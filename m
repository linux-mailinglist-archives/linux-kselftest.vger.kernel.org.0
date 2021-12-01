Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303E94650DA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350447AbhLAPId (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52774 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350365AbhLAPIb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 74F5ECE1F4E;
        Wed,  1 Dec 2021 15:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1776BC53FD2;
        Wed,  1 Dec 2021 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371107;
        bh=12Gg2gHRZzGJmTMNLn1vki+uItnZBSKL2VYrvKMNfGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTgr4ULb6pFVZFpgxoQEHrShkKMnZQGR46jEYJ9kb+BHip2uED09gDT/gdaVoAtZ1
         hSOraBh03SCjQBb64aGanRGXBbKfoommXFDkwVThNIfpVWbUQxMiaGMm89launsYHq
         PxoNEdbqLWQS58HwgTON2691Q0bj68zt2E0x2PsdupxmkKrWlB0uNUjhzhxjjkVTV9
         m/4btsLCFQYtiruLsCSuSy7pSXKz7jisUzZ99VEB+n9TRvMNAOH3So63ZAsEb1ubg6
         JgO0biZL6HIT6jhisQA2SkOLVfRFgnuLi9LoXCNJxaIWkIegJPeLMgfdlS1tprB9m9
         iGFXCjijHE0Xg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 11/11] selftests/damon: Split test cases
Date:   Wed,  1 Dec 2021 15:04:40 +0000
Message-Id: <20211201150440.1088-12-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, the single test program, debugfs.sh, contains all test cases
for DAMON.  When one of the cases is failed, finding which case is
failed from the test log is not so easy, and all remaining test will be
skipped.  To improve the situation, this commit splits the single
program into small test programs having their own names.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |   5 +-
 .../selftests/damon/_debugfs_common.sh        |  52 ++++++++
 .../testing/selftests/damon/debugfs_attrs.sh  | 111 +-----------------
 .../selftests/damon/debugfs_empty_targets.sh  |  13 ++
 .../damon/debugfs_huge_count_read_write.sh    |  22 ++++
 .../selftests/damon/debugfs_schemes.sh        |  19 +++
 .../selftests/damon/debugfs_target_ids.sh     |  19 +++
 7 files changed, 129 insertions(+), 112 deletions(-)
 create mode 100644 tools/testing/selftests/damon/_debugfs_common.sh
 create mode 100644 tools/testing/selftests/damon/debugfs_empty_targets.sh
 create mode 100644 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
 create mode 100644 tools/testing/selftests/damon/debugfs_schemes.sh
 create mode 100644 tools/testing/selftests/damon/debugfs_target_ids.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index f0aa954b5d13..937d36ae9a69 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -3,7 +3,8 @@
 
 TEST_GEN_FILES += huge_count_read_write
 
-TEST_FILES = _chk_dependency.sh
-TEST_PROGS = debugfs_attrs.sh
+TEST_FILES = _chk_dependency.sh _debugfs_common.sh
+TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
+TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/_debugfs_common.sh b/tools/testing/selftests/damon/_debugfs_common.sh
new file mode 100644
index 000000000000..48989d4813ae
--- /dev/null
+++ b/tools/testing/selftests/damon/_debugfs_common.sh
@@ -0,0 +1,52 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+test_write_result() {
+	file=$1
+	content=$2
+	orig_content=$3
+	expect_reason=$4
+	expected=$5
+
+	echo "$content" > "$file"
+	if [ $? -ne "$expected" ]
+	then
+		echo "writing $content to $file doesn't return $expected"
+		echo "expected because: $expect_reason"
+		echo "$orig_content" > "$file"
+		exit 1
+	fi
+}
+
+test_write_succ() {
+	test_write_result "$1" "$2" "$3" "$4" 0
+}
+
+test_write_fail() {
+	test_write_result "$1" "$2" "$3" "$4" 1
+}
+
+test_content() {
+	file=$1
+	orig_content=$2
+	expected=$3
+	expect_reason=$4
+
+	content=$(cat "$file")
+	if [ "$content" != "$expected" ]
+	then
+		echo "reading $file expected $expected but $content"
+		echo "expected because: $expect_reason"
+		echo "$orig_content" > "$file"
+		exit 1
+	fi
+}
+
+source ./_chk_dependency.sh
+
+damon_onoff="$DBGFS/monitor_on"
+if [ $(cat "$damon_onoff") = "on" ]
+then
+	echo "monitoring is on"
+	exit $ksft_skip
+fi
diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index 23a7b48ca7d3..902e312bca89 100644
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -1,57 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-test_write_result() {
-	file=$1
-	content=$2
-	orig_content=$3
-	expect_reason=$4
-	expected=$5
-
-	echo "$content" > "$file"
-	if [ $? -ne "$expected" ]
-	then
-		echo "writing $content to $file doesn't return $expected"
-		echo "expected because: $expect_reason"
-		echo "$orig_content" > "$file"
-		exit 1
-	fi
-}
-
-test_write_succ() {
-	test_write_result "$1" "$2" "$3" "$4" 0
-}
-
-test_write_fail() {
-	test_write_result "$1" "$2" "$3" "$4" 1
-}
-
-test_content() {
-	file=$1
-	orig_content=$2
-	expected=$3
-	expect_reason=$4
-
-	content=$(cat "$file")
-	if [ "$content" != "$expected" ]
-	then
-		echo "reading $file expected $expected but $content"
-		echo "expected because: $expect_reason"
-		echo "$orig_content" > "$file"
-		exit 1
-	fi
-}
-
-source ./_chk_dependency.sh
-
-ksft_skip=4
-
-damon_onoff="$DBGFS/monitor_on"
-if [ $(cat "$damon_onoff") = "on" ]
-then
-	echo "monitoring is on"
-	exit $ksft_skip
-fi
+source _debugfs_common.sh
 
 # Test attrs file
 # ===============
@@ -65,62 +15,3 @@ test_write_fail "$file" "1 2 3 5 4" "$orig_content" \
 	"min_nr_regions > max_nr_regions"
 test_content "$file" "$orig_content" "1 2 3 4 5" "successfully written"
 echo "$orig_content" > "$file"
-
-# Test schemes file
-# =================
-
-file="$DBGFS/schemes"
-orig_content=$(cat "$file")
-
-test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0 1 2 3 1 100 3 2 1" \
-	"$orig_content" "valid input"
-test_write_fail "$file" "1 2
-3 4 5 6 3 0 0 0 1 2 3 1 100 3 2 1" "$orig_content" "multi lines"
-test_write_succ "$file" "" "$orig_content" "disabling"
-test_write_fail "$file" "2 1 2 1 10 1 3 10 1 1 1 1 1 1 1 1 2 3" \
-	"$orig_content" "wrong condition ranges"
-echo "$orig_content" > "$file"
-
-# Test target_ids file
-# ====================
-
-file="$DBGFS/target_ids"
-orig_content=$(cat "$file")
-
-test_write_succ "$file" "1 2 3 4" "$orig_content" "valid input"
-test_write_succ "$file" "1 2 abc 4" "$orig_content" "still valid input"
-test_content "$file" "$orig_content" "1 2" "non-integer was there"
-test_write_succ "$file" "abc 2 3" "$orig_content" "the file allows wrong input"
-test_content "$file" "$orig_content" "" "wrong input written"
-test_write_succ "$file" "" "$orig_content" "empty input"
-test_content "$file" "$orig_content" "" "empty input written"
-echo "$orig_content" > "$file"
-
-# Test empty targets case
-# =======================
-
-orig_target_ids=$(cat "$DBGFS/target_ids")
-echo "" > "$DBGFS/target_ids"
-orig_monitor_on=$(cat "$DBGFS/monitor_on")
-test_write_fail "$DBGFS/monitor_on" "on" "orig_monitor_on" "empty target ids"
-echo "$orig_target_ids" > "$DBGFS/target_ids"
-
-# Test huge count read write
-# ==========================
-
-dmesg -C
-
-for file in "$DBGFS/"*
-do
-	./huge_count_read_write "$file"
-done
-
-if dmesg | grep -q WARNING
-then
-	dmesg
-	exit 1
-else
-	exit 0
-fi
-
-echo "PASS"
diff --git a/tools/testing/selftests/damon/debugfs_empty_targets.sh b/tools/testing/selftests/damon/debugfs_empty_targets.sh
new file mode 100644
index 000000000000..87aff8083822
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_empty_targets.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source _debugfs_common.sh
+
+# Test empty targets case
+# =======================
+
+orig_target_ids=$(cat "$DBGFS/target_ids")
+echo "" > "$DBGFS/target_ids"
+orig_monitor_on=$(cat "$DBGFS/monitor_on")
+test_write_fail "$DBGFS/monitor_on" "on" "orig_monitor_on" "empty target ids"
+echo "$orig_target_ids" > "$DBGFS/target_ids"
diff --git a/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh b/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
new file mode 100644
index 000000000000..922cadac2950
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source _debugfs_common.sh
+
+# Test huge count read write
+# ==========================
+
+dmesg -C
+
+for file in "$DBGFS/"*
+do
+	./huge_count_read_write "$file"
+done
+
+if dmesg | grep -q WARNING
+then
+	dmesg
+	exit 1
+else
+	exit 0
+fi
diff --git a/tools/testing/selftests/damon/debugfs_schemes.sh b/tools/testing/selftests/damon/debugfs_schemes.sh
new file mode 100644
index 000000000000..5b39ab44731c
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_schemes.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source _debugfs_common.sh
+
+# Test schemes file
+# =================
+
+file="$DBGFS/schemes"
+orig_content=$(cat "$file")
+
+test_write_succ "$file" "1 2 3 4 5 6 4 0 0 0 1 2 3 1 100 3 2 1" \
+	"$orig_content" "valid input"
+test_write_fail "$file" "1 2
+3 4 5 6 3 0 0 0 1 2 3 1 100 3 2 1" "$orig_content" "multi lines"
+test_write_succ "$file" "" "$orig_content" "disabling"
+test_write_fail "$file" "2 1 2 1 10 1 3 10 1 1 1 1 1 1 1 1 2 3" \
+	"$orig_content" "wrong condition ranges"
+echo "$orig_content" > "$file"
diff --git a/tools/testing/selftests/damon/debugfs_target_ids.sh b/tools/testing/selftests/damon/debugfs_target_ids.sh
new file mode 100644
index 000000000000..49aeabdb0aae
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_target_ids.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source _debugfs_common.sh
+
+# Test target_ids file
+# ====================
+
+file="$DBGFS/target_ids"
+orig_content=$(cat "$file")
+
+test_write_succ "$file" "1 2 3 4" "$orig_content" "valid input"
+test_write_succ "$file" "1 2 abc 4" "$orig_content" "still valid input"
+test_content "$file" "$orig_content" "1 2" "non-integer was there"
+test_write_succ "$file" "abc 2 3" "$orig_content" "the file allows wrong input"
+test_content "$file" "$orig_content" "" "wrong input written"
+test_write_succ "$file" "" "$orig_content" "empty input"
+test_content "$file" "$orig_content" "" "empty input written"
+echo "$orig_content" > "$file"
-- 
2.17.1

