Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981DA528FB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 22:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiEPUIP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 16:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350932AbiEPUBr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 16:01:47 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855284B84E
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 12:56:07 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ff1ed64f82so14630517b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfdUgGfNk3YhrYyq3M5XkqZYdXGFDT0Zb8uEoLzPkM8=;
        b=IbUzpIJLiMA1ViYgX8Jh1WuzPhrzWpCO0cyMdjY1sJ+mXkV4jPmeKJBw5W5eO9KKBS
         uRl4UlkDdCc3g1sS5dZD019n8RtHIIk3qECd6qb/4ikg+MRFGGaFelI2t/rn3ZK3B+hI
         oaKFOJyjKr01aMhzFnjTvwhcJElVTtVAlh3dIHkrrvGKeTmsPoNZuTqwKG4iYiDPjH6i
         Pl6rxNfX0HBPcTlV2W5b6L9c+ihTzdpnxl7Uonsd19/fw1RBnwoXAyi4YX15wx2g+i96
         6zkBCbMveUQud112L+2LH2jdgG9zouwGPHMibw7+vaCxAz5UJZkb0+1fayoiEaeo/nnI
         +iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfdUgGfNk3YhrYyq3M5XkqZYdXGFDT0Zb8uEoLzPkM8=;
        b=d9GLrj3906hbzimywqNWfzHPjcl2/0QT0OjWJK3l7nqmj7kkJMSvAQ3lQOv4AEhfZM
         EoYAbB9SqBSsph6c3u56FARRWgQrt1v9QCZ9qepb06clgk+z0h3j7V8EZH/G/XZquggR
         1tNU1Hw8OB19wTRI2b2XdKM+ffRkCtpQ91pETz9ZvW/n8FDHfmpiTqt28o3kygWEQ861
         nCZA49UvyVnx8tZmaCNeCrAV8s/0MDdrSr7JJypSWIDWzzEVQQgyoBVvk4zDbkID2ZH6
         yK7RJXuxEPWtqUFV8b1ngl3V72b6zQ2i4GnS86lgiWTImIoGduvVaLYotSIiV39xDUOh
         TXcg==
X-Gm-Message-State: AOAM530JQ5CFAiKMXW3pbuf/U32QEJNkgtc0ys+iSNMRa4g2KXu2LC/u
        /KHvocUGFKeeOee4ueq5XzK8Enj/VCwDD/ioccF1gA==
X-Google-Smtp-Source: ABdhPJw3x6WiZ42hrjmcTLP0iMMy3DDxNMyaCjoU1W4evQaWFgcPdb6I1JcYc/LIUoqSxPyOjGqbk6G6OjkRzdfSZ28=
X-Received: by 2002:a0d:d4d0:0:b0:2fe:b86b:472d with SMTP id
 w199-20020a0dd4d0000000b002feb86b472dmr19354893ywd.469.1652730966045; Mon, 16
 May 2022 12:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220516075538.1276644-1-surenb@google.com> <20220516125010.53ab9a27733f361e5965ed7f@linux-foundation.org>
In-Reply-To: <20220516125010.53ab9a27733f361e5965ed7f@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 16 May 2022 12:55:55 -0700
Message-ID: <CAJuCfpE8p6KVqMorFKYmH7+sd+YBt37J2A10_K=CfG73KJUw_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests: vm: add process_mrelease tests
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

On Mon, May 16, 2022 at 12:50 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 16 May 2022 00:55:38 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > Introduce process_mrelease syscall sanity tests which include tests
> > which expect to fail:
> > - process_mrelease with invalid pidfd and flags inputs
> > - process_mrelease on a live process with no pending signals
> > and valid process_mrelease usage which is expected to succeed.
> > Because process_mrelease has to be used against a process with a pending
> > SIGKILL, it's possible that the process exits before process_mrelease
> > gets called. In such cases we retry the test with a victim that allocates
> > twice more memory up to 1GB. This would require the victim process to
> > spend more time during exit and process_mrelease has a better chance of
> > catching the process before it exits and succeeding.
> >
> > On success the test reports the amount of memory the child had to
> > allocate for reaping to succeed. Sample output:
> >     Success reaping a child with 1MB of memory allocations
> >
> > On failure the test reports the failure. Sample outputs:
> >     All process_mrelease attempts failed!
> >     process_mrelease: Invalid argument
> >
> > ...
> >
> > --- a/tools/testing/selftests/vm/run_vmtests.sh
> > +++ b/tools/testing/selftests/vm/run_vmtests.sh
> > @@ -287,6 +287,22 @@ else
> >       echo "[PASS]"
> >  fi
> >
> > +echo "---------------------"
> > +echo "running mrelease_test"
> > +echo "---------------------"
> > +./mrelease_test
> > +ret_val=$?
> > +
> > +if [ $ret_val -eq 0 ]; then
> > +     echo "[PASS]"
> > +elif [ $ret_val -eq $ksft_skip ]; then
> > +      echo "[SKIP]"
> > +      exitcode=$ksft_skip
> > +else
> > +     echo "[FAIL]"
> > +     exitcode=1
> > +fi
> > +
> >  echo "-------------------"
> >  echo "running mremap_test"
> >  echo "-------------------"
>
> Can you please redo this against
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm branch mm-stable
> or mm-unstable.  Or against linux-next?
>
> This script now has a helper function run_test which I think can be
> used here.

Ah, thanks for the note! I'll give it a couple days for more reviews
and the will post it over mmotm.
