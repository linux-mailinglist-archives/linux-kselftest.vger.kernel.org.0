Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B35A527C21
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 04:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiEPCqh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 May 2022 22:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239461AbiEPCqg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 May 2022 22:46:36 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6623B14029
        for <linux-kselftest@vger.kernel.org>; Sun, 15 May 2022 19:46:35 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id f16so757697ybk.2
        for <linux-kselftest@vger.kernel.org>; Sun, 15 May 2022 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qs6KzmNvqi948FGwp/fLhqN7zczHoIBbeoB+SvqJ72Y=;
        b=BCnP2xhE6Ob/d+gt4ZTBLwa0Dtcr/c2wsmjwxm8K77+x6RvJkK0jJAT/5eUnmAAQT/
         qJAd1Vy7qGoEizlwBmUqFDispatPNG9bMJqKp0AsYWSCLBiqJxA4jyuPz5z4IjxlMCCu
         DfLpoMaTJe+AwZvcPAMOEVO7r0++WXpzd9hDTQjdQ1BRVnFJsz+ZzJoTJrt4atjSn4Hc
         O6YOAj3+BfEstQEo3vF/2NcL6Vp+JA4gz0ih6VlvyZ2yK8p/jW+xxEsJlhkvQ25FORLt
         /nJhTCB5M80sZVl4y1VmSZIE+iM115E5AvyleTP0kkNsZhAy9jR/AUTnrCMdjvb25BDY
         fDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qs6KzmNvqi948FGwp/fLhqN7zczHoIBbeoB+SvqJ72Y=;
        b=Pa/MJiKm2KkBriGWmOW7vgjsHIf444kauhpnspGelKjAgKprwFEZt5HwtY7F5/pbjt
         W/cxpNjthChk9UVGM0Sz26ZDN+VH1dF0Q4jv+/9YlzZLNGMoZoTbARouhiWpIyj7+Pfa
         BoO+KXbkmig/uBBrbFd3QvRbMOuX9sS+xfHYVo+/qf4eG0yS765nc9MivhbZEku4e1xY
         M9JQGLtcMyYvklXF+RtzSdHVyRx22JURh51aFbwV6UO6jnqmhBvs7co2yxgiX8FoYlIn
         R0e09JABZFVLVuA2ZizFiCU4PDEymSMamNhc5VvRszvwPb8JykqophQE3YNKwAD6kQMj
         ovqA==
X-Gm-Message-State: AOAM5322VMNjw419ogRDCR17OsWEpUhdcPMjnQOV9AMsfFRPjZhooU0L
        YRiXr9XLktOFpQt+yLyZokOfkcLI2JJiSD3dzA60Zg==
X-Google-Smtp-Source: ABdhPJwb9h9mJYmHGsuwFhWI1uHb0LK9seKGiF0DwaqJTNtk5nU+naQY4h5vM98rjRAljFgSPt7qzYWx3iBQVaTT1Wg=
X-Received: by 2002:a5b:30d:0:b0:64b:4193:7911 with SMTP id
 j13-20020a5b030d000000b0064b41937911mr14912687ybp.509.1652669194393; Sun, 15
 May 2022 19:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220510030014.3842475-1-surenb@google.com> <20220510030014.3842475-3-surenb@google.com>
 <Ynpj3TsPcWVL7K7F@dhcp22.suse.cz>
In-Reply-To: <Ynpj3TsPcWVL7K7F@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 15 May 2022 19:46:23 -0700
Message-ID: <CAJuCfpGO0E82uY7vfhqeFNKeyxmrFa6PnbmwN6qgf68oAdzD_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: delete unused MMF_OOM_VICTIM flag
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

On Tue, May 10, 2022 at 6:08 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 09-05-22 20:00:14, Suren Baghdasaryan wrote:
> > With the last usage of MMF_OOM_VICTIM in exit_mmap gone, this flag is
> > now unused and can be removed.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> LGTM
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> One question below
> [...]
> > diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> > index 4d9e3a656875..746f6cb07a20 100644
> > --- a/include/linux/sched/coredump.h
> > +++ b/include/linux/sched/coredump.h
> > @@ -70,7 +70,6 @@ static inline int get_dumpable(struct mm_struct *mm)
> >  #define MMF_UNSTABLE         22      /* mm is unstable for copy_from_user */
> >  #define MMF_HUGE_ZERO_PAGE   23      /* mm has ever used the global huge zero page */
> >  #define MMF_DISABLE_THP              24      /* disable THP for all VMAs */
> > -#define MMF_OOM_VICTIM               25      /* mm is the oom victim */
> >  #define MMF_OOM_REAP_QUEUED  26      /* mm was queued for oom_reaper */
> >  #define MMF_MULTIPROCESS     27      /* mm is shared between processes */
>
> Have you consider renumbering the follow up flags so that we do not have
> holes in there. Nothing really important but it can confuse somebody in
> the future.

Missed this note until now. I will renumber the constants to avoid confusion.
Thanks,
Suren.

>
> --
> Michal Hocko
> SUSE Labs
