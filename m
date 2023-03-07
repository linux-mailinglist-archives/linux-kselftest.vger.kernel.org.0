Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E666ADBBD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCGKXU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 05:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCGKXL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 05:23:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B81ACF3
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Mar 2023 02:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678184540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/IPZqHOoz7jiojxziiZXAo+iRRmEKFV9o6Kto64+sI=;
        b=f81QqDRLBdd/FiX+7iosalrrfkwgHQRileyQsbAlWoCR1WmKAY4U/r6sWukc79WS5JrUuw
        4uPHCveMBZ7VEDybQ99w8Qa6I9FHB+wLTgB+j7jHpgdoxIlVTWArI+tagXYMSNGkGK5iS8
        FKXglHPgiameAOEpmp/uQEgKSZd0RFM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-J-ph8L4yM0yfdKj6PS4YCQ-1; Tue, 07 Mar 2023 05:22:19 -0500
X-MC-Unique: J-ph8L4yM0yfdKj6PS4YCQ-1
Received: by mail-wr1-f72.google.com with SMTP id by11-20020a056000098b00b002ce45687cbdso1680795wrb.12
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Mar 2023 02:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184538;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/IPZqHOoz7jiojxziiZXAo+iRRmEKFV9o6Kto64+sI=;
        b=T+zz50FtXsP7q44xtxeWOTeq3t7X7trso2Liwwy3pNqOJuXtfxmUs5z/Q+VCNUsOkG
         9uCajo/2CuAyibu/a9GPvsfTtoTDLdrlVUPybPgWh9Tivms7VwY7bXGylLHs+PhOO42E
         o3fawjuL9eBE2Z8yAIf8bdgExppavxxupzADCyT5/MWiCB8AZtGYLCjXsrTgVXcj7V1L
         wZJPhVKIkR/KKxmNEFmqx4Po0DUmsJE4p+8uB5nVldJQ0MS2oC62xspy8neI2fQyzzBE
         JlNg5WIVB9rTqb5Mc64PO4SpO+NtkyQqNXmbj3/uuSeEd713+HIf+wX7SoLiAU2jBVaX
         Xx9A==
X-Gm-Message-State: AO0yUKVs6kLGWJA56qGTIWhd13tKRbOuSLqMoxhbzF0p+Y4qf1gmpMWg
        ZZohOYJxoqg1C/ySLTkl81YXylE6nkbKP+OAi5z+XSKZsanN+h9WWtmbGNi4WPOQk2iLYy/sibE
        iEha8Vj/CgHSBg6mKqK5GQ5Iu19cI
X-Received: by 2002:a5d:5452:0:b0:2ce:50a9:6d8e with SMTP id w18-20020a5d5452000000b002ce50a96d8emr6603683wrv.20.1678184537904;
        Tue, 07 Mar 2023 02:22:17 -0800 (PST)
X-Google-Smtp-Source: AK7set/i5Nv1U3NOAuCbE4btJ9ZAiOioRnHyw6o9C90eWaBZTs9BfvSsigkdVvJPs3CCoLRzMZNrMw==
X-Received: by 2002:a5d:5452:0:b0:2ce:50a9:6d8e with SMTP id w18-20020a5d5452000000b002ce50a96d8emr6603670wrv.20.1678184537566;
        Tue, 07 Mar 2023 02:22:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:a100:e20:41da:c49b:8974? (p200300cbc707a1000e2041dac49b8974.dip0.t-ipconnect.de. [2003:cb:c707:a100:e20:41da:c49b:8974])
        by smtp.gmail.com with ESMTPSA id a17-20020a056000101100b002c553e061fdsm12270849wrx.112.2023.03.07.02.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 02:22:17 -0800 (PST)
Message-ID: <9ce5434e-4c19-cb34-d3fa-99738c265b03@redhat.com>
Date:   Tue, 7 Mar 2023 11:22:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] selftests/mm: fix split huge page tests
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Zach O'Keefe <zokeefe@google.com>
References: <20230306160907.16804-1-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230306160907.16804-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06.03.23 17:09, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Fixed two inputs to check_anon_huge() and one if condition, so the tests
> work as expected.
> 
> Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 76e1c36dd9e5..b8558c7f1a39 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -106,7 +106,7 @@ void split_pmd_thp(void)
>   	for (i = 0; i < len; i++)
>   		one_page[i] = (char)i;
>   
> -	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
>   		printf("No THP is allocated\n");
>   		exit(EXIT_FAILURE);
>   	}
> @@ -122,7 +122,7 @@ void split_pmd_thp(void)
>   		}
>   
>   
> -	if (check_huge_anon(one_page, 0, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
>   		printf("Still AnonHugePages not split\n");
>   		exit(EXIT_FAILURE);
>   	}
> @@ -169,7 +169,7 @@ void split_pte_mapped_thp(void)
>   	for (i = 0; i < len; i++)
>   		one_page[i] = (char)i;
>   
> -	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
>   		printf("No THP is allocated\n");
>   		exit(EXIT_FAILURE);
>   	}

Hard to read. It should probably be "get_huge_anon()" to then check for 
the value in the caller manually. Negative value could be used as an 
indicator for an error obtaining the value.

Anyhow, was briefly confused about the 4 ("magic value" also apprearing 
in "size_t len = 4 * pmd_pagesize;") but it seems to be the right thing 
to do.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

