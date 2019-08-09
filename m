Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40B287848
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 13:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfHILQj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 07:16:39 -0400
Received: from foss.arm.com ([217.140.110.172]:45834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfHILQj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 07:16:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0465E1596;
        Fri,  9 Aug 2019 04:16:38 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CEBA3F575;
        Fri,  9 Aug 2019 04:16:37 -0700 (PDT)
Date:   Fri, 9 Aug 2019 12:16:35 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 02/11] kselftest: arm64: adds first test and common
 utils
Message-ID: <20190809111635.GL10425@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-3-cristian.marussi@arm.com>
 <20278fdd-95d0-060f-088d-aba8ac2b0b01@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20278fdd-95d0-060f-088d-aba8ac2b0b01@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 09, 2019 at 11:54:06AM +0100, Cristian Marussi wrote:
> Hi
> 
> On 8/2/19 6:02 PM, Cristian Marussi wrote:
> >Added some arm64/signal specific boilerplate and utility code to help
> >further testcase development.
> >
> >A simple testcase and related helpers are also introduced in this commit:
> >mangle_pstate_invalid_compat_toggle is a simple mangle testcase which
> >messes with the ucontext_t from within the sig_handler, trying to toggle
> >PSTATE state bits to switch the system between 32bit/64bit execution state.
> >Expects SIGSEGV on test PASS.
> >
> >Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >---
> >A few fixes:
> >- test_arm64_signals.sh runner script generation has been reviewed in order to
> >   be safe against the .gitignore
> >- using kselftest.h officially provided defines for tests' return values
> >- removed SAFE_WRITE()/dump_uc()
> >- looking for si_code==SEGV_ACCERR on SEGV test cases to better understand if
> >   the sigfault had been directly triggered by Kernel
> >---
> >  tools/testing/selftests/arm64/Makefile        |   2 +-
> >  .../testing/selftests/arm64/signal/.gitignore |   6 +
> >  tools/testing/selftests/arm64/signal/Makefile |  88 ++++++
> >  tools/testing/selftests/arm64/signal/README   |  59 ++++
> >  .../arm64/signal/test_arm64_signals.src_shell |  55 ++++
> >  .../selftests/arm64/signal/test_signals.c     |  26 ++
> >  .../selftests/arm64/signal/test_signals.h     | 137 +++++++++
> >  .../arm64/signal/test_signals_utils.c         | 261 ++++++++++++++++++
> >  .../arm64/signal/test_signals_utils.h         |  13 +
> >  .../arm64/signal/testcases/.gitignore         |   1 +
> >  .../mangle_pstate_invalid_compat_toggle.c     |  25 ++
> >  .../arm64/signal/testcases/testcases.c        | 150 ++++++++++
> >  .../arm64/signal/testcases/testcases.h        |  83 ++++++
> >  13 files changed, 905 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/arm64/signal/.gitignore
> >  create mode 100644 tools/testing/selftests/arm64/signal/Makefile
> >  create mode 100644 tools/testing/selftests/arm64/signal/README
> >  create mode 100755 tools/testing/selftests/arm64/signal/test_arm64_signals.src_shell
> >  create mode 100644 tools/testing/selftests/arm64/signal/test_signals.c
> >  create mode 100644 tools/testing/selftests/arm64/signal/test_signals.h
> >  create mode 100644 tools/testing/selftests/arm64/signal/test_signals_utils.c
> >  create mode 100644 tools/testing/selftests/arm64/signal/test_signals_utils.h
> >  create mode 100644 tools/testing/selftests/arm64/signal/testcases/.gitignore
> >  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_compat_toggle.c
> >  create mode 100644 tools/testing/selftests/arm64/signal/testcases/testcases.c
> >  create mode 100644 tools/testing/selftests/arm64/signal/testcases/testcases.h
> >
> 
> A few more compilation warnings triggered by GCC-8 ONLY when compiling via the top kselftest Makefile/target
> (due to some additional -W passed down and an awkward use of snprintf on my side...)
> 
> 
> test_signals_utils.c: In function ‘feats_to_string’:
> test_signals_utils.c:38:13: warning: passing argument 1 to restrict-qualified parameter aliases with argument 4 [-Wrestrict]
>     snprintf(feats_string, MAX_FEATS_SZ - 1, "%s %s ",
>              ^~~~~~~~~~~~
> test_signals_utils.c: In function ‘default_handler’:
> test_signals_utils.c:192:19: warning: format ‘%p’ expects argument of type ‘void *’, but argument 3 has type ‘long long unsigned int’ [-Wformat=]
>     "SIG_OK -- SP:%p  si_addr@:0x%p  si_code:%d  token@:0x%p  offset:%ld\n",
>                   ~^
> 
> will be fixed in V4 as:
> 
> 
> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> index 31788a1d33a4..c0f3cd1b560a 100644
> --- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
> @@ -23,21 +23,25 @@ extern struct tdescr *current;
>  static int sig_copyctx = SIGTRAP;
>  static char *feats_store[FMAX_END] = {
> -       "SSBS",
> -       "PAN",
> -       "UAO",
> +       " SSBS ",
> +       " PAN ",
> +       " UAO ",
>  };
>  #define MAX_FEATS_SZ   128
> +static char feats_string[MAX_FEATS_SZ];
> +
>  static inline char *feats_to_string(unsigned long feats)
>  {
> -       static char feats_string[MAX_FEATS_SZ];
> +       for (int i = 0; i < FMAX_END; i++) {
> +               size_t tlen = 0;
> -       for (int i = 0; i < FMAX_END && feats_store[i][0]; i++) {
> -               if (feats & 1UL << i)
> -                       snprintf(feats_string, MAX_FEATS_SZ - 1, "%s %s ",
> -                                feats_string, feats_store[i]);
> +               if (feats & 1UL << i) {
> +                       strncat(feats_string, feats_store[i],

Should this be feats_string + tlen?

> +                               MAX_FEATS_SZ - 1 - tlen);

An assert(tlen <= MAX_FEATS_SZ - 1) is probably a good idea here,
in case more features are added to feats_store[] someday.

> +                       tlen += strlen(feats_store[i]);
> +               }

Don't we need to initialise tlen outside the loop?  Otherwise we just
zero it again after the +=.

>         }
>         return feats_string;
> @@ -190,7 +194,7 @@ static void default_handler(int signum, siginfo_t *si, void *uc)
>                 /* it's a bug in the test code when this assert fail */
>                 assert(!current->sig_trig || current->triggered);
>                 fprintf(stderr,
> -                       "SIG_OK -- SP:%p  si_addr@:0x%p  si_code:%d  token@:0x%p  offset:%ld\n",
> +                       "SIG_OK -- SP:%llX  si_addr@:0x%p  si_code:%d  token@:0x%p  offset:%ld\n",

For consistency, can we have a "0x" prefix?

I think %p usually generates a "0x" prefix by itself, so 0x%p might give
a double prefix.

[...]

Cheers
---Dave
