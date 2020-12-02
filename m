Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E519D2CBA31
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 11:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbgLBKJk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 05:09:40 -0500
Received: from verein.lst.de ([213.95.11.211]:53455 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388089AbgLBKJk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 05:09:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A8C467373; Wed,  2 Dec 2020 11:08:55 +0100 (CET)
Date:   Wed, 2 Dec 2020 11:08:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roger Pau Monne <roger.pau@citrix.com>
Subject: Re: [PATCH v3 3/6] mm: support THP migration to device private
 memory
Message-ID: <20201202100854.GB7597@lst.de>
References: <20201106005147.20113-1-rcampbell@nvidia.com> <20201106005147.20113-4-rcampbell@nvidia.com> <20201106080322.GE31341@lst.de> <a7b8b90c-09b7-2009-0784-908b61f61ef2@nvidia.com> <20201109091415.GC28918@lst.de> <bbf1f0df-85f3-5887-050e-beb2aad750f2@nvidia.com> <20201120200133.GH917484@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120200133.GH917484@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 20, 2020 at 04:01:33PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 11, 2020 at 03:38:42PM -0800, Ralph Campbell wrote:
> 
> > MEMORY_DEVICE_GENERIC:
> > Struct pages are created in dev_dax_probe() and represent non-volatile memory.
> > The device can be mmap()'ed which calls dax_mmap() which sets
> > vma->vm_flags | VM_HUGEPAGE.
> > A CPU page fault will result in a PTE, PMD, or PUD sized page
> > (but not compound) to be inserted by vmf_insert_mixed() which will call either
> > insert_pfn() or insert_page().
> > Neither insert_pfn() nor insert_page() increments the page reference
> > count.
> 
> But why was this done? It seems very strange to put a pfn with a
> struct page into a VMA and then deliberately not take the refcount for
> the duration of that pfn being in the VMA?
> 
> What prevents memunmap_pages() from progressing while VMAs still point
> at the memory?

Agreed.  Adding Roger who added MEMORY_DEVICE_GENERIC and the only
user.

> > I think just leaving the page reference count at one is better than trying
> > to use the mmu_interval_notifier or changing vmf_insert_mixed() and
> > invalidations of pfn_t_devmap(pfn) to adjust the page reference count.
> 
> Why so? The entire point of getting struct page's for this stuff was
> to be able to follow the struct page flow. I never did learn a reason
> why there is devmap stuff all over the place in the page table code...

Exactly.
