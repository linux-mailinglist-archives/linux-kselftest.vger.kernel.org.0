Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60B42F835B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jan 2021 19:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbhAOSLp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Jan 2021 13:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbhAOSLo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Jan 2021 13:11:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6060FC061757
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jan 2021 10:11:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id dj23so7943058edb.13
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Jan 2021 10:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SVfCmLEiWAiL0R631NmKWHiEv5/3BnE+DWgN7tCTHc=;
        b=LT7meLxfsN9ZJj1NVem9T3FdAJp7+fYnVVLGwj0ymfrrDwmC+Cp8fY2m76Y9p9ZOUY
         DrG9gQkiUneL7meMDl40kir9wD+lupIwVSgT2zkgrec2qM8QF5wKiFCI0BYssd/bujN9
         7e9y5wg/6fUxw5exORuFv1NOXcQFRNhRudlb01jPO/RYYfgfBwicm3NBR1mKkmC6ntNv
         z/v07mXjdkt/D3ipAVODDI918IZEOqRT/nREaddodPRN7hV3O2l5iLCwEZy4fZx+txr4
         cJXdRlrTKCp+YAQeB4+j3QawjuhXB/UMPof/CfB1SrHkgf8zxD8gBjDC+QBEcFFkE46k
         leqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SVfCmLEiWAiL0R631NmKWHiEv5/3BnE+DWgN7tCTHc=;
        b=GfMiKHFzHRya7UlwTVQZTdmQLdQifDGIWyOGA1rXZ6ibxtVbPeAGXyiNmrD5obFuOt
         qzX+mEEOsbrpQoJ7Q+MlTQoUNR7zxTu/v+U1jzfgpICIZ6EtyytQSGE8/qt+uPmjEYxs
         aqHux5bIEElwkzpC4/3TIPlbapmZJi4WKEN7h1xMWRNqshPP6jEIbl7zS8AVkvrc9XBN
         5iWsZBzP/0gvG4l0aj156jV2naV0LTi9cKfxy13Y/wjRaOyvrIt3x4Ycw7crwNnXDqQK
         Tja/H8jaGHGUfzfQ49zPcfcsLwU7USE+N3kuZgaq5wXCMuAPf4JjxLlfAsBotv6rEleF
         DTVQ==
X-Gm-Message-State: AOAM531/phE7YIHBICJPx0WCuHCldoLVbwKlNFV2FItvrI3mkpR6aWlC
        FkbQZdVfioIt+FPegkb5X7Th412r85547NFzdXe3azKVn1XCFg==
X-Google-Smtp-Source: ABdhPJxcm9uW7ZpupMY4AzchVg5VAJOLsBRme8D47yXaQiHft3XUpIVHGE9veIXESaC3fSpI9Az8dNQaliYFA4XPzxA=
X-Received: by 2002:a05:6402:17:: with SMTP id d23mr10770454edu.341.1610734263068;
 Fri, 15 Jan 2021 10:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-9-pasha.tatashin@soleen.com> <20201217205048.GL5487@ziepe.ca>
 <CA+CK2bA4F+SipkReJzFjCSC-8kZdK4yrwCQZM+TvCTrqV2CGHg@mail.gmail.com>
 <20201218141927.GM5487@ziepe.ca> <CA+CK2bDULopw649ndBybA-ST5EoRMHULwcfQcSQVKT9r8zAtwQ@mail.gmail.com>
 <20210113195528.GD4605@ziepe.ca> <CA+CK2bDDUMOeCH8rQBL7fBdHCAUZBOykyXNL2N=hmxq7xi0giQ@mail.gmail.com>
In-Reply-To: <CA+CK2bDDUMOeCH8rQBL7fBdHCAUZBOykyXNL2N=hmxq7xi0giQ@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 15 Jan 2021 13:10:27 -0500
Message-ID: <CA+CK2bC=o1-qW5+d-Lud9qN1937PC4Jxf_oyxwVrKby=mH5WyQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] mm/gup: limit number of gup migration failures,
 honor failures
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 13, 2021 at 3:05 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > > Oh, that existing logic is wrong too :( Another bug.
> > >
> > > I do not think there is a bug.
> > >
> > > > You can't skip pages in the pages[] array under the assumption they
> > > > are contiguous. ie the i+=step is wrong.
> > >
> > > If pages[i] is part of a compound page, the other parts of this page
> > > must be sequential in this array for this compound page
> >
> > That is true only if the PMD points to the page. If the PTE points to
> > a tail page then there is no requirement that other PTEs are
> > contiguous with the compount page.
> >
> > At this point we have no idea if the GUP logic got this compound page
> > as a head page in a PMD or as a tail page from a PTE, so we can't
> > assume a contiguous run of addresses.
>
> I see, I will fix this bug in an upstream as a separate patch in my
> series, and keep the fix when my fixes are applied.
>
> >
> > Look at split_huge_pmd() - it doesn't break up the compound page it
> > just converts the PMD to a PTE array and scatters the tail pages to
> > the PTE.

Hi Jason,

I've been thinking about this some more. Again, I am not sure this is
a bug. I understand split_huge_pmd() may split the PMD size page into
PTEs and leave the compound page intact. However, in order for pages[]
to have non sequential addresses in compound page, those PTEs must
also be migrated after split_huge_pmd(), however when we migrate them
we will either migrate the whole compound page or do
split_huge_page_to_list() which will in turn do ClearPageCompound().
Please let me know if I am missing something.

Thank you,
Pasha

>
> Got it, unfortunately the fix will deoptimize the code by having to
> check every page if it is part of a previous compound page or not.
>
> >
> > I understand Matt is pushing on this idea more by having compound
> > pages in the page cache, but still mapping tail pages when required.
> >
> > > This is actually standard migration procedure, elsewhere in the kernel
> > > we migrate pages in exactly the same fashion: isolate and later
> > > migrate. The isolation works for LRU only pages.
> >
> > But do other places cause a userspace visible random failure when LRU
> > isolation fails?
>
> Makes sense, I will remove maximum retries for isolation, and retry
> indefinitely, the same as it is done during memory hot-remove. So, we
> will fail only when migration fails.
>
> >
> > I don't like it at all, what is the user supposed to do?
> >
> > Jason
