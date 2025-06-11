Return-Path: <linux-kselftest+bounces-34775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B949AD6250
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 00:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2255F17EDE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 22:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCE324887E;
	Wed, 11 Jun 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="zKAoErdO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3022B17E;
	Wed, 11 Jun 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680380; cv=none; b=N9eo0RRKzJYheHi08xS/vWL9K4fmShIb9O4CwM64pC+T9sPJtVDHi6er+dmDg1JJNlkZm6SHOfWWS4GiTH0SPOS7FZG3F8BSz48fYoSqusszTERlx/3BYbg6aE7y2cfZpkvN9QqsrM8y1jpthrVWM7uocILrO7RzQqzyKZMXKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680380; c=relaxed/simple;
	bh=fqDQLy+dXDj/b+10ItRY16Qcy7wpEc73ujoDUkfupw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIYMfyx3rcdLfvxhXR3/qNmbqrGghjEjRY3kbFrcCxnZ39Au1Afi98DWhFr1T6RFho+lB80f7LzNuh0ay15jlTjl86b5MYVF3IQt1s6E/BCZaB5LKoQfpXUBGkkO2wL+crmAiHwawYheWqDmDNHefedi8UyCybqvAOvsMYm/J+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=zKAoErdO; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BK44AW018984;
	Wed, 11 Jun 2025 22:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=UGWsH7uzFxvY45mWmXqZhqGzbZh72VvP8BOamH4Stt8=; b=zKAo
	ErdOuY4dhTV7Eys0Q8TTLoUyGxPZRXwIZAq7uuY1x/ucJNMzia5mY0ZsLdIHJT3G
	e++qwzPqQs44a8UM4mggLgnaHZJot/13IM77yk1UmeWn0Tw2DINVkaWQPyYcrHhf
	ZjjCEaEg/zQKhU3EqdRBnr+W52I8H4Q4vyla1IxrIwnvSuzE3zGcjQ2Niz7Hz5qr
	+O44ogaguFouLwdJr97PrJKfuq09fU/lwGYoFUwZsyThucEFrIyzszYafThsRQVb
	P43xRzz2Pqmu3eh8wuJAuVkGVKkKJvVM8Zw2IKQ48MDmJQAaZkhkQ21AMtIY9iXY
	OmKxMl0+0Cg40BukOg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 476nw20qbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 22:19:16 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Jun 2025 22:18:39 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <qmo@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <shuah@kernel.org>, <bpf@vger.kernel.org>
CC: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
        <jolsa@kernel.org>, <mykolal@fb.com>, <slava.imameev@crowdstrike.com>,
        <justin.deschamp@crowdstrike.com>, <mark.fontana@crowdstrike.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add test for bpftool access to read-only protected maps
Date: Thu, 12 Jun 2025 08:18:16 +1000
Message-ID: <20250611221816.54510-2-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250611221816.54510-1-slava.imameev@crowdstrike.com>
References: <20250611221816.54510-1-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH007.crowdstrike.sys (10.100.11.74)
X-Disclaimer: USA
X-Proofpoint-GUID: 5zPVLx1uT-_4HRoyJiBuOWz38UshkqSV
X-Authority-Analysis: v=2.4 cv=BvCdwZX5 c=1 sm=1 tr=0 ts=684a00e4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=6IFa9wvqVegA:10 a=pl6vuDidAAAA:8 a=Hz9SVTjO7JXawmZt_OwA:9
 a=CCL5U2caOzuHUBkE:21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE4OSBTYWx0ZWRfX7FP9KPoMe5/l
 wCLaaS4hmnYQ3q92uGRXhkX5wedXWeLuK6LV/QcY/c4NPt8Bz+azs4FeXGvrIwESnQwmM/ec+RP
 cvxpOVi5cMDk4WePadwzpTz+OTN4IRWED83N9f02/FYdHMsAkTMv9rfjZ+ggS3q2jSq0Ap6G2G9
 fswAxfd+vHxych+j318gPB6NvYVCBopvXemV5/Lm4qxP8UrMmQB/R1HcYBC9ettgyIU6+h25+eg
 vVdDW3aDu91NN4N+mA5P44yJ/TN04CAK2AC+GqXC1K53KoehYM9R6xv+RlyqPdq4hGvI17c/RpR
 05YYj36Yzg0qoteAZy16JTZF+js0R30vFhIDcAAtxeZHYXX/FLV/ybKqfbShgrhb2Hn18AP48La
 c/saeAwd5RjxBIP3ZKIC+HL9I7JYKkCChwazF7VhOgF2bnYxDrIdnKDVNrkV9WmO+sothLoo
X-Proofpoint-ORIG-GUID: 5zPVLx1uT-_4HRoyJiBuOWz38UshkqSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110189

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
Changes in v2:
- fix for a test compilation error: "conflicting types for 'bpf_fentry_test1'"
Changes in v3:
- Addressed review feedback
- Added tests for map iterator, map and map-of-maps creation, deletion
- Cleaned up excessive output logging
---
---
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/progs/bpf_iter_map_elem.c   |  22 ++
 .../selftests/bpf/progs/security_bpf_map.c    |  69 ++++
 .../testing/selftests/bpf/test_bpftool_map.sh | 363 ++++++++++++++++++
 4 files changed, 455 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_map_elem.c
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
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_map_elem.c b/tools/testing/selftests/bpf/progs/bpf_iter_map_elem.c
new file mode 100644
index 000000000000..2f20485e0de3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_map_elem.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u32 value_sum = 0;
+
+SEC("iter/bpf_map_elem")
+int dump_bpf_map_values(struct bpf_iter__bpf_map_elem *ctx)
+{
+	__u32 value = 0;
+
+	if (ctx->value == (void *)0)
+		return 0;
+
+	bpf_probe_read_kernel(&value, sizeof(value), ctx->value);
+	value_sum += value;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/security_bpf_map.c b/tools/testing/selftests/bpf/progs/security_bpf_map.c
new file mode 100644
index 000000000000..7176f8468641
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/security_bpf_map.c
@@ -0,0 +1,69 @@
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
+} prot_status_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 3);
+} prot_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 3);
+} not_prot_map SEC(".maps");
+
+SEC("fmod_ret/security_bpf_map")
+int BPF_PROG(fmod_bpf_map, struct bpf_map *map, int fmode)
+{
+	__u32 key = 0;
+	__u32 *status_ptr = bpf_map_lookup_elem(&prot_status_map, &key);
+	if (!status_ptr || !*status_ptr) {
+		return 0;
+	}
+
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
+int BPF_PROG(fentry_dummy1, int a)
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
index 000000000000..383e4df08f93
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_bpftool_map.sh
@@ -0,0 +1,363 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+TESTNAME="bpftool_map"
+BPF_FILE="security_bpf_map.bpf.o"
+BPF_ITER_FILE="bpf_iter_map_elem.bpf.o"
+PROTECTED_MAP_NAME="prot_map"
+NOT_PROTECTED_MAP_NAME="not_prot_map"
+BPF_FS_TMP_PARENT="/tmp"
+BPF_FS_PARENT=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
+BPF_FS_PARENT=${BPF_FS_PARENT:-$BPF_FS_TMP_PARENT}
+# bpftool will mount bpf file system under BPF_DIR if it is not mounted
+# under BPF_FS_PARENT.
+BPF_DIR="$BPF_FS_PARENT/test_$TESTNAME"
+SCRIPT_DIR=$(dirname $(realpath "$0"))
+BPF_FILE_PATH="$SCRIPT_DIR/$BPF_FILE"
+BPF_ITER_FILE_PATH="$SCRIPT_DIR/$BPF_ITER_FILE"
+BPFTOOL_PATH="bpftool"
+# Assume the script is located under tools/testing/selftests/bpf/
+KDIR_ROOT_DIR=$(realpath "$SCRIPT_DIR"/../../../../)
+
+_cleanup()
+{
+	set +eu
+
+	# If BPF_DIR is a mount point this will not remove the mount point itself.
+	[ -d "$BPF_DIR" ] && rm -rf "$BPF_DIR" 2> /dev/null
+
+	# Unmount if BPF filesystem was temporarily created.
+	if [ "$BPF_FS_PARENT" = "$BPF_FS_TMP_PARENT" ]; then
+		# A loop and recursive unmount are required as bpftool might
+		# create multiple mounts. For example, a bind mount of the directory
+		# to itself. The bind mount is created to change mount propagation
+		# flags on an actual mount point.
+		max_attempts=3
+		attempt=0
+		while mountpoint -q "$BPF_DIR" && [ $attempt -lt $max_attempts ]; do
+			umount -R "$BPF_DIR" 2>/dev/null
+			attempt=$((attempt+1))
+		done
+
+		# The directory still exists. Remove it now.
+		[ -d "$BPF_DIR" ] && rm -rf "$BPF_DIR" 2>/dev/null
+	fi
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
+check_root_privileges() {
+	if [ $(id -u) -ne 0 ]; then
+		echo "Need root privileges"
+		exit $ksft_skip
+	fi
+}
+
+# Function to verify bpftool path.
+# Parameters:
+#   $1: bpftool path
+verify_bpftool_path() {
+	local bpftool_path="$1"
+	if ! "$bpftool_path" version > /dev/null 2>&1; then
+		echo "Could not run test without bpftool"
+		exit $ksft_skip
+	fi
+}
+
+# Function to initialize map entries with keys [0..2] and values set to 0.
+# Parameters:
+#  $1: Map name
+#  $2: bpftool path
+initialize_map_entries() {
+	local map_name="$1"
+	local bpftool_path="$2"
+
+	for key in 0 1 2; do
+		"$bpftool_path" map update name "$map_name" key $key 0 0 0 value 0 0 0 $key
+	done
+}
+
+# Test read access to the map.
+# Parameters:
+#   $1: Name command (name/pinned)
+#   $2: Map name
+#   $3: bpftool path
+#   $4: key
+access_for_read() {
+	local name_cmd="$1"
+	local map_name="$2"
+	local bpftool_path="$3"
+	local key="$4"
+
+	# Test read access to the map.
+	if ! "$bpftool_path" map lookup "$name_cmd" "$map_name" key $key 1>/dev/null; then
+		echo "  Read access to $key in $map_name failed"
+		exit 1
+	fi
+}
+
+# Test write access to the map.
+# Parameters:
+#   $1: Name command (name/pinned)
+#   $2: Map name
+#   $3: bpftool path
+#   $4: key
+#   $5: Whether write should succeed (true/false)
+access_for_write() {
+	local name_cmd="$1"
+	local map_name="$2"
+	local bpftool_path="$3"
+	local key="$4"
+	local write_should_succeed="$5"
+	local value="1 1 1 1"
+
+	if "$bpftool_path" map update "$name_cmd" "$map_name" key $key value $value 2>/dev/null; then
+		if [ "$write_should_succeed" = "false" ]; then
+			echo "  Write access to $key in $map_name succeeded but should have failed"
+			exit 1
+		fi
+	else
+		if [ "$write_should_succeed" = "true" ]; then
+			echo "  Write access to $key in $map_name failed but should have succeeded"
+			exit 1
+		fi
+	fi
+}
+
+# Test entry deletion for the map.
+# Parameters:
+#   $1: Name command (name/pinned)
+#   $2: Map name
+#   $3: bpftool path
+#   $4: key
+#   $5: Whether write should succeed (true/false)
+access_for_deletion() {
+	local name_cmd="$1"
+	local map_name="$2"
+	local bpftool_path="$3"
+	local key="$4"
+	local write_should_succeed="$5"
+	local value="1 1 1 1"
+
+	# Test deletion by key for the map.
+	# Before deleting, check the key exists.
+	if ! "$bpftool_path" map lookup "$name_cmd" "$map_name" key $key 1>/dev/null; then
+		echo "  Key $key does not exist in $map_name"
+		exit 1
+	fi
+
+	# Delete by key.
+	if "$bpftool_path" map delete "$name_cmd" "$map_name" key $key 2>/dev/null; then
+		if [ "$write_should_succeed" = "false" ]; then
+			echo "  Deletion for $key in $map_name succeeded but should have failed"
+			exit 1
+		fi
+	else
+		if [ "$write_should_succeed" = "true" ]; then
+			echo "  Deletion for $key in $map_name failed but should have succeeded"
+			exit 1
+		fi
+	fi
+
+	# After deleting, check the entry existence according to the expected status.
+	if "$bpftool_path" map lookup "$name_cmd" "$map_name" key $key 1>/dev/null; then
+		if [ "$write_should_succeed" = "true" ]; then
+			echo "  Key $key for $map_name was not deleted but should have been deleted"
+			exit 1
+		fi
+	else
+		if [ "$write_should_succeed" = "false" ]; then
+			echo "  Key $key for $map_name was deleted but should have not been deleted"
+			exit 1
+		fi
+	fi
+
+	# Test creation of map's deleted entry, if deletion was successfull.
+	# Otherwise, the entry exists.
+	if "$bpftool_path" map update "$name_cmd" "$map_name" key $key value $value 2>/dev/null; then
+		if [ "$write_should_succeed" = "false" ]; then
+			echo "  Write access to $key in $map_name succeeded after deletion attempt but should have failed"
+			exit 1
+		fi
+	else
+		if [ "$write_should_succeed" = "true" ]; then
+			echo "  Write access to $key in $map_name failed after deletion attempt but should have succeeded"
+			exit 1
+		fi
+	fi
+}
+
+# Test map elements iterator.
+# Parameters:
+#   $1: Name command (name/pinned)
+#   $2: Map name
+#   $3: bpftool path
+#   $4: BPF_DIR
+#   $5: bpf iterator object file path
+iterate_map_elem() {
+	local name_cmd="$1"
+	local map_name="$2"
+	local bpftool_path="$3"
+	local bpf_dir="$4"
+	local bpf_file="$5"
+	local pin_path="$bpf_dir/map_iterator"
+
+	"$bpftool_path" iter pin "$bpf_file" "$pin_path" map "$name_cmd" "$map_name"
+	if [ ! -f "$pin_path" ]; then
+		echo "  Failed to pin iterator to $pin_path"
+		exit 1
+	fi
+
+	cat "$pin_path" 1>/dev/null
+	rm "$pin_path" 2>/dev/null
+}
+
+# Function to test map access with configurable write expectations
+# Parameters:
+#   $1: Name command (name/pinned)
+#   $2: Map name
+#   $3: bpftool path
+#   $4: key for rw
+#   $5: key to delete
+#   $6: Whether write should succeed (true/false)
+#   $7: BPF_DIR
+#   $8: bpf iterator object file path
+access_map() {
+	local name_cmd="$1"
+	local map_name="$2"
+	local bpftool_path="$3"
+	local key_for_rw="$4"
+	local key_to_del="$5"
+	local write_should_succeed="$6"
+	local bpf_dir="$7"
+	local bpf_iter_file_path="$8"
+
+	access_for_read "$name_cmd" "$map_name" "$bpftool_path" "$key_for_rw"
+	access_for_write "$name_cmd" "$map_name" "$bpftool_path" "$key_for_rw" \
+		"$write_should_succeed"
+	access_for_deletion "$name_cmd" "$map_name" "$bpftool_path" "$key_to_del" \
+		"$write_should_succeed"
+	iterate_map_elem "$name_cmd" "$map_name" "$bpftool_path" "$bpf_dir" \
+		"$bpf_iter_file_path"
+}
+
+# Function to test map access with configurable write expectations
+# Parameters:
+#   $1: Map name
+#   $2: bpftool path
+#   $3: BPF_DIR
+#   $4: Whether write should succeed (true/false)
+#   $5: bpf iterator object file path
+test_map_access() {
+	local map_name="$1"
+	local bpftool_path="$2"
+	local bpf_dir="$3"
+	local pin_path="$bpf_dir/${map_name}_pinned"
+	local write_should_succeed="$4"
+	local bpf_iter_file_path="$5"
+
+	# Test access to the map by name.
+	access_map "name" "$map_name" "$bpftool_path" "0 0 0 0" "1 0 0 0" \
+		"$write_should_succeed" "$bpf_dir" "$bpf_iter_file_path"
+
+	# Pin the map to the BPF filesystem
+	"$bpftool_path" map pin name "$map_name" "$pin_path"
+	if [ ! -e "$pin_path" ]; then
+		echo "  Failed to pin $map_name"
+		exit 1
+	fi
+
+	# Test access to the pinned map.
+	access_map "pinned" "$pin_path" "$bpftool_path" "0 0 0 0" "2 0 0 0" \
+		"$write_should_succeed" "$bpf_dir" "$bpf_iter_file_path"
+}
+
+# Function to test map creation and map-of-maps
+# Parameters:
+#   $1: bpftool path
+#   $2: BPF_DIR
+test_map_creation_and_map_of_maps() {
+	local bpftool_path="$1"
+	local bpf_dir="$2"
+	local outer_map_name="outer_map_tt"
+	local inner_map_name="inner_map_tt"
+
+	"$bpftool_path" map create "$bpf_dir/$inner_map_name" type array key 4 \
+		value 4 entries 4 name "$inner_map_name"
+	if [ ! -f "$bpf_dir/$inner_map_name" ]; then
+		echo " Failed to create inner map file at $bpf_dir/$outer_map_name"
+		return 1
+	fi
+
+	"$bpftool_path" map create "$bpf_dir/$outer_map_name" type hash_of_maps \
+		key 4 value 4 entries 2 name "$outer_map_name" inner_map name "$inner_map_name"
+	if [ ! -f "$bpf_dir/$outer_map_name" ]; then
+		echo " Failed to create outer map file at $bpf_dir/$outer_map_name"
+		return 1
+	fi
+
+	# Add entries to the outer map by name and by pinned path.
+	"$bpftool_path" map update pinned "$bpf_dir/$outer_map_name" key 0 0 0 0 \
+		value pinned "$bpf_dir/$inner_map_name"
+	"$bpftool_path" map update name "$outer_map_name" key 1 0 0 0 value \
+		name "$inner_map_name"
+
+	# The outer map should be full by now.
+	# The following map update command is expected to fail.
+	if "$bpftool_path" map update name "$outer_map_name" key 2 0 0 0 value name \
+		"$inner_map_name" 2>/dev/null; then
+		echo "  Update for $outer_map_name succeeded but should have failed"
+		exit 1
+	fi
+}
+
+set -eu
+
+trap cleanup_skip EXIT
+
+check_root_privileges
+
+verify_bpftool_path "$BPFTOOL_PATH"
+
+trap cleanup EXIT
+
+# Load and attach the BPF programs to control maps access.
+"$BPFTOOL_PATH" prog loadall "$BPF_FILE_PATH" "$BPF_DIR" autoattach
+
+initialize_map_entries "$PROTECTED_MAP_NAME" "$BPFTOOL_PATH"
+initialize_map_entries "$NOT_PROTECTED_MAP_NAME" "$BPFTOOL_PATH"
+
+# Activate the map protection mechanism. Protection status is controlled
+# by a value stored in the prot_status_map at index 0.
+"$BPFTOOL_PATH" map update name prot_status_map key 0 0 0 0 value 1 0 0 0
+
+# Test protected map (write should fail).
+test_map_access "$PROTECTED_MAP_NAME" "$BPFTOOL_PATH" "$BPF_DIR" "false" \
+ "$BPF_ITER_FILE_PATH"
+
+# Test not protected map (write should succeed).
+test_map_access "$NOT_PROTECTED_MAP_NAME" "$BPFTOOL_PATH" "$BPF_DIR" "true" \
+ "$BPF_ITER_FILE_PATH"
+
+test_map_creation_and_map_of_maps "$BPFTOOL_PATH" "$BPF_DIR"
+
+exit 0
-- 
2.34.1


