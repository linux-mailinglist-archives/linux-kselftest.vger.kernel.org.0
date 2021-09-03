Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D2E4003AF
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Sep 2021 18:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbhICQwl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Sep 2021 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhICQwk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Sep 2021 12:52:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6760C061575;
        Fri,  3 Sep 2021 09:51:40 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id c206so11155373ybb.12;
        Fri, 03 Sep 2021 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idwDNbH9Wo5Pci3iRQ8ors3jpFQBSSL6bTxgZX7Cc/8=;
        b=DKE9nLlWSUOxRlyu+tVrpndtb8H9vBjqtSM/j++9gc3jidyTis6Kdb/3AMX2R3fypJ
         OC5IBwWIsY62dmtGvHvQlCqieLDPFqVfR41QMC+riJULOJO3BMP//M7x+u3nergv4lAZ
         0Z5wx3oq4BTyxapS+zKzpA7rlEu6KOZwEelyvqo73Hntb31nalLqoQ3hobAinV0aud/E
         CNBIFe7TWZDj438BEKwXpWDfeokfkTgTq81nVzRKYQ4rdmcKK5YeBa1lUuG0lCs4z8xE
         AjSwnxv+BgXCpL2nFmaNgHzybwyNX7q2z4jeTd7TOW7q0KVGK9EPi3l2LmcjSCKxeknR
         5zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idwDNbH9Wo5Pci3iRQ8ors3jpFQBSSL6bTxgZX7Cc/8=;
        b=gCirFejT8n1dMO5gBmUzfraFszZm4gbsyOL31cQOtmEZ1XnQ8yeDUnS2jWjsfqdb3z
         jCb0AKcM69C+Zh553swRfAKD/Cp0vflqAEqvwIg6uaVC4p2YDmKBt0APA4K9fo90X3Ts
         tIRAf5RAnb7e3KCH4MPae1jJ8xnJPPs3lmPTv5p5GqHRbEKiRbylYNlo7RmhLhjjRkWn
         qaY29extBNFaCT+QFn1Qc+yd+eQKLkuHxlNc3Q9YcPh6tYjOhmcrNC5DUCEh8IdCNX0z
         kV+JubJStGasG2IIX0NWep6KgZ/afURXSnpwe1pwQXw55TjqdX/W5RMiaFoEXwvDk/S/
         eCCg==
X-Gm-Message-State: AOAM533LI3PAUNzhdutZL42fspKT81nh8cpNirqiTQ4mH+nLNtZdpSc+
        Bc06a4EUwWiWufoKZy7pGYW6UXjOAFu10eMoFYE=
X-Google-Smtp-Source: ABdhPJwEf6iJS9+pCeC+HwaYztN89WrvtY7/BT6uo8708nAfmVai0k8G+L5mAPn2SD0CoAZ317OM/QKDekKYlRCuhwQ=
X-Received: by 2002:a5b:7c4:: with SMTP id t4mr7819ybq.368.1630687900091; Fri,
 03 Sep 2021 09:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210902090925.2010528-1-jean-philippe@linaro.org>
 <CAADnVQKwHXw7fLGpJBJBb_MW+d1Gzexo2wk9QwE2v3fy=kHDRA@mail.gmail.com> <YTIWNRqZ/HmHgcaE@larix>
In-Reply-To: <YTIWNRqZ/HmHgcaE@larix>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Sep 2021 09:51:29 -0700
Message-ID: <CAEf4BzYqfykri6kF=KM8eQrJb3O0HLahB2ZqA-N_8TfmsZCr8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build of task_pt_regs tests
 for arm64
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 3, 2021 at 5:31 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Thu, Sep 02, 2021 at 12:13:40PM -0700, Alexei Starovoitov wrote:
> > On Thu, Sep 2, 2021 at 2:08 AM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > struct pt_regs is not exported to userspace on all archs. arm64 and s390
> > > export "user_pt_regs" instead, which causes build failure at the moment:
> > >
> > >   progs/test_task_pt_regs.c:8:16: error: variable has incomplete type 'struct pt_regs'
> > >   struct pt_regs current_regs = {};
> >
> > Right, which is 'bpf_user_pt_regs_t'.
> > It's defined for all archs and arm64/s390/ppc/risv define it
> > differently from pt_regs.
> >
> > >
> > > Use the multi-arch macros defined by tools/lib/bpf/bpf_tracing.h to copy
> > > the pt_regs into a locally-defined struct.
> > >
> > > Copying the user_pt_regs struct on arm64 wouldn't work because the
> > > struct is too large and the compiler complains about using too much
> > > stack.
> >
> > That's a different issue.
>
> It does work when doing an implicit copy (current_regs = *regs) rather
> than using __builtin_memcpy(). Don't know why but I'll take it.
>
> > I think the cleaner fix would be to make the test use
> > bpf_user_pt_regs_t instead.
>
> Right, although that comes with another complication. We end up including
> tools/include/uapi/asm/bpf_perf_event.h which requires the compiler
> builtins "__aarch64__", "__s390__", etc. Those are not defined with
> "clang -target bpf" so I have to add them to the command line.
> I'll resend with your suggestion but this patch is simpler.
>

The test doesn't care about struct pt_regs type itself, it only cares
to check that contents of captured pt_regs are the same.

We can use CO-RE to check whether user_pt_regs or pt_regs exists in
the kernel. We can also use bpf_core_type_size() to know exactly how
many bytes we want to capture. And then just use
bpf_probe_read_kernel() as memcpy() equivalent to capture bytes. This
should work on all architectures.

> Thanks,
> Jean
