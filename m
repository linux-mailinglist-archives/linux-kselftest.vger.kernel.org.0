Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA02A9EDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 22:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgKFVJd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 16:09:33 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11447 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgKFVJc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 16:09:32 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa5bb8a0001>; Fri, 06 Nov 2020 13:09:30 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 21:09:27 +0000
Subject: Re: [PATCH v3 4/6] mm/thp: add THP allocation helper
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
 <20201106005147.20113-5-rcampbell@nvidia.com> <20201106080147.GD31341@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <7cac5437-c5b1-25e2-f98a-c0a6c9af7ac6@nvidia.com>
Date:   Fri, 6 Nov 2020 13:09:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201106080147.GD31341@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604696970; bh=9yPdLjLMk4VDQyCtkT8t7GZNpDCZAji0utGt1xU6RII=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=FulphIc/so5+6aTPESZcFxW8h9OUZ2iyqmutRPbl18GBVLgAyX6fz4lJiev0O1YP6
         q/LNpjbRlW3SKWvukveekDhx0gjNTyauAUv90vIV2i9n949F8fptDvzdatTN74Gl7/
         f/PC1ihNAUIC/qOVlVty9n9Gv7EjknTWE+2q/GosGmlHMzqzSzMcN6nR1s0OIgCca4
         6FVZ7++xm6YWl9ul+2YLkZMvUsD6rl4gbVZX0+FR9xXlYHr9pjH9J0BMXIsVl3xfcX
         BMkE3aZvmR0guP2wjHWUqdDJJ5GlhtqIrC+NpmZfIIYGBbHGCrNbb22hcdjF6jg8XS
         Yq5UDWS1nzT6A==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/6/20 12:01 AM, Christoph Hellwig wrote:
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +extern struct page *alloc_transhugepage(struct vm_area_struct *vma,
>> +					unsigned long addr);
> 
> No need for the extern.  And also here: do we actually need the stub,
> or can the caller make sure (using IS_ENABLED and similar) that the
> compiler knows the code is dead?

Same problem as with prep_transhuge_device_private_page(), since
alloc_hugepage_direct_gfpmask() and alloc_hugepage_vma() are not
EXPORT_SYMBOL_GPL.

>> +struct page *alloc_transhugepage(struct vm_area_struct *vma,
>> +				 unsigned long haddr)
>> +{
>> +	gfp_t gfp;
>> +	struct page *page;
>> +
>> +	gfp = alloc_hugepage_direct_gfpmask(vma);
>> +	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
>> +	if (page)
>> +		prep_transhuge_page(page);
>> +	return page;
> 
> I think do_huge_pmd_anonymous_page should be switched to use this
> helper as well.

Sure, I'll do that for v4.
