Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B145CE30
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 21:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhKXUl1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 15:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbhKXUl1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 15:41:27 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16262C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Nov 2021 12:38:17 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id p20-20020a63fe14000000b002cc2a31eaf6so1289587pgh.6
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Nov 2021 12:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a+16mI7Pr87M2uOheqr5HzoEjiEncFmgWtieSeNymP8=;
        b=sLDh5e5zttR8HiXsPHhiMwbNUC45LgfgftB58cRynPMe8F9jC7xkanWNwgZpsdwyuY
         025SWhqQ13ZKMQ10nrI9rSvNR2lvDVczGrhEkJy9wlAVVGUlMJNDuFnd9HVQ4jzvAh08
         DTDCtTyAM3ul32YgaWyBFGkKduejfCaei0aJrQ3I2oKAMxoS2DW9wLf7vygtWwQ9WwuZ
         U4qh4m34a6BlqwMDtOiE7QkOc4sdaO/PbWAmTwwRo07hzB7DGg+a0VfDAunUjsvBdsCo
         B2hszkfGkqooH8Ks6GHvfGR1aAV7bzlDsoGjWATLx7xMiwrhwZQqpX7I4gXyATjiuQx/
         4jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a+16mI7Pr87M2uOheqr5HzoEjiEncFmgWtieSeNymP8=;
        b=yGjj4D139LfwiRURDw9BlUCJ+h/XVt8N0plJtUWYsdtp94sakHOkXBHQ+i2sxsUy0T
         RK5CLbdnqjUTEAgPStpoWLEddn/waFHZNP9Asgp7Q4NZAM0tpSXzjLDEhy7hp9psblPu
         lgIgHVGtg/1lomgu0Rr2BEyViuAPtk2cMQLttmkx1Sihhq3+7KW57L4nUNZSToUF5uZ5
         nRcEUoMbeZ3Td8V899fKGDd6Dvhz2xV3E2/DxWzIXrU69cu2Jqefchi9mR3lK6hrd5fy
         qXZRf7R1XU/CDAnniqvr5eIjdC7MZLnB1CZXxY11TcFwhUk6Ud8JdB2RneibFzxjUwbN
         U6hQ==
X-Gm-Message-State: AOAM533aLMOhBH5ImQucnQxT2uORCpA6ropW1c7gtnL0yRXfCNpqUY+r
        8vXWocRJUINt3UinlnIwmacdNl8uQWK+b7HJ
X-Google-Smtp-Source: ABdhPJxZxQIA2Ed7XXVSLYKke1BQRf6WyTVUPo6Gld0zAXvdmHx9LLhr2kyZFNKi/r9bXh1s692Av4+KkL04OpN4
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:2387:b0:49f:af00:d5d0 with
 SMTP id f7-20020a056a00238700b0049faf00d5d0mr8931769pfc.1.1637786296616; Wed,
 24 Nov 2021 12:38:16 -0800 (PST)
Date:   Wed, 24 Nov 2021 20:38:05 +0000
In-Reply-To: <20211123204644.3458700-1-yosryahmed@google.com>
Message-Id: <20211124203805.3700355-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20211123204644.3458700-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] mm, hugepages: make memory size variable in hugepage-mremap selftest
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The hugetlb vma mremap() test currently maps 1GB of memory to trigger
pmd sharing and make sure that 'unshare' path in mremap code works.
The test originally only mapped 10MB of memory (as specified by the
header comment) but was later modified to 1GB to tackle this case.

However, not all machines will have 1GB of memory to spare for this
test. Adding a mapping size arg will allow run_vmtest.sh to pass an
adequate mapping size, while allowing users to run the test
independently with arbitrary size mappings.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

This is a replacement for
mm-hugepages-fix-size-in-hugetlb-mremap-test.patch in -mm tree.

The original patch set the amount of memory used by the test to 10MB
instead of 1GB to avoid running out of memory. However, the test must
map 1GB or more to trigger pmd sharing. Hence, a variable mapping size
is the best solution here to allow for both options.

---
 tools/testing/selftests/vm/hugepage-mremap.c | 46 +++++++++++++-------
 tools/testing/selftests/vm/run_vmtests.sh    |  2 +-
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index 257df94697a5..2a7c33631a29 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -4,7 +4,11 @@
  *
  * Example of remapping huge page memory in a user application using the
  * mremap system call.  Code assumes a hugetlbfs filesystem is mounted
- * at './huge'.  The code will use 10MB worth of huge pages.
+ * at './huge'.  The amount of memory used by this test is decided by a command
+ * line argument in MBs. If missing, the default amount is 10MB.
+ *
+ * To make sure the test triggers pmd sharing and goes through the 'unshare'
+ * path in the mremap code use 1GB (1024) or more.
  */
 
 #define _GNU_SOURCE
@@ -18,8 +22,10 @@
 #include <linux/userfaultfd.h>
 #include <sys/ioctl.h>
 
-#define LENGTH (1UL * 1024 * 1024 * 1024)
+#define DEFAULT_LENGTH_MB 10UL
+#define MB_TO_BYTES(x) (x * 1024 * 1024)
 
+#define FILE_NAME "huge/hugepagefile"
 #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
 #define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
 
@@ -28,20 +34,20 @@ static void check_bytes(char *addr)
 	printf("First hex is %x\n", *((unsigned int *)addr));
 }
 
-static void write_bytes(char *addr)
+static void write_bytes(char *addr, size_t len)
 {
 	unsigned long i;
 
-	for (i = 0; i < LENGTH; i++)
+	for (i = 0; i < len; i++)
 		*(addr + i) = (char)i;
 }
 
-static int read_bytes(char *addr)
+static int read_bytes(char *addr, size_t len)
 {
 	unsigned long i;
 
 	check_bytes(addr);
-	for (i = 0; i < LENGTH; i++)
+	for (i = 0; i < len; i++)
 		if (*(addr + i) != (char)i) {
 			printf("Mismatch at %lu\n", i);
 			return 1;
@@ -99,11 +105,19 @@ static void register_region_with_uffd(char *addr, size_t len)
 	}
 }
 
-int main(void)
+int main(int argc, char *argv[])
 {
+	/* Read memory length as the first arg if valid, otherwise fallback to
+	 * the default length. Any additional args are ignored.
+	 */
+	size_t length = argc > 1 ? (size_t)atoi(argv[1]) : 0UL;
+
+	length = length > 0 ? length : DEFAULT_LENGTH_MB;
+	length = MB_TO_BYTES(length);
+
 	int ret = 0;
 
-	int fd = open("/huge/test", O_CREAT | O_RDWR, 0755);
+	int fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
 
 	if (fd < 0) {
 		perror("Open failed");
@@ -112,7 +126,7 @@ int main(void)
 
 	/* mmap to a PUD aligned address to hopefully trigger pmd sharing. */
 	unsigned long suggested_addr = 0x7eaa40000000;
-	void *haddr = mmap((void *)suggested_addr, LENGTH, PROTECTION,
+	void *haddr = mmap((void *)suggested_addr, length, PROTECTION,
 			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
 	printf("Map haddr: Returned address is %p\n", haddr);
 	if (haddr == MAP_FAILED) {
@@ -122,7 +136,7 @@ int main(void)
 
 	/* mmap again to a dummy address to hopefully trigger pmd sharing. */
 	suggested_addr = 0x7daa40000000;
-	void *daddr = mmap((void *)suggested_addr, LENGTH, PROTECTION,
+	void *daddr = mmap((void *)suggested_addr, length, PROTECTION,
 			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
 	printf("Map daddr: Returned address is %p\n", daddr);
 	if (daddr == MAP_FAILED) {
@@ -132,16 +146,16 @@ int main(void)
 
 	suggested_addr = 0x7faa40000000;
 	void *vaddr =
-		mmap((void *)suggested_addr, LENGTH, PROTECTION, FLAGS, -1, 0);
+		mmap((void *)suggested_addr, length, PROTECTION, FLAGS, -1, 0);
 	printf("Map vaddr: Returned address is %p\n", vaddr);
 	if (vaddr == MAP_FAILED) {
 		perror("mmap2");
 		exit(1);
 	}
 
-	register_region_with_uffd(haddr, LENGTH);
+	register_region_with_uffd(haddr, length);
 
-	void *addr = mremap(haddr, LENGTH, LENGTH,
+	void *addr = mremap(haddr, length, length,
 			    MREMAP_MAYMOVE | MREMAP_FIXED, vaddr);
 	if (addr == MAP_FAILED) {
 		perror("mremap");
@@ -150,10 +164,10 @@ int main(void)
 
 	printf("Mremap: Returned address is %p\n", addr);
 	check_bytes(addr);
-	write_bytes(addr);
-	ret = read_bytes(addr);
+	write_bytes(addr, length);
+	ret = read_bytes(addr, length);
 
-	munmap(addr, LENGTH);
+	munmap(addr, length);
 
 	return ret;
 }
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index a24d30af3094..75d401741394 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -111,7 +111,7 @@ fi
 echo "-----------------------"
 echo "running hugepage-mremap"
 echo "-----------------------"
-./hugepage-mremap
+./hugepage-mremap 256
 if [ $? -ne 0 ]; then
 	echo "[FAIL]"
 	exitcode=1
-- 
2.34.0.rc2.393.gf8c9666880-goog

