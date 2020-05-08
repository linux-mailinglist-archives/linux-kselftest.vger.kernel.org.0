Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F55F1CB894
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 21:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEHTve (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 15:51:34 -0400
Received: from verein.lst.de ([213.95.11.211]:54154 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHTve (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 15:51:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6EAA068C7B; Fri,  8 May 2020 21:51:30 +0200 (CEST)
Date:   Fri, 8 May 2020 21:51:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@linuxfoundation.org>, willy@infradead.org
Subject: Re: [PATCH 4/6] mm/hmm: add output flag for compound page mapping
Message-ID: <20200508195129.GA19740@lst.de>
References: <20200508192009.15302-1-rcampbell@nvidia.com> <20200508192009.15302-5-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508192009.15302-5-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 08, 2020 at 12:20:07PM -0700, Ralph Campbell wrote:
> hmm_range_fault() returns an array of page frame numbers and flags for
> how the pages are mapped in the requested process' page tables. The PFN
> can be used to get the struct page with hmm_pfn_to_page() and the page size
> order can be determined with compound_order(page) but if the page is larger
> than order 0 (PAGE_SIZE), there is no indication that the page is mapped
> using a larger page size. To be fully general, hmm_range_fault() would need
> to return the mapping size to handle cases like a 1GB compound page being
> mapped with 2MB PMD entries. However, the most common case is the mapping
> size the same as the underlying compound page size.
> Add a new output flag to indicate this so that callers know it is safe to
> use a large device page table mapping if one is available.

Why do you need the flag?  The caller should be able to just use
page_size() (or willys new thp_size helper).

