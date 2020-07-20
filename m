Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C6226F4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgGTTyz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 15:54:55 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17615 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgGTTyz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 15:54:55 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f15f6510000>; Mon, 20 Jul 2020 12:53:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 12:54:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 20 Jul 2020 12:54:55 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 19:54:54 +0000
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
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <2e775a5d-9d62-de52-6799-3bbb09c88c5a@nvidia.com>
Date:   Mon, 20 Jul 2020 12:54:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200720183643.GA3028737@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595274833; bh=xe0NlTll7koBWxfHzF7xMR2/rT2YI2SjQkBbzGUMHBo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=R1BoJhWZIo+phXPvLeBHb9GE3Ir3Ca2lGqCHZ7NOF28da9GouiDynuAzy0gXwHK3b
         0SMyfaA0vmSyeRjgDlnXk6jyQwdL9gxZzJ3BWM0f8xL7QCDDUC7gC4urSU3lvrIwhr
         Q/QFFZ3p5SX+tx1mFrH3nTwS4SZvc1GgkIjJyuIxTdmoGO4JaYLWNAVAIH3tTHYv2Q
         jU03JZBll7tMF8wszpfoFUpydK44DBij3jJxuXMpE1rw9qoEFZuC34Z+f8iN+kYHTg
         8Hip24/wshZhcjucEB6XpxKQZQEdfUZ2VK4A8GhafEtptM2onG1cGmjF48lb52H7+a
         kpV37ju9KbY2w==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 7/20/20 11:36 AM, Jason Gunthorpe wrote:
> On Mon, Jul 13, 2020 at 10:21:46AM -0700, Ralph Campbell wrote:
>> The src_owner field in struct migrate_vma is being used for two purposes,
>> it implies the direction of the migration and it identifies device private
>> pages owned by the caller. Split this into separate parameters so the
>> src_owner field can be used just to identify device private pages owned
>> by the caller of migrate_vma_setup().
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>
>>   arch/powerpc/kvm/book3s_hv_uvmem.c     |  2 ++
>>   drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 ++
>>   include/linux/migrate.h                | 12 +++++++++---
>>   lib/test_hmm.c                         |  2 ++
>>   mm/migrate.c                           |  5 +++--
>>   5 files changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
>> index 09d8119024db..acbf14cd2d72 100644
>> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
>> @@ -400,6 +400,7 @@ kvmppc_svm_page_in(struct vm_area_struct *vma, unsigned long start,
>>   	mig.end = end;
>>   	mig.src = &src_pfn;
>>   	mig.dst = &dst_pfn;
>> +	mig.dir = MIGRATE_VMA_FROM_SYSTEM;
>>   
>>   	/*
>>   	 * We come here with mmap_lock write lock held just for
>> @@ -578,6 +579,7 @@ kvmppc_svm_page_out(struct vm_area_struct *vma, unsigned long start,
>>   	mig.src = &src_pfn;
>>   	mig.dst = &dst_pfn;
>>   	mig.src_owner = &kvmppc_uvmem_pgmap;
>> +	mig.dir = MIGRATE_VMA_FROM_DEVICE_PRIVATE;
>>   
>>   	mutex_lock(&kvm->arch.uvmem_lock);
>>   	/* The requested page is already paged-out, nothing to do */
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
>> index e5c230d9ae24..e5c83b8ee82e 100644
>> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
>> @@ -183,6 +183,7 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
>>   		.src		= &src,
>>   		.dst		= &dst,
>>   		.src_owner	= drm->dev,
>> +		.dir		= MIGRATE_VMA_FROM_DEVICE_PRIVATE,
>>   	};
>>   
>>   	/*
>> @@ -615,6 +616,7 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
>>   	struct migrate_vma args = {
>>   		.vma		= vma,
>>   		.start		= start,
>> +		.dir		= MIGRATE_VMA_FROM_SYSTEM,
>>   	};
>>   	unsigned long i;
>>   	u64 *pfns;
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index 3e546cbf03dd..620f2235d7d4 100644
>> +++ b/include/linux/migrate.h
>> @@ -180,6 +180,11 @@ static inline unsigned long migrate_pfn(unsigned long pfn)
>>   	return (pfn << MIGRATE_PFN_SHIFT) | MIGRATE_PFN_VALID;
>>   }
>>   
>> +enum migrate_vma_direction {
>> +	MIGRATE_VMA_FROM_SYSTEM,
>> +	MIGRATE_VMA_FROM_DEVICE_PRIVATE,
>> +};
> 
> I would have guessed this is more natural as _FROM_DEVICE_ and
> TO_DEVICE_ ?

The caller controls where the destination memory is allocated so it isn't
necessarily device private memory, it could be from system to system.
The use case for system to system memory migration is for hardware
like ARM SMMU or PCIe ATS where a single set of page tables is shared by
the device and a CPU process over a coherent system memory bus.
Also many integrated GPUs in SOCs fall into this category too.

So to me, it makes more sense to specify the direction based on the
source location.

> All the callers of this API are device drivers managing their
> DEVICE_PRIVATE, right?

True for now, yes.

> Jason
> 
