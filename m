Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3659CBD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 01:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiHVXAI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 19:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiHVXAI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 19:00:08 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C49C4DF13
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 16:00:06 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id o123so12813893vsc.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CM+r2jDGi3Z1TY+2nDEEa9bz6Cg3yXP3SO7YhqCHkfo=;
        b=Fr4ZUOwdWXPMWZ0VIHwPHNgnoI5vRT/AKqrE1La5ulyUniUsetq7t6w4qi4Tj30KgQ
         aujMKcxmiWsb3YvpamUxbl8zMbQJJbv1lsgsyWYXtBqwUGVgpV2Ydzp1NdfAUnMkovb2
         lIG66WjOS9iJKkXJLidAFbWQthLLWYlTUg7QI0vTlpePU0jcFWQoI3qBJiKJxSBBKJzI
         /TSaEZxLBRFc7HzsZro7nHfqq5FJdPwiaZFUIvnj9rKwwXaqHHfg2ewEb3/+WyJThfJ5
         YlW5CrXOD4oDXH94xu4+GKkDslxcKAjdavOsENDv+vxICJgtGpTqmDNJuttyCBg7if6i
         A/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CM+r2jDGi3Z1TY+2nDEEa9bz6Cg3yXP3SO7YhqCHkfo=;
        b=TFSj9thQqugx7ancBaXvFopRUruZU3xe99We5p6mJ+fwkw2Sgx8D/yR5VFA177EbI3
         6YYOJ2PbT6y9qRCPjgA3dqkTsi/x1/JEbDVqEvjEgPcCUbZ7H26j/uJfz6l7VKehRhxZ
         u2wAhv8xkRcT4ImGHy9vhceA5rvvcbvijfgA7fzHmn3w1d5QfCchsPyQJsKZcYI91z51
         NgcATBTM8W7+nimH/8RseuyYk0ZpA3qWqxsTXZCsg6lEukHUlzy8fKxZx21egGaPmfsk
         Yu4zISF6eAWQAPVNsdiakQtofyWyoa7a1Hvs4n1pBQ/TJA2zM7M2INg4Vgz0e0K492tZ
         k8gA==
X-Gm-Message-State: ACgBeo3LH7QIwXW3/eod/A2vegm3nVOIc1pUK6Af6Or2SXFQJYKLNYlY
        nN1f3qdFjeALn7vhdPwb+wxZ5KpCwIVSKHNL0gX9Ag==
X-Google-Smtp-Source: AA6agR4ntjaDOEyCR2SDMeJVOZxMHCydD8GIIAaP1VehTb6mhepvnStH8hXJl00Zruvm8pbCQA7Bu0zLne8+bUujE48=
X-Received: by 2002:a67:b009:0:b0:38a:e0f2:4108 with SMTP id
 z9-20020a67b009000000b0038ae0f24108mr8469258vse.9.1661209205446; Mon, 22 Aug
 2022 16:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220531223100.510392-1-surenb@google.com> <20220531223100.510392-2-surenb@google.com>
 <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
 <CAOUHufbysRjhX_AiFirjvWCR129t4_bELd1wFQG+fBsZpzhgYw@mail.gmail.com> <20220822154822.366a9e4527b748cf99d98637@linux-foundation.org>
In-Reply-To: <20220822154822.366a9e4527b748cf99d98637@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 22 Aug 2022 16:59:29 -0600
Message-ID: <CAOUHufa1zc3fMWsyyz1uB6_gsgVPk1Hw_T31WzWK58QVgsQSAQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com,
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

On Mon, Aug 22, 2022 at 4:48 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 22 Aug 2022 16:33:51 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > > --- a/mm/vmscan.c~mm-delete-unused-mmf_oom_victim-flag-fix
> > > +++ a/mm/vmscan.c
> > > @@ -3429,9 +3429,6 @@ static bool should_skip_mm(struct mm_str
> > >         if (size < MIN_LRU_BATCH)
> > >                 return true;
> > >
> > > -       if (mm_is_oom_victim(mm))
> > > -               return true;
> > > -
> > >         return !mmget_not_zero(mm);
> > >  }
> > >
> > > @@ -4127,9 +4124,6 @@ restart:
> > >
> > >                 walk_pmd_range(&val, addr, next, args);
> > >
> > > -               if (mm_is_oom_victim(args->mm))
> > > -                       return 1;
> > > -
> > >                 /* a racy check to curtail the waiting time */
> > >                 if (wq_has_sleeper(&walk->lruvec->mm_state.wait))
> > >                         return 1;
> > > _
> > >
> > > Please confirm?
> >
> > LGTM.  The deleted checks are not about correctness.
>
> OK, for now.
>
> > I've queued
> >
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3402,7 +3402,7 @@ static bool should_skip_mm(struct mm_struct *mm,
> > struct lru_gen_mm_walk *walk)
> >         if (size < MIN_LRU_BATCH)
> >                 return true;
> >
> > -       if (mm_is_oom_victim(mm))
> > +       if (test_bit(MMF_OOM_REAP_QUEUED, &mm->flags))
> >                 return true;
> >
> >         return !mmget_not_zero(mm);
> > @@ -4109,7 +4109,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned
> > long start, unsigned long end,
> >
> >                 walk_pmd_range(&val, addr, next, args);
> >
> > -               if (mm_is_oom_victim(args->mm))
> > +               if (test_bit(MMF_OOM_REAP_QUEUED, &args->mm->flags))
> >                         return 1;
> >
> >                 /* a racy check to curtail the waiting time */
>
> Oh.  Why?  What does this change do?

The MMF_OOM_REAP_QUEUED flag is similar to the deleted MMF_OOM_VICTIM
flag, but it's set at a later stage during an OOM kill.

When either is set, the OOM reaper is probably already freeing the
memory of this mm_struct, or at least it's going to. So there is no
need to dwell on it in the reclaim path, hence not about correctness.
