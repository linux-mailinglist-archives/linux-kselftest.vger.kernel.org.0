Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1174413FA66
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 21:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgAPUQe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 15:16:34 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3152 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAPUQe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 15:16:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e20c4680000>; Thu, 16 Jan 2020 12:15:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jan 2020 12:16:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 Jan 2020 12:16:32 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jan
 2020 20:16:30 +0000
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
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <01adb7dd-589e-2cde-4fa9-68baa44c0976@nvidia.com>
Date:   Thu, 16 Jan 2020 12:16:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200116160002.GL20978@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579205736; bh=WNAQTyauIEAfjkBgPoGgynWZIGkIwE/v5rkCyZbbf6c=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Z2KHqSS3okrMumhjFyLWRiuvKmf1TDtFkM0S522antY7tHuOerAvISN0dFEzizNoc
         NFFpSvTa6MweZpNROuIcAI45JgTibZSveKfykxlLK1K80sxVsoEJi5XxgKLbV0jrmT
         ukTdbA069y6xD3Ibq4zJlCGKWM3B8OjWP5MlmjLw/1Favtvp5kRhIgw5UIWgRygNMC
         1Qsh80+xdYPwCXnrmpjH3FSt2pThqz5e9HUWHv1y+7iU2tSW+9ufo0MdcFpPK88jZt
         IOHrIV2z/4RVEmor07EEtw9AZ+RyPWehzlBW8a4e2jqVRqGu95/aCVx3+DnDdfrIMT
         /ZoBmRATcQn1A==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 1/16/20 8:00 AM, Jason Gunthorpe wrote:
> On Wed, Jan 15, 2020 at 02:09:47PM -0800, Ralph Campbell wrote:
> 
>> I don't understand the lifetime/membership issue. The driver is the only thing
>> that allocates, inserts, or removes struct mmu_interval_notifier and thus
>> completely controls the lifetime.
> 
> If the returned value is on the defered list it could be freed at any
> moment. The existing locks do not prevent it.
> 
>>>> +		ret = nouveau_svmm_interval_find(svmm, &range);
>>>> +		if (ret) {
>>>> +			up_read(&mm->mmap_sem);
>>>> +			return ret;
>>>> +		}
>>>> +		range.notifier_seq = mmu_interval_read_begin(range.notifier);
>>>>    		ret = hmm_range_fault(&range, 0);
>>>>    		up_read(&mm->mmap_sem);
>>>>    		if (ret <= 0) {
>>>
>>> I'm still not sure this is a better approach than what ODP does. It
>>> looks very expensive on the fault path..
>>>
>>> Jason
>>>
>>
>> ODP doesn't have this problem because users have to call ib_reg_mr()
>> before any I/O can happen to the process address space.
> 
> ODP supports a single 'full VA' call at process startup, just like
> these cases.
> 
>> That is when mmu_interval_notifier_insert() /
>> mmu_interval_notifier_remove() can be called and the driver doesn't
>> have to worry about the interval changing sizes or being removed
>> while I/O is happening.
> 
> No, for the 'ODP full process VA' (aka implicit ODP) mode it
> dynamically maintains a list of intervals. ODP chooses the align the
> dynamic intervals to it's HW page table levels, and not to SW VMAs.
> This is much simpler to manage and faster to fault, at the cost of
> capturing more VA for invalidations which have to be probed against
> the HW shadow PTEs.
> 
>> It isn't that expensive, there is an extra driver lock/unlock as
>> part of the lookup and possibly a find_vma() and kmalloc(GFP_ATOMIC)
>> for new intervals. Also, the deferred interval updates for munmap().
>> Compared to the cost of updating PTEs in the device and GPU fault
>> handling, this is minimal overhead.
> 
> Well, compared to ODP which does a single xa lookup with no lock to
> find its interval, this looks very expensive and not parallel.
> 
> I think if there is merit in having ranges cover the vmas and track
> changes then there is probably merit in having the core code provide
> much of that logic, not the driver.
> 
> But it would be interesting to see some kind of analysis on the two
> methods to decide if the complexity is worthwhile.
> 
> Jason
> 

Can you point me to the latest ODP code? Seems like my understanding is
quite off.
