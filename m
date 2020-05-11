Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746191CE140
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgEKRH7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 13:07:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15926 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730629AbgEKRH6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 13:07:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb985e60001>; Mon, 11 May 2020 10:05:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 May 2020 10:07:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 May 2020 10:07:57 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 May
 2020 17:07:55 +0000
Subject: Re: [PATCH 0/6] nouveau/hmm: add support for mapping large pages
To:     Matthew Wilcox <willy@infradead.org>
CC:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
 <20200508195910.GR16070@bombadil.infradead.org>
 <72422dca-e025-002a-4748-addfb392ffc4@nvidia.com>
 <20200509031726.GT16070@bombadil.infradead.org>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <04fed5a1-c777-8594-c869-8598da75c340@nvidia.com>
Date:   Mon, 11 May 2020 10:07:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200509031726.GT16070@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589216743; bh=5oKgOrWxFtRItgwWbbX4dX3IJlUBjgRpH2Q5E+LjAio=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OpPUg5qPadBLT2WMtDkFVSx1PU9l5XTlfujhBDah4+b+jb4sxdwysG11lCtk2/xjG
         ZZc+yxggAmSqznAmdePCk698sDTG7bnEe7CwGuZUqbPtPyduUjLGGxIJn9t/ynp/8j
         QGPR7nXHwb4C6S7TZTAmZuBI824KxdVOA0Sq5ufqsu0/fv78Q+wPKioP4bmhmrj665
         5lOUd6gqS2CdhwER+fASC4KLsI9TbX1B2lF7M24Dtew5334lFke6chdhjkzH5GgSQ2
         ybXwF8cXBiD7RQpF2G7PJ5s0VXLkOR3aRrlm0mFtq69KbAZBP0vgd8lrUSML0egUxV
         MJc2OIDizYv7w==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 5/8/20 8:17 PM, Matthew Wilcox wrote:
> On Fri, May 08, 2020 at 01:17:55PM -0700, Ralph Campbell wrote:
>> On 5/8/20 12:59 PM, Matthew Wilcox wrote:
>>> On Fri, May 08, 2020 at 12:20:03PM -0700, Ralph Campbell wrote:
>>>> hmm_range_fault() returns an array of page frame numbers and flags for
>>>> how the pages are mapped in the requested process' page tables. The PFN
>>>> can be used to get the struct page with hmm_pfn_to_page() and the page size
>>>> order can be determined with compound_order(page) but if the page is larger
>>>> than order 0 (PAGE_SIZE), there is no indication that the page is mapped
>>>> using a larger page size. To be fully general, hmm_range_fault() would need
>>>> to return the mapping size to handle cases like a 1GB compound page being
>>>> mapped with 2MB PMD entries. However, the most common case is the mapping
>>>> size the same as the underlying compound page size.
>>>> This series adds a new output flag to indicate this so that callers know it
>>>> is safe to use a large device page table mapping if one is available.
>>>> Nouveau and the HMM tests are updated to use the new flag.
>>>
>>> This explanation doesn't make any sense.  It doesn't matter how somebody
>>> else has it mapped; if it's a PMD-sized page, you can map it with a
>>> 2MB mapping.
>>
>> Sure, the I/O will work OK, but is it safe?
>> Copy on write isn't an issue? splitting a PMD in one process due to
>> mprotect of a shared page will cause other process' page tables to be split
>> the same way?
> 
> Are you saying that if you call this function on an address range of a
> process which has done COW of a single page in the middle of a THP,
> you want to return with this flag clear, but if the THP is still intact,
> you want to set this flag?

Correct. I want the GPU to see the same faults that the CPU would see when trying
to access the same addresses. All faults, whether from CPU or GPU, end up calling
handle_mm_fault() to handle the fault and update the GPU/CPU page tables.

>> Recall that these are system memory pages that could be THPs, shmem, hugetlbfs,
>> mmap shared file pages, etc.
