Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A45D2B2A61
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Nov 2020 02:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgKNBQR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 20:16:17 -0500
Received: from wforward1-smtp.messagingengine.com ([64.147.123.30]:60307 "EHLO
        wforward1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgKNBQQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 20:16:16 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2020 20:16:16 EST
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailforward.west.internal (Postfix) with ESMTP id 9FFC9F86;
        Fri, 13 Nov 2020 20:09:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 13 Nov 2020 20:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Y41m9SOkbuzfVtRo7ChuSg0M++MjP3b9rJdYUbpZ5
        io=; b=XaO6EhDEQ17kwxCAxwC28phYHP604Mixwe9wVGjehb9izYOzk4uYXJmAB
        xBXOrrSmesjiAyxPHfUwX57z0LqCbmEAUNsqzu9plp74yopAKEX+6a432LmIzJzW
        AqaBRuKEtzTPmPetN4kiC0agKfafCu2dyiOPxsWvLKiLDf8JOAWlcLgPvFRuqkXL
        Uj3f0foQevb+801JfKiKvFDqTrhndqPx8pTCck7Iac6BVcLSqS0u6geJKQLZNpTl
        ekf99sP017VfoaRMAmeSpqct/FXY625/svr5krw/7LuBV2SkEEsRuq3KnbO4nPOx
        rc06zA757Q6iavnFfAflw5OM2bLEQ==
X-ME-Sender: <xms:LC6vX_Ixi57RYg39AcxmOuoyXM-NP5M1zSY8c76SWdeUq8dVgQDmhQ>
    <xme:LC6vXzLMMb8e1PIYGKw6CZqR2m1RFBq6tNMW-rOsQqVjPUi_kv_LKj6nIEli8eAyR
    2qclhwnHmfpTDv5tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddviedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffoffkjghfgggtgfesthekmhdtredtjeenucfhrhhomhepfdgkihcu
    jggrnhdfuceoiihihiesnhhvihguihgrrdgtohhmqeenucggtffrrghtthgvrhhnpeeigf
    eutdegjefgleejheeugeffheegfffggedthfeifeegjeegkeffiefgueethfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejhedrieejrdelrddutdefnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihihiesnhhvihgu
    ihgrrdgtohhm
X-ME-Proxy: <xmx:LC6vX3s1Ibeq3c5C5u-qFDg0DAO26dOH1KMElQ2tCCUJx95-m1VtQQ>
    <xmx:LC6vX4azdwsErf3tYykGXfMD6NNmrfKHjZGhuKsAgnrBkAUAnefCNQ>
    <xmx:LC6vX2aYDV2iOMDQDUEpAx2JDxTv5Pmj9P3pF07oT41zk4wJK75QTg>
    <xmx:LS6vX4CmiiskaYCVebm2XtrH9wznQqc-4wzPrb5lU3p5DA0mt5hardhdU7rzcYcG>
Received: from [10.2.162.52] (c-75-67-9-103.hsd1.ma.comcast.net [75.67.9.103])
        by mail.messagingengine.com (Postfix) with ESMTPA id B354E328005E;
        Fri, 13 Nov 2020 20:08:59 -0500 (EST)
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Roman Gushchin" <guro@fb.com>,
        "Matthew Wilcox" <willy@infradead.org>
Cc:     linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "Yang Shi" <shy828301@gmail.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        "David Nellans" <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Date:   Fri, 13 Nov 2020 20:08:58 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <F55878E8-22B1-443E-9CC8-E97B3DAA7EA4@nvidia.com>
In-Reply-To: <20201114001505.GA3047204@carbon.dhcp.thefacebook.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <20201114001505.GA3047204@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13 Nov 2020, at 19:15, Roman Gushchin wrote:

> On Wed, Nov 11, 2020 at 03:40:05PM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> It adds a new_order parameter to set new page order in page owner.
>> It prepares for upcoming changes to support split huge page to any 
>> lower
>> order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/page_owner.h | 7 ++++---
>>  mm/huge_memory.c           | 2 +-
>>  mm/page_alloc.c            | 2 +-
>>  mm/page_owner.c            | 6 +++---
>>  4 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
>> index 3468794f83d2..215cbb159568 100644
>> --- a/include/linux/page_owner.h
>> +++ b/include/linux/page_owner.h
>> @@ -31,10 +31,11 @@ static inline void set_page_owner(struct page 
>> *page,
>>  		__set_page_owner(page, order, gfp_mask);
>>  }
>>
>> -static inline void split_page_owner(struct page *page, unsigned int 
>> nr)
>> +static inline void split_page_owner(struct page *page, unsigned int 
>> nr,
>> +			unsigned int new_order)
>>  {
>>  	if (static_branch_unlikely(&page_owner_inited))
>> -		__split_page_owner(page, nr);
>> +		__split_page_owner(page, nr, new_order);
>>  }
>>  static inline void copy_page_owner(struct page *oldpage, struct page 
>> *newpage)
>>  {
>> @@ -60,7 +61,7 @@ static inline void set_page_owner(struct page 
>> *page,
>>  {
>>  }
>>  static inline void split_page_owner(struct page *page,
>> -			unsigned int order)
>> +			unsigned int nr, unsigned int new_order)
>
> With the addition of the new argument it's a bit hard to understand
> what the function is supposed to do. It seems like nr == 
> page_order(page),
> is it right? Maybe we can pass old_order and new_order? Or just the 
> page
> and the new order?

Yeah, it is a bit confusing. Please see more below.

>
>>  {
>>  }
>>  static inline void copy_page_owner(struct page *oldpage, struct page 
>> *newpage)
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index f599f5b9bf7f..8b7d771ee962 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2459,7 +2459,7 @@ static void __split_huge_page(struct page 
>> *page, struct list_head *list,
>>
>>  	ClearPageCompound(head);
>>
>> -	split_page_owner(head, nr);
>> +	split_page_owner(head, nr, 1);
>>
>>  	/* See comment in __split_huge_page_tail() */
>>  	if (PageAnon(head)) {
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index d77220615fd5..a9eead0e091a 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3284,7 +3284,7 @@ void split_page(struct page *page, unsigned int 
>> order)
>>
>>  	for (i = 1; i < (1 << order); i++)
>>  		set_page_refcounted(page + i);
>> -	split_page_owner(page, 1 << order);
>> +	split_page_owner(page, 1 << order, 1);
>>  }
>>  EXPORT_SYMBOL_GPL(split_page);
>>
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index b735a8eafcdb..2b7f7e9056dc 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -204,7 +204,7 @@ void __set_page_owner_migrate_reason(struct page 
>> *page, int reason)
>>  	page_owner->last_migrate_reason = reason;
>>  }
>>
>> -void __split_page_owner(struct page *page, unsigned int nr)
>> +void __split_page_owner(struct page *page, unsigned int nr, unsigned 
>> int new_order)
>>  {
>>  	int i;
>>  	struct page_ext *page_ext = lookup_page_ext(page);
>> @@ -213,9 +213,9 @@ void __split_page_owner(struct page *page, 
>> unsigned int nr)
>>  	if (unlikely(!page_ext))
>>  		return;
>>
>> -	for (i = 0; i < nr; i++) {
>> +	for (i = 0; i < nr; i += (1 << new_order)) {
>>  		page_owner = get_page_owner(page_ext);
>> -		page_owner->order = 0;
>> +		page_owner->order = new_order;
>>  		page_ext = page_ext_next(page_ext);
>
> I believe there cannot be any leftovers because nr is always a power 
> of 2.
> Is it true? Converting nr argument to order (if it's possible) will 
> make it obvious.

Right. nr = thp_nr_pages(head), which is a power of 2. There would not 
be any
leftover.

Matthew recently converted split_page_owner to take nr instead of 
order.[1] But I am not
sure why, since it seems to me that two call sites (__split_huge_page in
mm/huge_memory.c and split_page in mm/page_alloc.c) can pass the order 
information.


[1]https://lore.kernel.org/linux-mm/20200908195539.25896-4-willy@infradead.org/


—
Best Regards,
Yan Zi
