Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D62FC0B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 21:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbhASUPe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 15:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbhASUPW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 15:15:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6277C061575
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 12:14:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id dj23so20511173edb.13
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 12:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byRyQq0Zgtt5NgbHeIaYNBYUmY4ZzoHZBsdIAqa6syw=;
        b=Gvl+pXMIcc2co0RDWG1pUGT2dp42EWP1Oa9B+3sOC1fEXqHYY0TNyn4mV/ProTlP1F
         6ThCzCQJMElcNtFlKMxBEDs+M43Z3iur8b+I/VPtsNTEn3DRGKXGgQHDLK6dELHcR2if
         ZHLG94pSN934JR9GRWS8HNj4barzLvHkGaTA708e9PQrN8RNfCZyVobjym7lfLJlenUa
         8IEjgp2B1w5yyZccOskcIDNMCgMkjpWDivGrzGl9WjZsYw/oYhe93GkKRG6KmcDUeVkr
         FO7Dk3NxbIwrPknVjZlUQmuSVKP4tIXyPHDJ5WnwBVugDNbaE5g4vXhLCKObLd+RZ6D0
         6rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byRyQq0Zgtt5NgbHeIaYNBYUmY4ZzoHZBsdIAqa6syw=;
        b=kp4n7Q6LnplPt68QydKhiKWM7uZyYqvYBLlx/TsMtJcszM3PmU/RwUC0ACZAo7WgEY
         Uriw6mCQ3JqYnoeVkLYfZS+yoeqqQSZANJoyxXq9PX5D/lokwSQsLgnJbOBbCjUCDu4g
         U/tZXU2lYNSD+7hJWM18lD1HknQC3iT+SJMwr3gicOe64P3AZqZcRbrMxlTW9hc1EhBT
         qDg19jXb95f8xPODVfLDPgSA43vghcLJsrsLYPZkRRwpS6G99Lw9wMlVCaK7RO2DAcQj
         +B2XRtlG8mzcgY39unYFHQzPJNqQexxYg4yIpOm5TOzjthtJuAANAuKoVfUr5A3bF+XV
         eNHA==
X-Gm-Message-State: AOAM53389KtOoFot+7xO+RHRuYPnf77Wv5ug05THhykN5MDkN21FjBX/
        W1/1sgun2YOSRCTaesOA8uxPx5hgNRgTsKJ6dkNo2Q==
X-Google-Smtp-Source: ABdhPJz8pqr0iEoSJaOvD5DC/VO5AZGkgHQio8PjFJuSvIBVP2GzlgXm4FTOWjvYilIQV8nA55C/YRhAG3ldeAxU44U=
X-Received: by 2002:a05:6402:304e:: with SMTP id bu14mr4545815edb.60.1611087280334;
 Tue, 19 Jan 2021 12:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
 <20210119043920.155044-9-pasha.tatashin@soleen.com> <20210119183013.GB4605@ziepe.ca>
 <CA+CK2bBKbht34Hkg9YvhwYAiAjd3NMd_+Eir9wfx+07V-Y2TTA@mail.gmail.com> <20210119184751.GD4605@ziepe.ca>
In-Reply-To: <20210119184751.GD4605@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 19 Jan 2021 15:14:04 -0500
Message-ID: <CA+CK2bDGDR9B=n5d4Dz6my6kKyFF=6y79HJt-k-SCpLhF1fUQQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] mm/gup: do not allow zero page for pinned pages
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

On Tue, Jan 19, 2021 at 1:47 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jan 19, 2021 at 01:34:26PM -0500, Pavel Tatashin wrote:
> > On Tue, Jan 19, 2021 at 1:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Jan 18, 2021 at 11:39:14PM -0500, Pavel Tatashin wrote:
> > > > Zero page should not be used for long term pinned pages. Once pages
> > > > are pinned their physical addresses cannot changed until they are unpinned.
> > > >
> > > > Guarantee to always return real pages when they are pinned by adding
> > > > FOLL_WRITE.
> > > >
> > > > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > > >  mm/gup.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > No, this will definitely break things
> >
> > What will break
>
> Things assuming GUP doesn't break COW, making all GUP WRITE was
> already tried and revered for some other reason
>
> > > Why does the zero page have to be movable?
> >
> > It is not even about being movable, we can't cow pinned pages returned
> > by GUP call, how can we use zero page for that?
>
> The zero page is always zero, it is never written to. What does cow
> matter?

Hi Jason,

I was thinking about a use case where userland would pin an address
without FOLL_WRITE, because the PTE for that address is not going to
be writable, but some device via DMA will write to it. Now, if we got
a zero page we have a problem... If this usecase is not valid then the
fix for movable zero page is make the zero page always come from a
non-movable zone so we do not need to isolate it during migration, and
so the memory can be offlined later.

Pasha

>
> Jason
