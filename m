Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166BD59CBB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiHVWs3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 18:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiHVWs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 18:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AF9DFE6;
        Mon, 22 Aug 2022 15:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C793961366;
        Mon, 22 Aug 2022 22:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F577C433C1;
        Mon, 22 Aug 2022 22:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661208504;
        bh=sOMr0Q0H2AG8pe61BiyqwV9Vfzg1HO+X+80PtuoQ1U4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jn+jIXL11peml5c/5m7jlSUZ/Nprd5dtsyObenqGyKRa1wB5SSgUh7saBlD6qhEZe
         9dJ14IaEgzUssPm8IZCRYaCjc1FsFDWBZwyNVH5MvGu79dGwsSc9QQF/kdJiMsNDtG
         1z9khI42mLkZ4hQjcdvU87pTUkDIxriT5nyO/uMY=
Date:   Mon, 22 Aug 2022 15:48:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
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
Subject: Re: [PATCH RESEND v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
Message-Id: <20220822154822.366a9e4527b748cf99d98637@linux-foundation.org>
In-Reply-To: <CAOUHufbysRjhX_AiFirjvWCR129t4_bELd1wFQG+fBsZpzhgYw@mail.gmail.com>
References: <20220531223100.510392-1-surenb@google.com>
        <20220531223100.510392-2-surenb@google.com>
        <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
        <CAOUHufbysRjhX_AiFirjvWCR129t4_bELd1wFQG+fBsZpzhgYw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 22 Aug 2022 16:33:51 -0600 Yu Zhao <yuzhao@google.com> wrote:

> > --- a/mm/vmscan.c~mm-delete-unused-mmf_oom_victim-flag-fix
> > +++ a/mm/vmscan.c
> > @@ -3429,9 +3429,6 @@ static bool should_skip_mm(struct mm_str
> >         if (size < MIN_LRU_BATCH)
> >                 return true;
> >
> > -       if (mm_is_oom_victim(mm))
> > -               return true;
> > -
> >         return !mmget_not_zero(mm);
> >  }
> >
> > @@ -4127,9 +4124,6 @@ restart:
> >
> >                 walk_pmd_range(&val, addr, next, args);
> >
> > -               if (mm_is_oom_victim(args->mm))
> > -                       return 1;
> > -
> >                 /* a racy check to curtail the waiting time */
> >                 if (wq_has_sleeper(&walk->lruvec->mm_state.wait))
> >                         return 1;
> > _
> >
> > Please confirm?
> 
> LGTM.  The deleted checks are not about correctness.

OK, for now.

> I've queued
> 
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3402,7 +3402,7 @@ static bool should_skip_mm(struct mm_struct *mm,
> struct lru_gen_mm_walk *walk)
>         if (size < MIN_LRU_BATCH)
>                 return true;
> 
> -       if (mm_is_oom_victim(mm))
> +       if (test_bit(MMF_OOM_REAP_QUEUED, &mm->flags))
>                 return true;
> 
>         return !mmget_not_zero(mm);
> @@ -4109,7 +4109,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned
> long start, unsigned long end,
> 
>                 walk_pmd_range(&val, addr, next, args);
> 
> -               if (mm_is_oom_victim(args->mm))
> +               if (test_bit(MMF_OOM_REAP_QUEUED, &args->mm->flags))
>                         return 1;
> 
>                 /* a racy check to curtail the waiting time */

Oh.  Why?  What does this change do?
