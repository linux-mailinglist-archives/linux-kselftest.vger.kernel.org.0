Return-Path: <linux-kselftest+bounces-16738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D72965238
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 23:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097CF1F213F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 21:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93B61BAEF4;
	Thu, 29 Aug 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RUk41ce4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7461BAED7
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967848; cv=none; b=tKJZdPNiQgCyyjw3C4uEtuRvujLC3RrmXRSSB+Dfilojz8OR/ZDJG1nEQLHI/PlHzHudR2gQTrQEuu/Pdha6KLdeTbOt6v2giUSGT22crGk3f00KQer6G3NnKz5jZI377PufrwkX3B2+9t6VTXdcS8KtWsoXRIrH3UFjiiFT8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967848; c=relaxed/simple;
	bh=/IMNJ95SpejvcUBxNqKXzFolTjM9jYB1KqtTg3owDqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE2mv1la46983xZKLESArr/DlnO67inGMnQ3HUV4gI5vHsHtHLyGCsii5k2rJYn9Vjm+Ym5NnmWOzLZTLnwgvCL5SyI+Ro3wtpcFXm5YA5DTeBCaV7o2G8YqaMAOFHzewmltqJxSr5WfSwTgtM2NdS2yg8mY6/eB9HTcTAUN6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RUk41ce4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7144135c842so66438b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724967846; x=1725572646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qngXRj3l1V5w2+Tk+0qChrUc0VPNj8YHKUhOOfdL/8E=;
        b=RUk41ce4GTZcfQNQ5jQ6IdTUD1C9NU5KJHte9pmHqksLBkLUgpHn81h1tHOmnscD4Y
         2BJxb9rJVdrVtRjAIhz1744DgzJ65bR19CiYITJpB8WlvshCSCaWb8Dy1P844XxVCALz
         vz6NnMoRUvKXO0tlXFrGzrsUwyKV9ik/IPRTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967846; x=1725572646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qngXRj3l1V5w2+Tk+0qChrUc0VPNj8YHKUhOOfdL/8E=;
        b=jiwByJxrpUYBAswuYIbh3tqZsW/YEiqzmTzXZNuwOeiaC1Tlyo764XTn/tJZbYJlYT
         JOEcWeXtXFFODsY3Df5qbXu0eC/RKzutBd2jV1hstcHO1SWzkOiWKGpfhAZpeDC0Fq2l
         pI0o/hGHD0/PIhCo97A62bxEVk2RQtq0VjtkEV4LkVDOKAbMpc35NOpFQ4i9G6eCg1b4
         Wh/Ook5X4wloNaSEiuJCM+b40N45T4IirHjDf1z446klHNXqI3GW7wa3dj9vQjB2X4Kb
         /ENJwBSdTnOB5opqFOr1Y36HyKGwOh6XlcmlU3XXrwSr45WwrHCrI3fCtEXbMxT1MAmu
         kjMw==
X-Gm-Message-State: AOJu0YxkGbhUpiF3GpGz/4iV5kzYVgx4Wm0jp5GqdXCz8tb4IZeFT47i
	qSvM6LCXxsAUpC9Q3pVgeTVF02iZ3yfzWGYzv2fHHVbdjcnyHnoGGjBRVgsKSg==
X-Google-Smtp-Source: AGHT+IGw6LhTiqcHA4wOD2hbInscY7fZlLpfvydbHUPkI3AUpW/gqVA9D8kpvdBYJgGdQzekGp3weg==
X-Received: by 2002:a17:903:2350:b0:1fa:a9f5:64b1 with SMTP id d9443c01a7336-2052761fcd8mr1316265ad.3.1724967846304;
        Thu, 29 Aug 2024 14:44:06 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-205152b26b2sm15882985ad.6.2024.08.29.14.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:44:05 -0700 (PDT)
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
Subject: [PATCH v2 2/4] selftests/mm: mseal_test add sealed madvise type
Date: Thu, 29 Aug 2024 21:43:50 +0000
Message-ID: <20240829214352.963001-3-jeffxu@chromium.org>
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

Add a testcase to cover all sealed madvise type.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 108 +++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index adc646cf576c..ae06c354220d 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2121,6 +2121,107 @@ static void test_seal_madvise_nodiscard(bool seal)
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
+		/* verify mapping are not changed */
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
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2142,7 +2243,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(88);
+	ksft_set_plan(91);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2251,5 +2352,10 @@ int main(int argc, char **argv)
 	test_seal_discard_ro_anon_on_pkey(false);
 	test_seal_discard_ro_anon_on_pkey(true);
 
+	test_seal_discard_madvise_advice();
+
+	test_munmap_free_multiple_ranges(false);
+	test_munmap_free_multiple_ranges(true);
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog


