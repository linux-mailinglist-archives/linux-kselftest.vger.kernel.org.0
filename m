Return-Path: <linux-kselftest+bounces-10988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F8E8D5C1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 09:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49361C2130B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 07:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335A78269;
	Fri, 31 May 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzQcmZzX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55557770EE;
	Fri, 31 May 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142016; cv=none; b=FM4Hyis1BElLk/x50IM054INcoIxcRWkWX2qzcSHLjq+H92ivgSednkBvqhRXU5pzwUimSYv3AEPPzkCGrldiHc/Kq+3HKIgZFjaQeydEw8A+oz2HBj4D/CQ4bvMF46pjIo2T2BQ1F9JoqzCRQ6MSQfHKvOj6eAizxHbFMSbVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142016; c=relaxed/simple;
	bh=PYEz/Sr4ltxvLj/akiWm754vTsgjoEK0PRP5FRtaalQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7tOWZ55lyKEjYp/ZI12IoQP4POkXMN9xvj6AJFfYr8inx4L+a59LlKPNNoXS44bpDziDi0nyDn2xNKX7DGV3TnVSv9m8iKCxajmM01MbjuJbuxqq9CGPBxJs0oREkXleIHSA1B0aP4JOKwlU6TqxgjcXz/runSnC2jITwyhpuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzQcmZzX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717142016; x=1748678016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PYEz/Sr4ltxvLj/akiWm754vTsgjoEK0PRP5FRtaalQ=;
  b=TzQcmZzXX5jcZzmROao3lLOe2hGCeAm0a9slbxPbIU5bHQQZuMItx54J
   P2GDQoqi6++JbRVTy/LwgbcFaQ7qwV5Y+fs4YfvHQ5VWMdAOZavIC7KEV
   7XueSDLhmeAOPVel3YbgTR/5Td+9FJZAfLx2TYjzSjDK0u9U75Ca/E5ZK
   g9Sla4IxtmYg70Mr00zDm2IvBaqDaSPlHFBvy6ZDEFn1FYXqVbGt4HRsu
   fHRqNJQLurVVcdelrfGn+fs0pE8qtvZhv5RZPY+dCzOMK/QWaGOip8eg8
   TlyqbHJBlpQ6gRz/qIfsCMM9weAMIweZkxgM+ih+kEcA14g9pBH1w0bdE
   g==;
X-CSE-ConnectionGUID: bNA0ndKSQTWEUHp0MjkWvQ==
X-CSE-MsgGUID: aaD42iBITJyV8/IlNYstNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24336936"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="24336936"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 00:53:35 -0700
X-CSE-ConnectionGUID: MiS9bPl8T4Kpaqfbid4rOA==
X-CSE-MsgGUID: k1awD5Y2SSCpI+yzQuP0Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36081100"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by fmviesa008.fm.intel.com with ESMTP; 31 May 2024 00:53:32 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	shuah@kernel.org,
	linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	jithu.joseph@intel.com,
	Pengfei Xu <pengfei.xu@intel.com>,
	ashok.raj@intel.com,
	sathyanarayanan.kuppuswamy@intel.com
Subject: [PATCH v2 3/4] selftests: ifs: verify IFS scan test functionality
Date: Fri, 31 May 2024 15:53:49 +0800
Message-ID: <1681a84049c8c80c8cb3fe6e4d6d60177d3c0ea1.1717137348.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1717137348.git.pengfei.xu@intel.com>
References: <cover.1717137348.git.pengfei.xu@intel.com>
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
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Co-developed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 .../platform/x86/intel/ifs/test_ifs.sh        | 190 +++++++++++++++++-
 1 file changed, 189 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
index dc78ad9100ca..82fc5a461b12 100755
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
@@ -268,10 +329,135 @@ test_bad_and_origin_ifs_image()
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
@@ -290,6 +476,8 @@ test_ifs()
 		append_log "[$SKIP] No proper ${IMG_PATH}/${CPU_FMS}-*.scan, skip ifs_0 scan"
 	else
 		test_bad_and_origin_ifs_image "$DEFAULT_IMG_ID"
+		test_ifs_scan_available_imgs
+		test_ifs_same_cpu_loop "$IFS_SCAN_MODE" "$RANDOM_CPU" "$LOOP_TIMES"
 	fi
 }
 
-- 
2.43.0


