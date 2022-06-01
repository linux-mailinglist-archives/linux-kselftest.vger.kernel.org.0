Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F2753AF2C
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 00:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiFAVr6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jun 2022 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiFAVr5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jun 2022 17:47:57 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03177E15EB
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Jun 2022 14:47:54 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ef5380669cso33039137b3.9
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Jun 2022 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJUCp0N7f8QZC5p1pY9lUtWxTt8Tl1s3y3X+X11zFbU=;
        b=D6xLdjE2nFKHbx08Hah09DsqZiFJ8nhVaq58ITr8nPW4TEC6nbeEHPyQsu0A5ytALO
         UfUTWLGxf9Euu4Ut/tms9s8+v18WQptypZ31HvOqNJUcvX7yPNVG5qT7KsSrA8iUsu3+
         U29NozcUeBeAncsUISoGUEuxfV1vsTpFnsm0r3atq7FIIpLVVrDj/gBDlGf3/SATMRt2
         u0lwebXXCfPeNeblrSU06Kofcj0UKDVbRBE+JsPf2cxI37YioBDJeEdWklvoDZL/RElC
         LyatQgDNLGKRMnFdqCfw4ohpeIh+v6LtWscUn2+t35p/TreRK42AznEHmENLbdnKPCHG
         by+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJUCp0N7f8QZC5p1pY9lUtWxTt8Tl1s3y3X+X11zFbU=;
        b=rT3tPVwWNjBJJdPqaqLH1IpDdPV5QAptpuicPzljrdI8FuDUzsf4McLTRzeNItqBHd
         n5pn+kM+i9brFKkgrttYGo9q+iAUXsWNk3G6yvdrrwlOSR1osx1W9Cp6/t71gXwKsuC5
         xFPp7/dcMQNjB1d1mYSdUMBjqQgCzSVqBPsMdcer585fThUI3t/Bd0seCQnUGdThnfAZ
         ghvSXXU6wX4CbN2zgmpM6sMPFIAq8sSPfnFFXzZy7gyBC+0ZEMMklnnrM2XH0EFVmen1
         4DPnq6O58QS8ir3mtPFOwgEAfw58sOVZXnHxom3a2sg0GqDYjsXOH8nkinrkSkD9c2sP
         vZbA==
X-Gm-Message-State: AOAM530dF/7QLfRjPbUBIu66ELCQgSjEuKZYL71Amj1wMIpYoFnMvi8N
        Qxh/8uVtI+96rI8RKQT/Qwr47z3fQIbBTR737xIxhg==
X-Google-Smtp-Source: ABdhPJwe19en89ldneIXAnekYCLdysaznIhe/fqWRXNnu/agTjuzcYCOmrjAQ/x14PZSn3c+bBkGCPzOE4bGbyLLrug=
X-Received: by 2002:a81:53c5:0:b0:301:ea23:5b09 with SMTP id
 h188-20020a8153c5000000b00301ea235b09mr1945845ywb.237.1654120072955; Wed, 01
 Jun 2022 14:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220531223100.510392-1-surenb@google.com> <20220601143638.9e78c470d2c980053cc8059a@linux-foundation.org>
In-Reply-To: <20220601143638.9e78c470d2c980053cc8059a@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Jun 2022 14:47:41 -0700
Message-ID: <CAJuCfpHcPhDYTpLj8Vo+W9Q6KkWdT_BOTaEfJW6_PDCPx5kD-A@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] mm: drop oom code from exit_mmap
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
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
        kernel-team <kernel-team@android.com>,
        Liam Howlett <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 1, 2022 at 2:36 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 31 May 2022 15:30:59 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > The primary reason to invoke the oom reaper from the exit_mmap path used
> > to be a prevention of an excessive oom killing if the oom victim exit
> > races with the oom reaper (see [1] for more details). The invocation has
> > moved around since then because of the interaction with the munlock
> > logic but the underlying reason has remained the same (see [2]).
> >
> > Munlock code is no longer a problem since [3] and there shouldn't be
> > any blocking operation before the memory is unmapped by exit_mmap so
> > the oom reaper invocation can be dropped. The unmapping part can be done
> > with the non-exclusive mmap_sem and the exclusive one is only required
> > when page tables are freed.
> >
> > Remove the oom_reaper from exit_mmap which will make the code easier to
> > read. This is really unlikely to make any observable difference although
> > some microbenchmarks could benefit from one less branch that needs to be
> > evaluated even though it almost never is true.
> >
> > [1] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
> > [2] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> > [3] a213e5cf71cb ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")
> >
>
> I've just reinstated the mapletree patchset so there are some
> conflicting changes.
>
> > --- a/include/linux/oom.h
> > +++ b/include/linux/oom.h
> > @@ -106,8 +106,6 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
> >       return 0;
> >  }
> >
> > -bool __oom_reap_task_mm(struct mm_struct *mm);
> > -
> >  long oom_badness(struct task_struct *p,
> >               unsigned long totalpages);
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 2b9305ed0dda..b7918e6bb0db 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3110,30 +3110,13 @@ void exit_mmap(struct mm_struct *mm)
> >       /* mm's last user has gone, and its about to be pulled down */
> >       mmu_notifier_release(mm);
> >
> > -     if (unlikely(mm_is_oom_victim(mm))) {
> > -             /*
> > -              * Manually reap the mm to free as much memory as possible.
> > -              * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> > -              * this mm from further consideration.  Taking mm->mmap_lock for
> > -              * write after setting MMF_OOM_SKIP will guarantee that the oom
> > -              * reaper will not run on this mm again after mmap_lock is
> > -              * dropped.
> > -              *
> > -              * Nothing can be holding mm->mmap_lock here and the above call
> > -              * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
> > -              * __oom_reap_task_mm() will not block.
> > -              */
> > -             (void)__oom_reap_task_mm(mm);
> > -             set_bit(MMF_OOM_SKIP, &mm->flags);
> > -     }
> > -
> > -     mmap_write_lock(mm);
> > +     mmap_read_lock(mm);
>
> Unclear why this patch fiddles with the mm_struct locking in this
> fashion - changelogging that would have been helpful.

Yeah, I should have clarified this in the description. Everything up
to unmap_vmas() can be done under mmap_read_lock and that way
oom-reaper and process_mrelease can do the unmapping in parallel with
exit_mmap. That's the reason we take mmap_read_lock, unmap the vmas,
mark the mm with MMF_OOM_SKIP and take the mmap_write_lock to execute
free_pgtables. I think maple trees do not change that except there is
no mm->mmap anymore, so the line at the end of exit_mmap where we
reset mm->mmap to NULL can be removed (I show that line below).

>
> But iirc mapletree wants to retain a write_lock here, so I ended up with
>
> void exit_mmap(struct mm_struct *mm)
> {
>         struct mmu_gather tlb;
>         struct vm_area_struct *vma;
>         unsigned long nr_accounted = 0;
>         MA_STATE(mas, &mm->mm_mt, 0, 0);
>         int count = 0;
>
>         /* mm's last user has gone, and its about to be pulled down */
>         mmu_notifier_release(mm);
>
>         mmap_write_lock(mm);
>         arch_exit_mmap(mm);
>
>         vma = mas_find(&mas, ULONG_MAX);
>         if (!vma) {
>                 /* Can happen if dup_mmap() received an OOM */
>                 mmap_write_unlock(mm);
>                 return;
>         }
>
>         lru_add_drain();
>         flush_cache_mm(mm);
>         tlb_gather_mmu_fullmm(&tlb, mm);
>         /* update_hiwater_rss(mm) here? but nobody should be looking */
>         /* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
>         unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
>
>         /*
>          * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
>          * because the memory has been already freed. Do not bother checking
>          * mm_is_oom_victim because setting a bit unconditionally is cheaper.
>          */
>         set_bit(MMF_OOM_SKIP, &mm->flags);
>         free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS,
>                       USER_PGTABLES_CEILING);
>         tlb_finish_mmu(&tlb);
>
>         /*
>          * Walk the list again, actually closing and freeing it, with preemption
>          * enabled, without holding any MM locks besides the unreachable
>          * mmap_write_lock.
>          */
>         do {
>                 if (vma->vm_flags & VM_ACCOUNT)
>                         nr_accounted += vma_pages(vma);
>                 remove_vma(vma);
>                 count++;
>                 cond_resched();
>         } while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
>
>         BUG_ON(count != mm->map_count);
>
>         trace_exit_mmap(mm);
>         __mt_destroy(&mm->mm_mt);
>         mm->mmap = NULL;

^^^ this line above needs to be removed when the patch is applied over
the maple tree patchset.


>         mmap_write_unlock(mm);
>         vm_unacct_memory(nr_accounted);
> }
>
