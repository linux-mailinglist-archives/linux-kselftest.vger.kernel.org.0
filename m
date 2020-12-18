Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA82DE31A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 14:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgLRNJR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 08:09:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:37320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLRNJR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 08:09:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608296911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qy4X5XGLkjjTrEVnpyl9ubxnV3suDoRLMs36eWY7vx8=;
        b=l76U/9Q65OcRVxpjlhkrgzoI2O/GDE06QXEjmSrmOHTqE5Ih/2RQ1jIJG3bjvK1Y4ex2xq
        8pw6RsXn2ZB7Oz9oWRONm2eAbpAwKQ3j3FevprsLmFtW13S9DlYK7cs6WEppEQvMHf0q36
        xyYXBCkFyyT6u01tptEnHUwdGs/ZD60=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 819A5AEBE;
        Fri, 18 Dec 2020 13:08:30 +0000 (UTC)
Date:   Fri, 18 Dec 2020 14:08:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 05/10] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201218130825.GY32193@dhcp22.suse.cz>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-6-pasha.tatashin@soleen.com>
 <20201218094324.GT32193@dhcp22.suse.cz>
 <CA+CK2bAKiWC5E4h4CZOqQrh4QzQQ-3_TUJgB=r4H23gu3cqvAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAKiWC5E4h4CZOqQrh4QzQQ-3_TUJgB=r4H23gu3cqvAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 18-12-20 07:24:53, Pavel Tatashin wrote:
> On Fri, Dec 18, 2020 at 4:43 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 17-12-20 13:52:38, Pavel Tatashin wrote:
> > > +      * 1. Pinned pages: (long-term) pinning of movable pages is avoided
> > > +      *    when pages are pinned and faulted, but it is still possible that
> > > +      *    address space already has pages in ZONE_MOVABLE at the time when
> > > +      *    pages are pinned (i.e. user has touches that memory before
> > > +      *    pinning). In such case we try to migrate them to a different zone,
> > > +      *    but if migration fails the pages can still end-up pinned in
> > > +      *    ZONE_MOVABLE. In such case, memory offlining might retry a long
> > > +      *    time and will only succeed once user application unpins pages.
> >
> > I still dislike this. Pinning can fail so there shouldn't be any reasons
> > to break MOVABLE constrain for something that can be handled. If
> > anything there should be a very good reasoning behind this decision
> > documented.
> 
> This is basically current behaviour, after patch 8, we can never pin
> pages in the movable zone, so I will update this comment in that
> patch.

Then it would be much easier for review to state that the existing
behavior is unchanged and do not update this comment just to remove it
in a later patch. Because this patch should be straightforward change of
the condition which pages to migrate (+some renaming which should be
reasonably easy to follow). Maybe it would be even better to do the
renaming separately without any functional changes and make only the
change in the condition here.

-- 
Michal Hocko
SUSE Labs
