#
# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file is executed by build/envsetup.sh, and can use anything
# defined in envsetup.sh.
#
# In particular, you can add lunch options with the add_lunch_combo
# function: add_lunch_combo generic-eng
export USE_CCACHE=1
add_lunch_combo cm_adam-userdebug
echo ""
echo "Patching Adam Workspace..."
echo ""
for p in $(find device/notionink/adam/patches/ -name "*.diff") 
	do 
		tmp=$(basename $p | awk -F"." '{print $1}')
		if [ -f $tmp".p" ]; then
			echo "Patch "$tmp" already applied"
		else
			echo -n "Apply patch "$tmp
			patch -p1 < $p > /dev/null 2>&1
			if [ $? == 0 ]; then
				echo "     [DONE]"
				touch $tmp".p"
			else
				echo "     [FAIL]"
			fi
		fi
		echo "" 
	done
echo "Cleaning .orig and .rej files if any..."
find . \( -name \*cpp.orig -o -name \*xml.orig -o -name \*.h.orig -o -name \*.java.orig -o -name \*.rej \) -delete
echo ""
