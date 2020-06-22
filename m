Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF8203F62
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 20:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgFVSpJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 14:45:09 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12286 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVSpI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 14:45:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef0fc270000>; Mon, 22 Jun 2020 11:44:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 11:45:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 11:45:08 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 18:44:59 +0000
Subject: Re: [PATCH 08/16] nouveau/hmm: fault one page at a time
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20200619215649.32297-1-rcampbell@nvidia.com>
 <20200619215649.32297-9-rcampbell@nvidia.com>
 <20200622172233.GA2874652@mellanox.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f529df0d-707c-cb67-ac12-356784e54ef8@nvidia.com>
Date:   Mon, 22 Jun 2020 11:44:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200622172233.GA2874652@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592851495; bh=edTvH4CLD4vItWTGQfSjP32xxPYuTSK47wQwLKtpC2o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Rw1MHPXFCHxs683/WECRpVcEISDyJHi11DYaKjk6Je+Hzsfmso1p97Ec8fYZM2+nM
         A+Whgg2ThDXh90YDXJAKBJwzuaP2WzJlG8bwz/1/VnakrGPCT7sb/aLJ+IleyTzN4h
         9jH1TmNccMQ6YU399/RKKkKq2dPSZhr92L71xYLncMKZOVOR48E1BIFUCpW11mwjOE
         t+M8mWr0WSNGayrNmi4RHcERwZ+hLyLIlZZD5cjsTt043/R1L5B5ihX/JKG3DP2Aem
         qU3pd3KpJt+qQyE2dumEr5djt4hCCHzY/BBBtQZeeGZ0+hG3skWe1a6K8PfsLkY2WT
         4nfL0AaTfpmSw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/22/20 10:22 AM, Jason Gunthorpe wrote:
> On Fri, Jun 19, 2020 at 02:56:41PM -0700, Ralph Campbell wrote:
>> The SVM page fault handler groups faults into a range of contiguous
>> virtual addresses and requests hmm_range_fault() to populate and
>> return the page frame number of system memory mapped by the CPU.
>> In preparation for supporting large pages to be mapped by the GPU,
>> process faults one page at a time. In addition, use the hmm_range
>> default_flags to fix a corner case where the input hmm_pfns array
>> is not reinitialized after hmm_range_fault() returns -EBUSY and must
>> be called again.
> 
> Are you sure? hmm_range_fault is pretty expensive per call..
> 
> Jason
> 

Short answer is no, I'm not 100% sure.

The GPU might generate a list of dozens or hundreds of fault entries in the
same 4K page, or sequential 4K pages, or some other stride.
A single 2MB mapping might satisfy all of those after calling hmm_range_fault()
for the first fault entry and then skipping all the other fault entries
that fall into that range. So mostly, I'm proposing this change because it
makes handling the compound page case and -EBUSY case simpler.

As for performance, that is hard to say because nouveau is missing policies
for whether to migrate data to GPU memory on a fault or to map system memory.
Since GPU memory is much higher bandwidth, overall performance
can be much higher if the data is migrated to the GPU's local memory but
currently, migration is only performed explicitly under application request
(via OpenCL clEnqueueSVMMigrateMem() call).
If the GPU is only accessing system memory a few times, then it can be faster
to map system memory and not migrate the data so it depends on the application.
Then there is thrashing to consider if the GPU and CPU are both trying to
access the same pages...
