Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BEB63B577
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 00:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiK1XDT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 18:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiK1XDS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 18:03:18 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F1A2BB0D
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 15:03:17 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id mn15so4632534qvb.13
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 15:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Robu8nmUKTiKQlMhDxt0GuMaQhgSeZWzrSFCOi0NpI=;
        b=HHflKt+THv9OY/GIgjE5v0xPgupcT0GXslgFF8T0VTrHj5z7mWEqIwyD2UFst52vGx
         EVm7/6mH/x5UpBPjFKEl30bYsfYtMvbabF32aQj0TJrkkPVk9QTO8qxy6MYLzC6Syhuz
         x35MnrmfKnhY0VeBJssE3Ngj43cChWTDcNtmDqwVy7rCe3EcPSBoGO+kR/yNRdcytpVU
         Xa3WCnbt3M3hZURo/dFzB7591imZIjSQYNIWPWbWl0pV0KLsibdlOs0Z1gsUYLkyA58S
         dKS+7is3dQpMY5smprFnLyWBsRBkxpOSfQhYyAWn3NcsuCL4j0E1hrSAFWX5oq1hcvsT
         hh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Robu8nmUKTiKQlMhDxt0GuMaQhgSeZWzrSFCOi0NpI=;
        b=lFlt1hMcILi4zKeoy0YDhu9ArBTJ2bLcPzltQfWXEmDd5fvLDXbA2LI6hRPEBEeXuW
         zrsfJGLJqKam6KZyRX9RD6WhxRSn7rfoU/sIIjpmz7xNxkEQkf5KQHusr1mn27oK7chk
         pFmiJyEuMstv6uAtDVNk3OKnpCMc40B+6bY0LAoQePpR4kZbmzgndcciRNT6wsy/zoq+
         GN+rgtSy+ssDNclB3GcJ/Rn26Z541JdX5uPLPqN65Fnk/1F68ztEDhASN3kV+deabtYq
         B5nZGPlOvKowJO1Cl3mPL1q8ZdlKfkJMvRVQzjQuOqFNKrJZFJGLd/EPqp8Boarl5iyu
         FYTg==
X-Gm-Message-State: ANoB5pm+PVviWlXmaUCUVVtiIsRxTWA0wR3o27VW/P+jTttDJxKzP1jL
        hoBQcbzlrv6vZBUdUydqGOZWg+nKBDzHKMC9ShvlMw==
X-Google-Smtp-Source: AA0mqf4OiAWyyIEEmsi5bKKFM6ACFPviKV2T7jtJwZhCHGqoALp8BMwVUSZhtu+66bveKV3VPHGv2+Mh/aOFMTjpVDk=
X-Received: by 2002:a0c:c3cc:0:b0:4c6:a05d:f67e with SMTP id
 p12-20020a0cc3cc000000b004c6a05df67emr32481992qvi.4.1669676596112; Mon, 28
 Nov 2022 15:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20221105025146.238209-1-horenchuang@bytedance.com>
 <CAADnVQK5t0YWGgdWmjiWX6vA0SjANrnf5x=yzu7PtDKpoK6cJQ@mail.gmail.com> <CAAYibXiHRg3C3tk=wbiHdaUgJD6AfJf7gX3w0gTJ2nsJ=DnY4g@mail.gmail.com>
In-Reply-To: <CAAYibXiHRg3C3tk=wbiHdaUgJD6AfJf7gX3w0gTJ2nsJ=DnY4g@mail.gmail.com>
From:   "Hao Xiang ." <hao.xiang@bytedance.com>
Date:   Mon, 28 Nov 2022 15:03:05 -0800
Message-ID: <CAAYibXgiCOOEY9NvLXbY4ve7pH8xWrZjnczrj6SHy3x_TtOU1g@mail.gmail.com>
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

Hi Alexei, we can use the existing switch bpf_stats_enabled around the
added overhead. The switch is turned off by default so I believe there
will be no extra overhead once we do that. Can you please have a
second thought on this?

On Mon, Nov 7, 2022 at 4:30 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
>
> Hi Alexei,
>
> We understand the concern on added performance overhead. We had some
> discussion about this while working on the patch and decided to give
> it a try (my bad).
>
> Adding some more context. We are leveraging the BPF_OBJ_GET_INFO_BY_FD
> syscall to trace CPU usage per prog and memory usage per map. We would
> like to use this patch to add an interface for map types to return its
> internal "count". For instance, we are thinking of having the below
> map types to report the "count" and those won't add overhead to the
> hot path.
> 1. ringbuf to return its "count" by calculating the distance between
> producer_pos and consumer_pos
> 2. queue and stack to return its "count" from the head's position
> 3. dev map hash to returns its "count" from items
>
> There are other map types, similar to the hashtab pre-allocation case,
> will introduce overhead in the hot path in order to count the stats. I
> think we can find alternative solutions for those (eg, iterate the map
> and count, count only if bpf_stats_enabled switch is on, etc). There
> are cases where this can't be done at the application level because
> applications don't see the internal stats in order to do the right
> counting.
>
> We can remove the counting for the pre-allocated case in this patch.
> Please let us know what you think.
>
> Thanks, Hao
>
> On Sat, Nov 5, 2022 at 9:20 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 4, 2022 at 7:52 PM Ho-Ren (Jack) Chuang
> > <horenchuang@bytedance.com> wrote:
> > >
> > > Hello everyone,
> > >
> > > We have prepared patches to address an issue from a previous discussion.
> > > The previous discussion email thread is here: https://lore.kernel.org/all/CAADnVQLBt0snxv4bKwg1WKQ9wDFbaDCtZ03v1-LjOTYtsKPckQ@mail.gmail.com/
> >
> > Rephrasing what was said earlier.
> > We're not keeping the count of elements in a preallocated hash map
> > and we are not going to add one.
> > The bpf prog needs to do the accounting on its own if it needs
> > this kind of statistics.
> > Keeping the count for non-prealloc is already significant performance
> > overhead. We don't trade performance for stats.
