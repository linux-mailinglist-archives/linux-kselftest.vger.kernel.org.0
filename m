Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1490751101
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjGLTLj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 15:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGLTLh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 15:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F131BF8
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689189051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q45SoRMuLgunlP8L7mZ4yYklFc9J8ZjnlV0HAlFrluA=;
        b=FvtSAKP/W0rluk3vy56TimDf2Qni7XOh5q48UldEydX5Cf/BmsggFGMCY94SDKEUgy7A9+
        CGZPlRXNPT2KZhG5Euz9vPA7VWt9c2uq/A+V+nvmyfw2pZGUEPok7CsHfAvPFm7ZXhgsFQ
        It1bsnMe8emNIf1fKPi3N26ENukUBPg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-5g7DydEOMFqv3UsLmkOQBw-1; Wed, 12 Jul 2023 15:10:50 -0400
X-MC-Unique: 5g7DydEOMFqv3UsLmkOQBw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so45605635e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 12:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689189049; x=1691781049;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q45SoRMuLgunlP8L7mZ4yYklFc9J8ZjnlV0HAlFrluA=;
        b=HRBTqY3xhAeW0XUjLk+Z6Q8SuuZkPTqax9/wJFdrx86bhTzp6UfuaUvn/uSP0G1nBh
         VFMukNHsgN02fcArrdRX77smwoFE3vlunk/WRKqpxM7ONofXlqdD17SyWTjLpOv+t8EX
         0S1cVvqD+syf0jcLYRRca2yBWp+qTBQPE8q8PJXWQAxXoIStEa4sBKaRRZsx6iroW2vb
         fFMfWopemIIcw6YIL1/x+Lpaa8Kbu1KRsG5YFWkGjXYG5O9uNrG7GOMR3WCY06b9m0AX
         DCa2FfwV7eyv3v9TWDkic2PluuHrHpCqzihefonkF63IIkuv8dwgg7Yj+OYrj+Ac0yhI
         +7hg==
X-Gm-Message-State: ABy/qLapPlwVo6R+PE2bWF6nlBB61vKCsPvWKebiZNcfnqZVavSTXllF
        0xvN9nNQaqoC674iiyOiQWQ2ENPSefgGs88/gNTlhiwwqBf4wr8hEP1yokLo76s5VTgLdb3Ti6v
        ZXGg7gR1GBXMunSTIWCpRE/8yi08h
X-Received: by 2002:a7b:c019:0:b0:3fb:a62d:1992 with SMTP id c25-20020a7bc019000000b003fba62d1992mr16262192wmb.0.1689189049322;
        Wed, 12 Jul 2023 12:10:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7+RfJW8rL+kAwaM2CugjDDuPQVV8Tbi86e3qb2YFzqDwqbvHOu/X6/+h7PYfnyGjOw9KBjA==
X-Received: by 2002:a7b:c019:0:b0:3fb:a62d:1992 with SMTP id c25-20020a7bc019000000b003fba62d1992mr16262181wmb.0.1689189048992;
        Wed, 12 Jul 2023 12:10:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3700:3eea:ace6:5bde:4478? (p200300cbc70737003eeaace65bde4478.dip0.t-ipconnect.de. [2003:cb:c707:3700:3eea:ace6:5bde:4478])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b003fa9a00d74csm409177wms.3.2023.07.12.12.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 12:10:48 -0700 (PDT)
Message-ID: <60f2ef09-53b2-6bf8-9cd0-3b639ac7b765@redhat.com>
Date:   Wed, 12 Jul 2023 21:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH][next] selftests/mm: mkdirty: Fix incorrect position of
 #endif
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230712134648.456349-1-colin.i.king@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230712134648.456349-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12.07.23 15:46, Colin Ian King wrote:
> The #endif is the wrong side of a } causing a build failure when
> __NR_userfaultfd is not defined. Fix this by moving the #end to
> enclose the }
> 
> Fixes: 9eac40fc0cc7 ("selftests/mm: mkdirty: test behavior of (pte|pmd)_mkdirty on VMAs without write permissions")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   tools/testing/selftests/mm/mkdirty.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
> index 6d71d972997b..301abb99e027 100644
> --- a/tools/testing/selftests/mm/mkdirty.c
> +++ b/tools/testing/selftests/mm/mkdirty.c
> @@ -321,8 +321,8 @@ static void test_uffdio_copy(void)
>   munmap:
>   	munmap(dst, pagesize);
>   	free(src);
> -#endif /* __NR_userfaultfd */
>   }
> +#endif /* __NR_userfaultfd */
>   
>   int main(void)
>   {

Ouch, thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

