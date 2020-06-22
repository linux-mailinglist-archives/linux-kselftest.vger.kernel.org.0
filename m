Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5416920408C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 21:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgFVTgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 15:36:20 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16392 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgFVTgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 15:36:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef108270000>; Mon, 22 Jun 2020 12:36:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 12:36:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 12:36:19 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 19:36:13 +0000
Subject: Re: [PATCH 13/16] mm: support THP migration to device private memory
To:     Zi Yan <ziy@nvidia.com>
CC:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
 <20200619215649.32297-14-rcampbell@nvidia.com>
 <F1872509-3B1F-4A8A-BFF5-E4D44E451920@nvidia.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b6eed976-c515-72d6-a7be-2296cab8f0d4@nvidia.com>
Date:   Mon, 22 Jun 2020 12:36:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <F1872509-3B1F-4A8A-BFF5-E4D44E451920@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592854567; bh=k92wmBgrGAE346s5tJGKtF1T6WINWYI3KFBqOeO8Nlw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XbZZVsKWFDMXu+mngjFYiRn2RbQAIcVJJlSDUvc/OgLFsfWagoAzSycdRPS23bc+u
         90cSRi4HCzcajweccikNKZxCcES+coy0DPkVoindh/tvK5sDM3W7s35U+bSdDmOWtG
         NUmEHT+sZ8dRU9gRd8hVyhwMbe/dIXf2MJIlLzMb+79CGSPHSCVdY6IelcEL8R0Ul/
         1aGjl+A5NgFU9OVnK42g+u+Gq29eihRRkGlXbO5YE/gN3yzCqijZe0sHWBN0hzB/DP
         vJiXwvziXSBB31zCiRD/2WvlgYOdEZlyYGFb33xirIoc2J6wqlsqpKxoo0L7oCqA7S
         hPj1k8FBFDMWg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/21/20 4:20 PM, Zi Yan wrote:
> On 19 Jun 2020, at 17:56, Ralph Campbell wrote:
> 
>> Support transparent huge page migration to ZONE_DEVICE private memory.
>> A new flag (MIGRATE_PFN_COMPOUND) is added to the input PFN array to
>> indicate the huge page was fully mapped by the CPU.
>> Export prep_compound_page() so that device drivers can create huge
>> device private pages after calling memremap_pages().
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> ---
>>   include/linux/migrate.h |   1 +
>>   include/linux/mm.h      |   1 +
>>   mm/huge_memory.c        |  30 ++++--
>>   mm/internal.h           |   1 -
>>   mm/memory.c             |  10 +-
>>   mm/memremap.c           |   9 +-
>>   mm/migrate.c            | 226 ++++++++++++++++++++++++++++++++--------
>>   mm/page_alloc.c         |   1 +
>>   8 files changed, 226 insertions(+), 53 deletions(-)
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index 3e546cbf03dd..f6a64965c8bd 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -166,6 +166,7 @@ static inline int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>>   #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>>   #define MIGRATE_PFN_LOCKED	(1UL << 2)
>>   #define MIGRATE_PFN_WRITE	(1UL << 3)
>> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
>>   #define MIGRATE_PFN_SHIFT	6
>>
>>   static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index dc7b87310c10..020b9dd3cddb 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -932,6 +932,7 @@ static inline unsigned int page_shift(struct page *page)
>>   }
>>
>>   void free_compound_page(struct page *page);
>> +void prep_compound_page(struct page *page, unsigned int order);
>>
>>   #ifdef CONFIG_MMU
>>   /*
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 78c84bee7e29..25d95f7b1e98 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1663,23 +1663,35 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>   	} else {
>>   		struct page *page = NULL;
>>   		int flush_needed = 1;
>> +		bool is_anon = false;
>>
>>   		if (pmd_present(orig_pmd)) {
>>   			page = pmd_page(orig_pmd);
>> +			is_anon = PageAnon(page);
>>   			page_remove_rmap(page, true);
>>   			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
>>   			VM_BUG_ON_PAGE(!PageHead(page), page);
>>   		} else if (thp_migration_supported()) {
>>   			swp_entry_t entry;
>>
>> -			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
>>   			entry = pmd_to_swp_entry(orig_pmd);
>> -			page = pfn_to_page(swp_offset(entry));
>> +			if (is_device_private_entry(entry)) {
>> +				page = device_private_entry_to_page(entry);
>> +				is_anon = PageAnon(page);
>> +				page_remove_rmap(page, true);
>> +				VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
>> +				VM_BUG_ON_PAGE(!PageHead(page), page);
>> +				put_page(page);
> 
> Why do you hide this code behind thp_migration_supported()? It seems that you just need
> pmd swap entry not pmd migration entry. Also the condition is not consistent with the code
> in __handle_mm_fault(), in which you handle is_device_private_entry() directly without
> checking thp_migration_support().

Good point, I think "else if (thp_migration_supported())" should be
"else if (is_pmd_migration_entry(orig_pmd))" since if the PMD *is*
a device private or migration entry, then it should be handled and the
VM_BUG_ON() should be that thp_migration_supported() is true
(or maybe remove the VM_BUG_ON?).

> Do we need to support split_huge_pmd() if a page is migrated to device? Any new code
> needed in split_huge_pmd()?

I was thinking that any CPU usage of the device private page would cause it to be
migrated back to system memory as a whole PMD/PUD page but I'll double check.
At least there should be a check that the page isn't a device private page.
