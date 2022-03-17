Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8D4DC404
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 11:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiCQKfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 06:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiCQKfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 06:35:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BA1DE936;
        Thu, 17 Mar 2022 03:33:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 312121F44FD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647513237;
        bh=vkOmIpb65jl2/KSIPy8hOvjOKFgiEmDAD06aY4dtfdA=;
        h=From:To:Cc:Subject:Date:From;
        b=N5fyGtOugo+DolCSWn541/erLx3k7/OCq/TltPSUuzwLOHD+6qVSl4B8Lrt5tlr41
         lu6yMRrhoLmK4sxwAmkW6wt0SsR8x9wSd5jebSOPYPUwM21x7zxBAiVbvyOp88gveW
         9MnjHhwhAveSgmwZ+1T/gUmGkAk9M4o/msWUNJAenk9yA0/c+SXRJkFTFnMD/q8NiK
         JjbSCJ9RkIYF4Ff3KEjRn1/Jdl9L2XoUDpWUDsJ6CLmm+qXjZ1pVp0nVASiy2qsnLY
         u+drxGKjdW41Im4sJnHiVBnBJVzRD26abGyqe7ZUAVXzKBukq7LYQuH/pWdM9lPJst
         1R3E8SpWZVuhQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, krisman@collabora.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH V5 1/2] selftests: vm: bring common functions to a new file
Date:   Thu, 17 Mar 2022 15:33:21 +0500
Message-Id: <20220317103323.94799-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Bring common functions to a new file while keeping code as much same as
possible. These functions can be used in the new tests. This helps in
avoiding code duplication.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in V5:
Keep moved code as same as possible
- Updated macros names
- Removed macro used to show bit number of dirty bit, added a comment
  instead
- Corrected indentation
---
 tools/testing/selftests/vm/Makefile           |   7 +-
 tools/testing/selftests/vm/madv_populate.c    |  34 +-----
 .../selftests/vm/split_huge_page_test.c       |  79 +------------
 tools/testing/selftests/vm/vm_util.c          | 107 ++++++++++++++++++
 tools/testing/selftests/vm/vm_util.h          |  10 ++
 5 files changed, 124 insertions(+), 113 deletions(-)
 create mode 100644 tools/testing/selftests/vm/vm_util.c
 create mode 100644 tools/testing/selftests/vm/vm_util.h

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 5e43f072f5b76..4e68edb26d6b6 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -34,7 +34,7 @@ TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
 TEST_GEN_FILES += hugepage-vmemmap
 TEST_GEN_FILES += khugepaged
-TEST_GEN_FILES += madv_populate
+TEST_GEN_PROGS = madv_populate
 TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
@@ -47,7 +47,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
-TEST_GEN_FILES += split_huge_page_test
+TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 
 ifeq ($(MACHINE),x86_64)
@@ -91,6 +91,9 @@ TEST_FILES := test_vmalloc.sh
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
+$(OUTPUT)/madv_populate: vm_util.c
+$(OUTPUT)/split_huge_page_test: vm_util.c
+
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
diff --git a/tools/testing/selftests/vm/madv_populate.c b/tools/testing/selftests/vm/madv_populate.c
index 3ee0e82756002..715a42e8e2cdb 100644
--- a/tools/testing/selftests/vm/madv_populate.c
+++ b/tools/testing/selftests/vm/madv_populate.c
@@ -18,6 +18,7 @@
 #include <sys/mman.h>
 
 #include "../kselftest.h"
+#include "vm_util.h"
 
 /*
  * For now, we're using 2 MiB of private anonymous memory for all tests.
@@ -26,18 +27,6 @@
 
 static size_t pagesize;
 
-static uint64_t pagemap_get_entry(int fd, char *start)
-{
-	const unsigned long pfn = (unsigned long)start / pagesize;
-	uint64_t entry;
-	int ret;
-
-	ret = pread(fd, &entry, sizeof(entry), pfn * sizeof(entry));
-	if (ret != sizeof(entry))
-		ksft_exit_fail_msg("reading pagemap failed\n");
-	return entry;
-}
-
 static bool pagemap_is_populated(int fd, char *start)
 {
 	uint64_t entry = pagemap_get_entry(fd, start);
@@ -46,13 +35,6 @@ static bool pagemap_is_populated(int fd, char *start)
 	return entry & 0xc000000000000000ull;
 }
 
-static bool pagemap_is_softdirty(int fd, char *start)
-{
-	uint64_t entry = pagemap_get_entry(fd, start);
-
-	return entry & 0x0080000000000000ull;
-}
-
 static void sense_support(void)
 {
 	char *addr;
@@ -258,20 +240,6 @@ static bool range_is_not_softdirty(char *start, ssize_t size)
 	return ret;
 }
 
-static void clear_softdirty(void)
-{
-	int fd = open("/proc/self/clear_refs", O_WRONLY);
-	const char *ctrl = "4";
-	int ret;
-
-	if (fd < 0)
-		ksft_exit_fail_msg("opening clear_refs failed\n");
-	ret = write(fd, ctrl, strlen(ctrl));
-	if (ret != strlen(ctrl))
-		ksft_exit_fail_msg("writing clear_refs failed\n");
-	close(fd);
-}
-
 static void test_softdirty(void)
 {
 	char *addr;
diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
index 52497b7b9f1db..6aa2b8253aeda 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -16,14 +16,13 @@
 #include <sys/mount.h>
 #include <malloc.h>
 #include <stdbool.h>
+#include "vm_util.h"
 
 uint64_t pagesize;
 unsigned int pageshift;
 uint64_t pmd_pagesize;
 
-#define PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
-#define SMAP_PATH "/proc/self/smaps"
 #define INPUT_MAX 80
 
 #define PID_FMT "%d,0x%lx,0x%lx"
@@ -51,30 +50,6 @@ int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
 	return 0;
 }
 
-
-static uint64_t read_pmd_pagesize(void)
-{
-	int fd;
-	char buf[20];
-	ssize_t num_read;
-
-	fd = open(PMD_SIZE_PATH, O_RDONLY);
-	if (fd == -1) {
-		perror("Open hpage_pmd_size failed");
-		exit(EXIT_FAILURE);
-	}
-	num_read = read(fd, buf, 19);
-	if (num_read < 1) {
-		close(fd);
-		perror("Read hpage_pmd_size failed");
-		exit(EXIT_FAILURE);
-	}
-	buf[num_read] = '\0';
-	close(fd);
-
-	return strtoul(buf, NULL, 10);
-}
-
 static int write_file(const char *path, const char *buf, size_t buflen)
 {
 	int fd;
@@ -113,58 +88,6 @@ static void write_debugfs(const char *fmt, ...)
 	}
 }
 
-#define MAX_LINE_LENGTH 500
-
-static bool check_for_pattern(FILE *fp, const char *pattern, char *buf)
-{
-	while (fgets(buf, MAX_LINE_LENGTH, fp) != NULL) {
-		if (!strncmp(buf, pattern, strlen(pattern)))
-			return true;
-	}
-	return false;
-}
-
-static uint64_t check_huge(void *addr)
-{
-	uint64_t thp = 0;
-	int ret;
-	FILE *fp;
-	char buffer[MAX_LINE_LENGTH];
-	char addr_pattern[MAX_LINE_LENGTH];
-
-	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
-		       (unsigned long) addr);
-	if (ret >= MAX_LINE_LENGTH) {
-		printf("%s: Pattern is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-
-
-	fp = fopen(SMAP_PATH, "r");
-	if (!fp) {
-		printf("%s: Failed to open file %s\n", __func__, SMAP_PATH);
-		exit(EXIT_FAILURE);
-	}
-	if (!check_for_pattern(fp, addr_pattern, buffer))
-		goto err_out;
-
-	/*
-	 * Fetch the AnonHugePages: in the same block and check the number of
-	 * hugepages.
-	 */
-	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
-		goto err_out;
-
-	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) != 1) {
-		printf("Reading smap error\n");
-		exit(EXIT_FAILURE);
-	}
-
-err_out:
-	fclose(fp);
-	return thp;
-}
-
 void split_pmd_thp(void)
 {
 	char *one_page;
diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/vm/vm_util.c
new file mode 100644
index 0000000000000..5beaebc8a88b4
--- /dev/null
+++ b/tools/testing/selftests/vm/vm_util.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
+#include <string.h>
+#include "vm_util.h"
+
+#define PMD_SIZE_FILE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+#define SMAP_FILE_PATH "/proc/self/smaps"
+#define MAX_LINE_LENGTH 500
+
+uint64_t pagemap_get_entry(int fd, char *start)
+{
+	const unsigned long pfn = (unsigned long)start / getpagesize();
+	uint64_t entry;
+	int ret;
+
+	ret = pread(fd, &entry, sizeof(entry), pfn * sizeof(entry));
+	if (ret != sizeof(entry))
+		ksft_exit_fail_msg("reading pagemap failed\n");
+	return entry;
+}
+
+bool pagemap_is_softdirty(int fd, char *start)
+{
+	uint64_t entry = pagemap_get_entry(fd, start);
+
+	// Check if dirty bit (55th bit) is set
+	return entry & 0x0080000000000000ull;
+}
+
+void clear_softdirty(void)
+{
+	int ret;
+	const char *ctrl = "4";
+	int fd = open("/proc/self/clear_refs", O_WRONLY);
+
+	if (fd < 0)
+		ksft_exit_fail_msg("opening clear_refs failed\n");
+	ret = write(fd, ctrl, strlen(ctrl));
+	close(fd);
+	if (ret != strlen(ctrl))
+		ksft_exit_fail_msg("writing clear_refs failed\n");
+}
+
+static bool check_for_pattern(FILE *fp, const char *pattern, char *buf)
+{
+	while (fgets(buf, MAX_LINE_LENGTH, fp) != NULL) {
+		if (!strncmp(buf, pattern, strlen(pattern)))
+			return true;
+	}
+	return false;
+}
+
+uint64_t read_pmd_pagesize(void)
+{
+	int fd;
+	char buf[20];
+	ssize_t num_read;
+
+	fd = open(PMD_SIZE_FILE_PATH, O_RDONLY);
+	if (fd == -1)
+		ksft_exit_fail_msg("Open hpage_pmd_size failed\n");
+
+	num_read = read(fd, buf, 19);
+	if (num_read < 1) {
+		close(fd);
+		ksft_exit_fail_msg("Read hpage_pmd_size failed\n");
+	}
+	buf[num_read] = '\0';
+	close(fd);
+
+	return strtoul(buf, NULL, 10);
+}
+
+uint64_t check_huge(void *addr)
+{
+	uint64_t thp = 0;
+	int ret;
+	FILE *fp;
+	char buffer[MAX_LINE_LENGTH];
+	char addr_pattern[MAX_LINE_LENGTH];
+
+	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
+		       (unsigned long) addr);
+	if (ret >= MAX_LINE_LENGTH)
+		ksft_exit_fail_msg("%s: Pattern is too long\n", __func__);
+
+	fp = fopen(SMAP_FILE_PATH, "r");
+	if (!fp)
+		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, SMAP_FILE_PATH);
+
+	if (!check_for_pattern(fp, addr_pattern, buffer))
+		goto err_out;
+
+	/*
+	 * Fetch the AnonHugePages: in the same block and check the number of
+	 * hugepages.
+	 */
+	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
+		goto err_out;
+
+	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) != 1)
+		ksft_exit_fail_msg("Reading smap error\n");
+
+err_out:
+	fclose(fp);
+	return thp;
+}
diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
new file mode 100644
index 0000000000000..e9f5a0f2be196
--- /dev/null
+++ b/tools/testing/selftests/vm/vm_util.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdint.h>
+#include <fcntl.h>
+#include "../kselftest.h"
+
+uint64_t pagemap_get_entry(int fd, char *start);
+bool pagemap_is_softdirty(int fd, char *start);
+void clear_softdirty(void);
+uint64_t read_pmd_pagesize(void);
+uint64_t check_huge(void *addr);
-- 
2.30.2

