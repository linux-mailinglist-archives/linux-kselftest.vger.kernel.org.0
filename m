Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34A782DCE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 18:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjHUQFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 12:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjHUQFo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 12:05:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 119ADFD;
        Mon, 21 Aug 2023 09:05:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B37D81515;
        Mon, 21 Aug 2023 09:06:22 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB3F93F64C;
        Mon, 21 Aug 2023 09:05:40 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests: cachestat: catch failing fsync test on tmpfs
Date:   Mon, 21 Aug 2023 17:05:34 +0100
Message-Id: <20230821160534.3414911-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821160534.3414911-1-andre.przywara@arm.com>
References: <20230821160534.3414911-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The cachestat kselftest runs a test on a normal file, which is created
temporarily in the current directory. Among the tests it runs there is a
call to fsync(), which is expected to clean all dirty pages used by the
file.
However the tmpfs filesystem implements fsync() as noop_fsync(), so the
call will not even attempt to clean anything when this test file happens
to live on a tmpfs instance. This happens in an initramfs, or when the
current directory is in /dev/shm or sometimes /tmp.

To avoid this test failing wrongly, use statfs() to check which filesystem
the test file lives on. If that is "tmpfs", we skip the fsync() test.

Since the fsync test is only one part of the "normal file" test, we now
execute this twice, skipping the fsync part on the first call.
This way only the second test, including the fsync part, would be skipped.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../selftests/cachestat/test_cachestat.c      | 62 ++++++++++++++-----
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 8f8f46c24846d..4804c7dc7b312 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -4,10 +4,12 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/kernel.h>
+#include <linux/magic.h>
 #include <linux/mman.h>
 #include <sys/mman.h>
 #include <sys/shm.h>
 #include <sys/syscall.h>
+#include <sys/vfs.h>
 #include <unistd.h>
 #include <string.h>
 #include <fcntl.h>
@@ -15,7 +17,7 @@
 
 #include "../kselftest.h"
 
-#define NR_TESTS	8
+#define NR_TESTS	9
 
 static const char * const dev_files[] = {
 	"/dev/zero", "/dev/null", "/dev/urandom",
@@ -91,6 +93,20 @@ bool write_exactly(int fd, size_t filesize)
 	return ret;
 }
 
+/*
+ * fsync() is implemented via noop_fsync() on tmpfs. This makes the fsync()
+ * test fail below, so we need to check for test file living on a tmpfs.
+ */
+static bool is_on_tmpfs(int fd)
+{
+	struct statfs statfs_buf;
+
+	if (fstatfs(fd, &statfs_buf))
+		return false;
+
+	return statfs_buf.f_type == TMPFS_MAGIC;
+}
+
 /*
  * Open/create the file at filename, (optionally) write random data to it
  * (exactly num_pages), then test the cachestat syscall on this file.
@@ -98,13 +114,13 @@ bool write_exactly(int fd, size_t filesize)
  * If test_fsync == true, fsync the file, then check the number of dirty
  * pages.
  */
-bool test_cachestat(const char *filename, bool write_random, bool create,
-		bool test_fsync, unsigned long num_pages, int open_flags,
-		mode_t open_mode)
+static int test_cachestat(const char *filename, bool write_random, bool create,
+			  bool test_fsync, unsigned long num_pages,
+			  int open_flags, mode_t open_mode)
 {
 	size_t PS = sysconf(_SC_PAGESIZE);
 	int filesize = num_pages * PS;
-	bool ret = true;
+	int ret = KSFT_PASS;
 	long syscall_ret;
 	struct cachestat cs;
 	struct cachestat_range cs_range = { 0, filesize };
@@ -113,7 +129,7 @@ bool test_cachestat(const char *filename, bool write_random, bool create,
 
 	if (fd == -1) {
 		ksft_print_msg("Unable to create/open file.\n");
-		ret = false;
+		ret = KSFT_FAIL;
 		goto out;
 	} else {
 		ksft_print_msg("Create/open %s\n", filename);
@@ -122,7 +138,7 @@ bool test_cachestat(const char *filename, bool write_random, bool create,
 	if (write_random) {
 		if (!write_exactly(fd, filesize)) {
 			ksft_print_msg("Unable to access urandom.\n");
-			ret = false;
+			ret = KSFT_FAIL;
 			goto out1;
 		}
 	}
@@ -133,7 +149,7 @@ bool test_cachestat(const char *filename, bool write_random, bool create,
 
 	if (syscall_ret) {
 		ksft_print_msg("Cachestat returned non-zero.\n");
-		ret = false;
+		ret = KSFT_FAIL;
 		goto out1;
 
 	} else {
@@ -143,15 +159,17 @@ bool test_cachestat(const char *filename, bool write_random, bool create,
 			if (cs.nr_cache + cs.nr_evicted != num_pages) {
 				ksft_print_msg(
 					"Total number of cached and evicted pages is off.\n");
-				ret = false;
+				ret = KSFT_FAIL;
 			}
 		}
 	}
 
 	if (test_fsync) {
-		if (fsync(fd)) {
+		if (is_on_tmpfs(fd)) {
+			ret = KSFT_SKIP;
+		} else if (fsync(fd)) {
 			ksft_print_msg("fsync fails.\n");
-			ret = false;
+			ret = KSFT_FAIL;
 		} else {
 			syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
 
@@ -162,13 +180,13 @@ bool test_cachestat(const char *filename, bool write_random, bool create,
 				print_cachestat(&cs);
 
 				if (cs.nr_dirty) {
-					ret = false;
+					ret = KSFT_FAIL;
 					ksft_print_msg(
 						"Number of dirty should be zero after fsync.\n");
 				}
 			} else {
 				ksft_print_msg("Cachestat (after fsync) returned non-zero.\n");
-				ret = false;
+				ret = KSFT_FAIL;
 				goto out1;
 			}
 		}
@@ -259,7 +277,7 @@ int main(void)
 		const char *dev_filename = dev_files[i];
 
 		if (test_cachestat(dev_filename, false, false, false,
-			4, O_RDONLY, 0400))
+			4, O_RDONLY, 0400) == KSFT_PASS)
 			ksft_test_result_pass("cachestat works with %s\n", dev_filename);
 		else {
 			ksft_test_result_fail("cachestat fails with %s\n", dev_filename);
@@ -268,13 +286,27 @@ int main(void)
 	}
 
 	if (test_cachestat("tmpfilecachestat", true, true,
-		true, 4, O_CREAT | O_RDWR, 0400 | 0600))
+		false, 4, O_CREAT | O_RDWR, 0600) == KSFT_PASS)
 		ksft_test_result_pass("cachestat works with a normal file\n");
 	else {
 		ksft_test_result_fail("cachestat fails with normal file\n");
 		ret = 1;
 	}
 
+	switch (test_cachestat("tmpfilecachestat", true, true,
+		true, 4, O_CREAT | O_RDWR, 0600)) {
+	case KSFT_FAIL:
+		ksft_test_result_fail("cachestat fsync fails with normal file\n");
+		ret = KSFT_FAIL;
+		break;
+	case KSFT_PASS:
+		ksft_test_result_pass("cachestat fsync works with a normal file\n");
+		break;
+	case KSFT_SKIP:
+		ksft_test_result_skip("tmpfilecachestat is on tmpfs\n");
+		break;
+	}
+
 	if (test_cachestat_shmem())
 		ksft_test_result_pass("cachestat works with a shmem file\n");
 	else {
-- 
2.25.1

