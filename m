Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4AF6D8482
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjDERFs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 13:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjDERFi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 13:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F75CE51
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Apr 2023 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680714257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJP3QkjqCwycJfPPFlfynLksaPqkFMupu9ad2mCFYko=;
        b=bVzzarlXt/d6ChI4d5Kz9pL5FfuHmG8KqgjA7qlwpMSyYyPZa/qRu0OHdKVu6OG+omkb2D
        5MbOsPwBD/A3DbSudK0OiDNa5K1T34f74S7ok7YZfbSC2A+6vGFwPVfLiKJHPYOsGA/YYQ
        qy2jrksLzKD+5zjLULwt22NNaLuMYnE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-wN0Z-5ZoNJmV3oZG9JhMxg-1; Wed, 05 Apr 2023 13:04:16 -0400
X-MC-Unique: wN0Z-5ZoNJmV3oZG9JhMxg-1
Received: by mail-wm1-f72.google.com with SMTP id bh19-20020a05600c3d1300b003ee93fac4a9so19024243wmb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Apr 2023 10:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680714255;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJP3QkjqCwycJfPPFlfynLksaPqkFMupu9ad2mCFYko=;
        b=3JkQttxMxyTziAGok3ulJB6Ao1vgh1NhdPr3eESUCe/RRp909MkpBPtTOrhZbrOG1S
         bawBFqdVskYxbase2F3Sgx6wYee/liJUcrCwsWHr9mVpf0qm31OUStZoN/iGvWoV8hqs
         CJUDsmUg21cPZlugpt60VZcApIH8dhZRHiR14wHGXvClpYuURjqZCmCXXnYoeTrTrCFK
         khjJxiHJkrMP2AAs/uv3NjYfnRv08yNsa5xhCEJJgmMWo06rMtaNuMDbEo3D9gL4O60x
         VN8hQXVQPj+w2fSLkAeMYYviHYIDbkV8HrRXNccK1sxkd8Bk8N5akR6FBeDtrnjLKyIE
         dBsA==
X-Gm-Message-State: AAQBX9feg2MWD/n2ba6m26mmcQGChcYIRyx7+KXqhyICCbzhs9WbXml4
        xmFEPaGvHzMJemq/E9zIPA4MEHCfLR7egPKrpOIlMcoRg34BGdioDHN5fV6DGmbjECX5Kb+jeFu
        HUeBBsMh68GVQe8BVZa0X+DCfOZFGdIL45i/L
X-Received: by 2002:a05:600c:ad2:b0:3ef:624a:d042 with SMTP id c18-20020a05600c0ad200b003ef624ad042mr4920525wmr.17.1680714255266;
        Wed, 05 Apr 2023 10:04:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350amhqFteNi09T2ntknFXQ4YviCJPSlDHhxXZw76znlymOYkAKOaTd5dRq5YRgcFSyRLORQKDA==
X-Received: by 2002:a05:600c:ad2:b0:3ef:624a:d042 with SMTP id c18-20020a05600c0ad200b003ef624ad042mr4920503wmr.17.1680714254958;
        Wed, 05 Apr 2023 10:04:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bce13000000b003ee1acdb036sm2750457wmc.17.2023.04.05.10.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 10:04:14 -0700 (PDT)
Message-ID: <ce494e5a-3540-d6ad-4e9c-0bb49c7e1e1b@redhat.com>
Date:   Wed, 5 Apr 2023 19:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230310182851.2579138-3-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 2/3] mm: add new KSM process and sysfs knobs
In-Reply-To: <20230310182851.2579138-3-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10.03.23 19:28, Stefan Roesch wrote:
> This adds the general_profit KSM sysfs knob and the process profit metric
> and process merge type knobs to ksm_stat.
> 
> 1) split off pages_volatile function
> 
>     This splits off the pages_volatile function.  The next patch will
>     use this function.
> 
> 2) expose general_profit metric
> 
>     The documentation mentions a general profit metric, however this
>     metric is not calculated.  In addition the formula depends on the size
>     of internal structures, which makes it more difficult for an
>     administrator to make the calculation.  Adding the metric for a better
>     user experience.
> 
> 3) document general_profit sysfs knob
> 
> 4) calculate ksm process profit metric
> 
>     The ksm documentation mentions the process profit metric and how to
>     calculate it.  This adds the calculation of the metric.
> 
> 5) add ksm_merge_type() function
> 
>     This adds the ksm_merge_type function.  The function returns the
>     merge type for the process.  For madvise it returns "madvise", for
>     prctl it returns "process" and otherwise it returns "none".
> 
> 6) mm: expose ksm process profit metric and merge type in ksm_stat
> 
>     This exposes the ksm process profit metric in /proc/<pid>/ksm_stat.
>     The name of the value is ksm_merge_type.  The documentation mentions
>     the formula for the ksm process profit metric, however it does not
>     calculate it.  In addition the formula depends on the size of internal
>     structures.  So it makes sense to expose it.
> 
> 7) document new procfs ksm knobs
> 

Often, when you have to start making a list of things that a patch does, 
it might make sense to split some of the items into separate patches 
such that you can avoid lists and just explain in list-free text how the 
pieces in the patch fit together.

I'd suggest splitting this patch into logical pieces. For example, 
separating the general profit calculation/exposure from the per-mm 
profit and the per-mm ksm type indication.

> Link: https://lkml.kernel.org/r/20230224044000.3084046-3-shr@devkernel.io
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---


[...]

>   KSM_ATTR_RO(pages_volatile);
>   
> @@ -3280,6 +3305,21 @@ static ssize_t zero_pages_sharing_show(struct kobject *kobj,
>   }
>   KSM_ATTR_RO(zero_pages_sharing);
>   
> +static ssize_t general_profit_show(struct kobject *kobj,
> +				   struct kobj_attribute *attr, char *buf)
> +{
> +	long general_profit;
> +	long all_rmap_items;
> +
> +	all_rmap_items = ksm_max_page_sharing + ksm_pages_shared +
> +				ksm_pages_unshared + pages_volatile();

Are you sure you want to count a config knob (ksm_max_page_sharing) into 
that formula? I yet have to digest what this calculation implies, but it 
does feel odd.


Further, maybe just avoid pages_volatile(). Expanding the formula 
(excluding ksm_max_page_sharing for now):

all_rmap = ksm_pages_shared + ksm_pages_unshared + pages_volatile();

-> expand pages_volatile() (ignoring the < 0 case)

all_rmap = ksm_pages_shared + ksm_pages_unshared + ksm_rmap_items - 
ksm_pages_shared - ksm_pages_sharing - ksm_pages_unshared;

-> simplify

all_rmap = ksm_rmap_items + ksm_pages_sharing;

Or is the < 0 case relevant here?

> +	general_profit = ksm_pages_sharing * PAGE_SIZE -
> +				all_rmap_items * sizeof(struct ksm_rmap_item);
> +
> +	return sysfs_emit(buf, "%ld\n", general_profit);
> +}
> +KSM_ATTR_RO(general_profit);
> +
>   static ssize_t stable_node_dups_show(struct kobject *kobj,
>   				     struct kobj_attribute *attr, char *buf)
>   {
> @@ -3345,6 +3385,7 @@ static struct attribute *ksm_attrs[] = {
>   	&stable_node_dups_attr.attr,
>   	&stable_node_chains_prune_millisecs_attr.attr,
>   	&use_zero_pages_attr.attr,
> +	&general_profit_attr.attr,
>   	NULL,
>   };
>   

The calculations (profit) don't include when KSM places the shared 
zeropage I guess. Accounting that per MM (and eventually globally) is in 
the works. [1]


[1] 
https://lore.kernel.org/lkml/20230328153852.26c2577e4bd921c371c47a7e@linux-foundation.org/t/

-- 
Thanks,

David / dhildenb

