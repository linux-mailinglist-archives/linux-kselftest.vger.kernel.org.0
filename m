Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB92165408
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 02:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgBTBKw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 20:10:52 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6968 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgBTBKw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 20:10:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4ddc8d0001>; Wed, 19 Feb 2020 17:10:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Feb 2020 17:10:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Feb 2020 17:10:50 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 01:10:45 +0000
Subject: Re: [PATCH v6 5/6] nouveau: use new mmu interval notifiers
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20200113224703.5917-1-rcampbell@nvidia.com>
 <20200113224703.5917-6-rcampbell@nvidia.com>
 <20200114125957.GO20978@mellanox.com>
 <5845f50e-8bc0-8068-ee21-4f910beb1255@nvidia.com>
 <20200116160002.GL20978@mellanox.com>
 <01adb7dd-589e-2cde-4fa9-68baa44c0976@nvidia.com>
 <20200116202151.GS20978@mellanox.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <770d0aab-726a-12b0-944d-ef71722ad587@nvidia.com>
Date:   Wed, 19 Feb 2020 17:10:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200116202151.GS20978@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582161037; bh=j5Kl9BSF2vTH61P01nHLq9s0kQA2Bt6KxZQ3tGK3SiY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mymMtlTV6FEpRSSfBKo8/J22MnNOMqhoctTnXKtoJNXQCGrFu2vD/UZWIgrhZKqx2
         yZX/Olb+DHLawdffw5s7tzbLtq7L3rLMA1whAzYQmLJpjpty6SZQAOavs1iUYrF1rT
         HTrA2u4UhZkBa3u67AZuNNObcH0GFzqZuWVoCrb3FMeLJawDhdGSPpaALw7Im9razI
         cdAiQcigaPwrLsRhllcboZoB++U+H935O4KnvWag0CdyBtpgYEPvHrVhtmgYCjF3/O
         +FBDcYWSeu5STzMh3DIwhAnhoJpFjvDMzrkPN0aVKcAQLw28WJpkfqGpDZrzCncRtb
         +ixSSVVng+RzQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 1/16/20 12:21 PM, Jason Gunthorpe wrote:
> On Thu, Jan 16, 2020 at 12:16:30PM -0800, Ralph Campbell wrote:
>> Can you point me to the latest ODP code? Seems like my understanding is
>> quite off.
> 
> https://elixir.bootlin.com/linux/v5.5-rc6/source/drivers/infiniband/hw/mlx5/odp.c
> 
> Look for the word 'implicit'
> 
> mlx5_ib_invalidate_range() releases the interval_notifier when there are
> no populated shadow PTEs in its leaf
> 
> pagefault_implicit_mr() creates an interval_notifier that covers the
> level in the page table that needs population. Notice it just uses an
> unlocked xa_load to find the page table level.
> 
> The locking is pretty tricky as it relies on RCU, but the fault flow
> is fairly lightweight.
> 
> Jason
> 
Thanks for the information, Jason.

I'm still interested in finding a way to support range based hints to device drivers.
madvise() looks like it only sets a bit in vma->vm_flags or acts on the
advice immediately. mbind() and set_mempolicy() only work with CPUs and memory
with NUMA a node number. What I'm looking for is a way for the device to know
whether to migrate pages to device private memory on a fault, whether to duplicate
read-only pages in device private memory, or remote map/access a page instead of migrating it.
For example, there is a working draft extension to OpenCL,
https://github.com/intel/llvm/blob/sycl/sycl/doc/extensions/USM/cl_intel_unified_shared_memory.asciidoc
that could provide a way to specify this sort of advice.
C++ is also looking at extentions for specifying affinity attributes.
In any case, these are probably a long ways off before being finalized and implemented.

I also have some changes to support THP migration to device private memory but that
will require updating nouveau to use 2MB TLB mappings.

In the mean time, I can update the HMM self tests to do something like ODP without
changing mm/mmu_notifier.c but I don't think I can easily change nouveau to that model.
