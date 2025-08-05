Return-Path: <linux-kselftest+bounces-38261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF464B1AC23
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 03:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A563A4E47
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F820199E94;
	Tue,  5 Aug 2025 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTElEv0J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A718C011
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357818; cv=none; b=riK2XWixB/Y2W27GdQnc+2lC87hBK8LW0yWbG7HPO2W3vVboCf16KfRNdo11ti8GV3R6HvIM6TNuti7FuyKg069hKKDc/aEM6nOx5Rp0vkxjkStJ3jUcSrBqrLS0/D3b/uy8hClqLQDwUEcvQv8Hrh5OFzuYesGlDiA1Mz+8LI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357818; c=relaxed/simple;
	bh=14rJY76pYCowLl26Jh/Gtt3YHSBgzVhu7C3NkYPnQ5k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S7aziL2YV90i9gLZhm4ZOM3Gual14wvjExtP++qGZQjqq2eEiIMQySKJSXkZYaoKXgfQO29f/ZWpiP8kdJEtsXMxu3HwEYAeJ5ClBH7xt1o/T+krpk7N5dVB9FPFJJ/dG7P4aqElvMoSKuLuGbwgHKvYXbmyzX8zfbkjZRmu0+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTElEv0J; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sudarsanm.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bd757bbccso3421692b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Aug 2025 18:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754357816; x=1754962616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EWDIRG94rF/jhpzQYk9pekkna8f6TwTEVOGNiOzScoU=;
        b=qTElEv0Jn7qZ2joTr6mGgLLY46nA0t8/mAqyXb1TIPtxCIPjg6FxnY1Cx4HxDZGrR/
         uRgrsvyH5a7b/KIF5qA5/HRVZ4pnJddRbGqu9xIXecd/d7kNFDYo2YtenbrjCPzHTgy1
         aRgS9QYyILjDvBRoCFE443WZt7Bro70JShHurwnTdGCIScKDD90b9phICTYTCmT51uCC
         uyepXuQ4OIcW05N+vqM0NpdWYojlQt7f/CbxyBwKjeabjkRP0yZde9rbxdXrhpZjGKbz
         duh2fWZMOXhz6nf4jZ7Nza7FbdBGEutymuO1FFNSZ9teO4LfO4Q/KRW3Ylu1INIxooRd
         k7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754357816; x=1754962616;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWDIRG94rF/jhpzQYk9pekkna8f6TwTEVOGNiOzScoU=;
        b=W/VMZDLtbDwhazVJ7kVE+48PBrj0hg7RPlfvUtSQm8Y4ABKT/bSvGXsiSCrhVA0KyD
         q2Xxgrlh30Y+jnW+U/0VlRdC9wrjbx3jP3bu4yMngtooSlKrD4lmXVonGiI+zABWgRVE
         i2Af6TZfQYhVd1+y+FcR+wd2NiPRSzg1rRWaN3s/Kdly91MCbFE2adn+xe8lgKKTJUjB
         upB1aEiP34DYazjYxynjpuWnfdrt2ZHUGzitHnhQ+lnX1Z9qTeqEsC/kxnaV6Ye6nTOh
         6m+jLxubdwIDm7rSZUqLBkGJKDqsfrzppSKLudXYPoPwtW8lucTzk+8C84YQtpGSIO7w
         MTXA==
X-Gm-Message-State: AOJu0Yx9M/uDVo0Tc0kZZcixyYUoysMOEqmJAtMrPQn8Nr0ipjzOdloW
	pMgMZynehj68DOsNpOzNyvq6P5KpWXg2jnmoc8wqG6BiqSA8T3fwz5fTHy/qlyewW4rEgZ1I9qQ
	LbsqlVq58nOxmMRPuaVl+y49PcVj6AiLgncaNcaeTApX15nSnINb4SbqWVQnFnhtqvj8Y7c0nx5
	yRPOfz3JhahyfZ16359QH1bJT/CZkRKBGHszjAXYnFn0cSWO48gvMzRlnWihX5FOCA
X-Google-Smtp-Source: AGHT+IEP4Ogt0yYMTIBcyMkZVXGHn1+5yaxjZGFBUoanUVK2ZcSy/N7vLmJir+3zYOINgjYWp9TiiN0hN/ltZ0Y=
X-Received: from pgdq17.prod.google.com ([2002:a63:9811:0:b0:b2b:f469:cf78])
 (user=sudarsanm job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7287:b0:240:27c:fcc6 with SMTP id adf61e73a8af0-240027d0352mr9585169637.42.1754357815911;
 Mon, 04 Aug 2025 18:36:55 -0700 (PDT)
Date: Mon,  4 Aug 2025 18:36:29 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805013629.47629-1-sudarsanm@google.com>
Subject: [PATCH v3] selftests/mm: pass filename as input param to VM_PFNMAP tests
From: Sudarsan Mahendran <sudarsanm@google.com>
To: linux-kselftest@vger.kernel.org, David Hildenbrand <david@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	trivial@kernel.org, Sudarsan Mahendran <sudarsanm@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable these tests to be run on other pfnmap'ed memory like
NVIDIA's EGM.

Add '--' as a separator to pass in file path. This allows
passing of cmd line arguments to kselftest_harness.
Use '/dev/mem' as default filename.

Existing test passes:
	pfnmap
	TAP version 13
	1..6
	# Starting 6 tests from 1 test cases.
	# PASSED: 6 / 6 tests passed.
	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Pass params to kselftest_harness:
	pfnmap -r pfnmap:mremap_fixed
	TAP version 13
	1..1
	# Starting 1 tests from 1 test cases.
	#  RUN           pfnmap.mremap_fixed ...
	#            OK  pfnmap.mremap_fixed
	ok 1 pfnmap.mremap_fixed
	# PASSED: 1 / 1 tests passed.
	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Pass non-existent file name as input:
	pfnmap -- /dev/blah
	TAP version 13
	1..6
	# Starting 6 tests from 1 test cases.
	#  RUN           pfnmap.madvise_disallowed ...
	#      SKIP      Cannot open '/dev/blah'

Pass non pfnmap'ed file as input:
	pfnmap -r pfnmap.madvise_disallowed -- randfile.txt
	TAP version 13
	1..1
	# Starting 1 tests from 1 test cases.
	#  RUN           pfnmap.madvise_disallowed ...
	#      SKIP      Invalid file: 'randfile.txt'. Not pfnmap'ed

Signed-off-by: Sudarsan Mahendran <sudarsanm@google.com>
---

v2 -> v3:
* Add check_vmflag_pfnmap func
* Re-use existing check_vmflag_io func
* Verify pfnmap using mmap addr
* Rename phys_addr to offset

v1 -> v2:
* Add verify_pfnmap func to sanity check the input param
* mmap with zero offset if filename != '/dev/mem'

---
 tools/testing/selftests/mm/pfnmap.c  | 48 ++++++++++++++++++++--------
 tools/testing/selftests/mm/vm_util.c | 14 ++++++--
 tools/testing/selftests/mm/vm_util.h |  1 +
 3 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index 866ac023baf5..88659f0a90ea 100644
--- a/tools/testing/selftests/mm/pfnmap.c
+++ b/tools/testing/selftests/mm/pfnmap.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Basic VM_PFNMAP tests relying on mmap() of '/dev/mem'
+ * Basic VM_PFNMAP tests relying on mmap() of input file provided.
+ * Use '/dev/mem' as default.
  *
  * Copyright 2025, Red Hat, Inc.
  *
@@ -25,6 +26,7 @@
 #include "vm_util.h"
 
 static sigjmp_buf sigjmp_buf_env;
+static char *file = "/dev/mem";
 
 static void signal_handler(int sig)
 {
@@ -51,7 +53,7 @@ static int test_read_access(char *addr, size_t size, size_t pagesize)
 	return ret;
 }
 
-static int find_ram_target(off_t *phys_addr,
+static int find_ram_target(off_t *offset,
 		unsigned long long pagesize)
 {
 	unsigned long long start, end;
@@ -91,7 +93,7 @@ static int find_ram_target(off_t *phys_addr,
 		/* We need two pages. */
 		if (end > start + 2 * pagesize) {
 			fclose(file);
-			*phys_addr = start;
+			*offset = start;
 			return 0;
 		}
 	}
@@ -100,7 +102,7 @@ static int find_ram_target(off_t *phys_addr,
 
 FIXTURE(pfnmap)
 {
-	off_t phys_addr;
+	off_t offset;
 	size_t pagesize;
 	int dev_mem_fd;
 	char *addr1;
@@ -113,23 +115,31 @@ FIXTURE_SETUP(pfnmap)
 {
 	self->pagesize = getpagesize();
 
-	/* We'll require two physical pages throughout our tests ... */
-	if (find_ram_target(&self->phys_addr, self->pagesize))
-		SKIP(return, "Cannot find ram target in '/proc/iomem'\n");
+	if (strncmp(file, "/dev/mem", strlen("/dev/mem")) == 0) {
+		/* We'll require two physical pages throughout our tests ... */
+		if (find_ram_target(&self->offset, self->pagesize))
+			SKIP(return,
+				   "Cannot find ram target in '/proc/iomem'\n");
+	} else {
+		self->offset = 0;
+	}
 
-	self->dev_mem_fd = open("/dev/mem", O_RDONLY);
+	self->dev_mem_fd = open(file, O_RDONLY);
 	if (self->dev_mem_fd < 0)
-		SKIP(return, "Cannot open '/dev/mem'\n");
+		SKIP(return, "Cannot open '%s'\n", file);
 
 	self->size1 = self->pagesize * 2;
 	self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
-			   self->dev_mem_fd, self->phys_addr);
+			   self->dev_mem_fd, self->offset);
 	if (self->addr1 == MAP_FAILED)
-		SKIP(return, "Cannot mmap '/dev/mem'\n");
+		SKIP(return, "Cannot mmap '%s'\n", file);
+
+	if (!check_vmflag_pfnmap(self->addr1))
+		SKIP(return, "Invalid file: '%s'. Not pfnmap'ed\n", file);
 
 	/* ... and want to be able to read from them. */
 	if (test_read_access(self->addr1, self->size1, self->pagesize))
-		SKIP(return, "Cannot read-access mmap'ed '/dev/mem'\n");
+		SKIP(return, "Cannot read-access mmap'ed '%s'\n", file);
 
 	self->size2 = 0;
 	self->addr2 = MAP_FAILED;
@@ -182,7 +192,7 @@ TEST_F(pfnmap, munmap_split)
 	 */
 	self->size2 = self->pagesize;
 	self->addr2 = mmap(NULL, self->pagesize, PROT_READ, MAP_SHARED,
-			   self->dev_mem_fd, self->phys_addr);
+			   self->dev_mem_fd, self->offset);
 	ASSERT_NE(self->addr2, MAP_FAILED);
 }
 
@@ -246,4 +256,14 @@ TEST_F(pfnmap, fork)
 	ASSERT_EQ(ret, 0);
 }
 
-TEST_HARNESS_MAIN
+int main(int argc, char **argv)
+{
+	for (int i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--") == 0) {
+			if (i + 1 < argc && strlen(argv[i + 1]) > 0)
+				file = argv[i + 1];
+			return test_harness_run(i, argv);
+		}
+	}
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 5492e3f784df..2cebe4212db8 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -402,7 +402,7 @@ unsigned long get_free_hugepages(void)
 	return fhp;
 }
 
-bool check_vmflag_io(void *addr)
+static bool check_vmflag(void *addr, const char *flag)
 {
 	char buffer[MAX_LINE_LENGTH];
 	const char *flags;
@@ -419,13 +419,23 @@ bool check_vmflag_io(void *addr)
 		if (!flaglen)
 			return false;
 
-		if (flaglen == strlen("io") && !memcmp(flags, "io", flaglen))
+		if (flaglen == strlen(flag) && !memcmp(flags, flag, flaglen))
 			return true;
 
 		flags += flaglen;
 	}
 }
 
+bool check_vmflag_io(void *addr)
+{
+	return check_vmflag(addr, "io");
+}
+
+bool check_vmflag_pfnmap(void *addr)
+{
+	return check_vmflag(addr, "pf");
+}
+
 /*
  * Open an fd at /proc/$pid/maps and configure procmap_out ready for
  * PROCMAP_QUERY query. Returns 0 on success, or an error code otherwise.
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index b8136d12a0f8..ec1f61f30fe7 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -84,6 +84,7 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls);
 unsigned long get_free_hugepages(void);
 bool check_vmflag_io(void *addr);
+bool check_vmflag_pfnmap(void *addr);
 int open_procmap(pid_t pid, struct procmap_fd *procmap_out);
 int query_procmap(struct procmap_fd *procmap);
 bool find_vma_procmap(struct procmap_fd *procmap, void *address);
-- 
2.50.1.565.gc32cd1483b-goog


