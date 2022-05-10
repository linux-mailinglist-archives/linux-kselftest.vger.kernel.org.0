Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0210F522146
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiEJQgc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347451AbiEJQgD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:36:03 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED7446659
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:32:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ebf4b91212so185926977b3.8
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbeafxozpMoUIoZYNiBhClKUTEoirWTIQT5SbIYMvgY=;
        b=S93KyGQn2wdSML11sOCTMuFkKrJFU5aOaCEo6hMoFsAJapfw/z68o2XJdecid4v+1w
         5imt+0Tx2VA5Vu0BuP+ng9175P6tfMna5xwMriqyMcXBC32q4QI/s621h3BBgi6KDzQ/
         /mQP6iTHWSiLU05VebTJQUvcyuU6PXOilhDXPEdxHnmozF0thna7eLKi30v72QlorLwf
         yPSDt66K84FKyGuXD21ARYWgDIwrbqtGdsAPXhF+f5BYkS98SXfMzv6eHtmi8Ufq/HLP
         TE++Ad09hh94UwED/ms3PenfmiGwBKBz78O+UiOdC1lROufFPAfZ3ZnlrVlCIlyg5IUl
         uIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbeafxozpMoUIoZYNiBhClKUTEoirWTIQT5SbIYMvgY=;
        b=1RtsNeJwO43lif38NcdqfUZ92RBwb/7PvCWLxi/zqaxK+kae+Up48y7TrFse9zo7Qo
         bHfEdEtA30gFYzfvchORvMggn+zmxvIuYbY6S1HBsJFkmo5TyqTF/z64wVmOocXLlDuq
         T4dwz3tB9R3a04LeUGGklakzCsoVC+cQCbqIyviqykC8ZPsmoQZoSc5nEvgPf6wMM0H5
         AWqzFtSGgk8FXLCDKT+AMw8gGmzWKABYok27Jrlk8LyfLixJG+lSt1b5S46V5IMnOWgB
         iDzxElifKqNbXZSWzl30FW0ZSCoS5rtjYnkqZnMZOfflYbzR8nMWA9UtYxl+atkMSToU
         iLNg==
X-Gm-Message-State: AOAM5304c0FVtkHrRYQGR1OzF6C2a1N+g20kkfk41SyScb/COJ7J7Tcm
        wZX3NcPDyZ29DNyTAIe+fyX24hTRZjHMxPFg0GPLGw==
X-Google-Smtp-Source: ABdhPJyXHvPFrLpD9JHZCeHuyGvGIXtbfBGwcobE9WuG1B4tDoKEOWroGcOYYXCzJn0wqwei/jnuhTj3Vn3KvonB3oQ=
X-Received: by 2002:a81:6cc3:0:b0:2f7:cc1f:b52d with SMTP id
 h186-20020a816cc3000000b002f7cc1fb52dmr20616990ywc.293.1652200321217; Tue, 10
 May 2022 09:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220510030014.3842475-1-surenb@google.com> <20220510030014.3842475-2-surenb@google.com>
 <YnpjNyrdqT/QxBPI@dhcp22.suse.cz>
In-Reply-To: <YnpjNyrdqT/QxBPI@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 10 May 2022 09:31:50 -0700
Message-ID: <CAJuCfpEt9SSrELZzfmcqJ7JL_nEzWGz-YE9GRUZTjU5unqQjQg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: drop oom code from exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 10, 2022 at 6:06 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 09-05-22 20:00:13, Suren Baghdasaryan wrote:
> > With the oom-killer being able to operate on locked pages, exit_mmap
> > does not need to ensure that oom_reap_task_mm is done before it can
> > proceed. Instead it can rely on mmap_lock write lock to prevent
> > oom-killer from operating on the vma tree while it's freeing page
> > tables. exit_mmap can hold mmap_lock read lock when unmapping vmas
> > and then take mmap_lock write lock before freeing page tables.
>
> The changelog is rather light on nasty details which might be good but
> for the sake of our future us let's be more verbose so that we do not
> have to reinvent the prior history each time we are looking into this
> code. I would go with something like this instead:
> "
> The primary reason to invoke the oom reaper from the exit_mmap path used
> to be a prevention of an excessive oom killing if the oom victim exit
> races with the oom reaper (see 212925802454 ("mm: oom: let oom_reap_task
> and exit_mmap run concurrently") for more details. The invocation has
> moved around since then because of the interaction with the munlock
> logic but the underlying reason has remained the same (see 27ae357fa82b
> ("mm, oom: fix concurrent munlock and oom reaper unmap, v3").
>
> Munlock code is no longer a problem since a213e5cf71cb ("mm/munlock:
> delete munlock_vma_pages_all(), allow oomreap") and there shouldn't be
> any blocking operation before the memory is unmapped by exit_mmap so
> the oom reaper invocation can be dropped. The unmapping part can be done
> with the non-exclusive mmap_sem and the exclusive one is only required
> when page tables are freed.
>
> Remove the oom_reaper from exit_mmap which will make the code easier to
> read. This is really unlikely to make any observable difference although
> some microbenchmarks could benefit from one less branch that needs to be
> evaluated even though it almost never is true.
> "

Looks great! Thanks for collecting all the history. Will update the description.

>
> One minor comment below. Other than that \o/ this is finally going away.
> I strongly suspect that the history of this code is a nice example about how
> over optimizing code can cause more harm than good.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

>
> Thanks!
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/oom.h |  2 --
> >  mm/mmap.c           | 25 ++++++-------------------
> >  mm/oom_kill.c       |  2 +-
> >  3 files changed, 7 insertions(+), 22 deletions(-)
> >
> [...]
> > @@ -3138,6 +3121,10 @@ void exit_mmap(struct mm_struct *mm)
> >       /* update_hiwater_rss(mm) here? but nobody should be looking */
> >       /* Use -1 here to ensure all VMAs in the mm are unmapped */
> >       unmap_vmas(&tlb, vma, 0, -1);
> > +     mmap_read_unlock(mm);
> > +     /* Set MMF_OOM_SKIP to disregard this mm from further consideration.*/
> > +     set_bit(MMF_OOM_SKIP, &mm->flags);
>
> I think that it would be slightly more readable to add an empty line
> above and below of this. Also the comment would be more helpful if it
> explaind what the further consideration actually means. I would go with
>
>         /*
>          * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
>          * because the memory has been already freed. Do not bother
>          * checking mm_is_oom_victim because setting a bit
>          * unconditionally is just cheaper.
>          */
>

Ack.

> > +     mmap_write_lock(mm);
> >       free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> >       tlb_finish_mmu(&tlb);
>
> --
> Michal Hocko
> SUSE Labs
