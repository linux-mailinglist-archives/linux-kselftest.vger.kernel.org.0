Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4A7FD151
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2019 00:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKNXGJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Nov 2019 18:06:09 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7439 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNXGJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Nov 2019 18:06:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcddda90000>; Thu, 14 Nov 2019 15:05:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 14 Nov 2019 15:06:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 14 Nov 2019 15:06:08 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Nov
 2019 23:06:05 +0000
Subject: Re: [PATCH v4 2/2] mm/hmm/test: add self tests for HMM
To:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
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
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <21d6b69c-3167-e60d-eed2-65bb1f8515ae@nvidia.com>
Date:   Thu, 14 Nov 2019 15:06:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191113135115.GA10688@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573772713; bh=B7TOYH1oGC7u+umXh4N1/gSiAG/BcpUtpnIfDaTAGGs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oFJOV++Eska9iFN5ZhKxMBTjRKi8JF1c4HhevVI8pPNuS5t7MtzmYfvOgVfcpByUR
         fJaX6cTnVCLhFEFTYsU5rTtSUs0KslB9IdJkuhy4B4L8wxaT32kLpmM93ENybg3fWJ
         xrjb7/GDA8EdaxcUzOTJhqrf2xAJQKr2efRt0lO9JVRmzrBn/1ZNan8ghaePlkc8+f
         AbSoMxaEoDeq9UZTG0HOz8Qb6j67Ng+9TPQ3P4XABedJSMmVAVLLTsa0YjGD2Cq1HX
         NiFqgMNiYEQudfJXYaT7i7qDM6DlXfSwbRWl1D14+WVDRhtSdB73GLYltc8yac6ncU
         1JjDg+lgEI9fg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/13/19 5:51 AM, Christoph Hellwig wrote:
> On Tue, Nov 12, 2019 at 11:45:52PM +0000, Jason Gunthorpe wrote:
>>> Well, it would mean registering for the whole process address space.
>>> I'll give it a try.
>>
>> I'm not sure it makes much sense that this testing is essentially
>> modeled after nouveau's usage which is very strange compared to the
>> other drivers.
> 
> Which means we really should make the test cases fit the proper usage.
> Maybe defer the tests for 5.5 and just merge the first patch for now?
> 

I think this a good point to discuss.
Some devices will want to register for all changes to the process address
space because there is no requirement to preregister regions that the
device can access verses devices like InfiniBand where a range of addresses
have to be registered before the device can access those addresses.
So for nouveau and the hmm-test driver, the mmu_range_notifier_insert()
and mmu_range_notifier_remove() are only used long enough to get a
stable copy of a small part of the process address space and copy it to
the device's page table. Then the regular process wide invalidations are
required to keep the device's page tables consistent with the process
page table.

The "hacky" part of the current design is the interaction between the
short term narrow address range invalidations verses the long term
process wide invalidations. (double callbacks, double locking of the
device page table)

Both types of invalidate callbacks seem useful to me so forcing a
driver to use only one type doesn't make sense to me.
