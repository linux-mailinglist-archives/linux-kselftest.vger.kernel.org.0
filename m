Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E1D1CBCE7
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 May 2020 05:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgEIDRc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 23:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgEIDRc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 23:17:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D35C061A0C;
        Fri,  8 May 2020 20:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lyg8KFPxTn0tWshWc1x4r9ezlzCrdRUk1alOb1U8QOk=; b=mjzVRHGSFUzWCtzv5ct3WCVzIJ
        ctNdyru+3tw2Jx6byTHTJQdaLOT6wypRAwM0vM2BA4uTaZtqgBMteST/YjZJAGCjBwcYThXJPE7/x
        yKqdUpYrah7TLL+CgNUvGMi7er7Ds8YVx/LcngEtraSyPD7EPowngkYGh2oEmoNlgi8apHTbQjn/V
        buoEqQ4HLNZNOjPcy+7VUaM1SwZI2P+rqXh0qrcN0izk711h14xjyY8hAK7g2BXziyMosb87vaZUW
        IzKvDkrSzkQsUUdLQZC3Zpq8nEMRjyBLe+cpQChBogC+1GMjV2EmiLtnG0vtSzWy/cSY+ZO6ik0mL
        /JrDhQLw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXFzS-0001xm-Dk; Sat, 09 May 2020 03:17:26 +0000
Date:   Fri, 8 May 2020 20:17:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/6] nouveau/hmm: add support for mapping large pages
Message-ID: <20200509031726.GT16070@bombadil.infradead.org>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
 <20200508195910.GR16070@bombadil.infradead.org>
 <72422dca-e025-002a-4748-addfb392ffc4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72422dca-e025-002a-4748-addfb392ffc4@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 08, 2020 at 01:17:55PM -0700, Ralph Campbell wrote:
> On 5/8/20 12:59 PM, Matthew Wilcox wrote:
> > On Fri, May 08, 2020 at 12:20:03PM -0700, Ralph Campbell wrote:
> > > hmm_range_fault() returns an array of page frame numbers and flags for
> > > how the pages are mapped in the requested process' page tables. The PFN
> > > can be used to get the struct page with hmm_pfn_to_page() and the page size
> > > order can be determined with compound_order(page) but if the page is larger
> > > than order 0 (PAGE_SIZE), there is no indication that the page is mapped
> > > using a larger page size. To be fully general, hmm_range_fault() would need
> > > to return the mapping size to handle cases like a 1GB compound page being
> > > mapped with 2MB PMD entries. However, the most common case is the mapping
> > > size the same as the underlying compound page size.
> > > This series adds a new output flag to indicate this so that callers know it
> > > is safe to use a large device page table mapping if one is available.
> > > Nouveau and the HMM tests are updated to use the new flag.
> > 
> > This explanation doesn't make any sense.  It doesn't matter how somebody
> > else has it mapped; if it's a PMD-sized page, you can map it with a
> > 2MB mapping.
> 
> Sure, the I/O will work OK, but is it safe?
> Copy on write isn't an issue? splitting a PMD in one process due to
> mprotect of a shared page will cause other process' page tables to be split
> the same way?

Are you saying that if you call this function on an address range of a
process which has done COW of a single page in the middle of a THP,
you want to return with this flag clear, but if the THP is still intact,
you want to set this flag?

> Recall that these are system memory pages that could be THPs, shmem, hugetlbfs,
> mmap shared file pages, etc.
