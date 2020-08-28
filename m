Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240B3255367
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Aug 2020 05:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgH1Dmt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Aug 2020 23:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgH1Dms (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Aug 2020 23:42:48 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5185C06121B
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Aug 2020 20:42:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l2so10501496eji.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Aug 2020 20:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wl7POtGUJpujC577nqFjmTBAOmvQ4nTIGwkF53IPEDs=;
        b=tq0zGDR93T6ES5KjCAtJcuuPzPguZpOtkbOunk4JUInNQbuoAVAJvp++D4hQ1yRLG9
         oVPESLvDSvN/SxHxeQBn/z/jPgT6PJD8LEEIA9IyLij9gJ1K6+1fPJHnJ0EoDT8b3Ey3
         WdmEq+7HQmSJcbiUqvgLSodFl+JDqVoT85Ibx6I87W+TjP1QncW/tz9j4q/JVPBsZaj1
         gONchDfblDPomG0BR+ZL49xl0Fu5y2j9uQAVCn2UYlnN2/qTkbxSswMf4Mi3d370TMHJ
         WHUTT1bZSwkkCnhEOOAFbmilHPa4mwjSE7kHdORspUTiVg9cDmo+mshEIyS/3rtOo+yV
         f8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wl7POtGUJpujC577nqFjmTBAOmvQ4nTIGwkF53IPEDs=;
        b=oYuJ/UpoZZX/qrUpQJkLvs4fr6K4Z3MAfUiFs2Ed66Yadm7kOZ13qC6H4sHbHh92ZP
         3d5qipHZFXoQiOAFrBdDfKm/VR27xoMit2Qz28lxPmz6u6S70OH/ABtaZfE5UXy7c0t2
         Fo7rRcPr7QgbdZVemkFU7h6uYwdiMxeMIKf9y2fPP6H5p8QqccSThCye66FlfWXWtkL2
         6exQo+KFUVAe8QUTwvAXNKYMDGYO6qIzWJct1ocAWE86UmjICbsr7opdAtSRIeSOJba3
         Q0sJekNzRqopQoCN9q1OmehfIqhW9O9i4sLHabRSg2lK1Cw/QzUar2ftVM2zBs1MQ9/7
         ROBQ==
X-Gm-Message-State: AOAM531RllrgPQGdQ95qHOUSh3IuNdTwFs0m4gIUcZdR5yrwmN6bTq0F
        vf1MZ3md/OT40GwmGdr+/YWU6EOn2HOM0dkDwrP4nA==
X-Google-Smtp-Source: ABdhPJwk4MdYud22SSD4VMNkQ45Fwn96im/vGznNyYRJQx0E7CnsPzI55RD6/Xhy7xw6X35XN4XD+TwVA146l+SuseE=
X-Received: by 2002:a17:906:6406:: with SMTP id d6mr23310789ejm.30.1598586165507;
 Thu, 27 Aug 2020 20:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200819224030.1615203-1-haoluo@google.com> <20200819224030.1615203-9-haoluo@google.com>
 <CAEf4BzYC0JRQusCxTrmraYQC7SZdkVjdy8DMUNECKwCbXP9-dw@mail.gmail.com>
In-Reply-To: <CAEf4BzYC0JRQusCxTrmraYQC7SZdkVjdy8DMUNECKwCbXP9-dw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 27 Aug 2020 20:42:34 -0700
Message-ID: <CA+khW7jYWNT5aVe5vCinw5qwKKoB0w386qz2g+0ndv1LeeoGGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 8/8] bpf/selftests: Test for bpf_per_cpu_ptr()
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

Thanks for taking a look!

On Fri, Aug 21, 2020 at 8:30 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 19, 2020 at 3:42 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Test bpf_per_cpu_ptr(). Test two paths in the kernel. If the base
> > pointer points to a struct, the returned reg is of type PTR_TO_BTF_ID.
> > Direct pointer dereference can be applied on the returned variable.
> > If the base pointer isn't a struct, the returned reg is of type
> > PTR_TO_MEM, which also supports direct pointer dereference.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
>
[...]
> >
> >  __u64 out__runqueues = -1;
> >  __u64 out__bpf_prog_active = -1;
> > +__u32 out__rq_cpu = -1;
> > +unsigned long out__process_counts = -1;
>
> try to not use long for variables, it is 32-bit integer in user-space
> but always 64-bit in BPF. This causes problems when using skeleton on
> 32-bit architecture.
>

Ack. I will use another variable of type 'int' instead.

> >
> > -extern const struct rq runqueues __ksym; /* struct type global var. */
> > +extern const struct rq runqueues __ksym; /* struct type percpu var. */
> >  extern const int bpf_prog_active __ksym; /* int type global var. */
> > +extern const unsigned long process_counts __ksym; /* int type percpu var. */
> >
> >  SEC("raw_tp/sys_enter")
> >  int handler(const void *ctx)
> >  {
> > +       struct rq *rq;
> > +       unsigned long *count;
> > +
> >         out__runqueues = (__u64)&runqueues;
> >         out__bpf_prog_active = (__u64)&bpf_prog_active;
> >
> > +       rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, 1);
> > +       if (rq)
> > +               out__rq_cpu = rq->cpu;
>
> this is awesome!
>
> Are there any per-cpu variables that are arrays? Would be nice to test
> those too.
>
>

There are currently per-cpu arrays, but not common. There is a
'pmc_prev_left' in arch/x86, I can add that in this test.

[...]
