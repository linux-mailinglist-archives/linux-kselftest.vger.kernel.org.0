Return-Path: <linux-kselftest+bounces-30054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D0A7A0BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 12:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED503B5808
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD142248891;
	Thu,  3 Apr 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pls1+a9f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2224BBE1;
	Thu,  3 Apr 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675241; cv=none; b=dHqWphYNvX2IOUcgFcixg392MA9m1u0SmJVSwBL7v1hKI1N/WlYjykVVcVeBN47EjIdpUUGlBdlqikgG8XskS86m0C5FAom4RFSNBXaOGusNEeHY15LEWtTXAmtrjnu8rm0Ib4lnAqNSOgIJIEH7Eb69ZHUsLWaePauV+yAa9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675241; c=relaxed/simple;
	bh=SoPWAEpaQZ+eWbfdqHjnaQXDxz5IohZvVnzt47Mtqjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epOZphWLuA6/R/xS7EufWsMOkTvfXp2E/vLdzrlkrW2KLnh9azQ5+oXjAKIZxH4iyj0Zf0y/ZdvdWwbGGWI0duWsaE4PnoGf97auRPgciaNVIR2keLirakR3E2+6/Jzgp7bzTAkM7dZ8E08neEtSge3QxhKicl1KbgV4OoJUWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pls1+a9f; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2240b4de12bso10138605ad.2;
        Thu, 03 Apr 2025 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743675239; x=1744280039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1jcYIDsgwV0QbwwcIaFrUZpYunSVhU3f2VZkEk3KyA=;
        b=Pls1+a9fs0SkgYIL5rh05WaSa9DZIBNikALB4fnJHOLeNRpK9Dtu9p5Y/qjVuWV6Fi
         7uWWJ/wXSS5APXi4efLlS4FdFBWxNgxRekTyF3t1wznloe+CAo3qt+Ez9Q6a+ECs6WWf
         Stq5dj37FhztEt40nVidHZFFtjLfiFK8l6jLA46tZq5FBqZir7sZXOK8OvnRYCkL54HE
         GPMy+FByzCTCtVhQNRdSJdEy9L6GEJyitOK8huWdTFz1hNKe/4rG+I7wl168Nw2fKNY8
         xQtgLHEWawqb8QL7u1ThX32HPRWhn8FNR+O0rzt4nTMLeeZcly0oVpIrPqo+iRXvc/mz
         eYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743675239; x=1744280039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1jcYIDsgwV0QbwwcIaFrUZpYunSVhU3f2VZkEk3KyA=;
        b=BEzDL8NGkKw4UlBNCNIw/Iq9yMj9qd48KCqrN12L9GzXT92k/avnp1CVQohRpBEVmh
         MUJQB09O+eP03UIyzkdkoQTdpeRP2MqdF9ReVzqNuA5BKUi6eUua2iVxNFa7762i4o5l
         pwpaP7syYacE8iiQT+f6kenwaO1npdwSZT73PezASvWqZXcUWqTgL8slutYOXNfJoJHc
         fRWOKSGBe1KlK7ff20IOHtvAyldqU+3o9YQLytW+Z5Rlq0geF2nfQPfqNAXQPJtWnUI9
         JTa3RtqoKzw/1jaiLZTx3Mwzr0V3pDA4wsYlJJtekFSSxtChdyR8cGcfi9bzLzH4hEzB
         +FWw==
X-Forwarded-Encrypted: i=1; AJvYcCUN6lrMudWbzO5D0pnRFkNixvwLO3EFCMeIlfYNiEKdiWLIuNNaNmECInPZswk11sJ7TcrXj09UamR23WI=@vger.kernel.org, AJvYcCVPWcQLS9HNTiuG7GmF80koQuwVmIt+z+7oJUZlntrex9/jpN75CtR93m1ZF5jrDkGuHw7lb++uu2OQ4wVfBVDE@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNT0yyla3Wyi2JtP82FH4aKz4d/2MIE0wM17h8IidkmhYFqiL
	nZy3Ed1veuMynPjFQU6hCsOagS7TLeIIIRmZe8wjLX7NtD5gfQKU
X-Gm-Gg: ASbGnctmnnSh3UB5i2jtvuJQyuek3+5RHAYX38VRw2xdq108UEFtPdV6Iwg7aEYTgTy
	Ncc62yQSIBcvdt1wquRZk6uAXDAxYwuWWB39yM+4FjpXhY8E3fgxqy4lJtAocO5eX622fvg36WQ
	rIBVA4EOwOUCP7Wy8f0vNVv5l5NZtdrn6DhBKHMETmEb00cvaNgMVqKoYtMc78mGe9ri7C+9VIK
	kK69+M7dSTnexzOlhoJ/ThZPKmhE/5xj07jUtfJ+ogMf28LFb5Rx1vPFZfpQbtMYwlSPt0SJNL1
	HDwnNdNTzTaRWN0NQppBoFHFTEOXbXrz3I4DB0adhbeb2qvEByQ0sKRALT+Xv3gfc/w=
X-Google-Smtp-Source: AGHT+IHBEgySem7ZYEyvmalH7tBoil+1mmF1NNG09oSI2oZk3fzOSaRWrhjHXMxCEepBrEitJNny1g==
X-Received: by 2002:a17:902:ebc3:b0:224:1579:5e91 with SMTP id d9443c01a7336-22977dfe34dmr28809205ad.47.1743675239264;
        Thu, 03 Apr 2025 03:13:59 -0700 (PDT)
Received: from sid-Inspiron-15-3525.. ([2401:4900:5084:2815:d682:e65a:7ee2:33e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30562c6d29dsm2773042a91.2.2025.04.03.03.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 03:13:58 -0700 (PDT)
From: Siddarth G <siddarthsgml@gmail.com>
To: shuah@kernel.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Siddarth G <siddarthsgml@gmail.com>,
	David Binderman <dcb314@hotmail.com>
Subject: [PATCH v3] selftests/mm: Convert page_size to unsigned long
Date: Thu,  3 Apr 2025 15:43:45 +0530
Message-ID: <20250403101345.29226-1-siddarthsgml@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cppcheck warning:
int result is assigned to long long variable. If the variable is long long
to avoid loss of information, then you have loss of information.

This patch changes the type of page_size from 'unsigned int' to
'unsigned long' instead of using ULL suffixes. Changing hpage_size to
'unsigned long' was considered, but since gethugepage() expects an int,
this change was avoided.

Reported-by: David Binderman <dcb314@hotmail.com>
Closes: https://lore.kernel.org/all/AS8PR02MB10217315060BBFDB21F19643E9CA62@AS8PR02MB10217.eurprd02.prod.outlook.com/

Signed-off-by: Siddarth G <siddarthsgml@gmail.com>
---
Changes since v2:
- v2 had conflict with current mainline, so this is a fresh patch

 tools/testing/selftests/mm/pagemap_ioctl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 57b4bba2b45f..fe5ae8b25ff6 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -34,7 +34,7 @@
 #define PAGEMAP "/proc/self/pagemap"
 int pagemap_fd;
 int uffd;
-unsigned int page_size;
+unsigned long page_size;
 unsigned int hpage_size;
 const char *progname;
 
@@ -184,7 +184,7 @@ void *gethugetlb_mem(int size, int *shmid)
 
 int userfaultfd_tests(void)
 {
-	int mem_size, vec_size, written, num_pages = 16;
+	long mem_size, vec_size, written, num_pages = 16;
 	char *mem, *vec;
 
 	mem_size = num_pages * page_size;
@@ -213,7 +213,7 @@ int userfaultfd_tests(void)
 	written = pagemap_ioctl(mem, mem_size, vec, 1, PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC,
 				vec_size - 2, PAGE_IS_WRITTEN, 0, 0, PAGE_IS_WRITTEN);
 	if (written < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", written, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", written, errno, strerror(errno));
 
 	ksft_test_result(written == 0, "%s all new pages must not be written (dirty)\n", __func__);
 
@@ -995,7 +995,7 @@ int unmapped_region_tests(void)
 {
 	void *start = (void *)0x10000000;
 	int written, len = 0x00040000;
-	int vec_size = len / page_size;
+	long vec_size = len / page_size;
 	struct page_region *vec = malloc(sizeof(struct page_region) * vec_size);
 
 	/* 1. Get written pages */
@@ -1051,7 +1051,7 @@ static void test_simple(void)
 int sanity_tests(void)
 {
 	unsigned long long mem_size, vec_size;
-	int ret, fd, i, buf_size;
+	long ret, fd, i, buf_size;
 	struct page_region *vec;
 	char *mem, *fmem;
 	struct stat sbuf;
@@ -1160,7 +1160,7 @@ int sanity_tests(void)
 
 	ret = stat(progname, &sbuf);
 	if (ret < 0)
-		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+		ksft_exit_fail_msg("error %ld %d %s\n", ret, errno, strerror(errno));
 
 	fmem = mmap(NULL, sbuf.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (fmem == MAP_FAILED)
-- 
2.43.0


