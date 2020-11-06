Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796132A9E99
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 21:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgKFUew (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 15:34:52 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9066 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgKFUew (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 15:34:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa5b36a0000>; Fri, 06 Nov 2020 12:34:50 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 20:34:49 +0000
Subject: Re: [PATCH v3 1/6] mm/thp: add prep_transhuge_device_private_page()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
 <20201106005147.20113-2-rcampbell@nvidia.com>
 <20201106121407.GQ17076@casper.infradead.org>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <e384a09a-23a2-6a9b-dda6-db93e26c8f66@nvidia.com>
Date:   Fri, 6 Nov 2020 12:34:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201106121407.GQ17076@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604694890; bh=3kQ//mMEobyQywMprE0fVaDOJaCYEqZr2rGa9riAH38=;
        h=Subject:To:CC:References:From:X-Nvconfidentiality:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ZfdPSy+wi5oJm1vMDFZi1SmNpeYM/8prR76BnNgoMkSMSy4w7h5WgBEzZsEPEcS7N
         DRqem5D7qEyAsyuyRSY1i0ypwydJcgYVspVqXuDd3UeWrYgNZ+wbrcfPkA1ygnQn0T
         CgmMWbi80T2WSfm1AmNpNcKF6QcMvRpiihkgA3C35EL15KcKT671+VzYGb8zgXxAOJ
         SLVF/22aNTf29FHM+5IKkAi7SOxnYjbRIIXFE+b9Kjh+qhWw4+VWDRnR6Wd7DV0QQw
         fSpOl7pA3HC2EoGrk4/m0ZED4KnZacd2J5rab7HOFIpKm/ZWATixv9WLIel2nUmv/A
         EnHQPaKIzWVMQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/6/20 4:14 AM, Matthew Wilcox wrote:
> On Thu, Nov 05, 2020 at 04:51:42PM -0800, Ralph Campbell wrote:
>> Add a helper function to allow device drivers to create device private
>> transparent huge pages. This is intended to help support device private
>> THP migrations.
> 
> I think you'd be better off with these calling conventions:
> 
> -void prep_transhuge_page(struct page *page)
> +struct page *thp_prep(struct page *page)
>   {
> +       if (!page || compound_order(page) == 0)
> +               return page;
>          /*
> -        * we use page->mapping and page->indexlru in second tail page
> +        * we use page->mapping and page->index in second tail page
>           * as list_head: assuming THP order >= 2
>           */
> +       BUG_ON(compound_order(page) == 1);
>   
>          INIT_LIST_HEAD(page_deferred_list(page));
>          set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
> +
> +       return page;
>   }
> 
> It simplifies the users.

I'm not sure what the simplification is.
If you mean the name change from prep_transhuge_page() to thp_prep(),
that seems fine to me. The following could also be renamed to
thp_prep_device_private_page() or similar.

>> +void prep_transhuge_device_private_page(struct page *page)
>> +{
>> +	prep_compound_page(page, HPAGE_PMD_ORDER);
>> +	prep_transhuge_page(page);
>> +	/* Only the head page has a reference to the pgmap. */
>> +	percpu_ref_put_many(page->pgmap->ref, HPAGE_PMD_NR - 1);
>> +}
>> +EXPORT_SYMBOL_GPL(prep_transhuge_device_private_page);
> 
> Something else that may interest you from my patch series is support
> for page sizes other than PMD_SIZE.  I don't know what page sizes 
> hardware supports.  There's no support for page sizes other than PMD
> for anonymous memory, so this might not be too useful for you yet.

I did see those changes. It might help some device drivers to do DMA in
larger than PAGE_SIZE blocks but less than PMD_SIZE. It might help
reduce page table sizes since 2MB, 64K, and 4K are commonly supported
GPU page sizes. The MIGRATE_PFN_COMPOUND flag is intended to indicate
that the page size is determined by page_size() so I was thinking ahead
to other than PMD sized pages. However, when migrating a pte_none() or
pmd_none() page, there is no source page to determine the size.
Maybe I need to encode the page order in the migrate PFN entry like
hmm_range_fault().

Anyway, I agree that thinking about page sizes other than PMD is good.
