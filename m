Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452CA100B81
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2019 19:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfKRScW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 13:32:22 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10542 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfKRScV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 13:32:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd2e3b50002>; Mon, 18 Nov 2019 10:32:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 10:32:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 10:32:21 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Nov
 2019 18:32:18 +0000
Subject: Re: [PATCH v4 2/2] mm/hmm/test: add self tests for HMM
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20191104222141.5173-1-rcampbell@nvidia.com>
 <20191104222141.5173-3-rcampbell@nvidia.com> <20191112152521.GC12550@lst.de>
 <07589a71-3984-b2a6-b24b-6b9a23e1b60d@nvidia.com>
 <20191112234549.GX21728@mellanox.com> <20191113135115.GA10688@lst.de>
 <21d6b69c-3167-e60d-eed2-65bb1f8515ae@nvidia.com>
 <20191115140619.GC3873@mellanox.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <912f9f23-fa2a-1dd7-3f91-f7175094c2e2@nvidia.com>
Date:   Mon, 18 Nov 2019 10:32:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191115140619.GC3873@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574101941; bh=39u0XUhcHMVb+ZMv/dn3CtMgXSJFUOYDTSmuZ9uY/T0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=o965utNs7sb47SjzfNx79P1NDcBYHTTGYjQg5eKJdAz3jTgIhAnFr7N7geNbmi9ao
         0aR+c+4bAWxpWTsY8M7EzLb02XVMovvgMAPCe6jdZBm6jwo5VnQrt9+rCKJqo5Mkon
         LrArGzwWtC3qJKyXDLyDSzFu3Qfb38n35KX+O1XdeUetSQm5A71fFIm2qI6frO6BLZ
         YWQKfutfxInIgfUt8Gqfws0OZXSfTM0mz83p6l/T1h40NtNdZnySgsZATpTc2AtoSH
         N0DZphSt/6agDSMc8H6BBxkfDZwbXAJPZmi2srMIK0eBBEXuDroYwod1i4932/8BLH
         QNbuhWw7JCpYg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/15/19 6:06 AM, Jason Gunthorpe wrote:
> On Thu, Nov 14, 2019 at 03:06:05PM -0800, Ralph Campbell wrote:
>>
>> On 11/13/19 5:51 AM, Christoph Hellwig wrote:
>>> On Tue, Nov 12, 2019 at 11:45:52PM +0000, Jason Gunthorpe wrote:
>>>>> Well, it would mean registering for the whole process address space.
>>>>> I'll give it a try.
>>>>
>>>> I'm not sure it makes much sense that this testing is essentially
>>>> modeled after nouveau's usage which is very strange compared to the
>>>> other drivers.
>>>
>>> Which means we really should make the test cases fit the proper usage.
>>> Maybe defer the tests for 5.5 and just merge the first patch for now?
>>>
>>
>> I think this a good point to discuss.
>> Some devices will want to register for all changes to the process address
>> space because there is no requirement to preregister regions that the
>> device can access verses devices like InfiniBand where a range of addresses
>> have to be registered before the device can access those addresses.
> 
> But this is a very bad idea to register and do HW actions for ranges
> that can't possibly have any pages registered. It slows down the
> entire application
> 
> I think the ODP approach might be saner, when it mirrors the entire
> address space it chops it up into VA chunks, and once a page is
> registered on the HW the VA chunk goes into the interval tree.
> 
> Presumably the GPU also has some kind of page table tree and you could
> set one of the levels as the VA interval when there are populated children
> 
> Jason

I wasn't suggesting that HW invalidates happen in two places.
I'm suggesting the two styles of invalidates can work together.
For example, what if a driver calls mmu_notifier_register(mn, mm)
to register for address space wide invalidations, then some time
later there is a device page table fault and the driver calls
mmu_range_notifier_insert() but with a NULL ops.invalidate.
The fault handler follows the nouveau/test_hmm pattern to call
     mmu_range_read_begin()
     hmm_range_fault()
     device lock
     mmu_range_read_retry()
     update device page tables
     device unlock
     mmu_range_notifier_remove()

The global invalidate() callback would get the device lock and
call into mm to update the sequence number of any affected ranges
instead of having a range invalidate callback, and then do the HW
invalidations.

