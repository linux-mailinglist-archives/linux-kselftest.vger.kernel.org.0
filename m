Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6969071FE79
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 12:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjFBKCI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 06:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjFBKCG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 06:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C8CC0
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685700088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SNgThRS/mxJXRGAid53owyTPHRL8x+BARghkh0lpZvc=;
        b=LBuRqYPA238o1ffQWWDqhFeh8ouEIwWKyGhaGcGCi82fV6XDtEK6fNJSqbfiXgVZ8qwgIT
        bREewB04LHcSCRmWLJuuRh6gCx1SjYRSuHv5cByAVRSNKLq5Jb8me8z+T+uj+VQynv0HYR
        eaATNHh/NnkUBMYLTBZYP3TPv5Xpo70=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-26JWcY9uNHCfc5gjSB9GaQ-1; Fri, 02 Jun 2023 06:01:27 -0400
X-MC-Unique: 26JWcY9uNHCfc5gjSB9GaQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-307897bc279so1004354f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 03:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700086; x=1688292086;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNgThRS/mxJXRGAid53owyTPHRL8x+BARghkh0lpZvc=;
        b=ZGsuryIcAwoGjll/o/cIo3PrDrwNU/uGNPK0FzESztG3f5LGT9IXZWoUlJAhH9W8AR
         YEDw8cpXPHb+Av1aOKfFMGZQ4c9WsVcdD1vefHsiw1GQ0sUZWRHN3xLjvK7qFTSK4zhF
         URAz96W0K4LJGMui585bSIzxLgSzPZaDRdPaOUjOIDiDmOaVERvIDmr4IMkW4G2EOdgj
         O9XoE1JV0/KAsbS2jCcqgwVwMtD7vWGYfIbRtzh5Dpdy44OfZXl0VxV5eV279iGczCBj
         Y4pQrKfDcVYf6QiEyX3i7ykzc1EHuR4f/415LVEBJvj0lf4sE5iLXHSH4QFBdY/ny7lK
         y3VQ==
X-Gm-Message-State: AC+VfDy3U+uJSKWJtTsLglM+yYdzxuZIoBlEsb0FSEMSeUbS1zPwkmtd
        PzIPVOTojLxBg0+52dFLrTCYR5N3KCIJUbEjxHNFUfH1UYYZ6V/u1bjXUgskUjO7OpRZ7ASKFr9
        sdxVeb5WIIKMcPyoocPOd8JJh/XWA
X-Received: by 2002:a5d:55c9:0:b0:306:26d1:230a with SMTP id i9-20020a5d55c9000000b0030626d1230amr3832715wrw.65.1685700086506;
        Fri, 02 Jun 2023 03:01:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kIbobvqh4CJfE/keecR5A4XUd25PIh9SH42XIUCrYvrlX3rA069tcuU7hOaLq1WER9Tq3kA==
X-Received: by 2002:a5d:55c9:0:b0:306:26d1:230a with SMTP id i9-20020a5d55c9000000b0030626d1230amr3832695wrw.65.1685700086152;
        Fri, 02 Jun 2023 03:01:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003f727764b10sm1152850wmd.4.2023.06.02.03.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:01:25 -0700 (PDT)
Message-ID: <dd78871f-c95c-6691-9ceb-532271b1f453@redhat.com>
Date:   Fri, 2 Jun 2023 12:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/12] selftests/mm: fix unused variable warning in
 hugetlb-madvise.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-3-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> The dummy variable is required in order to make this work, so declare it
> as volatile in order to avoid the clang compiler warning.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/hugetlb-madvise.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
> index 28426e30d9bc..3296ccaf7525 100644
> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
> @@ -65,7 +65,7 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
>   
>   void read_fault_pages(void *addr, unsigned long nr_pages)
>   {
> -	unsigned long dummy = 0;
> +	volatile unsigned long dummy = 0;
>   	unsigned long i;
>   
>   	for (i = 0; i < nr_pages; i++)

The compiler can still decide to optimize it all out, because it's not a 
global variable.


Placing a

asm volatile("" : "+r" (dummy));

after the write tells the compiler that the value will be read and 
cannot be optimized out (we use that trick in the cow selftest and I've 
been using it in QEMU for the same purpose as well).

-- 
Thanks,

David / dhildenb

