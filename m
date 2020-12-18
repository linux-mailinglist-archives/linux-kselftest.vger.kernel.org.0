Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3113B2DE2D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 13:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgLRMdy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 07:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgLRMdy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 07:33:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59FCC0617B0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 04:33:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id dk8so2202561edb.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 04:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4auixzjhc3l5kGc5mD15oPo8KZORVAz4eHOnG9WGUU=;
        b=n6tUjhd4sqvhp8M2z4j5VFSxJeotpjxPd0CPZa5/EEkcoeLyfyDskake0eK9yxhmwy
         S2gV2oOJzviGu9Y+HT1JnquGMls/BLX+jC+HgjKoBbCtEGWktMPT2nMVHOoLhLl0KgvG
         peXy3mP/v5o9GPyQ8zCeJENiWt244Qtx5yIrpCIXKcHHLKce5fQ7WLALIl8MpgCHKKD0
         q1lOXUYw01ZQ5n/Hzb1tToYlIWOWHfXBaEMR8L39XIv4/BPtOJ3zfKkyuTXHwcwSFoiD
         GbfceUFPcWfb8QPWxwJ3/wFiCvhjXjbRR2moF52UiyqMkdZSC0eRi45AU3BnsQyx5mMJ
         1t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4auixzjhc3l5kGc5mD15oPo8KZORVAz4eHOnG9WGUU=;
        b=mzBjN60f56UhOvV2xgi0CeeKzWE2jeMGJECy2rpihvpYBWRYJT6tXTE8A/2FpRrb4/
         gyzdDIZkAff8vBJ23HCs54NfPUjP9aM43u53MGFUED163nb+Hl8vWzvz46B7esnQhsDh
         b6+gIDVB1EzRnihEVGbbpDeyYQBAmCpe78dop0GlLZ73HcBa3OHiRR8+Nwixoeyma6PO
         YiEtnXBZgEzxoZkFhfdjkG+Rq0noNgho+YP+3lFwXRxXL3VWovg2bxbrGFscgZDynEr5
         gx36FW/y2U+rcStsYnhIh5sqDkvTtzzDZYalIVUcHqMoFzVI9s6e46WO6TNO2fkauSb0
         pAHQ==
X-Gm-Message-State: AOAM531kjE32mkY3GauM3VBfnF6cRXg3IXNEaN+Mm8xLrjh+4+2EyZW9
        SUg60lfd6P+jyiPW8SF0nbGkJxEc+gwr3UQumFTZGg==
X-Google-Smtp-Source: ABdhPJwgiTCZzvnrnw4pePa5kEW9sgXWm1sxNmTcGwoJHPoxUO+t4XBaVGOPekgQGbQO4lfsyuEJ3CDfnv6ztzzqldQ=
X-Received: by 2002:a50:f404:: with SMTP id r4mr4201011edm.62.1608294792260;
 Fri, 18 Dec 2020 04:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-8-pasha.tatashin@soleen.com> <20201218095058.GV32193@dhcp22.suse.cz>
In-Reply-To: <20201218095058.GV32193@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 18 Dec 2020 07:32:36 -0500
Message-ID: <CA+CK2bBTtVQuZMBQ=67cFQ6fLNcFi+nuPgFWOHWMWgyiQSeEzQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] mm/gup: change index type to long as it counts pages
To:     Michal Hocko <mhocko@suse.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 18, 2020 at 4:51 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 17-12-20 13:52:40, Pavel Tatashin wrote:
> > In __get_user_pages_locked() i counts number of pages which should be
> > long.
>
> Do we know of any caller who would like to pin so many pages it wouldn't
> fit into an int? I suspect this is more to sync types of nr_pages and
> the iterator right. It would be better to be explicit about this in the
> changelog.

It is to sync types. I will add it to the changelog.

But, in general 32-bit increasingly becomes too small for handling
page count proportional values. It is 8T for npages. For pinning may
be a bit too large today, but I can image RDMA this size in the
future.

>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> > ---
> >  mm/gup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 591d8e2dfc70..1ebb7cc2fbe4 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1481,7 +1481,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
> >  {
> >       struct vm_area_struct *vma;
> >       unsigned long vm_flags;
> > -     int i;
> > +     long i;
> >
> >       /* calculate required read or write permissions.
> >        * If FOLL_FORCE is set, we only require the "MAY" flags.
> > --
> > 2.25.1
>
> --
> Michal Hocko
> SUSE Labs
