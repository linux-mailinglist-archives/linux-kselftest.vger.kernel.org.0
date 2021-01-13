Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D262E2F53BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 20:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbhAMT4M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 14:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbhAMT4M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 14:56:12 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDE2C0617A3
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 11:55:31 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z20so2001434qtq.3
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jan 2021 11:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j2KHy6ytFaCxtFCpnxnAAp4By3drKdosRae2NFEDzUM=;
        b=IRMzoOo7LuVrwmBlGKEz71GRBRg7cY+S5B3mH3i0TSq/0N9aJCbG0tIGyFPQpMb4ya
         M+spbtAg+5dXCn6zcd/Jrl060Cr7TMU76ssCVbKUfhbUL7Uyp9RnmbLNUNF1wZJglmWr
         tmnaq5qtA4/PR1Tmp0nFTwXL5ztM45VMTnftRKHl3kzUzCi1IrHn5T+m+a2RNzBXBBsw
         D/5mgCiv8McU+V8oEABeIz2Z9s70ro7kOe7JduuNX4D2YU0WJdzD8qTu8uOijnbQd2d0
         hjyofIHk6YiUWrlvW5subuz/fltvSS4PijEe/pw8s2Xw/pDs2bMHD5jbMJrRrhg7zHph
         15xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j2KHy6ytFaCxtFCpnxnAAp4By3drKdosRae2NFEDzUM=;
        b=QxeJ6kLgAogYR4c62YrC/7dPqKr4u9xbimKaRZx7PNe8UTTxLxEEO9XtqCJ0A05p3r
         rdX+h4MgncvdpjyzdMFKx/DjPAfm3NyZ69wvZ8sg7SHGrRIoFqW6Dt6+o9X1iSwqzOzY
         5tEznUB5eO7D+ITPwjjXY8OkHFWnvK7M7mZSogJrAdZmE9ekUTfdYVNhQbgXFNUYfYIX
         6ROaMqYzlreVS8RT7BFX3Jvz6vBocjNPIFhVhlUQWVP83vayvLB8g0P652PjSHoay3ho
         sEYntvrWOO/ndWEN/BoLgd1NO4oPrMuEUhNBHg4Cn3bESCFm+r1J513MJYTuNi79rt1R
         Nd7w==
X-Gm-Message-State: AOAM532Gpc40zDkWWhVtIrjA6Wii0Uh3fvlr3Nqy4HaZKcMbA/Z483PK
        FNHdvYtzcIAury8UL2omQp1Nlw==
X-Google-Smtp-Source: ABdhPJzMjn9xG2uNycc141Ms/0p2ycjTiyqWztEAjOhW86pox433bwVX8jUG36NBwT5vor4/WVqkjA==
X-Received: by 2002:aed:39a6:: with SMTP id m35mr3951749qte.29.1610567730489;
        Wed, 13 Jan 2021 11:55:30 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q6sm1716839qkd.41.2021.01.13.11.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 11:55:29 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kzmEq-000f2u-QV; Wed, 13 Jan 2021 15:55:28 -0400
Date:   Wed, 13 Jan 2021 15:55:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 08/10] mm/gup: limit number of gup migration failures,
 honor failures
Message-ID: <20210113195528.GD4605@ziepe.ca>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-9-pasha.tatashin@soleen.com>
 <20201217205048.GL5487@ziepe.ca>
 <CA+CK2bA4F+SipkReJzFjCSC-8kZdK4yrwCQZM+TvCTrqV2CGHg@mail.gmail.com>
 <20201218141927.GM5487@ziepe.ca>
 <CA+CK2bDULopw649ndBybA-ST5EoRMHULwcfQcSQVKT9r8zAtwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDULopw649ndBybA-ST5EoRMHULwcfQcSQVKT9r8zAtwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 13, 2021 at 02:43:50PM -0500, Pavel Tatashin wrote:
> On Fri, Dec 18, 2020 at 9:19 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Dec 17, 2020 at 05:02:03PM -0500, Pavel Tatashin wrote:
> > > Hi Jason,
> > >
> > > Thank you for your comments. My replies below.
> > >
> > > On Thu, Dec 17, 2020 at 3:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Thu, Dec 17, 2020 at 01:52:41PM -0500, Pavel Tatashin wrote:
> > > > > +/*
> > > > > + * Verify that there are no unpinnable (movable) pages, if so return true.
> > > > > + * Otherwise an unpinnable pages is found return false, and unpin all pages.
> > > > > + */
> > > > > +static bool check_and_unpin_pages(unsigned long nr_pages, struct page **pages,
> > > > > +                               unsigned int gup_flags)
> > > > > +{
> > > > > +     unsigned long i, step;
> > > > > +
> > > > > +     for (i = 0; i < nr_pages; i += step) {
> > > > > +             struct page *head = compound_head(pages[i]);
> > > > > +
> > > > > +             step = compound_nr(head) - (pages[i] - head);
> > > >
> > > > You can't assume that all of a compound head is in the pages array,
> > > > this assumption would only work inside the page walkers if the page
> > > > was found in a PMD or something.
> > >
> > > I am not sure I understand your comment. The compound head is not
> > > taken from the pages array, and not assumed to be in it. It is exactly
> > > the same logic as that we currently have:
> > > https://soleen.com/source/xref/linux/mm/gup.c?r=a00cda3f#1565
> >
> > Oh, that existing logic is wrong too :( Another bug.
> 
> I do not think there is a bug.
> 
> > You can't skip pages in the pages[] array under the assumption they
> > are contiguous. ie the i+=step is wrong.
> 
> If pages[i] is part of a compound page, the other parts of this page
> must be sequential in this array for this compound page

That is true only if the PMD points to the page. If the PTE points to
a tail page then there is no requirement that other PTEs are
contiguous with the compount page.

At this point we have no idea if the GUP logic got this compound page
as a head page in a PMD or as a tail page from a PTE, so we can't
assume a contiguous run of addresses.

Look at split_huge_pmd() - it doesn't break up the compound page it
just converts the PMD to a PTE array and scatters the tail pages to
the PTE.

I understand Matt is pushing on this idea more by having compound
pages in the page cache, but still mapping tail pages when required.

> This is actually standard migration procedure, elsewhere in the kernel
> we migrate pages in exactly the same fashion: isolate and later
> migrate. The isolation works for LRU only pages.

But do other places cause a userspace visible random failure when LRU
isolation fails?

I don't like it at all, what is the user supposed to do?

Jason
