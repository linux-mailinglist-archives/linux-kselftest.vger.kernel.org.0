Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFD575246B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjGMN5w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjGMN5v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A365D1FFC
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689256616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7slRFqXzj+fIwUfWpHgJOEMlp6jejIeFSooLIetSLk=;
        b=VWGGG9G9iRr6CXdSdy9z9qXNkl9E+HRcKv0QM+fOiO9brbVr0K3f159mthYHswVqIsYcop
        2AUGH46gRUSGUeCQASF0owWBOokNV2u2vEZK84vlm2/S0bPKaL/UvHI5Hh52KZSNiHjC/C
        /cbOE64aVEVlT0dheLMSV8+zhaV0MBM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-VOhQH7vyOh6xGBrbZvNbfA-1; Thu, 13 Jul 2023 09:56:55 -0400
X-MC-Unique: VOhQH7vyOh6xGBrbZvNbfA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fc08035926so8238585e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 06:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689256614; x=1691848614;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7slRFqXzj+fIwUfWpHgJOEMlp6jejIeFSooLIetSLk=;
        b=d1QJkwcLMbZ0okXGOA+KiBWdD647ReBLYb7Gw2iDGNF4IdtioL+qXb5kOXSjtlop//
         IEoKwgHjHig+5w76Cm0StLDoqKh4w6BciFbedbmC5dRVGXECf+Mwop4DFj4z7mIkw1L8
         aZfob+iAJ1DbJiMXZGlqipHUBWhCN0iq2sljvL61CoKb3Mwx9LYTc7yf4qyEKTrdZMjf
         3PlsW1mw2FraUVkUalq2p1sC9O+VSeuZHQPvFUaULAi5crPmDriyjlX4yfar4ZFhEbYs
         c2lRvw10qB/Bf1q9s08sAeylcVqP5ynMbA+ESNUmzWhmC8Stnrdzys3Bn52TKdQs1snD
         s4Tg==
X-Gm-Message-State: ABy/qLZJFo9H0sIF+BMmAkXlp+j2odxkxLmfBDMCWVilbGVyXckw4rl5
        5Qyg1hNZ0Vl6qYzZltPF43XB4Jp+x72R5Eaa5NX2iR3MBvf9miijTC2rx4dL9Ry4ag8meZ6HldV
        Vr0J8kjlCK7JX7o47RqrPqur5omK5
X-Received: by 2002:a05:600c:5187:b0:3fb:b18a:f32d with SMTP id fa7-20020a05600c518700b003fbb18af32dmr4313867wmb.17.1689256614495;
        Thu, 13 Jul 2023 06:56:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE118GN9dvVisQic4LNU75RVuVsDjt1KGEsf35PRM3rckhrWuEAXEBr4f3RPD+JkiJS5nwlWA==
X-Received: by 2002:a05:600c:5187:b0:3fb:b18a:f32d with SMTP id fa7-20020a05600c518700b003fbb18af32dmr4313854wmb.17.1689256614159;
        Thu, 13 Jul 2023 06:56:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003fbc9d178a8sm18501864wmc.4.2023.07.13.06.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 06:56:53 -0700 (PDT)
Message-ID: <cf3c237e-69c8-dd6e-26fc-fe19de910813@redhat.com>
Date:   Thu, 13 Jul 2023 15:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/9] selftests/mm: Skip soft-dirty tests on arm64
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-4-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713135440.3651409-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13.07.23 15:54, Ryan Roberts wrote:
> arm64 does not support the soft-dirty PTE bit. However there are tests
> in `madv_populate` and `soft-dirty` which assume it is supported and
> cause spurious failures to be reported when preferred behaviour would be
> to mark the tests as skipped.
> 
> Unfortunately, the only way to determine if the soft-dirty dirty bit is
> supported is to write to a page, then see if the bit is set in
> /proc/self/pagemap. But the tests that we want to conditionally execute
> are testing precicesly this. So if we introduced this feature check, we
> could accedentally turn a real failure (on a system that claims to
> support soft-dirty) into a skip.
> 
> So instead, do the check based on architecture; for arm64, we report
> that soft-dirty is not supported. This is wrapped up into a utility
> function `system_has_softdirty()`, which is used to skip the whole
> `soft-dirty` suite, and mark the soft-dirty tests in the `madv_populate`
> suite as skipped.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/madv_populate.c | 18 +++++++++++++-----
>   tools/testing/selftests/mm/soft-dirty.c    |  3 +++
>   tools/testing/selftests/mm/vm_util.c       | 17 +++++++++++++++++
>   tools/testing/selftests/mm/vm_util.h       |  1 +
>   4 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
> index 60547245e479..5a8c176d7fec 100644
> --- a/tools/testing/selftests/mm/madv_populate.c
> +++ b/tools/testing/selftests/mm/madv_populate.c
> @@ -232,6 +232,14 @@ static bool range_is_not_softdirty(char *start, ssize_t size)
>   	return ret;
>   }
> 
> +#define ksft_test_result_if_softdirty(cond, ...)	\
> +do {							\
> +	if (system_has_softdirty())			\
> +		ksft_test_result(cond, __VA_ARGS__);	\
> +	else						\
> +		ksft_test_result_skip(__VA_ARGS__);	\
> +} while (0)
> +
>   static void test_softdirty(void)
>   {
>   	char *addr;
> @@ -246,19 +254,19 @@ static void test_softdirty(void)
> 
>   	/* Clear any softdirty bits. */
>   	clear_softdirty();
> -	ksft_test_result(range_is_not_softdirty(addr, SIZE),
> +	ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
>   			 "range is not softdirty\n");
> 
>   	/* Populating READ should set softdirty. */
>   	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
> -	ksft_test_result(!ret, "MADV_POPULATE_READ\n");
> -	ksft_test_result(range_is_not_softdirty(addr, SIZE),
> +	ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_READ\n");
> +	ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
>   			 "range is not softdirty\n");
> 
>   	/* Populating WRITE should set softdirty. */
>   	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
> -	ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
> -	ksft_test_result(range_is_softdirty(addr, SIZE),
> +	ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_WRITE\n");
> +	ksft_test_result_if_softdirty(range_is_softdirty(addr, SIZE),
>   			 "range is softdirty\n");

We probably want to skip the whole test_*softdirty* test instead of 
adding this (IMHO suboptimal) ksft_test_result_if_softdirty.

-- 
Cheers,

David / dhildenb

