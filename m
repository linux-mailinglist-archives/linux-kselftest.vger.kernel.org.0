Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DBB21BE53
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGJUNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 16:13:48 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17155 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJUNr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 16:13:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f08cb8e0000>; Fri, 10 Jul 2020 13:11:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 13:13:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Jul 2020 13:13:47 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 20:13:46 +0000
Subject: Re: [PATCH v3 0/5] mm/hmm/nouveau: add PMD system memory mapping
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Ben Skeggs <bskeggs@redhat.com>
References: <20200701225352.9649-1-rcampbell@nvidia.com>
 <20200710192704.GA2128670@nvidia.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <886151ff-c8e7-7b49-cc8d-c0e32fdc770b@nvidia.com>
Date:   Fri, 10 Jul 2020 13:13:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200710192704.GA2128670@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594411918; bh=kBUZGsLnFvs5AsR2jhrWWoSLsoCM1L3w7Wtbc0qtxj0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=K3Dzp89zmicqXa+y0n8OOLym6kCUeazXTrxWKuXyC/tYXivwEn0t+LYOLybh7UIRs
         Whs4nbq3XhoKckYmk5hxdDJJSjc6+tcenmizLcZ+9hITHo2ymlHwDKw/KzgD4jXqsf
         CXDG/OIoOriWZjxSZ++/DUQBySlgupmLwEWHAfvI027WffQPvJ7ZoaeX/h+2ZvgYeP
         j7WWMTd0i9jcYA2k64awuSTUKnT1Qh+ex05aqZegl13YwSrWZKL4+LHbSpgsqYIP3I
         GJp51Ge7rgvO8jvpE3yAqsR2Hr4rRbjWfc9fbzbffbmYY0FtlkVHSYd1HMRqVZkjgo
         2VapRmOWglIeg==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 7/10/20 12:27 PM, Jason Gunthorpe wrote:
> On Wed, Jul 01, 2020 at 03:53:47PM -0700, Ralph Campbell wrote:
>> The goal for this series is to introduce the hmm_pfn_to_map_order()
>> function. This allows a device driver to know that a given 4K PFN is
>> actually mapped by the CPU using a larger sized CPU page table entry and
>> therefore the device driver can safely map system memory using larger
>> device MMU PTEs.
>> The series is based on 5.8.0-rc3 and is intended for Jason Gunthorpe's
>> hmm tree. These were originally part of a larger series:
>> https://lore.kernel.org/linux-mm/20200619215649.32297-1-rcampbell@nvidia.com/
>>
>> Changes in v3:
>> Replaced the HMM_PFN_P[MU]D flags with hmm_pfn_to_map_order() to
>> indicate the size of the CPU mapping.
>>
>> Changes in v2:
>> Make the hmm_range_fault() API changes into a separate series and add
>>    two output flags for PMD/PUD instead of a single compund page flag as
>>    suggested by Jason Gunthorpe.
>> Make the nouveau page table changes a separate patch as suggested by
>>    Ben Skeggs.
>> Only add support for 2MB nouveau mappings initially since changing the
>> 1:1 CPU/GPU page table size assumptions requires a bigger set of changes.
>> Rebase to 5.8.0-rc3.
>>
>> Ralph Campbell (5):
>>    nouveau/hmm: fault one page at a time
>>    mm/hmm: add hmm_mapping order
>>    nouveau: fix mapping 2MB sysmem pages
>>    nouveau/hmm: support mapping large sysmem pages
>>    hmm: add tests for HMM_PFN_PMD flag
> 
> Applied to hmm.git.
> 
> I edited the comment for hmm_pfn_to_map_order() and added a function
> to compute the field.
> 
> Thanks,
> Jason

Looks good, thanks.
