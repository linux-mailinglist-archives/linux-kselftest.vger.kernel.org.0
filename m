Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910662DE3E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 15:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgLROUL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 09:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgLROUL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 09:20:11 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE87C06138C
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 06:19:30 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id et9so907056qvb.10
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 06:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WERPNLKxdgIzL5x4a7MSy0JBfPg8vRpdWpyRT6Y+Lx4=;
        b=JWVockyamEBA1QzjNns4oKAV8HOKMsYdVPooYbIOFtw278D5Gt2qniBWvLXweuFSj1
         tzoYgabP31sX8hAUUWwt4d0+LhYZklSF/9Z3Fjkyzcx403vDihglcZmVY9UWldsSa209
         8KGP9Eedu9P7hKrxzgJg7+VYF77W8RFgrnq9eZz6CHtBH3d7cRyxqUGaefNQ/BPmrNEx
         9oi1tjrsWCdOQocEJGzhvaO1K25b4dVre+HK05WlgxLdhuRdrs5lGz4do084bbGZMjD9
         igN58y1WTKT0to1tcAZQOxq+tGgZe7hUtUrwUcHq0n/sMfcq1W3S32vgfSrF4OeLu0iI
         CNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WERPNLKxdgIzL5x4a7MSy0JBfPg8vRpdWpyRT6Y+Lx4=;
        b=XJQZcTzmEPDaeXIP9yyrnlK3dxAqafqWohkTHdqium0bZJCF8GLqsyxVNO+Ordqkpw
         SxRlHcNqhHkBc5X1Wf+yb0Auz/EWjpPMm09CzrypRZOm1j0tY6GefvBjxj+xjsEj7oxj
         rwE/YC8fVAK2uV0Zz1xmtdtsbfl38aHg0X8XNksv7P/io+KvaXJObm/0vi3ke6RDxK0A
         oylfAZijXugK/RVVMoaCAV0EgV9EAnkmd1Gkrz5oh32IFKA7HcQlG+vH/KZ2maC2lEUH
         9LKj2iBDWEpjcm7gJkM8kfuz0WGMw+ZaVkold92/+qTtBh9+MXsA8sLns/4NkTjL3c+M
         5sCA==
X-Gm-Message-State: AOAM5308caJN9ZYJeHNwgPDBBzrRbRV7BT/Gg7hI/bamC9wfaXhoAQjz
        MicSXPSrv23n7i4aQQOadz2eSw==
X-Google-Smtp-Source: ABdhPJx8/DJ78GkxbcIU1memIsL2TB3DNuXc1GCmXG+0Kwa2zwOi49IxsU0awOMhpxtgwLhA0c9ALg==
X-Received: by 2002:a05:6214:768:: with SMTP id f8mr4637876qvz.1.1608301168974;
        Fri, 18 Dec 2020 06:19:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id s130sm5426876qka.91.2020.12.18.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 06:19:28 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kqGbP-00CgM0-FO; Fri, 18 Dec 2020 10:19:27 -0400
Date:   Fri, 18 Dec 2020 10:19:27 -0400
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
Message-ID: <20201218141927.GM5487@ziepe.ca>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-9-pasha.tatashin@soleen.com>
 <20201217205048.GL5487@ziepe.ca>
 <CA+CK2bA4F+SipkReJzFjCSC-8kZdK4yrwCQZM+TvCTrqV2CGHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bA4F+SipkReJzFjCSC-8kZdK4yrwCQZM+TvCTrqV2CGHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 17, 2020 at 05:02:03PM -0500, Pavel Tatashin wrote:
> Hi Jason,
> 
> Thank you for your comments. My replies below.
> 
> On Thu, Dec 17, 2020 at 3:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Dec 17, 2020 at 01:52:41PM -0500, Pavel Tatashin wrote:
> > > +/*
> > > + * Verify that there are no unpinnable (movable) pages, if so return true.
> > > + * Otherwise an unpinnable pages is found return false, and unpin all pages.
> > > + */
> > > +static bool check_and_unpin_pages(unsigned long nr_pages, struct page **pages,
> > > +                               unsigned int gup_flags)
> > > +{
> > > +     unsigned long i, step;
> > > +
> > > +     for (i = 0; i < nr_pages; i += step) {
> > > +             struct page *head = compound_head(pages[i]);
> > > +
> > > +             step = compound_nr(head) - (pages[i] - head);
> >
> > You can't assume that all of a compound head is in the pages array,
> > this assumption would only work inside the page walkers if the page
> > was found in a PMD or something.
> 
> I am not sure I understand your comment. The compound head is not
> taken from the pages array, and not assumed to be in it. It is exactly
> the same logic as that we currently have:
> https://soleen.com/source/xref/linux/mm/gup.c?r=a00cda3f#1565

Oh, that existing logic is wrong too :( Another bug.

You can't skip pages in the pages[] array under the assumption they
are contiguous. ie the i+=step is wrong.

> >
> > > +     if (gup_flags & FOLL_PIN) {
> > > +             unpin_user_pages(pages, nr_pages);
> >
> > So we throw everything away? Why? That isn't how the old algorithm worked
> 
> It is exactly like the old algorithm worked: if there are pages to be
> migrated (not pinnable pages) we unpinned everything.
> See here:
> https://soleen.com/source/xref/linux/mm/gup.c?r=a00cda3f#1603

Hmm, OK, but I'm not sure that is great either

> cleaner, and handle errors. We must unpin everything because if we
> fail, no pages should stay pinned, and also if we migrated some pages,
> the pages array must be updated, so we need to call
> __get_user_pages_locked() pin and repopulated pages array.

However the page can't be unpinned until it is put on the LRU (and I'm
hoping that the LRU is enough of a 'lock' to make that safe, no idea)

> > I don't like this at all. It shouldn't be so flakey
> >
> > Can you do migration without the LRU?
> 
> I do not think it is possible, we must isolate pages before migration.

I don't like this at all :( Lots of stuff relies on GUP, introducing a
random flakiness like this not good.

Jason
