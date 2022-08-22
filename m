Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5162A59CB84
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 00:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiHVWee (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 18:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbiHVWea (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 18:34:30 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE41422CB
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 15:34:28 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id l26so4939477uai.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iZ4aTKxmgzYAEVUnlcLNmF4cSAWmUwWq1yIkniS2lL0=;
        b=rtT+NsCSQka7KbyH7rAcBe92sgRFz606wyn75s7/lsMN+Hcw+JArgHz5ZqoCcW/8Rk
         zPa0OaypuRKQbIm/dttjw3wlbfBYGB+VeWZOeQ4Y8cdFOeaWpYEQW0ZaJ6pzZGsPoxmY
         //aByMBzPgAyM+2jHfOzM5sOLr8PTlp0IW4hx0M8wddu573kFri7H3v8UKlXpIcXDO8a
         r/NIQDmwPwK40IKxM99L1c733FRFNIpV0Euik7VpUNq3WGBJYcjY3DoKzCphZPkk268+
         V7NaIVePZZK7OlMf1Stu0q0plaMhsb/2GMXh7/SSWgFERJJ6Uy2MVrl5WHmGm/rfC9+I
         LWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iZ4aTKxmgzYAEVUnlcLNmF4cSAWmUwWq1yIkniS2lL0=;
        b=XOBU3alcD/Oc3SVlMiD3XFnicCDsR8aKo7g5Fzf4Uli5r1IDYpG+6E5ueLosHCs6sU
         +Q9POrXhtlNOjnlsBuTa0UPfpMTvpVkYhN1gUffr/AAvFz5vKOCbqOwh5cIkvgW7DWaP
         CfSltG451PF4oUl/oWh8+IvKyo2BM1bRmNn5YFG2hJqWF/GtPggx5WSkBEBsQBGh/w/K
         +QAK5KLWTuZDvII8EZTEsUTwGU/7r+JahtXNTgp273rYdPYW9EkwJV3u77sSDwI3gXdo
         vujCjIs6m0eMNA7zvPlk+QOX6q7BDfCFWojqfO9wtnF5eFy2IQ5uZj4Yrm7qtic57DDe
         hgPA==
X-Gm-Message-State: ACgBeo1lRbXHLlKHSY+Zzktu1J2Iz7t9jZ8mNeRwZWRQGQGW0J4sST+p
        SVadOpivv3jSFHzhQUmsdTZQlfhKT+YAv6Cvtc0zHw==
X-Google-Smtp-Source: AA6agR7IQdMHvp5x/ilzybc9F3dX6tIA926NxCQb6p6jY5QhGizH1xIddOda33LFsoE769hy9fge67U5zAGfEu8ZFEA=
X-Received: by 2002:ab0:5ac1:0:b0:39f:1ea5:250e with SMTP id
 x1-20020ab05ac1000000b0039f1ea5250emr199069uae.70.1661207667742; Mon, 22 Aug
 2022 15:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220531223100.510392-1-surenb@google.com> <20220531223100.510392-2-surenb@google.com>
 <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
In-Reply-To: <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 22 Aug 2022 16:33:51 -0600
Message-ID: <CAOUHufbysRjhX_AiFirjvWCR129t4_bELd1wFQG+fBsZpzhgYw@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 22, 2022 at 4:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 31 May 2022 15:31:00 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > With the last usage of MMF_OOM_VICTIM in exit_mmap gone, this flag is
> > now unused and can be removed.
> >
> > ...
> >
> > --- a/include/linux/oom.h
> > +++ b/include/linux/oom.h
> > @@ -77,15 +77,6 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
> >       return tsk->signal->oom_mm;
> >  }
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
>
> The patch "mm: multi-gen LRU: support page table walks" from the MGLRU
> series
> (https://lkml.kernel.org/r/20220815071332.627393-9-yuzhao@google.com)
> adds two calls to mm_is_oom_victim(), so my build broke.
>
> I assume the fix is simply
>
> --- a/mm/vmscan.c~mm-delete-unused-mmf_oom_victim-flag-fix
> +++ a/mm/vmscan.c
> @@ -3429,9 +3429,6 @@ static bool should_skip_mm(struct mm_str
>         if (size < MIN_LRU_BATCH)
>                 return true;
>
> -       if (mm_is_oom_victim(mm))
> -               return true;
> -
>         return !mmget_not_zero(mm);
>  }
>
> @@ -4127,9 +4124,6 @@ restart:
>
>                 walk_pmd_range(&val, addr, next, args);
>
> -               if (mm_is_oom_victim(args->mm))
> -                       return 1;
> -
>                 /* a racy check to curtail the waiting time */
>                 if (wq_has_sleeper(&walk->lruvec->mm_state.wait))
>                         return 1;
> _
>
> Please confirm?

LGTM.  The deleted checks are not about correctness.

I've queued

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3402,7 +3402,7 @@ static bool should_skip_mm(struct mm_struct *mm,
struct lru_gen_mm_walk *walk)
        if (size < MIN_LRU_BATCH)
                return true;

-       if (mm_is_oom_victim(mm))
+       if (test_bit(MMF_OOM_REAP_QUEUED, &mm->flags))
                return true;

        return !mmget_not_zero(mm);
@@ -4109,7 +4109,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned
long start, unsigned long end,

                walk_pmd_range(&val, addr, next, args);

-               if (mm_is_oom_victim(args->mm))
+               if (test_bit(MMF_OOM_REAP_QUEUED, &args->mm->flags))
                        return 1;

                /* a racy check to curtail the waiting time */
