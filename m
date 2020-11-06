Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69882A9EC0
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgKFU4x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 15:56:53 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18697 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgKFU4w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 15:56:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa5b8980001>; Fri, 06 Nov 2020 12:56:56 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 20:56:47 +0000
Subject: Re: [PATCH v3 1/6] mm/thp: add prep_transhuge_device_private_page()
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
 <20201106005147.20113-2-rcampbell@nvidia.com> <20201106075554.GA31341@lst.de>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <e2d3b996-e1a9-ccc1-8b7a-31df840b8ebb@nvidia.com>
Date:   Fri, 6 Nov 2020 12:56:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201106075554.GA31341@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604696216; bh=GkUJF2wcwNFtVtDfugtak/8XayWbGhH8zDvyol5BTOw=;
        h=Subject:To:CC:References:From:X-Nvconfidentiality:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=lbkHqjuGwbH6A6WGPayoyWp6kjVQqyl+1HlMHQmgnRCG7ImrV+QA3prCNDi0hcHWH
         5pgzBx1Xdiu5ctXNK+U2GWo6yTLpp7AtFcK24oWgkl+tyshpzWKi3wj8nIybRWGRq2
         vRu4YZvc9pShH8njactRwiAh/sEg82BOK8FELyMy+kNsdPDnon5t2NINVetSuGRljd
         L/lVTVqhiQ9zwL+4m/hesd8jxRBj9zubOwR/SkuakblzyCIaImrr+oUvIdccAr+kza
         /OQJ0ZnhXsT5Tg7g8aJFNe/0xgH5aKdy9g16stNGBndeYj4+WjornFrjd3asoPuc4z
         qcYOZNQNpXU9w==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/5/20 11:55 PM, Christoph Hellwig wrote:
> On Thu, Nov 05, 2020 at 04:51:42PM -0800, Ralph Campbell wrote:
>> +extern void prep_transhuge_device_private_page(struct page *page);
> 
> No need for the extern.

Right, I was just copying the style.
Would you like to see a preparatory patch that removes extern for the other
declarations in huge_mm.h?

>> +static inline void prep_transhuge_device_private_page(struct page *page)
>> +{
>> +}
> 
> Is the code to call this even reachable if THP support is configured
> out?  If not just declaring it unconditionally and letting dead code
> elimination do its job might be a tad cleaner.

The HMM test driver depends on TRANSPARENT_HUGEPAGE but the nouveau SVM
option doesn't and SVM is still useful if TRANSPARENT_HUGEPAGE is not configured.

The problem with defining prep_transhuge_device_private_page() in huge_mm.h
as a static inline function is that prep_compound_page() and prep_transhuge_page()
would have to be EXPORT_SYMBOL_GPL which are currently mm internal only.
The intent is to make this helper callable by separate device driver modules
using struct pages created with memremap_pages().

>> +void prep_transhuge_device_private_page(struct page *page)
> 
> I think a kerneldoc comment explaining what this function is useful for
> would be helpful.

That is a good idea. I'll add it to v4.
