Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13405220D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbiEJQO5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347019AbiEJQO4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:14:56 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B994B2316B
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:10:57 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r1so4899857ybo.7
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWr6j8L83YvC4oASSY1+KN7VXDAW39s2toR1CA0dOGM=;
        b=RlY/r9s3r9kOyisJCmDy9MdyIjnatnPNsx5zqhU5hy+tmdsBoq6TF36hxb9T4906as
         bYTWoizuhtwJHb2AF1uriEvmqhjci5KVeh7DADQgrNrImJXfNPm66sQRkba/MIAThsi3
         i9RE/oJtZqzqxbWczthqmb/xHpq3M1yZaqKpmKDHryIz5VJ7bOLFNcfrFT93N1Cesiwm
         8zATZIVKIntG+AV/qUl89gwyaM7nJK3zuei11ezzA9SKpumXz3nHAV1rdIwveht/78sX
         bj4NGXJceokJyDg7yyqDg1tGRW8DKu8s/UOykw/JSaTmEJUhcRxE3d7dvliXDNp3Brlb
         RduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWr6j8L83YvC4oASSY1+KN7VXDAW39s2toR1CA0dOGM=;
        b=0+pR1SlqxDFO8fZ4mpvsVEx4OT9Layd9V0SCxWuWtSm0W75rhPWrve0ADtWqRBToKU
         rJ9SOEOMe0ksn1xSigYWbc+oY6HHlp/d7cgrKQMp1zcqRY4b1vJYD7SYnSzjF+b3JK2e
         f00ljxoVeARE19jcHLYoJN/x/NeCusufPwec+ePt77Pi6+QJeGsWhdYrXaiZFzxhnbAR
         XZSFBhMAt/C4SVAIyqktZrgM9CD0E8W6EpIkist7M20uWGTDHBbS2Ujvj+s9lz81dIGK
         oCWfZyjSHlVq70dEbRvZxglV2/HRpJG9XPev2/NKFrm1K59W3w/kD4fPPiuFlm1ixKo5
         pbPQ==
X-Gm-Message-State: AOAM532KUt1NkhRtfn2v5TKRZvHD2U4OpTC3EW1bHQPhz/vr2zu4LmWj
        JtzrQl/NvhyVoVAr6Usy795o09rMG+MxMy0R4uu9mg==
X-Google-Smtp-Source: ABdhPJxw2puCwa3aeQ2ujP92lgV0IWtmFRYyzeAebZNg7CXo5t9A9KOZycbj33LXrbCpqmmrklTc/q9gZ69BS9j8rk8=
X-Received: by 2002:a05:6902:13c2:b0:641:b6d:a151 with SMTP id
 y2-20020a05690213c200b006410b6da151mr18715929ybu.348.1652199056496; Tue, 10
 May 2022 09:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220510030014.3842475-1-surenb@google.com> <20220510030014.3842475-3-surenb@google.com>
 <008de890-7fe1-aeae-345e-0cd3fcd32352@linuxfoundation.org>
In-Reply-To: <008de890-7fe1-aeae-345e-0cd3fcd32352@linuxfoundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 10 May 2022 09:10:45 -0700
Message-ID: <CAJuCfpFHxAdiVWvsU6HvpBcme5AJV-Pytkpdow2mWs1+RL1XdQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: delete unused MMF_OOM_VICTIM flag
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
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

On Tue, May 10, 2022 at 8:51 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/9/22 9:00 PM, Suren Baghdasaryan wrote:
> > With the last usage of MMF_OOM_VICTIM in exit_mmap gone, this flag is
> > now unused and can be removed.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >   include/linux/oom.h            | 9 ---------
> >   include/linux/sched/coredump.h | 1 -
> >   mm/oom_kill.c                  | 4 +---
> >   3 files changed, 1 insertion(+), 13 deletions(-)
> >
> > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > index 6cdf0772dbae..25990e9d9e15 100644
> > --- a/include/linux/oom.h
> > +++ b/include/linux/oom.h
> > @@ -77,15 +77,6 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
> >       return tsk->signal->oom_mm;
> >   }
> >
> > -/*
> > - * Use this helper if tsk->mm != mm and the victim mm needs a special
> > - * handling. This is guaranteed to stay true after once set.
> > - */
> > -static inline bool mm_is_oom_victim(struct mm_struct *mm)
> > -{
> > -     return test_bit(MMF_OOM_VICTIM, &mm->flags);
> > -}
> > -
> >   /*
> >    * Checks whether a page fault on the given mm is still reliable.
> >    * This is no longer true if the oom reaper started to reap the
> > diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> > index 4d9e3a656875..746f6cb07a20 100644
> > --- a/include/linux/sched/coredump.h
> > +++ b/include/linux/sched/coredump.h
> > @@ -70,7 +70,6 @@ static inline int get_dumpable(struct mm_struct *mm)
> >   #define MMF_UNSTABLE                22      /* mm is unstable for copy_from_user */
> >   #define MMF_HUGE_ZERO_PAGE  23      /* mm has ever used the global huge zero page */
> >   #define MMF_DISABLE_THP             24      /* disable THP for all VMAs */
> > -#define MMF_OOM_VICTIM               25      /* mm is the oom victim */
> >   #define MMF_OOM_REAP_QUEUED 26      /* mm was queued for oom_reaper */
> >   #define MMF_MULTIPROCESS    27      /* mm is shared between processes */
> >   /*
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 36355b162727..11291b99599f 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -732,10 +732,8 @@ static void mark_oom_victim(struct task_struct *tsk)
> >               return;
> >
> >       /* oom_mm is bound to the signal struct life time. */
> > -     if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm)) {
> > +     if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm))
> >               mmgrab(tsk->signal->oom_mm);
> > -             set_bit(MMF_OOM_VICTIM, &mm->flags);
> > -     }
> >
> >       /*
> >        * Make sure that the task is woken up from uninterruptible sleep
> >
>
> Thank you for working on the new tests and cleanups.

Thanks for the review!

>
> This series needs a cover-letter that explains why this series is needed
> that includes the information from this last patch.
>
> Please send v2 with a proper cover letter starting with why this series
> is necessary. If you did that, it would have reviewers job is lot easier.
>
> Also it appears you are combining new tests with cleanup patches. I think
> patches 2/3 and 3/3 can be a separate series and the new test can be a
> separate patch.

I used the new selftest to test the patches but otherwise it's true,
they are unrelated. I was debating whether to send them separately and
with your blessing I'll split them up.
Thanks,
Suren.

>
> thanks,
> -- Shuah
