Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F466073A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiJUJNP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiJUJM4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 05:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC26255923
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666343470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QNj3hgEs4bdBiVyu7LVFVtKGSZLscyD7sZ5w02+87Hk=;
        b=GLftEHYoz2/Tz/zxCqZa/GDTYhHvrkAcgKxFKj3NkzI4xDIo1d30d3q5aB7ydTMFZHD1v0
        qElyk+oTt4XktufX2ZXzmSs6u0/e11+bfCKWv/zpOfqJccpJVj1slW5YepDnrJNp7DEM/v
        xHy0OuB2J2unffeqBtELrXPmzRN/Kzo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-5lIU-z6hPHun9YGUUqpklA-1; Fri, 21 Oct 2022 05:11:08 -0400
X-MC-Unique: 5lIU-z6hPHun9YGUUqpklA-1
Received: by mail-wm1-f70.google.com with SMTP id t20-20020a7bc3d4000000b003c6bfea856aso338645wmj.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Oct 2022 02:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNj3hgEs4bdBiVyu7LVFVtKGSZLscyD7sZ5w02+87Hk=;
        b=i/pPsCEtwxR03MEIn1Yb91o5Rppj160Wm04LJGFFJCqvlLRr40p6SHH16tG8klM7AV
         vuz4RMET5UR8UACTkMe98kMUw0CmgoaXV5FDMqgHzqY/S12gwqn1GYyEVdTIv5ttv5j1
         amfTBy+SM3ndpbOt1+HgiVoktlc1z2ml97uwH1ZhucqO/cTgw6FAbzzlXZjzTwwmGGGB
         ex8jTCFNYzHK+TKhOVwvZFO3B73Jc4yVpqKp/bNaYR7D5cRRm0VJS2RWxVg18XOxuqY1
         t+r3KlHx1O6ioGVMvJKfYJ9WI71hAYx9rjA5kL++qlQybS6IrV1QsurpaLXOUlMVPUzM
         T+2Q==
X-Gm-Message-State: ACrzQf2Nl1K+YpO5ij+nVxYuaDXkNtNCbRLVjNUVDw2aM05pRMeJFEUb
        b1WzbAVSVefe1rlnI62wq/ymar1XIndctb+zt7MSeA/EcMlhHcEhz5O9eTrOmn6Rflzj+InSNSN
        50g68keWh6I/uDG1bWxJzLPoF3UmG
X-Received: by 2002:a5d:59a8:0:b0:22e:d6ff:3a7c with SMTP id p8-20020a5d59a8000000b0022ed6ff3a7cmr10953449wrr.128.1666343467783;
        Fri, 21 Oct 2022 02:11:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6hFXNeBt6oxLNmY4x/JZYnr1k0+HqDtVJtEv7DGA4moNCSIWQ++QOW5VSnf7aMpvwJq4FCeQ==
X-Received: by 2002:a5d:59a8:0:b0:22e:d6ff:3a7c with SMTP id p8-20020a5d59a8000000b0022ed6ff3a7cmr10953431wrr.128.1666343467486;
        Fri, 21 Oct 2022 02:11:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1700:e40d:574c:c991:5f78? (p200300cbc7081700e40d574cc9915f78.dip0.t-ipconnect.de. [2003:cb:c708:1700:e40d:574c:c991:5f78])
        by smtp.gmail.com with ESMTPSA id f18-20020adff452000000b0022584c82c80sm18307517wrp.19.2022.10.21.02.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 02:11:06 -0700 (PDT)
Message-ID: <948fbf8f-1f0c-ace4-f7b3-64f2bbca00f8@redhat.com>
Date:   Fri, 21 Oct 2022 11:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
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
 <9a84440f-1462-2193-7dd6-c84e8bb22232@redhat.com> <Yz8sZROC7rpPwmgY@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 6/7] mm/ksm: convert break_ksm() to use
 walk_page_range_vma()
In-Reply-To: <Yz8sZROC7rpPwmgY@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06.10.22 21:28, Peter Xu wrote:
> On Thu, Oct 06, 2022 at 11:20:42AM +0200, David Hildenbrand wrote:
>>>> +int break_ksm_pud_entry(pud_t *pud, unsigned long addr, unsigned long next,
>>>> +			struct mm_walk *walk)
>>>> +{
>>>> +	/* We only care about page tables to walk to a single base page. */
>>>> +	if (pud_leaf(*pud) || !pud_present(*pud))
>>>> +		return 1;
>>>> +	return 0;
>>>> +}
>>>
>>> Is this needed?  I thought the pgtable walker handlers this already.
>>>
>>> [...]
>>>
>>
>> Most probably yes. I was trying to avoid about PUD splits, but I guess we
>> simply should not care in VMAs that are considered by KSM (MERGABLE). Most
>> probably never ever happens.
> 
> I was surprised the split is the default approach; didn't really notice
> that before. Yeah maybe better to keep it.

Interestingly, one callback reduces the benchmark result by 100-200 MiB.

With only break_ksm_pmd_entry(), I get ~4900 MiB/s instead of ~5010 MiB/s (~2%).

I came to the conclusion that we really shouldn't have to worry about pud
THPs here: it could only be a file PUD and splitting that only zaps the
entry, but doesn't PMD- or PTE-map it.

Also, I think we will barely see large pud THP in a mergable mapping ... :)

[...]

>> My main motivation is to remove most of that GUP hackery here, which is
>> 1) Getting a reference on a page and waiting for migration to finish
>>     even though both is unnecessary.
>> 2) As we don't have sufficient control, we added FOLL_MIGRATION hacks to
>>     MM core to work around limitations in the GUP-based approacj.
> 
> I saw one thing of adding FOLL_MIGRATION from Hugh was to have a hint for
> follow page users:
> 
>    I'd have preferred to avoid another flag, and do it every time, in case
>    someone else makes the same easy mistake..
> 
> Though..

The important thing I think is that FOLL_MIGRATION really only applies to
follow_page(). In case of "modern" GUP we will just wait for migration
entries, handle swap entries ... when triggering a page fault.

> 
>> 3) We rely on legacy follow_page() interface that we should really get
>>     rid of in the long term.
> 
> ..this is part of effort to remove follow_page()?  More context will be
> helpful in that case.

The comment from Hugh is another example why follow_page() adds complexity.
One might wonder, how pages in the swapcache, device coherent pages, ...
would have to be handled.

Short-term, I want to cleanup GUP. Long-term we might want to consider
removing follow_page() completely.

[...]

>>
>> Yes, we have to extend page walking code, but it's just the natural,
>> non-hacky way of doing it.
>>
>> Regarding the 4% performance degradation (if I wouldn't have added the
>> benchmarks, nobody would know and probably care ;) ), I am not quite sure
>> why that is the case. We're just walking page tables after all in both
>> cases. Maybe the callback-based implementation of pagewalk code is less
>> efficient, but we might be able to improve that implementation if we really
>> care about performance here. Maybe removing break_ksm_pud_entry() already
>> improves the numbers slightly.
> 
> Yeah it could be the walker is just slower.  And for !ksm walking your code
> should be faster when hit migration entries, but that should really be rare
> anyway.


I have the following right now:


 From 7f767f9e9e673a29793cd35f1c3d66ed593b67cb Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Jul 2022 10:36:20 +0200
Subject: [PATCH] mm/ksm: convert break_ksm() to use walk_page_range_vma()

FOLL_MIGRATION exists only for the purpose of break_ksm(), and
actually, there is not even the need to wait for the migration to
finish, we only want to know if we're dealing with a KSM page.

Using follow_page() just to identify a KSM page overcomplicates GUP
code. Let's use walk_page_range_vma() instead, because we don't actually
care about the page itself, we only need to know a single property --
no need to even grab a reference.

So, get rid of follow_page() usage such that we can get rid of
FOLL_MIGRATION now and eventually be able to get rid of follow_page() in
the future.

In my setup (AMD Ryzen 9 3900X), running the KSM selftest to test unmerge
performance on 2 GiB (taskset 0x8 ./ksm_tests -D -s 2048), this results in
a performance degradation of ~2% (old: ~5010 MiB/s, new: ~4900 MiB/s).
I don't think we particularly care for now.

Interestingly, the benchmark reduction is due to the single callback.
Adding a second callback (e.g., pud_entry()) reduces the benchmark by
another 100-200 MiB/s.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/ksm.c | 49 +++++++++++++++++++++++++++++++++++++++----------
  1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c6f58aa6e731..5cdb852ff132 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -39,6 +39,7 @@
  #include <linux/freezer.h>
  #include <linux/oom.h>
  #include <linux/numa.h>
+#include <linux/pagewalk.h>
  
  #include <asm/tlbflush.h>
  #include "internal.h"
@@ -419,6 +420,39 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
  	return atomic_read(&mm->mm_users) == 0;
  }
  
+static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+			struct mm_walk *walk)
+{
+	struct page *page = NULL;
+	spinlock_t *ptl;
+	pte_t *pte;
+	int ret;
+
+	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
+		return 0;
+
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	if (pte_present(*pte)) {
+		page = vm_normal_page(walk->vma, addr, *pte);
+	} else if (!pte_none(*pte)) {
+		swp_entry_t entry = pte_to_swp_entry(*pte);
+
+		/*
+		 * As KSM pages remain KSM pages until freed, no need to wait
+		 * here for migration to end.
+		 */
+		if (is_migration_entry(entry))
+			page = pfn_swap_entry_to_page(entry);
+	}
+	ret = page && PageKsm(page);
+	pte_unmap_unlock(pte, ptl);
+	return ret;
+}
+
+static const struct mm_walk_ops break_ksm_ops = {
+	.pmd_entry = break_ksm_pmd_entry,
+};
+
  /*
   * We use break_ksm to break COW on a ksm page by triggering unsharing,
   * such that the ksm page will get replaced by an exclusive anonymous page.
@@ -434,21 +468,16 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
   */
  static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
  {
-	struct page *page;
  	vm_fault_t ret = 0;
  
  	do {
-		bool ksm_page = false;
+		int ksm_page;
  
  		cond_resched();
-		page = follow_page(vma, addr,
-				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
-		if (IS_ERR_OR_NULL(page))
-			break;
-		if (PageKsm(page))
-			ksm_page = true;
-		put_page(page);
-
+		ksm_page = walk_page_range_vma(vma, addr, addr + 1,
+					       &break_ksm_ops, NULL);
+		if (WARN_ON_ONCE(ksm_page < 0))
+			return ksm_page;
  		if (!ksm_page)
  			return 0;
  		ret = handle_mm_fault(vma, addr,
-- 
2.37.3


-- 
Thanks,

David / dhildenb

