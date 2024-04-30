Return-Path: <linux-kselftest+bounces-9107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E298B68C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 05:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E263B22F68
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 03:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A56010A1E;
	Tue, 30 Apr 2024 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmAVtwnf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5201179B2;
	Tue, 30 Apr 2024 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447895; cv=none; b=mBNSLc/DTj41Baf7V3e7QJaFAv5X6t7/O29OMW4TjyWZj98An1AK1Nn2SRQalW18QmNVW5yaQRhh79JvUfCYc64XIfMFBUFKNts2Qko+kEwTFkP20M8XXidabhJr+QyZYRJm1cFIwJCHCC6L4vggHc5Tgpl7Tuyx+NMvCz9bwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447895; c=relaxed/simple;
	bh=l3atzUkPqdTg5c89tRfCdE8NJod9oiE8nTavithueLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdYNiiU1HsUQro0f41FepTJkCC6V7O9adTfK+dyue1p9K3pv57dgXtLLxtu4ddNUBQGnhNE1x+s7UipCOMxzaf2i9GgEz8g1WQ2Hl3j2Z7SevlFMp/EmJ2pq2vioEAdxLGzi8wihB7LfQ04MHNcFbaLlQYlYbcF7eQkuohLVPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmAVtwnf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714447894; x=1745983894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3atzUkPqdTg5c89tRfCdE8NJod9oiE8nTavithueLM=;
  b=AmAVtwnfgR8n0K6acbKtT5a5bYX6u27qoOBl6mMWA4Qk8MCqBnpUz1+h
   xJ4AXrEmSYT08IrG86mrk0gDUjX/L15BJZM5Wp/3hWWFpLW43Grp3a+dw
   kH4ZyrAabDKwPG7rlL3lbA0PKQ4AknzYHJuzolVkfuLwmzkxuWOvtM/Ev
   RaESf0Y9djLdmdVd3T7hK5kd194KwiWH8XkP85Ua/oaDpjJZur1KFGDEb
   PHO6GP5j+b8nZ0NQtIXzWaJ/6hdg34EPdKia5PwS7VPS7h7qg7rcmhb86
   mNxkfLqzU+JvxdIvMPJARWCkSU0pv0j5yi1O+A8gzPapVG6COaFX5dtZv
   g==;
X-CSE-ConnectionGUID: o0TZsQ0gQSau7mHQ8PseNA==
X-CSE-MsgGUID: hlOAsXaQTHWXpemHOBUNxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21284187"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21284187"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:31:34 -0700
X-CSE-ConnectionGUID: CeJVoS+rSX+HmFhkmTR3Ww==
X-CSE-MsgGUID: fchqet6/Soi96GtiH+Uk3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26820008"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2024 20:31:31 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	shuah@kernel.org,
	linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	jithu.joseph@intel.com,
	Pengfei Xu <pengfei.xu@intel.com>,
	ashok.raj@intel.com,
	sathyanarayanan.kuppuswamy@intel.com
Subject: [PATCH v1 3/4] selftests: ifs: verify IFS scan test functionality
Date: Tue, 30 Apr 2024 11:31:47 +0800
Message-ID: <fa2609cfd75bb0a8359ce2a7d90c17567f5b7311.1714447026.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714447026.git.pengfei.xu@intel.com>
References: <cover.1714447026.git.pengfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two selftests are added to verify IFS scan test feature:

1. Perform IFS scan test once on each CPU using all the available image
   files.
2. Perform IFS scan test with the default image on a random cpu for 3
   rounds.

Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 .../platform/x86/intel/ifs/test_ifs.sh        | 190 +++++++++++++++++-
 1 file changed, 189 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
index 2a4df745bf6f..63d13400af4f 100755
--- a/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
+++ b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
@@ -10,16 +10,25 @@ readonly KSFT_FAIL=1
 readonly KSFT_XFAIL=2
 readonly KSFT_SKIP=4
 
+readonly CPU_SYSFS="/sys/devices/system/cpu"
+readonly CPU_OFFLINE_SYSFS="${CPU_SYSFS}/offline"
 readonly IMG_PATH="/lib/firmware/intel/ifs_0"
 readonly IFS_SCAN_MODE="0"
+readonly IFS_ARRAY_BIST_SCAN_MODE="1"
 readonly IFS_PATH="/sys/devices/virtual/misc/intel_ifs"
 readonly IFS_SCAN_SYSFS_PATH="${IFS_PATH}_${IFS_SCAN_MODE}"
+readonly RUN_TEST="run_test"
+readonly STATUS="status"
+readonly DETAILS="details"
+readonly STATUS_PASS="pass"
 readonly PASS="PASS"
 readonly FAIL="FAIL"
 readonly INFO="INFO"
 readonly XFAIL="XFAIL"
 readonly SKIP="SKIP"
 readonly IFS_NAME="intel_ifs"
+readonly ALL="all"
+readonly SIBLINGS="siblings"
 
 # Matches arch/x86/include/asm/intel-family.h and
 # drivers/platform/x86/intel/ifs/core.c requirement as follows
@@ -28,6 +37,7 @@ readonly EMERALDRAPIDS_X="cf"
 
 readonly INTEL_FAM6="06"
 
+LOOP_TIMES=3
 FML=""
 MODEL=""
 STEPPING=""
@@ -36,11 +46,13 @@ TRUE="true"
 FALSE="false"
 RESULT=$KSFT_PASS
 IMAGE_NAME=""
-export INTERVAL_TIME=1
+INTERVAL_TIME=1
+OFFLINE_CPUS=""
 # For IFS cleanup tags
 ORIGIN_IFS_LOADED=""
 IFS_IMAGE_NEED_RESTORE=$FALSE
 IFS_LOG="/tmp/ifs_logs.$$"
+RANDOM_CPU=""
 DEFAULT_IMG_ID=""
 
 append_log()
@@ -48,6 +60,35 @@ append_log()
 	echo -e "$1" | tee -a "$IFS_LOG"
 }
 
+online_offline_cpu_list()
+{
+	local on_off=$1
+	local target_cpus=$2
+	local cpu=""
+	local cpu_start=""
+	local cpu_end=""
+	local i=""
+
+	if [[ -n "$target_cpus" ]]; then
+		for cpu in $(echo "$target_cpus" | tr ',' ' '); do
+			if [[ "$cpu" == *"-"* ]]; then
+				cpu_start=""
+				cpu_end=""
+				i=""
+				cpu_start=$(echo "$cpu" | cut -d "-" -f 1)
+				cpu_end=$(echo "$cpu" | cut -d "-" -f 2)
+				for((i=cpu_start;i<=cpu_end;i++)); do
+					append_log "[$INFO] echo $on_off > \
+${CPU_SYSFS}/cpu${i}/online"
+					echo "$on_off" > "$CPU_SYSFS"/cpu"$i"/online
+				done
+			else
+				set_target_cpu "$on_off" "$cpu"
+			fi
+		done
+	fi
+}
+
 ifs_scan_result_summary()
 {
 	local failed_info pass_num skip_num fail_num
@@ -80,6 +121,9 @@ ifs_cleanup()
 		mv -f "$IMG_PATH"/"$IMAGE_NAME"_origin "$IMG_PATH"/"$IMAGE_NAME"
 	}
 
+	# Restore the CPUs to the state before testing
+	[[ -z "$OFFLINE_CPUS" ]] || online_offline_cpu_list "0" "$OFFLINE_CPUS"
+
 	lsmod | grep -q "$IFS_NAME" && [[ "$ORIGIN_IFS_LOADED" == "$FALSE" ]] && {
 		echo "[$INFO] modprobe -r $IFS_NAME"
 		modprobe -r "$IFS_NAME"
@@ -122,6 +166,23 @@ test_exit()
 	ifs_cleanup
 }
 
+online_all_cpus()
+{
+	local off_cpus=""
+
+	OFFLINE_CPUS=$(cat "$CPU_OFFLINE_SYSFS")
+	online_offline_cpu_list "1" "$OFFLINE_CPUS"
+
+	off_cpus=$(cat "$CPU_OFFLINE_SYSFS")
+	if [[ -z "$off_cpus" ]]; then
+		append_log "[$INFO] All CPUs are online."
+	else
+		append_log "[$XFAIL] There is offline cpu:$off_cpus after online all cpu!"
+		RESULT=$KSFT_XFAIL
+		ifs_cleanup
+	fi
+}
+
 get_cpu_fms()
 {
 	FML=$(grep -m 1 "family" /proc/cpuinfo | awk -F ":" '{printf "%02x",$2;}')
@@ -270,10 +331,135 @@ test_bad_and_origin_ifs_image()
 	append_log "[$INFO] Loading invalid IFS image and then loading initial image passed.\n"
 }
 
+ifs_test_cpu()
+{
+	local ifs_mode=$1
+	local cpu_num=$2
+	local image_id status details ret result result_info
+
+	echo "$cpu_num" > "$IFS_PATH"_"$ifs_mode"/"$RUN_TEST"
+	ret=$?
+
+	status=$(cat "${IFS_PATH}_${ifs_mode}/${STATUS}")
+	details=$(cat "${IFS_PATH}_${ifs_mode}/${DETAILS}")
+
+	if [[ "$ret" -eq 0 && "$status" == "$STATUS_PASS" ]]; then
+		result="$PASS"
+	else
+		result="$FAIL"
+	fi
+
+	cpu_num=$(cat "${CPU_SYSFS}/cpu${cpu_num}/topology/thread_siblings_list")
+
+	# There is no image file for IFS ARRAY BIST scan
+	if [[ -e "${IFS_PATH}_${ifs_mode}/current_batch" ]]; then
+		image_id=$(cat "${IFS_PATH}_${ifs_mode}/current_batch")
+		result_info=$(printf "[%s] ifs_%1d cpu(s):%s, current_batch:0x%02x, \
+ret:%2d, status:%s, details:0x%016x" \
+			     "$result" "$ifs_mode" "$cpu_num" "$image_id" "$ret" \
+			     "$status" "$details")
+	else
+		result_info=$(printf "[%s] ifs_%1d cpu(s):%s, ret:%2d, status:%s, details:0x%016x" \
+			     "$result" "$ifs_mode" "$cpu_num" "$ret" "$status" "$details")
+	fi
+
+	append_log "$result_info"
+}
+
+ifs_test_cpus()
+{
+	local cpus_type=$1
+	local ifs_mode=$2
+	local image_id=$3
+	local cpu_max_num=""
+	local cpu_num=""
+
+	case "$cpus_type" in
+		"$ALL")
+			cpu_max_num=$(($(nproc) - 1))
+			cpus=$(seq 0 $cpu_max_num)
+			;;
+		"$SIBLINGS")
+			cpus=$(cat ${CPU_SYSFS}/cpu*/topology/thread_siblings_list \
+				| sed -e 's/,.*//' \
+				| sed -e 's/-.*//' \
+				| sort -n \
+				| uniq)
+			;;
+		*)
+			test_exit "Invalid cpus_type:$cpus_type" "$KSFT_XFAIL"
+			;;
+	esac
+
+	for cpu_num in $cpus; do
+		ifs_test_cpu "$ifs_mode" "$cpu_num"
+	done
+
+	if [[ -z "$image_id" ]]; then
+		append_log "[$INFO] ifs_$ifs_mode test $cpus_type cpus completed\n"
+	else
+		append_log "[$INFO] ifs_$ifs_mode $cpus_type cpus with $CPU_FMS-$image_id.scan \
+completed\n"
+	fi
+}
+
+test_ifs_same_cpu_loop()
+{
+	local ifs_mode=$1
+	local cpu_num=$2
+	local loop_times=$3
+
+	append_log "[$INFO] Test ifs mode $ifs_mode on CPU:$cpu_num for $loop_times rounds:"
+	[[ "$ifs_mode" == "$IFS_SCAN_MODE" ]] && {
+		load_image "$DEFAULT_IMG_ID" ||	return $?
+	}
+	for (( i=1; i<=loop_times; i++ )); do
+		append_log "[$INFO] Loop iteration: $i in total of $loop_times"
+		# Only IFS scan needs the interval time
+		if [[ "$ifs_mode" == "$IFS_SCAN_MODE" ]]; then
+			do_cmd "sleep $INTERVAL_TIME"
+		elif [[ "$ifs_mode" == "$IFS_ARRAY_BIST_SCAN_MODE" ]]; then
+			true
+		else
+			test_exit "Invalid ifs_mode:$ifs_mode" "$KSFT_XFAIL"
+		fi
+
+		ifs_test_cpu "$ifs_mode" "$cpu_num"
+	done
+	append_log "[$INFO] $loop_times rounds of ifs_$ifs_mode test on CPU:$cpu_num completed.\n"
+}
+
+test_ifs_scan_available_imgs()
+{
+	local image_ids=""
+	local image_id=""
+
+	append_log "[$INFO] Test ifs scan with available images:"
+	image_ids=$(find "$IMG_PATH" -maxdepth 1 -name "${CPU_FMS}-[0-9a-fA-F][0-9a-fA-F].scan" \
+		    2>/dev/null \
+		    | sort \
+		    | awk -F "-" '{print $NF}' \
+		    | cut -d "." -f 1)
+
+	for image_id in $image_ids; do
+		load_image "$image_id" || return $?
+
+		ifs_test_cpus "$SIBLINGS" "$IFS_SCAN_MODE" "$image_id"
+		# IFS scan requires time interval for the scan on the same CPU
+		do_cmd "sleep $INTERVAL_TIME"
+	done
+}
+
 prepare_ifs_test_env()
 {
+	local max_cpu=""
+
 	check_cpu_ifs_support_interval_time
 
+	online_all_cpus
+	max_cpu=$(($(nproc) - 1))
+	RANDOM_CPU=$(shuf -i 0-$max_cpu -n 1)
+
 	DEFAULT_IMG_ID=$(find $IMG_PATH -maxdepth 1 -name "${CPU_FMS}-[0-9a-fA-F][0-9a-fA-F].scan" \
 			 2>/dev/null \
 			 | sort \
@@ -292,6 +478,8 @@ test_ifs()
 		append_log "[$SKIP] No proper ${IMG_PATH}/${CPU_FMS}-*.scan, skip ifs_0 scan"
 	else
 		test_bad_and_origin_ifs_image "$DEFAULT_IMG_ID"
+		test_ifs_scan_available_imgs
+		test_ifs_same_cpu_loop "$IFS_SCAN_MODE" "$RANDOM_CPU" "$LOOP_TIMES"
 	fi
 }
 
-- 
2.43.0


