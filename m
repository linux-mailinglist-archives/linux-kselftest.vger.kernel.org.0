Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0A5F637F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Oct 2022 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiJFJUu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Oct 2022 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJFJUs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Oct 2022 05:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D682F666
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Oct 2022 02:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665048046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mw6vh8Fj2nr/tAp1jCRdKpprVY4vooB4N4OGmMaId3w=;
        b=NGPc2xEKKOptrR4fH1ZYMk26Tig9ZfMOKLrEOXEl1mQwt4chERnpKq6Rilfss+F7JEaAMc
        AqJ8LuK6leqLvC0K7lDoFc0i8DXosfMzZNYLZl6ftDeqjK1i/lj/8RNYdj5zY8XsNbfiSm
        Bi8bAw6X4OoVQIHy1MR8uS04D68EaXI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-Q_x8S9qEMdOqtVO-ijdXMg-1; Thu, 06 Oct 2022 05:20:45 -0400
X-MC-Unique: Q_x8S9qEMdOqtVO-ijdXMg-1
Received: by mail-wm1-f69.google.com with SMTP id f26-20020a7bcc1a000000b003c03db14864so381344wmh.6
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Oct 2022 02:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=mw6vh8Fj2nr/tAp1jCRdKpprVY4vooB4N4OGmMaId3w=;
        b=QQkBH7kWkFz9gjf6rIOwTkRDQsvUpMh2axw+QmWSNZwty3hrEWU1joNWA1+sFijxEU
         mjrIrMGrmtgYUi1+XTLPP3kIjJr9AjtjgBmiuQYbO+pCZd7Wp1IkP4qi0fUmAg9Fr3si
         H27p30cPlpdZI2yKuKuIv7Rl3O43sf+kRIjZx3ktbYVXoc67NCGHdrUliiT3dHB74Mu3
         eYu4cngS6u1+ADchNCjf06e0zjfetiP7lbyhmlLwie9+0+G2OKool13qIBzrVVXKpLs6
         90K06XCoIThNw70wi8S2Vh0o2L7w6NvWPv1WHCRUqKiVxC1toRbqspvA9NDRw+5B4mzT
         PGHw==
X-Gm-Message-State: ACrzQf2eVKe958Pn7tWSXk0i3Eg9FYmf9RzYEer1JrcBHwON3VId3Pr/
        0JIv2n7q9Zfo/8cXmuBUwvgOUKgYiZ0fXcxLO6r61xM8lZZdppP0pJlQ9Q5bwABR+9WkIei9CdY
        cSP5KVmrjheOcizAgSPtmABbsgNWS
X-Received: by 2002:a05:6000:783:b0:22e:35dd:5f48 with SMTP id bu3-20020a056000078300b0022e35dd5f48mr2418054wrb.106.1665048044465;
        Thu, 06 Oct 2022 02:20:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6CPRIjlEs2RQKZxShqi1C0hC1GtJGCC/hdDMM0onx6qferHIFo+jEb+L9bsJrIDf7AP0JKGg==
X-Received: by 2002:a05:6000:783:b0:22e:35dd:5f48 with SMTP id bu3-20020a056000078300b0022e35dd5f48mr2418025wrb.106.1665048044084;
        Thu, 06 Oct 2022 02:20:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:3700:aed2:a0f8:c270:7f30? (p200300cbc7053700aed2a0f8c2707f30.dip0.t-ipconnect.de. [2003:cb:c705:3700:aed2:a0f8:c270:7f30])
        by smtp.gmail.com with ESMTPSA id az30-20020adfe19e000000b002286670bafasm7091697wrb.48.2022.10.06.02.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 02:20:43 -0700 (PDT)
Message-ID: <9a84440f-1462-2193-7dd6-c84e8bb22232@redhat.com>
Date:   Thu, 6 Oct 2022 11:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-7-david@redhat.com> <Yz3wcDZPFvKBmnet@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 6/7] mm/ksm: convert break_ksm() to use
 walk_page_range_vma()
In-Reply-To: <Yz3wcDZPFvKBmnet@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>> +int break_ksm_pud_entry(pud_t *pud, unsigned long addr, unsigned long next,
>> +			struct mm_walk *walk)
>> +{
>> +	/* We only care about page tables to walk to a single base page. */
>> +	if (pud_leaf(*pud) || !pud_present(*pud))
>> +		return 1;
>> +	return 0;
>> +}
> 
> Is this needed?  I thought the pgtable walker handlers this already.
> 
> [...]
> 

Most probably yes. I was trying to avoid about PUD splits, but I guess 
we simply should not care in VMAs that are considered by KSM (MERGABLE). 
Most probably never ever happens.

>>   static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>>   {
>> -	struct page *page;
>>   	vm_fault_t ret = 0;
>>   
>> +	if (WARN_ON_ONCE(!IS_ALIGNED(addr, PAGE_SIZE)))
>> +		return -EINVAL;
>> +
>>   	do {
>>   		bool ksm_page = false;
>>   
>>   		cond_resched();
>> -		page = follow_page(vma, addr,
>> -				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
>> -		if (IS_ERR_OR_NULL(page))
>> -			break;
>> -		if (PageKsm(page))
>> -			ksm_page = true;
>> -		put_page(page);
>> +		ret = walk_page_range_vma(vma, addr, addr + PAGE_SIZE,
>> +					  &break_ksm_ops, &ksm_page);
>> +		if (WARN_ON_ONCE(ret < 0))
>> +			return ret;
> 
> I'm not sure this would be worth it, especially with a 4% degrade.  The
> next patch will be able to bring 50- LOC, but this patch does 60+ anyway,
> based on another new helper just introduced...
> 
> I just don't see whether there's strong enough reason to do so to drop
> FOLL_MIGRATE.  It's different to the previous VM_FAULT_WRITE refactor
> because of the unshare approach was much of a good reasoning to me.
> 
> Perhaps I missed something?

My main motivation is to remove most of that GUP hackery here, which is
1) Getting a reference on a page and waiting for migration to finish
    even though both is unnecessary.
2) As we don't have sufficient control, we added FOLL_MIGRATION hacks to
    MM core to work around limitations in the GUP-based approacj.
3) We rely on legacy follow_page() interface that we should really get
    rid of in the long term.

All we want to do is walk the page tables and make a decision if 
something we care about is mapped. Instead of leaking these details via 
hacks into GUP code and making that code harder to grasp/maintain, this 
patch moves that logic to the actual user, while reusing generic page 
walking code.

Yes, we have to extend page walking code, but it's just the natural, 
non-hacky way of doing it.

Regarding the 4% performance degradation (if I wouldn't have added the 
benchmarks, nobody would know and probably care ;) ), I am not quite 
sure why that is the case. We're just walking page tables after all in 
both cases. Maybe the callback-based implementation of pagewalk code is 
less efficient, but we might be able to improve that implementation if 
we really care about performance here. Maybe removing 
break_ksm_pud_entry() already improves the numbers slightly.

Thanks!

-- 
Thanks,

David / dhildenb

