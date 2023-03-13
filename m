Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D126B732A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjCMJux (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 05:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjCMJus (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 05:50:48 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5E637F37
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Mar 2023 02:50:34 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id a3so10479885vsi.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Mar 2023 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678701033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0thsfBhKWc4p+EFtaKanDgEsWWKR0LrE3hmVfPf/OgA=;
        b=Nh3RFuZOS7PVy3YaLzs4wUqwSvbWILuwB1hJqMBUNlYfPJIJj0zyfp/uPCULg/m4EP
         cqfSzk7J07ROlJY+CgXgJ9SA/d2UhU+SB9CH7/Vsi4zPtHA/uw8bsTx9msC26QFZTEjg
         cjwPyfaCN1kofIEo4p1lK73Czbl8KDoh8E8Mv5bsDcd+XZmM5uhZBVaiK4iqCM4qIotm
         H4XWhxHhHg/QBEEoanIOrMFkdY/6QEohAMJsfAFdBIwYisZTl/8to5SWEjR20CkqDa6/
         K5wb/8kMzvf3pJdhplZY8F2MugRXqANUDWe4MmA9rl53Z15aAKkzefgjEsiN++DD7Iku
         dSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678701033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0thsfBhKWc4p+EFtaKanDgEsWWKR0LrE3hmVfPf/OgA=;
        b=0SrNbztq7mFv6KBYMkMJHbs8plZCfMggLFhMrD/qVYETRVRuMUz7cubvbHE/Fqqq2Q
         SIPjlxChne8yCAMWIq12bd4+BaEoLR2FtlYSYQCY68jVGrSz7+UkfuxIWatD6X4883nP
         lBu1ZozXp7B5FH+veW2J0I2D5juOkNcx37V8NThOHGs2hrCP4fssmgZjqLCpFai668Wm
         Vgh9Dq5FfsGSnCTheQNdczgYaqSdy/r8AFIL8fs9/AAG4OuchZs/78Mqnw81r3thxyQB
         nBUnt1JtGuoTCjEgwbLmqS8lMx19oZdxjK3adQ60UTAtxjiPgOjqxzsQhzFp7an8yQg/
         +JtQ==
X-Gm-Message-State: AO0yUKWzCdpQzzsHc2GReglYM2BSiC+UAbjAkY7Cx2Y48YVoCM/mZGxf
        PRmiuJ2eu0uzYW+A/VT+pqUOSF4po5J2QRpiVBGRYA==
X-Google-Smtp-Source: AK7set/M8gEYQsVx0+WWXfj/bSZ1YioVzkOVkLFio9jFik9aJjbtJBiBoSSNstXJXQmtGgiZ+KicAEYxmQSMf6GCZXs=
X-Received: by 2002:a67:1005:0:b0:425:8e57:7bfd with SMTP id
 5-20020a671005000000b004258e577bfdmr1261928vsq.3.1678701033388; Mon, 13 Mar
 2023 02:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230308195933.806917-1-ndesaulniers@google.com>
In-Reply-To: <20230308195933.806917-1-ndesaulniers@google.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 13 Mar 2023 15:20:22 +0530
Message-ID: <CA+G9fYtTL+y-ZYeZXKHbVg9XiYVeHE-RaAjaRHTT+EfXO924cA@mail.gmail.com>
Subject: Re: [PATCH] selftests: sigaltstack: fix -Wuninitialized
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp@list.ru>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 9 Mar 2023 at 01:29, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Building sigaltstack with clang via:
> $ ARCH=x86 make LLVM=1 -C tools/testing/selftests/sigaltstack/
>
> produces the following warning:
>   warning: variable 'sp' is uninitialized when used here [-Wuninitialized]
>   if (sp < (unsigned long)sstack ||
>       ^~
>
> Clang expects these to be declared at global scope; we've fixed this in
> the kernel proper by using the macro `current_stack_pointer`. This is
> defined in different headers for different target architectures, so just
> create a new header that defines the arch-specific register names for
> the stack pointer register, and define it for more targets (at least the
> ones that support current_stack_pointer/ARCH_HAS_CURRENT_STACK_POINTER).
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/lkml/CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimBp86LhGBa0eCnEpA@mail.gmail.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Build and boot tested with clang-16 and tested sigaltstack
on arm64, armv7, FVP, x86_64 and i386 [1] & [2].
These tests were performed at Linaro test farm by Anders
with the help of tuxplan / tuxmake and tuxrun.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by:  Anders Roxell <anders.roxell@linaro.org>


Build log:
-------
clang --target=aarch64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-Werror=option-ignored -Werror=unused-command-line-argument
--target=aarch64-linux-gnu -fintegrated-as -Wall     sas.c  -o
/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/sigaltstack/sas

Test log:
----------

Linux version 6.3.0-rc1-next-20230310 (tuxmake@tuxmake) (Debian clang
version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525.41),
Debian LLD 16.0.0) #1 SMP PREEMPT @1678519789
...

[   56.327569] kselftest: Running tests in sigaltstack
TAP version 13
1..1
# selftests: sigaltstack: sas
# # [NOTE] the stack size is 26400
# TAP version 13
# 1..3
# ok 1 Initial sigaltstack state was SS_DISABLE
# # [RUN] signal USR1
# ok 2 sigaltstack is disabled in sighandler
# # [RUN] switched to user ctx
# # [RUN] signal USR2
# # [OK] Stack preserved
# ok 3 sigaltstack is still SS_AUTODISARM after signal
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sigaltstack: sas

Details of test log links provided [3].

> ---
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>
> Cc: linux-api@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: lkft-triage@lists.linaro.org
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Stas Sergeev <stsp@list.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: llvm@lists.linux.dev
> ---
>  .../sigaltstack/current_stack_pointer.h       | 23 +++++++++++++++++++
>  tools/testing/selftests/sigaltstack/sas.c     |  7 +-----
>  2 files changed, 24 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/sigaltstack/current_stack_pointer.h
>
> diff --git a/tools/testing/selftests/sigaltstack/current_stack_pointer.h b/tools/testing/selftests/sigaltstack/current_stack_pointer.h
> new file mode 100644
> index 000000000000..ea9bdf3a90b1
> --- /dev/null
> +++ b/tools/testing/selftests/sigaltstack/current_stack_pointer.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#if __alpha__
> +register unsigned long sp asm("$30");
> +#elif __arm__ || __aarch64__ || __csky__ || __m68k__ || __mips__ || __riscv
> +register unsigned long sp asm("sp");
> +#elif __i386__
> +register unsigned long sp asm("esp");
> +#elif __loongarch64
> +register unsigned long sp asm("$sp");
> +#elif __ppc__
> +register unsigned long sp asm("r1");
> +#elif __s390x__
> +register unsigned long sp asm("%15");
> +#elif __sh__
> +register unsigned long sp asm("r15");
> +#elif __x86_64__
> +register unsigned long sp asm("rsp");
> +#elif __XTENSA__
> +register unsigned long sp asm("a1");
> +#else
> +#error "implement current_stack_pointer equivalent"
> +#endif
> diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
> index c53b070755b6..98d37cb744fb 100644
> --- a/tools/testing/selftests/sigaltstack/sas.c
> +++ b/tools/testing/selftests/sigaltstack/sas.c
> @@ -20,6 +20,7 @@
>  #include <sys/auxv.h>
>
>  #include "../kselftest.h"
> +#include "current_stack_pointer.h"
>
>  #ifndef SS_AUTODISARM
>  #define SS_AUTODISARM  (1U << 31)
> @@ -46,12 +47,6 @@ void my_usr1(int sig, siginfo_t *si, void *u)
>         stack_t stk;
>         struct stk_data *p;
>
> -#if __s390x__
> -       register unsigned long sp asm("%15");
> -#else
> -       register unsigned long sp asm("sp");
> -#endif
> -
>         if (sp < (unsigned long)sstack ||
>                         sp >= (unsigned long)sstack + stack_size) {
>                 ksft_exit_fail_msg("SP is not on sigaltstack\n");
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog

log link:
-----
[1] https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-kselftest_20230308195933_806917-1-ndesaulniers_google_com/?failures_only=false#!?filter-tests=kselftest-sigaltstack&details=#test-results
[2] https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-kselftest_20230308195933_806917-1-ndesaulniers_google_com/testrun/15468761/suite/kselftest-sigaltstack/test/sigaltstack_sas/log
[3] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/anders/tests/2MrJ2e4bDCC4iZjIrnRqmnE7KfC


--
Linaro LKFT
https://lkft.linaro.org
