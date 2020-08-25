Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA62250E0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Aug 2020 03:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgHYBDs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Aug 2020 21:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgHYBDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Aug 2020 21:03:45 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE9EC061795
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Aug 2020 18:03:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i26so9743337edv.4
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Aug 2020 18:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ve340FBnE1IFfQ0W0GtQ2RPw5r9LpjCO3O73FDEbehQ=;
        b=ZVSlGEmPWwd7gWYd9D33C6IPSJ1bADML54SZ4oGBBcAx6QjuZc609Nwwiyv0dfvLr4
         lztF+M4JcAQla0H8qITYK1KIRboJkvaxb9dXaxTkUUnNreZ7TMkfUZyVgaE3S8WpkL7M
         mRJLCoPwWEOR/gzP5qb1coo8WhvBr757QM7ooR7S18gzTPIBIrT/MT85oMsBfxxJc34m
         E9L1V3KV+kLCDVQhFIrYxQ63YR7UfG80Wpk9QlKaVAw9p+e/vU5lKDwfXnMXshgSGE3x
         BJhrFFjAH0vQUs27NFMoeBGqBDXQUtNM36h9WVoayiHLuTBbn90pE9zsSRpl453witZq
         qF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ve340FBnE1IFfQ0W0GtQ2RPw5r9LpjCO3O73FDEbehQ=;
        b=l20Ms/ztUf1E5b4/oAk38nMkg0/b7Hv4vIVyVsy1wYqkq+O8+aysbzH/xq8cjrfICX
         JkomnPHA6jQMWRVCTAGN/i8Jx3nTV6eRltgxUguQg0/Q9uXyFMjQ/o5O4MERrVSsfwxP
         FH8okRuu5tzKXrEOumUoj6tY3DqQIcUeb0REIBJBPCCdrD7fGQztKv9Xe+HBBnnFE7p7
         2vjqXgXvgOSD/4yodrE8mJRFaCD4/UlenuZwxZnnfi5pMOdnbp1Gbm4pAXuQHCmsrXnE
         p3Hrn7q1MQeNOtwGRPHrL0B/eXD3SaY1WT9xRxtTsme9q+cafEOdyaBDNYH0pgyoSKXm
         uuhg==
X-Gm-Message-State: AOAM531JTchhyM58EamKAz5P564SVXNXcCxTt8x8a7qdbmvoTiNjXprK
        8lCBDi+82uzIW98Z6Tkn99/60rWkJQiPScM/nR6Djg==
X-Google-Smtp-Source: ABdhPJzo/IRL6/MLWaK55PlZr8vGi6D4/kvR6VzUg92D3PIT1yMsWDjDHTyBPY2K4zxTwvCl6CflSF1/6FmThoSF/5M=
X-Received: by 2002:aa7:d912:: with SMTP id a18mr96788edr.18.1598317422894;
 Mon, 24 Aug 2020 18:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200819224030.1615203-1-haoluo@google.com> <20200819224030.1615203-7-haoluo@google.com>
 <CAEf4BzZY2LyJvF9HCdAzHM7WG26GO0qqX=Wc6EiXArks=kmazA@mail.gmail.com>
 <CAEf4BzZ+uqE73tM6W1vXyc-hu6fB8B9ZNniq-XHYhFDjhHg9gA@mail.gmail.com>
 <CA+khW7jQmdw-TZMnST_rBcQWmxZ_eVw4ja+nsrqCM9HSkeWaXQ@mail.gmail.com> <CAEf4BzZwtpvBSE=00XyHGr2p2OD6X_rwnntwvSZBjGvZUEZKCA@mail.gmail.com>
In-Reply-To: <CAEf4BzZwtpvBSE=00XyHGr2p2OD6X_rwnntwvSZBjGvZUEZKCA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 24 Aug 2020 18:03:31 -0700
Message-ID: <CA+khW7gR=oCPvs07=XwsBPV2NiY4ne2d6mX9L_dj6fYy5grsyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] bpf: Introduce bpf_per_cpu_ptr()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 22, 2020 at 12:55 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Aug 22, 2020 at 12:49 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Fri, Aug 21, 2020 at 8:31 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Aug 21, 2020 at 8:26 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Aug 19, 2020 at 3:42 PM Hao Luo <haoluo@google.com> wrote:
> > > > >
> > > > > Add bpf_per_cpu_ptr() to help bpf programs access percpu vars.
> > > > > bpf_per_cpu_ptr() has the same semantic as per_cpu_ptr() in the kernel
> > > > > except that it may return NULL. This happens when the cpu parameter is
> > > > > out of range. So the caller must check the returned value.
> > > > >
> > > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > > ---
> > > >
> > > > The logic looks correct, few naming nits, but otherwise:
> > > >
> > > > Acked-by: Andrii Nakryiko <andriin@fb.com>
> > > >
> > > > >  include/linux/bpf.h      |  3 ++
> > > > >  include/linux/btf.h      | 11 +++++++
> > > > >  include/uapi/linux/bpf.h | 14 +++++++++
> > > > >  kernel/bpf/btf.c         | 10 -------
> > > > >  kernel/bpf/verifier.c    | 64 ++++++++++++++++++++++++++++++++++++++--
> > > > >  kernel/trace/bpf_trace.c | 18 +++++++++++
> > > > >  6 files changed, 107 insertions(+), 13 deletions(-)
> > [...]
> > >
> > > btw, having bpf_this_cpu_ptr(const void *ptr) seems worthwhile as well, WDYT?
> > >
> >
> > It's probably not a good idea, IMHO. How does it interact with
> > preemption? Should we treat it as __this_cpu_ptr()? If so, I feel it's
> > easy to be misused, if the bpf program is called in a preemptible
> > context.
> >
> > Btw, is bpf programs always called with preemption disabled? How about
> > interrupts? I haven't thought about these questions before but I think
> > they matter as we start to have more ways for bpf programs to interact
> > with the kernel.
>
> non-sleepable BPF is always disabling CPU migration, so there is no
> problem with this_cpu_ptr. For sleepable not sure, but we can disable
> this helper for sleepable BPF programs, if that's a problem.
>

Sounds good. I see there is bpf_get_smp_processor_id() and we are
already doing this. I can add this_cpu_ptr() in v2.

Hao
