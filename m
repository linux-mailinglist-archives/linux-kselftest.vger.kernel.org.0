Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597682BB632
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Nov 2020 21:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgKTUBp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Nov 2020 15:01:45 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:16759 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbgKTUBo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Nov 2020 15:01:44 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb820a70004>; Sat, 21 Nov 2020 04:01:43 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Nov
 2020 20:01:38 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 20 Nov 2020 20:01:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzVcSizvsxf4yCVuRNWmvdeJ4G3cPgLEAA/d72jV8W7xeLtG/rXrobzqF/+YvI3D+P4564dq70E8sgcnPMryK/X6h74JMSr9Um4r3EVHV2JwVk5MbSPaj9oQpCPHRE05Sp2kG+ROOI3fLWwVEDRFTnUuLSU4A6C3H1Xuzi+nJv+VgND0oA6l9mB10IuqTgazCY7znEjG1lOHB9DqdPCo3n+AAmI5gGE7lOiH37xZzGgy4wxmQ/POjrjPo6Ng02KnGWxoPQFSYUIkiN79Da5a/HA5B0InekhyGSBzS4/FmfXnLQF4yLlA9v4/rxXMVUbjuPscaYfSrZe3YdbKds0JdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFfp8hz1DSdZvGULg6OJS/UGwcunZv40bBdS/Y5/ieE=;
 b=Gknug4ZDgH9xKjS8xdBlHwLnwHYfDcYOocagXQ13v7PVMNe0U4eewnzCiTRfnZ6X7HfZSgNwH/17JurhmX7v/MRaVdxRsG2RVRa8dLWI4oN8q5eAhgJjCQnPhQ5OBJ5xywdfYrJ/h7BcFHORBEQh0yvgXV/jGU/parERfCJRA6TNM/nWYQb+NV+pw/cC9oED4A5zIWrCKw49QXrzziLWooZuyQZ9hWzvuKm8Z9wqJB5L5EYOVfdI6gK9Jw8N8VgGG3+SEAHG5WddvS6MQqUyhmzhb/vVc1xwdeA69uvd7tQGAxvaBiqXfC3GqvpUlE6RnHQaV3oHePztJbUgbYj3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 20:01:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 20:01:35 +0000
Date:   Fri, 20 Nov 2020 16:01:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Christoph Hellwig <hch@lst.de>, <linux-mm@kvack.org>,
        <nouveau@lists.freedesktop.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/6] mm: support THP migration to device private memory
Message-ID: <20201120200133.GH917484@nvidia.com>
References: <20201106005147.20113-1-rcampbell@nvidia.com>
 <20201106005147.20113-4-rcampbell@nvidia.com> <20201106080322.GE31341@lst.de>
 <a7b8b90c-09b7-2009-0784-908b61f61ef2@nvidia.com>
 <20201109091415.GC28918@lst.de>
 <bbf1f0df-85f3-5887-050e-beb2aad750f2@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bbf1f0df-85f3-5887-050e-beb2aad750f2@nvidia.com>
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:01:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kgCb7-008wuP-OH; Fri, 20 Nov 2020 16:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605902503; bh=IFfp8hz1DSdZvGULg6OJS/UGwcunZv40bBdS/Y5/ieE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=kEd8yQ8SWwe0ENlF6IPdDz1ts9iHDbWIpG2xLqqwwl4/XwyPtzkpkomCvABqpYeZ7
         /V4kqwKMkZ7/bCpZh9GNf1SBWcxDOfGH0wuOFKSbJA8JqmEmSjy8x1tJ2JTy82OGTa
         CnMR56uNxSmQuXrBWQsxzlpTWAx7OMgcZCZTJDWl5DjFZVN2vazZ3dGz2I4N7dO9Om
         niay8qxI/PQtDxIpjbRZkj11WHNZd6vLTu0dHk0VWuXPPa3RRdeCWrhwEbdqS9LxmB
         BNuo4jRG+X4PxBy0puRkATAIBo7tx3kk+fgelHEIUhlc+zHo6GcbIGJxTX//0m5cqU
         dr6NeWVeV1kpQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 11, 2020 at 03:38:42PM -0800, Ralph Campbell wrote:

> MEMORY_DEVICE_GENERIC:
> Struct pages are created in dev_dax_probe() and represent non-volatile memory.
> The device can be mmap()'ed which calls dax_mmap() which sets
> vma->vm_flags | VM_HUGEPAGE.
> A CPU page fault will result in a PTE, PMD, or PUD sized page
> (but not compound) to be inserted by vmf_insert_mixed() which will call either
> insert_pfn() or insert_page().
> Neither insert_pfn() nor insert_page() increments the page reference
> count.

But why was this done? It seems very strange to put a pfn with a
struct page into a VMA and then deliberately not take the refcount for
the duration of that pfn being in the VMA?

What prevents memunmap_pages() from progressing while VMAs still point
at the memory?

> I think just leaving the page reference count at one is better than trying
> to use the mmu_interval_notifier or changing vmf_insert_mixed() and
> invalidations of pfn_t_devmap(pfn) to adjust the page reference count.

Why so? The entire point of getting struct page's for this stuff was
to be able to follow the struct page flow. I never did learn a reason
why there is devmap stuff all over the place in the page table code...

> MEMORY_DEVICE_FS_DAX:
> Struct pages are created in pmem_attach_disk() and virtio_fs_setup_dax() with
> an initial reference count of one.
> The problem I see is that there are 3 states that are important:
> a) memory is free and not allocated to any file (page_ref_count() == 0).
> b) memory is allocated to a file and in the page cache (page_ref_count() == 1).
> c) some gup() or I/O has a reference even after calling unmap_mapping_pages()
>    (page_ref_count() > 1). ext4_break_layouts() basically waits until the
>    page_ref_count() == 1 with put_page() calling wake_up_var(&page->_refcount)
>    to wake up ext4_break_layouts().
> The current code doesn't seem to distinguish (a) and (b). If we want to use
> the 0->1 reference count to signal (c), then the page cache would have hold
> entries with a page_ref_count() == 0 which doesn't match the general page cache
> assumptions.

This explanation feels confusing. If *anything* has a reference on the
page it cannot be recycled. I would have guess the logic is to remove
it from the page cache then wait for a 0 reference??

Jason
