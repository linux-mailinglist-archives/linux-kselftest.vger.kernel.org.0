Return-Path: <linux-kselftest+bounces-16843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845829668A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 20:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A691F24A39
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466381BD4F4;
	Fri, 30 Aug 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ITR6BqYM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF61BC09A
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040968; cv=none; b=cy9I747jsA3kZa7E+eD7TcpXY+FwDusbaalnOZOl8sQB/WcYZZvld2cV8tasKF7wiSMDwaroGlxBSieDw2Xh4xZXQnlzjguLQvpxN7ysYJqSZUc60By1KM5FCC/WXdX6+gMdqzGzlKKb3KtcbXeTOv2OGJkSBcl+rrMkMSLp4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040968; c=relaxed/simple;
	bh=qbHaaS3yGr3DjDN4L7XsPDq/nqbV5OqUPsiH58Vk8zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXAZXT1SEXHPk355mmV2ThbgjFU1r11o7g1138NVI5HuqoDHScztKpuFlmqLjYsIpyjPZmQTIX2UJKSV3qBPCbskggj7LNN1UZ3PF544N/+pqduDc/mgphf62A7nN5wE+p422+89Y3fDfZkRjbl5fJqBxmtLZYT5B4Z6GZ9WT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ITR6BqYM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7143677f81bso78839b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725040966; x=1725645766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG4FqLRVN7QRhtpNFNyTot11ECNVu7XseshInxYcE2s=;
        b=ITR6BqYMGlnu1rub5olQ8qlG6jVEcKEYmrFD/OCc0dLI/Q6u3ZqjnwrAvk+7LIEGt/
         ngwz4pftZ93dibBCdt78nNSR+SblAVXx7+AQIXRQTuKwUnSQMo2WJX+XYWAVt70UIeoF
         gZ8Iba8XvcTbQmgUChiM70YVCVu7/JMCZXw9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040966; x=1725645766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DG4FqLRVN7QRhtpNFNyTot11ECNVu7XseshInxYcE2s=;
        b=NsraxxB13najrzkLrjPMIaG+zNaH1VOLc+7j4lspwaH4m9Gfsn2qlv20hgkWBeGGHk
         cNj+8GsVLR0HtMg/42RjKwSgoX8ZV9yvyjn7KKtgJzyPYkhYLaLdUAZCqyVsUyiUNN3N
         tbN9BVZUgvC69cdATCsRYIS/aL5dFIm6gLZwbOcrVU0y8q8Noq78xlA6kynfPnHqrmIQ
         5jg+hOuVfvFJpIFLjQC1908XSbAcuYGMWB1oWV60KFzCxkZoy1T9MGO2OtsF+aU1152v
         LYoHi1jwiAFD9OPnHgqXheESuZlPNmZkH+hezSIChun7ClF7sZhqEtZSQB8qlUB0zx0h
         6tyg==
X-Gm-Message-State: AOJu0YxbBhRetImqwkKwP2bbHPwprfQGW8fEiNwV0LFkNr5+PRwsLe0U
	bKazpNGf3GtBXZqyEFQd9Rx1E3VX+66rZjEnwRtgpyz2CqYdq55Y9ZZuHlOZYQ==
X-Google-Smtp-Source: AGHT+IFFGS+07CU8IBOM66L6oaRfXsetQe4pywdwlw95pQS95a2NVA/2F4lCrT4hvMrc8/Ywtkgvzg==
X-Received: by 2002:a05:6a21:6d8d:b0:1c3:c1d0:226 with SMTP id adf61e73a8af0-1ccee48ec07mr1706297637.7.1725040965460;
        Fri, 30 Aug 2024 11:02:45 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-715e55769c6sm3051663b3a.33.2024.08.30.11.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 11:02:45 -0700 (PDT)
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
Subject: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Date: Fri, 30 Aug 2024 18:02:36 +0000
Message-ID: <20240830180237.1220027-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240830180237.1220027-1-jeffxu@chromium.org>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add sealing test to cover mmap for
Expand/shrink across sealed vmas (MAP_FIXED)
Reuse the same address in !MAP_FIXED case.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 126 +++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index e855c8ccefc3..3516389034a7 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2222,6 +2222,123 @@ static void test_munmap_free_multiple_ranges(bool seal)
 	REPORT_TEST_PASS();
 }
 
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
+	/* use mmap to expand and overwrite (MAP_FIXED)  */
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
+	/* use mmap to shrink and overwrite (MAP_FIXED)  */
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
+static void test_seal_mmap_reuse_addr(bool seal)
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
+	/* MAP_FIXED is not used, expect new addr */
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
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2243,7 +2360,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(91);
+	ksft_set_plan(97);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2357,5 +2474,12 @@ int main(int argc, char **argv)
 	test_munmap_free_multiple_ranges(false);
 	test_munmap_free_multiple_ranges(true);
 
+	test_seal_mmap_expand_seal_middle(false);
+	test_seal_mmap_expand_seal_middle(true);
+	test_seal_mmap_shrink_seal_middle(false);
+	test_seal_mmap_shrink_seal_middle(true);
+	test_seal_mmap_reuse_addr(false);
+	test_seal_mmap_reuse_addr(true);
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog


