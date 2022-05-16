Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA18E52958F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 01:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244469AbiEPXv7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 19:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350258AbiEPXv5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 19:51:57 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B9D3EF3B
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 16:51:55 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v71so4687668ybi.4
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i606HfEWVO/qnL8GVN8QjqxjzHn2kHFuQ0+GTOY9ccY=;
        b=n+DIO+7/hs5dubTKEpbxjG3NWXawGNH+U5W3/PTMqu1oU0UFB9TtNUYil1wX+uO6yH
         naYC4DdWVKhp384hBvQJSkpBNrFmunkQbfljVYDe7NdgbOZXE6OdvV/9UV5HaVzr4U/G
         Ozw1o91PaZqKW+xWqVTDMRKC402IK5R8WjYODJ7cAJa65THZWGX8kut+xKsfzhfB37Et
         7PvY2KVP3rbyrRpbJEv6snQanikc9Bm68A2JmNYS5qml1jJcp+wyNolOD5mxUs087RFM
         w5OYrjpQs1PN36UXYIwvth6TRpSpIiHayEsbY2xabi0fhhvPRZoHX85Vb0McblFrLATl
         KMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i606HfEWVO/qnL8GVN8QjqxjzHn2kHFuQ0+GTOY9ccY=;
        b=bh1l5n7cczUDyhupoNRX8fm661q0L6BySTjXMAgR5kTxRW11ftWgLnwoiPfvFWCNDL
         OM2QMFRkni1TOjZ+7xfOJNusfzaxvjXPsXh300xFWnTjPr3TXJM/hXuf1c9s3dBIZJ8B
         2ggCNJ07d+vwvTiEKSS+gf+5IBtA5+aSkygUcy7XKFDCFcc8fKFsqSy18fqcYFSOnHsV
         c/TzNm/4D+1Vp1eSLq+J8rAavk25oN42u19SS4Bmf1rNGknjVVUAUBCRWR+NYwmTM8Ub
         2j2ob9qBAfzpObl9cqVBDUty7mjgv7qNsjmFBT5fI5nfTxVV78pTrkGLAm4jZPBR8gml
         rooQ==
X-Gm-Message-State: AOAM533QSt1uNfBEEOjsWzHmSNdiBgLti/qVV8rfQNzIKbsk1KMeC27L
        h4344yO+yM8NA9JpQfXS8uYonxl1GBgRcK2p5F9cIA==
X-Google-Smtp-Source: ABdhPJyTW5XuzXVi3sj4DqnD1ld6DZCkzmQw1+kKkUEO2Q4whnBJnGiGh0ctOzXzfOqXqHcJeD9HZd0WZDI5Y5IaHSQ=
X-Received: by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP id
 f9-20020a056902038900b0063331c1d0f7mr19940675ybs.543.1652745114021; Mon, 16
 May 2022 16:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220516075538.1276644-1-surenb@google.com> <78c3a163-551b-ef53-4018-7b6ba0640757@linuxfoundation.org>
 <CAJuCfpEW3kif-QAVdFKyZikVRT5QrLGwJ5pzua+yuVq=A=bv8w@mail.gmail.com> <7f0fd407-18f5-2718-40b5-b16804163197@linuxfoundation.org>
In-Reply-To: <7f0fd407-18f5-2718-40b5-b16804163197@linuxfoundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 16 May 2022 16:51:43 -0700
Message-ID: <CAJuCfpFn7aRoTJHmnR7oXuXY+LkhMF2R+W7h9pL_3hm9ynUJSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests: vm: add process_mrelease tests
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 16, 2022 at 4:28 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/16/22 2:47 PM, Suren Baghdasaryan wrote:
> > On Mon, May 16, 2022 at 1:29 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>
> >> On 5/16/22 1:55 AM, Suren Baghdasaryan wrote:
> >>> Introduce process_mrelease syscall sanity tests which include tests
> >>> which expect to fail:
> >>> - process_mrelease with invalid pidfd and flags inputs
> >>> - process_mrelease on a live process with no pending signals
> >>> and valid process_mrelease usage which is expected to succeed.
> >>> Because process_mrelease has to be used against a process with a pending
> >>> SIGKILL, it's possible that the process exits before process_mrelease
> >>> gets called. In such cases we retry the test with a victim that allocates
> >>> twice more memory up to 1GB. This would require the victim process to
> >>> spend more time during exit and process_mrelease has a better chance of
> >>> catching the process before it exits and succeeding.
> >>>
> >>> On success the test reports the amount of memory the child had to
> >>> allocate for reaping to succeed. Sample output:
> >>>       Success reaping a child with 1MB of memory allocations
> >>>
> >>> On failure the test reports the failure. Sample outputs:
> >>>       All process_mrelease attempts failed!
> >>>       process_mrelease: Invalid argument
> >>>
> >>
> >> Nit: Please format this better - include actual example output from the
> >> command and how to run the test examples.
> >
> > Hmm... Those are the actual outputs from the command and it does not
> > take any input arguments. Do you mean smth like this:
> >
> > $ mrelease_test
> > Success reaping a child with 1MB of memory allocations
> >
> > $ mrelease_test
> > All process_mrelease attempts failed!
> >
> > $ mrelease_test
> > process_mrelease: Invalid argument
> >
> > ?
>
> This looks good.
>
> >
> >>
> >>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >>> ---
> >>>    tools/testing/selftests/vm/.gitignore      |   1 +
> >>>    tools/testing/selftests/vm/Makefile        |   1 +
> >>>    tools/testing/selftests/vm/mrelease_test.c | 214 +++++++++++++++++++++
> >>>    tools/testing/selftests/vm/run_vmtests.sh  |  16 ++
> >>>    4 files changed, 232 insertions(+)
> >>>    create mode 100644 tools/testing/selftests/vm/mrelease_test.c
> >>>
>
> [snip]
>
> >>
> >> Okay these above 3 routines are called once. I am not seeing any point
> >> in making these separate routines. I made the same comment on v1.
> >
> > I must have misunderstood your previous comment. Will change.
> >
>
> Thank you.
>
> >>
>
> >>
> >> Now the above code can be a separate function which will make it readable.
> >
> > Ack.
> >
> >>
>
> >>> +
> >>
> >> Why do you need these ifdefs - syscall will return ENOSYS and you can
> >> key off that. Please take a look at other usages of syscall in the
> >> repo.
> >
> > The issue is that I need to provide the syscall number when calling
> > syscall() (in my case __NR_pidfd_open and __NR_process_mrelease) and
> > if that number is not defined in the userspace headers on a given
> > system then what should I pass instead?
> > When implementing this I followed the examples of
> > https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/vm/memfd_secret.c#L30
> > and https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/vm/userfaultfd.c#L65.
> > My original implementation was modeled after this approach:
> > https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/vm/mlock2.h#L15.
> > If none of these are correct, could you please point me to the example
> > you want me to follow?
> >
>
> kselftests include kernel headers. As long as these syscalls are
> defined in the kernel headers, the test will build.
>
> Looks it is defined in include/uapi/asm-generic/unistd.h
>
> You can assume it is defined and then if we find architectures that
> don't, you can follow what tools/testing/selftests/pidfd/pidfd.h
> does.
>
> This way the test can simply call syscall and handle ENOSYS.

Thanks for the guidance! I'll try that approach.
Suren.

>
> thanks,
> -- Shuah
>
>
>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
