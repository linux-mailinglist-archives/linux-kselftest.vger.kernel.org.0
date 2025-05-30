Return-Path: <linux-kselftest+bounces-34059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 957CEAC9047
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 15:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF6189C4E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B299016132F;
	Fri, 30 May 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="NweBX4q9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7AF1547D2;
	Fri, 30 May 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611997; cv=none; b=hCeEpNiwQyyR1S9jH9+sXb9d2mW3c4jktfxpVH/n0wmrobN8S2H5ctxkfZFj+jvqeSrkQcF3t1gy6y1HyPYG8bIx/WW8o2XhwsOOTyojdhUoDMkgsuC5HHQuRaAGN7J1siwfFWQ5GZ1I6UYNTOzUmNE2FBx2vZR+SNU07HIobAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611997; c=relaxed/simple;
	bh=4w22kZ52negMUTuIli5dR16SY+t1/SlhL095ZunFByM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvcKWYbxTwDxnPnmMRTD5xlnHB6k2Z9RuAbm6LTRzTtr3X8wz/7pnVOGIDmMph0ze+NQMVNEVJURONnL3A180VZb8aPXzP+1ci5ytchaydB3QV3JkIjTrYM3GFfIcYkTxtrMopztuu537RgtngD1Fzb7UtnrTMR6nTFqSq7tP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=NweBX4q9; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UCLQEJ002202;
	Fri, 30 May 2025 12:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=default; bh=Wz
	t3C1uyCswPs1cKeQlufIRtqHdv3juNPPqO3gwQN9g=; b=NweBX4q9U8U+Xwn+TB
	dxkaC5s7rVhsmhpnkXk+AIyZ6BfIcPhOpTE/t4n6bU08npF4lSl7Td0psX416x1v
	mgN2EzP3rTcIbXkvdHsppxHZOTelclkYxCgTDJJ7+rkYxBNn3kIPgdKag+F0aUHf
	7Wvk3bqcGKEa/c/+1vGgn2EB89ngJ4gA/VVf6QdpotqwL4nsfnHyLCOp5basQ9R+
	Eh3oE/mRPaNp004RVBsH3RSBoR8kcYazvDlPgY9eveO40yK+JS6JaeeB5iOFJ4LR
	qOPtoEPY92fy/CT59rU2OTi599VJRNrE2RZXSBYYThEfk0ZPQB8VjcBoAkSZ42Vs
	Yd8Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 46uux3kfr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 12:58:07 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 30 May 2025 12:58:02 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <qmo@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
        <song@kernel.org>, <yonghong.song@linux.dev>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <slava.imameev@crowdstrike.com>,
        <justin.deschamp@crowdstrike.com>, <mark.fontana@crowdstrike.com>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for bpftool access to read-only protected maps
Date: Fri, 30 May 2025 22:57:17 +1000
Message-ID: <20250530125717.34746-2-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250530125717.34746-1-slava.imameev@crowdstrike.com>
References: <20250530125717.34746-1-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH009.crowdstrike.sys (10.100.11.79) To
 04WPEXCH007.crowdstrike.sys (10.100.11.74)
X-Disclaimer: USA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_05,2025-05-30_01,2025-03-28_01

Add selftest cases that validate bpftool's expected behavior when
accessing maps protected from modification via security_bpf_map.

The test includes a BPF program attached to security_bpf_map with two maps:
- A protected map that only allows read-only access
- An unprotected map that allows full access

The test script attaches the BPF program to security_bpf_map and
verifies that for the bpftool map command:
- Read access works on both maps
- Write access fails on the protected map
- Write access succeeds on the unprotected map
- These behaviors remain consistent when the maps are pinned

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
---
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/progs/security_bpf_map.c    |  56 +++++
 .../testing/selftests/bpf/test_bpftool_map.sh | 208 ++++++++++++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/security_bpf_map.c
 create mode 100755 tools/testing/selftests/bpf/test_bpftool_map.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index cf5ed3bee573..731a86407799 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -109,6 +109,7 @@ TEST_PROGS := test_kmod.sh \
 	test_xdping.sh \
 	test_bpftool_build.sh \
 	test_bpftool.sh \
+	test_bpftool_map.sh \
 	test_bpftool_metadata.sh \
 	test_doc_build.sh \
 	test_xsk.sh \
diff --git a/tools/testing/selftests/bpf/progs/security_bpf_map.c b/tools/testing/selftests/bpf/progs/security_bpf_map.c
new file mode 100644
index 000000000000..57226f2ceb5f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/security_bpf_map.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define EPERM 1 /* Operation not permitted */
+
+/* From include/linux/mm.h. */
+#define FMODE_WRITE	0x2
+
+struct map;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 1);
+} prot_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 1);
+} not_prot_map SEC(".maps");
+
+SEC("fmod_ret/security_bpf_map")
+int BPF_PROG(fmod_bpf_map, struct bpf_map *map, int fmode)
+{
+	if (map == &prot_map) {
+		/* Allow read-only access */
+		if (fmode & FMODE_WRITE)
+			return -EPERM;
+	}
+
+	return 0;
+}
+
+/*
+ * This program keeps references to maps. This is needed to prevent
+ * optimizing them out.
+ */
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(bpf_fentry_test1, int a)
+{
+	__u32 key = 0;
+	__u32 val1 = a;
+	__u32 val2 = a + 1;
+
+	bpf_map_update_elem(&prot_map, &key, &val1, BPF_ANY);
+	bpf_map_update_elem(&not_prot_map, &key, &val2, BPF_ANY);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_bpftool_map.sh b/tools/testing/selftests/bpf/test_bpftool_map.sh
new file mode 100755
index 000000000000..c7c7f3d2071e
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_bpftool_map.sh
@@ -0,0 +1,208 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+PROTECTED_MAP_NAME="prot_map"
+NOT_PROTECTED_MAP_NAME="not_prot_map"
+BPF_FILE="security_bpf_map.bpf.o"
+TESTNAME="security_bpf_map"
+BPF_FS=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
+BPF_DIR="$BPF_FS/test_$TESTNAME"
+SCRIPT_DIR=$(dirname $(realpath "$0"))
+BPF_FILE_PATH="$SCRIPT_DIR/$BPF_FILE"
+# Assume the script is located under tools/testing/selftests/bpf/
+KDIR_ROOT_DIR=$(realpath "$SCRIPT_DIR"/../../../../)
+
+_cleanup()
+{
+	set +eu
+	[ -d "$TMPDIR" ] && rm -rf "$TMPDIR" 2> /dev/null
+	[ -d "$BPF_DIR" ] && rm -rf "$BPF_DIR" 2> /dev/null
+}
+
+cleanup_skip()
+{
+	echo "selftests: $TESTNAME [SKIP]"
+	_cleanup
+
+	exit $ksft_skip
+}
+
+cleanup()
+{
+	if [ "$?" = 0 ]; then
+		echo "selftests: $TESTNAME [PASS]"
+	else
+		echo "selftests: $TESTNAME [FAILED]"
+	fi
+	_cleanup
+}
+
+# Parameters:
+#   $1: The top of kernel repository
+#   $2: Output directory
+build_bpftool()
+{
+	local kdir_root_dir="$1"
+	local output_dir="$2"
+	local pwd="$(pwd)"
+	local ncpus=1
+
+	echo Building bpftool ...
+
+	#We want to start build from the top of kernel repository.
+	cd "$kdir_root_dir"
+	if [ ! -e tools/bpf/bpftool/Makefile ]; then
+		echo bpftool files not found
+		exit $ksft_skip
+	fi
+
+	# Determine the number of CPUs for parallel compilation
+	if command -v nproc >/dev/null 2>&1; then
+		ncpus=$(nproc)
+	fi
+
+	make -C tools/bpf/bpftool -s -j"$ncpus" OUTPUT="$output_dir"/ >/dev/null
+	echo ... finished building bpftool
+	cd "$pwd"
+}
+
+# Function to test map access with configurable write expectations
+# Parameters:
+#   $1: Map name
+#   $2: Whether write should succeed (true/false)
+#   $3: bpftool path
+#   $4: BPF_DIR
+test_map_access() {
+	local map_name="$1"
+	local write_should_succeed="$2"
+	local bpftool_path="$3"
+	local pin_path="$4/${map_name}_pinned"
+	local key="0 0 0 0"
+	local value="1 1 1 1"
+
+	echo "Testing access to map: $map_name"
+
+	# Test read access to the map
+	if "$bpftool_path" map lookup name "$map_name" key $key; then
+		echo "  Read access to $map_name succeeded"
+	else
+		echo "  Read access to $map_name failed"
+		exit 1
+	fi
+
+	# Test write access to the map
+	if "$bpftool_path" map update name "$map_name" key $key value $value; then
+		if [ "$write_should_succeed" = "true" ]; then
+			echo "  Write access to $map_name succeeded as expected"
+		else
+			echo "  Write access to $map_name succeeded but should have failed"
+			exit 1
+		fi
+	else
+		if [ "$write_should_succeed" = "true" ]; then
+			echo "  Write access to $map_name failed but should have succeeded"
+			exit 1
+		else
+			echo "  Write access to $map_name failed as expected"
+		fi
+	fi
+
+	# Pin the map to the BPF filesystem
+	"$bpftool_path" map pin name "$map_name" "$pin_path"
+	if [ -e "$pin_path" ]; then
+		echo "  Successfully pinned $map_name to $pin_path"
+	else
+		echo "  Failed to pin $map_name"
+		exit 1
+	fi
+
+	# Test read access to the pinned map
+	if "$bpftool_path" map lookup pinned "$pin_path" key $key; then
+		echo "  Read access to pinned $map_name succeeded"
+	else
+		echo "  Read access to pinned $map_name failed"
+		exit 1
+	fi
+
+	# Test write access to the pinned map
+	if "$bpftool_path" map update pinned "$pin_path" key $key value $value; then
+		if [ "$write_should_succeed" = "true" ]; then
+			echo "  Write access to pinned $map_name succeeded as expected"
+		else
+			echo "  Write access to pinned $map_name succeeded but should have failed"
+			exit 1
+		fi
+	else
+		if [ "$write_should_succeed" = "true" ]; then
+			echo "  Write access to pinned $map_name failed but should have succeeded"
+			exit 1
+		else
+			echo "  Write access to pinned $map_name failed as expected"
+		fi
+	fi
+
+	echo "  Finished testing $map_name"
+	echo
+}
+
+check_root_privileges() {
+	if [ $(id -u) -ne 0 ]; then
+		echo "Need root privileges"
+		exit $ksft_skip
+	fi
+}
+
+check_bpffs() {
+	if [ -z "$BPF_FS" ]; then
+		echo "Could not run test without bpffs mounted"
+		exit $ksft_skip
+	fi
+}
+
+create_tmp_dir() {
+	TMPDIR=$(mktemp -d)
+	if [ $? -ne 0 ] || [ ! -d "$TMPDIR" ]; then
+		echo "Failed to create temporary directory"
+		exit $ksft_skip
+	fi
+}
+
+locate_or_build_bpftool() {
+	if ! bpftool version > /dev/null 2>&1; then
+		build_bpftool "$KDIR_ROOT_DIR" "$TMPDIR"
+		BPFTOOL_PATH="$TMPDIR"/bpftool
+	else
+		echo "Using bpftool from PATH"
+		BPFTOOL_PATH="bpftool"
+	fi
+}
+
+set -eu
+
+trap cleanup_skip EXIT
+
+check_root_privileges
+
+check_bpffs
+
+create_tmp_dir
+
+locate_or_build_bpftool
+
+mkdir "$BPF_DIR"
+
+trap cleanup EXIT
+
+# Load and attach the BPF programs to control maps access
+"$BPFTOOL_PATH" prog loadall "$BPF_FILE_PATH" "$BPF_DIR"/prog autoattach
+
+# Test protected map (write should fail)
+test_map_access "$PROTECTED_MAP_NAME" "false" "$BPFTOOL_PATH" "$BPF_DIR"
+
+# Test not protected map (write should succeed)
+test_map_access "$NOT_PROTECTED_MAP_NAME" "true" "$BPFTOOL_PATH" "$BPF_DIR"
+
+exit 0
-- 
2.34.1


