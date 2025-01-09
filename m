Return-Path: <linux-kselftest+bounces-24151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10386A07F08
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 18:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C08C188D7F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AF8202C41;
	Thu,  9 Jan 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="eHeKHjTz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2418BC36;
	Thu,  9 Jan 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444411; cv=pass; b=JmGx4e5P5r7CgrDnSOAFWSqNjOREY4DcRZa40Rk/joziiNKv570LyBNbjHupVD4fvii3XbxdPtMFPT3yKKNfVX8ulF2RvgE73h1ptewS9JS9w0fhb/crZhfu+hlA98fvaaEMAKbjDG8j/cVO3OmUkTbGFdq//2APEtjLB0r8/xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444411; c=relaxed/simple;
	bh=nd6PwWS3XThxBPkMOp9zYGO4HFxvs9Fc/tFK+VjaLU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXSVFKOb1kHx7ADT3llVxqlTrArnJftRA+VVTS3QrUGaP4+bct+jF+VsO6p5pR73BhxkQKS9wC12YRFe+vL6GA8qB5BRWmPHZPX6Ti4UzBHVj3cTs2zLCS7Y8oZ96YapuYvsjAov8gdzUfRghXJC/DynjUnYxBhgE0u0B68Y15I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=eHeKHjTz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736444394; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VlzaRCT5kdxtHLCSMGQmkERU8zSolIzcxLb8/I4WY1+XJLcLXFZ4OoS+D+w+FmDFfhqHjlzmE5kyPCEfHU1HynvZ8+F2D2ehyb136ZvgDVKATNwQfxgR7CKbbkJYbS0D4wbP9x6mLbirRPHfnwnToKvcafjOlDAhjCpTdg04bMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736444394; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XUKQE+pYYQLtw6iu8h8iqPbRlit3OHNgXQDXtcizq18=; 
	b=Co8na6WkeEFbKrs/k0LxXEAsXWhT/Th5GrH/sf6RBEtz3CGBW3lVglsuVNNiREVa6Lg8ourjhRt28ySDAlUJwUe8idZI94sIzDHbRpZhJK7axrhmmyjn9mf5RiF6bb+rdwxIluD21rEw5Tgy3Ux8wMumM/1AhKT07YczssWzBvs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736444394;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=XUKQE+pYYQLtw6iu8h8iqPbRlit3OHNgXQDXtcizq18=;
	b=eHeKHjTzhsqsZuOslb/hCZEQ5g7QV68DmaGZcMoRObOq17GCnwZNYwrGmqOmELLb
	TcSaH9qK60tCGL9SseD4ZKoMgREz+G/4Sm/rHWS1pk2vbTiUTWMPxl6VYELGfMHce9f
	D8xbR9TW8TIHh6mtvL8iM8LE9rGSIufzl5klIF6A=
Received: by mx.zohomail.com with SMTPS id 1736444393092801.0156014908434;
	Thu, 9 Jan 2025 09:39:53 -0800 (PST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH 13/16] selftests/mm: protection_keys: Fix variables types mismatch warnings
Date: Thu,  9 Jan 2025 22:38:39 +0500
Message-Id: <20250109173842.1142376-14-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109173842.1142376-1-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix variable type mismatch warnings.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/protection_keys.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 3a66798a8e8d6..ab1e586bc2728 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -78,7 +78,7 @@ static void cat_into_file(char *str, char *file)
 	}
 
 	ret = write(fd, str, strlen(str));
-	if (ret != strlen(str)) {
+	if (ret != (signed int)strlen(str)) {
 		perror("write to file failed");
 		fprintf(stderr, "filename: '%s' str: '%s'\n", file, str);
 		exit(__LINE__);
@@ -597,10 +597,10 @@ struct pkey_malloc_record *pkey_last_malloc_record;
 static long nr_pkey_malloc_records;
 void record_pkey_malloc(void *ptr, long size, int prot)
 {
-	long i;
+	unsigned long i;
 	struct pkey_malloc_record *rec = NULL;
 
-	for (i = 0; i < nr_pkey_malloc_records; i++) {
+	for (i = 0; i < (unsigned long)nr_pkey_malloc_records; i++) {
 		rec = &pkey_malloc_records[i];
 		/* find a free record */
 		if (rec)
@@ -866,7 +866,7 @@ static int nr_test_fds;
 static void __save_test_fd(int fd)
 {
 	pkey_assert(fd >= 0);
-	pkey_assert(nr_test_fds < ARRAY_SIZE(test_fds));
+	pkey_assert(nr_test_fds < (signed int)ARRAY_SIZE(test_fds));
 	test_fds[nr_test_fds] = fd;
 	nr_test_fds++;
 }
@@ -897,7 +897,7 @@ static void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 __attribute__((unuse
 	int max_nr_pkey_allocs;
 	int alloced_pkeys[NR_PKEYS];
 	int nr_alloced = 0;
-	long size;
+	unsigned long size;
 
 	pkey_assert(pkey_last_malloc_record);
 	size = pkey_last_malloc_record->size;
@@ -1280,7 +1280,7 @@ static void test_pkey_init_state(int __attribute__((unused)) *ptr, u16 __attribu
  */
 static void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
 {
-	long size;
+	unsigned long size;
 	int prot;
 
 	assert(pkey_last_malloc_record);
@@ -1530,7 +1530,7 @@ static void test_ptrace_modifies_pkru(int __attribute__((unused)) *ptr,
 	pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
 
 	xsave = (void *)malloc(xsave_size);
-	pkey_assert(xsave > 0);
+	pkey_assert(xsave != NULL);
 
 	/* Modify the PKRU register directly */
 	iov.iov_base = xsave;
@@ -1727,7 +1727,7 @@ static void run_tests_once(void)
 	int *ptr;
 	int prot = PROT_READ|PROT_WRITE;
 
-	for (test_nr = 0; test_nr < ARRAY_SIZE(pkey_tests); test_nr++) {
+	for (test_nr = 0; test_nr < (signed int)ARRAY_SIZE(pkey_tests); test_nr++) {
 		int pkey;
 		int orig_pkey_faults = pkey_faults;
 
-- 
2.39.5


