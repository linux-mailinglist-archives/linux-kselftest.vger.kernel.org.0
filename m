Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB932DE2CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 13:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgLRM0L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 07:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgLRM0L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 07:26:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C73C061282
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 04:25:30 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id g20so2976322ejb.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lhuweqQlhHO7hy/V02BEkOocTAj67fYHbIRgEWFXLs=;
        b=MJ6K37SnOv0MOV1yNPGIsCJSfLdzIW59btJg0j0VNKWwYOIneNWAlzLezFS+4P1UIg
         kvtBTojCVh9e1FShHJeAPucWvI2ftbOUroXc3gg7yM9AHLhxecDsp8JqaLP16g3CYZ95
         KNP1Cnk6441ZWkLzWsRgdtvMxmnJkXOKrDk8xEK6tCfLPgJxrVR4w/situU0UMdI+ZPY
         SogVsfeoRkuyNuOHCbCzgcc9dcFBT5d5ugBKWROYrsUZM6AezfJFecEcH9aIqwQZ1vsU
         gurHn2N1ewEy9LbesQUw63usbfVnz6ZqRvJr4uYOp33JrXL8bIpGh2UkjhHGhGLVcJy7
         FOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lhuweqQlhHO7hy/V02BEkOocTAj67fYHbIRgEWFXLs=;
        b=NM2QXgtTp8+sqpkHlvpHZfTbQzwY7SKjmGor81HqEcvN3F7/OuDGb9P17J8kjFnlc5
         OCjPnflXwp5/tDZc/V019cHdwECvlJ/LzmeFeIGPQfDrzLK88l9kw0x+/bvMWnVz3S09
         L/foPXN5cMuU4jsUvCWiRIsl/9fc/orWMvgWib/4XvPQ2djfFQD3tPiib3XkCOJToHqM
         tyRDLJth5RnXzcSZwpF09z+7V0RTHatqkbg3rJWXorrtvL+CPejnwBREUqverfWWrHLZ
         lmPzisxl8MkC0FSMycVqH5YiiB44ZQfRv7bYle1ntapMwHNejtxRq/i30B1sEpKOMe76
         Bgog==
X-Gm-Message-State: AOAM531dlCs998b/BVUBE/BE1owlqGqj71d1qWs5UdeSgEq7E/Jvm5dL
        5/Z9T+CoIUVKjWU8ZoqedwacGFfKDw0nhj797FulZw==
X-Google-Smtp-Source: ABdhPJxS61dnQ5BtpBbJ0RZj2DWMhhsRQ2d4te1FBg4JvHGVH2QxOB81QucqauKQ/kxnWqUevwveMDcth6n5BZbPruM=
X-Received: by 2002:a17:906:ce51:: with SMTP id se17mr3761264ejb.314.1608294329649;
 Fri, 18 Dec 2020 04:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-6-pasha.tatashin@soleen.com> <20201218094324.GT32193@dhcp22.suse.cz>
In-Reply-To: <20201218094324.GT32193@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 18 Dec 2020 07:24:53 -0500
Message-ID: <CA+CK2bAKiWC5E4h4CZOqQrh4QzQQ-3_TUJgB=r4H23gu3cqvAA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] mm/gup: migrate pinned pages out of movable zone
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

On Fri, Dec 18, 2020 at 4:43 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 17-12-20 13:52:38, Pavel Tatashin wrote:
> > +      * 1. Pinned pages: (long-term) pinning of movable pages is avoided
> > +      *    when pages are pinned and faulted, but it is still possible that
> > +      *    address space already has pages in ZONE_MOVABLE at the time when
> > +      *    pages are pinned (i.e. user has touches that memory before
> > +      *    pinning). In such case we try to migrate them to a different zone,
> > +      *    but if migration fails the pages can still end-up pinned in
> > +      *    ZONE_MOVABLE. In such case, memory offlining might retry a long
> > +      *    time and will only succeed once user application unpins pages.
>
> I still dislike this. Pinning can fail so there shouldn't be any reasons
> to break MOVABLE constrain for something that can be handled. If
> anything there should be a very good reasoning behind this decision
> documented.

This is basically current behaviour, after patch 8, we can never pin
pages in the movable zone, so I will update this comment in that
patch.

Thank you,
Pasha

> --
> Michal Hocko
> SUSE Labs
