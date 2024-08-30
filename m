Return-Path: <linux-kselftest+bounces-16842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40069668A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 20:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C4D1F24A03
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B34E1BD004;
	Fri, 30 Aug 2024 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hncTTrDz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFFC1BC075
	for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040967; cv=none; b=kVWW/yrmZRMX13N73HF6Zm9bGwcQkC9zzJh56oXgwLBQm//nYGnKiQi6aAPsSpF61kX1/yfIGRW4I3J2P9qW+iIbcNnaLTfU+s/fBiscFx51mdyHzBLmpW6Oo3c4HntT0jbSmZiiBqz63xjPVqeratRKz5Cw5CGxbak2wRePqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040967; c=relaxed/simple;
	bh=k9Yj8N7+CNONduZGW66WtwLdIDyZHwlEArsp28UOTIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5P7Pc2dLS6K60F24ngu2r8U80oMl08G/6MBKNofO10uPxv55v/RtpRTJVP2xQSqLTZARTAeARsYHv9Gwyu4ltOkf4VS4kfAljW7rm2W5LGn+ZDN6i/nACxYTB2rLP8WmuQGDhOXWHvN243P3JJARMmW/yeI2lCtmcUy6t5LdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hncTTrDz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3cc6170eeso330597a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Aug 2024 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725040965; x=1725645765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKGNPxNsYKipWJTu2FnzfGVLgyBodzOHMPjLCFGxD/E=;
        b=hncTTrDzxIn+QoNsX8+QdNmvId2/WlUak+Sscn1FTY+HOI/NO88DOFHoayCOn7ehhk
         2cVY5hvqKN3cANsn7AdKquRfF2RSnkL1aIoooXX1eDXAA4St2DNKEO6ayDpg9NYSJPJx
         yMJ/6UDWLl5Co44xHNyKyBGwXbzEic3ICBcrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040965; x=1725645765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKGNPxNsYKipWJTu2FnzfGVLgyBodzOHMPjLCFGxD/E=;
        b=bG2p+DgzRiHQ+w76R5JgKISnkF2qb5CuYL1ap8sWbEXiefKJYKzCN8+HgPYFNMMODp
         paluuEe1xSeeCgzyBc0MZkwyfKF71OfOV0Wi2HzQg3Je6Ei7dKboiHYRbwsxusXWzMcx
         tu2Zpn1tFTBRYQMoLqhpSBgr3sJnWEH7/O1JkMiAj18lYqXybMxE+KvvWa56p/+9QNMx
         8UvdgDYfGBC91u10WRLOWlFh4gM43R6g9TuPLQHzn8+p1lBKEfZLVL6DwEcSjcOI3WXw
         KsW2mw0fOhOKU3aNasuIDWGs7tADu+xTwShHLzK2tvBGQDM4j6FcT9U8RcQ9QH7ymm8f
         kgjA==
X-Gm-Message-State: AOJu0YwQ20Br2yH8MQ8HoZzkwcopJK28yLs3Z/8doHKpxQMhSoHTm0Z+
	eKVkLYYFNez71ptelpEc0OBF18XTvuShcQfIqwZWII3Bmhaeze8/AasVPrY9Wg==
X-Google-Smtp-Source: AGHT+IEihnCD63EfKi0DOVXqIMhOWH4VJANKaavsJJCvNs5Q8uboJudceTAmj4oEGAUcSNs9tNCDsA==
X-Received: by 2002:a17:90a:d904:b0:2d3:da94:171 with SMTP id 98e67ed59e1d1-2d86b8c3a42mr1724919a91.5.1725040964619;
        Fri, 30 Aug 2024 11:02:44 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d8445d5bb0sm6770604a91.1.2024.08.30.11.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 11:02:44 -0700 (PDT)
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
Subject: [PATCH v3 3/5] selftests/mseal: munmap across multiple vma ranges.
Date: Fri, 30 Aug 2024 18:02:35 +0000
Message-ID: <20240830180237.1220027-4-jeffxu@chromium.org>
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

Add a test to munmap across multiple vma ranges.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 80 ++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 6d77dc9b5442..e855c8ccefc3 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2147,6 +2147,81 @@ static void test_seal_discard_madvise_advice(void)
 	REPORT_TEST_PASS();
 }
 
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
@@ -2168,7 +2243,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(89);
+	ksft_set_plan(91);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2279,5 +2354,8 @@ int main(int argc, char **argv)
 
 	test_seal_discard_madvise_advice();
 
+	test_munmap_free_multiple_ranges(false);
+	test_munmap_free_multiple_ranges(true);
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog


