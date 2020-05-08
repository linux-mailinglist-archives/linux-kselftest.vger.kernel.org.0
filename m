Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4991CB8C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 22:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHUG4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 16:06:56 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8438 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHUG4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 16:06:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb5bbd30000>; Fri, 08 May 2020 13:06:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 May 2020 13:06:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 May 2020 13:06:56 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 May
 2020 20:06:55 +0000
Subject: Re: [PATCH 4/6] mm/hmm: add output flag for compound page mapping
To:     Christoph Hellwig <hch@lst.de>
CC:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>, <willy@infradead.org>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
 <20200508192009.15302-5-rcampbell@nvidia.com> <20200508195129.GA19740@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <1ec0511f-e6eb-3e11-ad6d-ad4e5b107464@nvidia.com>
Date:   Fri, 8 May 2020 13:06:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200508195129.GA19740@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588968404; bh=1PhR0ynTTHTZ2jjSta5jo4Wils7Nsyx2BUSfOurLe2M=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ycs8GXkCLsC3dOjGwwVRiDFIa15xrlFp5dmFGRza+tkcfuZFMsD5xYyCaJ3SGXe5L
         MbsyET5GQuGbmktRrCTBcURNRpVyByNfAP6d32d3PQqHhfvXHl7hV3Vz6+jpL9f7XP
         CXbZOo+mS0n/H/P9XYRbSRpH1g1yZoCcRMaMatvBiqhLkjOZkUb5AO5td5VmqXKkE/
         sM80B5uZfLs+ocEiGdK/OF8louCokHaVcQ5PGDdXwn/0dQA98q3hte0xdQaR0KSK8o
         h1YgoYDiUJdbmaXyPqLW6c0Avqm1BAzTgQczQUQuWMpS3cwZcoVq5P9xL82BMqcFaC
         raNhF8Jy7jtaw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 5/8/20 12:51 PM, Christoph Hellwig wrote:
> On Fri, May 08, 2020 at 12:20:07PM -0700, Ralph Campbell wrote:
>> hmm_range_fault() returns an array of page frame numbers and flags for
>> how the pages are mapped in the requested process' page tables. The PFN
>> can be used to get the struct page with hmm_pfn_to_page() and the page size
>> order can be determined with compound_order(page) but if the page is larger
>> than order 0 (PAGE_SIZE), there is no indication that the page is mapped
>> using a larger page size. To be fully general, hmm_range_fault() would need
>> to return the mapping size to handle cases like a 1GB compound page being
>> mapped with 2MB PMD entries. However, the most common case is the mapping
>> size the same as the underlying compound page size.
>> Add a new output flag to indicate this so that callers know it is safe to
>> use a large device page table mapping if one is available.
> 
> Why do you need the flag?  The caller should be able to just use
> page_size() (or willys new thp_size helper).
> 

The question is whether or not a large page can be mapped with smaller
page table entries with different permissions. If one process has a 2MB
page mapped with 4K PTEs with different read/write permissions, I don't think
it would be OK for a device to map the whole 2MB with write access enabled.
The flag is supposed to indicate that the whole page can be mapped by the
device with the indicated read/write permissions.
