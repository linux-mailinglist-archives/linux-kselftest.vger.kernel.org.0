Return-Path: <linux-kselftest+bounces-16737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B6C965237
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 23:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F96B242B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 21:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5E1BAEE8;
	Thu, 29 Aug 2024 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P7Sfqjpz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D81BA889
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967847; cv=none; b=gaC5ZUVcAg3MtIJ5SOF+tRshB1FgIG/vwczM9JJvjzLlapbH7C/BjsdmOya6mdqBG7QU/yt/j/Ao+vK/1OfcsSWki7xtdr4qdalmBZ31AYgVMk4tpKFAf5nvFWvhunFvnkbPREhoF15Qfk1rb4weJ78dVAcSWEkHmBXE7l1C8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967847; c=relaxed/simple;
	bh=apMHPNI1yPMaoYfRUKKhhBb7LeuUcGyz20qs9PeM88Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUSvDzl/Ta5hAgJaNM87LICx7WwZV/JZ8K5yW4/MjEpQDbRuZGbEZ13JskrLgsril2W9h/EAY4rv3bPV9Fyv4LaK1lxSDahX3hXYjef/HdVLevZ17yKBptTle37laBWsrsAj+78dw5UaQXQVc90JkQ2OkxLU2zXLi3vH3nLVI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P7Sfqjpz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso153103a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724967845; x=1725572645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV36Q5Y79tUSIn32vCscn3phXv9vAn9RdQBx5GFOQFk=;
        b=P7SfqjpzayJeGZQwjX8m9s55w08FyW0NWH5+QZc54QS2U8ATByHntp18V68hOV5bmQ
         P2BRFAMjBIMaDG0vvbdk2iPjlP1OSqdB6YfsiS4e2eyKasrpVfHp3tLpJFlArmNGgUxP
         CBCkwnuvDe2gn3Jbmotv/fbTked8rPLZNYJ6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967845; x=1725572645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EV36Q5Y79tUSIn32vCscn3phXv9vAn9RdQBx5GFOQFk=;
        b=hDLM4g7RxZ87ZuZCMkKbvqSypVEtxpTcEwN87e18WZNda4o84V9R7ySI/YnqubQkhF
         iBDvk5Y3C8NHK4FBGEhv3Go+xuFx7O+8nwtOr2T1XZlddPxnRh9hMqUpsgSOEZuRuehx
         j//7VrjoWOpZ1x+cqbtyAG0hj0gHYj3Lk3I+80xOKbst2rjf3ArRe8lOoiaW1rRYaaXR
         LFJLvRAn3MLYknD0R0ApIljP+UaKfZzdxR9/FrwXVPnRsCEfBX+qa/zmnLnCko3+SaJE
         T4bU+yjDv7H1uQAohomWaFakMgcKiQUkAc+wx7jk+mcdV808sme1M7XLEqK+lrBr9DNq
         T99A==
X-Gm-Message-State: AOJu0YwaORLEPxf/HPQqdwjFIUzkifS/Po23HtsxYj8QwDVolxUmF/nC
	z8+RQGxk6Z5a+2w85TJKLFs3Z014+h3Ti5gaoimCiZHStS/r9okylSFa0a3utaf6sw5ZLsvzEFM
	=
X-Google-Smtp-Source: AGHT+IGXS/7yU03nYXMN9eJKu2hQiu0AShJffAnSYmN8VBCAEYihBobOV5g45a7+u97gPxZ2hllOuA==
X-Received: by 2002:a05:6a20:a125:b0:1be:c3fc:1ccf with SMTP id adf61e73a8af0-1ccee3aa41emr204386637.2.1724967844597;
        Thu, 29 Aug 2024 14:44:04 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d8445e80absm4717791a91.13.2024.08.29.14.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:44:04 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pedro.falcato@gmail.com,
	willy@infradead.org,
	lorenzo.stoakes@oracle.com,
	broonie@kernel.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 1/4] selftests/mm: mseal_test, add vma size check
Date: Thu, 29 Aug 2024 21:43:49 +0000
Message-ID: <20240829214352.963001-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240829214352.963001-1-jeffxu@chromium.org>
References: <20240829214352.963001-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add check for vma size, prot bits and error return.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 398 ++++++++++++++++++++----
 1 file changed, 332 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index e7991e5fdcf3..adc646cf576c 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -170,18 +170,31 @@ static void set_pkey(int pkey, unsigned long pkey_value)
 static void setup_single_address(int size, void **ptrOut)
 {
 	void *ptr;
+	unsigned long page_size = getpagesize();
 
-	ptr = mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	*ptrOut = ptr;
+	*ptrOut = (void *)-1;
+	ptr = mmap(NULL, size + 2 * page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (ptr != (void *) -1) {
+		/* add 2 page at the beginning and end to avoid auto-merge of mapping */
+		sys_mprotect(ptr, page_size, PROT_NONE);
+		sys_mprotect(ptr + size + page_size, page_size, PROT_NONE);
+		*ptrOut = ptr + page_size;
+	}
 }
 
 static void setup_single_address_rw(int size, void **ptrOut)
 {
 	void *ptr;
 	unsigned long mapflags = MAP_ANONYMOUS | MAP_PRIVATE;
+	unsigned long page_size = getpagesize();
 
-	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1, 0);
-	*ptrOut = ptr;
+	*ptrOut = (void *)-1;
+	ptr = mmap(NULL, size + 2 * page_size, PROT_READ | PROT_WRITE, mapflags, -1, 0);
+	if (ptr != (void *) -1) {
+		sys_mprotect(ptr, page_size, PROT_NONE);
+		sys_mprotect(ptr + size + page_size, page_size, PROT_NONE);
+		*ptrOut = ptr + page_size;
+	}
 }
 
 static int clean_single_address(void *ptr, int size)
@@ -226,6 +239,21 @@ bool pkey_supported(void)
 	return false;
 }
 
+bool get_vma_size_supported(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	size = get_vma_size(ptr, &prot);
+	if (size == 4 * page_size && prot == 0x4)
+		return true;
+
+	return false;
+}
+
 static void test_seal_addseal(void)
 {
 	int ret;
@@ -419,11 +447,17 @@ static void test_seal_invalid_input(void)
 	unsigned long size = 4 * page_size;
 	int ret;
 
-	setup_single_address(8 * page_size, &ptr);
+	setup_single_address(9 * page_size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
-	ret = clean_single_address(ptr + 4 * page_size, 4 * page_size);
+
+	ret = clean_single_address(ptr, page_size);
 	FAIL_TEST_IF_FALSE(!ret);
 
+	ret = clean_single_address(ptr + 5 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ptr = ptr + page_size;
+
 	/* invalid flag */
 	ret = syscall(__NR_mseal, ptr, size, 0x20);
 	FAIL_TEST_IF_FALSE(ret < 0);
@@ -523,6 +557,7 @@ static void test_seal_mprotect(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -533,9 +568,14 @@ static void test_seal_mprotect(bool seal)
 	}
 
 	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
@@ -547,6 +587,7 @@ static void test_seal_start_mprotect(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -558,9 +599,14 @@ static void test_seal_start_mprotect(bool seal)
 
 	/* the first page is sealed. */
 	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	/* pages after the first page is not sealed. */
@@ -577,6 +623,7 @@ static void test_seal_end_mprotect(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -593,9 +640,14 @@ static void test_seal_end_mprotect(bool seal)
 	/* last 3 page are sealed */
 	ret = sys_mprotect(ptr + page_size, page_size * 3,
 			PROT_READ | PROT_WRITE);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr + page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 3 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
@@ -607,6 +659,7 @@ static void test_seal_mprotect_unalign_len(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -618,9 +671,14 @@ static void test_seal_mprotect_unalign_len(bool seal)
 
 	/* 2 pages are sealed. */
 	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	ret = sys_mprotect(ptr + page_size * 2, page_size,
@@ -636,6 +694,7 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -646,9 +705,14 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
 
 	/* 3 pages are sealed. */
 	ret = sys_mprotect(ptr, page_size * 3, PROT_READ | PROT_WRITE);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 3 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	ret = sys_mprotect(ptr + page_size * 3, page_size,
@@ -664,6 +728,7 @@ static void test_seal_mprotect_two_vma(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -678,16 +743,26 @@ static void test_seal_mprotect_two_vma(bool seal)
 	}
 
 	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x6);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	ret = sys_mprotect(ptr + page_size * 2, page_size * 2,
 			PROT_READ | PROT_WRITE);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr + page_size * 2, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
@@ -699,6 +774,7 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -719,17 +795,27 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
 
 	/* the second page is sealed. */
 	ret = sys_mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x6);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	/* the third page is sealed. */
 	ret = sys_mprotect(ptr + 2 * page_size, page_size,
 			PROT_READ | PROT_WRITE);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr + 2 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	/* the fouth page is not sealed. */
@@ -746,6 +832,7 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -758,9 +845,14 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
 
 	/* mprotect first 2 page will fail, since the first page are sealed. */
 	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
@@ -783,15 +875,15 @@ static void test_seal_mprotect_partial_mprotect_tail(bool seal)
 	}
 
 	ret = sys_mprotect(ptr, size, PROT_EXEC);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
-		FAIL_TEST_IF_FALSE(!ret);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
 
-	if (seal) {
-		FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) > 0);
+		size = get_vma_size(ptr + page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
 		FAIL_TEST_IF_FALSE(prot == 0x4);
-	}
+	} else
+		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
 }
@@ -846,6 +938,7 @@ static void test_seal_mprotect_split(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -862,16 +955,34 @@ static void test_seal_mprotect_split(bool seal)
 
 	/* mprotect is sealed. */
 	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x6);
+
+		size = get_vma_size(ptr + page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 3 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 
 	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x6);
+
+		size = get_vma_size(ptr + page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 3 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
@@ -883,6 +994,7 @@ static void test_seal_mprotect_merge(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -899,9 +1011,18 @@ static void test_seal_mprotect_merge(bool seal)
 
 	/* 2 pages are sealed. */
 	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x6);
+
+		size = get_vma_size(ptr + page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	/* last 2 pages are not sealed. */
@@ -917,6 +1038,7 @@ static void test_seal_munmap(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -928,9 +1050,14 @@ static void test_seal_munmap(bool seal)
 
 	/* 4 pages are sealed. */
 	ret = sys_munmap(ptr, size);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
@@ -948,6 +1075,7 @@ static void test_seal_munmap_two_vma(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -962,15 +1090,33 @@ static void test_seal_munmap_two_vma(bool seal)
 	}
 
 	ret = sys_munmap(ptr, page_size * 2);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x6);
+
+		size = get_vma_size(ptr + 2 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	ret = sys_munmap(ptr + page_size, page_size * 2);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x6);
+
+		size = get_vma_size(ptr + 2 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
@@ -1018,33 +1164,75 @@ static void test_seal_munmap_partial_across_vmas(bool seal)
 {
 	void *ptr;
 	unsigned long page_size = getpagesize();
-	unsigned long size = 2 * page_size;
+	unsigned long size = 12 * page_size;
 	int ret;
 	int prot;
 
-	/*
-	 * Check if a partial mseal (that results in two vmas) works correctly.
-	 * It might unmap the first, but it'll never unmap the second (msealed) vma.
-	 */
-
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	if (seal) {
-		ret = sys_mseal(ptr + page_size, page_size);
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
 		FAIL_TEST_IF_FALSE(!ret);
 	}
 
-	ret = sys_munmap(ptr, size);
-	if (seal)
+	ret = sys_munmap(ptr, 12 * page_size);
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 8 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
+
+	ret = sys_munmap(ptr, 6 * page_size);
 	if (seal) {
-		FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &prot) > 0);
+		FAIL_TEST_IF_FALSE(ret < 0);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
 		FAIL_TEST_IF_FALSE(prot == 0x4);
-	}
+
+		size = get_vma_size(ptr + 8 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
+		FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_munmap(ptr + 6 * page_size, 6 * page_size);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret < 0);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 8 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
+		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
 }
@@ -1074,9 +1262,11 @@ static void test_munmap_start_freed(bool seal)
 	ret = sys_munmap(ptr, size);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
 
 		size = get_vma_size(ptr + page_size, &prot);
-		FAIL_TEST_IF_FALSE(size == page_size * 3);
+		FAIL_TEST_IF_FALSE(size == 3 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else {
 		/* note: this will be OK, even the first page is */
 		/* already unmapped. */
@@ -1095,6 +1285,7 @@ static void test_munmap_end_freed(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1111,9 +1302,14 @@ static void test_munmap_end_freed(bool seal)
 
 	/* unmap all pages. */
 	ret = sys_munmap(ptr, size);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 3 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
@@ -1144,12 +1340,15 @@ static void test_munmap_middle_freed(bool seal)
 	ret = sys_munmap(ptr, size);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
 
 		size = get_vma_size(ptr, &prot);
 		FAIL_TEST_IF_FALSE(size == page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 
 		size = get_vma_size(ptr + page_size * 3, &prot);
 		FAIL_TEST_IF_FALSE(size == page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else {
 		FAIL_TEST_IF_FALSE(!ret);
 
@@ -1170,6 +1369,7 @@ static void test_seal_mremap_shrink(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1184,6 +1384,10 @@ static void test_seal_mremap_shrink(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else {
 		FAIL_TEST_IF_FALSE(ret2 != (void *) MAP_FAILED);
 
@@ -1199,6 +1403,7 @@ static void test_seal_mremap_expand(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1216,6 +1421,10 @@ static void test_seal_mremap_expand(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else {
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
@@ -1231,6 +1440,7 @@ static void test_seal_mremap_move(bool seal)
 	unsigned long size = page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1249,10 +1459,12 @@ static void test_seal_mremap_move(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
-	} else {
-		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
 
-	}
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size ==  page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
 
 	REPORT_TEST_PASS();
 }
@@ -1264,6 +1476,7 @@ static void test_seal_mmap_overwrite_prot(bool seal)
 	unsigned long size = page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1279,6 +1492,10 @@ static void test_seal_mmap_overwrite_prot(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
@@ -1292,6 +1509,7 @@ static void test_seal_mmap_expand(bool seal)
 	unsigned long size = 12 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1310,6 +1528,10 @@ static void test_seal_mmap_expand(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 8 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
@@ -1323,6 +1545,7 @@ static void test_seal_mmap_shrink(bool seal)
 	unsigned long size = 12 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1338,6 +1561,10 @@ static void test_seal_mmap_shrink(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 12 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
@@ -1352,6 +1579,7 @@ static void test_seal_mremap_shrink_fixed(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1369,6 +1597,10 @@ static void test_seal_mremap_shrink_fixed(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == newAddr);
 
@@ -1383,6 +1615,7 @@ static void test_seal_mremap_expand_fixed(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(page_size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1400,6 +1633,10 @@ static void test_seal_mremap_expand_fixed(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(newAddr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == newAddr);
 
@@ -1414,6 +1651,7 @@ static void test_seal_mremap_move_fixed(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1430,6 +1668,10 @@ static void test_seal_mremap_move_fixed(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(newAddr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == newAddr);
 
@@ -1443,6 +1685,7 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1460,9 +1703,12 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
-	} else {
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
 		FAIL_TEST_IF_FALSE(ret2 == 0);
-	}
 
 	REPORT_TEST_PASS();
 }
@@ -1474,6 +1720,7 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1488,6 +1735,10 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else {
 		/* kernel will allocate a new address */
 		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
@@ -1503,6 +1754,7 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1529,6 +1781,10 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else {
 		/* remap success and return ptr2 */
 		FAIL_TEST_IF_FALSE(ret2 ==  ptr2);
@@ -1690,9 +1946,10 @@ static void test_seal_discard_ro_anon_on_pkey(bool seal)
 	/* sealing will take effect if PKRU deny write. */
 	set_pkey(pkey, PKEY_DISABLE_WRITE);
 	ret = sys_madvise(ptr, size, MADV_DONTNEED);
-	if (seal)
+	if (seal) {
 		FAIL_TEST_IF_FALSE(ret < 0);
-	else
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+	} else
 		FAIL_TEST_IF_FALSE(!ret);
 
 	/* base seal still apply. */
@@ -1876,6 +2133,15 @@ int main(int argc, char **argv)
 	if (!pkey_supported())
 		ksft_print_msg("PKEY not supported\n");
 
+	/*
+	 * Possible reasons:
+	 * - unable to read /proc/pid/maps (unlikely)
+	 * - parsing error when reading /proc/pid/maps,e.g. len is not expected.
+	 *   Is this "TOPDOWN" mapping or format change in /proc/pid/maps ?
+	 */
+	if (!get_vma_size_supported())
+		ksft_exit_skip("get_vma_size not supported\n");
+
 	ksft_set_plan(88);
 
 	test_seal_addseal();
-- 
2.46.0.469.g59c65b2a67-goog


