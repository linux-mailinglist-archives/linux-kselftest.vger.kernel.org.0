Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3FF60D0B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 17:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiJYPfD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiJYPfA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 11:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5455258DF2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666712097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1GvBOBCP6KETy6rTK6QCl92NvC/MctQ2jjFIvDTUSU=;
        b=NLEHoELw3FW3lGAgKhXLKvhRXSXYC03mFHzo1Lky6pvEkID2pMR6rKBYICtB3nSoMf1lN+
        hZOvwTWRTtYyRiTbg2ps3opYv8AjsB4gXa1uUXfJSilHQ1M5tAt4+9YaufcCwWCq9rmZKw
        fe94xfgCJ+R3aad6fFES1l0NAansthI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-604-mCIqHKr1Mwe1inC_qYECcw-1; Tue, 25 Oct 2022 11:34:55 -0400
X-MC-Unique: mCIqHKr1Mwe1inC_qYECcw-1
Received: by mail-wr1-f71.google.com with SMTP id t12-20020adfa2cc000000b0022adcbb248bso4908600wra.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 08:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1GvBOBCP6KETy6rTK6QCl92NvC/MctQ2jjFIvDTUSU=;
        b=nhWN1uCFYTShxsWkBVw3j0RYnpDr/N9lPX4g6yfRZeZPdXJIXXCL9NhSMZa5rdvuLe
         lEkTPHpBxyf0IRyBOBV+4AZsYTxvPEnE4d+CkUNPfcR6owpDnTK2ddiqglNqtkOWDyL/
         5/kKhRxSvUBxXHrNk4Fp+7PiL/K4PEfVMagDhM3dmik/Rz7/fLUAJiQSZzzDnXpUT4dO
         U5fIsRNwgsUNcDtC6s8fZmIoUBdI2kbeGLSC2gDnnekoIdyBkZ0wcIvsERLYgGxKNGZ6
         5BM1zzJHiJurFBjBEAwq9KEHKgsnOq9ej4l/o/6HjScH7aooWt8LvC4QF1zlMW0bIRQE
         seMg==
X-Gm-Message-State: ACrzQf37Ptz6x96SeIY6KQQENVo3WcAtwUAB9Zi7iiBoexSYvpsPqtVJ
        VR47GOnJZ2vIST/vFjy/3oBVL0ilJO5105G2ujEINZz4aKz9zZZ8nI33euW0G1s2Ds94Hc1e4qx
        DYWTBSu5JkaPYoX4hu5JxIHm1qDqj
X-Received: by 2002:a05:6000:18ad:b0:230:6d12:fc7d with SMTP id b13-20020a05600018ad00b002306d12fc7dmr25096955wri.409.1666712094505;
        Tue, 25 Oct 2022 08:34:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5MF3ZzlWB5p5BMwQBW0Xp49UZmIOa+s5CbB/a5oA0uLsaa08jpku5+sqs+rXA4yS/NADMYVw==
X-Received: by 2002:a05:6000:18ad:b0:230:6d12:fc7d with SMTP id b13-20020a05600018ad00b002306d12fc7dmr25096938wri.409.1666712094252;
        Tue, 25 Oct 2022 08:34:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:d00:eae9:3af6:9999:7b63? (p200300cbc7190d00eae93af699997b63.dip0.t-ipconnect.de. [2003:cb:c719:d00:eae9:3af6:9999:7b63])
        by smtp.gmail.com with ESMTPSA id c1-20020adfe741000000b00236883f2f5csm506813wrn.94.2022.10.25.08.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 08:34:53 -0700 (PDT)
Message-ID: <e5eff1ef-760c-5e6f-9f32-e8a7a624993b@redhat.com>
Date:   Tue, 25 Oct 2022 17:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] selftests: vm: use 1 MB hugepage size for s390
Content-Language: en-US
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20221025152610.3439102-1-gerald.schaefer@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221025152610.3439102-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25.10.22 17:26, Gerald Schaefer wrote:
> hugepage-vmemmap test fails for s390 because it assumes a hugepagesize
> of 2 MB, while we have 1 MB on s390. This results in iterating over two
> hugepages. If they are consecutive in memory, check_page_flags() will
> stumble over the additional head page. Otherwise, it will stumble over
> non-huge pageflags, after crossing the first 1 MB hugepage.
> 
> Fix this by using 1 MB MAP_LENGTH for s390.
> 
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>   tools/testing/selftests/vm/hugepage-vmemmap.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/vm/hugepage-vmemmap.c b/tools/testing/selftests/vm/hugepage-vmemmap.c
> index 557bdbd4f87e..a4695f138cec 100644
> --- a/tools/testing/selftests/vm/hugepage-vmemmap.c
> +++ b/tools/testing/selftests/vm/hugepage-vmemmap.c
> @@ -11,7 +11,14 @@
>   #include <sys/mman.h>
>   #include <fcntl.h>
>   
> +/*
> + * 1 MB hugepage size for s390
> + */
> +#if defined(__s390x__)
> +#define MAP_LENGTH		(1UL * 1024 * 1024)
> +#else
>   #define MAP_LENGTH		(2UL * 1024 * 1024)
> +#endif

Why not detect it at runtime, so this works on any architecture (e.g., 
ppc64 with 16 MiB IIRC and arm64 with weird sizes)?

A patch that adds such detection code is currently on its way upstream:

https://lore.kernel.org/all/20220927110120.106906-5-david@redhat.com/T/#u

We could factor that out into vm_utils.c

-- 
Thanks,

David / dhildenb

