Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999A221BAA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jul 2020 18:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGJQUE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 12:20:04 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2162 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJQUE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 12:20:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0894c70000>; Fri, 10 Jul 2020 09:18:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 09:20:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Jul 2020 09:20:04 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 16:19:57 +0000
Subject: Re: [PATCH 1/2] mm/migrate: optimize migrate_vma_setup() for holes
To:     <bharata@linux.ibm.com>
CC:     <linux-mm@kvack.org>, <kvm-ppc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200709165711.26584-1-rcampbell@nvidia.com>
 <20200709165711.26584-2-rcampbell@nvidia.com>
 <20200710063509.GE7902@in.ibm.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <72557537-3d64-7082-11f7-d70b41f7d0e6@nvidia.com>
Date:   Fri, 10 Jul 2020 09:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200710063509.GE7902@in.ibm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594397895; bh=Ue/frzFxUQ5xNe2FlvXb4r/DHKPE3j0pZwT+2iMRx4s=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CsSiPpre9qxK1jS02numnr4cfl7QmxJ0/oYmekUMhjtq34QymiInNuhlkiCDn0E7p
         Bl+cgS3sGUonpda8dBJFP7ibbOFONADHdtgHtgcRKvXQArVDB0uEePCFyqO8B5UHlb
         KR1pBKdSmVPdg062vI5u3K6IVK2DExOIGzrUf2dX5pQySstXbXRvhrXpWDd6xWF+c8
         TMjfbHedmpP4pZt21f75Zm+hj4lVqe8Ny94gFMGjxbEqdutYx1QT/u3g8DBXsjb5a0
         DtGKN67dVzTn8mziAEBNJI/0nEz200XIpALyu/RdCHrI+Df8RJivh9s4L720y+2BV3
         M0oTYVkJHwS9g==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 7/9/20 11:35 PM, Bharata B Rao wrote:
> On Thu, Jul 09, 2020 at 09:57:10AM -0700, Ralph Campbell wrote:
>> When migrating system memory to device private memory, if the source
>> address range is a valid VMA range and there is no memory or a zero page,
>> the source PFN array is marked as valid but with no PFN. This lets the
>> device driver allocate private memory and clear it, then insert the new
>> device private struct page into the CPU's page tables when
>> migrate_vma_pages() is called. migrate_vma_pages() only inserts the
>> new page if the VMA is an anonymous range. There is no point in telling
>> the device driver to allocate device private memory and then not migrate
>> the page. Instead, mark the source PFN array entries as not migrating to
>> avoid this overhead.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> ---
>>   mm/migrate.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index b0125c082549..8aa434691577 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2204,9 +2204,13 @@ static int migrate_vma_collect_hole(unsigned long start,
>>   {
>>   	struct migrate_vma *migrate = walk->private;
>>   	unsigned long addr;
>> +	unsigned long flags;
>> +
>> +	/* Only allow populating anonymous memory. */
>> +	flags = vma_is_anonymous(walk->vma) ? MIGRATE_PFN_MIGRATE : 0;
>>   
>>   	for (addr = start; addr < end; addr += PAGE_SIZE) {
>> -		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
>> +		migrate->src[migrate->npages] = flags;
> 
> I see a few other such cases where we directly populate MIGRATE_PFN_MIGRATE
> w/o a pfn in migrate_vma_collect_pmd() and wonder why the vma_is_anonymous()
> check can't help there as well?
> 
> 1. pte_none() check in migrate_vma_collect_pmd()
> 2. is_zero_pfn() check in migrate_vma_collect_pmd()
> 
> Regards,
> Bharata.

For case 1, this seems like a useful addition.
For case 2, the zero page is only inserted if the VMA is marked read-only and
anonymous so I don't think the check is needed.
I'll post a v2 with the change.

Thanks for the suggestions!
