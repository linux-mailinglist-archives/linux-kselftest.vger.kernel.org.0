Return-Path: <linux-kselftest+bounces-10986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F108D5C17
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 09:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8607DB22235
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21059770E5;
	Fri, 31 May 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGq+0A22"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F7768FC;
	Fri, 31 May 2024 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142014; cv=none; b=iv3S3CXP3okuk3SJt3liqj0byUAv9/tlx55U25bYz1aqQVRI+/PGtmYU6K0echynIWS7rJXRmaSBm5SCfK9Rp3dxEYxIx42/BQv79XRUiIkkxycXuSXk5Z2jfNJPVPvP50MsSXeKl6C1XCVBWaN3whKonsCA85V1hbRYJ5P70Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142014; c=relaxed/simple;
	bh=9gVNS2Pwfv+HFbhDMKB8k7WfIGQgFpiCBG6w7wDCcgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utGHY2NknX84lv2QszEfCvJAN3BqN0Cb/oJH+arZOj/+h83ePItwmpiy/DOaFnTxW8prv8zro8/0pItzRA2Ow+VW4bsYQUcJRFnce/r4QIHtb3WAG4VRbdSoQ74kv4fg6qmy3IkwEO5q1lT7wGIYFD6tSo2TVlsSdajKwND9FOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGq+0A22; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717142014; x=1748678014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9gVNS2Pwfv+HFbhDMKB8k7WfIGQgFpiCBG6w7wDCcgM=;
  b=XGq+0A221vCn/YwBgiES9GEhdm4exPy5ou3dbB8tcUzOEUu0Osoc0lCj
   z0dYMP1gGZwwCqGuvPRhxfMCaAAxlgZxa5VFVdzUR7gEeCBSCPfGZx8JB
   /XKa5J8xFV4aGHHWQgNzcdrwX9ykDthDRYxwhWAZSTjBepHqlxq0pCpGp
   8nadvlgjh/cApJmpVmFfyCaENTe2UFa/CwxFl6X65hrjUUJg5t6bCzsDe
   vt3slzoovvBSIGu/a4xoV3pSIfHiFn5Uue8nlHx2FT43jwyh5y+1JU4Gs
   Iv9wmqe/w5XEUf5fd4LFOJ2IgNHHMGVpQV/s3z7/+OswiYLoQqzuwwvzI
   w==;
X-CSE-ConnectionGUID: K3AQHdCvQyC/OiwwgvcMPA==
X-CSE-MsgGUID: FuhLf9hNQyqnx7axFNZFjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24336929"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="24336929"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 00:53:33 -0700
X-CSE-ConnectionGUID: 4xq6jLO0TU2ktd3zoNK0vw==
X-CSE-MsgGUID: yx/WjMKpTpy/8Rr3jk80oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36081094"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by fmviesa008.fm.intel.com with ESMTP; 31 May 2024 00:53:30 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	shuah@kernel.org,
	linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	jithu.joseph@intel.com,
	Pengfei Xu <pengfei.xu@intel.com>,
	ashok.raj@intel.com,
	sathyanarayanan.kuppuswamy@intel.com
Subject: [PATCH v2 2/4] selftests: ifs: verify test image loading functionality
Date: Fri, 31 May 2024 15:53:48 +0800
Message-ID: <6f5d01874c3b90a453030d195f9fc0c198b95015.1717137348.git.pengfei.xu@intel.com>
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

Scan test image files have to be loaded before starting IFS test.

Verify that In Field scan driver is able to load valid test image files.

Also check if loading an invalid test image file fails.

Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Co-developed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 .../platform/x86/intel/ifs/test_ifs.sh        | 121 +++++++++++++++++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
index 90d099578199..dc78ad9100ca 100755
--- a/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
+++ b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
@@ -10,6 +10,7 @@ readonly KSFT_FAIL=1
 readonly KSFT_XFAIL=2
 readonly KSFT_SKIP=4
 
+readonly IMG_PATH="/lib/firmware/intel/ifs_0"
 readonly IFS_SCAN_MODE="0"
 readonly IFS_PATH="/sys/devices/virtual/misc/intel_ifs"
 readonly IFS_SCAN_SYSFS_PATH="${IFS_PATH}_${IFS_SCAN_MODE}"
@@ -29,14 +30,18 @@ readonly INTEL_FAM6="06"
 
 FML=""
 MODEL=""
-
+STEPPING=""
+CPU_FMS=""
 TRUE="true"
 FALSE="false"
 RESULT=$KSFT_PASS
+IMAGE_NAME=""
 export INTERVAL_TIME=1
 # For IFS cleanup tags
 ORIGIN_IFS_LOADED=""
+IFS_IMAGE_NEED_RESTORE=$FALSE
 IFS_LOG="/tmp/ifs_logs.$$"
+DEFAULT_IMG_ID=""
 
 append_log()
 {
@@ -68,6 +73,13 @@ ifs_scan_result_summary()
 
 ifs_cleanup()
 {
+	echo "[$INFO] Restore environment after IFS test"
+
+	# Restore ifs origin image if origin image backup step is needed
+	[[ "$IFS_IMAGE_NEED_RESTORE" == "$TRUE" ]] && {
+		mv -f "$IMG_PATH"/"$IMAGE_NAME"_origin "$IMG_PATH"/"$IMAGE_NAME"
+	}
+
 	lsmod | grep -q "$IFS_NAME" && [[ "$ORIGIN_IFS_LOADED" == "$FALSE" ]] && {
 		echo "[$INFO] modprobe -r $IFS_NAME"
 		modprobe -r "$IFS_NAME"
@@ -80,6 +92,21 @@ ifs_cleanup()
 	exit "$RESULT"
 }
 
+do_cmd()
+{
+	local cmd=$*
+	local ret=""
+
+	append_log "[$INFO] $cmd"
+	eval "$cmd"
+	ret=$?
+	if [[ $ret -ne 0 ]]; then
+		append_log "[$FAIL] $cmd failed. Return code is $ret"
+		RESULT=$KSFT_XFAIL
+		ifs_cleanup
+	fi
+}
+
 test_exit()
 {
 	local info=$1
@@ -99,6 +126,8 @@ get_cpu_fms()
 {
 	FML=$(grep -m 1 "family" /proc/cpuinfo | awk -F ":" '{printf "%02x",$2;}')
 	MODEL=$(grep -m 1 "model" /proc/cpuinfo | awk -F ":" '{printf "%02x",$2;}')
+	STEPPING=$(grep -m 1 "stepping" /proc/cpuinfo | awk -F ":" '{printf "%02x",$2;}')
+	CPU_FMS="${FML}-${MODEL}-${STEPPING}"
 }
 
 check_cpu_ifs_support_interval_time()
@@ -162,9 +191,93 @@ test_ifs_scan_entry()
 	fi
 }
 
+load_image()
+{
+	local image_id=$1
+	local image_info=""
+	local ret=""
+
+	check_ifs_loaded
+	if [[ -e "${IMG_PATH}/${IMAGE_NAME}" ]]; then
+		append_log "[$INFO] echo 0x$image_id > ${IFS_SCAN_SYSFS_PATH}/current_batch"
+		echo "0x$image_id" > "$IFS_SCAN_SYSFS_PATH"/current_batch 2>/dev/null
+		ret=$?
+		[[ "$ret" -eq 0 ]] || {
+			append_log "[$FAIL] Load ifs image $image_id failed with ret:$ret\n"
+			return "$ret"
+		}
+		image_info=$(cat ${IFS_SCAN_SYSFS_PATH}/current_batch)
+		if [[ "$image_info" == 0x"$image_id" ]]; then
+			append_log "[$PASS] load IFS current_batch:$image_info"
+		else
+			append_log "[$FAIL] current_batch:$image_info is not expected:$image_id"
+			return "$KSFT_FAIL"
+		fi
+	else
+		append_log "[$FAIL] No IFS image file ${IMG_PATH}/${IMAGE_NAME}"\
+		return "$KSFT_FAIL"
+	fi
+	return 0
+}
+
+test_load_origin_ifs_image()
+{
+	local image_id=$1
+
+	IMAGE_NAME="${CPU_FMS}-${image_id}.scan"
+
+	load_image "$image_id" || return $?
+	return 0
+}
+
+test_load_bad_ifs_image()
+{
+	local image_id=$1
+
+	IMAGE_NAME="${CPU_FMS}-${image_id}.scan"
+
+	do_cmd "mv -f ${IMG_PATH}/${IMAGE_NAME} ${IMG_PATH}/${IMAGE_NAME}_origin"
+
+	# Set IFS_IMAGE_NEED_RESTORE to true before corrupt the origin ifs image file
+	IFS_IMAGE_NEED_RESTORE=$TRUE
+	do_cmd "dd if=/dev/urandom of=${IMG_PATH}/${IMAGE_NAME} bs=1K count=6 2>/dev/null"
+
+	# Use the specified judgment for negative testing
+	append_log "[$INFO] echo 0x$image_id > ${IFS_SCAN_SYSFS_PATH}/current_batch"
+	echo "0x$image_id" > "$IFS_SCAN_SYSFS_PATH"/current_batch 2>/dev/null
+	ret=$?
+	if [[ "$ret" -ne 0 ]]; then
+		append_log "[$PASS] Load invalid ifs image failed with ret:$ret not 0 as expected"
+	else
+		append_log "[$FAIL] Load invalid ifs image ret:$ret unexpectedly"
+	fi
+
+	do_cmd "mv -f ${IMG_PATH}/${IMAGE_NAME}_origin ${IMG_PATH}/${IMAGE_NAME}"
+	IFS_IMAGE_NEED_RESTORE=$FALSE
+}
+
+test_bad_and_origin_ifs_image()
+{
+	local image_id=$1
+
+	append_log "[$INFO] Test loading bad and then loading original IFS image:"
+	test_load_origin_ifs_image "$image_id" || return $?
+	test_load_bad_ifs_image "$image_id"
+	# Load origin image again and make sure it's worked
+	test_load_origin_ifs_image "$image_id" || return $?
+	append_log "[$INFO] Loading invalid IFS image and then loading initial image passed.\n"
+}
+
 prepare_ifs_test_env()
 {
 	check_cpu_ifs_support_interval_time
+
+	DEFAULT_IMG_ID=$(find $IMG_PATH -maxdepth 1 -name "${CPU_FMS}-[0-9a-fA-F][0-9a-fA-F].scan" \
+			 2>/dev/null \
+			 | sort \
+			 | head -n 1 \
+			 | awk -F "-" '{print $NF}' \
+			 | cut -d "." -f 1)
 }
 
 test_ifs()
@@ -172,6 +285,12 @@ test_ifs()
 	prepare_ifs_test_env
 
 	test_ifs_scan_entry
+
+	if [[ -z "$DEFAULT_IMG_ID" ]]; then
+		append_log "[$SKIP] No proper ${IMG_PATH}/${CPU_FMS}-*.scan, skip ifs_0 scan"
+	else
+		test_bad_and_origin_ifs_image "$DEFAULT_IMG_ID"
+	fi
 }
 
 trap ifs_cleanup SIGTERM SIGINT
-- 
2.43.0


