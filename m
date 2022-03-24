Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4297F4E5D06
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 03:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347560AbiCXCDz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 22:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347556AbiCXCDy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 22:03:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5596B931B4;
        Wed, 23 Mar 2022 19:02:22 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KP7fl5mtbzBrjN;
        Thu, 24 Mar 2022 09:58:23 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 10:02:19 +0800
Subject: Re: [RFC PATCH 3/5] mm: thp: split huge page to any lower order
 pages.
To:     Zi Yan <ziy@nvidia.com>
CC:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        Yu Zhao <yuzhao@google.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-4-zi.yan@sent.com>
 <165ec1a8-2b35-f6fb-82d3-b94613dd437a@huawei.com>
 <D03D6945-8BFE-4137-BDB6-BD884656B65B@nvidia.com>
 <ed175cd4-1411-459e-e892-7d889e1253c0@huawei.com>
 <87E48455-3FDD-47FC-A953-CBAB52FD3889@nvidia.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6587a8af-8d6d-c947-2cee-11f75ceefef6@huawei.com>
Date:   Thu, 24 Mar 2022 10:02:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87E48455-3FDD-47FC-A953-CBAB52FD3889@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/3/24 6:10, Zi Yan wrote:
> On 22 Mar 2022, at 22:31, Miaohe Lin wrote:
> 
>> On 2022/3/22 22:30, Zi Yan wrote:
>>> On 21 Mar 2022, at 23:21, Miaohe Lin wrote:
>>>
>>>> On 2022/3/21 22:21, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> To split a THP to any lower order pages, we need to reform THPs on
>>>>> subpages at given order and add page refcount based on the new page
>>>>> order. Also we need to reinitialize page_deferred_list after removing
>>>>> the page from the split_queue, otherwise a subsequent split will see
>>>>> list corruption when checking the page_deferred_list again.
>>>>>
>>>>> It has many uses, like minimizing the number of pages after
>>>>> truncating a pagecache THP. For anonymous THPs, we can only split them
>>>>> to order-0 like before until we add support for any size anonymous THPs.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>>  include/linux/huge_mm.h |   8 +++
>>>>>  mm/huge_memory.c        | 111 ++++++++++++++++++++++++++++++----------
>>>>>  2 files changed, 91 insertions(+), 28 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>> index 2999190adc22..c7153cd7e9e4 100644
>>>>> --- a/include/linux/huge_mm.h
>>>>> +++ b/include/linux/huge_mm.h
>>>>> @@ -186,6 +186,8 @@ void free_transhuge_page(struct page *page);
>>>>>
>>>>>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>>>>>  int split_huge_page_to_list(struct page *page, struct list_head *list);
>>>>> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>> +		unsigned int new_order);
>>>>>  static inline int split_huge_page(struct page *page)
>>>>>  {
>>>>>  	return split_huge_page_to_list(page, NULL);
>>>>> @@ -355,6 +357,12 @@ split_huge_page_to_list(struct page *page, struct list_head *list)
>>>>>  {
>>>>>  	return 0;
>>>>>  }
>>>>> +static inline int
>>>>> +split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>> +		unsigned int new_order)
>>>>> +{
>>>>> +	return 0;
>>>>> +}
>>>>>  static inline int split_huge_page(struct page *page)
>>>>>  {
>>>>>  	return 0;
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index fcfa46af6c4c..3617aa3ad0b1 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -2236,11 +2236,13 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>>>>>  static void unmap_page(struct page *page)
>>>>>  {
>>>>>  	struct folio *folio = page_folio(page);
>>>>> -	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
>>>>> -		TTU_SYNC;
>>>>> +	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SYNC;
>>>>>
>>>>>  	VM_BUG_ON_PAGE(!PageHead(page), page);
>>>>>
>>>>> +	if (folio_order(folio) >= HPAGE_PMD_ORDER)
>>>>> +		ttu_flags |= TTU_SPLIT_HUGE_PMD;
>>>>> +
>>>>>  	/*
>>>>>  	 * Anon pages need migration entries to preserve them, but file
>>>>>  	 * pages can simply be left unmapped, then faulted back on demand.
>>>>> @@ -2254,9 +2256,9 @@ static void unmap_page(struct page *page)
>>>>>  	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
>>>>>  }
>>>>>
>>>>> -static void remap_page(struct folio *folio, unsigned long nr)
>>>>> +static void remap_page(struct folio *folio, unsigned short nr)
>>>>>  {
>>>>> -	int i = 0;
>>>>> +	unsigned int i;
>>>>>
>>>>>  	/* If unmap_page() uses try_to_migrate() on file, remove this check */
>>>>>  	if (!folio_test_anon(folio))
>>>>> @@ -2274,7 +2276,6 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>>>>>  		struct lruvec *lruvec, struct list_head *list)
>>>>>  {
>>>>>  	VM_BUG_ON_PAGE(!PageHead(head), head);
>>>>> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>>>>>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>>>>>  	lockdep_assert_held(&lruvec->lru_lock);
>>>>>
>>>>> @@ -2295,9 +2296,10 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>>>>>  }
>>>>>
>>>>>  static void __split_huge_page_tail(struct page *head, int tail,
>>>>> -		struct lruvec *lruvec, struct list_head *list)
>>>>> +		struct lruvec *lruvec, struct list_head *list, unsigned int new_order)
>>>>>  {
>>>>>  	struct page *page_tail = head + tail;
>>>>> +	unsigned long compound_head_flag = new_order ? (1L << PG_head) : 0;
>>>>>
>>>>>  	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
>>>>>
>>>>> @@ -2321,6 +2323,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>>>>>  #ifdef CONFIG_64BIT
>>>>>  			 (1L << PG_arch_2) |
>>>>>  #endif
>>>>> +			 compound_head_flag |
>>>>>  			 (1L << PG_dirty)));
>>>>>
>>>>>  	/* ->mapping in first tail page is compound_mapcount */
>>>>> @@ -2329,7 +2332,10 @@ static void __split_huge_page_tail(struct page *head, int tail,
>>>>>  	page_tail->mapping = head->mapping;
>>>>>  	page_tail->index = head->index + tail;
>>>>>
>>>>> -	/* Page flags must be visible before we make the page non-compound. */
>>>>> +	/*
>>>>> +	 * Page flags must be visible before we make the page non-compound or
>>>>> +	 * a compound page in new_order.
>>>>> +	 */
>>>>>  	smp_wmb();
>>>>>
>>>>>  	/*
>>>>> @@ -2339,10 +2345,15 @@ static void __split_huge_page_tail(struct page *head, int tail,
>>>>>  	 * which needs correct compound_head().
>>>>>  	 */
>>>>>  	clear_compound_head(page_tail);
>>>>> +	if (new_order) {
>>>>> +		prep_compound_page(page_tail, new_order);
>>>>> +		prep_transhuge_page(page_tail);
>>>>> +	}
>>>>
>>>> Many thanks for your series. It looks really good. One question:
>>>> IIUC, It seems there has assumption that LRU compound_pages should
>>>> be PageTransHuge. So PageTransHuge just checks PageHead:
>>>>
>>>> static inline int PageTransHuge(struct page *page)
>>>> {
>>>> 	VM_BUG_ON_PAGE(PageTail(page), page);
>>>> 	return PageHead(page);
>>>> }
>>>>
>>>> So LRU pages with any order( > 0) will might be wrongly treated as THP which
>>>> has order = HPAGE_PMD_ORDER. We should ensure thp_nr_pages is used instead of
>>>> hard coded HPAGE_PMD_ORDER.
>>>>
>>>> Looks at the below code snippet:
>>>> mm/mempolicy.c:
>>>> static struct page *new_page(struct page *page, unsigned long start)
>>>> {
>>>> ...
>>>> 	} else if (PageTransHuge(page)) {
>>>> 		struct page *thp;
>>>>
>>>> 		thp = alloc_hugepage_vma(GFP_TRANSHUGE, vma, address,
>>>> 					 HPAGE_PMD_ORDER);
>>>> 					 ^^^^^^^^^^^^^^^^
>>>> 		if (!thp)
>>>> 			return NULL;
>>>> 		prep_transhuge_page(thp);
>>>> 		return thp;
>>>> 	}
>>>> ...
>>>> }
>>>>
>>>> HPAGE_PMD_ORDER is used instead of thp_nr_pages. So the lower order pages might be
>>>> used as if its order is HPAGE_PMD_ORDER. All of such usage might need to be fixed.
>>>> Or am I miss something ?
>>>>
>>>> Thanks again for your work. :)
>>>
>>> THP will still only have HPAGE_PMD_ORDER and will not be split into any order
>>> other than 0. This series only allows to split huge page cache folio (added by Matthew)
>>> into any lower order. I have an explicit VM_BUG_ON() to ensure new_order
>>> is only 0 when non page cache page is the input. Since there is still non-trivial
>>> amount of work to add any order THP support in the kernel. IIRC, Yu Zhao (cc’d) was
>>> planning to work on that.
>>>
>>
>> Many thanks for clarifying. I'm sorry but I haven't followed Matthew's patches. I am
>> wondering could huge page cache folio be treated as THP ? If so, how to ensure the
>> correctness of huge page cache ?
> 
> You are right. All these HPAGE_PMD_ORDRE locations should be replaced by thp_nr_pages().
> I will look into it.
> 

Many thanks for doing this. :)

> Thanks a lot.
> 
> --
> Best Regards,
> Yan, Zi
> 

