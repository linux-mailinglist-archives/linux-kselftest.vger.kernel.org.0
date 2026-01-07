Return-Path: <linux-kselftest+bounces-48424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4296BCFF007
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 18:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C687300A341
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA180354AFC;
	Wed,  7 Jan 2026 16:49:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502E034DB47;
	Wed,  7 Jan 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804553; cv=none; b=aPbhOj5TAidb43vtzAUTmuWrr0FHkmdAEpMklJ2g3yW3yT2CMzAYSpddWJMlgiNEuDGqD9/GjOMxB91ehcjM+clSRuSiWMpYP/BEG36yMCK83iG6LDGgiPO4s/jBGkkw5d057RuGjMO0yngNukCQ257cLryfpcy/hcK/JMNYsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804553; c=relaxed/simple;
	bh=vso8txYA5j9rF+IDmtRFs+v78bjUzSYPh0lwSQtU/Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNAKrHgHeoBnmdKZhakjjb4YdgEEO1aAxLUUqmhYytQ1Ululr90zW3vlvDweprUREC08+BSmwUzBoz7GhJPajMk0yCwWAAn5Hrx4uBB8/8J8H5jm8U/O/Q13u9mkcsPfSaYT2xiXXFUf/pdfMNE3gq+Wj/MlS/lem8VaY46b7tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A97021595;
	Wed,  7 Jan 2026 08:48:56 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43EA53F5A1;
	Wed,  7 Jan 2026 08:49:02 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 8/8] selftests/mm: report SKIP in pfnmap if a check fails
Date: Wed,  7 Jan 2026 16:48:42 +0000
Message-ID: <20260107164842.3289559-9-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107164842.3289559-1-kevin.brodsky@arm.com>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pfnmap currently checks the target file in FIXTURE_SETUP(pfnmap),
meaning once for every test, and skips the test if any check fails.

The target file is the same for every test so this is a little
overkill. More importantly, this approach means that the whole suite
will report PASS even if all the tests are skipped because kernel
configuration (e.g. CONFIG_STRICT_DEVMEM=y) prevented /dev/mem from
being mapped, for instance.

Let's ensure that KSFT_SKIP is returned as exit code if any check
fails by performing the checks in pfnmap_init(), run once. That
function also takes care of finding the offset of the pages to be
mapped and saves it in a global. The file is still mapped/unmapped
for every test, as some of them modify the mapping.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pfnmap.c | 81 ++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index 35b0e3ed54cd..e41d5464130b 100644
--- a/tools/testing/selftests/mm/pfnmap.c
+++ b/tools/testing/selftests/mm/pfnmap.c
@@ -25,8 +25,11 @@
 #include "kselftest_harness.h"
 #include "vm_util.h"
 
+#define DEV_MEM_NPAGES	2
+
 static sigjmp_buf sigjmp_buf_env;
 static char *file = "/dev/mem";
+static off_t file_offset;
 
 static void signal_handler(int sig)
 {
@@ -88,7 +91,7 @@ static int find_ram_target(off_t *offset,
 			break;
 
 		/* We need two pages. */
-		if (end > start + 2 * pagesize) {
+		if (end > start + DEV_MEM_NPAGES * pagesize) {
 			fclose(file);
 			*offset = start;
 			return 0;
@@ -97,9 +100,49 @@ static int find_ram_target(off_t *offset,
 	return -ENOENT;
 }
 
+static void pfnmap_init(void)
+{
+	size_t pagesize = getpagesize();
+	size_t size = DEV_MEM_NPAGES * pagesize;
+	int fd;
+	void *addr;
+
+	if (strncmp(file, "/dev/mem", strlen("/dev/mem")) == 0) {
+		int err = find_ram_target(&file_offset, pagesize);
+
+		if (err)
+			ksft_exit_skip("Cannot find ram target in '/proc/iomem': %s\n",
+				       strerror(-err));
+	} else {
+		file_offset = 0;
+	}
+
+	/*
+	 * Make sure we can open and map the file, and perform some basic
+	 * checks; skip the whole suite if anything goes wrong.
+	 * A fresh mapping is then created for every test case by
+	 * FIXTURE_SETUP(pfnmap).
+	 */
+	fd = open(file, O_RDONLY);
+	if (fd < 0)
+		ksft_exit_skip("Cannot open '%s': %s\n", file, strerror(errno));
+
+	addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, file_offset);
+	if (addr == MAP_FAILED)
+		ksft_exit_skip("Cannot mmap '%s': %s\n", file, strerror(errno));
+
+	if (!check_vmflag_pfnmap(addr))
+		ksft_exit_skip("Invalid file: '%s'. Not pfnmap'ed\n", file);
+
+	if (test_read_access(addr, size))
+		ksft_exit_skip("Cannot read-access mmap'ed '%s'\n", file);
+
+	munmap(addr, size);
+	close(fd);
+}
+
 FIXTURE(pfnmap)
 {
-	off_t offset;
 	size_t pagesize;
 	int dev_mem_fd;
 	char *addr1;
@@ -112,31 +155,13 @@ FIXTURE_SETUP(pfnmap)
 {
 	self->pagesize = getpagesize();
 
-	if (strncmp(file, "/dev/mem", strlen("/dev/mem")) == 0) {
-		/* We'll require two physical pages throughout our tests ... */
-		if (find_ram_target(&self->offset, self->pagesize))
-			SKIP(return,
-				   "Cannot find ram target in '/proc/iomem'\n");
-	} else {
-		self->offset = 0;
-	}
-
 	self->dev_mem_fd = open(file, O_RDONLY);
-	if (self->dev_mem_fd < 0)
-		SKIP(return, "Cannot open '%s'\n", file);
+	ASSERT_GE(self->dev_mem_fd, 0);
 
-	self->size1 = self->pagesize * 2;
+	self->size1 = DEV_MEM_NPAGES * self->pagesize;
 	self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
-			   self->dev_mem_fd, self->offset);
-	if (self->addr1 == MAP_FAILED)
-		SKIP(return, "Cannot mmap '%s'\n", file);
-
-	if (!check_vmflag_pfnmap(self->addr1))
-		SKIP(return, "Invalid file: '%s'. Not pfnmap'ed\n", file);
-
-	/* ... and want to be able to read from them. */
-	if (test_read_access(self->addr1, self->size1))
-		SKIP(return, "Cannot read-access mmap'ed '%s'\n", file);
+			   self->dev_mem_fd, file_offset);
+	ASSERT_NE(self->addr1, MAP_FAILED);
 
 	self->size2 = 0;
 	self->addr2 = MAP_FAILED;
@@ -189,7 +214,7 @@ TEST_F(pfnmap, munmap_split)
 	 */
 	self->size2 = self->pagesize;
 	self->addr2 = mmap(NULL, self->pagesize, PROT_READ, MAP_SHARED,
-			   self->dev_mem_fd, self->offset);
+			   self->dev_mem_fd, file_offset);
 	ASSERT_NE(self->addr2, MAP_FAILED);
 }
 
@@ -258,8 +283,12 @@ int main(int argc, char **argv)
 		if (strcmp(argv[i], "--") == 0) {
 			if (i + 1 < argc && strlen(argv[i + 1]) > 0)
 				file = argv[i + 1];
-			return test_harness_run(i, argv);
+			argc = i;
+			break;
 		}
 	}
+
+	pfnmap_init();
+
 	return test_harness_run(argc, argv);
 }
-- 
2.51.2


