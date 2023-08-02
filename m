Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4876D130
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjHBPNT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjHBPND (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 11:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865C8210A
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690989133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+0KWNa1xwubY/Ggk8izjhhZVuMUOv4VLooz2GsqEHg=;
        b=SWxW84pY93ZvXp+k57vxxvhS52f/J8VeuKAdimshI5vQJG9fOBK0C6EumwXWAr69VXptGj
        nV16gglJ77czKbVcSTExE5hsakSo3h1QY5gUHExyXHpYQlRiH+MTTC87wUPMj2Sqb6r8cn
        AEVSXjJ5y4FfRBQkJvfMzgCowpUvPkU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-qpUZ9Gt5MO-S8cmn0HTceg-1; Wed, 02 Aug 2023 11:12:12 -0400
X-MC-Unique: qpUZ9Gt5MO-S8cmn0HTceg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe232ba9e5so19043845e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 08:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989130; x=1691593930;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+0KWNa1xwubY/Ggk8izjhhZVuMUOv4VLooz2GsqEHg=;
        b=lVAmv5yLVzhTNZ2vsasM3MuLd1Seo7TVCvbWwAVDU43B8P29OsYDRjYrTBLgwvLkln
         PZjD+KcfFQFUlEi5DOdD+pMn0gVv8PhhdV19AyHa+5Van8XxFfZ2GlakEniBa3NlwPUn
         aK1BJqbLXoszJb6PZ8Gqhn2RwqjNVB4BfFMqZHMzgcRRcbW1H+vpINCz264bplC4Yqnr
         6l2zJxYaoMunNgPeQHtsiog7sXom0pgjUTuifIMbqgwldhhmt6Qb4zrqdSerfA0D/zY/
         Cu3lR7MAscmo15GRwT2lklAghLEiulraEHgS9Sf4LjGafkWwjPUppfS1gFmvw4J5rts3
         84Vg==
X-Gm-Message-State: ABy/qLYwUnNf2dz0Iw0AxHQiPZC37TLK15FsZibAs2V5ueWHa8uI5pmD
        MNgbYIVEeqi1SkVhEYZaEDtOuAaGA2NDwXmB8SUWDG5EyXQAoQmgFSM5mhfhwEARziPOIT3hnq1
        0BSurGn1wNaKdJlzR/k81/vMf1/UV
X-Received: by 2002:a5d:595b:0:b0:316:f3cf:6f12 with SMTP id e27-20020a5d595b000000b00316f3cf6f12mr4856144wri.48.1690989130092;
        Wed, 02 Aug 2023 08:12:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFiwCmVukTG4b003Kw1jOw/WrbZSFH1/nxmUVT0cf0q5oxfG7XYzDO68q2V6Sj2RMU4SGVtAg==
X-Received: by 2002:a5d:595b:0:b0:316:f3cf:6f12 with SMTP id e27-20020a5d595b000000b00316f3cf6f12mr4856114wri.48.1690989129710;
        Wed, 02 Aug 2023 08:12:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4f12000000b0030647449730sm19346391wru.74.2023.08.02.08.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:12:09 -0700 (PDT)
Message-ID: <fa396bd9-9453-2212-6cfd-9dc0ae1c8c48@redhat.com>
Date:   Wed, 2 Aug 2023 17:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/8] mm/gup: reintroduce FOLL_NUMA as
 FOLL_HONOR_NUMA_FAULT
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-2-david@redhat.com>
 <20230802150816.aaubbx4t7745lqik@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230802150816.aaubbx4t7745lqik@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>> Reported-by: liubo <liubo254@huawei.com>
>> Closes: https://lore.kernel.org/r/20230726073409.631838-1-liubo254@huawei.com
>> Reported-by: Peter Xu <peterx@redhat.com>
>> Closes: https://lore.kernel.org/all/ZMKJjDaqZ7FW0jfe@x1n/
>> Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> I agree that FOLL_REMOTE probably needs separate treatment but also agree
> that it's outside the context of this patch, particularly as a -stable
> candidate so
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> I've a minor nit below that would be nice to get fixed up, but not
> mandatory.

Thanks Mel for taking a look, so I don't mess up once more :)

> 
>> ---
>>   include/linux/mm.h       | 21 +++++++++++++++------
>>   include/linux/mm_types.h |  9 +++++++++
>>   mm/gup.c                 | 29 +++++++++++++++++++++++------
>>   mm/huge_memory.c         |  2 +-
>>   4 files changed, 48 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 2493ffa10f4b..f463d3004ddc 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2240,6 +2244,12 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
>>   		gup_flags |= FOLL_UNLOCKABLE;
>>   	}
>>   
>> +	/*
>> +	 * For now, always trigger NUMA hinting faults. Some GUP users like
>> +	 * KVM really require it to benefit from autonuma.
>> +	 */
>> +	gup_flags |= FOLL_HONOR_NUMA_FAULT;
>> +
>>   	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
>>   	if (WARN_ON_ONCE((gup_flags & (FOLL_PIN | FOLL_GET)) ==
>>   			 (FOLL_PIN | FOLL_GET)))
> 
> Expand on *why* KVM requires it even though I suspect this changes later
> in the series. Maybe "Some GUP users like KVM require the hint to be as
> the calling context of GUP is functionally similar to a memory reference
> from task context"?

It's raised later in this series but it doesn't hurt to discuss it here 
in a bit more detail.

Sounds good to me.

> 
> Also minor nit -- s/autonuma/NUMA Balancing/ or numab. autonuma refers to
> a specific implementation of automatic balancing that operated similar to
> khugepaged but not merged. If you grep for it, you'll find that autonuma
> is only referenced in powerpc-specific code. It's not important these
> days but very early on, it was very confusing if AutoNUMA was mentioned
> when NUMAB was intended.

Ah, yes, thanks. That's the one of the only place where that terminology 
accidentally slipped in.

I'll wait for more feedback and resend!

-- 
Cheers,

David / dhildenb

