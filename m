Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E837A5A499
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2019 20:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF1Sx4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jun 2019 14:53:56 -0400
Received: from foss.arm.com ([217.140.110.172]:53980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfF1Sxz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jun 2019 14:53:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A64632B;
        Fri, 28 Jun 2019 11:53:53 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCC483F718;
        Fri, 28 Jun 2019 11:53:52 -0700 (PDT)
Subject: Re: [PATCH 02/13] kselftest: arm64: adds arm64/signal support code
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-3-cristian.marussi@arm.com>
 <20190621103510.GJ2790@e103592.cambridge.arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <a9bc6ef2-8f5e-f74e-d96b-c51a0d399a4a@arm.com>
Date:   Fri, 28 Jun 2019 19:53:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621103510.GJ2790@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

Thanks for the review Dave

On 21/06/2019 11:35, Dave Martin wrote:
> On Thu, Jun 13, 2019 at 12:13:24PM +0100, Cristian Marussi wrote:
>> Added some arm64/signal specific boilerplate and utility code to help
>> further testcase development. Still no test case code included though.
> 
> There is a lot of code here, doing a variety of different things.
> 
> It may be more digestible if the common code is added in pieces,
> starting with whatever is needed for the simplest testcase, then adding
> that testcase, then extending the common code for the next case, and so
> on.
> 
> This would make it easier to see why each bit of common code is being
> added, and how it gets used.
> 
> I'll try to review as-is for now, but it might be worth splitting this
> patch up a bit when reposting.

I'll split support code to smaller chunks committed together with the
test cases using them.

> 
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>  tools/testing/selftests/arm64/Makefile        |   2 +-
>>  .../testing/selftests/arm64/signal/.gitignore |   5 +
>>  tools/testing/selftests/arm64/signal/Makefile |  86 ++++++
>>  tools/testing/selftests/arm64/signal/README   |  56 ++++
>>  .../testing/selftests/arm64/signal/signals.S  |  64 +++++
>>  .../arm64/signal/test_arm64_signals.sh        |  44 +++
>>  .../selftests/arm64/signal/test_signals.c     |  30 ++
>>  .../selftests/arm64/signal/test_signals.h     | 136 ++++++++++
>>  .../arm64/signal/test_signals_utils.c         | 256 ++++++++++++++++++
>>  .../arm64/signal/test_signals_utils.h         | 110 ++++++++
>>  .../arm64/signal/testcases/testcases.c        | 123 +++++++++
>>  .../arm64/signal/testcases/testcases.h        |  85 ++++++
>>  12 files changed, 996 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/arm64/signal/.gitignore
>>  create mode 100644 tools/testing/selftests/arm64/signal/Makefile
>>  create mode 100644 tools/testing/selftests/arm64/signal/README
>>  create mode 100644 tools/testing/selftests/arm64/signal/signals.S
>>  create mode 100755 tools/testing/selftests/arm64/signal/test_arm64_signals.sh
>>  create mode 100644 tools/testing/selftests/arm64/signal/test_signals.c
>>  create mode 100644 tools/testing/selftests/arm64/signal/test_signals.h
>>  create mode 100644 tools/testing/selftests/arm64/signal/test_signals_utils.c
>>  create mode 100644 tools/testing/selftests/arm64/signal/test_signals_utils.h
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/testcases.c
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/testcases.h
>>
>> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
>> index 03a0d4f71218..af59dc74e0dc 100644
>> --- a/tools/testing/selftests/arm64/Makefile
>> +++ b/tools/testing/selftests/arm64/Makefile
>> @@ -6,7 +6,7 @@ ARCH ?= $(shell uname -m)
>>  ARCH := $(shell echo $(ARCH) | sed -e s/aarch64/arm64/)
>>  
>>  ifeq ("x$(ARCH)", "xarm64")
>> -SUBDIRS :=
>> +SUBDIRS := signal
>>  else
>>  SUBDIRS :=
>>  endif
>> diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
>> new file mode 100644
>> index 000000000000..7234ebd99363
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/.gitignore
>> @@ -0,0 +1,5 @@
>> +# Helper script's internal testcases list (TPROGS) is regenerated
>> +# each time by Makefile on standalone (non KSFT driven) runs.
>> +# Committing such list creates a dependency between testcases
>> +# patches such that they are no more easily revertable. Just ignore.
>> +test_arm64_signals.sh
>> diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
>> new file mode 100644
>> index 000000000000..9518841124a3
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/Makefile
>> @@ -0,0 +1,86 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2019 ARM Limited
>> +
>> +# Supports also standalone invokation out of KSFT-tree.
>> +#
>> +# Build standalone with (issued from within the dir containing this makefile):
>> +#
>> +# 	host:~$ make clean && make INSTALL_PATH=<your-device-instdir> install
> 
> Minor nit: why clean?
just (bad) habit...not needed in fact

> Minor nit: this won't work if run from ~.  Maybe just say "$" for the
> prompt.
True, and  I think I'll stick to the syntax used by KSFT doces using -C <dir>
like invocation from linux/ topdir like in:

$ make -C tools/testing/selftests/arm64/signal INSTALL_PATH= install

(moreover I spotted a tricky bug in the test_arm64_signal.sh script which I'll fix)

> 
>> +#
>> +# Run standalone on device with:
>> +# 	device:~# <your-device-instdir>/test_arm64_signals.sh [-k|-v]
> 
> Minor nit: do these tests actually need to run as root?  If not (and for
> the above reasons) you could again just say "$".

root not really needed for arm64/signal, I'll fix.

> 
>> +#
>> +
>> +# A proper top_srcdir is needed both by KSFT(lib.mk)
>> +# and standalone builds
>> +top_srcdir = ../../../../..
>> +
>> +CFLAGS += -std=gnu99 -I. -I$(top_srcdir)/tools/testing/selftests/
>> +SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
>> +PROGS := $(patsubst %.c,%,$(SRCS))
>> +
>> +# Guessing as best as we can where the Kernel headers
>> +# could have been installed depending on ENV config and
>> +# type of invocation.
>> +ifeq ($(KBUILD_OUTPUT),)
>> +khdr_dir = $(top_srcdir)/usr/include
>> +else
>> +ifeq (0,$(MAKELEVEL))
>> +khdr_dir = $(KBUILD_OUTPUT)/usr/include
>> +else
>> +# the KSFT preferred location when KBUILD_OUTPUT is set
>> +khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
>> +endif
>> +endif
>> +
>> +CFLAGS += -I$(khdr_dir)
>> +
>> +# Standalone run
>> +ifeq (0,$(MAKELEVEL))
>> +CC := $(CROSS_COMPILE)gcc
>> +RUNNER = test_arm64_signals.sh
>> +INSTALL_PATH ?= install/
>> +
>> +all: $(RUNNER)
>> +
>> +$(RUNNER): $(PROGS)
>> +	sed -i -e 's#PROGS=.*#PROGS="$(PROGS)"#' $@
>> +
>> +install: all
>> +	mkdir -p $(INSTALL_PATH)/testcases
>> +	cp $(PROGS) $(INSTALL_PATH)/testcases
>> +	cp $(RUNNER) $(INSTALL_PATH)/
>> +
>> +.PHONY clean:
>> +	rm -f $(PROGS)
>> +# KSFT run
>> +else
>> +# Generated binaries to be installed by top KSFT script
>> +TEST_GEN_PROGS := $(notdir $(PROGS))
>> +
>> +# Get Kernel headers installed and use them.
>> +KSFT_KHDR_INSTALL := 1
>> +
>> +# This include mk will also mangle the TEST_GEN_PROGS list
>> +# to account for any OUTPUT target-dirs optionally provided
>> +# by the toplevel makefile
>> +include ../../lib.mk
>> +
>> +$(TEST_GEN_PROGS): $(PROGS)
>> +	-mkdir -p $(OUTPUT)
>> +	-cp $(PROGS) $(OUTPUT)/
> 
> Why doesn't it matter if these fail?
> 
> (Maybe this was pasted from other kselftest Makefiles...)

Unfortunately I think the evil comes from me, an ancient iteration of the patch
where standalone and KSFT-integrated run were not splitted (nor working fully),
so a bit of unclean machinery was needed to cope with non existent OUTPUT
(anyway I was using mkdir -p so -mkdir was unneeded anyway...). OUTPUT dir is
now properly created and propagated by upper layer Makefiles so no need to mkdir
anything nor to ignore -cp. I'll cleanup.

> 
>> +
>> +clean:
>> +	$(CLEAN)
>> +	rm -f $(PROGS)
>> +endif
>> +
>> +# Common test-unit targets to build common-layout test-cases executables
>> +# Needs secondary expansion to properly include the testcase c-file in pre-reqs
>> +.SECONDEXPANSION:
>> +$(PROGS): test_signals.c test_signals_utils.c signals.S testcases/testcases.c $$@.c test_signals.h test_signals_utils.h testcases/testcases.h
>> +	@if [ ! -d $(khdr_dir) ]; then \
>> +		echo -n "\n!!! WARNING: $(khdr_dir) NOT FOUND."; \
>> +		echo "===>  Are you sure Kernel Headers have been installed properly ?\n"; \
>> +	fi
>> +	$(CC) $(CFLAGS) $^ -o $@
>> diff --git a/tools/testing/selftests/arm64/signal/README b/tools/testing/selftests/arm64/signal/README
>> new file mode 100644
>> index 000000000000..315d77558e14
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/README
>> @@ -0,0 +1,56 @@
>> +KSelfTest arm64/signal/
>> +=======================
>> +
>> +Signals Tests
>> ++++++++++++++
>> +
>> +- Tests are built around a common main compilation unit: such shared main
>> +  enforces a standard sequence of operations needed to perform a single
>> +  signal-test (setup/trigger/run/result/cleanup)
>> +
>> +- The above mentioned ops are configurable on a test-by-test basis: each test
>> +  is described (and configured) using the descriptor signals.h::struct tdescr
>> +
>> +- Each signal testcase is compiled into its own executable: a separate
>> +  executable is used for each test since many tests complete successfully
>> +  by receiving some kind of 'Term' signal from the Kernel, so it's safer
> 
> Nit: to avoid confusion with SIGTERM, maybe say "some fatal signal"
> instead of 'Term' (although I can see what you mean).

Right, I was trying to avoid confusion following man pages signal(7) terminology
for signal dispositions, but in fact it is far worse using Term here :D

> 
>> +  to run each test unit in its own standalone process, so as to start each
>> +  test from a clean-slate.
> 
> Pedantic nit: "-" -> " "
> 
Ok

>> +
>> +- New tests can be simply defined in testcases/ dir providing a proper struct
>> +  tdescr overriding all the defaults we wish to change (as of now providing a
>> +  custom run method is mandatory though)
>> +
>> +- Signals' test-cases hereafter defined belong currently to two
>> +  principal families:
>> +
>> +  - 'mangle_' tests: a real signal (SIGUSR1) is raised and used as a trigger
>> +    and then the test case code messes-up with the sigframe ucontext_t from
>> +    inside the sighandler itself.
>> +
>> +  - 'fake_sigreturn_' tests: a brand new custom artificial sigframe structure
>> +    is placed on the stack and a sigreturn syscall is called to simulate a
>> +    real signal return. This kind of tests does not use a trigger usually and
>> +    they are just fired using some simple included assembly trampoline code.
>> +
>> + - Most of these tests are successfully passing if the process gets killed by
>> +   some 'Term' signal: usually SIGSEGV or SIGBUS. Since, while writing this
> 
> Nit: "some fatal signal"
> 
Ok

>> +   kind of tests, it is extremely easy in fact to end-up injecting other
>> +   unrelated SEGV bugs in the testcases, it becomes extremely tricky to
> 
> For tests that receive a fatal signal on success, is it always the same
> signal?

No and in fact it is configured in tdescr.sig_ok which signal the test case
expects on success (if the acse)

> 
> I'm wondering whether we can filter expected from unexpected signals
> using siginfo.  For a bad sigreturn for example, I'd expect si_addr to
> point to (or at least somewhere within) the signal frame.
> 
> Maybe it's not that simple, though.

This was my main concern in fact. At the end I double checked and verified all
the here proposed test cases instrumenting the Kernel and seeing that in fact
the test case was segfaulting from Kernel at the expected line (o_O) ... but
this is clearly a poor approach for future tests...I would have like to have at
least a check that ensures the crash come from the Kernel space inside the
signal code.

For this reason at first I added the token field into tdescr, where I now save
the SP used/calculated by fake_sigreturn ....my idea was
 to verify that once SEGV was hit, the test case handler could have verified
this current->token saved-SP-value against the value hold in siginfo.si_addr,
since, once the evil happens inside the kernel (and so the test is successful),
Kernel calls:

arm64_notify_segfault(regs->sp)

with regs->sp finally put inside si_addr if you follow the call-chain.

Unfortunately in my tests I always found si_addr displaced from the saved SP by
a few kbytes in my tests so I doubted this was a feasible approach and I instead
reverted to the following best-effort strategy (as I tried poorly to explain in
the README):

- at first I provided a couple of sanity macros ASSERT_GOOD/BAD_CONTEXT() which
are supposed to check that at least the pre-requisite for the tests, in terms of
built sigframe, are fine.

- then:

  + since I could NOT verify strictly the SEGV location was coming from Kernel
(as above said), and also considering the fact that even if I could, I won't be
ever able to track down the fault to the exact location in kernel code (as I
manually did instrumenting with lovely printfs), and so I could not be
automatically sure that what the testcase was effectively testing was what was
meant to test

  + I decided to at least try to ensure that the crash happened after
fake_sigreturn was issued...so reducing the uncertainty. I found this really
useful while developing tests in order to quickly rule-out trivial SEGV coming
from test code running well before the fake_sigreturn.

  In order to do this:

  1. as a last step in fake_sigreturn, just before calling sigreturn via SVC I
save the used SP into current->token (which is norMa

  2. in the SEGV handler, unless current->sanity_disabled was set in the tdescr
config (set for mangle_ tests which do not use fake_sigreturn), I make sure that
the token field is NOT ZERO...which means at least I arrived so far into
fake_sigreturn and so I can reasonably assume fake_sigreturn was called

default_handler() while handling sig_ok (usually SEGV) signal
-------------------------------------------------------------
if (!current->sanity_disabled) {
	fprintf(stderr,
                "SIG_OK -- si_addr@:0x%p  token@:0x%p\n",
                 si->si_addr, current->token);
        assert(current->token);
}

 with the assertion meant to cause an unexpected SIGABORT which warns the
test-developer which something odd is happening and the test is flawed.

This approach is definitely a best effort, but if you could suggest some more
strict and reliable test on si_addr value, I'm happy to review this thing.

> 
>> +   be really sure that the tests are really addressing what they are meant
>> +   to address and they are not instead falling apart due to unplanned bugs.
>> +   In order to alleviate the misery of the life of such test-developer, a few
>> +   helpers are provided:
>> +
>> +   - a couple of ASSERT_BAD/GOOD_CONTEXT() macros to easily parse a ucontext_t
>> +     and verify if it is indeed GOOD or BAD (depending on what we were
>> +     expecting), using the same logic/perspective as in the arm64 Kernel signals
>> +     routines.
>> +
>> +   - a sanity mechanism to be used in 'fake_sigreturn_'-alike tests: enabled by
>> +     default it takes care to verify that the test-execution had at least
>> +     successfully progressed upto the stage of triggering the fake sigreturn
> 
> Pedantic nit: "upto" -> "up to"
> 

Ok

>> +     call.
>> +
>> +  In both cases test results are expected in terms of some 'Term' signal sent
> 
> Nit: "some fatal signal"?

Ok

> 
>> +  by the Kernel to the test process, or analyzing some final regs state.
> 
> In general, putting comments nearer to the functions makes for easier
> reviewing, and makes it easier to keep the documentation in sync when
> the code changes. 
> 
> Since you've written this documentation, we may as well keep it, though.

Ok, I'll relocate or duplicate code-related and very specific comments into the
codebase.

> 
>> diff --git a/tools/testing/selftests/arm64/signal/signals.S b/tools/testing/selftests/arm64/signal/signals.S
>> new file mode 100644
>> index 000000000000..4f510b3a3b4b
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/signals.S
>> @@ -0,0 +1,64 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0
>> + * Copyright (C) 2019 ARM Limited
>> + */
>> +
>> +#include <asm/unistd.h>.
>> +
>> +.section	.rodata
> 
> This also needs to be marked allocatable (, "a")
> 
> You can also just say
> 
> 	.rodata
> 
> which gives you the sane default attributes for this section.

I remember a compilation error while trying to use .rodata straight away, that's
the reason I reverted to used section...

..yep...

/opt/toolchains/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc
-std=gnu99 -I. -I../../../../../tools/testing/selftests/
-I/home/crimar01/ARM/dev/src/pdsw/out_linux/usr/include test_signals.c
test_signals_utils.c signals.S testcases/testcases.c
testcases/fake_sigreturn_bad_size.c test_signals.h test_signals_utils.h
testcases/testcases.h -o testcases/fake_sigreturn_bad_size
signals.S: Assembler messages:
signals.S:8: Error: unknown pseudo-op: `.rodata'

and I remember now  a post from 2012 saying that the assembler could be too
old....but I don't think so .... so I went for .section

in fact grepping for .rodata in arch/arm64 I can find a .rodata without section
directive only in the linker script for vdso (arch/arm64/kernel/vdso/vdso.lds.S)

any thoughts ? what I'm getting wrong ?

> 
>> +call_fmt:
>> +	.asciz "Calling sigreturn with fake sigframe sized:%zd at calculated SP @%08lX\n"
>> +
>> +.text
>> +
>> +.extern current
> 
> This is harmless, but people usually don't bother with .extern.  It
> doesn't do anything IIUC.
> 

ah, ok.

>> +
>> +.globl fake_sigreturn
>> +
>> +/*	fake_sigreturn	x0:&sigframe  x1:sigframe_size  x2:alignment_SP */
>> +fake_sigreturn:
>> +	stp x20, x21, [sp, #-16]!
>> +	stp x22, x23, [sp, #-16]!
> 
> Nit:
> <tab> <mnemonic> <tab> [<operands> separated by ", " ...]
> 
Messed again...sorry.

> If this function doesn't return, does it need to save anything at all?
> 

Good point
>> +
>> +	mov x20, x0
>> +	mov x21, x1
>> +	mov x22, x2
>> +	mov x23, sp
>> +
>> +	/* create space on the stack for fake sigframe..."x22"-aligned */
>> +	mov x0, #0
>> +	add x0, x21, x22
>> +	sub x22, x22, #1
>> +	bic x0, x0, x22
>> +	sub x23, x23, x0
>> +
>> +	ldr x0, =call_fmt
>> +	mov x1, x21
>> +	mov x2, x23
>> +	bl printf
>> +
>> +	mov sp, x23
>> +
>> +	/* now fill it with the provided content... */
>> +	mov x0, sp
>> +	mov x1, x20
>> +	mov x2, x21
>> +	bl memcpy
>> +
>> +	/*
>> +	 * Here saving a last minute SP to current->token acts as a marker:
>> +	 * if we got here, we are successfully faking a sigreturn; in other
>> +	 * words we are reasonably sure no bad Term signal has been raised
>> +	 * till now for unrelated reasons, so we should consider the possibly
>> +	 * observed SEGV coming from Kernel restore_sigframe() and triggered
>> +	 * as expected from our test-case.
>> +	 * For simplicity field 'token' is laid out as first in struct tdescr
>> +	 */
>> +	ldr x0, current
> 
> Nit: this assumes that current is 

ok

>> +	str x23, [x0, #0]
> 
> What's this for?  Doesn't this overwrite the first bytes of siginfo or
> something?
> 

This is the step which I write the value of SP (cached also in x23) into the
first field of tdescr (which is the first at offset 0 for simplicity) for the
current test so in fact is equivalent to:

current->token = SP;

and it is part of the mechanism I described above to try to catch spurios SEGV

> Nit: The ", #0" is also redundant here.

ok
> 
>> +	/* SP is already pointing back to the just built fake sigframe here */
>> +	mov x8, #__NR_rt_sigreturn
>> +	svc #0
>> +
>> +	/* This should not return here...looping lead to a timeout */
>> +	b .
> 
> Could we also return here, rather than relying on a timeout?  This
> function strictly doesn't return when it succeeds, so this would provide
> an immediate indication of failure.
> 
> Maybe it's not worth it though, since some kinds of failure might lead
> to corruption or jumping to a random location -- which might only be
> detectable via a timeout in any case.

Good point...I'll have a thought about the opportunity of a return...
> 
>> diff --git a/tools/testing/selftests/arm64/signal/test_arm64_signals.sh b/tools/testing/selftests/arm64/signal/test_arm64_signals.sh
>> new file mode 100755
>> index 000000000000..ecaa5a67d3ca
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/test_arm64_signals.sh
>> @@ -0,0 +1,44 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2019 ARM Limited
>> +
>> +ret=0
>> +keep_on_fail=0
>> +err_out="2> /dev/null"
>> +
>> +# avoiding getopt
> 
> It doesn't matter, but do we need to avoid getopt?
> 
>> +while [ $# -gt 0 ]
>> +do
>> +	case $1 in
>> +		"-k")
>> +			keep_on_fail=1
>> +			shift
>> +			;;
>> +		"-v")
>> +			err_out=""
> 
> Or just
> 
> 	err_out=
> 
>> +			shift
>> +			;;
>> +		*)
>> +			shift
> 
> Could you move the shift out of the switch here?  Each case seems to end
> with it.

Ok I'll do
> 
>> +			;;
>> +	esac
>> +done
>> +
>> +TPROGS=
>> +
>> +i=0
>> +tot=$(echo $TPROGS | wc -w)
>> +
>> +for test in $TPROGS
>> +do
>> +	eval ./$test $err_out
>> +	if [ $? != 0 ]; then
>> +		[ $keep_on_fail = 0 ] && echo "===>>> FAILED:: $test <<<===" && ret=1 && break
>> +	else
>> +		i=$((i + 1))
>> +	fi
>> +done
>> +
>> +echo "==>> PASSED: $i/$tot"
>> +
>> +exit $ret
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
>> new file mode 100644
>> index 000000000000..afadb8ae33e4
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/test_signals.c
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <stddef.h>
> 
> ^ Are any of these needed?  I don't see direct use of any libc stuff in
> this file...
>

I'll verify and cleanup

>> +
>> +#include <kselftest.h>
>> +
>> +#include "test_signals.h"
>> +#include "test_signals_utils.h"
>> +
>> +struct tdescr *current;
>> +extern struct tdescr tde;
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	current = &tde;
>> +
>> +	ksft_print_msg("%s :: %s - SIG_TRIG:%d  SIG_OK:%d -- current:%p\n",
>> +		       current->name, current->descr, current->sig_trig,
>> +		       current->sig_ok, current);
>> +	if (test_setup(current)) {
>> +		if (test_run(current))
>> +			test_result(current);
>> +		test_cleanup(current);
>> +	}
>> +
>> +	return !current->pass;
>> +}
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
>> new file mode 100644
>> index 000000000000..49536326db04
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/test_signals.h
>> @@ -0,0 +1,136 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
>> +#ifndef __TEST_SIGNALS_H__
>> +#define __TEST_SIGNALS_H__
>> +
>> +#include <assert.h>
>> +#include <stdbool.h>
>> +#include <signal.h>
>> +#include <ucontext.h>
>> +#include <stdint.h>
>> +
>> +/*
>> + * Using ARCH specific and sanitized Kernel headers installed by KSFT
>> + * framework since we asked for it by setting flag KSFT_KHDR_INSTALL
>> + * in our Makefile.
>> + */
>> +#include <asm/ptrace.h>
>> +#include <asm/hwcap.h>
>> +
>> +/* pasted from include/linux/stringify.h */
>> +#define __stringify_1(x...)	#x
>> +#define __stringify(x...)	__stringify_1(x)
>> +
>> +#define FEAT_SSBS		(1 << 0)
>> +#define FEAT_PAN		(1 << 1)
>> +#define FEAT_UAO		(1 << 2)
> 
> ^ Comment to say what these are?
> 

Ok


>> +
>> + /*
>> +  * Reads a sysreg using the, possibly provided, S3_ encoding in order to
>> +  * avoid inject any dependency on the used toolchain regarding possibly
>> +  * still unsupported ARMv8 extensions.
>> +  *
>> +  * Using a standard mnemonic here to indicate the specific sysreg (like SSBS)
>> +  * would introduce a compile-time dependency on possibly unsupported ARMv8
>> +  * Extensions: you could end-up failing to build the test depending on the
>> +  * available toolchain.
>> +  * This is undesirable since some tests, even if specifically targeted at some
>> +  * ARMv8 Extensions, can be plausibly run even on hardware lacking the above
>> +  * optional ARM features. (SSBS bit preservation is an example: Kernel handles
>> +  * it transparently not caring at all about the effective set of supported
>> +  * features).
>> +  * On the other side we will expect to observe different behaviours if the
>> +  * feature is supported or not: usually getting a SIGILL when trying to use
>> +  * unsupported features. For this reason we have anyway in place some
>> +  * preliminary run-time checks about the cpu effectively supported features.
>> +  *
>> +  * This helper macro is meant to be used for regs readable at EL0, BUT some
>> +  * EL1 sysregs are indeed readable too through MRS emulation Kernel-mechanism
>> +  * if the required reg is included in the supported encoding space:
>> +  *
>> +  *  Documentation/arm64/cpu-feature-regsiters.txt
>> +  *
>> +  *  "The infrastructure emulates only the following system register space:
>> +  *   	Op0=3, Op1=0, CRn=0, CRm=0,4,5,6,7
>> +  */
>> +#define get_regval(regname, out) \
>> +	asm volatile("mrs %0, " __stringify(regname) : "=r" (out) :: "memory")
>> +
>> +/* Regs encoding and masks naming copied in from sysreg.h */
>> +#define SYS_ID_AA64MMFR1_EL1	S3_0_C0_C7_1	/* MRS Emulated */
>> +#define SYS_ID_AA64MMFR2_EL1	S3_0_C0_C7_2	/* MRS Emulated */
>> +#define ID_AA64MMFR1_PAN_SHIFT	20
>> +#define ID_AA64MMFR2_UAO_SHIFT	4
>> +
>> +/* Local Helpers */
>> +#define IS_PAN_SUPPORTED(val) \
>> +	(!!((val) & (0xf << ID_AA64MMFR1_PAN_SHIFT)))
>> +#define IS_UAO_SUPPORTED(val) \
>> +	(!!((val) & (0xf << ID_AA64MMFR2_UAO_SHIFT)))
> 
> These should probably be 0xfUL.  The ID regs are 64-bit, so a
> shift >= 28 would cause things to go wrong here.
> 

Missed that. Thanks
>> +
>> +#define MRS_SSBS_SYSREG		S3_3_C4_C2_6	/* EL0 supported */
>> +#define MRS_SSBS_BIT		(1 << 12)
>> +
>> +/*
>> + * A descriptor used to describe and configure a test case.
>> + * Fields with a non-trivial meaning are described inline in the following.
>> + */
>> +struct tdescr {
>> +	/* KEEP THIS FIELD FIRST for easier lookup from assembly */
>> +	void		*token;
>> +	/* when disabled token based sanity checking is skipped in handler */
>> +	bool		sanity_disabled;
>> +	/* just a name for the test-case; manadatory field */
>> +	char		*name;
>> +	char		*descr;
>> +	unsigned long	feats_required;
>> +	/* bitmask of effectively supported feats: populated at run-time */
>> +	unsigned long	feats_supported;
>> +	bool		feats_ok;
>> +	bool		initialized;
>> +	unsigned int	minsigstksz;
>> +	/* signum used as a test trigger. Zero if no trigger-signal is used */
>> +	int		sig_trig;
>> +	/*
>> +	 * signum considered as a successfull test completion.
> 
> successful

ok

> 
>> +	 * Zero when no signal is expected on success
>> +	 */
>> +	int		sig_ok;
> 
> Could this be bool, or is it a signal number if nonzero?

No this holds the expected signal on a successfull test (SIGSEGV/SIGBUS...)
> 
>> +	/* signum expected on unsupported CPU features. */
>> +	int		sig_unsupp;
>> +	/*
>> +	 * used to grab a sigcontext from a signal handler
>> +	 * automatically set to SIGUSR2 if not configured
>> +	 */
>> +	int		sig_copyctx;
> 
> Is there any reason for this to be customisable?

It is changeable, because on test init I take care to verify I'm not using a
SIGUSR? which clashes with some other thing...like the configured sig_trig, not
sure if the user should be allowed to configure it explicitly as it is now.
> 
>> +	/* a timeout in second for test completion *
>> +	unsigned int	timeout;
>> +	bool		triggered;
>> +	unsigned int	handled;
> 
> bool, or otherwise what does the value for handled mean?

This counts the times I hit the sig_ok...since I used to exit the program
straight away once it counts than 1...to avoid infinite SEGV loops...but now is
unused and I'll remove

> 
>> +	bool		pass;
>> +	/* optional sa_flags for the installed handler */
>> +	int		sa_flags;
>> +	ucontext_t	saved_uc;
>> +	/* used by copy_ctx */
>> +	ucontext_t	*live_uc;
>> +	size_t		live_sz;
>> +
>> +	/* a setup function to be called before test starts */
>> +	int (*setup)(struct tdescr *td);
>> +	int (*cleanup)(struct tdescr *td);
>> +
>> +	/* an optional function to be used as a trigger for test starting */
>> +	int (*trigger)(struct tdescr *td);
>> +	/*
>> +	 * the actual test-core: invoked differently depending on the
>> +	 * presence of the trigger function above; this is mandatory
>> +	 */
>> +	int (*run)(struct tdescr *td, siginfo_t *si, ucontext_t *uc);
>> +
>> +	/* an optional function for custom results' processing */
>> +	int (*check_result)(struct tdescr *td);
>> +
>> +	void *priv;
>> +};
>> +#endif
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
>> new file mode 100644
>> index 000000000000..c00ba355dc1b
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
>> @@ -0,0 +1,256 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <signal.h>
>> +#include <unistd.h>
>> +#include <assert.h>
>> +#include <sys/auxv.h>
>> +#include <linux/auxvec.h>
>> +
>> +#include "test_signals.h"
>> +#include "test_signals_utils.h"
>> +#include "testcases/testcases.h"
>> +
>> +extern struct tdescr *current;
>> +
>> +void dump_uc(const char *prefix, ucontext_t *uc, int filter)
> 
> Should probably #include <ucontext.h> for this, even if we're getting
> it via some other header.

Fine. This is for possible debug usage though, it was used and it could be used
to debug the tests, but it is currently not used....so I wonder if I should just
remove it.
> 
>> +{
>> +	int i;
>> +
>> +	if (prefix)
>> +		fprintf(stderr, "%s", prefix);
>> +	if (filter & DUMP_REGS)
>> +		for (i = 0; i < 29; i++)
>> +			fprintf(stderr, "x%02d:%016llX\n",
>> +				i, uc->uc_mcontext.regs[i]);
>> +	if (filter & DUMP_FP)
>> +		fprintf(stderr, "x%02d(fp):%016llX\n",
>> +			i, uc->uc_mcontext.regs[i]);
>> +	i++;
>> +	if (filter & DUMP_LR)
>> +		fprintf(stderr, "x%02d(lr):%016llX\n",
>> +			i, uc->uc_mcontext.regs[i]);
>> +	if (filter & DUMP_SP)
>> +		fprintf(stderr, "sp:%016llX\n", uc->uc_mcontext.sp);
>> +	if (filter & DUMP_PC)
>> +		fprintf(stderr, "pc:%016llX\n", uc->uc_mcontext.pc);
>> +	if (filter & DUMP_PSTATE)
>> +		fprintf(stderr, "pstate:%016llX\n", uc->uc_mcontext.pstate);
>> +	if (filter & DUMP_FAULT)
>> +		fprintf(stderr, "fault_address:%016llX\n",
>> +			uc->uc_mcontext.fault_address);
>> +}
>> +
>> +static void unblock_signal(int signum)
>> +{
>> +	sigset_t sset;
>> +
>> +	sigemptyset(&sset);
>> +	sigaddset(&sset, signum);
>> +	sigprocmask(SIG_UNBLOCK, &sset, NULL);
>> +}
>> +
>> +static int default_result(struct tdescr *td, int force_exit);
> 
> Can we move default_result() here to avoid this forward declaration?

Ok
> 
>> +
>> +static void default_handler(int signum, siginfo_t *si, void *uc)
>> +{
>> +	if (signum == current->sig_trig) {
>> +		SAFE_WRITE(2, "Handling SIG_TRIG\n");
>> +		current->triggered = 1;
>> +		/* ->run was asserted NON-NULL in test_setup() already */
>> +		current->run(current, si, uc);
>> +	} else if (signum == SIGILL && !current->initialized) {
>> +		/*
>> +		 * A SIGILL here while still not initialized means we fail
>> +		 * to even asses the existence of feature
>> +		 */
>> +		SAFE_WRITE(1, "Marking UNSUPPORTED features.\n");
>> +	} else if (current->sig_ok && signum == current->sig_ok) {
>> +		/* it's a bug in the test code when this assert fail */
>> +		assert(!current->sig_trig || current->triggered);
>> +		if (!current->sanity_disabled) {
>> +			fprintf(stderr,
>> +				"SIG_OK -- si_addr@:0x%p  token@:0x%p\n",
>> +				si->si_addr, current->token);
>> +			assert(current->token);
>> +		}
>> +		SAFE_WRITE(2, "Handling SIG_OK\n");
>> +		current->pass = 1;
>> +		current->handled++;
>> +		/*
>> +		 * Some tests can lead to SEGV loops: in such a case we want
>> +		 * to terminate immediately exiting straight away
>> +		 */
>> +		default_result(current, 1);
>> +	} else if (current->sig_copyctx && signum == current->sig_copyctx) {
>> +		memcpy(current->live_uc, uc, current->live_sz);
>> +		ASSERT_GOOD_CONTEXT(current->live_uc);
>> +		SAFE_WRITE(2,
>> +			   "GOOD CONTEXT grabbed from sig_copyctx handler\n");
>> +	} else {
>> +		if (signum == current->sig_unsupp && !current->feats_ok) {
>> +			SAFE_WRITE(2, "-- RX SIG_UNSUPP on unsupported feature...OK\n");
>> +			current->pass = 1;
>> +		} else if (signum == SIGALRM && current->timeout) {
>> +			SAFE_WRITE(2, "-- Timeout !\n");
>> +		} else {
>> +			SAFE_WRITE(2, "-- UNEXPECTED SIGNAL\n");
>> +		}
>> +		default_result(current, 1);
>> +	}
>> +}
>> +
>> +static int default_setup(struct tdescr *td)
>> +{
>> +	struct sigaction sa;
>> +
>> +	sa.sa_sigaction = default_handler;
>> +	sa.sa_flags = SA_SIGINFO;
>> +	if (td->sa_flags)
>> +		sa.sa_flags |= td->sa_flags;
>> +	sigemptyset(&sa.sa_mask);
>> +	/* uncatchable signals naturally skipped ... */
>> +	for (int sig = 1; sig < 32; sig++)
>> +		sigaction(sig, &sa, NULL);
>> +	/*
>> +	 * RT Signals default disposition is Term but they cannot be
>> +	 * generated by the Kernel in response to our tests; so just catch
>> +	 * them all and report them as UNEXPECTED signals.
>> +	 */
>> +	for (int sig = SIGRTMIN; sig <= SIGRTMAX; sig++)
>> +		sigaction(sig, &sa, NULL);
>> +
>> +	/* just in case...unblock explicitly all we need */
>> +	if (td->sig_trig)
>> +		unblock_signal(td->sig_trig);
>> +	if (td->sig_ok)
>> +		unblock_signal(td->sig_ok);
>> +	if (td->sig_unsupp)
>> +		unblock_signal(td->sig_unsupp);
>> +
>> +	if (td->timeout) {
>> +		unblock_signal(SIGALRM);
>> +		alarm(td->timeout);
>> +	}
>> +	fprintf(stderr, "Registered handlers for all signals.\n");
>> +
>> +	return 1;
>> +}
>> +
>> +static inline int default_trigger(struct tdescr *td)
>> +{
>> +	return !raise(td->sig_trig);
>> +}
>> +
>> +static int default_result(struct tdescr *td, int force_exit)
>> +{
>> +	if (td->pass)
>> +		SAFE_WRITE(2, "==>> completed. PASS(1)\n");
>> +	else
>> +		SAFE_WRITE(1, "==>> completed. FAIL(0)\n");
>> +	if (!force_exit)
>> +		return td->pass;
>> +	else
>> +		exit(td->pass ? EXIT_SUCCESS : EXIT_FAILURE);
>> +}
>> +
>> +static int test_init(struct tdescr *td)
>> +{
>> +	td->minsigstksz = getauxval(AT_MINSIGSTKSZ);
>> +	if (!td->minsigstksz)
>> +		td->minsigstksz = MINSIGSTKSZ;
>> +	fprintf(stderr, "Detected MINSTKSIGSZ:%d\n", td->minsigstksz);
>> +
>> +	if (td->feats_required) {
>> +		td->feats_supported = 0;
>> +		/*
>> +		 * Checking for CPU required features using both the
>> +		 * auxval and the arm64 MRS Emulation to read sysregs.
>> +		 */
>> +		if (getauxval(AT_HWCAP) & HWCAP_CPUID) {
>> +			uint64_t val = 0;
>> +
>> +			if (td->feats_required & FEAT_SSBS) {
>> +				if (getauxval(AT_HWCAP) & HWCAP_SSBS)
>> +					td->feats_supported |= FEAT_SSBS;
>> +			}
>> +			if (td->feats_required & FEAT_PAN) {
>> +				get_regval(SYS_ID_AA64MMFR1_EL1, val);
>> +				if (IS_PAN_SUPPORTED(val))
>> +					td->feats_supported |= FEAT_PAN;
>> +			}
>> +			if (td->feats_required & FEAT_UAO) {
>> +				get_regval(SYS_ID_AA64MMFR2_EL1 , val);
>> +				if (IS_UAO_SUPPORTED(val))
>> +					td->feats_supported |= FEAT_UAO;
>> +			}
>> +		} else {
>> +			fprintf(stderr,
>> +				"CPUID regs NOT available. Marking features unsupported\n");
>> +		}
>> +		td->feats_ok = td->feats_required == td->feats_supported;
>> +		fprintf(stderr, "Required Features %08lX are %ssupported\n",
>> +		       td->feats_required, !td->feats_ok ? "NOT " : "");
>> +	}
>> +
>> +	if (!td->sig_copyctx) {
>> +		if (td->sig_trig != SIGUSR2)
>> +			td->sig_copyctx = SIGUSR2;
>> +		else if (td->sig_trig != SIGUSR1)
>> +			td->sig_copyctx = SIGUSR1;
>> +		else
>> +			td->sig_copyctx = 0;
>> +	}
>> +
>> +	if (td->sig_copyctx)
>> +		unblock_signal(td->sig_copyctx);
>> +
>> +	td->initialized = 1;
>> +	return 1;
>> +}
>> +
>> +int test_setup(struct tdescr *td)
>> +{
>> +	/* assert core invariants symptom of a rotten testcase */
>> +	assert(current);
>> +	assert(td);
>> +	assert(td->name);
>> +	assert(td->run);
>> +
>> +	if (!test_init(td))
>> +		return 0;
>> +
>> +	if (td->setup)
>> +		return td->setup(td);
>> +	else
>> +		return default_setup(td);
>> +}
>> +
>> +int test_run(struct tdescr *td)
>> +{
>> +	if (td->sig_trig) {
>> +		if (td->trigger)
>> +			return td->trigger(td);
>> +		else
>> +			return default_trigger(td);
>> +	} else {
>> +		return td->run(td, NULL, NULL);
>> +	}
>> +}
>> +
>> +int test_result(struct tdescr *td)
>> +{
>> +	if (td->check_result)
>> +		td->check_result(td);
>> +	return default_result(td, 0);
>> +}
>> +
>> +int test_cleanup(struct tdescr *td)
>> +{
>> +	if (td->cleanup)
>> +		return td->cleanup(td);
>> +	else
>> +		return 1;
>> +}
> 
> Do we use the return value of either of these functions?  Should we?

Some of them are used for sure, I'll check if it really needed for all in this
moment.

> 
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> new file mode 100644
>> index 000000000000..e7ebae8e8077
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
>> @@ -0,0 +1,110 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
>> +#ifndef __TEST_SIGNALS_UTILS_H__
>> +#define __TEST_SIGNALS_UTILS_H__
>> +#include <stdio.h>
>> +#include <signal.h>
>> +#include <unistd.h>
>> +#include <ucontext.h>
>> +#include <string.h>
>> +
>> +#include <asm/unistd.h>
>> +
>> +#include "test_signals.h"
>> +
>> +#define DUMP_REGS	(1 << 0)
>> +#define DUMP_FP		(1 << 1)
>> +#define DUMP_LR		(1 << 2)
>> +#define DUMP_SP		(1 << 3)
>> +#define DUMP_PC		(1 << 4)
>> +#define DUMP_PSTATE	(1 << 5)
>> +#define DUMP_FAULT	(1 << 6)
>> +#define DUMP_ALL	0xffffffff
>> +
>> +/* Using a signal-safe function to write something out */
>> +#define SAFE_WRITE(fd, str) \
>> +	do { \
>> +		int bytes = 0; \
>> +		bytes = write((fd), (str) + bytes, sizeof(str) - bytes); \
>> +		if (bytes < 0 || bytes == sizeof(str)) \
>> +			break; \
> 
> In the interest of readability, consider lining up the \ here.  Doesn't
> matter that much though.
> 
> Also: won't we write the start of the string repeatedly here?  bytes is
> never updated AFAICT.
You're right it will work only if INTR once. bytes += at least.

> 
>> +	} while(1)
> 
> For block-like macros, I tend to write
> 
> #define FOO(bar) do {	\
> 	/* ... */	\
> } while (0)
> 
> to save a line and reduce indentation.  This is a matter of style though.

Ok good to know
> 
> 
> Finally, does this need to be a macro?
> 
> To avoid surprises, we could use strlen() for the string length.  If the
> compiler is smart enough and the function is inlined, then strlen("foo")
> can be evaluated at compile time... but anyway, we are going to make
> syscalls, so the cost of an out-of-line strlen() is not a big deal.
> 

Ok I'll review completely the approach and the need to these best-effort debug
messages sent in the signal handlers...

>> +
>> +/* Be careful this helper is NOT signal-safe */
>> +void dump_uc(const char *prefix, ucontext_t *uc, int filter);
>> +
>> +int test_setup(struct tdescr *td);
>> +int test_cleanup(struct tdescr *td);
>> +int test_run(struct tdescr *td);
>> +int test_result(struct tdescr *td);
>> +int fake_sigreturn(void *sigframe, size_t sz, int alignment);
>> +
>> +/*
>> + * Obtaining a valid and full-blown ucontext_t from userspace is tricky:
>> + * libc getcontext does() not save all the regs and messes with some of
>> + * them (pstate value in particular is not reliable).
>> + * Here we use a service signal to grab the ucontext_t from inside a
>> + * dedicated signal handler, since there, it is populated by Kernel
>> + * itself in setup_sigframe(). The grabbed context is then stored and
>> + * made available in td->live_uc.
>> + *
>> + * Anyway this function really serves a dual purpose:
>> + *
>> + * 1. grab a valid sigcontext into td->live_uc for result analysis: in
>> + * such case it returns 1.
>> + *
>> + * 2. detect if somehow a previously grabbed live_uc context has been
>> + * used actively with a sigreturn: in such a case the execution would have
>> + * magically resumed in the middle of the function itself (seen_already==1):
>> + * in such a case return 0, since in fact we have not just simply grabbed
>> + * the context.
>> + *
>> + * This latter case is useful to detect when a fake_sigreturn test-case has
>> + * unexpectedly survived without hittig a SEGV.
>> + */
>> +static inline __attribute__((always_inline))
>> +int get_current_context(struct tdescr *td, ucontext_t *uc)
>> +{
>> +	static volatile int seen_already;
> 
> If there could be multiple users of this in the same program, it may
> make sense to make seen_already part of td.

Same program means same test though, so I'm not sure it would serve the same
fucntionality...I have ot think about it.

> 
> Strictly speaking, this should be sig_atomic_t, not int (I think
> volatile int can't be torn into multiple accesses on any reasonable
> arch, but it depends which toolchain folks you talk to...)

ah...this was unexpected...
> 
>> +
>> +	if (!td || !td->sig_copyctx || !uc) {
>> +		SAFE_WRITE(1, "Signal-based Context dumping NOT available\n");
>> +		return 0;
>> +	}
>> +
>> +	/* it's a genuine invokation..reinit */
>> +	seen_already = 0;
>> +	td->live_uc = uc;
>> +	td->live_sz = sizeof(*uc);
>> +	memset(td->live_uc, 0x00, td->live_sz);
> 
> Is this required?  It is just here to help sanity-check whether live_uc
> is populatd with real data?
Yes it is a safe net, I'll review if it is really needed.

> 
>> +	/*
>> +	 * Grab ucontext_t triggering a signal...
>> +	 * ASM equivalent of raise(td->sig_copyctx);
>> +	 */
>> +	asm volatile ("mov x8, %0\n\t"
>> +		      "svc #0\n\t"
>> +		      "mov x1, %1\n\t"
>> +		      "mov x8, %2\n\t"
>> +		      "svc #0" :
> 
> Nit: for readability, it's usual to put the : only at the start of lines
> when writing an asm on multiple lines.

ok
> 
>> +		      : "r" (__NR_getpid),
>> +		        "r" (td->sig_copyctx),
>> +			"r" (__NR_kill)
> 
> For the __NR_foo constants, you can use "i" to avoid wasting a register.
> 
>> +		      : "memory");
> 
> You need clobbers for x1 and x8, and also x0 (for the svc return value).
> 
> How does the compiler know that live_uc may be modified by this asm?
It does not in fact....
> 
>> +
>> +	/*
>> +	 * If we get here with seen_already==1 it implies the td->live_uc
>> +	 * context has been used to get back here....this probably means
>> +	 * a test has failed to cause a SEGV...anyway the live_uc has not
>> +	 * just been acquired...so return 0
>> +	 */
>> +	if (seen_already) {
>> +		SAFE_WRITE(1, "....and we're back....seen_already !\n");
> 
> Can we make this message more self-explanatory?
> 
> Say "Can't populate already-populated ucontext" or somethine like that?

ok...it is on the failpath, but I suppose is better to explain why is this jump
back considered symptom of failure.

> 
>> +		return 0;
>> +	}
>> +	seen_already = 1;
>> +
>> +	return 1;
> 
> Do we have a way to detect that live_uc really was populated?  I think
> that if sig_copyctx was blocked or handled inappropriately due to a bug
> elsewhere in the program, we could just fall through here and assume
> that td->live_uc contains valid data.
> 
> If we have a flag in td to indicate that live_uc was populated, we may
> be able to use it for this.

good point...it's similar to the token usage to grab suprios SEGV conditions, if
they're exclusive I could reuse token...maybe with a better naming...

> 
>> +}
>> +
>> +#endif
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
>> new file mode 100644
>> index 000000000000..9f83f3517325
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
>> @@ -0,0 +1,123 @@
>> +#include "testcases.h"
> 
> Should <asm/sigcontext.h> be included for the arm64 sigcontext types
> here?

It is in included testcases.h in fact:

#ifndef __TESTCASES_H__
#define __TESTCASES_H__

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <ucontext.h>

#include <asm/sigcontext.h>

> 
>> +
>> +struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
>> +				size_t resv_sz, size_t *offset)
>> +{
>> +	size_t offs = 0;
>> +
>> +	while (head && head->magic != magic && offs < resv_sz - HDR_SZ) {
> 
> Could resv_sz be < HDR_SZ?
> 
> Should head ever be NULL?

probably not..overly defensive
> 
>> +		offs += head->size;
>> +		head = GET_RESV_NEXT_HEAD(head);
>> +	}
>> +	if (!head || head->magic != magic)
>> +		return NULL;
>> +	else if (offset)
>> +		*offset = offs;
> 
> This could be probably be simplified a little by returning from inside
> the while loop when the match is found.  It works either way, though.

ok

> 
>> +
>> +	return head;
>> +}
>> +
>> +bool validate_extra_context(struct extra_context *extra, char **err)
>> +{
>> +	struct _aarch64_ctx *term;
>> +
>> +	if (!extra || !err)
>> +		return false;
>> +
>> +	fprintf(stderr, "Validating EXTRA...\n");
>> +	term = GET_RESV_NEXT_HEAD(extra);
>> +	if (!term || term->magic || term->size) {
>> +		SET_CTX_ERR("UN-Terminated EXTRA context");
>> +		return false;
>> +	}
>> +	if (extra->datap & ~0x10UL)
>> +		SET_CTX_ERR("Extra DATAP misaligned");
> 
> Did you mean & ~0xfUL?

yes...I'll fix.
> 
> Alternatively, datap % 0x10 == 0.
> 
> 
>> +	else if (extra->size & ~0x10UL)
>> +		SET_CTX_ERR("Extra SIZE misaligned");
> 
> Similarly.
> 
>> +	else if (extra->datap != (uint64_t)term + sizeof(*term))
>> +		SET_CTX_ERR("Extra DATAP broken");
> 
> Make this more informative?  Broken how?
> 

ok

>> +	if (*err)
>> +		return false;
>> +
>> +	fprintf(stderr, "GOOD EXTRA CONTEXT FOUND !\n");
> 
> Maybe we don't need to print anything on success here.
> 

In fact is debug in stderr, but KSFT main runner does not throw away stderr in
fact (like my standalone script)..so it pollutes the output a bit...

>> +
>> +	return true;
>> +}
>> +
>> +bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
>> +{
>> +	bool terminated = false;
>> +	size_t offs = 0;
>> +	int flags = 0;
>> +	struct extra_context *extra = NULL;
>> +	struct _aarch64_ctx *head =
>> +		(struct _aarch64_ctx *)uc->uc_mcontext.__reserved;
>> +
>> +	if (!err)
>> +		return false;
>> +	/* Walk till the end terminator verifying __reserved contents */
>> +	while (head && !terminated && offs < resv_sz) {
>> +		if ((uint64_t)head & 0x0fUL) {
>> +			SET_CTX_ERR("Misaligned HEAD");
>> +			return false;
>> +		}
>> +
>> +		switch (head->magic) {
>> +			case 0:
>> +				if (head->size)
>> +					SET_CTX_ERR("Bad size for MAGIC0");
> 
> I suggest just assigning *err rather than hiding this assignment in a
> macro, otherwise it's not clear that err (let alone *err) is touched
> by this.

ok


> 
>> +				else
>> +					terminated = true;
>> +				break;
>> +			case FPSIMD_MAGIC:
>> +				if (flags & FPSIMD_CTX)
>> +					SET_CTX_ERR("Multiple FPSIMD");
>> +				else if (head->size !=
>> +					 sizeof(struct fpsimd_context))
>> +					SET_CTX_ERR("Bad size for FPSIMD context");
> 
> Can we use the names from sigcontext.h?
> 
> (Like "fpsimd_context" or FPSIMD_MAGIC?)

> 
> For the null record at the end, I have tended to write "terminator
> record" in the past.

ok

> 
>> +				flags |= FPSIMD_CTX;
>> +				break;
>> +			case ESR_MAGIC:
>> +				if (head->size != sizeof(struct esr_context))
>> +					SET_CTX_ERR("Bad size for ESR context");
>> +				break;
>> +			case SVE_MAGIC:
>> +				if (flags & SVE_CTX)
>> +					SET_CTX_ERR("Multiple SVE");
>> +				else if (head->size !=
>> +					 sizeof(struct sve_context))
>> +					SET_CTX_ERR("Bad size for SVE context");
>> +				flags |= SVE_CTX;
>> +				break;
>> +			case EXTRA_MAGIC:
>> +				if (flags & EXTRA_CTX)
>> +					SET_CTX_ERR("Multiple EXTRA");
>> +				else if (head->size !=
>> +					 sizeof(struct extra_context))
>> +					SET_CTX_ERR("Bad size for EXTRA context");
>> +				flags |= EXTRA_CTX;
>> +				extra = (struct extra_context *)head;
>> +				break;
>> +			default:
>> +				SET_CTX_ERR("Unknown MAGIC !");
> 
> This probably shouldn't be an error.  If we hit this, it may mean that
> the kernel is newer than the kselftest build, but we can go ahead and
> test the records that we understand.

Ah, yes true. I should log clearly though that we are missing something, and I
should verify that size if fine and there is a properly chained context or a
terminator in such a case.
> 
>> +				break;
>> +		}
>> +
>> +		if (*err)
>> +			return false;
> 
> We should do some sanity-checks on size here: for forward progress
> guarantees it should be >= sizeof(*head).  To avoid ending up
> misaligned, it should also be a multiple of 16.

ok

> 
>> +
>> +		offs += head->size;
>> +		if (resv_sz - offs < sizeof(*head)) {
>> +			SET_CTX_ERR("Broken HEAD");
> 
> Maybe describe this an an overrun rather than a corrupt header.
ok

> 
>> +			return false;
>> +		}
>> +
>> +		if (flags & EXTRA_CTX)
>> +			if (!validate_extra_context(extra, err))
>> +				return false;
>> +
>> +		head = GET_RESV_NEXT_HEAD(head);
>> +	}
>> +
>> +	return true;
>> +}
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
>> new file mode 100644
>> index 000000000000..4f704c1501aa
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
>> @@ -0,0 +1,85 @@
>> +#ifndef __TESTCASES_H__
>> +#define __TESTCASES_H__
>> +
>> +#include <stdio.h>
>> +#include <stdint.h>
>> +#include <stdbool.h>
>> +#include <unistd.h>
>> +#include <ucontext.h>
>> +
>> +#include <asm/sigcontext.h>
>> +
> 
> Add a comment to explain what these are?

ok
> 
>> +#define FPSIMD_CTX	(1 << 0)
>> +#define SVE_CTX		(1 << 1)
>> +#define EXTRA_CTX	(1 << 2)
>> +
>> +#define HDR_SZ \
>> +	sizeof(struct _aarch64_ctx)
>> +
>> +#define GET_SF_RESV_HEAD(sf) \
>> +	(struct _aarch64_ctx *)(&sf.uc.uc_mcontext.__reserved)
> 
> ((struct _aarch64_ctx *)&(sf).uc.uc_mcontext.__reserved)
> 
ok

>> +
>> +#define GET_SF_RESV_SIZE(sf) \
>> +	sizeof(sf.uc.uc_mcontext.__reserved)
> 
> (sf)
> 
>> +
>> +#define GET_UCP_RESV_SIZE(ucp) \
>> +	sizeof(((ucontext_t *)ucp)->uc_mcontext.__reserved)
> 
> (ucp)
> 
> Ideally, lose the cast and require ucp to be the correct type.
> Otherwise, the caller could pass any random type without the compiler
> complaining here.

yes good point
> 
>> +
>> +#define ASSERT_BAD_CONTEXT(uc) \
>> +	do { \
>> +		char *err = NULL; \
>> +		assert(!validate_reserved((uc), GET_UCP_RESV_SIZE((uc)), &err)); \
>> +		if (err) \
>> +			fprintf(stderr, "Using badly built context - ERR: %s\n", err);\
>> +	} while(0)
> 
> Using err implicitly may be confusing and make the code harder to
> maintain.  Pass it in as an argument?

ok


> 
>> +
>> +#define ASSERT_GOOD_CONTEXT(uc) \
>> +	do { \
>> +		char *err = NULL; \
>> +		if (!validate_reserved((uc), GET_UCP_RESV_SIZE((uc)), &err)) { \
>> +			if (err) \
>> +				fprintf(stderr, "Detected BAD context - ERR: %s\n", err);\
>> +			assert(0); \
>> +		} else { \
>> +			fprintf(stderr, "uc context validated.\n"); \
>> +		} \
>> +	} while(0)
>> +
>> +/* head->size accounts both for payload and header _aarch64_ctx size ! */
>> +#define GET_RESV_NEXT_HEAD(h) \
>> +	(struct _aarch64_ctx *)((uint8_t *)(h) + (h)->size)
> 
> Pedantic nit: maybe use (char *) here.  The C standard is explicit about
> the magic properties of character types, including sizeof(char) == 1.
> 
> We "know" that uint8_t the same as unsigned char, but superficially this
> is just "whatever unsigned integer type is 8 bits in size".

ok

> 
>> +
>> +#define SET_CTX_ERR(str) \
>> +	do { \
>> +		if (err) \
>> +			*err = str; \
>> +	} while(0)
>> +
>> +struct a_sigframe {
> 
> Maybe fake_sigframe would be a better name?  It depends on how you use
> this type, though.

Well yes, in fact it is a regular frame, it will be the content and the usage
which will be fake....not the structure itself.

> 
>> +	siginfo_t	info;
>> +	ucontext_t	uc;
>> +};
>> +
>> +
>> +bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err);
>> +
>> +bool validate_extra_context(struct extra_context *extra, char **err);
>> +
>> +struct _aarch64_ctx *get_header(struct _aarch64_ctx *head, uint32_t magic,
>> +				size_t resv_sz, size_t *offset);
>> +
>> +static inline struct _aarch64_ctx *get_terminator(struct _aarch64_ctx *head,
>> +						  size_t resv_sz,
>> +						  size_t *offset)
>> +{
>> +	return get_header(head, 0, resv_sz, offset);
>> +}
>> +
>> +static inline void write_terminator(struct _aarch64_ctx *tail)
>> +{
>> +	if (tail) {
>> +		tail->magic = 0;
>> +		tail->size = 0;
>> +	}
>> +}
>> +#endif
>> -- 
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

