Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEAD4650D5
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350400AbhLAPIb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59638 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245059AbhLAPIa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20E58B81FE7;
        Wed,  1 Dec 2021 15:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50104C53FD5;
        Wed,  1 Dec 2021 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371106;
        bh=nP0zCJWJh2R15aZXtogVlD4kCvqivnJ+cG8oPlUtwQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjC450bSsbfSeu9uKxK/FCRKWkhs5OCSuvUeLurwI68vVCMqMUml6QrdDnWW2l3cX
         p5E6osJdfF+wwtKApr+slRKF2CkJR8t/VaG2RhykFjYv4xvw200Ri81bVi3jv8cDFt
         /v6yR6TC0utIJv0NQFrB4zSaMJ5dhFaHeLPydF1BThEsCaAITWFhlsY/2pCZg0rd3Y
         GltDaEHxBzhwzwtj5SywsLTzZ5wSf3q/m+yWWuZCLG7+87boyKajswY4FSVRhZCiEJ
         rQ/l3XWYLZBLxJltSf11SvedVw/r60iSHNmMG2Nx+gxfPM1sIiKO1L9DKDmpVSceFP
         hXjibou/gztRw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 10/11] selftests/damon: Test debugfs file reads/writes with huge count
Date:   Wed,  1 Dec 2021 15:04:39 +0000
Message-Id: <20211201150440.1088-11-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DAMON debugfs interface users were able to trigger warning by writing
some files with arbitrarily large 'count' parameter.  The issue is fixed
with commit db7a347b26fe ("mm/damon/dbgfs: use '__GFP_NOWARN' for
user-specified size buffer allocation").  This commit adds a test case
for the issue in DAMON selftests to avoid future regressions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/.gitignore      |  2 +
 tools/testing/selftests/damon/Makefile        |  2 +
 .../testing/selftests/damon/debugfs_attrs.sh  | 18 +++++++++
 .../selftests/damon/huge_count_read_write.c   | 39 +++++++++++++++++++
 4 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/damon/.gitignore
 create mode 100644 tools/testing/selftests/damon/huge_count_read_write.c

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
new file mode 100644
index 000000000000..c6c2965a6607
--- /dev/null
+++ b/tools/testing/selftests/damon/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+huge_count_read_write
diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 8a3f2cd9fec0..f0aa954b5d13 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for damon selftests
 
+TEST_GEN_FILES += huge_count_read_write
+
 TEST_FILES = _chk_dependency.sh
 TEST_PROGS = debugfs_attrs.sh
 
diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index 1ef118617167..23a7b48ca7d3 100644
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -105,4 +105,22 @@ orig_monitor_on=$(cat "$DBGFS/monitor_on")
 test_write_fail "$DBGFS/monitor_on" "on" "orig_monitor_on" "empty target ids"
 echo "$orig_target_ids" > "$DBGFS/target_ids"
 
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
+
 echo "PASS"
diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
new file mode 100644
index 000000000000..ad7a6b4cf338
--- /dev/null
+++ b/tools/testing/selftests/damon/huge_count_read_write.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+
+void write_read_with_huge_count(char *file)
+{
+	int filedesc = open(file, O_RDWR);
+	char buf[25];
+	int ret;
+
+	printf("%s %s\n", __func__, file);
+	if (filedesc < 0) {
+		fprintf(stderr, "failed opening %s\n", file);
+		exit(1);
+	}
+
+	write(filedesc, "", 0xfffffffful);
+	perror("after write: ");
+	ret = read(filedesc, buf, 0xfffffffful);
+	perror("after read: ");
+	close(filedesc);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s <file>\n", argv[0]);
+		exit(1);
+	}
+	write_read_with_huge_count(argv[1]);
+
+	return 0;
+}
-- 
2.17.1

