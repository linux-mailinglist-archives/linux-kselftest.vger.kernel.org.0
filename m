Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2387A58B59D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiHFMqq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Aug 2022 08:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiHFMqp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Aug 2022 08:46:45 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35F2639A
        for <linux-kselftest@vger.kernel.org>; Sat,  6 Aug 2022 05:46:43 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z5so7480840yba.3
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Aug 2022 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wfqUsEzEiCCBgQ5jNGeT7/KH0IY7yOeXOJ/dkTqWA2E=;
        b=XUzM0spOXwRLkQOziA2UxUAINcsO0ir6CtCUIe6xr++pqfWJn8GnXtG6SI1PcVC7+e
         S5NZfq/F6tgWrkzRSBaAXW6FMWk/Ks42dDiabekOY3evqB1IbYsq3yDgijLZYEg79p+J
         M9P4qGNDnT5wBts4YFs3ZYPXRrV8XJ4xORgxfhfPrMNY0mvePF61jh6ab/3vsSw92neZ
         IE3cdgDq3NEZf4PM3qOxTy9DW1WtzhE7AuoY8F1pqJAvyplWARP7IsslQql19eUQP4e/
         fXoSqpnJKKQ3x7wjg33HwV0UbmNWY9WXBE/sj+1cGai4czrGd980h+H0h6t/Zdsebap3
         1jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wfqUsEzEiCCBgQ5jNGeT7/KH0IY7yOeXOJ/dkTqWA2E=;
        b=fmwdZs0QEZwcR9e8b2X+Ucl/uZbZVeD6WCblZXq7SRQ+qEEVxKieNc+JYQZ4fUkLdb
         42L/WM4Nng4YLVg5kkbatnAnHhm9ODkqTtZlfpgArWohL1BIfzESK5Zlb2z7VHdoZvUx
         ZJYier1K9mqcFg7ZOvty3sGjTYldZGt8JtmiZpJF8M7kYaKXaQZw2z2zP5LgUn+BiUOG
         Ol2zbLdsP1VHFAFbK73Kt0UTA1YmBsGKsF/C3HP1IKlH/hOKUUXLb3Ydp/uf6gYVDHkx
         PpdfIY2rKKtJZh2jPpftUSWIZRF6ZN28884vHZrbMbLEmtn7cQYEYY6lM6jTRjd0yakI
         ZM9Q==
X-Gm-Message-State: ACgBeo3NTKcihzy4OGv55glTVsjCPdmUNtAYnNhLmpVBQ1oPU6667bAN
        mrs4Jnv7Znto+UJ80KsipOnSd4c11sdCbmyoksJ0IQ==
X-Google-Smtp-Source: AA6agR5sPY+i3aLX+Y6bOJOLsdhWTGZgQPCbuGjmcgjrqhCFfgIgIcCsirSpV2eSlJoNvXsUCDfixkAhackVlC/35vE=
X-Received: by 2002:a25:6ed5:0:b0:669:8b84:bb57 with SMTP id
 j204-20020a256ed5000000b006698b84bb57mr8511440ybc.227.1659790003139; Sat, 06
 Aug 2022 05:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220805230158.39378-1-khuey@kylehuey.com> <20220805230158.39378-2-khuey@kylehuey.com>
 <Yu4rzf9XI6NzHwne@gmail.com>
In-Reply-To: <Yu4rzf9XI6NzHwne@gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Sat, 6 Aug 2022 05:46:31 -0700
Message-ID: <CAP045ApfwwoJOxJhaNVY-LpzBis5b8NYiPwz4nEtERf_tJbcKA@mail.gmail.com>
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

On Sat, Aug 6, 2022 at 1:52 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Kyle Huey <me@kylehuey.com> wrote:
>
> > From: Kyle Huey <me@kylehuey.com>
> >
> > This tests PTRACE_SETREGSET with NT_X86_XSTATE modifying PKRU directly and
> > removing the PKRU bit from XSTATE_BV.
> >
> > Signed-off-by: Kyle Huey <me@kylehuey.com>
> > ---
> >  tools/testing/selftests/vm/pkey-x86.h        | 12 +++
> >  tools/testing/selftests/vm/protection_keys.c | 88 +++++++++++++++++++-
> >  2 files changed, 98 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
> > index b078ce9c6d2a..72c14cd3ddc7 100644
> > --- a/tools/testing/selftests/vm/pkey-x86.h
> > +++ b/tools/testing/selftests/vm/pkey-x86.h
> > @@ -104,6 +104,18 @@ static inline int cpu_has_pkeys(void)
> >       return 1;
> >  }
> >
> > +static inline int cpu_max_xsave_size(void)
> > +{
> > +     unsigned long XSTATE_CPUID = 0xd;
> > +     unsigned int eax;
> > +     unsigned int ebx;
> > +     unsigned int ecx;
> > +     unsigned int edx;
> > +
> > +     __cpuid_count(XSTATE_CPUID, 0, eax, ebx, ecx, edx);
> > +     return ecx;
> > +}
> > +
> >  static inline u32 pkey_bit_position(int pkey)
> >  {
> >       return pkey * PKEY_BITS_PER_PKEY;
> > diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> > index 291bc1e07842..27759d3ed9cd 100644
> > --- a/tools/testing/selftests/vm/protection_keys.c
> > +++ b/tools/testing/selftests/vm/protection_keys.c
> > @@ -18,12 +18,13 @@
> >   *   do a plain mprotect() to a mprotect_pkey() area and make sure the pkey sticks
> >   *
> >   * Compile like this:
> > - *   gcc      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> > - *   gcc -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> > + *   gcc -mxsave      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> > + *   gcc -mxsave -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
> >   */
> >  #define _GNU_SOURCE
> >  #define __SANE_USERSPACE_TYPES__
> >  #include <errno.h>
> > +#include <linux/elf.h>
> >  #include <linux/futex.h>
> >  #include <time.h>
> >  #include <sys/time.h>
> > @@ -1550,6 +1551,86 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
> >       do_not_expect_pkey_fault("plain read on recently PROT_EXEC area");
> >  }
> >
> > +#if defined(__i386__) || defined(__x86_64__)
> > +void test_ptrace_modifies_pkru(int *ptr, u16 pkey)
> > +{
> > +     pid_t child;
> > +     int status, ret;
> > +     int pkey_offset = pkey_reg_xstate_offset();
> > +     size_t xsave_size = cpu_max_xsave_size();
> > +     void *xsave;
> > +     u32 *pkey_register;
> > +     u64 *xstate_bv;
> > +     struct iovec iov;
> > +
> > +     child = fork();
> > +     pkey_assert(child >= 0);
> > +     dprintf3("[%d] fork() ret: %d\n", getpid(), child);
> > +     if (!child) {
> > +             u32 pkey_register = read_pkey_reg();
> > +
> > +             ptrace(PTRACE_TRACEME, 0, 0, 0);
> > +             raise(SIGSTOP);
> > +
> > +             /*
> > +              * need __read_pkey_reg() version so we do not do shadow_pkey_reg
> > +              * checking
> > +              */
> > +             if (pkey_register == __read_pkey_reg())
> > +                     exit(1);
> > +
> > +             raise(SIGSTOP);
> > +
> > +             exit(__read_pkey_reg());
> > +     }
> > +
> > +     pkey_assert(child == waitpid(child, &status, 0));
> > +     dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
> > +     pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
> > +
> > +     xsave = (void *)malloc(xsave_size);
> > +     pkey_assert(xsave > 0);
> > +
> > +     iov.iov_base = xsave;
> > +     iov.iov_len = xsave_size;
> > +     ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> > +     pkey_assert(ret == 0);
> > +
> > +     pkey_register = (u32 *)(xsave + pkey_offset);
> > +     pkey_assert(*pkey_register == read_pkey_reg());
> > +
> > +     *pkey_register = !read_pkey_reg();
> > +
> > +     ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> > +     pkey_assert(ret == 0);
> > +
> > +     ret = ptrace(PTRACE_CONT, child, 0, 0);
> > +     pkey_assert(ret == 0);
> > +
> > +     pkey_assert(child == waitpid(child, &status, 0));
> > +     dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
> > +     pkey_assert(WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP);
> > +
> > +     ret = ptrace(PTRACE_GETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> > +     pkey_assert(ret == 0);
> > +
> > +     xstate_bv = (u64 *)(xsave + 512);
> > +     *xstate_bv &= ~(1 << 9);
> > +
> > +     ret = ptrace(PTRACE_SETREGSET, child, (void *)NT_X86_XSTATE, &iov);
> > +     pkey_assert(ret == 0);
> > +
> > +     ret = ptrace(PTRACE_CONT, child, 0, 0);
> > +     pkey_assert(ret == 0);
> > +
> > +     pkey_assert(child == waitpid(child, &status, 0));
> > +     dprintf3("[%d] waitpid(%d) status: %x\n", getpid(), child, status);
> > +     pkey_assert(WIFEXITED(status));
> > +     pkey_assert(WEXITSTATUS(status) == 0);
> > +     free(xsave);
>
> LGTM.
>
> May I ask for a bit more in terms of testing the ABI: writing some
> non-trivial (not all-zero and not all-ones) value into the PKRU register,
> forcing the child task to go through a FPU save/restore context switch
> and then reading it back and verifying the value, or something like that?

Can you elaborate a bit on what you mean here? I'm not sure what "a
FPU save/restore context switch" is. The XSTATE (and everything else)
will be saved/restored at the ptrace stops (for the raise(SIGSTOP)s)
already.

- Kyle

> Thanks,
>
>         Ingo
