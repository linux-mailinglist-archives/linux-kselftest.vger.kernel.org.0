Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6BE752562
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjGMOmd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjGMOmd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527A173F
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689259311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2R6dDDtWkBzm8BK7gNECoNNAz90QfecM3mxU2f2ZR0=;
        b=i6D3RXwFO0cat1t13IrNjkgH28Gj6FzJUT4LlSJqsleESXR5EXvsBl4TosRRjUCOyRvTeu
        JVxO7bxPuYMot2IFLKTdDGb4KkIkATDlDzriMu/dOmag5ZWaWX1OfhmUJiJB59UN6C/VUP
        ZwnnhB0iuLVk7gmbxxaij4EArO1ViHg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-cINJT_wZMH-6C8I3nyRLnA-1; Thu, 13 Jul 2023 10:41:50 -0400
X-MC-Unique: cINJT_wZMH-6C8I3nyRLnA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3143ac4a562so555094f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 07:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259309; x=1691851309;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2R6dDDtWkBzm8BK7gNECoNNAz90QfecM3mxU2f2ZR0=;
        b=DQPwqiv0RJomzWCJfYJmgqZ+lacMt5JSIN3cDMneRNxLrgThWVsvbuvCNo5fk4xeJ/
         8Ixhfl/khygx8HRR+Y+c4UZHqU9mcwANXc+2u+9j0cVl2AE9Bz3Y6Nl723Bq03Xlqnh0
         h4R6tWceBu25VimG/MIAcyvHEkeAvyvBek2NTB8yidUmzYvZ5C5Dn8Gbrvryb2Gu2+sr
         S4yKKz+WGLJf8aMjWei1m4a4/Bk84MJy/uQkOJ9tUrmGCvKzSb/GFQeYoJS0l5OvRc3Q
         sbkKTPiRJ1+xroxHlzGul0aCdo5g7Qw9t+m4Yb4Y0BC5jvjmLcFlO/fuGkTi5tOe6mnv
         LVFw==
X-Gm-Message-State: ABy/qLa602Gvzz5NNqnNeOO8Ax7fM8gSwuZSNQ8M/1koVbMbJiTfoewQ
        q6X3wfyvNJRn/OQhzbhVyiGgqgKMKcvQjeUwP6BcRxxGsilyMjFwHrV9SD1/sEOBqnWlzMWLbbe
        Dz0oVFiD3K8KD3heitc7ur6ZKyMzf
X-Received: by 2002:a5d:5944:0:b0:313:fce9:c568 with SMTP id e4-20020a5d5944000000b00313fce9c568mr1555689wri.31.1689259309465;
        Thu, 13 Jul 2023 07:41:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8Y9wJtjwsoykc35+sgxyZLim850yFkZVhcdkP6y60VpV1mMg23WlUd55g5Z0yevQoGHHrqg==
X-Received: by 2002:a5d:5944:0:b0:313:fce9:c568 with SMTP id e4-20020a5d5944000000b00313fce9c568mr1555675wri.31.1689259309129;
        Thu, 13 Jul 2023 07:41:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id d6-20020adfe846000000b0030fd03e3d25sm8165077wrn.75.2023.07.13.07.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:41:48 -0700 (PDT)
Message-ID: <afe16f17-3398-c30c-82a9-eaadae4949c1@redhat.com>
Date:   Thu, 13 Jul 2023 16:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 6/9] selftests/mm: va_high_addr_switch should skip
 unsupported arm64 configs
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
 <20230713135440.3651409-7-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713135440.3651409-7-ryan.roberts@arm.com>
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
> va_high_addr_switch has a mechanism to determine if the tests should be
> run or skipped (supported_arch()). This currently returns
> unconditionally true for arm64. However, va_high_addr_switch also
> requires a large virtual address space for the tests to run, otherwise
> they spuriously fail.
> 
> Since arm64 can only support VA > 48 bits when the page size is 64K,
> let's decide whether we should skip the test suite based on the page
> size. This reduces noise when running on 4K and 16K kernels.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/va_high_addr_switch.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
> index 7cfaf4a74c57..4b6f62c69a9d 100644
> --- a/tools/testing/selftests/mm/va_high_addr_switch.c
> +++ b/tools/testing/selftests/mm/va_high_addr_switch.c
> @@ -292,7 +292,8 @@ static int supported_arch(void)
>   #elif defined(__x86_64__)
>   	return 1;
>   #elif defined(__aarch64__)
> -	return 1;
> +	size_t page_size = getpagesize();
> +	return page_size == PAGE_SIZE;


return getpagesize() == PAGE_SIZE;

?


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

