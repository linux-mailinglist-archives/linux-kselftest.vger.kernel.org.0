Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878E72B710C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgKQVn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQVn6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:43:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780CEC0613CF;
        Tue, 17 Nov 2020 13:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U1HUq3odOaKKvpXhRq9sCZmlrJ8CUFhzjI0olhIffX8=; b=RXcEhCdel4HtJTqO+9ba2Ef8q0
        4d+tTf7mLLmqyXSfW52Cr4E1EqvArs7Hl0JXOvpF75xQj2ruK7nQyvjknZr5VcctuMzsd7IRIFaKL
        3glUIHYp+jOAJdEerRZqTMOmhdmHWZyksjxWYNQlqZ4hqoJLvW66dFj4L+UW4p9ZD4WpAqpw7PkJ5
        3PPMWRcqa7FoKXBQQ56p6sUkfUb8E+mA0Y/CUlkLL1/ExDKtNu7+VIOuRs5RrjZ1koxL8OVSQKiNq
        h8Ag0VIKoZz3CcCD1msO5XY/FXnp3zOucGXJ+YNPsAeF8QNQ+W5LdKp8LvRhrPFs7b8iJQsh43bff
        k9FRW/Fw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf8lN-0005WN-V8; Tue, 17 Nov 2020 21:43:46 +0000
Date:   Tue, 17 Nov 2020 21:43:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
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
Message-ID: <20201117214345.GB29991@casper.infradead.org>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-4-zi.yan@sent.com>
 <20201114001505.GA3047204@carbon.dhcp.thefacebook.com>
 <F55878E8-22B1-443E-9CC8-E97B3DAA7EA4@nvidia.com>
 <20201114013801.GA3069806@carbon.dhcp.thefacebook.com>
 <20201117210532.GX29991@casper.infradead.org>
 <3E32BC50-700F-471E-89FD-35414610B84E@nvidia.com>
 <20201117212255.GZ29991@casper.infradead.org>
 <20201117213537.GB156448@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117213537.GB156448@carbon.DHCP.thefacebook.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 17, 2020 at 01:35:37PM -0800, Roman Gushchin wrote:
> On Tue, Nov 17, 2020 at 09:22:55PM +0000, Matthew Wilcox wrote:
> > On Tue, Nov 17, 2020 at 04:12:03PM -0500, Zi Yan wrote:
> > > On 17 Nov 2020, at 16:05, Matthew Wilcox wrote:
> > > 
> > > > On Fri, Nov 13, 2020 at 05:38:01PM -0800, Roman Gushchin wrote:
> > > >> On Fri, Nov 13, 2020 at 08:08:58PM -0500, Zi Yan wrote:
> > > >>> Matthew recently converted split_page_owner to take nr instead of order.[1]
> > > >>> But I am not
> > > >>> sure why, since it seems to me that two call sites (__split_huge_page in
> > > >>> mm/huge_memory.c and split_page in mm/page_alloc.c) can pass the order
> > > >>> information.
> > > >>
> > > >> Yeah, I'm not sure why too. Maybe Matthew has some input here?
> > > >> You can also pass new_nr, but IMO orders look so much better here.
> > > >
> > > > If only I'd written that information in the changelog ... oh wait, I did!
> > > >
> > > >     mm/page_owner: change split_page_owner to take a count
> > > >
> > > >     The implementation of split_page_owner() prefers a count rather than the
> > > >     old order of the page.  When we support a variable size THP, we won't
> > > >     have the order at this point, but we will have the number of pages.
> > > >     So change the interface to what the caller and callee would prefer.
> > > 
> > > There are two callers, split_page in mm/page_alloc.c and __split_huge_page in
> > > mm/huge_memory.c. The former has the page order. The latter has the page order
> > > information before __split_huge_page_tail is called, so we can do
> > > old_order = thp_order(head) instead of nr = thp_nr_page(head) and use old_order.
> > > What am I missing there?
> > 
> > Sure, we could also do that.  But what I wrote was true at the time I
> > wrote it.
> 
> Sure, I was asking about if you're ok with going back to orders or there are better
> ideas. I'm sorry if it wasn't clear and sounded differently.
> 
> It just seems to me than a function is taking nr and order (as in Zi's last version),
> I'd expect that it's a number of pages of given order, or something like this.
> So I'd avoid mixing them. Orders are slightly better if nr is always a power of two,
> it's just more obvious from looking at the code.

I think it's awkward no matter which way round we do it.

If we pass old_order, new_order then we create extra work for both caller
and callee.

If we pass old_nr, new_order, it looks weird for humans.

At the end of the day, I'm not that invested in which we do.
