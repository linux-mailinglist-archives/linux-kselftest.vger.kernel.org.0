Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87195A3F85
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Aug 2022 21:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiH1Tut (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 15:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiH1Tur (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 15:50:47 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFC265AD
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Aug 2022 12:50:46 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id c3so6516827vsc.6
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Aug 2022 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+v2zwEcOJT455DYq2PDJ2m5npdfWrDTIt86gNrYfAfc=;
        b=oRjN+/A3WWnFFM0BPcVi0Rc5jIQqm8bbut4KMQbcLOXSVdF/l7ANaTrz/m76a7yhgk
         sTfbpElKdUCXDUF2HcblLXwtEks/hAH38xZrjJCRRloAibkhv6IPg9yWoJfAOyfoEOth
         n3Q4cOT2p8W83ogFv9rr080RipI7MCgzhsYRiOaxuRyb/Fumw3jRGN9WtM/J45Oftz0j
         w/ISKLFvjb5v+z4OgCig/n3W4rRtb15AlKLVLUpqNh3uQ3e7zzkRcoIR15avWeNmG/vx
         HdjoQ2KTVAUCRbtrXXPWj/TIMqOT5r6amvVOUWLumM58u3ltyHbMb/6BRHqfz1/yC+oR
         PNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+v2zwEcOJT455DYq2PDJ2m5npdfWrDTIt86gNrYfAfc=;
        b=rHKuR7hK5nLRAnFWb/xFbX7a8o4xcXGI3HTGoRMvxX3mvBlZeBHnmf5p1oYEdLEgD5
         jVm4lpJXl8Xei2F+zsxnby8PHXr31KQn1dCsNYRqFxh0RpHWOG1aQdw+eUfhL9Q2htUq
         YCg9G70tr8bo+ErrgOlaXM7c1Aymzs6JsJbJGEJr8Uz9wukKnS6henQO1QKdPVV8ZyyO
         pqo1OyTDvBmS/957sdYuMMjWKB+oP/alzh+T8cCU5+slO8ANbDhkJunoApjm7dllTK7S
         bdWhWSGeFDi2EpD0DXGkk7jWaeO1NCPELdbUnvNu9sxOAfg7ZAOpwLxkypsQjEsNkhyK
         SMqg==
X-Gm-Message-State: ACgBeo2bsgy9gPxMKf7UAd/whugGCIXhjlJx4/uofMrPZ+u7lA03aBNF
        d2X2nREcleFjYdvYQucnGbr4U0mmyMASpcAol9MiJA==
X-Google-Smtp-Source: AA6agR4zBYiEXFieLaETyfJ8Rsax+YVm7x98jgZmyuW38pyWvv0P0eVR13oXtS3rt8TGtr2WBnmNel188rmvTCCwRYk=
X-Received: by 2002:a67:b009:0:b0:38a:e0f2:4108 with SMTP id
 z9-20020a67b009000000b0038ae0f24108mr2599399vse.9.1661716245413; Sun, 28 Aug
 2022 12:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220531223100.510392-1-surenb@google.com> <20220531223100.510392-2-surenb@google.com>
 <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
 <CAOUHufbysRjhX_AiFirjvWCR129t4_bELd1wFQG+fBsZpzhgYw@mail.gmail.com>
 <20220822154822.366a9e4527b748cf99d98637@linux-foundation.org>
 <CAOUHufa1zc3fMWsyyz1uB6_gsgVPk1Hw_T31WzWK58QVgsQSAQ@mail.gmail.com>
 <20220822161603.9e19edfe2daaea3bf591910a@linux-foundation.org>
 <CAOUHufbyWwkOAJTD4G82sLcwE_33Yy=s4Q+gGBujwXvEBZ8iqA@mail.gmail.com> <YwSRf3LZ7gXwWaNN@dhcp22.suse.cz>
In-Reply-To: <YwSRf3LZ7gXwWaNN@dhcp22.suse.cz>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 28 Aug 2022 13:50:09 -0600
Message-ID: <CAOUHufbauOoXshmfbBYAnPVYkrZ=jFA2wpPotXNnOjoWVRa5qQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>, brauner@kernel.org,
        Christoph Hellwig <hch@infradead.org>, oleg@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
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

On Tue, Aug 23, 2022 at 2:36 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 22-08-22 17:20:17, Yu Zhao wrote:
> > On Mon, Aug 22, 2022 at 5:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Mon, 22 Aug 2022 16:59:29 -0600 Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > > > > @@ -4109,7 +4109,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned
> > > > > > long start, unsigned long end,
> > > > > >
> > > > > >                 walk_pmd_range(&val, addr, next, args);
> > > > > >
> > > > > > -               if (mm_is_oom_victim(args->mm))
> > > > > > +               if (test_bit(MMF_OOM_REAP_QUEUED, &args->mm->flags))
> > > > > >                         return 1;
> > > > > >
> > > > > >                 /* a racy check to curtail the waiting time */
> > > > >
> > > > > Oh.  Why?  What does this change do?
> > > >
> > > > The MMF_OOM_REAP_QUEUED flag is similar to the deleted MMF_OOM_VICTIM
> > > > flag, but it's set at a later stage during an OOM kill.
> > > >
> > > > When either is set, the OOM reaper is probably already freeing the
> > > > memory of this mm_struct, or at least it's going to. So there is no
> > > > need to dwell on it in the reclaim path, hence not about correctness.
> > >
> > > Thanks.  That sounds worthy of some code comments?
> >
> > Will do. Thanks.
>
> I would rather not see this abuse.

I understand where you're coming from, however, I don't share this
POV. I see it as cooperation -- the page reclaim and the oom/reaper
can't (or at least shouldn't) operate in isolation.

> You cannot really make any
> assumptions about oom_reaper and how quickly it is going to free the
> memory.

Agreed. But here we are talking about heuristics, not dependencies on
certain behaviors. Assume we are playing a guessing game: there are
multiple mm_structs available for reclaim, would the oom-killed ones
be more profitable on average? I'd say no, because I assume it's more
likely than unlikely that the oom reaper is doing/to do its work. Note
that the assumption is about likelihood, hence arguably valid.

> If this is really worth it (and I have to say I doubt it) then
> it should be a separate patch with numbers justifying it.

I definitely can artificially create a test case that runs oom a few
times per second, to prove this two-liner is beneficial to that
scenario. Then there is the question how much it would benefit the
real-world scenarios.

I'd recommend keeping this two-liner if we still had
mm_is_oom_victim(), because it's simple, clear and intuitive. With
MMF_OOM_REAP_QUEUED, I don't have a strong opinion. Since you do, I'll
just delete it.
