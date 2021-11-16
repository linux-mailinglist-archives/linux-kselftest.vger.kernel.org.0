Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717944539BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Nov 2021 20:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhKPTGt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Nov 2021 14:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbhKPTGt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Nov 2021 14:06:49 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A5AC061570;
        Tue, 16 Nov 2021 11:03:51 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y68so55196289ybe.1;
        Tue, 16 Nov 2021 11:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNMHd0m7YSjAFUJ4/2Md5Ysd8NvQljw8TBpQtRS8+nE=;
        b=bpI2osQtpaAIKgDvkCOHlFOIMewfPSKRSXQyeOpDbOS451zRGrWHP4I5JQtg5PqMhR
         Wa8/lvTYyTVFWjxtBHXDtKWBWEHBYdnx9MwvM7vc/dJpJjM8C0uPcljFHpnmfJeqazka
         WytZokJibQQqs3yPyEZ7CfvbKVf2vgWW8JBGv0icUjWcybgTkIGVczuoDp4QmFAkLzU9
         672BPrxaB6bKjrbGmKHFYK4HoRlOc5g7NTZlHNmDVVvdaZnFfJdtRLPb2Rew7D34OGMH
         GNW096odU/QAmqvIxXCH8olkOLCkqlfvXwaOhsuoY0MCcJD61VMRqyY0Y0toARsfQwmy
         gdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNMHd0m7YSjAFUJ4/2Md5Ysd8NvQljw8TBpQtRS8+nE=;
        b=qugNoZJX7VplJxYGa5fzsgFrhdJRaEHR4OBOUN5TI8+bhqVGJ2VOkq3sYlunN9LxOs
         HprxlRIkFJuyzoC2wDdFlXjuGwBv33pgtI6NtMKyLeY0pyaOfUdKDltZ2b+ReTh2E4oW
         Y09Ej+CcosMIN65c0XlbtPrWAucFa/XhEj+xNceA/QDgDvG6BNUTAiiwg24IHPwYTvIf
         Qh068BDYVCWvAPn3aTZwYJmSiSEuHtQNGTHKo6Nue5Pu4Qnv3LtyQimuMtPKkn+A8SY0
         36SDjugCY0cZi83Ks7sujFYvrklo8msAmaG6OGOiEr4jJsLUn6VHhLPV8JqdR4yzNYTv
         u40Q==
X-Gm-Message-State: AOAM533lbi7VpjwRfzKP+Z1XJ/TULPTfRxBRpcgg4iPKjCcB2KGDppL+
        yLSx5hM3hmhJxKtcNTwMhfQfszaeZ74bfUKo7v8=
X-Google-Smtp-Source: ABdhPJxoJMxbGLKsE/I2W9+DQ2IO1iiAZqV9793JzrMgVL9FNzbZU/MxYM5LlTnfVNdV1azhSlrJxcfZYVXroxx1ggw=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr10395367ybt.267.1637089431079;
 Tue, 16 Nov 2021 11:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20211112155128.565680-1-jean-philippe@linaro.org>
 <d3a19501-01ee-a160-2275-c83fb0fb04b7@isovalent.com> <YY6WLDizLBxnhgnP@myrica>
 <CAEf4BzbS-4sWORntzqh7qhEo=5cpzca0WA5ars70LxwzZwxgKA@mail.gmail.com> <YZNuWUEBG9Jbzerx@myrica>
In-Reply-To: <YZNuWUEBG9Jbzerx@myrica>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 11:03:40 -0800
Message-ID: <CAEf4BzbkU87MX22w0-W8N4SV0hY=gkhYi8JcQZ4B5q6xjhfhXw@mail.gmail.com>
Subject: Re: [PATCH bpf] tools/runqslower: Fix cross-build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 16, 2021 at 12:40 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Mon, Nov 15, 2021 at 10:10:03PM -0800, Andrii Nakryiko wrote:
> > On Fri, Nov 12, 2021 at 8:28 AM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > On Fri, Nov 12, 2021 at 04:17:21PM +0000, Quentin Monnet wrote:
> > > > 2021-11-12 15:51 UTC+0000 ~ Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > Commit be79505caf3f ("tools/runqslower: Install libbpf headers when
> > > > > building") uses the target libbpf to build the host bpftool, which
> > > > > doesn't work when cross-building:
> > > > >
> > > > >   make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/bpf/runqslower O=/tmp/runqslower
> > > > >   ...
> > > > >     LINK    /tmp/runqslower/bpftool/bpftool
> > > > >   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a(libbpf-in.o): Relocations in generic ELF (EM: 183)
> > > > >   /usr/bin/ld: /tmp/runqslower/libbpf/libbpf.a: error adding symbols: file in wrong format
> > > > >   collect2: error: ld returned 1 exit status
> > > > >
> > > > > When cross-building, the target architecture differs from the host. The
> > > > > bpftool used for building runqslower is executed on the host, and thus
> > > > > must use a different libbpf than that used for runqslower itself.
> > > > > Remove the LIBBPF_OUTPUT and LIBBPF_DESTDIR parameters, so the bpftool
> > > > > build makes its own library if necessary.
> > > > >
> > > > > In the selftests, pass the host bpftool, already a prerequisite for the
> > > > > runqslower recipe, as BPFTOOL_OUTPUT. The runqslower Makefile will use
> > > > > the bpftool that's already built for selftests instead of making a new
> > > > > one.
> > > > >
> > > > > Fixes: be79505caf3f ("tools/runqslower: Install libbpf headers when building")
> > > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> > > >
> > > > I realised too late I should have cc-ed you on those patches, apologies
> > > > for not doing so. Thank you for the fix!
> > >
> > > No worries, I usually try to catch build issues in bpf-next but missed it
> > > this time. I'm still slowly working towards getting automated testing on
> > > Arm targets, which will catch regressions quicker.
> >
> > Are you planning to contribute it to BPF CI? Or you meant you have
> > your own separate system?
>
> At the moment I'm looking at adding it to LKFT, which does regression
> testing on various Arm boards (https://lkft.linaro.org/about/). The only
> bit missing for that is support for cross-building tools with clang, which
> I'll send shortly.

Detecting regressions is good, but preventing regressions is even
better. That's what we are doing with BPF CI. We create a Github PR
and run BPF selftests before patches are applied (see [0] for the
current list of patch sets being reviewed and thus tested). It would
be good to have more support for various architectures there. We
currently have x86-64 and s390x was added just recently. Regressions
still happen, obviously (we don't also control all the other parts of
the kernel so after tree merges things quite often are a bit unstable
and broken, but the system has caught many issues already), but it's
been a tremendous help and time saver. So consider contributing, if
you care about those architectures.

  [0] https://github.com/kernel-patches/bpf/pulls

>
> Thanks,
> Jean
