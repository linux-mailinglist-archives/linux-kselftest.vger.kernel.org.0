Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89546204AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiKHAaW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiKHAaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:30:21 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C151D668
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 16:30:19 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z6so7910540qtv.5
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Nov 2022 16:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NF/Xjl4bGX60sTFdSkyJB0iuEuG5H4mSvhGQEhyFFsE=;
        b=optWeMbKrLwYAP5/SViogLQxgNk3k+gmgqGwknY4DN9tkcLWh/wvnIQA+FvQ1HWubL
         ZUGbEfIdlQ6roFAuBmalgMPoCEwLMx34IM7LoPms25sDGh628s9gpq5i9RLxDfaixGTU
         HwZs2Y2ovr7Mf+NT6Zg9yF8PNLTUueIQPRqwEUgvtZBAJ8GSjpel3OIpP/3ZGSV4+dZJ
         STzKJL5Ltpd393Ba/7QUFPAHknZdU5y9VPwMUpD+4ho6bTlyRs0E7jhXJ8UIr4UWK/1o
         4obrgLwAFMea8d1x0oAIP/x9Ht9EJN3vCkqLweHFlubiHgVaa0+b0O5cOd3vawaAJbGc
         wYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NF/Xjl4bGX60sTFdSkyJB0iuEuG5H4mSvhGQEhyFFsE=;
        b=6TBhrs9jG+8uZvzuSu1G2fIpC9+GhvhHNZsAD/hPtmX+FAqPgGQ2+//0rX6hOxB/FQ
         VxhyXqMks/s+ZPWvjpSXyY4jRkKlJJL77Bre3n61IiWGroTeNd8nXzEGBljeMTRv4E9R
         h3xSqUdiCtmWwFow7cZlKrTtZa5U6v4G6OqtrLYvbyurf5LyGYOUjd1aNxZUJSnEeDV3
         Aap8PkPj1d/9VW4NXgHDjezd0Kz13v24BHfuWAuMiGKMNWJhGaBPmangAGZLjZZdSaEF
         xJb1Z+k7/HiN/OSmEUELEJzdxKr0XMmhBhWUw6/GYHJoAzsG0vjBo7FhExBEFPV44lLn
         xSnA==
X-Gm-Message-State: ACrzQf2K8jrL2OEzhr84j1oAQivzB5wet4JEFUIY32xSD6vGnSNjVBFd
        sPsy8Er7xE5iEjHqC6Q7YSWhXGQ4AzPR00MG2rrUfQ==
X-Google-Smtp-Source: AMsMyM538Rf/rIwE958s8XEtxsLIOx6qcDRgjIB13zeIqU/f+VnJBFogAjCSAOLfk1E604oXa+bK0vYgoMmVMC45ISI=
X-Received: by 2002:a05:622a:a05:b0:3a5:2c5f:9a66 with SMTP id
 bv5-20020a05622a0a0500b003a52c5f9a66mr32343641qtb.508.1667867418139; Mon, 07
 Nov 2022 16:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20221105025146.238209-1-horenchuang@bytedance.com> <CAADnVQK5t0YWGgdWmjiWX6vA0SjANrnf5x=yzu7PtDKpoK6cJQ@mail.gmail.com>
In-Reply-To: <CAADnVQK5t0YWGgdWmjiWX6vA0SjANrnf5x=yzu7PtDKpoK6cJQ@mail.gmail.com>
From:   "Hao Xiang ." <hao.xiang@bytedance.com>
Date:   Mon, 7 Nov 2022 16:30:08 -0800
Message-ID: <CAAYibXiHRg3C3tk=wbiHdaUgJD6AfJf7gX3w0gTJ2nsJ=DnY4g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v1 0/4] Add BPF htab map's used
 size for monitoring
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Xiaoning Ding <xiaoning.ding@bytedance.com>,
        bpf <bpf@vger.kernel.org>, Ho-Ren Chuang <horenc@vt.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Alexei,

We understand the concern on added performance overhead. We had some
discussion about this while working on the patch and decided to give
it a try (my bad).

Adding some more context. We are leveraging the BPF_OBJ_GET_INFO_BY_FD
syscall to trace CPU usage per prog and memory usage per map. We would
like to use this patch to add an interface for map types to return its
internal "count". For instance, we are thinking of having the below
map types to report the "count" and those won't add overhead to the
hot path.
1. ringbuf to return its "count" by calculating the distance between
producer_pos and consumer_pos
2. queue and stack to return its "count" from the head's position
3. dev map hash to returns its "count" from items

There are other map types, similar to the hashtab pre-allocation case,
will introduce overhead in the hot path in order to count the stats. I
think we can find alternative solutions for those (eg, iterate the map
and count, count only if bpf_stats_enabled switch is on, etc). There
are cases where this can't be done at the application level because
applications don't see the internal stats in order to do the right
counting.

We can remove the counting for the pre-allocated case in this patch.
Please let us know what you think.

Thanks, Hao

On Sat, Nov 5, 2022 at 9:20 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 4, 2022 at 7:52 PM Ho-Ren (Jack) Chuang
> <horenchuang@bytedance.com> wrote:
> >
> > Hello everyone,
> >
> > We have prepared patches to address an issue from a previous discussion.
> > The previous discussion email thread is here: https://lore.kernel.org/all/CAADnVQLBt0snxv4bKwg1WKQ9wDFbaDCtZ03v1-LjOTYtsKPckQ@mail.gmail.com/
>
> Rephrasing what was said earlier.
> We're not keeping the count of elements in a preallocated hash map
> and we are not going to add one.
> The bpf prog needs to do the accounting on its own if it needs
> this kind of statistics.
> Keeping the count for non-prealloc is already significant performance
> overhead. We don't trade performance for stats.
