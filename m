Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77D3309DCA
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Jan 2021 17:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhAaQEy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 31 Jan 2021 11:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhAaQEv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 31 Jan 2021 11:04:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE797C061574
        for <linux-kselftest@vger.kernel.org>; Sun, 31 Jan 2021 08:04:09 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f1so16045217edr.12
        for <linux-kselftest@vger.kernel.org>; Sun, 31 Jan 2021 08:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ill5FtHsvnGnhyZq4PTZ+wfZWDbj85ydmjcR5hoQtSU=;
        b=WA9qeWNS7cwGg8EThTQKocqoSAMpMXmdWEN96odCb1lDWcM2Sc6v0Qb7sDlmvA+l+I
         A8f+UMiuSXRUXIbHorjezUUJhKowq2uMgSlOLaQKlQ2TE2CKW/8nPCtEsN+ULwFm0bCg
         9/wX7BwKDdipxk5O1KYWXekm+8qe/E4QqrApq/d05iBQtDtZIXya1NS9k8a0s5lWncyh
         g6ruf7EBD+cG/5qucNNMJ6+m+zjl1MiGsDM8tC4ZUV0lVOP0V6NdY9Qaskw+B2dxa5eF
         WGMkCC6G04Cz0bCzZ3ggOUmnb142HmddZFEz3cJyHpOYgpANZbbHESkueT3GcqeRKuB9
         a7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ill5FtHsvnGnhyZq4PTZ+wfZWDbj85ydmjcR5hoQtSU=;
        b=EATrf0emR2PC9xwS01dSvoibZAvhg0kFj2zEaWGujklnrIRYoQfKOTju9g1+g8dE4y
         mXyvb5doQtOl+PfVKB1e8Zn8BzTSG5HhpiBQGn0RvcFit/JNdvKLFHQuvmm8bL33A8eg
         MCY1tQBXrl9Tw1XPvKEg5jBSGFrJU03KoW24PbOCndcKCpHVwIctAwwVI+bLj3U9bPo8
         J8nkvdj0j4RP2/BvbxLw7x9ZqlDX41vOjS5UK76f3afiu+6rBW0mvgcr+oPDiblgUHRA
         Ht4skTBHQ0lm3LqKGqbTYho9F2jPHeZ6RXh9Byztqan29tKiERqwdVYB3sciuVe33Zxw
         aq1A==
X-Gm-Message-State: AOAM530YdBY8MJwUiRtZ5KT4ewkPevf6FAcolrtTXGKM6LHetQ2/QF22
        0WcctwEbokmDpmYNwhl9pbBGYjgR2INtYcdOutdS2w==
X-Google-Smtp-Source: ABdhPJyCGWQ/3ra4ZR4qn/M+OGAua47G1o3uToLGNFPGWhEhJk7alqSH8V206c7XvCeXq7s9hKIxxI4DTjqV9Fn0UKc=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr14874940edv.116.1612109048337;
 Sun, 31 Jan 2021 08:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20210125194751.1275316-8-pasha.tatashin@soleen.com> <20210131130903.4875-1-lecopzer@gmail.com>
In-Reply-To: <20210131130903.4875-1-lecopzer@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Sun, 31 Jan 2021 11:03:32 -0500
Message-ID: <CA+CK2bC_LKeffiYq8eraM-rLBFPfUS1034eD6FKQo5eR7s28Ew@mail.gmail.com>
Subject: Re: [PATCH v8 07/14] mm: honor PF_MEMALLOC_PIN for all movable pages
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        James Morris <jmorris@namei.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 31, 2021 at 8:09 AM Lecopzer Chen <lecopzer@gmail.com> wrote:
>
>
> Hi,
>
> [...]
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c93e801a45e9..3f17c73ad582 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3807,16 +3807,13 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
> >       return alloc_flags;
> >  }
> >
> > -static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
> > -                                     unsigned int alloc_flags)
> > +/* Must be called after current_gfp_context() which can change gfp_mask */
> > +static inline unsigned int gpf_to_alloc_flags(gfp_t gfp_mask,
> > +                                           unsigned int alloc_flags)
> >  {
> >  #ifdef CONFIG_CMA
> > -     unsigned int pflags = current->flags;
> > -
> > -     if (!(pflags & PF_MEMALLOC_PIN) &&
> > -         gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> > +     if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> >               alloc_flags |= ALLOC_CMA;
> > -
> >  #endif
> >       return alloc_flags;
> >  }
> > @@ -4472,7 +4469,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
> >       } else if (unlikely(rt_task(current)) && !in_interrupt())
> >               alloc_flags |= ALLOC_HARDER;
> >
> > -     alloc_flags = current_alloc_flags(gfp_mask, alloc_flags);
> > +     alloc_flags = gpf_to_alloc_flags(gfp_mask, alloc_flags);
> >
> >       return alloc_flags;
> >  }
> > @@ -4774,7 +4771,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >
> >       reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
> >       if (reserve_flags)
> > -             alloc_flags = current_alloc_flags(gfp_mask, reserve_flags);
> > +             alloc_flags = gpf_to_alloc_flags(gfp_mask, reserve_flags);
> >
> >       /*
> >        * Reset the nodemask and zonelist iterators if memory policies can be
> > @@ -4943,7 +4940,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
> >       if (should_fail_alloc_page(gfp_mask, order))
> >               return false;
> >
> > -     *alloc_flags = current_alloc_flags(gfp_mask, *alloc_flags);
> > +     *alloc_flags = gpf_to_alloc_flags(gfp_mask, *alloc_flags);
>
> I have a question, what is the abbreviation of "gpf" in the function
> name gpf_to_alloc_flags()?
>
> It seems that this function still use gfp_mask, is this supposed
> to be gfp (Get Free Page)?

Thank you for noticing this, it was accidental, I will rename the
function gpf_to_alloc_flags() -> gfp_to_alloc_flags()

>
> Thanks,
> Lecopzer
>
