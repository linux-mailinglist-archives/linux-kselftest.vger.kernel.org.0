Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E636272BE9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 12:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjFLKRa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 06:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjFLKRO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 06:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCE010FF
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 02:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686563786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7erq9mCXu6YfPjb1swyfCVbQPxq89IutQ/4dZgRd0RM=;
        b=OLwsPy9QilIVP2tx0pWVeCHYYEz3I0CPdCLIJN6B02eknOX7dxwTwjuCPHAehcKvl891V2
        hnI1nSroS2OT38Tf5uUJ0OHuFAXOi7DZ/HqFE8g+I8MrY7fe4ZqqO8fPNjveLxVjOa2GRL
        J/VKT8Lg0C/9oe0A940rgClpO4sLLWA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-52Joyw-bPT-eY92BjDt1vA-1; Mon, 12 Jun 2023 05:56:24 -0400
X-MC-Unique: 52Joyw-bPT-eY92BjDt1vA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b331898229so909051fa.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 02:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563782; x=1689155782;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7erq9mCXu6YfPjb1swyfCVbQPxq89IutQ/4dZgRd0RM=;
        b=g38lVLgF2sjPev08uGCOPROYEsOHB3EcWBmrN+dLb9VHLn9+DnpwjENaZR5+y8djIf
         LzU1E/FHVEpO0A04oflgmjJ0sbcNiUSHecM14O0BdD1sOQsmBHiqqBqh4JKgxlWX6t9r
         ddd2gscUQnBtDGxkutyGEBpW7wYnnkwd4wZHpBO3k4gUUJJ+Cg4Oi0sbvKHIlIUhuerA
         dQQQEiP5KDyRBz79kPz9+Wviba+bbUVq//YattmLExDlzm2K7Mn+RUyk/pWv3LpmdHyQ
         udBxNPNk0lHhqfj6PW0Z9PpVcqYxzY3iTEkYBdxfFGDI2TijcRkrs6Aitwig0eVEyFAc
         7bLQ==
X-Gm-Message-State: AC+VfDw2dyfAKX36FTOvQLT0cISGr/J1Lf2EqIZkaK8zHa44Qo8dlxjm
        zbsQXI8Wr5JCOY1emR8SOEFZeQsHnSd0kvoKzDK+QOKc9jUgvVdBcEbojsSsP1VtMlXERRgFuU6
        9DZqlaFrWdMeo4ZNB+Jm6TbkS39zdKfXAWHOL
X-Received: by 2002:a19:4f4c:0:b0:4f3:b222:1eed with SMTP id a12-20020a194f4c000000b004f3b2221eedmr3525795lfk.2.1686563782586;
        Mon, 12 Jun 2023 02:56:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4U7pGmP/JxxfD47wW6q0zz8WCn++HEA7IpRLWH5Pgnbq09E9OG/AArBNmozy2NqofxEpwZXA==
X-Received: by 2002:a19:4f4c:0:b0:4f3:b222:1eed with SMTP id a12-20020a194f4c000000b004f3b2221eedmr3525779lfk.2.1686563782187;
        Mon, 12 Jun 2023 02:56:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003f8140763c7sm5747410wml.30.2023.06.12.02.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:56:21 -0700 (PDT)
Message-ID: <c287f70c-7eab-8835-de9f-f68db4e54510@redhat.com>
Date:   Mon, 12 Jun 2023 11:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] selftests: mm: remove wrong kernel header inclusion
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Stefan Roesch <shr@devkernel.io>
Cc:     kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230612095347.996335-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230612095347.996335-1-usama.anjum@collabora.com>
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

On 12.06.23 11:53, Muhammad Usama Anjum wrote:
> It is wrong to include unprocessed user header files directly. They are
> processed to "<source_tree>/usr/include" by running "make headers" and
> they are included in selftests by kselftest makefiles automatically with
> help of KHDR_INCLUDES variable. These headers should always bulilt
> first before building kselftests.
> 
> Fixes: 07115fcc15b4 ("selftests/mm: add new selftests for KSM")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/mm/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 95acb099315e..e6cd60ca9e48 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -29,7 +29,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>   # LDLIBS.
>   MAKEFLAGS += --no-builtin-rules
>   
> -CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
> +CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>   LDLIBS = -lrt -lpthread
>   
>   TEST_GEN_PROGS = cow

Still compiles after "make headers", so

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

