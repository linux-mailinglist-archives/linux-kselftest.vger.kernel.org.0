Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171E82B70DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgKQVXG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKQVXE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:23:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B3C0613CF;
        Tue, 17 Nov 2020 13:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Le6nenVdfqug4GtB+TuVFFmGAO2UeQg8aKMVmpcDyQ=; b=vzOxukK9yDaGfyVYUmioAz5KU0
        MIcMpKA70ufQ7Gjat7Zm3T8FPDQU3BEmO8kyrTbBFe22r/dxfkMhgG0UK68dsUpNx3ISfu5ffBg+i
        J764GpsRUjtb5zmFjAE0xteJeP/fGCEUx/5yEx8PhZJ7bVRDBThuxJhW0GCCuSLb6GpNVEpDHkId3
        jcEzwjrNvoAgPrtf5g1SFXsqpiyigeQyFjBYCoyputpzR3zVH79ekkbAoUHKZn/2uMC52ndo+lX3X
        CPuQsNI5X180Q0x8iagaKdG3sd8Xth3L403wZg+tIAyA7jCK/Biw9GSELCV31CaCyxYa2u9QtFNH8
        l7w8rMzg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf8RD-0004N9-Ox; Tue, 17 Nov 2020 21:22:55 +0000
Date:   Tue, 17 Nov 2020 21:22:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 3/6] mm: page_owner: add support for splitting to any
 order in split page_owner.
Message-ID: <20201117212255.GZ29991@casper.infradead.org>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <20201114001505.GA3047204@carbon.dhcp.thefacebook.com>
 <F55878E8-22B1-443E-9CC8-E97B3DAA7EA4@nvidia.com>
 <20201114013801.GA3069806@carbon.dhcp.thefacebook.com>
 <20201117210532.GX29991@casper.infradead.org>
 <3E32BC50-700F-471E-89FD-35414610B84E@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E32BC50-700F-471E-89FD-35414610B84E@nvidia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 17, 2020 at 04:12:03PM -0500, Zi Yan wrote:
> On 17 Nov 2020, at 16:05, Matthew Wilcox wrote:
> 
> > On Fri, Nov 13, 2020 at 05:38:01PM -0800, Roman Gushchin wrote:
> >> On Fri, Nov 13, 2020 at 08:08:58PM -0500, Zi Yan wrote:
> >>> Matthew recently converted split_page_owner to take nr instead of order.[1]
> >>> But I am not
> >>> sure why, since it seems to me that two call sites (__split_huge_page in
> >>> mm/huge_memory.c and split_page in mm/page_alloc.c) can pass the order
> >>> information.
> >>
> >> Yeah, I'm not sure why too. Maybe Matthew has some input here?
> >> You can also pass new_nr, but IMO orders look so much better here.
> >
> > If only I'd written that information in the changelog ... oh wait, I did!
> >
> >     mm/page_owner: change split_page_owner to take a count
> >
> >     The implementation of split_page_owner() prefers a count rather than the
> >     old order of the page.  When we support a variable size THP, we won't
> >     have the order at this point, but we will have the number of pages.
> >     So change the interface to what the caller and callee would prefer.
> 
> There are two callers, split_page in mm/page_alloc.c and __split_huge_page in
> mm/huge_memory.c. The former has the page order. The latter has the page order
> information before __split_huge_page_tail is called, so we can do
> old_order = thp_order(head) instead of nr = thp_nr_page(head) and use old_order.
> What am I missing there?

Sure, we could also do that.  But what I wrote was true at the time I
wrote it.

