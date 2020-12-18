Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBAE2DE323
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 14:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgLRNPj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 08:15:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:42438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgLRNPi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 08:15:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608297292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ED9u4YU+XtDT7l6r5t+/jBrRwKWBqQx+LhwzAb6wzQ=;
        b=Vg2wsKjY3rLAFd2M/+Dny22SjAwfWHdBFFPXoGiNkmuXJp9niVNcpJDzQhS/cFDTGExND7
        /vFJ6QZzs3GjBhTcPBb6vlAlzajeRUNbxO8AmeNo0eB4EpIx6TfHOssRiQValxU8Nfbm6q
        IiU62c0O569BuNxrf4RuhoTD7z891dU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E32A1AD29;
        Fri, 18 Dec 2020 13:14:51 +0000 (UTC)
Date:   Fri, 18 Dec 2020 14:14:49 +0100
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
Subject: Re: [PATCH v4 08/10] mm/gup: limit number of gup migration failures,
 honor failures
Message-ID: <20201218131449.GZ32193@dhcp22.suse.cz>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-9-pasha.tatashin@soleen.com>
 <20201218104655.GW32193@dhcp22.suse.cz>
 <CA+CK2bCn++2Sk4-Eunibj6f+JoOL77uJQXGU2+dScHQ3RgC7_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCn++2Sk4-Eunibj6f+JoOL77uJQXGU2+dScHQ3RgC7_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 18-12-20 07:43:15, Pavel Tatashin wrote:
> On Fri, Dec 18, 2020 at 5:46 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 17-12-20 13:52:41, Pavel Tatashin wrote:
> > [...]
> > > +#define PINNABLE_MIGRATE_MAX 10
> > > +#define PINNABLE_ISOLATE_MAX 100
> >
> > Why would we need to limit the isolation retries. Those should always be
> > temporary failure unless I am missing something.
> 
> Actually, during development, I was retrying isolate errors
> infinitely, but during testing found a hung where when FOLL_TOUCH
> without FOLL_WRITE is passed (fault in kernel without write flag), the
> zero page is faulted. The isolation of the zero page was failing every
> time, therefore the process was hanging.

Why would you migrate zero page in the first place? Simply instantiate
it.
 
> Since then, I fixed this problem by adding FOLL_WRITE unconditionally
> to FOLL_LONGTERM, but I was worried about other possible bugs that
> would cause hangs, so decided to limit isolation errors. If you think
> it its not necessary, I can unlimit isolate retires.

It should have a really good reason to exist. Worries about some corner
cases is definitely not a reason to put some awkward retry mechanism.
My historical experience is that these things are extremely hard to get
rid of later.

> > I am not sure about the
> > PINNABLE_MIGRATE_MAX either. Why do we want to limit that? migrate_pages
> > already implements its retry logic why do you want to count retries on
> > top of that? I do agree that the existing logic is suboptimal because
> 
> True, but again, just recently, I worked on a race bug where pages can
> end up in per-cpu list after lru_add_drain_all() but before isolation,
> so I think retry is necessary.

There are ways to make sure pages are not ending on pcp list. Have a
look at how hotplug does that.

> > the migration failure might be ephemeral or permanent but that should be
> > IMHO addressed at migrate_pages (resp. unmap_and_move) and simply report
> > failures that are permanent - e.g. any potential pre-existing long term
> > pin - if that is possible at all. If not what would cause permanent
> > migration failure? OOM?
> 
> Yes, OOM is the main cause for migration failures.

Then you can treat ENOMEM as a permanent failure.

> And also a few
> cases described in movable zone comment, where it is possible during
> boot some pages can be allocated by memblock in movable zone due to
> lack of memory resources (even if those resources were added later),

Do you have any examples? I find it hard to follow that somebody would
be pinning early boot allocations.

> hardware page poisoning is another rare example.

Could you elaborate please?
-- 
Michal Hocko
SUSE Labs
