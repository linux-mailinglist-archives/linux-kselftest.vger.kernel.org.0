Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F8117A1CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 10:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgCEJDA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 04:03:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34923 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCEJDA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 04:03:00 -0500
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1j9mPB-0006db-TE
        for linux-kselftest@vger.kernel.org; Thu, 05 Mar 2020 09:02:58 +0000
Received: by mail-lf1-f70.google.com with SMTP id q2so1715609lfo.5
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Mar 2020 01:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrSbYIRTjXPuBmdlG/mjTUYNkZeuzj3eG/1piLNpOjc=;
        b=lsuFl6IP6VTOsXMw7eORJ+QZns1MTTsuYPSNdDQ+o6nquCiYKzY2pmM8MWJgZqldyI
         Y2/p5RAxHIwcvxrLpmQkvQpwtMD3h6OY3Y+1dsCHvtc4M1zqLQvYMekoxzTvxAaTdyXf
         X1ARPL4cSmity3F3DdzMpsZ5DSjDH5tryYhRuWyP9myKIGxwzHgTcoNF2o2sype1xicR
         bwdNsRInjy8no+Sv1CJG2kLDi+9X149g0igMU8sI/+DhcbGBJ2LzR3mDuI0/g2zT9ggD
         yspKZ9z2BQeET3HnGZy6FPKGvI8zz0WODZBvRKS3WU7CIncYZPqTg/1aa+u3Qco2hKrU
         Jm+w==
X-Gm-Message-State: ANhLgQ2+tJ+FOJrS6fAADgrMlu2Z05ZbLGToXh8jnX7+LKxQ22+H3D5R
        HjWoNVVl1a2SeSoRQUwZzksIuys9yrFCGhdBbmloVQnpXuRNvHe7E8+l8wNWNnFoOIr50gtgAXv
        yHyU0A/gqXpULe+NFOkj1hokEXtCO2KpT/GB4SlRmBdvO+kvf2w7hNZw4f1kF
X-Received: by 2002:a2e:570f:: with SMTP id l15mr4709801ljb.236.1583398977218;
        Thu, 05 Mar 2020 01:02:57 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt6qfV8GneO9Qxk/ML5cwfUpdwGUMAQ9cLA99DbdPFD0fdAYfOPF1pIXzb0KzrNtVpg5u6CW/KNa/X3H2JyZa4=
X-Received: by 2002:a2e:570f:: with SMTP id l15mr4709770ljb.236.1583398976762;
 Thu, 05 Mar 2020 01:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20200304131553.27582-1-po-hsu.lin@canonical.com> <87zhcvp89e.fsf@mpe.ellerman.id.au>
In-Reply-To: <87zhcvp89e.fsf@mpe.ellerman.id.au>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 5 Mar 2020 17:02:45 +0800
Message-ID: <CAMy_GT9fr9cq3FrxUEjv+UhFuduqwPzBjeOL25Kp_EPAAmpU2g@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc: Turn off timeout setting for
 benchmarks, dscr, signal, tm
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, shuah <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 5, 2020 at 3:32 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Po-Hsu Lin <po-hsu.lin@canonical.com> writes:
> > Some specific tests in powerpc can take longer than the default 45
> > seconds that added in commit 852c8cbf (selftests/kselftest/runner.sh:
> > Add 45 second timeout per test) to run, the following test result was
> > collected across 2 Power8 nodes and 1 Power9 node in our pool:
> >   powerpc/benchmarks/futex_bench - 52s
> >   powerpc/dscr/dscr_sysfs_test - 116s
> >   powerpc/signal/signal_fuzzer - 88s
> >   powerpc/tm/tm_unavailable_test - 168s
> >   powerpc/tm/tm-poison - 240s
> >
> > Thus they will fail with TIMEOUT error. Disable the timeout setting
> > for these sub-tests to allow them finish properly.
>
> I run the powerpc tests with run-parts, rather than the kselftest
> script, we already have our own test runner with a 120s timeout.
>
> I didn't think the kselftests runner actually worked with the powerpc
> tests? Because we override RUN_TESTS.
>
Hello Michael,

I have done a small experiment with timeout=1 in settings and use
run-parts to run the executables, it looks like this change won't
affect run-parts.

Not quite sure about the RUN_TESTS you mentioned here, we're testing
it with command like:
sudo make -C linux/tools/testing/selftests TARGETS=powerpc run_tests
And the timeout setting will take effect with this.

Thanks

> cheers
>
>
> > https://bugs.launchpad.net/bugs/1864642
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
> >  tools/testing/selftests/powerpc/benchmarks/Makefile | 2 ++
> >  tools/testing/selftests/powerpc/benchmarks/settings | 1 +
> >  tools/testing/selftests/powerpc/dscr/Makefile       | 2 ++
> >  tools/testing/selftests/powerpc/dscr/settings       | 1 +
> >  tools/testing/selftests/powerpc/signal/Makefile     | 2 ++
> >  tools/testing/selftests/powerpc/signal/settings     | 1 +
> >  tools/testing/selftests/powerpc/tm/Makefile         | 2 ++
> >  tools/testing/selftests/powerpc/tm/settings         | 1 +
> >  8 files changed, 12 insertions(+)
> >  create mode 100644 tools/testing/selftests/powerpc/benchmarks/settings
> >  create mode 100644 tools/testing/selftests/powerpc/dscr/settings
> >  create mode 100644 tools/testing/selftests/powerpc/signal/settings
> >  create mode 100644 tools/testing/selftests/powerpc/tm/settings
> >
> > diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
> > index d40300a..a32a6ab 100644
> > --- a/tools/testing/selftests/powerpc/benchmarks/Makefile
> > +++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
> > @@ -2,6 +2,8 @@
> >  TEST_GEN_PROGS := gettimeofday context_switch fork mmap_bench futex_bench null_syscall
> >  TEST_GEN_FILES := exec_target
> >
> > +TEST_FILES := settings
> > +
> >  CFLAGS += -O2
> >
> >  top_srcdir = ../../../../..
> > diff --git a/tools/testing/selftests/powerpc/benchmarks/settings b/tools/testing/selftests/powerpc/benchmarks/settings
> > new file mode 100644
> > index 0000000..e7b9417
> > --- /dev/null
> > +++ b/tools/testing/selftests/powerpc/benchmarks/settings
> > @@ -0,0 +1 @@
> > +timeout=0
> > diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
> > index 5df4763..cfa6eed 100644
> > --- a/tools/testing/selftests/powerpc/dscr/Makefile
> > +++ b/tools/testing/selftests/powerpc/dscr/Makefile
> > @@ -3,6 +3,8 @@ TEST_GEN_PROGS := dscr_default_test dscr_explicit_test dscr_user_test \
> >             dscr_inherit_test dscr_inherit_exec_test dscr_sysfs_test  \
> >             dscr_sysfs_thread_test
> >
> > +TEST_FILES := settings
> > +
> >  top_srcdir = ../../../../..
> >  include ../../lib.mk
> >
> > diff --git a/tools/testing/selftests/powerpc/dscr/settings b/tools/testing/selftests/powerpc/dscr/settings
> > new file mode 100644
> > index 0000000..e7b9417
> > --- /dev/null
> > +++ b/tools/testing/selftests/powerpc/dscr/settings
> > @@ -0,0 +1 @@
> > +timeout=0
> > diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
> > index 113838f..153fafc 100644
> > --- a/tools/testing/selftests/powerpc/signal/Makefile
> > +++ b/tools/testing/selftests/powerpc/signal/Makefile
> > @@ -5,6 +5,8 @@ CFLAGS += -maltivec
> >  $(OUTPUT)/signal_tm: CFLAGS += -mhtm
> >  $(OUTPUT)/sigfuz: CFLAGS += -pthread -m64
> >
> > +TEST_FILES := settings
> > +
> >  top_srcdir = ../../../../..
> >  include ../../lib.mk
> >
> > diff --git a/tools/testing/selftests/powerpc/signal/settings b/tools/testing/selftests/powerpc/signal/settings
> > new file mode 100644
> > index 0000000..e7b9417
> > --- /dev/null
> > +++ b/tools/testing/selftests/powerpc/signal/settings
> > @@ -0,0 +1 @@
> > +timeout=0
> > diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
> > index b15a1a3..7b99d09 100644
> > --- a/tools/testing/selftests/powerpc/tm/Makefile
> > +++ b/tools/testing/selftests/powerpc/tm/Makefile
> > @@ -7,6 +7,8 @@ TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack
> >       $(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn tm-signal-sigreturn-nt \
> >       tm-signal-context-force-tm tm-poison
> >
> > +TEST_FILES := settings
> > +
> >  top_srcdir = ../../../../..
> >  include ../../lib.mk
> >
> > diff --git a/tools/testing/selftests/powerpc/tm/settings b/tools/testing/selftests/powerpc/tm/settings
> > new file mode 100644
> > index 0000000..e7b9417
> > --- /dev/null
> > +++ b/tools/testing/selftests/powerpc/tm/settings
> > @@ -0,0 +1 @@
> > +timeout=0
> > --
> > 2.7.4
