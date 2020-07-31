Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBA7234B9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jul 2020 21:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGaTbZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jul 2020 15:31:25 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5286 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGaTbY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jul 2020 15:31:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f24712e0000>; Fri, 31 Jul 2020 12:29:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 Jul 2020 12:31:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 31 Jul 2020 12:31:24 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul
 2020 19:31:23 +0000
Subject: Re: [PATCH v4 6/6] mm/migrate: remove range invalidation in
 migrate_vma_pages()
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>
References: <20200723223004.9586-1-rcampbell@nvidia.com>
 <20200723223004.9586-7-rcampbell@nvidia.com>
 <20200728191940.GB159104@nvidia.com>
 <7f947311-0034-9148-1dca-fb9b9a10abc4@nvidia.com>
 <20200731191543.GJ24045@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <b8c35d45-91d0-1c99-390a-049867af17fb@nvidia.com>
Date:   Fri, 31 Jul 2020 12:31:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200731191543.GJ24045@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596223790; bh=MF4Np6kSGoTk93XreGGnpf8Lflbk/aQSd9CdXlm3gxg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Jrvy3o8XJ2rY3h6bMQqWanvXTXrCvZz2LWHdo1X7SNs+nmekjNPqnyIhs7UtxJkuW
         FMnHvtBQj8zr9jesv11SxggwiWhDu6842G9JagwXSjMizmbF/C+x2Ml8s6IOQs08nq
         2n8TQS51oUHkTQcN2FCe7qo70Q8VKNVlgQ4qLtBkSQ9+ib1yW6Nc70SFp/jQcRjyxh
         WxtFmZ16kXYh+Hq3mhLNHf/Y0PI4F+dahDYQaKaTitPTDBPbVjT0OVveLaQMuLEI/Z
         pIPJrtAiTRbfiY7Pb5dn/ns2bCBOZa3fWf9TQyI6WuLHb8Jv/Fs6eww3WhAufsO/x5
         njIu1bRlWI0iw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 7/31/20 12:15 PM, Jason Gunthorpe wrote:
> On Tue, Jul 28, 2020 at 03:04:07PM -0700, Ralph Campbell wrote:
>>
>> On 7/28/20 12:19 PM, Jason Gunthorpe wrote:
>>> On Thu, Jul 23, 2020 at 03:30:04PM -0700, Ralph Campbell wrote:
>>>> When migrating the special zero page, migrate_vma_pages() calls
>>>> mmu_notifier_invalidate_range_start() before replacing the zero page
>>>> PFN in the CPU page tables. This is unnecessary since the range was
>>>> invalidated in migrate_vma_setup() and the page table entry is checked
>>>> to be sure it hasn't changed between migrate_vma_setup() and
>>>> migrate_vma_pages(). Therefore, remove the redundant invalidation.
>>>
>>> I don't follow this logic, the purpose of the invalidation is also to
>>> clear out anything that may be mirroring this VA, and "the page hasn't
>>> changed" doesn't seem to rule out that case?
>>>
>>> I'm also not sure I follow where the zero page came from?
>>
>> The zero page comes from an anonymous private VMA that is read-only
>> and the user level CPU process tries to read the page data (or any
>> other read page fault).
>>
>>> Jason
>>>
>>
>> The overall migration process is:
>>
>> mmap_read_lock()
>>
>> migrate_vma_setup()
>>        // invalidates range, locks/isolates pages, puts migration entry in page table
>>
>> <driver allocates destination pages and copies source to dest>
>>
>> migrate_vma_pages()
>>        // moves source struct page info to destination struct page info.
>>        // clears migration flag for pages that can't be migrated.
>>
>> <driver updates device page tables for pages still migrating, rollback pages not migrating>
>>
>> migrate_vma_finalize()
>>        // replaces migration page table entry with destination page PFN.
>>
>> mmap_read_unlock()
>>
>> Since the address range is invalidated in the migrate_vma_setup() stage,
>> and the page is isolated from the LRU cache, locked, unmapped, and the page table
>> holds a migration entry (so the page can't be faulted and the CPU page table set
>> valid again), and there are no extra page references (pins), the page
>> "should not be modified".
> 
> That is the physical page though, it doesn't prove nobody else is
> reading the PTE.
>   
>> For pte_none()/is_zero_pfn() entries, migrate_vma_setup() leaves the
>> pte_none()/is_zero_pfn() entry in place but does still call
>> mmu_notifier_invalidate_range_start() for the whole range being migrated.
> 
> Ok..
> 
>> In the migrate_vma_pages() step, the pte page table is locked and the
>> pte entry checked to be sure it is still pte_none/is_zero_pfn(). If not,
>> the new page isn't inserted. If it is still none/zero, the new device private
>> struct page is inserted into the page table, replacing the pte_none()/is_zero_pfn()
>> page table entry. The secondary MMUs were already invalidated in the migrate_vma_setup()
>> step and a pte_none() or zero page can't be modified so the only invalidation needed
>> is the CPU TLB(s) for clearing the special zero page PTE entry.
> 
> No, the secondary MMU was invalidated but the invalidation start/end
> range was exited. That means a secondary MMU is immeidately able to
> reload the zero page into its MMU cache.
> 
> When this code replaces the PTE that has a zero page it also has to
> invalidate again so that secondary MMU's are guaranteed to pick up the
> new PTE value.
> 
> So, I still don't understand how this is safe?
> 
> Jason

Oops, you are right of course. I was only thinking of the device doing the migration
and forgetting about a second device faulting on the same page.
You can drop patch from the series.
