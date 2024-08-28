Return-Path: <linux-kselftest+bounces-16596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0622C963519
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 00:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC711C22288
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 22:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5324E1AC8AE;
	Wed, 28 Aug 2024 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+Vpq/DG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5B1AD9D8
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885754; cv=none; b=dY84JLq3VacmwZW3eH5vuXW8Hmdx6PhY2RVMUDRqec4dEeuBysn/OQWbqL9+mZeiiji2Vg6nZMPQtoqTEUIyyjCLeNDw3AcrDAaQsI5KCZzc+Egd7GHxrBE+clBttu7xoQj7iXX6Rqq5hujrQwOHoECys6OKi/2tmC8VPZODjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885754; c=relaxed/simple;
	bh=2woQxUuLRC/ZyQQqIOQuZcQRLPd99YLDxjYO2GPV4Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUiPNNKKbpR9utxIltcEg428X9BUNH4URa/myDzO81rxnZA/OiiGxFchA6NAKD3N950gbkEXGNjeQJjgI/zryuAgKSUCyrdOn0I6zrkIcrmyJG7gX3IPemKZykctOJo3tShaBOlXjEND0uii05JhffYuSnp1RnxAiIZvHYzri04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i+Vpq/DG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71446767885so7431b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 15:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724885751; x=1725490551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qN7fsKN8Eg1I7UI8VLIiWX1kAYoVxC5C3RoKDwRDA/U=;
        b=i+Vpq/DGe4q5920eCiS9V14+GA1PvN9RJ06j/v/FQAUsdSERMXi+hst6vIwnuGBIe8
         KGwslepqmecc2jO8/cQ1cfr1snid6w0b5T8wDyLwJYnnQ2bw7lx7d2KbwpMW5AH01g8d
         0TPXmWT7B0OGzKmjtsUVeCnA6zbFncf1QZ40w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724885751; x=1725490551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qN7fsKN8Eg1I7UI8VLIiWX1kAYoVxC5C3RoKDwRDA/U=;
        b=dV6JcuqmGKMJLiZcPBmJS2RHHcHR2f/iisnIEeYEbCT1s+VXHAMDGVd858/xR3pFVu
         X1akTE3Lc84cCj11KSL8AvF0Evx3POZFPSA5uYXMcUQEn9gmqAETwpf3srzGjqMw1n0W
         /kW+JP03dutR8iwnTr0xf8J4/+O+6wXVI5E9lQaQc6+b7cxuRuekqsxZ+ag11ko65k4j
         D/kudZQu212Ci3upmsw8gzZfUnLxAtgogBTds4FOTemgebTNp21IL/CTWwlKonH54GRY
         AyznwRHlIJ5I/htYV690iy1nHmQyEkmrI7NOLv92mhjoOJnrPMMkqwsWs9/32sfpvGLx
         g65A==
X-Gm-Message-State: AOJu0YyVMr/JoJ1V9BrZRospEO0P8Yk6onPUkQK93wkEbrqx2KGs04Jh
	BymGLnurzGTRcEZglxj8MrGKRocdkWKxtC0hI0QrLrkFU9JBRIjmTZjThSO58g==
X-Google-Smtp-Source: AGHT+IHPdM+RcBzDCoPZqr+pfi5iJ6HwqJZs12k37A7Uyi+W5GaUTMYzYWkMZQlIAhkrTdq1U0zH9A==
X-Received: by 2002:a17:902:d510:b0:202:4e99:210a with SMTP id d9443c01a7336-2050c3fd772mr5977455ad.6.1724885750454;
        Wed, 28 Aug 2024 15:55:50 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-205152d0358sm3685ad.70.2024.08.28.15.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 15:55:49 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	pedro.falcato@gmail.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
Date: Wed, 28 Aug 2024 22:55:22 +0000
Message-ID: <20240828225522.684774-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240828225522.684774-1-jeffxu@chromium.org>
References: <20240828225522.684774-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add more testcases and increase test coverage, e.g. add
get_vma_size to check VMA size and prot bits.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 826 ++++++++++++++++++++++--
 1 file changed, 759 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index e7991e5fdcf3..4b3f883aae17 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -170,18 +170,30 @@ static void set_pkey(int pkey, unsigned long pkey_value)
 static void setup_single_address(int size, void **ptrOut)
 {
 	void *ptr;
+	unsigned long page_size = getpagesize();
 
-	ptr = mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	*ptrOut = ptr;
+	*ptrOut = (void *)-1;
+	ptr = mmap(NULL, size + 2 * page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (ptr != (void *) -1) {
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
@@ -226,6 +238,21 @@ bool pkey_supported(void)
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
@@ -419,11 +446,17 @@ static void test_seal_invalid_input(void)
 	unsigned long size = 4 * page_size;
 	int ret;
 
-	setup_single_address(8 * page_size, &ptr);
+	setup_single_address(9 * page_size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
-	ret = clean_single_address(ptr + 4 * page_size, 4 * page_size);
+
+	ret = clean_single_address(ptr, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = clean_single_address(ptr + 5 * page_size, 4 * page_size);
 	FAIL_TEST_IF_FALSE(!ret);
 
+	ptr = ptr + page_size;
+
 	/* invalid flag */
 	ret = syscall(__NR_mseal, ptr, size, 0x20);
 	FAIL_TEST_IF_FALSE(ret < 0);
@@ -523,6 +556,7 @@ static void test_seal_mprotect(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -533,9 +567,14 @@ static void test_seal_mprotect(bool seal)
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
@@ -547,6 +586,7 @@ static void test_seal_start_mprotect(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -558,9 +598,14 @@ static void test_seal_start_mprotect(bool seal)
 
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
@@ -577,6 +622,7 @@ static void test_seal_end_mprotect(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -593,9 +639,14 @@ static void test_seal_end_mprotect(bool seal)
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
@@ -607,6 +658,7 @@ static void test_seal_mprotect_unalign_len(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -618,9 +670,14 @@ static void test_seal_mprotect_unalign_len(bool seal)
 
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
@@ -636,6 +693,7 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -646,9 +704,14 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
 
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
@@ -664,6 +727,7 @@ static void test_seal_mprotect_two_vma(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -678,16 +742,26 @@ static void test_seal_mprotect_two_vma(bool seal)
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
@@ -699,6 +773,7 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -719,17 +794,27 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
 
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
@@ -746,6 +831,7 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -758,9 +844,14 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
 
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
@@ -783,15 +874,15 @@ static void test_seal_mprotect_partial_mprotect_tail(bool seal)
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
@@ -846,6 +937,7 @@ static void test_seal_mprotect_split(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -862,16 +954,34 @@ static void test_seal_mprotect_split(bool seal)
 
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
@@ -883,6 +993,7 @@ static void test_seal_mprotect_merge(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -899,9 +1010,18 @@ static void test_seal_mprotect_merge(bool seal)
 
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
@@ -917,6 +1037,7 @@ static void test_seal_munmap(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -928,9 +1049,14 @@ static void test_seal_munmap(bool seal)
 
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
@@ -948,6 +1074,7 @@ static void test_seal_munmap_two_vma(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -962,15 +1089,33 @@ static void test_seal_munmap_two_vma(bool seal)
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
@@ -1018,33 +1163,75 @@ static void test_seal_munmap_partial_across_vmas(bool seal)
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
+		FAIL_TEST_IF_FALSE(prot == 0x4);
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
 		FAIL_TEST_IF_FALSE(prot == 0x4);
-	}
+
+		size = get_vma_size(ptr + 8 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
+		FAIL_TEST_IF_FALSE(!ret);
 
 	REPORT_TEST_PASS();
 }
@@ -1074,9 +1261,11 @@ static void test_munmap_start_freed(bool seal)
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
@@ -1095,6 +1284,7 @@ static void test_munmap_end_freed(bool seal)
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1111,9 +1301,14 @@ static void test_munmap_end_freed(bool seal)
 
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
@@ -1144,12 +1339,15 @@ static void test_munmap_middle_freed(bool seal)
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
 
@@ -1170,6 +1368,7 @@ static void test_seal_mremap_shrink(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1184,6 +1383,10 @@ static void test_seal_mremap_shrink(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else {
 		FAIL_TEST_IF_FALSE(ret2 != (void *) MAP_FAILED);
 
@@ -1199,6 +1402,7 @@ static void test_seal_mremap_expand(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1216,6 +1420,10 @@ static void test_seal_mremap_expand(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else {
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
@@ -1231,6 +1439,7 @@ static void test_seal_mremap_move(bool seal)
 	unsigned long size = page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1249,10 +1458,12 @@ static void test_seal_mremap_move(bool seal)
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
@@ -1264,6 +1475,7 @@ static void test_seal_mmap_overwrite_prot(bool seal)
 	unsigned long size = page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1279,6 +1491,10 @@ static void test_seal_mmap_overwrite_prot(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
@@ -1292,6 +1508,7 @@ static void test_seal_mmap_expand(bool seal)
 	unsigned long size = 12 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1310,6 +1527,10 @@ static void test_seal_mmap_expand(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 8 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
@@ -1323,6 +1544,7 @@ static void test_seal_mmap_shrink(bool seal)
 	unsigned long size = 12 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1338,6 +1560,10 @@ static void test_seal_mmap_shrink(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 12 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
@@ -1352,6 +1578,7 @@ static void test_seal_mremap_shrink_fixed(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1369,6 +1596,10 @@ static void test_seal_mremap_shrink_fixed(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == newAddr);
 
@@ -1383,6 +1614,7 @@ static void test_seal_mremap_expand_fixed(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(page_size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1400,6 +1632,10 @@ static void test_seal_mremap_expand_fixed(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(newAddr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == newAddr);
 
@@ -1414,6 +1650,7 @@ static void test_seal_mremap_move_fixed(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1430,6 +1667,10 @@ static void test_seal_mremap_move_fixed(bool seal)
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(newAddr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == newAddr);
 
@@ -1443,6 +1684,7 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1460,9 +1702,12 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
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
@@ -1474,6 +1719,7 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1488,6 +1734,10 @@ static void test_seal_mremap_move_dontunmap(bool seal)
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
@@ -1503,6 +1753,7 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	void *ret2;
+	int prot;
 
 	setup_single_address(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
@@ -1529,6 +1780,10 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
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
@@ -1690,9 +1945,10 @@ static void test_seal_discard_ro_anon_on_pkey(bool seal)
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
@@ -1864,6 +2120,413 @@ static void test_seal_madvise_nodiscard(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_discard_madvise_advice(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int sealed_advice[] = {MADV_FREE, MADV_DONTNEED,
+		MADV_DONTNEED_LOCKED, MADV_REMOVE,
+		MADV_DONTFORK, MADV_WIPEONFORK};
+	int size_sealed_advice = sizeof(sealed_advice) / sizeof(int);
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = seal_single_address(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	for (int i = 0; i < size_sealed_advice; i++) {
+		ret = sys_madvise(ptr, size, sealed_advice[i]);
+		FAIL_TEST_IF_FALSE(ret < 0);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+	}
+
+	REPORT_TEST_PASS();
+}
+
+static void test_munmap_free_multiple_ranges(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 8 * page_size;
+	int ret;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	/* unmap one page from beginning. */
+	ret = sys_munmap(ptr, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* unmap one page from middle. */
+	ret = sys_munmap(ptr + 4 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr + page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 3 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+	size = get_vma_size(ptr +  5 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 3 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+
+	/* seal the last page */
+	if (seal) {
+		ret = sys_mseal(ptr + 7 * page_size, page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+
+		size = get_vma_size(ptr +  1 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 3 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  5 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  7 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+	}
+
+	/* munmap all 8  pages from beginning */
+	ret = sys_munmap(ptr, 8 * page_size);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret);
+
+		size = get_vma_size(ptr + 1 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 3 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  5 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  7 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+	} else {
+		FAIL_TEST_IF_FALSE(!ret);
+
+		for (int i = 0; i < 8; i++) {
+			size = get_vma_size(ptr, &prot);
+			FAIL_TEST_IF_FALSE(size == 0);
+		}
+	}
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mmap_expand_seal_middle(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 8 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to expand. */
+	ret2 = mmap(ptr, 12 * page_size, PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mmap_shrink_seal_middle(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to shrink. */
+	ret2 = mmap(ptr, 7 * page_size, PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
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
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mmap_overwrite_addr(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to change protection. */
+	ret2 = mmap(ptr, size, PROT_NONE,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+
+	FAIL_TEST_IF_FALSE(!(ret2 == MAP_FAILED));
+	FAIL_TEST_IF_FALSE(ret2 != ptr);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mremap_shrink_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	ret2 = sys_mremap(ptr, 12 * page_size, 6 * page_size, 0, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+	}
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mremap_expand_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	ret2 = sys_mremap(ptr, 8 * page_size, 12 * page_size, 0, 0);
+	FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mremap_move_expand_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+	void *ptr2;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	setup_single_address(size, &ptr2);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+
+	ret = sys_munmap(ptr2, 12 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* move and expand cross VMA boundary will fail */
+	ret2 = sys_mremap(ptr, 8 * page_size, 10 * page_size, MREMAP_FIXED | MREMAP_MAYMOVE, ptr2);
+	FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mremap_move_shrink_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+	void *ptr2;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	setup_single_address(size, &ptr2);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+
+	ret = sys_munmap(ptr2, 12 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* move and shrink cross VMA boundary is NOK */
+	ret2 = sys_mremap(ptr, 12 * page_size, 8 * page_size, MREMAP_FIXED | MREMAP_MAYMOVE, ptr2);
+	FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0);
+
+	REPORT_TEST_PASS();
+}
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -1876,7 +2539,15 @@ int main(int argc, char **argv)
 	if (!pkey_supported())
 		ksft_print_msg("PKEY not supported\n");
 
-	ksft_set_plan(88);
+	/*
+	 * possible reasons:
+	 * - unable to read /proc/pid/maps
+	 * - parsing error when reading /proc/pid/maps,e.g. len is not expected.
+	 */
+	if (!get_vma_size_supported())
+		ksft_exit_skip("get_vma_size not supported\n");
+
+	ksft_set_plan(105);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -1985,5 +2656,26 @@ int main(int argc, char **argv)
 	test_seal_discard_ro_anon_on_pkey(false);
 	test_seal_discard_ro_anon_on_pkey(true);
 
+	test_seal_discard_madvise_advice();
+
+	test_munmap_free_multiple_ranges(false);
+	test_munmap_free_multiple_ranges(true);
+
+	test_seal_mmap_expand_seal_middle(false);
+	test_seal_mmap_expand_seal_middle(true);
+	test_seal_mmap_shrink_seal_middle(false);
+	test_seal_mmap_shrink_seal_middle(true);
+	test_seal_mmap_overwrite_addr(false);
+	test_seal_mmap_overwrite_addr(true);
+
+	test_seal_mremap_shrink_multiple_vmas(false);
+	test_seal_mremap_shrink_multiple_vmas(true);
+	test_seal_mremap_expand_multiple_vmas(false);
+	test_seal_mremap_expand_multiple_vmas(true);
+	test_seal_mremap_move_expand_multiple_vmas(false);
+	test_seal_mremap_move_expand_multiple_vmas(true);
+	test_seal_mremap_move_shrink_multiple_vmas(false);
+	test_seal_mremap_move_shrink_multiple_vmas(true);
+
 	ksft_finished();
 }
-- 
2.46.0.295.g3b9ea8a38a-goog


