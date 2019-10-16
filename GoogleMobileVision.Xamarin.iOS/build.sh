# /bash/sh

# Set bash script to exit immediately if any commands fail.
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

( cd $DIR && pod install )

OBJROOT=${DIR}/build
SYMROOT=${DIR}/build
GENERATED_FRAMEWORKS_PATH=${DIR}/GeneratedFrameworks/Fat

xcodebuild \
-workspace ${DIR}/GoogleMobileVision.Xamarin.xcworkspace \
-scheme GoogleMobileVision.Xamarin \
-configuration Release \
-sdk iphoneos \
OBJROOT=${OBJROOT} \
SYMROOT=${OBJROOT}

xcodebuild \
-workspace ${DIR}/GoogleMobileVision.Xamarin.xcworkspace \
-scheme GoogleMobileVision.Xamarin \
-configuration Release \
-sdk iphonesimulator \
OBJROOT=${OBJROOT} \
SYMROOT=${OBJROOT}
# xcodebuild -workspace GoogleMobileVision.Xamarin.xcworkspace -scheme GoogleMobileVision.Xamarin -configuration Release -sdk iphonesimulator

function make_fat_library {
    # Will smash 2 static libs together
    #     make_fat_library in1 in2 out
    xcrun lipo -create "${1}" "${2}" -output "${3}"
}

rm -rf ${GENERATED_FRAMEWORKS_PATH}
mkdir -p ${GENERATED_FRAMEWORKS_PATH}

declare -a arr=("GoogleMobileVision_Xamarin.framework" "GoogleToolboxForMac/GoogleToolboxForMac.framework" "GTMSessionFetcher/GTMSessionFetcher.framework" "Protobuf/Protobuf.framework")

for i in "${arr[@]}"
do
    basename=$(basename "${i%.*}")
    fullFrameworkName=$(basename $i)
    frameworkName=`echo "${fullFrameworkName}" | cut -d'.' -f1`
    iphoneFramework="${OBJROOT}/Release-iphoneos/${i}"
    simulatorFramework="${OBJROOT}/Release-iphonesimulator/${i}"
    fatFrameworkPath=$GENERATED_FRAMEWORKS_PATH/

    cp -R ${iphoneFramework} ${fatFrameworkPath}/

    make_fat_library \
        "${iphoneFramework}/${frameworkName}" \
        "${simulatorFramework}/${frameworkName}" \
        "${fatFrameworkPath}${fullFrameworkName}/${frameworkName}"
done
