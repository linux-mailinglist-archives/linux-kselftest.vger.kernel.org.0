Return-Path: <linux-kselftest+bounces-15061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51E94CC25
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 10:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAADB23F37
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162FB18DF8F;
	Fri,  9 Aug 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="J5y08/sJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0017556C;
	Fri,  9 Aug 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191944; cv=pass; b=MtCUnLPbYqlbGn96MQrQ8lj6il7ISE4/VCWFBW0weBuVp9RcXWIC/0YhY8YAGnnGDYjwOhp5ngvOUX3SoKaydW3r/HQn0zyEJqFwDjgbmzctvcHP1NoTDmlvUbnlbgyFIIiTj2UiJmWUqDin7gtUrK/ZmY92pb8KYkxGHIDOObM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191944; c=relaxed/simple;
	bh=hNhkS5s4pZ/TvPiMVzZP4/+E4B4Kp6Tp4r2or3Nb49g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LOcsIEG3lJvUNfIpGV/tBAkgpIjaBRlwVpwBpUDdyxIUh28JSxlxQhSEXJFtNJOEdx6hcuRk/QewBP8O0nk4d+Jss4J/NiBDc9638cAiM2RZTJiu62rX8Dk4ljLc+gxPW3FwJeNpriO380T9C3vp09hq94OGXRToKDLlRgx+19Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=J5y08/sJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: usama.anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723191931; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X5r0Hj1uIIiLsjBYiKa6Z37Abt5npPlrIY9CPYNSQjGU8ICmGL7Dmdo6rxJm3FKZOQ4eESI+mJUjdYJE+Dmc4f3sMVV+9wXlDNMbgoayjDrroQXRwIy6kTc5FhEZ/0O0Zg8QuTJHIVhIki0qh5koPVO/PNPeBirrsfTn075Ck74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723191931; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ARoGuwCRmzTNnu/zj+XGQUUTD1/UnUzYPaVkcwelbf8=; 
	b=n2L+1UcFnl5J/P9X9bzVXOyKpO/aTZZ6Fo2AaF9d0fEYbNa0d4kGeIkhU05xmieTSr5/oaXihqXcRw/1hJmjMGt+5KqX8soK4llU8h4UUwAoBQNVZvlCvxzutRoVkf2W2HRsqWGmR9HRUPAxYfqllni70Ig6iJk6DXVZQKIdU48=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723191931;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ARoGuwCRmzTNnu/zj+XGQUUTD1/UnUzYPaVkcwelbf8=;
	b=J5y08/sJWA/tUY8j5hz3pFViQRkicFYOGrpqydElIaUGGgFtoieRS2zEGS0NKx38
	FB7MvyyWlMP1ciJHyCAW0A/YIUJ3UcQD9z7ulLk+g4icNRjjKHpbh67L2QCj1z1b7bw
	qE5GvcexW8dK94Em0/m3iPSuNsRitistGVh0sf00=
Received: by mx.zohomail.com with SMTPS id 1723191930315384.302913310908;
	Fri, 9 Aug 2024 01:25:30 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: mm: Fix build errors on armhf
Date: Fri,  9 Aug 2024 13:25:11 +0500
Message-Id: <20240809082511.497266-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The __NR_mmap isn't found on armhf. The mmap() is commonly available
system call and its wrapper is presnet on all architectures. So it
should be used directly. It solves problem for armhf and doesn't create
problem for architectures as well. Remove sys_mmap() functions as they
aren't doing anything else other than calling mmap(). There is no need
to set errno = 0 manually as glibc always resets it.

For reference errors are as following:

  CC       seal_elf
seal_elf.c: In function 'sys_mmap':
seal_elf.c:39:33: error: '__NR_mmap' undeclared (first use in this function)
   39 |         sret = (void *) syscall(__NR_mmap, addr, len, prot,
      |                                 ^~~~~~~~~

mseal_test.c: In function 'sys_mmap':
mseal_test.c:90:33: error: '__NR_mmap' undeclared (first use in this function)
   90 |         sret = (void *) syscall(__NR_mmap, addr, len, prot,
      |                                 ^~~~~~~~~

Cc: stable@vger.kernel.org
Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/mseal_test.c | 37 +++++++++----------------
 tools/testing/selftests/mm/seal_elf.c   | 13 +--------
 2 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index a818f010de479..bfcea5cf9a484 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -81,17 +81,6 @@ static int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 	return sret;
 }
 
-static void *sys_mmap(void *addr, unsigned long len, unsigned long prot,
-	unsigned long flags, unsigned long fd, unsigned long offset)
-{
-	void *sret;
-
-	errno = 0;
-	sret = (void *) syscall(__NR_mmap, addr, len, prot,
-		flags, fd, offset);
-	return sret;
-}
-
 static int sys_munmap(void *ptr, size_t size)
 {
 	int sret;
@@ -172,7 +161,7 @@ static void setup_single_address(int size, void **ptrOut)
 {
 	void *ptr;
 
-	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	ptr = mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	*ptrOut = ptr;
 }
 
@@ -181,7 +170,7 @@ static void setup_single_address_rw(int size, void **ptrOut)
 	void *ptr;
 	unsigned long mapflags = MAP_ANONYMOUS | MAP_PRIVATE;
 
-	ptr = sys_mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1, 0);
+	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1, 0);
 	*ptrOut = ptr;
 }
 
@@ -205,7 +194,7 @@ bool seal_support(void)
 	void *ptr;
 	unsigned long page_size = getpagesize();
 
-	ptr = sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	ptr = mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	if (ptr == (void *) -1)
 		return false;
 
@@ -481,8 +470,8 @@ static void test_seal_zero_address(void)
 	int prot;
 
 	/* use mmap to change protection. */
-	ptr = sys_mmap(0, size, PROT_NONE,
-			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ptr = mmap(0, size, PROT_NONE,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
 	FAIL_TEST_IF_FALSE(ptr == 0);
 
 	size = get_vma_size(ptr, &prot);
@@ -1209,8 +1198,8 @@ static void test_seal_mmap_overwrite_prot(bool seal)
 	}
 
 	/* use mmap to change protection. */
-	ret2 = sys_mmap(ptr, size, PROT_NONE,
-			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ret2 = mmap(ptr, size, PROT_NONE,
+		    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1240,8 +1229,8 @@ static void test_seal_mmap_expand(bool seal)
 	}
 
 	/* use mmap to expand. */
-	ret2 = sys_mmap(ptr, size, PROT_READ,
-			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ret2 = mmap(ptr, size, PROT_READ,
+		    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1268,8 +1257,8 @@ static void test_seal_mmap_shrink(bool seal)
 	}
 
 	/* use mmap to shrink. */
-	ret2 = sys_mmap(ptr, 8 * page_size, PROT_READ,
-			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ret2 = mmap(ptr, 8 * page_size, PROT_READ,
+		    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1650,7 +1639,7 @@ static void test_seal_discard_ro_anon_on_filebacked(bool seal)
 	ret = fallocate(fd, 0, 0, size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	ptr = sys_mmap(NULL, size, PROT_READ, mapflags, fd, 0);
+	ptr = mmap(NULL, size, PROT_READ, mapflags, fd, 0);
 	FAIL_TEST_IF_FALSE(ptr != MAP_FAILED);
 
 	if (seal) {
@@ -1680,7 +1669,7 @@ static void test_seal_discard_ro_anon_on_shared(bool seal)
 	int ret;
 	unsigned long mapflags = MAP_ANONYMOUS | MAP_SHARED;
 
-	ptr = sys_mmap(NULL, size, PROT_READ, mapflags, -1, 0);
+	ptr = mmap(NULL, size, PROT_READ, mapflags, -1, 0);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	if (seal) {
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index 7aa1366063e4e..d9f8ba8d5050b 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -30,17 +30,6 @@ static int sys_mseal(void *start, size_t len)
 	return sret;
 }
 
-static void *sys_mmap(void *addr, unsigned long len, unsigned long prot,
-	unsigned long flags, unsigned long fd, unsigned long offset)
-{
-	void *sret;
-
-	errno = 0;
-	sret = (void *) syscall(__NR_mmap, addr, len, prot,
-		flags, fd, offset);
-	return sret;
-}
-
 static inline int sys_mprotect(void *ptr, size_t size, unsigned long prot)
 {
 	int sret;
@@ -56,7 +45,7 @@ static bool seal_support(void)
 	void *ptr;
 	unsigned long page_size = getpagesize();
 
-	ptr = sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	ptr = mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
 	if (ptr == (void *) -1)
 		return false;
 
-- 
2.39.2


