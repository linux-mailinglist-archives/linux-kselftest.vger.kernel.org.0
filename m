Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5282E2A90E0
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 09:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKFIBw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 03:01:52 -0500
Received: from verein.lst.de ([213.95.11.211]:50484 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgKFIBv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 03:01:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A9C9068B05; Fri,  6 Nov 2020 09:01:47 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:01:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ben Skeggs <bskeggs@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 4/6] mm/thp: add THP allocation helper
Message-ID: <20201106080147.GD31341@lst.de>
References: <20201106005147.20113-1-rcampbell@nvidia.com> <20201106005147.20113-5-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106005147.20113-5-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +extern struct page *alloc_transhugepage(struct vm_area_struct *vma,
> +					unsigned long addr);

No need for the extern.  And also here: do we actually need the stub,
or can the caller make sure (using IS_ENABLED and similar) that the
compiler knows the code is dead?

> +struct page *alloc_transhugepage(struct vm_area_struct *vma,
> +				 unsigned long haddr)
> +{
> +	gfp_t gfp;
> +	struct page *page;
> +
> +	gfp = alloc_hugepage_direct_gfpmask(vma);
> +	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
> +	if (page)
> +		prep_transhuge_page(page);
> +	return page;

I think do_huge_pmd_anonymous_page should be switched to use this
helper as well.
