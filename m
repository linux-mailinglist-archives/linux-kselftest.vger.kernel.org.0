Return-Path: <linux-kselftest+bounces-38633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFEEB1F60B
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 21:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3223ADE53
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBAB223DF5;
	Sat,  9 Aug 2025 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf7v80Q/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF4204C0C
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Aug 2025 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754768537; cv=none; b=tuLjULVZ5Ski4FzXMZzrli9l/ZfF3a2iwp9Uowx83yrGa4dbcHod1TjQc1bNz6g9YF1PgG8LhQupVvgpVkfELIzHVE5GLrHGMolGXmycrBYQ2bRNHDKk2yXAQ8YoT2VoUIaJjy1dGfAyHQUs6yCcF8yg2j8WUuddNALe6eIAaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754768537; c=relaxed/simple;
	bh=LuvHALPrug4dgWcEcMy+PvWERvKXn3egXi0VaVDGdT8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KWTzXz4zrWxcl15gJANYx4HW/w/wumCG/xeTWTssUTrQUFl/Hlt7mEtwr1YShCaz0czJ+MnOUWJp7kokL/KaLAhisHGiQg7KYy/kW0tcz6jx+mlCzmVZS2Bpm8I9zh/hdm8ZyPDntSOG53UIb39LeEYijP3kDnSIV+TxuMbRgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf7v80Q/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af968aa2de4so603672366b.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Aug 2025 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754768534; x=1755373334; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic3K7UCH8w0cHNlR6jBGkNggzwSb+Jje246b5cUnyGw=;
        b=bf7v80Q/rVTQxyXy0GR5LwbhLukb8Bi9gAluZ5cizDzgYpTwHJ/Nif3I2NGiF4KonU
         zC2Cdys169PiiktegXxFcA2xbZD8YkC4K1FfA2e0yuoBVbSQKA8OU3i7d+rfgXtgJSWE
         sscaoa91Xx8E3NEEUCMiIUGAKHqv/Z6p0nPdAVTRp8G3Q+g0MB+GjgYsAIAhXoOAFrf6
         1GIJbHK6EsgYRRi2g+2C/GFHp1ic1rzYMGSiwoSFue4NvJcbaXFYQyIuK3HsleqPdfF8
         0UMGQt3naX68DkzWqo/e8dYz0rcUP6HSmnZ3NcjciBfuVF/QWKpW+fYLI8udgHaYz2/i
         mOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754768534; x=1755373334;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ic3K7UCH8w0cHNlR6jBGkNggzwSb+Jje246b5cUnyGw=;
        b=H5DI6XqCIQLCP100n8EHc7i/jbFG7Bv+wCsRrcfkZuI+kDQICm0KEllzqucQn3jbyy
         agCWwkijji6oL20J6bWkPOVg0v4gFKEiVv+RuerNYeqiJ325OxM/jNKvdLsIVfVDBAM2
         /IVqAqJ22mdcgrhaiU8MyfrZzSZTHSJev1Y7M2jW3eEY1xef5evEZ7iCAv87UIX8G0t2
         giG2dLiOfv+bqG7KmV1/Bf7sV5GntveZ9ciyfwpVoGaO4BDuFAuJxHQyJl3WDiN54485
         HC3fKvDrAVe9+HO0cAWWIwrcHZc58RFKwhdOeCeMdDJnhVGBpZU58ISvi7wctDwdPY0Y
         WcIg==
X-Forwarded-Encrypted: i=1; AJvYcCXxjjqe+1+lf9qJB0eR4vwFSNZsVkfwU8nLpehQJyRR1qbl7RbDBl2v2j+y31CYmEvaHW8m3ZGj/7ZZkX2Zg9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl77IezgfyFhi5Y4DRDqnypjt5hFJuD6S74KlHFLFSrUAxq3zd
	sHp6bTt4pZ5ZbetQj9t6pesfxnpY0TbgRDK1HMF/OYSL7sUFw1DxgujxlkW2yjCj
X-Gm-Gg: ASbGnctfeL/Okeb5UeTJ/FryEi33loZpf8d3d+r4nurMp1fGyIOuuQw29FOheWKXshV
	gB94pWOsQXik7Bk+l5Xnmenwnk3NQtTOzpXoc8gD+0xnAlp59ijVNuSloOjvBxZfTzpgHWV9xjX
	yRqoIKDi50PzxhoBPz/IVtJfbzf3jiWCiTDCM1xAZ/Z8z+J0IG3XdOlQjLlfUOJOSzTbWb8tNAi
	i1pkv68u0VRWa0erwOFtHEQ3Ti5WFbPyfFv2PL55QYkA8RjQiEX1kIZhzdG8Hp/JUaQjs0fiV4a
	+eDPKPJ1DijU5wp602jnVZQAtbObOC8WgT9sHlOmZERCQK0yx05BiPLoonsWeiMtcffV6ogT0fi
	N8HLg1GxzOZIoM3PTKKbREPhVHYAlC/IP
X-Google-Smtp-Source: AGHT+IE7x1UXlTbQaKb/FHpNY+rq/S0rmCS/wR19xs1S9zT+TQJ9dYKv7J4ktAbnBOq5oVMDmgkn9w==
X-Received: by 2002:a17:906:fe05:b0:ade:4339:9367 with SMTP id a640c23a62f3a-af9c648edcbmr748294866b.26.1754768533931;
        Sat, 09 Aug 2025 12:42:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm1711636766b.39.2025.08.09.12.42.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Aug 2025 12:42:13 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Donet Tom <donettom@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [Patch v2] selftests/mm: do check_huge_anon() with a number been passed in
Date: Sat,  9 Aug 2025 19:42:09 +0000
Message-Id: <20250809194209.30484-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Currently it hard codes the number of hugepage to check for
check_huge_anon(), but it would be more reasonable to do the check based
on a number passed in.

Pass in the hugepage number and do the check based on it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>

---
v2:
  * use mm-new
  * add back nr_hpages which is removed by an early commit
  * adjust the change log a little
  * drop RB and resend
---
 tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 5ab488fab1cd..63ac82f0b9e0 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -105,12 +105,12 @@ static char *allocate_zero_filled_hugepage(size_t len)
 	return result;
 }
 
-static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, size_t len)
+static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hpages, size_t len)
 {
 	unsigned long rss_anon_before, rss_anon_after;
 	size_t i;
 
-	if (!check_huge_anon(one_page, 4, pmd_pagesize))
+	if (!check_huge_anon(one_page, nr_hpages, pmd_pagesize))
 		ksft_exit_fail_msg("No THP is allocated\n");
 
 	rss_anon_before = rss_anon();
@@ -141,7 +141,7 @@ void split_pmd_zero_pages(void)
 	size_t len = nr_hpages * pmd_pagesize;
 
 	one_page = allocate_zero_filled_hugepage(len);
-	verify_rss_anon_split_huge_page_all_zeroes(one_page, len);
+	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
 	ksft_test_result_pass("Split zero filled huge pages successful\n");
 	free(one_page);
 }
-- 
2.34.1


