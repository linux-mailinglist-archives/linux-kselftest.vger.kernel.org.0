Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3F17224B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjFELgv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFELgu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 07:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A4EA
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685964961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYARy8HibsJRuVCsxN/w1opXBP1A7Z939kJomrPeo3k=;
        b=gx4+vO5yukSO1rHywesm9BglIwuDitnv5aHOAz/JdDAZEmHmFi062i9Ag/BEpoDFiCHf2e
        GyYbEXPU3NkinCbbVHle0LBnEx1H8PdKDCtxHz8a7ghK17EQG0Q/5bDmL2iFH697T1hJxO
        KyUzoZPnyWDTJslsoyH67IpvM/7MZvo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-oADSrv4sMZCipmSr0Uj1ig-1; Mon, 05 Jun 2023 07:36:00 -0400
X-MC-Unique: oADSrv4sMZCipmSr0Uj1ig-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f5fa06debcso28210305e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 04:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964959; x=1688556959;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYARy8HibsJRuVCsxN/w1opXBP1A7Z939kJomrPeo3k=;
        b=VyPZKUx4OoRNDD4n0/UnYBjPWfZ7h2EHhprpmzTD8jMhWxS/IniBUaofkzPFdtL4vf
         uDatxbnsxL4bAKs2oTb/EoN8MpXZ/8nHt/JY3fErWrDe/YQj/JJrJ72n6xbS2RjQWuNe
         IolZakjHrF23BSjEQGwXfVlreymMLUF9EDzqZd8KSJau0XrKOfs1fovEXfRmi9JKZZbB
         IfrwyRPuEOoozDrpl6WZBxVwfCPiQbmghoAOngmIBYJQ5p1hD8r1y+HbwiMvBlalUXcs
         OZNquVmAZNlQY+aG0eDCSRXHuYEl/YrpuQ/jSwOP/sZ4rQSAZ2Cmzst9RP2wI64sLh1e
         pxSg==
X-Gm-Message-State: AC+VfDzhxASn137orveJG4TNv4fgv7lozgzlyL/xdaPY0X/9dxdAzWrv
        OSVe++ld1ZVDFt36gPucG/AwUYqlToTYjvq4u8U7l8J+7Vrdz+C3mf8IM9JPr1VeUjLCl/z3o4H
        +Bx4UEbOSw3yo7X3YmtBfBr7qARgRU7HjxPQD
X-Received: by 2002:a1c:7208:0:b0:3f7:4961:52ad with SMTP id n8-20020a1c7208000000b003f7496152admr2513975wmc.3.1685964959154;
        Mon, 05 Jun 2023 04:35:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kqLKmA6Uaca3flnGm41wNf/22uPch19FG6pqRuK+wk+si/v/bT8+LCR0C/BaP0urg5ol3tQ==
X-Received: by 2002:a1c:7208:0:b0:3f7:4961:52ad with SMTP id n8-20020a1c7208000000b003f7496152admr2513963wmc.3.1685964958842;
        Mon, 05 Jun 2023 04:35:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:8f00:ed9:16b8:4e22:5820? (p200300cbc7378f000ed916b84e225820.dip0.t-ipconnect.de. [2003:cb:c737:8f00:ed9:16b8:4e22:5820])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b00306415ac69asm9435530wrt.15.2023.06.05.04.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:35:58 -0700 (PDT)
Message-ID: <0764cf72-26fe-627b-f56c-b0d2629bc9e3@redhat.com>
Date:   Mon, 5 Jun 2023 13:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 02/11] selftests/mm: fix unused variable warnings in
 hugetlb-madvise.c, migration.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-3-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230603021558.95299-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03.06.23 04:15, John Hubbard wrote:
> Dummy variables are required in order to make these two (similar)
> routines work, so in both cases, declare the variables as volatile in
> order to avoid the clang compiler warning.
> 
> Furthermore, in order to ensure that each test actually does what is
> intended, add an asm volatile invocation (thanks to David Hildenbrand
> for the suggestion), with a clarifying comment so that it survives
> future maintenance.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/hugetlb-madvise.c | 8 ++++++--
>   tools/testing/selftests/mm/migration.c       | 5 ++++-
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
> index 28426e30d9bc..d55322df4b73 100644
> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
> @@ -65,11 +65,15 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
>   
>   void read_fault_pages(void *addr, unsigned long nr_pages)
>   {
> -	unsigned long dummy = 0;
> +	volatile unsigned long dummy = 0;
>   	unsigned long i;
>   
> -	for (i = 0; i < nr_pages; i++)
> +	for (i = 0; i < nr_pages; i++) {
>   		dummy += *((unsigned long *)(addr + (i * huge_page_size)));
> +
> +		/* Prevent the compiler from optimizing out the entire loop: */
> +		asm volatile("" : "+r" (dummy));
> +	}
>   }
>   
>   int main(int argc, char **argv)
> diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
> index 1cec8425e3ca..379581567f27 100644
> --- a/tools/testing/selftests/mm/migration.c
> +++ b/tools/testing/selftests/mm/migration.c
> @@ -95,12 +95,15 @@ int migrate(uint64_t *ptr, int n1, int n2)
>   
>   void *access_mem(void *ptr)
>   {
> -	uint64_t y = 0;
> +	volatile uint64_t y = 0;
>   	volatile uint64_t *x = ptr;
>   
>   	while (1) {
>   		pthread_testcancel();
>   		y += *x;
> +
> +		/* Prevent the compiler from optimizing out the writes to y: */
> +		asm volatile("" : "+r" (y));
>   	}
>   
>   	return NULL;

With the asm, I think the "volatile" might be completely unnecessary. 
But it doesn't hurt.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

