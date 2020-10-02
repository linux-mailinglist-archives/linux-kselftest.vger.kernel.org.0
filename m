Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E2D281E65
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Oct 2020 00:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgJBWeh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 18:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJBWeh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 18:34:37 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB44C0613E2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 15:34:37 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k14so3347091edo.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rW2kdxzCx6rjV7FoduPhfty2PLyTqlk9TMNTcfuuQ4s=;
        b=oDxYvdrHfD4v9ujnECNuHvHJ1GRmkF3o3KW2+Mhbbnt4zybaHYRx5wo0yyo303FNaY
         Cwms3vNtMxZXOG0paxnu6r5zGHw+Shsc46byqffrxdqlO2VFmGkmedFTp2xfn8hj3le4
         UrNgdM7Dls2e1nCM15NdO0HirP0ma1LcIOBOX1j5wVfNZHws+AZE9nEh2MV1Q+xMRTam
         8sOGalsE+HG4O5aDGbJrOXyadFj+hSiVMKDrYpbK4E9Ex9EQ+QlcZRz3JGX9KS2hAoUK
         DF78z1AF9Vy9zz+HibgOwouYKW/gXGUw3pLyn0JqiF9gMf9wD9hLJhtxnGynWCvb0c2K
         1P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rW2kdxzCx6rjV7FoduPhfty2PLyTqlk9TMNTcfuuQ4s=;
        b=qKJpWxVxJ6+nP4c6Fa5wRxzumMmi9rPi1BjAQfBoRbiKfGFZMTAtP1a6LPaw0y/9Vl
         gbHSdyicMTY1uml5Vi3hHTTFT2T4f5rmrJrUHp+oN8n/FDVkOIqQAyCytAhSW8CoSqTE
         SkCKNwtdNF6wtvyHySDLJe9wV9BvzQCdDdKDt6TC0tRackK3SNUrG+Swhjmb9vjv64jC
         5cMFa2dPx60OUl7NuoexPbBI2Ueiy5IXwvAGnfGwa4g37mW0Ibk8XgGMF58k+jey8Qps
         Ed8eQe+PmPAXA0Ho9EbGD/DU/HBwyRj0CQNUenlsmmUPPgiaVnXgNfl+jZI/w65fXRkA
         PUhg==
X-Gm-Message-State: AOAM530YNcq8Fb4HeSkx82J8f/WGNXby4OeSwzmCuHKVlyhFaY9kdsau
        J53eHdf63lGGJMJ1jNt51Xua0+nejCLWJSl+Ab4zpw==
X-Google-Smtp-Source: ABdhPJx8XkTqJ9V+QW/OqaO3mO5TrIJsCnxykvwM3e8lwJHjET40/paN7xvIUn13PC/thAmwsxdPIQoqDUPyPIqmURc=
X-Received: by 2002:a05:6402:1642:: with SMTP id s2mr4993261edx.295.1601678075536;
 Fri, 02 Oct 2020 15:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200929235049.2533242-1-haoluo@google.com> <CAADnVQK8XbzDs9hWLYEqkJj+g=1HJ7nrar+0STY5CY8t5nrC=A@mail.gmail.com>
 <CA+khW7i4wpvOsJTH4AePVsm4cAOnFoxEwEqv27tEzJrwOWFqxw@mail.gmail.com> <CAADnVQ+UdKjHWWojmUx5K+RjUZ=DCe6LAHwhBicv-1KkuJnPVg@mail.gmail.com>
In-Reply-To: <CAADnVQ+UdKjHWWojmUx5K+RjUZ=DCe6LAHwhBicv-1KkuJnPVg@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 2 Oct 2020 15:34:24 -0700
Message-ID: <CA+khW7jxBNewhD9KH0KUDAvjasUHkVxPjw-xypvpNd8VZYKCNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/6] bpf: BTF support for ksyms
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks, Alexei and Andrii and other reviewers for the comments. It's a
pleasure to work with you and contribute to bpf.

Hao

On Fri, Oct 2, 2020 at 3:16 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 29, 2020 at 11:48 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Ah, this is the bug in pahole described in
> > https://lkml.org/lkml/2020/8/20/1862. I proposed a fix [1] but it
> > hasn't reached pahole's master branch. Let me ask Arnaldo to see if he
> > is OK merging it.
> >
> > [1] https://www.spinics.net/lists/dwarves/msg00451.html
> >
> > On Tue, Sep 29, 2020 at 9:36 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 4:50 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > v3 -> v4:
> > > >  - Rebasing
> > > >  - Cast bpf_[per|this]_cpu_ptr's parameter to void __percpu * before
> > > >    passing into per_cpu_ptr.
>
> I've rebased it myself and applied. Thanks Hao.
