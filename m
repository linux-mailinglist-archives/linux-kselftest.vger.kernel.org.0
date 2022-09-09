Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCB5B3799
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiIIMX2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 08:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiIIMW7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 08:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237FBC4830
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Sep 2022 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662726115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpKZaZKB6OuIOUbNK0QXmxRia5uDsfJYJGNMehBpaeQ=;
        b=Gg28gKJ3uKapzabdcjs/ovSkjmzQHcse7/DT6PFfTqWsw+hYpR7ACfBtTyuGGGiV/+5xuy
        N7xGMSXUYiUl8By9l0ewwMVmj8Q+DdQE+Rz0WnpSaZ/PBT87lvB2r1bpSRU/W3tFQGIMx0
        ZohYkQ23f6xUZy3z3J76XaWgPtdxaW8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-aToaIkC7O1aIvs9DB4LnWw-1; Fri, 09 Sep 2022 08:21:53 -0400
X-MC-Unique: aToaIkC7O1aIvs9DB4LnWw-1
Received: by mail-wm1-f69.google.com with SMTP id c128-20020a1c3586000000b003b324bb08c5so2450504wma.9
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Sep 2022 05:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=wpKZaZKB6OuIOUbNK0QXmxRia5uDsfJYJGNMehBpaeQ=;
        b=XNiZiC6WyzV/3oZmTJWwjY76pv32ew/W1RAdQSJ36p3pljRr8nHsS01IJZeiZTjTl+
         UqfK2ZFzusRpzjZwkJiJUI9emnibzI3orZz/3RW1S9GVBq37wRHK/ATm5hXBrffZJkT5
         ZuvFXHNT/TwG5HQnchS2FbT9osPVbzP5/6GIz8gI0fh4PwGOayocXvD84dSOu2xOmanK
         KiVeK//UhsuVqh/6/46DIUGr4JaIs19FA/TOfogD0UO8t2T2U8YKUSn4DWGUikJKmtMM
         6wcywOUts6VEI9IxwuQMNtjzylGUj5a4Hnk4rsEbmJCB9+y1PODxzGFKSv7ZuMkqYotw
         zGIg==
X-Gm-Message-State: ACgBeo0VEiHlDt+t318QhGKZVdqMZnvIQAMTXnJ+Y0O/5ABH6UOXWKcp
        H4mWu4GGPa2CY/zXWM+CGfQul0ml03oVmUcCjhQp4asyVqoNwRLbSdk6B0cM5UIVTKT1O3h3MaN
        9YdYY23w29my23PVVaDKSs9y04RxP
X-Received: by 2002:a5d:588a:0:b0:228:462f:a49 with SMTP id n10-20020a5d588a000000b00228462f0a49mr8372607wrf.616.1662726112733;
        Fri, 09 Sep 2022 05:21:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zCe6lDbEZptsQT9dTPwb/AYvVBjW5axO/MWFBwE2Vrd8p4VQ+FCvkXzdgnWOwMPwcYhUpUA==
X-Received: by 2002:a5d:588a:0:b0:228:462f:a49 with SMTP id n10-20020a5d588a000000b00228462f0a49mr8372589wrf.616.1662726112488;
        Fri, 09 Sep 2022 05:21:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id q127-20020a1c4385000000b003a5f54e3bbbsm429713wma.38.2022.09.09.05.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 05:21:52 -0700 (PDT)
Message-ID: <c4447a26-8bc7-2250-0a64-1cb3a1b3b5a2@redhat.com>
Date:   Fri, 9 Sep 2022 14:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 4/5] selftests/memory-hotplug: Restore memory before
 exit
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     akinobu.mita@gmail.com, corbet@lwn.net, osalvador@suse.de,
        shuah@kernel.org
References: <20220909075200.198363-1-zhaogongyi@huawei.com>
 <20220909075200.198363-5-zhaogongyi@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909075200.198363-5-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09.09.22 09:51, Zhao Gongyi wrote:
> Some momory will be left in offline state when calling
> offline_memory_expect_fail() failed. Restore it before exit.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   .../memory-hotplug/mem-on-off-test.sh         | 24 +++++++++++++------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> index 3bdf3c4d6d06..259fd8978639 100755
> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
> @@ -134,6 +134,17 @@ offline_memory_expect_fail()
>   	return 0
>   }
> 
> +online_all_hot_pluggable_memory()
> +{
> +
> +	for memory in `hotpluggable_offline_memory`; do
> +		online_memory_expect_success $memory || {
> +			echo "online memory $memory: unexpected fail"
> +			retval=1
> +		}
> +	done
> +}

Maybe call it

"online_all_offline_memory()"

instead?

Note that "removable" as used in hotpluggable_memory() will nowadays 
always return "1" if the kernel supports memory hotunplug, independent 
of the specific memory block.

-- 
Thanks,

David / dhildenb

