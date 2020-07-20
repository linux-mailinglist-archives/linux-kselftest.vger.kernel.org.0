Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A50227350
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 01:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGTXxq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 19:53:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2712 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgGTXxp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 19:53:45 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f162e110000>; Mon, 20 Jul 2020 16:51:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 16:53:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 20 Jul 2020 16:53:45 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 23:53:44 +0000
Subject: Re: [PATCH v2 2/5] mm/migrate: add a direction parameter to
 migrate_vma
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>
References: <20200713172149.2310-1-rcampbell@nvidia.com>
 <20200713172149.2310-3-rcampbell@nvidia.com>
 <20200720183643.GA3028737@nvidia.com>
 <2e775a5d-9d62-de52-6799-3bbb09c88c5a@nvidia.com>
 <20200720195943.GH2021234@nvidia.com>
 <fdfde6a0-f2bf-c0b2-0283-c882aa755292@nvidia.com>
 <20200720231633.GI2021234@nvidia.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <d458ffef-d205-e71d-1b8b-60721c42ca7f@nvidia.com>
Date:   Mon, 20 Jul 2020 16:53:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200720231633.GI2021234@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595289105; bh=ZQjRhhF+y7yVrWHN10F4rwb8PZd9lDc5hIDmGv41Pnw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Nwzysd2f4rPxKQVih681HcCnyXf4qE7QVnsfF9tUtJg8Dc9oBycsJXLGLV3kaUfXV
         nmm4LncwyqzoOLgco1FCThZHDdqbmM3+CjrFswyr5WV7DTb3AMo9EKjCt5biRhuWMB
         lSRgCG173E4ml5n8MeKW+VBZQVkO0yyD5hf+OodIOjSKRiTXJ/tKAEye51AIva2T1U
         FODQh+Z15ZUAjjTsNpkmriBFpTDfXwqEn0A6fxS4VnMjggS0A7MGoqiWrIfS4pU0+f
         NlFesJezdyDMTEH/Zg4AeOZpuwCO6L+bQkrLw/S41vxNr5I2vrNdySmYHnqVEy3tJf
         nQod1z/sAA/4w==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 7/20/20 4:16 PM, Jason Gunthorpe wrote:
> On Mon, Jul 20, 2020 at 01:49:09PM -0700, Ralph Campbell wrote:
>>
>> On 7/20/20 12:59 PM, Jason Gunthorpe wrote:
>>> On Mon, Jul 20, 2020 at 12:54:53PM -0700, Ralph Campbell wrote:
>>>>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>>>>> index 3e546cbf03dd..620f2235d7d4 100644
>>>>>> +++ b/include/linux/migrate.h
>>>>>> @@ -180,6 +180,11 @@ static inline unsigned long migrate_pfn(unsigned long pfn)
>>>>>>     	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
>>>>>>     }
>>>>>> +enum migrate_vma_direction {
>>>>>> +	MIGRATE_VMA_FROM_SYSTEM,
>>>>>> +	MIGRATE_VMA_FROM_DEVICE_PRIVATE,
>>>>>> +};
>>>>>
>>>>> I would have guessed this is more natural as _FROM_DEVICE_ and
>>>>> TO_DEVICE_ ?
>>>>
>>>> The caller controls where the destination memory is allocated so it isn't
>>>> necessarily device private memory, it could be from system to system.
>>>> The use case for system to system memory migration is for hardware
>>>> like ARM SMMU or PCIe ATS where a single set of page tables is shared by
>>>> the device and a CPU process over a coherent system memory bus.
>>>> Also many integrated GPUs in SOCs fall into this category too.
>>>
>>> Maybe just TO/FROM_DEIVCE then? Even though the memory is not
>>> DEVICE_PRIVATE it is still device owned pages right?
>>>
>>>> So to me, it makes more sense to specify the direction based on the
>>>> source location.
>>>
>>> It feels strange because the driver doesn't always know or control the
>>> source?
>>
>> The driver can't really know where the source is currently located because the
>> API is designed to not initially hold the page locks, migrate_vma_setup() only knows
>> the source once it holds the page table locks and isolates/locks the pages being
>> migrated. The direction and pgmap_owner are supposed to filter which pages
>> the caller is interested in migrating.
>> Perhaps the direction should instead be a flags field with separate bits for
>> system memory and device private memory selecting source candidates for
>> migration. I can imagine use cases for all 4 combinations of
>> d->d, d->s, s->d, and s->s being valid.
>>
>> I didn't really think a direction was needed, this was something that
>> Christoph Hellwig seemed to think made the API safer.
> 
> If it is a filter then just using those names would make sense
> 
> MIGRATE_VMA_SELECT_SYSTEM
> MIGRATE_VMA_SELECT_DEVICE_PRIVATE
> 
> SYSTEM feels like the wrong name too, doesn't linux have a formal name
> for RAM struct pages?

Highmem? Movable? Zone normal?
There are quite a few :-)
At the moment, only anonymous pages are being migrated but I expect
file backed pages to be supported at some point (but not DAX).
VM_PFNMAP and VM_MIXEDMAP might make sense some day with peer-to-peer
copies.

So MIGRATE_VMA_SELECT_SYSTEM seems OK to me.

> In your future coherent design how would the migrate select 'device'
> pages that are fully coherent? Are they still zone something pages
> that are OK for CPU usage?
> 
> Jason
> 

For pages that are device private, the pgmap_owner selects them (plus the
MIGRATE_VMA_SELECT_DEVICE_PRIVATE flag).
For pages that are migrating from system memory to system memory, I expect
the pages to be in different NUMA zones. Otherwise, there wouldn't be much
point in migrating them. And yes, the CPU can access them.
It might be useful to have a filter saying "migrate system memory not already
in NUMA zone X" if the MIGRATE_VMA_SELECT_SYSTEM flag is set.

Also, in support of the flags field, I'm looking at THP migration and I can
picture defining some request flags like hmm_range_fault() to say "migrate
THPs if they exist, otherwise split THPs".
A default_flags MIGRATE_PFN_REQ_FAULT would be useful if the source page is
swapped out. Currently, migrate_vma_setup() just skips these pages without
any indication to the caller why the page isn't being migrated or if retrying
is worth attempting.
