Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFCA1E0FA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 May 2020 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbgEYNlW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 May 2020 09:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390796AbgEYNlV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 May 2020 09:41:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8525FC08C5C0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 May 2020 06:41:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b27so7471557qka.4
        for <linux-kselftest@vger.kernel.org>; Mon, 25 May 2020 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gPDO3X5exveNuQB33sqGwYFDtLpn1MHpqh7qgx9Ds0U=;
        b=YWisdnilIhfDrM+E+SxMXaOOM3S8J0owofy6L63tPMKNlQpTOnDBXaJIGIpfLVuv8e
         RPwFtQIUH3v7EOrCTGWLmLB0H7YbUEomLIfmYte8O6ZPx64QjusgkIxmiTn0/Veefq7M
         pGEt8yH0t/vwgIpSl+RtDysE0yr6nJS4JK3YSde04NTeyPjZmiEOJpHUKytYk9YebMaP
         ZBwTqRWOlcbPbyxbCtPg/99VSLhwlIy3blfpxEsFWPNLZqUxUrAIQcRPOOcELjbAp/DY
         UMb0QDSHWVMTyUFW5IIroZvxqvroUZ4aOu//kLYALqNBVGf71IaS4QGAehurQ0LEWc+H
         VK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gPDO3X5exveNuQB33sqGwYFDtLpn1MHpqh7qgx9Ds0U=;
        b=Xs8bQY7gwezFBrzLfYiAI+ho+t9VdSJEHFgN3Ty5PGpFpWaDXs2ouUFD7MpdccoFXF
         XyuhSQVBM/sQKKrc3X+dH9qzfqUgP226mhdLecW3CeoAm9UW8Sszn4j+/g5x0qKfiFOX
         /mWxuAjAZ2ZpkWpywpZluTPr2FGvK7iIZBFGh/9k1PbtA3u/gjd7uVrvO75v9vqnx8Rc
         pbYoFYtH4Cbw5bViOu8jUb45iFCD/+3LVvya/+ZpD2q+/z12MYiIUOtyZ0GJoSgYkPr6
         rzPqHyDfa1+T3h9rgoZjgzaCSs1r0PwIH+yDll8RDJPZWhidLDKoOI9VWPWHPXrF6Qnf
         Awwg==
X-Gm-Message-State: AOAM531kG9eHoyCJiud7991Osn0NNx2ASqXtb1mIOsqZlxhrb3yTXCsm
        Qem5xiuoEN0pTUeynhyECrG3Nw==
X-Google-Smtp-Source: ABdhPJztwwj2Lmnes/knDFhWm/x9ekYq2TGHNL3KtgNw4hZnEPBap7aZFzv7gZ3WmAGU8iH6kzNbLg==
X-Received: by 2002:a37:2dc4:: with SMTP id t187mr3763851qkh.166.1590414079640;
        Mon, 25 May 2020 06:41:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r15sm2718512qtt.42.2020.05.25.06.41.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 06:41:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdDLy-0000hA-Jv; Mon, 25 May 2020 10:41:18 -0300
Date:   Mon, 25 May 2020 10:41:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@linuxfoundation.org>
Subject: Re: [PATCH 0/6] nouveau/hmm: add support for mapping large pages
Message-ID: <20200525134118.GA2536@ziepe.ca>
References: <20200508192009.15302-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508192009.15302-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 08, 2020 at 12:20:03PM -0700, Ralph Campbell wrote:
> hmm_range_fault() returns an array of page frame numbers and flags for
> how the pages are mapped in the requested process' page tables. The PFN
> can be used to get the struct page with hmm_pfn_to_page() and the page size
> order can be determined with compound_order(page) but if the page is larger
> than order 0 (PAGE_SIZE), there is no indication that the page is mapped
> using a larger page size. To be fully general, hmm_range_fault() would need
> to return the mapping size to handle cases like a 1GB compound page being
> mapped with 2MB PMD entries. However, the most common case is the mapping
> size the same as the underlying compound page size.
> This series adds a new output flag to indicate this so that callers know it
> is safe to use a large device page table mapping if one is available.
> Nouveau and the HMM tests are updated to use the new flag.
> 
> Note that this series depends on a patch queued in Ben Skeggs' nouveau
> tree ("nouveau/hmm: map pages after migration") and the patches queued
> in Jason's HMM tree.
> There is also a patch outstanding ("nouveau/hmm: fix nouveau_dmem_chunk
> allocations") that is independent of the above and could be applied
> before or after.

Did Christoph and Matt's remarks get addressed here?

I think ODP could use something like this, currently it checks every
page to get back to the huge page size and this flag would optimze
that

Jason
