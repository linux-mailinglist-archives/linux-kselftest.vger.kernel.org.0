Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D351E28E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 19:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgEZRct (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 13:32:49 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1308 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEZRct (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 13:32:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecd52680001>; Tue, 26 May 2020 10:31:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 10:32:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 May 2020 10:32:49 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 17:32:48 +0000
Subject: Re: [PATCH 0/6] nouveau/hmm: add support for mapping large pages
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@linuxfoundation.org>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
 <20200525134118.GA2536@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <4743ec6e-a5a0-16ac-a1b8-992f851515f0@nvidia.com>
Date:   Tue, 26 May 2020 10:32:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200525134118.GA2536@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590514280; bh=gY1xHSzU0BixoChtgpMiGs26xB1k45JS1OITIdF0cPM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YT6X8ZnMP3j2H98e/7bMTxvdcizzJii7qVVjHUfEFojmdIyhUbS3YLngjP0oO5mnQ
         vMVFflzmbMRnAtJAvCGfn27zgKrru6NNKyc6215BVmJQv5P2SlhTOzfdIOtvkLILKd
         eK8IB+aZBBKf+9QcOz3hHhbFq48EGMdTwSkqFXiaK8tMiGfqpR2y6WIl0vArwJinF8
         /M/m6VN4l777oH6kgroSbuBL3/KyGVYBbYUEe3EsIObrnVtyX6ZE2IQ8g16O645XNw
         OzjiUse4raMuhGPim7qMXfvYnXckCIUkzcKfIwBj1rHL5NI2x3jIWhjAqGjyqJWX9L
         bsa3lTJ9hIpqw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 5/25/20 6:41 AM, Jason Gunthorpe wrote:
> On Fri, May 08, 2020 at 12:20:03PM -0700, Ralph Campbell wrote:
>> hmm_range_fault() returns an array of page frame numbers and flags for
>> how the pages are mapped in the requested process' page tables. The PFN
>> can be used to get the struct page with hmm_pfn_to_page() and the page size
>> order can be determined with compound_order(page) but if the page is larger
>> than order 0 (PAGE_SIZE), there is no indication that the page is mapped
>> using a larger page size. To be fully general, hmm_range_fault() would need
>> to return the mapping size to handle cases like a 1GB compound page being
>> mapped with 2MB PMD entries. However, the most common case is the mapping
>> size the same as the underlying compound page size.
>> This series adds a new output flag to indicate this so that callers know it
>> is safe to use a large device page table mapping if one is available.
>> Nouveau and the HMM tests are updated to use the new flag.
>>
>> Note that this series depends on a patch queued in Ben Skeggs' nouveau
>> tree ("nouveau/hmm: map pages after migration") and the patches queued
>> in Jason's HMM tree.
>> There is also a patch outstanding ("nouveau/hmm: fix nouveau_dmem_chunk
>> allocations") that is independent of the above and could be applied
>> before or after.
> 
> Did Christoph and Matt's remarks get addressed here?

Both questioned the need to add the HMM_PFN_COMPOUND flag to the
hmm_range_fault() output array saying that the PFN can be used to get the
struct page pointer and the page can be examined to determine the page size.
My response is that while is true, it is also important that the device only
access the same parts of a large page that the process/cpu has access to.
There are places where a large page is mapped with smaller page table entries
when a page is shared by multiple processes.
After I explained this, I haven't seen any further comments from Christoph
and Matt. I'm still looking for reviews, acks, or suggested changes.


> I think ODP could use something like this, currently it checks every
> page to get back to the huge page size and this flag would optimze
> that
> 
> Jason
