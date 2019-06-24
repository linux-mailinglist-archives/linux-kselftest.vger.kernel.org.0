Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA4851A5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 20:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfFXSUa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 14:20:30 -0400
Received: from mail.efficios.com ([167.114.142.138]:37680 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfFXSUa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 14:20:30 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7D86A25BCB5;
        Mon, 24 Jun 2019 14:20:27 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LxOYVrVyTkdC; Mon, 24 Jun 2019 14:20:26 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D409425BCAC;
        Mon, 24 Jun 2019 14:20:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D409425BCAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1561400426;
        bh=rbi9zyQvL7CuwR0oM9yMZGb42TU7oXvaSJgJpIyGIzY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=t+ZDVWCAIPTZVMj7diZ5pMD47aiybG+i4UZ0vTOquU6Fd33e7W4jv1HpNfQrnATaT
         VX7PnGQZzCWywDkWRUNvdXFhMup6MIfkSza/U9jfvOURJoucT/0TXHsQQ69r+Dy5uT
         YOx4YVdS3a8qm4rfJulT2xkZCyr+UgX2d99Bj80D9XrFpsY6pyBnv1/+wjydN93HIJ
         apC64MecgzQ/ysFltJOYX7DHarUuwQBsxyjK0mfOCzAWAmz/srOKpN5GgDHW3kalhL
         thonMCWNzAiEsFqn46YoBjawanZigYXVD3pQ/ipjhMicWADECDEWqxcCszn0xSK9zJ
         inCw9O5LqpHAw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id lZJq1kOXPwpc; Mon, 24 Jun 2019 14:20:26 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B12FF25BCA5;
        Mon, 24 Jun 2019 14:20:26 -0400 (EDT)
Date:   Mon, 24 Jun 2019 14:20:26 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     shuah <shuah@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>
Message-ID: <1620037196.377.1561400426591.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190624172429.GA11133@fuggles.cambridge.arm.com>
References: <20190617152304.23371-1-mathieu.desnoyers@efficios.com> <20190624172429.GA11133@fuggles.cambridge.arm.com>
Subject: Re: [RFC PATCH 1/1] Revert "rseq/selftests: arm: use udf
 instruction for RSEQ_SIG"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: Revert "rseq/selftests: arm: use udf instruction for RSEQ_SIG"
Thread-Index: /h6jdFbwANn2L9jg7/QPYpOO/noN9A==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Jun 24, 2019, at 1:24 PM, Will Deacon will.deacon@arm.com wrote:

> On Mon, Jun 17, 2019 at 05:23:04PM +0200, Mathieu Desnoyers wrote:
>> This reverts commit 2b845d4b4acd9422bbb668989db8dc36dfc8f438.
>> 
>> That commit introduces build issues for programs compiled in Thumb mode.
>> Rather than try to be clever and emit a valid trap instruction on arm32,
>> which requires special care about big/little endian handling on that
>> architecture, just emit plain data. Data in the instruction stream is
>> technically expected on arm32: this is how literal pools are
>> implemented. Reverting to the prior behavior does exactly that.
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: Joel Fernandes <joelaf@google.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Dave Watson <davejwatson@fb.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Shuah Khan <shuah@kernel.org>
>> CC: Andi Kleen <andi@firstfloor.org>
>> CC: linux-kselftest@vger.kernel.org
>> CC: "H . Peter Anvin" <hpa@zytor.com>
>> CC: Chris Lameter <cl@linux.com>
>> CC: Russell King <linux@arm.linux.org.uk>
>> CC: Michael Kerrisk <mtk.manpages@gmail.com>
>> CC: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
>> CC: Paul Turner <pjt@google.com>
>> CC: Boqun Feng <boqun.feng@gmail.com>
>> CC: Josh Triplett <josh@joshtriplett.org>
>> CC: Steven Rostedt <rostedt@goodmis.org>
>> CC: Ben Maurer <bmaurer@fb.com>
>> CC: linux-api@vger.kernel.org
>> CC: Andy Lutomirski <luto@amacapital.net>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> CC: Carlos O'Donell <carlos@redhat.com>
>> CC: Florian Weimer <fweimer@redhat.com>
>> ---
>>  tools/testing/selftests/rseq/rseq-arm.h | 52 ++-------------------------------
>>  1 file changed, 2 insertions(+), 50 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/rseq/rseq-arm.h
>> b/tools/testing/selftests/rseq/rseq-arm.h
>> index 84f28f147fb6..5f262c54364f 100644
>> --- a/tools/testing/selftests/rseq/rseq-arm.h
>> +++ b/tools/testing/selftests/rseq/rseq-arm.h
>> @@ -5,54 +5,7 @@
>>   * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>   */
>>  
>> -/*
>> - * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
>> - * value 0x5de3. This traps if user-space reaches this instruction by mistake,
>> - * and the uncommon operand ensures the kernel does not move the instruction
>> - * pointer to attacker-controlled code on rseq abort.
>> - *
>> - * The instruction pattern in the A32 instruction set is:
>> - *
>> - * e7f5def3    udf    #24035    ; 0x5de3
>> - *
>> - * This translates to the following instruction pattern in the T16 instruction
>> - * set:
>> - *
>> - * little endian:
>> - * def3        udf    #243      ; 0xf3
>> - * e7f5        b.n    <7f5>
>> - *
>> - * pre-ARMv6 big endian code:
>> - * e7f5        b.n    <7f5>
>> - * def3        udf    #243      ; 0xf3
>> - *
>> - * ARMv6+ -mbig-endian generates mixed endianness code vs data: little-endian
>> - * code and big-endian data. Ensure the RSEQ_SIG data signature matches code
>> - * endianness. Prior to ARMv6, -mbig-endian generates big-endian code and data
>> - * (which match), so there is no need to reverse the endianness of the data
>> - * representation of the signature. However, the choice between BE32 and BE8
>> - * is done by the linker, so we cannot know whether code and data endianness
>> - * will be mixed before the linker is invoked.
>> - */
>> -
>> -#define RSEQ_SIG_CODE	0xe7f5def3
>> -
>> -#ifndef __ASSEMBLER__
>> -
>> -#define RSEQ_SIG_DATA							\
>> -	({								\
>> -		int sig;						\
>> -		asm volatile ("b 2f\n\t"				\
>> -			      "1: .inst " __rseq_str(RSEQ_SIG_CODE) "\n\t" \
>> -			      "2:\n\t"					\
>> -			      "ldr %[sig], 1b\n\t"			\
>> -			      : [sig] "=r" (sig));			\
>> -		sig;							\
>> -	})
>> -
>> -#define RSEQ_SIG	RSEQ_SIG_DATA
>> -
>> -#endif
>> +#define RSEQ_SIG	0x53053053
> 
> I don't get why you're reverting back to this old signature value, when the
> one we came up with will work well when interpreted as an instruction in the
> *vast* majority of scenarios that people care about (A32/T32 little-endian).
> I think you might be under-estimating just how dead things like BE32 really
> are.

My issue is that the current .instr approach is broken for programs or functions
built in Thumb mode, and I received no feedback on the solutions I proposed for
those issues, which led me to propose a patch reverting to a simple .word.

> 
> That said, when you ran into .inst.n/.inst.w issues, did you try something
> along the lines of the WASM() macro we use in arch/arm/, which adds the ".w"
> suffix when targetting Thumb?

AFAIU, the WASM macros depend on CONFIG_THUMB2_KERNEL, which may be fine within
the kernel, but for user-space things are a bit more complex.

A compile-unit can be compiled as thumb, which will set a compiler define
which we could use to detect thumb mode. However, unfortunately, a single
function can also be compiled with an attribute selecting thumb mode, which
AFAIU does not influence the preprocessor defines.

If we had the equivalent of pushsection and popsection for "arm" mode vs "thumb"
mode in asm, it would solve all our issues, but the only way I found to do
something equivalent was to use the size of a no-op in a asm conditional
to restore the previous state.

Any other ideas on how to handle this ?

Thanks,

Mathieu


> 
> Will

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
