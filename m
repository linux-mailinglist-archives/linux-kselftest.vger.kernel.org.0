Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65B071FF37
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 12:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjFBK0B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 06:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjFBKYx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 06:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB66E75
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685701412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxTIvBa280tFX1Ziuv3vXhP9JFFIHvNa5gTAJi66bKg=;
        b=gnH58Su0r+IJpal9J81SX4ylFfEgi73wbPHyq/vLywSvoWfIaTRNy0vtegKS/jMfz162Ho
        qIZPTH8WbzfMnfK/jKLZMwotx9YpWEozvnPDVN02GhYB1MUt35yiWHtAxNAhlcTZcpNGX4
        xG+6bORrSfWYtc6E6ja99Bh73nOJiOc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-iXYIf9ukNR6Xidu9dgOOvA-1; Fri, 02 Jun 2023 06:23:31 -0400
X-MC-Unique: iXYIf9ukNR6Xidu9dgOOvA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30af222c5feso1022899f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 03:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701410; x=1688293410;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxTIvBa280tFX1Ziuv3vXhP9JFFIHvNa5gTAJi66bKg=;
        b=aR0zFrqSNin1Mt4bztJOUqHpCxwcNKztCltHTnsyOBUY0pgzOQa+Q79mZzp9mGK2X7
         spO/jiIuuULwE9Ld5E7QaPQGnIF4/FPGaSLMlWZsOpzx6SMAsvxz70U7QgpU+lIiYZsS
         PBwG14c31Iptsr1zyG2CHyd4eceoUghzRYl2oj+ZRp5g6/JeU2QtI1i38TXfprN6uDyz
         VVttyHvOHFiyM5rH07zcQnS/0lzAoyGT7uAlzyqRRr4XMGZya2WK6FRf92PPrm7bfh+/
         oo4wgYbwZOiWa7RdOQBDAT+OyloatDCGgrikJRSNIGTXiQk/VvStUUcWccTaHkonEY2b
         BG5g==
X-Gm-Message-State: AC+VfDxrq4A0K1kcbbfHrQVfkJNySlJz5fvZ7r7CK6RpCYkZTYgZoxOd
        2a1RqlNtvpAJYUVXH6q9ts/+o2NvCgx+PtplaNEXAQkS6h6BZKsf1CSUhY8R9IwTA0TRvXR/EV8
        9NV3uvBpyy6D6/pLzRlP7fs+qNGDH
X-Received: by 2002:adf:e905:0:b0:30a:e499:e5ff with SMTP id f5-20020adfe905000000b0030ae499e5ffmr4186473wrm.30.1685701410384;
        Fri, 02 Jun 2023 03:23:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VxWw+nvusOgvfBrsCuX+swQ9iMsm5wh4JYGmC+BxQY+ezR55VhpYbTbnv+HzMc9NMkzKcbQ==
X-Received: by 2002:adf:e905:0:b0:30a:e499:e5ff with SMTP id f5-20020adfe905000000b0030ae499e5ffmr4186466wrm.30.1685701410071;
        Fri, 02 Jun 2023 03:23:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d6081000000b0030adc30e9f1sm1249661wrt.68.2023.06.02.03.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:23:29 -0700 (PDT)
Message-ID: <7a999b80-e266-2b7e-f198-869b1ac7cde7@redhat.com>
Date:   Fri, 2 Jun 2023 12:23:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 11/12] selftests/mm: fix missing UFFDIO_CONTINUE_MODE_WP
 and similar build failures
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-12-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-12-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> UFFDIO_CONTINUE_MODE_WP, UFFD_FEATURE_WP_UNPOPULATED, USERFAULTFD_IOC,
> and USERFAULTFD_IOC_NEW are needed lately, but they are not in my host
> (Arch Linux) distro's userfaultfd.h yet. So put them in here.
> 
> A better approach would be to include the uapi version of userfaultfd.h
> from the kernel tree, but that currently fails with rather difficult
> linker problems (__packed is defined multiple times, ugg), so defer that
> to another day and just fix the build for now.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/uffd-common.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index a1cdb78c0762..98847e41ecf9 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -36,6 +36,23 @@
>   
>   #define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
>   
> +#ifndef UFFDIO_CONTINUE_MODE_WP
> +#define UFFDIO_CONTINUE_MODE_WP			((__u64)1<<1)
> +#endif
> +
> +#ifndef UFFD_FEATURE_WP_UNPOPULATED
> +#define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
> +#endif
> +
> +/* ioctls for /dev/userfaultfd */
> +#ifndef USERFAULTFD_IOC
> +#define USERFAULTFD_IOC 0xAA
> +#endif
> +
> +#ifndef USERFAULTFD_IOC_NEW
> +#define USERFAULTFD_IOC_NEW _IO(USERFAULTFD_IOC, 0x00)
> +#endif
> +
>   #define _err(fmt, ...)						\
>   	do {							\
>   		int ret = errno;				\

Unfortunately, that seems to be the ugly way to handle this because
including the in-tree headers seems to not work and I yet haven't
figured out why (there were some changes back and forth so I lost track).

CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

