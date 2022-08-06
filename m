Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9058B7E4
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 21:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiHFTUn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Aug 2022 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiHFTUi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Aug 2022 15:20:38 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12ADEC8
        for <linux-kselftest@vger.kernel.org>; Sat,  6 Aug 2022 12:20:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id y127so8286704yby.8
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Aug 2022 12:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4oGq3ZCSrT1vfi2bYaoywXv1NdclezC5yegz+NUwITI=;
        b=CIUMYyI35ZMhzCIPXqmcc/C+PWVIOpvyOAVdltd1//S4ElmNpnaJuyZHPDcf4NL2pl
         fLihhv4pO5Sjhgs55T1pJGNpggZiYJnoC4mfmKcFAVuqKWC2hyoAxO8LL2FUrCsCiC7w
         Erw2nGhjQlsyzqBqCZEz0h66kBxkFIm57tKja7qAqdk+guDImqH/ztMfdQSdAhzdBnnd
         Q8fjY97xs/NbxVL98wAIIOM1q3tH/RrpSFktczXmB3OWFsf5Rh3JGmkMld8LPSPpig3S
         EcJC3JnGl29JeJidB+AMECa3RMbGrdw54RQtJFQOnx9Gnb7H8FrnrtGK12X2fTTGlTM7
         ++Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4oGq3ZCSrT1vfi2bYaoywXv1NdclezC5yegz+NUwITI=;
        b=6Mzo9N4YxjEyzRWkEEAG+PP/6bUid0L5UnCE5KaF+YtgE7Ymb5FXMW4Rw558kzQjuv
         WHQbjbVXgZKwCV17cZv6R5bypKkT6APmRI7sxEEU9QQTk7IP2NfPSBhvM6tMoNg1JVSF
         r2sCePHyBXszz6YxJinF3CMXeGTNdmHiC+espDKAcrJ9FkBp1v2Px7IiQASBlD6DTa5v
         7Zr0F96JbND3xtL0priPHNnJLkk7mL9mYYJs1HBLq2TxP3WDG5mb/na1zBA0+maLSil2
         JdECiptIqbzj8X0EKbN3TaFhYdL9by6SKhoV+HSOl4tzsWoHlTmZFq9+YHvZ3zaXSYdL
         Y8Og==
X-Gm-Message-State: ACgBeo1NzIDoZGw9QCjQVA11F6vJ4m9NZNBsBYo61idHgoZD1FyD3cuT
        rghbqlU/hAqslwWjXjutHSEEesn/DYogXNyveKuogQ==
X-Google-Smtp-Source: AA6agR5hE/H9qUf9Xrh/2jvFjmn62VHy9OUX0o87viBxyH2xV7voC6wV/zPuuqX8+eiCQeu+B0118IG1b59A1k9VhJU=
X-Received: by 2002:a25:6ed5:0:b0:669:8b84:bb57 with SMTP id
 j204-20020a256ed5000000b006698b84bb57mr9562220ybc.227.1659813636619; Sat, 06
 Aug 2022 12:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220805230158.39378-1-khuey@kylehuey.com> <20220805230158.39378-2-khuey@kylehuey.com>
 <Yu4rzf9XI6NzHwne@gmail.com> <CAP045ApfwwoJOxJhaNVY-LpzBis5b8NYiPwz4nEtERf_tJbcKA@mail.gmail.com>
 <Yu65FD+Jd1V7GG62@gmail.com>
In-Reply-To: <Yu65FD+Jd1V7GG62@gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Sat, 6 Aug 2022 12:20:21 -0700
Message-ID: <CAP045Aqy68vz3rJUGAOjeTjHD2Mx6b19GrgrhjEDssdOaZacig@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] selftests/vm/pkeys: Add a regression test for
 setting PKRU through ptrace
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "Robert O'Callahan" <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 6, 2022 at 11:55 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Kyle Huey <me@kylehuey.com> wrote:
>
> > On Sat, Aug 6, 2022 at 1:52 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Kyle Huey <me@kylehuey.com> wrote:
> > >
> > > > From: Kyle Huey <me@kylehuey.com>
> > > >
> > > > This tests PTRACE_SETREGSET with NT_X86_XSTATE modifying PKRU directly and
> > > > removing the PKRU bit from XSTATE_BV.
> > > >
> > > > Signed-off-by: Kyle Huey <me@kylehuey.com>
> > > > ---
> > > >  tools/testing/selftests/vm/pkey-x86.h        | 12 +++
> > > >  tools/testing/selftests/vm/protection_keys.c | 88 +++++++++++++++++++-
> > > >  2 files changed, 98 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
> > > > index b078ce9c6d2a..72c14cd3ddc7 100644
> > > > --- a/tools/testing/selftests/vm/pkey-x86.h
> > > > +++ b/tools/testing/selftests/vm/pkey-x86.h
> > > > @@ -104,6 +104,18 @@ static inline int cpu_has_pkeys(void)
> > > >       return 1;
> > > >  }
> > > >
> > > > +static inline int cpu_max_xsave_size(void)
> > > > +{
> > > > +     unsigned long XSTATE_CPUID = 0xd;
> > > > +     unsigned int eax;
> > > > +     unsigned int ebx;
> > > > +     unsigned int ecx;
> > > > +     unsigned int edx;
> > > > +
> > > > +     __cpuid_count(XSTATE_CPUID, 0, eax, ebx, ecx, edx);
> > > > +     return ecx;
> > > > +}
> > > > +
> > > >  static inline u32 pkey_bit_position(int pkey)
> > > >  {
> > > >       return pkey * PKEY_BITS_PER_PKEY;
> > > > diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> > > > index 291bc1e07842..27759d3ed9cd 100644
> > > > --- a/tools/testing/selftests/vm/protection_keys.c
> > > > +++ b/tools/testing/selftests/vm/protection_keys.c
> > > > @@ -18,12 +18,13 @@
> > > >   *   do a plain mprotect() to a mprotect_pkey() area and make sure the pkey sticks
> > > >   *
> > > >   * Compile like this:
> > > > - *   gcc      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> > > > - *   gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> > > > + *   gcc -mxsave      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> > > > + *   gcc -mxsave -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> > > >   */
> > > >  #define _GNU_SOURCE
> > > >  #define __SANE_USERSPACE_TYPES__
> > > >  #include <errno.h>
> > > > +#include <linux/elf.h>
> > > >  #include <linux/futex.h>
> > > >  #include <time.h>
> > > >  #include <sys/time.h>
> > > > @@ -1550,6 +1551,86 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
> > > >       do_not_expect_pkey_fault("plain read on recently PROT_EXEC area");
> > > >  }
> > > >
> > > > +#if defined(__i386__) || defined(__x86_64__)
> > > > +void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
> > > > +{
> > > > +     pid_t child;
> > > > +     int status, ret;
> > > > +     int pkey_offset = pkey_reg_xstate_offset();
> > > > +     size_t xsave_size = cpu_max_xsave_size();
> > > > +     void *xsave;
> > > > +     u32 *pkey_register;
> > > > +     u64 *xstate_bv;
> > > > +     struct iovec iov;
> > > > +
> > > > +     child = fork();
> > > > +     pkey_assert(child >= 0);
> > > > +     dprintf3("[%d] fork() ret: %d\n", getpid(), child);
> > > > +     if (!child) {
> > > > +             u32 pkey_register = read_pkey_reg();
> > > > +
> > > > +             ptrace(PTRACE_TRACEME, 0, 0, 0);
> > > > +             raise(SIGSTOP);
> > > > +
> > > > +             /*
> > > > +              * need __read_pkey_reg() version so we do not do shadow_pkey_reg
> > > > +              * checking
> > > > +              */
> > > > +             if (pkey_register == __read_pkey_reg())
> > > > +                     exit(1);
> > > > +
> > > > +             raise(SIGSTOP);
> > > > +
> > > > +             exit(__read_pkey_reg());
> > > > +     }
> > > > +
> > > > +     pkey_assert(child == waitpid(child, &status, 0));
> > > > +     dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
> > > > +     pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
> > > > +
> > > > +     xsave = (void *)malloc(xsave_size);
> > > > +     pkey_assert(xsave > 0);
> > > > +
> > > > +     iov.iov_base = xsave;
> > > > +     iov.iov_len = xsave_size;
> > > > +     ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> > > > +     pkey_assert(ret == 0);
> > > > +
> > > > +     pkey_register = (u32 *)(xsave + pkey_offset);
> > > > +     pkey_assert(*pkey_register == read_pkey_reg());
> > > > +
> > > > +     *pkey_register = !read_pkey_reg();
> > > > +
> > > > +     ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> > > > +     pkey_assert(ret == 0);
> > > > +
> > > > +     ret = ptrace(PTRACE_CONT, child, 0, 0);
> > > > +     pkey_assert(ret == 0);
> > > > +
> > > > +     pkey_assert(child == waitpid(child, &status, 0));
> > > > +     dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
> > > > +     pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
> > > > +
> > > > +     ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> > > > +     pkey_assert(ret == 0);
> > > > +
> > > > +     xstate_bv = (u64 *)(xsave + 512);
> > > > +     *xstate_bv &= ~(1 << 9);
> > > > +
> > > > +     ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> > > > +     pkey_assert(ret == 0);
> > > > +
> > > > +     ret = ptrace(PTRACE_CONT, child, 0, 0);
> > > > +     pkey_assert(ret == 0);
> > > > +
> > > > +     pkey_assert(child == waitpid(child, &status, 0));
> > > > +     dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
> > > > +     pkey_assert(WIFEXITED(status));
> > > > +     pkey_assert(WEXITSTATUS(status) == 0);
> > > > +     free(xsave);
> > >
> > > LGTM.
> > >
> > > May I ask for a bit more in terms of testing the ABI: writing some
> > > non-trivial (not all-zero and not all-ones) value into the PKRU register,
> > > forcing the child task to go through a FPU save/restore context switch
> > > and then reading it back and verifying the value, or something like that?
> >
> > Can you elaborate a bit on what you mean here? I'm not sure what "a
> > FPU save/restore context switch" is. The XSTATE (and everything else)
> > will be saved/restored at the ptrace stops (for the raise(SIGSTOP)s)
> > already.
>
> Yeah, here I meant that the ptraced child actually has to execute to carry
> the new values - and AFAICS that already happens in your testcase, as
> there's a PTRACE_CONT+waitpid() between the PTRACE_SETREGSET and the second
> PTRACE_GETREGSET call, right?

Yeah. The gdb command sequence I reported is essentially doing
PTRACE_SETREGSET immediately followed by PTRACE_GETREGSET with no
intervening execution. And while that is a visible manifestation of
the bug, what I really care about is the modifications being reflected
in the execution of the ptracee. I could add code to read back the
value via PTRACE_GETREGSET too if desired.

> If so, then the testcase should be mostly fine, except would it make sense
> to use something less trivial than clearing the permission bitmask:
>
> > > > +     xstate_bv = (u64 *)(xsave + 512);
> > > > +     *xstate_bv &= ~(1 << 9);
>
> if I'm reading the code right? A 01010101 bitmask perhaps?

So there's two tests (the two PTRACE_SETREGSET calls). The first one
tests modifying the PKRU value stored in the XSTATE. I actually meant
this to negate the existing PKRU value and flip all the bits but I
realize now I wrote ! instead of ~ (! is the bitwise negation operator
in Rust, which is what I do most of the time).  !PKRU is still
different from PKRU though, so the test does fail on affected kernels
and pass after the fix which the child sees that the PKRU value did
change somehow and doesn't take the early exit(1).

The second part, which you've highlighted, tests clearing the PKRU bit
in the XSTATE_BV field. This would cause an XRSTOR to set PKRU to the
hardware init value (0) and the test checks that the value is indeed
zero (by having the child exit with the PKRU register value as its
return code, and then checking that the child exited with code 0).

- Kyle

> Thanks,
>
>         Ingo
