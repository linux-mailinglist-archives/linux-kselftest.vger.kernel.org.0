Return-Path: <linux-kselftest+bounces-38235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E1BB19E31
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 11:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A5318885D2
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073F0215073;
	Mon,  4 Aug 2025 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg1a7Alg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A34242D6F;
	Mon,  4 Aug 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298254; cv=none; b=tWVo5+JWvcSKSPw57fdPZ4Rznw0GoeqeBtuIyZliOkKUPJ+DDKczBNCxpGrobsdv/uR6DBVts1f4zH8UyQz3h5KrKJRqs5Zy9odexs4Q5GTo836uCVki83WCc0qcMnOEoVUGJb8B9ZUE6ioTajCEBSwQbBldSDid4wgvzLbo+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298254; c=relaxed/simple;
	bh=bQ6XJxrd3l0nExUNe/0IQi1uhBICMEx32FAEE1whfIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou18HOXR300F1TA7EJeikZML33H5FfOJiQRY6NOtUeDim3BCAJC+Ou7FkMvczOdTLURb5gdFqXjOxQpav1b9Y866rOJMNUNKnAwXIdwyhQQvmcPqAMnfLXpysN3r+wkECEPtegBEkPZ0C0TA+ad4sKbUnVfwSEXQfi37bXsYZis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg1a7Alg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so714028966b.1;
        Mon, 04 Aug 2025 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754298251; x=1754903051; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acSH/YECNzPqrJpecMNECSlF0Ozf4k+b5plEpSVAioQ=;
        b=Bg1a7AlgW1L0BkaXdtpAiKxMDnaMj1VwS6mL1/LxbIAZkR4DMbqmC5wpFbo2swFFyA
         cPRJdrSFkXhxYB+4+qOKP8HDdd/31w65l4v8bwu32NPSSiIXG9PeGnDzYQ59XfBxTylo
         KTuXt+JurcK/VTyIuDd73B6wm+cHLC8m1tNKBW0P+DW7ZryqfQ9MbawRFhtRocpEbM7L
         6v6tJYVA8h8UojjDxbIwmlV7HtPwcRwOhbb1IsglaF1aj1ys13KOCdbs3CD7ipy9KSGC
         Bf3zqbkB7CkB07RhXAqwHleoi7vy53PLDwUHZJFnjJFth4wZ5E4oPky2BHTk4b76Ng+G
         wKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754298251; x=1754903051;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=acSH/YECNzPqrJpecMNECSlF0Ozf4k+b5plEpSVAioQ=;
        b=qxUAQsGBXlZNQkvH5EnIoKxN7DX/DkrKeHAsY8B8j0QLjlZzWxW7asdWBjNtEtxHyM
         WUc2BDRol4DyrE230Sa3yDr2GszitzOD4I1cJ+mLs552IJWzY8xOeLaE6UcCtfG144H5
         g3502JGxQH8i+IAOd/kNImpqHP+aMsTOG0ZOhSghSUwdZVaW7EF2V2WoguVGcgldBXRH
         LH8UelLInuvg6m147YBYQCaPCJdM7LskcE5e9TYTQbeVJbRN4uK+z9e3qiLenGsZ3WiL
         l9/YQYl0JqGqQEl152kz2gofTcwnnfBiGT+Rn7Nvk/8qAthDVvmSWi9eDYsVVNWtZVfB
         Lqyg==
X-Forwarded-Encrypted: i=1; AJvYcCUOSS/d9BDF99WAKm3+Lb3TFTTxJ7yDhCrBG0HBcIXUf/0MdZR/QwiqBzGcf3NlyUAkh4GZ0eSzXSkb+gc=@vger.kernel.org, AJvYcCXdJu52zHYNKU5biGdbDmH7vVzLNFiIXqwX6EFPtRzzjjrIKprcZE4zfXzG7DHZTdkixzCchb/aQr6MDeL2V0iH@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXtAVHVLJyRsbGcga8rbcYGGPnDhIP//8C4aI3wh0hmUEZ8zv
	/2lH578iMGmMmMwlRs6jGJD0YBUk2iVVfRhMqo17kWXkCpqXf8O2/CKy
X-Gm-Gg: ASbGncun6a6aLrH6LOPqnjvbITcmDxHntAFvX4YpLuaqvx/0no3XV1ErIR1+59cz/1u
	0A9C92wvAXesf5N0uVs6oyZRvXymlXLrjupu0izhPG8/FNVOjqrAjRtS6a4XngN8Z8pkR1USqdq
	URBaFY+nFCfa0w6NorU1p7uRPnYM7bQElL9NirAVp1zi5efb2ekZ8yAHvOEc7qaIRDpiQnA4Xv3
	Cd8cNl99xR5Zf3BydxSFYuScVdune/1ga8ejhv5rPWRR5Ykg/7/siMw4NzF0AznlmBn36VNpvgo
	gwambBnUuDA9bog1Qeb4THv/mxpZoGvjQCpAf6temK84z8bSesJwoHOvOiWETucyvt2BUho9I7E
	mY+1BL+Er6AnBWV4hjjJuqAiBUygO4XBX
X-Google-Smtp-Source: AGHT+IFo1FiK09kxSqh9OOz66lLLPAg3rVm2WiND0BXkRJXNrtebIpCavH4jstjbD8rfqeuDjfzk3Q==
X-Received: by 2002:a17:907:3fa2:b0:adb:2e9f:5d11 with SMTP id a640c23a62f3a-af940174eafmr807904766b.37.1754298250902;
        Mon, 04 Aug 2025 02:04:10 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b77sm702303266b.51.2025.08.04.02.04.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Aug 2025 02:04:10 -0700 (PDT)
Date: Mon, 4 Aug 2025 09:04:10 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	donettom@linux.ibm.com, ritesh.list@gmail.com
Subject: Re: [PATCH v3 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
Message-ID: <20250804090410.of5xwrlker665bdp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
 <20250729053403.1071807-5-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729053403.1071807-5-aboorvad@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jul 29, 2025 at 11:04:00AM +0530, Aboorva Devarajan wrote:
>From: Donet Tom <donettom@linux.ibm.com>
>
>The split_huge_page_test fails on systems with a 64KB base page size.
>This is because the order of a 2MB huge page is different:
>
>On 64KB systems, the order is 5.
>
>On 4KB systems, it's 9.
>
>The test currently assumes a maximum huge page order of 9, which is only
>valid for 4KB base page systems. On systems with 64KB pages, attempting
>to split huge pages beyond their actual order (5) causes the test to fail.
>
>In this patch, we calculate the huge page order based on the system's base
>page size. With this change, the tests now run successfully on both 64KB
>and 4KB page size systems.
>
>Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for splitting THP tests")
>Reviewed-by: Dev Jain <dev.jain@arm.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>---
> .../selftests/mm/split_huge_page_test.c       | 23 ++++++++++++-------
> 1 file changed, 15 insertions(+), 8 deletions(-)
>
>diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>index 05de1fc0005b..718daceb5282 100644
>--- a/tools/testing/selftests/mm/split_huge_page_test.c
>+++ b/tools/testing/selftests/mm/split_huge_page_test.c
>@@ -36,6 +36,7 @@ uint64_t pmd_pagesize;
> 
> #define PFN_MASK     ((1UL<<55)-1)
> #define KPF_THP      (1UL<<22)
>+#define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
> 
> int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
> {
>@@ -522,6 +523,9 @@ int main(int argc, char **argv)
> 	const char *fs_loc;
> 	bool created_tmp;
> 	int offset;
>+	unsigned int max_order;
>+	unsigned int nr_pages;
>+	unsigned int tests;
> 
> 	ksft_print_header();
> 
>@@ -533,35 +537,38 @@ int main(int argc, char **argv)
> 	if (argc > 1)
> 		optional_xfs_path = argv[1];
> 
>-	ksft_set_plan(1+8+1+9+9+8*4+2);
>-
> 	pagesize = getpagesize();
> 	pageshift = ffs(pagesize) - 1;
> 	pmd_pagesize = read_pmd_pagesize();
> 	if (!pmd_pagesize)
> 		ksft_exit_fail_msg("Reading PMD pagesize failed\n");
> 
>+	nr_pages = pmd_pagesize / pagesize;
>+	max_order = GET_ORDER(nr_pages);

There is a sz2ord() in cow.c and uffd-wp-mremap.c.

Maybe we can factor it into vm_util.h and use it here.

-- 
Wei Yang
Help you, Help me

