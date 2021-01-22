Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20122FF934
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 01:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbhAVAF2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 19:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbhAVAF0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 19:05:26 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6048CC0613D6;
        Thu, 21 Jan 2021 16:04:46 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i141so3855225yba.0;
        Thu, 21 Jan 2021 16:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+c6Vsc2Hr1NYtehFNtn1wrNndygwXtWUpkJB2b6HZE=;
        b=WEZB+ES+30vwtfjjodlhKEup0jmMLyCGmrbtCm3IUoybNmf2N7/LEXpV/v/bgvKc09
         PgisUMPbDi0b57bzVFA0mllJMVs1+P9zIYj9n1jqxfBlhufm0JenhwBVo8ZETy4JWQeS
         a9GQIYWFYd0BG7KMltMbO/SSf2voBrX/jcTkJTx7sqaX42bcmPaR037jzXnlhaJAHze2
         GbUPuKfRFSI3hXtDuBPMt8dp4lAG64jWKREN8nbsGV9k0R0Znq4rlsPaa4n5x2qTx3F3
         prB5gATlF6XIoLQJdytoHS1L0u9iLlKx2hHP8ojsX4LkMrkT9jhB6vgANAtD0IecrcNc
         5mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+c6Vsc2Hr1NYtehFNtn1wrNndygwXtWUpkJB2b6HZE=;
        b=r6ceAPq1uKbAbxhY4cqTy8F43z0wXw3TgYCoGBu3Mc/O/si+/mBDHCKIdtrXad9pQD
         UX+NGnIuP+6pjki2KfP3aNCB761qPnBae+FyqOXR5Fc+LIWxatLGirNfQwYJpGU4POE8
         TmAKaLLiIcATNxG1Dtlb2VHqXJB/e1MoA1qit8HZH6wXJMh70ikmFL05vgmLC5u1GTax
         UkTprJaGzzK5H6HKboM1uk53y3tifhgSczKg74NnTrLq8oHTVD7BvXa5517TEhg4+K3N
         OyN9YxdDzlOB/O3SYINnBoToTuB1MdmTzbEEFvNVcCa3iaVXcM+i+g9wywsCMTR6SghL
         vQQA==
X-Gm-Message-State: AOAM531XuhSzNPDQAdvt8qV3EVCZifWe5FskH1kYW/g/K2ESuooyAagN
        hFU6/9pzKIO6gS6WdMYitqVGAfy9TVcDMnKq5aA=
X-Google-Smtp-Source: ABdhPJyOJX2GyJdtIKpUldsXEykc6aFSpw5UtzuLJvwcCSdNn9fulPMFHg7GlZQiQDR5xKPDSOBugzvgH7j6Nr7KAmQ=
X-Received: by 2002:a25:d6d0:: with SMTP id n199mr2624997ybg.27.1611273885731;
 Thu, 21 Jan 2021 16:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20210116095413.72820-1-sedat.dilek@gmail.com> <20210120223546.GF1798087@krava>
In-Reply-To: <20210120223546.GF1798087@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 Jan 2021 16:04:34 -0800
Message-ID: <CAEf4Bza2W061YpxtUx9ZKQUtE0-tS6gf4yg2Le_2g4kyi3FhnQ@mail.gmail.com>
Subject: Re: [PATCH RFC] tools: Factor Clang, LLC and LLVM utils definitions
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Yulia Kartseva <hex@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Davide Caratti <dcaratti@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 20, 2021 at 2:36 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sat, Jan 16, 2021 at 10:54:04AM +0100, Sedat Dilek wrote:
> > When dealing with BPF/BTF/pahole and DWARF v5 I wanted to build bpftool.
> >
> > While looking into the source code I found duplicate assignments
> > in misc tools for the LLVM eco system, e.g. clang and llvm-objcopy.
> >
> > Move the Clang, LLC and/or LLVM utils definitions to
> > tools/scripts/Makefile.include file and add missing
> > includes where needed.
> > Honestly, I was inspired by commit c8a950d0d3b9
> > ("tools: Factor HOSTCC, HOSTLD, HOSTAR definitions").
> >
> > I tested with bpftool and perf on Debian/testing AMD64 and
> > LLVM/Clang v11.1.0-rc1.
> >
> > Build instructions:
> >
> > [ make and make-options ]
> > MAKE="make V=1"
> > MAKE_OPTS="HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang LD=ld.lld LLVM=1 LLVM_IAS=1"
> > MAKE_OPTS="$MAKE_OPTS PAHOLE=/opt/pahole/bin/pahole"
> >
> > [ clean-up ]
> > $MAKE $MAKE_OPTS -C tools/ clean
> >
> > [ bpftool ]
> > $MAKE $MAKE_OPTS -C tools/bpf/bpftool/
> >
> > [ perf ]
> > PYTHON=python3 $MAKE $MAKE_OPTS -C tools/perf/
> >
> > I was careful with respecting the user's wish to override custom compiler,
> > linker, GNU/binutils and/or LLVM utils settings.
> >
> > Some personal notes:
> > 1. I have NOT tested with cross-toolchain for other archs (cross compiler/linker etc.).
> > 2. This patch is on top of Linux v5.11-rc3.
> >
> > I hope to get some feedback from especially Linux-bpf folks.
> >
> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> > ---
> >  tools/bpf/bpftool/Makefile                  | 2 --
> >  tools/bpf/runqslower/Makefile               | 3 ---
> >  tools/build/feature/Makefile                | 4 ++--
> >  tools/perf/Makefile.perf                    | 1 -
>
> for tools/build and tools/perf
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
>

It's pretty straightforward and looks good for bpftool and runqslower,
but I couldn't apply directly to test due to merge conflicts.

Also, which tree this should go through, given it touches multiple
parts under tools/?

> jirka
>
> >  tools/scripts/Makefile.include              | 7 +++++++
> >  tools/testing/selftests/bpf/Makefile        | 3 +--
> >  tools/testing/selftests/tc-testing/Makefile | 3 +--
> >  7 files changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index f897cb5fb12d..71c14efa6e91 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
>
> SNIP
>
