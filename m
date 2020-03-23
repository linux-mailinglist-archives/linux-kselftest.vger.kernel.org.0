Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE718FC8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 19:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCWSVQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 14:21:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2790 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgCWSVQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 14:21:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e78fe0e0000>; Mon, 23 Mar 2020 11:21:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 23 Mar 2020 11:21:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 23 Mar 2020 11:21:15 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Mar
 2020 18:21:15 +0000
Subject: Re: [PATCH v8 0/3] mm/hmm/test: add self tests for HMM
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20200321003108.22941-1-rcampbell@nvidia.com>
 <20200321090047.GM514123@unreal>
 <396f0c30-4a49-6a18-ff02-a73ee1a09883@nvidia.com>
 <20200321215505.GW20941@ziepe.ca> <20200322081038.GG650439@unreal>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <010050db-a37d-d200-88d4-696cc2c8d9d6@nvidia.com>
Date:   Mon, 23 Mar 2020 11:21:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200322081038.GG650439@unreal>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584987662; bh=1Wek6LBYAdU1aHIlmdcVgKcV0g9ZqFumuUlMbDqQya8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=V6XX7qH92buUCwPTHr32tVk37r9DCwWiP01gZ5NQeioLh2l4m+RDLIaGzQFmE8xKW
         9/9K4I5SpNQDgrdpE8b4vsxDz1hF89T0L/c6ByepnxqI1t6ti/j72xBQ9/dn/F8nV6
         Wo4ZwOBBiq7JgsD3MPAa6a1LK6MWvXuNW0KdD/ac0hLX6xK8K25QJw2JYFDH4wXJzb
         ac8IxYzO30X+L8jxW31n/NglXxNBSsNufj05l8/Ih8O2Sjp6v/4e1vKAHYosj1IfeM
         PvKEoZrvRH0HnckdaiMqeu01h824HMlqbHXQEZwriSE2Q6iDBk4tOKGOYAsamku+pt
         ctx4qI2Fc5iaw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 3/22/20 1:10 AM, Leon Romanovsky wrote:
> On Sat, Mar 21, 2020 at 06:55:05PM -0300, Jason Gunthorpe wrote:
>> On Sat, Mar 21, 2020 at 10:27:46AM -0700, Ralph Campbell wrote:
>>>
>>> On 3/21/20 2:00 AM, Leon Romanovsky wrote:
>>>> On Fri, Mar 20, 2020 at 05:31:05PM -0700, Ralph Campbell wrote:
>>>>> This series adds basic self tests for HMM and are intended for Jason
>>>>> Gunthorpe's rdma tree which has a number of HMM patches applied.
>>>>>
>>>>> Changes v7 -> v8:
>>>>> Rebased to Jason's rdma/hmm tree, plus Jason's 6 patch series
>>>>>     "Small hmm_range_fault() cleanups".
>>>>> Applied a number of changes from Jason's comments.
>>>>>
>>>>> Changes v6 -> v7:
>>>>> Rebased to linux-5.6.0-rc6
>>>>> Reverted back to just using mmu_interval_notifier_insert() and making
>>>>>     this series only introduce HMM self tests.
>>>>>
>>>>> Changes v5 -> v6:
>>>>> Rebased to linux-5.5.0-rc6
>>>>> Refactored mmu interval notifier patches
>>>>> Converted nouveau to use the new mmu interval notifier API
>>>>>
>>>>> Changes v4 -> v5:
>>>>> Added mmu interval notifier insert/remove/update callable from the
>>>>>     invalidate() callback
>>>>> Updated HMM tests to use the new core interval notifier API
>>>>>
>>>>> Changes v1 -> v4:
>>>>> https://lore.kernel.org/linux-mm/20191104222141.5173-1-rcampbell@nvidia.com
>>>>>
>>>>> Ralph Campbell (3):
>>>>>     mm/hmm/test: add selftest driver for HMM
>>>>>     mm/hmm/test: add selftests for HMM
>>>>>     MAINTAINERS: add HMM selftests
>>>>>
>>>>>    MAINTAINERS                            |    3 +
>>>>>    include/uapi/linux/test_hmm.h          |   59 ++
>>>>
>>>> Isn't UAPI folder supposed to be for user-visible interfaces that follow
>>>> the rule of non-breaking user space and not for selftests?
>>>>
>>>> Thanks
>>>>
>>>
>>> Most of the other kernel module tests seem to invoke the test as part of the
>>> module load/init. I'm open to moving it if there is a more appropriate location.
>>
>> Is it even possible to create a user mm_struct and put crazy things in
>> it soley from a kernel module?
> 
> I didn't look very closely of what Ralph did in his patchsets, but from
> what I know, if you want in-kernel interface, you use in-kernel module,
> if you want to test user visible uapi, you write application. You don't
> create new UAPI just to test something in the kernel.
> 
> Can kunit help here?
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
> 
> Thanks
> 
>>
>> Jason

The tests are intended to cover hmm_range_fault() and the migrate_vma_setup(),
migrate_vma_pages(), and migrate_vma_finalize() kernel functions that a device
driver can call to initialize hardware that has its own page tables.
An example is a GPU where the code on the GPU sees the same address space as
code running on the host CPU. This means the test has to have a user process
to create a user process address space and a device driver to simulate some
real device driver. The UAPI is for the user level test program to tell the
kernel module test driver what to do and return results.
The complexity is all around maintaining coherent copies of the user process
page tables while hardware and CPUs are accessing the same physical addresses.
The pages are not pinned as with most I/O so system activity like pagein/pageout,
LRU page reclaim, compaction, and the process calling functions like
mmap(), mprotect(), madvise(), fork(), etc. all update the CPU and device page
tables and would be very hard to duplicate in a kernel level only KUNIT style
of test.

