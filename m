Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274C61D5D73
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 May 2020 02:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEPA4N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 May 2020 20:56:13 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15066 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgEPA4N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 May 2020 20:56:13 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebf3a200000>; Fri, 15 May 2020 17:56:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 15 May 2020 17:56:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 15 May 2020 17:56:12 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 16 May
 2020 00:56:10 +0000
Subject: Re: [PATCH] mm/hmm/test: destroy xa_array instead of looping
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20200513214507.30592-1-rcampbell@nvidia.com>
 <20200515231538.GD24561@mellanox.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <ad8dfe8f-7c4c-12e8-9251-89e3d7fb242d@nvidia.com>
Date:   Fri, 15 May 2020 17:56:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200515231538.GD24561@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589590560; bh=NhBCoaCRWwssiHRuS3xyxevAb+KCgQoaTCdzXg1ITHY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qTQeteg5qrAId4asjZOdDSQniDmaYrOBSh/LU1Do4auOQVVwJbiU1xRCGXl1jK6ct
         aVjUR04LI8BA0CxVpvIdj2oyaJrKSjcgCYbXVrkOjMWpyFL0whmXJ1SSKX7PiLhKq5
         MT+FL57PzrZwzQo9lTfUjVdwXqGyF5AzlZF3xzrqmR6d8J3omRLXE5ai+C6+ftyORg
         IDqEYISElmzyt+Y6S+bUi1zbrcFIAZC1MZD7CnKIAUSdCq2VMPP6zOi2mMngOoIitS
         mGvD6YUI8EZhmAOx/z/SSfrwD/SuY59oEESVjx5sSwg8zdHXlOgc7neLQ6wbbQHLhW
         9Vjg/rHgCT9Cw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 5/15/20 4:15 PM, Jason Gunthorpe wrote:
> On Wed, May 13, 2020 at 02:45:07PM -0700, Ralph Campbell wrote:
>> The test driver uses an xa_array to store virtual to physical address
>> translations for a simulated hardware device. The MMU notifier
>> invalidation callback is used to keep the table consistent with the CPU
>> page table and is frequently called only for a page or two. However, if
>> the test process exits unexpectedly or is killed, the range can be
>> [0..ULONG_MAX] in which case calling xa_erase() for every possible PFN
>> results in CPU timeouts. Munmap() can result in a large range being
>> invalidated but in that case, the xa_array is likely to contain entries
>> that need to be invalidated.
>> Check for [0..ULONG_MAX] explicitly and just destroy the whole table.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>>
>> This patch is based on Jason Gunthorpe's hmm tree and should be folded
>> into the ("mm/hmm/test: add selftest driver for HMM") patch once this
>> patch is reviewed, etc.
>>
>>   lib/test_hmm.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>> index 8b36c26b717b..b89852ec3c29 100644
>> +++ b/lib/test_hmm.c
>> @@ -201,7 +201,13 @@ static void dmirror_do_update(struct dmirror *dmirror, unsigned long start,
>>   	 * The XArray doesn't hold references to pages since it relies on
>>   	 * the mmu notifier to clear page pointers when they become stale.
>>   	 * Therefore, it is OK to just clear the entry.
>> +	 * However, if the entire address space is being invalidated, it
>> +	 * takes too long to clear them one at a time so destroy the array.
>>   	 */
>> +	if (start == 0 && end == ULONG_MAX) {
>> +		xa_destroy(&dmirror->pt);
>> +		return;
>> +	}
>>   	for (pfn = start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++)
>>   		xa_erase(&dmirror->pt, pfn);
>>   }
> 
> Just use xa_for_each_range() instead of the naive loop, it already
> optimizes against membership and avoids the need for the xa_destroy
> hack
> 
> Jason
> 

For some reason I had looked at that and rejected it but of course, it works
fine. :-)
Thanks!
