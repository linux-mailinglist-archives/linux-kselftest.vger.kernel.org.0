Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD61A163E44
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2020 08:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSHyt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 02:54:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35946 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgBSHys (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 02:54:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so22956612oic.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2020 23:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5zuuxTOmeY03tgnTeqmbMJcmo8FWeVE9jhVJeIKxhY=;
        b=RCM/nYbHYhF26ml+bw7CJB00Tu1bvizUk/NqVAQvp9vRXCFdKYgsl01pnwx5ej8ypI
         1YlAzlD1fYBTy6Oc2DhzQUDrhTLVFXLSgs31eQJokjPLkhtO2+8CkEbV5SZjyp5LNEme
         ziwwWEcQ430fUoAvokqDahZVU5hPf7/uvfR+1bYp/xNUAMXFaDXiD0hkMz15m8P7kWDm
         SVYKRLaENNJ6LNrWEUk1Zxh3fCOsIYMG1JeA0ttkbAVmmFd3dpbVcxKM39oe1BrLvPhy
         wqqi+JG0sUJqgbEuJIDFEEd+mU26HfLdO+3TR++rsfNG8L3CtDsdH2AUTmbQAlk4HPnN
         rE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5zuuxTOmeY03tgnTeqmbMJcmo8FWeVE9jhVJeIKxhY=;
        b=p8wLjPba72EUB0GgOJAXBGmYDMjeh0gJGHxe0FSV92YjKJImWyoiCvzK18LI/BeLEj
         s+hVyp1Y/sVxZjHhK8P8K+Gt2/4gN1rmg/k3cF43pIhW6Xm7WL9w2EmUNkHxoCHrskYD
         1b6Hzk3lx+yr6sYKSRreKqZn9evAtJcaI2VyGUv670w4wICRjwsY1USfYrR7FIcGfWgi
         zMdJbOYU/MeBfxlwflY0OyfgXmZwLkuLtq4FgmZaVOPl2IQ+OCBCB1f6kdPxFPGhVvz9
         NZm5SF0o4iry/I+F/ZHZu99cUvJUChFjJJn7nMe+DLFRpjkuSie7PbiraCHhg+8ER4Dr
         XOAQ==
X-Gm-Message-State: APjAAAVRu8pa7GX6edH6jQvVf14QmpB8KMUnhLmsstoQ+kflleU5Z4z5
        tZrXaZKwF0FdlD+ZNcOdjz2WzwqU+4BgZbbiJUvUig==
X-Google-Smtp-Source: APXvYqwrgPiaRBC36d3nGupFESCf7i3fbETUfZ+IXTIAh32oyWQQePytvF+stlAyZxSK3BBnvotq6eC5R+C5XYPzsDs=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr4046734oig.103.1582098885598;
 Tue, 18 Feb 2020 23:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211213128.73302-7-almasrymina@google.com> <cb402ae6-8424-c1f7-35ff-6acc68f9a23b@oracle.com>
In-Reply-To: <cb402ae6-8424-c1f7-35ff-6acc68f9a23b@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 18 Feb 2020 23:54:34 -0800
Message-ID: <CAHS8izOTipknnYaKz=FdzL-7yW-Z61ck1yPnYWixyMSJuTUYLQ@mail.gmail.com>
Subject: Re: [PATCH v12 7/9] hugetlb: support file_region coalescing again
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 18, 2020 at 7:31 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/11/20 1:31 PM, Mina Almasry wrote:
> > An earlier patch in this series disabled file_region coalescing in order
> > to hang the hugetlb_cgroup uncharge info on the file_region entries.
> >
> > This patch re-adds support for coalescing of file_region entries.
> > Essentially everytime we add an entry, we call a recursive function that
> > tries to coalesce the added region with the regions next to it. The
> > worst case call depth for this function is 3: one to coalesce with the
> > region next to it, one to coalesce to the region prev, and one to reach
> > the base case.
> >
> > This is an important performance optimization as private mappings add
> > their entries page by page, and we could incur big performance costs for
> > large mappings with lots of file_region entries in their resv_map.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > Changes in v12:
> > - Changed logic for coalescing. Instead of checking inline to coalesce
> > with only the region on next or prev, we now have a recursive function
> > that takes care of coalescing in both directions.
> > - For testing this code I added a bunch of debug code that checks that
> > the entries in the resv_map are coalesced appropriately. This passes
> > with libhugetlbfs tests.
> >
> > ---
> >  mm/hugetlb.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 2d62dd35399db..45219cb58ac71 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -276,6 +276,86 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
> >  #endif
> >  }
> >
> > +static bool has_same_uncharge_info(struct file_region *rg,
> > +                                struct file_region *org)
> > +{
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +     return rg && org &&
> > +            rg->reservation_counter == org->reservation_counter &&
> > +            rg->css == org->css;
> > +
> > +#else
> > +     return true;
> > +#endif
> > +}
> > +
> > +#ifdef CONFIG_DEBUG_VM
> > +static void dump_resv_map(struct resv_map *resv)
> > +{
> > +     struct list_head *head = &resv->regions;
> > +     struct file_region *rg = NULL;
> > +
> > +     pr_err("--------- start print resv_map ---------\n");
> > +     list_for_each_entry(rg, head, link) {
> > +             pr_err("rg->from=%ld, rg->to=%ld, rg->reservation_counter=%px, rg->css=%px\n",
> > +                    rg->from, rg->to, rg->reservation_counter, rg->css);
> > +     }
> > +     pr_err("--------- end print resv_map ---------\n");
> > +}
> > +
> > +/* Debug function to loop over the resv_map and make sure that coalescing is
> > + * working.
> > + */
> > +static void check_coalesce_bug(struct resv_map *resv)
> > +{
> > +     struct list_head *head = &resv->regions;
> > +     struct file_region *rg = NULL, *nrg = NULL;
> > +
> > +     list_for_each_entry(rg, head, link) {
> > +             nrg = list_next_entry(rg, link);
> > +
> > +             if (&nrg->link == head)
> > +                     break;
> > +
> > +             if (nrg->reservation_counter && nrg->from == rg->to &&
> > +                 nrg->reservation_counter == rg->reservation_counter &&
> > +                 nrg->css == rg->css) {
> > +                     dump_resv_map(resv);
> > +                     VM_BUG_ON(true);
> > +             }
> > +     }
> > +}
> > +#endif
> > +
> > +static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
> > +{
> > +     struct file_region *nrg = NULL, *prg = NULL;
> > +
> > +     prg = list_prev_entry(rg, link);
> > +     if (&prg->link != &resv->regions && prg->to == rg->from &&
> > +         has_same_uncharge_info(prg, rg)) {
> > +             prg->to = rg->to;
> > +
> > +             list_del(&rg->link);
> > +             kfree(rg);
> > +
> > +             coalesce_file_region(resv, prg);
> > +             return;
> > +     }
> > +
> > +     nrg = list_next_entry(rg, link);
> > +     if (&nrg->link != &resv->regions && nrg->from == rg->to &&
> > +         has_same_uncharge_info(nrg, rg)) {
> > +             nrg->from = rg->from;
> > +
> > +             list_del(&rg->link);
> > +             kfree(rg);
> > +
> > +             coalesce_file_region(resv, nrg);
> > +             return;
> > +     }
> > +}
> > +
> >  /* Must be called with resv->lock held. Calling this with count_only == true
> >   * will count the number of pages to be added but will not modify the linked
> >   * list. If regions_needed != NULL and count_only == true, then regions_needed
> > @@ -327,6 +407,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
> >                               record_hugetlb_cgroup_uncharge_info(h_cg, h,
> >                                                                   resv, nrg);
> >                               list_add(&nrg->link, rg->link.prev);
> > +                             coalesce_file_region(resv, nrg);
> >                       } else if (regions_needed)
> >                               *regions_needed += 1;
> >               }
> > @@ -344,11 +425,15 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
> >                               resv, last_accounted_offset, t);
> >                       record_hugetlb_cgroup_uncharge_info(h_cg, h, resv, nrg);
> >                       list_add(&nrg->link, rg->link.prev);
> > +                     coalesce_file_region(resv, nrg);
> >               } else if (regions_needed)
> >                       *regions_needed += 1;
> >       }
> >
> >       VM_BUG_ON(add < 0);
> > +#ifdef CONFIG_DEBUG_VM
> > +     check_coalesce_bug(resv);
> > +#endif
>
> Some distros have CONFIG_DEBUG_VM on in their default kernels.  Fedora comes
> to mind.  Yes, this means 'VM_BUG_ON()' become 'BUG_ON()'.  That is somewhat
> accepted.  I don't think we want this debug code behind CONFIG_DEBUG_VM and
> called each time a file region is added.  It may be overkill to make it a
> debug option via the config system.  Perhaps, just make it something like
> CONFIG_DEBUG_HUGETLB_RSV_REGION and let hugetlb developers turn it on if
> they would like?
>

Ah, I feel like adding a whole config to accommodate this function is
overkill and will end up being dead code anyway as no-one remembers to
turn it on. If it's the same to you I'll take it out of the patch and
leave it as a local change for me to test with.

> Other than that, the code looks good.
> --
> Mike Kravetz
>
> >       return add;
> >  }
> >
> > --
> > 2.25.0.225.g125e21ebc7-goog
> >
