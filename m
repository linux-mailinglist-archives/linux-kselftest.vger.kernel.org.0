Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F5613B581
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 23:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgANWxA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 17:53:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42796 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgANWw7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 17:52:59 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so14328872otd.9
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2020 14:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJtNfvQPx9MiBAuYZtkLpTeT5BO5WkJk3mTGoJfjU7s=;
        b=o9gUDnz5jpe+CiIZYHYrpzQ0gklH8dSzlV0V5rU3UZuJqVw3CeAXzUvseADgwVpJ7u
         w4bINIdxg9skSJEoZ8a3U2UWn9tWTp17RAbPRwTe35q9x8gmdrs0RMlH3wo9nyh13LaO
         tWHBLZzSolC7SMA/mYEjulaVAxYm5wWZLA4q61MyidJApDY493NSCbvvZBjQZaD/ifDQ
         X2DqkzQjv4UN6OCFvQDXEO54lw1eltlZG3yN+vJYwiRygT5uzceKEXN2SJu0owmn+Kn+
         JFbABS6lKqtKSXUaN/XbTRiGuFiQvGOFPAXCmNfK1I+kuDQjPVk0iGS4jK4529EgLCm5
         J96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJtNfvQPx9MiBAuYZtkLpTeT5BO5WkJk3mTGoJfjU7s=;
        b=WmmGvaLZJ4sO6vb48owXqxhNtc5F2cJxYFrYmZRB+ZZxmmFI9ah+1F5vz3TiL9Ucl9
         AyV0g5HLAJINTMdv1DgivUokjLL4aRN51G2tWn7JVdDcp+qc6+br9GF7DSK8Xbitr5ZQ
         VFy5gddofAfEAplKbQ4kB9VzW5PzB98Pzm2gOTg57sD1zWoXY7cggfNQnK6qyIQdCrXt
         0rmmdTQKUEqQm2+Z3/eVl57GeNMfnG6SCtkHDLzfLLabbSZbEMT6jZ9DXiivun5KCdpC
         4Wq5OCBwST5qnVQd5LZ8jf+VaBBMH0D+87CC1nBrsM13VIq42XJ/3vGzUKSdHb45Vkjs
         Y48Q==
X-Gm-Message-State: APjAAAURyitCuOgerUWqj4t6z6tic3RoqzReq+Y/sbW0Rj/YWaZXHPbF
        FNXow1lRdauFYexiS/vdaMNo2Gm58G5H2kAl3s4ieQ==
X-Google-Smtp-Source: APXvYqxrNZMinjspu4inEaBcza9QCTgWkgoCXnc5Q5cQmERuz8yAYG/VoatDOt3ousc+3PSIZdk0IJl6QzzPcJ85qcc=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr572976ota.127.1579042378672;
 Tue, 14 Jan 2020 14:52:58 -0800 (PST)
MIME-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191217231615.164161-3-almasrymina@google.com> <dec1ccd5-5973-c498-f2fe-390c1c51b2d0@oracle.com>
In-Reply-To: <dec1ccd5-5973-c498-f2fe-390c1c51b2d0@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 14 Jan 2020 14:52:47 -0800
Message-ID: <CAHS8izMzXpNMCmFh_SD7n+4+rj3QTqyRfeWQyXAhFo1-qV4iEQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] hugetlb_cgroup: add reservation accounting for
 private mappings
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 4:55 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index dea6143aa0685..e6ab499ba2086 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -46,6 +46,15 @@ struct resv_map {
> >       long adds_in_progress;
> >       struct list_head region_cache;
> >       long region_cache_count;
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +     /*
> > +      * On private mappings, the counter to uncharge reservations is stored
> > +      * here. If these fields are 0, then the mapping is shared.
>
> Will *reservation_counter ALWAYS be non-NULL for private mappings?
>
> More on this below.
>
> > +      */
> > +     struct page_counter *reservation_counter;
> > +     unsigned long pages_per_hpage;
> > +     struct cgroup_subsys_state *css;
> > +#endif
> >  };
> >  extern struct resv_map *resv_map_alloc(void);
> >  void resv_map_release(struct kref *ref);
> > diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> > index eab8a70d5bcb5..8c320accefe87 100644
> > --- a/include/linux/hugetlb_cgroup.h
> > +++ b/include/linux/hugetlb_cgroup.h
> > @@ -25,6 +25,33 @@ struct hugetlb_cgroup;
> >  #define HUGETLB_CGROUP_MIN_ORDER     2
> >
> >  #ifdef CONFIG_CGROUP_HUGETLB
> > +enum hugetlb_memory_event {
> > +     HUGETLB_MAX,
> > +     HUGETLB_NR_MEMORY_EVENTS,
> > +};
> > +
> > +struct hugetlb_cgroup {
> > +     struct cgroup_subsys_state css;
> > +
> > +     /*
> > +      * the counter to account for hugepages from hugetlb.
> > +      */
> > +     struct page_counter hugepage[HUGE_MAX_HSTATE];
> > +
> > +     /*
> > +      * the counter to account for hugepage reservations from hugetlb.
> > +      */
> > +     struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
> > +
> > +     atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
> > +     atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
> > +
> > +     /* Handle for "hugetlb.events" */
> > +     struct cgroup_file events_file[HUGE_MAX_HSTATE];
> > +
> > +     /* Handle for "hugetlb.events.local" */
> > +     struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
> > +};
> >
> >  static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
> >                                                             bool reserved)
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index e6e8240f1718c..7782977970301 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -665,6 +665,17 @@ struct resv_map *resv_map_alloc(void)
> >       INIT_LIST_HEAD(&resv_map->regions);
> >
> >       resv_map->adds_in_progress = 0;
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +     /*
> > +      * Initialize these to 0. On shared mappings, 0's here indicate these
> > +      * fields don't do cgroup accounting. On private mappings, these will be
> > +      * re-initialized to the proper values, to indicate that hugetlb cgroup
> > +      * reservations are to be un-charged from here.
> > +      */
> > +     resv_map->reservation_counter = NULL;
> > +     resv_map->pages_per_hpage = 0;
> > +     resv_map->css = NULL;
> > +#endif
> >
> >       INIT_LIST_HEAD(&resv_map->region_cache);
> >       list_add(&rg->link, &resv_map->region_cache);
> > @@ -3145,7 +3156,20 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
> >
> >       reserve = (end - start) - region_count(resv, start, end);
> >
> > -     kref_put(&resv->refs, resv_map_release);
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +     /*
> > +      * Since we check for HPAGE_RESV_OWNER above, this must a private
> > +      * mapping, and these values should be none-zero, and should point to
> > +      * the hugetlb_cgroup counter to uncharge for this reservation.
> > +      */
> > +     WARN_ON(!resv->reservation_counter);
> > +     WARN_ON(!resv->pages_per_hpage);
> > +     WARN_ON(!resv->css);
>
> I was once again wondering if these were always non-NULL for private mappings.
> It seems that reservation_counter (h_gc) would be NULL in these cases from
> these early checks in hugetlb_cgroup_charge_cgroup().
>

You are right. I'm fixing in v10 the code and comments to account for
h_cg potentially being NULL, but I'm having trouble testing. Looking
at the code, I'm a bit confused by the checks. Seems to me
hugetlb_cgroup_disabled() is the same as #ifdef CONFIG_CGROUP_HUGETLB;
I can't find a way to enable the Kconfig but have that return false
unless I hack the code. Also seems to me checking huge_page_order is
just super definsive; I skimmed the hugepage sizes allowed code and I
can't find an arch that allows you to configure hugetlb page size to <
2^HUGETLB_CGROUP_MIN_ORDER pages. So in reality these will never fire,
IIUC.

> int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
>                                  struct hugetlb_cgroup **ptr, bool reserved)
> {
>         int ret = 0;
>         struct page_counter *counter;
>         struct hugetlb_cgroup *h_cg = NULL;
>
>         if (hugetlb_cgroup_disabled())
>                 goto done;
>         /*
>          * We don't charge any cgroup if the compound page have less
>          * than 3 pages.
>          */
>         if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
>                 goto done;
>         ...
>
> It seems like the following hugetlb_cgroup_uncharge_counter() guards
> against reservation_counter being NULL (for some of the same reasons).
>
> > +
> > +     hugetlb_cgroup_uncharge_counter(resv->reservation_counter,
> > +                                     (end - start) * resv->pages_per_hpage,
> > +                                     resv->css);
> > +#endif
> >
> >       if (reserve) {
> >               /*
> > @@ -3155,6 +3179,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
> >               gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
> >               hugetlb_acct_memory(h, -gbl_reserve);
> >       }
> > +
> > +     kref_put(&resv->refs, resv_map_release);
> >  }
> >
> >  static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
> > @@ -4501,6 +4527,7 @@ int hugetlb_reserve_pages(struct inode *inode,
> >       struct hstate *h = hstate_inode(inode);
> >       struct hugepage_subpool *spool = subpool_inode(inode);
> >       struct resv_map *resv_map;
> > +     struct hugetlb_cgroup *h_cg;
> >       long gbl_reserve;
> >
> >       /* This should never happen */
> > @@ -4534,12 +4561,30 @@ int hugetlb_reserve_pages(struct inode *inode,
> >               chg = region_chg(resv_map, from, to);
> >
> >       } else {
> > +             /* Private mapping. */
> >               resv_map = resv_map_alloc();
> >               if (!resv_map)
> >                       return -ENOMEM;
> >
> >               chg = to - from;
> >
> > +             if (hugetlb_cgroup_charge_cgroup(hstate_index(h),
> > +                                              chg * pages_per_huge_page(h),
> > +                                              &h_cg, true)) {
> > +                     kref_put(&resv_map->refs, resv_map_release);
> > +                     return -ENOMEM;
> > +             }
> > +
>
> Shouldn't this code be in the #ifdef CONFIG_CGROUP_HUGETLB block?

Not necessary AFAICT, hugetlb_cgroup_charge_cgroup stub returns 0 (no-op).
