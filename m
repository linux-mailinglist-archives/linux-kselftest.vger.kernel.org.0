Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783D66ACCA5
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 19:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCFSbw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 13:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCFSbv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 13:31:51 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945375C120
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 10:31:25 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y11so11460848plg.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Mar 2023 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678127483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iizvtg68lyx86Kw9qy0rXsUsJPZUaHrLw5tLos/TKTM=;
        b=d6W3uSP4iBw3OI2cevFx2OYlEKgarZeDqsRFR0NhhlohwME9gwJEG3Mx8E4NVsF5VP
         WrTyb488Sl1W2AOCT8GG1jtVTBVivzP5hzi5DslbpGjrnpTkf6K4n8n5pWZ48qCH9Ejn
         f5J0o9MB/KoFNmyKHsCzkhUIK/4jt4eto18kJlpVMPqWVerWzwk8v9uWa6A6TpgDIj2S
         mYE1w1QkxveDdbG4Nb8zQzGoxSXCNFR6Fn6SXvrpjqTArX/H/vshlGP69KJZpO7wEcqQ
         g3NJntBLCBR30hMz1iV2EdRme2bfZJVPrwuY/MIN/SDH2BqCVFXd1rT9nqEUTT5NXHXw
         pjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678127483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iizvtg68lyx86Kw9qy0rXsUsJPZUaHrLw5tLos/TKTM=;
        b=NoXks0rbSKAiVzGnz1Xxfh0bxn9XvMJcbJDcP9ySCDYmPwqYAYZDffwx/CLtw8Vx92
         qRqCiZWhkUmDQQTTkRwp2FWNX9AnkO0loWHfOilFYwA/7CrP6ypx1vW0j0ecYgZEhXYm
         qYpabTD2xEDwCe6I41NVpixZzZhVW5ClwAS8gLySRqk+VuTFeB0Oe96/XwoJdYsJ2Q+L
         Vm3J2PcGRn5ImhhfUt0M2acNK0HItB3YKcradSq4x9JvgQUUcb9Wq06aUujJUqXcc/R4
         U1MlNHlPWk+phfcuQKzSNcT00oF8bKk8ALRrldu9X4/UO6NPuc5bgpgvKbyJ7Qk78mDA
         Y76Q==
X-Gm-Message-State: AO0yUKX8Pvqa3caAlrKkoLjyZETnSrOcSLUfAgAs5UrfQlALuErRYEol
        BNJ3jpg2fFM63UH8T8uJ/JInk7z0CkaXy0BAJ/rfXQ==
X-Google-Smtp-Source: AK7set/9nLGBsaVaVqUCwr4yTobByniqdrZzZpR0yJ13wdZ24m7Lzy6HSWTyA1Jkij4pbT2nvOouWw==
X-Received: by 2002:a17:903:6cb:b0:198:af50:e4e6 with SMTP id kj11-20020a17090306cb00b00198af50e4e6mr848900plb.12.1678127483181;
        Mon, 06 Mar 2023 10:31:23 -0800 (PST)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b0061998311344sm4392559pff.211.2023.03.06.10.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 10:31:22 -0800 (PST)
Date:   Mon, 6 Mar 2023 10:31:19 -0800
From:   Zach O'Keefe <zokeefe@google.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/mm: fix split huge page tests
Message-ID: <20230306183119.igudzgqj5bemqkox@google.com>
References: <20230306160907.16804-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306160907.16804-1-zi.yan@sent.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mar 06 11:09, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Fixed two inputs to check_anon_huge() and one if condition, so the tests
> work as expected.
> 
> Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> ---
>  tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 76e1c36dd9e5..b8558c7f1a39 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -106,7 +106,7 @@ void split_pmd_thp(void)
>  	for (i = 0; i < len; i++)
>  		one_page[i] = (char)i;
>  
> -	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
>  		printf("No THP is allocated\n");
>  		exit(EXIT_FAILURE);
>  	}
> @@ -122,7 +122,7 @@ void split_pmd_thp(void)
>  		}
>  
>  
> -	if (check_huge_anon(one_page, 0, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
>  		printf("Still AnonHugePages not split\n");
>  		exit(EXIT_FAILURE);
>  	}
> @@ -169,7 +169,7 @@ void split_pte_mapped_thp(void)
>  	for (i = 0; i < len; i++)
>  		one_page[i] = (char)i;
>  
> -	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
>  		printf("No THP is allocated\n");
>  		exit(EXIT_FAILURE);
>  	}
> -- 
> 2.39.2
> 

Thanks Zi -- I had this in my TODO-log, but was slow to get it it -- apologies
for the clearly buggy code, and thanks for the cleanup. I've ran these tests to
confirm (as I should have previously), and it all looks good. Can have either my

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Tested-by: Zach O'Keefe <zokeefe@google.com>

I don't know which is more appropriate.

Best,
Zach

