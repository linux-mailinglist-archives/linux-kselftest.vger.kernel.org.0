Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCFAEA4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2019 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391992AbfIJMZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 08:25:39 -0400
Received: from foss.arm.com ([217.140.110.172]:34250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfIJMZi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 08:25:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21E2C1000;
        Tue, 10 Sep 2019 05:25:38 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E5D3F59C;
        Tue, 10 Sep 2019 05:25:37 -0700 (PDT)
Subject: Re: [PATCH v5 00/11] Add arm64/signal initial kselftest support
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190904114722.GQ27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <74165b2e-eb4c-994f-20ca-b69f71f3f5bc@arm.com>
Date:   Tue, 10 Sep 2019 13:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904114722.GQ27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/09/2019 12:47, Dave Martin wrote:
> On Mon, Sep 02, 2019 at 12:29:21pm +0100, Cristian Marussi wrote:
>> Hi
>>
>> this patchset aims to add the initial arch-specific arm64 support to
>> kselftest starting with signals-related test-cases.
>> A common internal test-case layout is proposed which then it is anyway
>> wired-up to the toplevel kselftest Makefile, so that it should be possible
>> at the end to run it on an arm64 target in the usual way with KSFT.
> 
> BTW, it's helpful to state the base branch / commit as clearly as
> possible near the top of the cover letter, say,
> 
> --8<--
> 
> This series is based on arm64/for-next/core [1]
> commit 9ce1263033cd ("selftests, arm64: add a selftest for passing tagged pointers to kernel")
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> 
> -->8--
> 
> This is particularly important if you expect the maintainer to pick up
> the patches.
> 
> You don't need to reference a specific commit unless there's a
> significant chance of conflicts if the wrong commit is used, but it can
> help provide a clue as to why you're basing on this alternate branch.
> 

Ok, thanks I'll do.

>> ~/linux# make TARGETS=arm64 kselftest
>>
>> New KSFT arm64 testcases live inside tools/testing/selftests/arm64 grouped by
>> family inside subdirectories: arm64/signal is the first family proposed with
>> this series.
>> This series converts also to this subdirectory scheme the pre-existing
>> (already queued on arm64/for-next/core) KSFT arm64 tags tests, moving them
>> into arm64/tags.
>>
>> Thanks
>>
>> Cristian
>>
>>
>> Notes:
>> -----
>> - further details in the included READMEs
>>
>> - more tests still to be written (current strategy is going through the related
>>   Kernel signal-handling code and write a test for each possible and sensible code-path)
>>   A few ideas for more TODO testcases:
>> 	- fake_sigreturn_unmapped_sp: SP into unmapped addrs
>> 	- fake_sigreturn_kernelspace_sp: SP into kernel addrs
>> 	- fake_sigreturn_sve_bad_extra_context: SVE extra context badly formed
>> 	- mangle_sve_invalid_extra_context: SVE extra_context invalid
>>
>> - SVE signal testcases and special handling will be part of an additional patch
>>   still to be released
> 
> What's your approach to checking that the test failure paths work?
> 
> We could either hack the kernel or the tests to provoke "fake" failures,
> and I don't think it's necessary to test everything in this way,
> providing we have confidence that the test strategy and framework works
> in general.
> 

So my approach to testing the tests itself has been as follows:

- PASS path: instrumented Kernel itself to print the exact line where the SEGV
  is supposed to be called and manually check once for all (just redone now).
  Something like:

# FAKE_SIGRETURN_MISALIGNED_SP :: Triggers a sigreturn with a misaligned sigframe
Registered handlers for all signals.
Detected MINSTKSIGSZ:9984
Testcase initialized.
uc context validated.
GOOD CONTEXT grabbed from sig_copyctx handler
Handled SIG_COPYCTX
Calling sigreturn with fake sigframe sized:4688 at SP @FFFFCAAE5253
[  188.206911] Kernel SEGV @ 571                                                   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
SIG_OK -- SP:0xFFFFCAAE5253  si_addr@:0xffffcaae5253  si_code:2  token@:0xffffcaae5253  offset:0
==>> completed. PASS(1)


- FAIL path: tried at first the same approach (instrument to avoid the SEGV), but thinking that
  this could have led to general Kernel instability while processing bad sigframes,
  I instead instrumented tests and utils as follows:

  - mangle_ TESTS:

    + removed the "mangling" for each test, and observed test FAIL (NO SEGV)

# MANGLE_PSTATE_INVALID_MODE_EL1h :: Mangling uc_mcontext INVALID MODE EL1h
Registered handlers for all signals.
Detected MINSTKSIGSZ:9984
Testcase initialized.
uc context validated.
Handled SIG_TRIG
==>> completed. FAIL(0)

    + SSBS: being this a peculiar mangle_ test, where we check that SSBS is PRESERVED as it is
      on Kernel restoring sigframe (no expected SEGV), I used a kernel patched to NOT preserve
      the SSBS bit (so clearing it). Moreover I experimented with the various SSBS support levels
      (no_supp/SSBS_BIT/MRS+SSBS_BIT) and observed how test behaved related to the detected SSBS support

    + verify that an anomalous SEGV (no SEGV_ACCER) is detected (say a *(* int)0x00= inside handler)

# MANGLE_PSTATE_INVALID_DAIF_BITS :: Mangling uc_mcontext with INVALID DAIF_BITS
Registered handlers for all signals.
Detected MINSTKSIGSZ:9984
Testcase initialized.
uc context validated.
SIG_OK -- SP:0xFFFFFBE96DA0  si_addr@:(nil)  si_code:1  token@:(nil)  offset:0
si_code != SEGV_ACCERR...test is probably broken!  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- RX UNEXPECTED SIGNAL: 6
==>> completed. FAIL(0)


  - fake_sigreturn_ TESTS:

    + verify placing on the stack the good context grabbed from get_current_context() as it is
      (GOOD), execution flow is anomalously restored inside get_current_context() and such 
      anomaly is spotted (without deadly loops)

# FAKE_SIGRETURN_BAD_MAGIC :: Trigger a sigreturn with a sigframe with a bad magic
Registered handlers for all signals.
Detected MINSTKSIGSZ:9984
Testcase initialized.
uc context validated.
GOOD CONTEXT grabbed from sig_copyctx handler
Handled SIG_COPYCTX
Calling sigreturn with fake sigframe sized:4688 at SP @FFFFCAC61F80
Unexpected successful sigreturn detected: live_uc is stale !        <<<<<<<<<<<<<<<<<<<<<<<<<<<
==>> completed. FAIL(0)

    + verify that an early SEGV is detected as anomalous (say a *(* int)0x00 before fake sigframe
      has been placed on the stack)

# FAKE_SIGRETURN_BAD_MAGIC :: Trigger a sigreturn with a sigframe with a bad magic
Registered handlers for all signals.
Detected MINSTKSIGSZ:9984
Testcase initialized.
uc context validated.
GOOD CONTEXT grabbed from sig_copyctx handler
Handled SIG_COPYCTX
Available space:3552
Using badly built context - ERR: BAD MAGIC !
Calling sigreturn with fake sigframe sized:4688 at SP @FFFFE77C96D0
SIG_OK -- SP:0xFFFFE77C96D0  si_addr@:(nil)  si_code:1  token@:(nil)  offset:0
current->token ZEROED...test is probably broken!   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- RX UNEXPECTED SIGNAL: 6
==>> completed. FAIL(0)


> [...]
> 
> Cheers
> ---Dave
> 

Cheers

Cristian

