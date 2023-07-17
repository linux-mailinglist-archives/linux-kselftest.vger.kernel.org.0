Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30049756A16
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 19:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGQRXM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjGQRXG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 13:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0C5D8
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689614540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uS2WS/BDTnCQtRW2bGAzVXx+rq+QgojxjwNbtUWSj4U=;
        b=KcIOHx6albbXTNeaPWgQNTDsvh0nrx4jqp+ZQl7SmK0WTW5pau7/nml9LKapKIBP79/+uG
        5Y7le6HhQT2CuYriTC/Sd13sl4ahwMciYvf8p90X3/Y4n+KPHnRYiRdyJTbfJ1fYlgnxGF
        7xd/ycm98ras4p2ttTRkmFfelGruAiQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-Dio39OBLOxqdGj62faj_iw-1; Mon, 17 Jul 2023 13:22:16 -0400
X-MC-Unique: Dio39OBLOxqdGj62faj_iw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3143b999f6eso2746906f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 10:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614535; x=1692206535;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uS2WS/BDTnCQtRW2bGAzVXx+rq+QgojxjwNbtUWSj4U=;
        b=bKPuZ7IxRQB7qfXOhLiFvziHzb2nyj7U6QRAte1vZa8hwZFAWJAaviw7/9isB1EIGn
         HNVhunZiGPnCyaRzWc0+7+1oSEpSuuyeKSUtEBXzyb5FB1DK+B8aOPOXHff5+wzItul7
         7kudN07cbxWx6v3B85aHUL7GnQ0xG47r6NA2C4GJcKXD/8QIzdSGVd3zIOKUG5Xh+/NN
         PIB2yCJPLxesgbF3oUIYS2cykafUaENOPMifdzLCYS21yp/P3jBWFbIIsTX7MZMUmY2G
         kYjuoSlX58vB/4RS4yff0yeGG98Y3No5hw2Cq4BYExeTIyDtG5Y9EO9uAQ9HBRrtj/4P
         ky7Q==
X-Gm-Message-State: ABy/qLbSIJ2ED1xTNUJbfMKjrkrK7XJ+vuGkjMFsDIqEQZ5BiWkmJK0G
        s+DGtLUwTbiBT6KBX2yVXRkeoKxWEd2M5pmY386UEJFX6drH6YhbfnwgrDW2BrHXau2gpGPhC/D
        GsPRt0QPyn+BcNKLdsEMYlF29w3VbvRUMz/2J
X-Received: by 2002:a5d:4b06:0:b0:313:e5f2:7cbf with SMTP id v6-20020a5d4b06000000b00313e5f27cbfmr10455328wrq.58.1689614535150;
        Mon, 17 Jul 2023 10:22:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG5w0pwpqpuswQO0mr5p24K4kS+T7JyG79MOUp+x29Ro/O73yqXbI5EoQaDa7+hAzceVJDQfw==
X-Received: by 2002:a5d:4b06:0:b0:313:e5f2:7cbf with SMTP id v6-20020a5d4b06000000b00313e5f27cbfmr10455308wrq.58.1689614534778;
        Mon, 17 Jul 2023 10:22:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5188000000b00314172ba213sm19579156wrv.108.2023.07.17.10.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 10:22:14 -0700 (PDT)
Message-ID: <e9207c67-40d9-23c9-3c90-677e0a605566@redhat.com>
Date:   Mon, 17 Jul 2023 19:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/8] selftests/mm: Fix thuge-gen test bugs
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-5-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230717103152.202078-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.07.23 12:31, Ryan Roberts wrote:
> thuge-gen was previously only munmapping part of the mmapped buffer,
> which caused us to run out of 1G huge pages for a later part of the
> test. Fix this by munmapping the whole buffer. Based on the code, it
> looks like a typo rather than an intention to keep some of the buffer
> mapped.
> 
> thuge-gen was also calling mmap with SHM_HUGETLB flag (bit 11 set),
> which is actually MAP_DENYWRITE in mmap context. The man page says this
> flag is ignored in modern kernels. I'm pretty sure from the context that
> the author intended to pass the MAP_HUGETLB flag so I've fixed that up
> too.

Makes sense to me.

> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/thuge-gen.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index 380ab5f0a534..16ed4dfa7359 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -139,7 +139,7 @@ void test_mmap(unsigned long size, unsigned flags)
>   		before, after, before - after, size);
>   	assert(size == getpagesize() || (before - after) == NUM_PAGES);
>   	show(size);
> -	err = munmap(map, size);
> +	err = munmap(map, size * NUM_PAGES);
>   	assert(!err);
>   }
>   
> @@ -222,7 +222,7 @@ int main(void)
>   		test_mmap(ps, MAP_HUGETLB | arg);
>   	}
>   	printf("Testing default huge mmap\n");
> -	test_mmap(default_hps, SHM_HUGETLB);
> +	test_mmap(default_hps, MAP_HUGETLB);
>   
>   	puts("Testing non-huge shmget");
>   	test_shmget(getpagesize(), 0);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

