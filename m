Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8AC51975
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfFXRYi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 13:24:38 -0400
Received: from foss.arm.com ([217.140.110.172]:55346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfFXRYi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 13:24:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83073C0A;
        Mon, 24 Jun 2019 10:24:37 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63FA93F718;
        Mon, 24 Jun 2019 10:24:34 -0700 (PDT)
Date:   Mon, 24 Jun 2019 18:24:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Maurer <bmaurer@fb.com>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [RFC PATCH 1/1] Revert "rseq/selftests: arm: use udf instruction
 for RSEQ_SIG"
Message-ID: <20190624172429.GA11133@fuggles.cambridge.arm.com>
References: <20190617152304.23371-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617152304.23371-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 17, 2019 at 05:23:04PM +0200, Mathieu Desnoyers wrote:
> This reverts commit 2b845d4b4acd9422bbb668989db8dc36dfc8f438.
> 
> That commit introduces build issues for programs compiled in Thumb mode.
> Rather than try to be clever and emit a valid trap instruction on arm32,
> which requires special care about big/little endian handling on that
> architecture, just emit plain data. Data in the instruction stream is
> technically expected on arm32: this is how literal pools are
> implemented. Reverting to the prior behavior does exactly that.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Joel Fernandes <joelaf@google.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Dave Watson <davejwatson@fb.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Shuah Khan <shuah@kernel.org>
> CC: Andi Kleen <andi@firstfloor.org>
> CC: linux-kselftest@vger.kernel.org
> CC: "H . Peter Anvin" <hpa@zytor.com>
> CC: Chris Lameter <cl@linux.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Michael Kerrisk <mtk.manpages@gmail.com>
> CC: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
> CC: Paul Turner <pjt@google.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Josh Triplett <josh@joshtriplett.org>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ben Maurer <bmaurer@fb.com>
> CC: linux-api@vger.kernel.org
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Carlos O'Donell <carlos@redhat.com>
> CC: Florian Weimer <fweimer@redhat.com>
> ---
>  tools/testing/selftests/rseq/rseq-arm.h | 52 ++-------------------------------
>  1 file changed, 2 insertions(+), 50 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
> index 84f28f147fb6..5f262c54364f 100644
> --- a/tools/testing/selftests/rseq/rseq-arm.h
> +++ b/tools/testing/selftests/rseq/rseq-arm.h
> @@ -5,54 +5,7 @@
>   * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   */
>  
> -/*
> - * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
> - * value 0x5de3. This traps if user-space reaches this instruction by mistake,
> - * and the uncommon operand ensures the kernel does not move the instruction
> - * pointer to attacker-controlled code on rseq abort.
> - *
> - * The instruction pattern in the A32 instruction set is:
> - *
> - * e7f5def3    udf    #24035    ; 0x5de3
> - *
> - * This translates to the following instruction pattern in the T16 instruction
> - * set:
> - *
> - * little endian:
> - * def3        udf    #243      ; 0xf3
> - * e7f5        b.n    <7f5>
> - *
> - * pre-ARMv6 big endian code:
> - * e7f5        b.n    <7f5>
> - * def3        udf    #243      ; 0xf3
> - *
> - * ARMv6+ -mbig-endian generates mixed endianness code vs data: little-endian
> - * code and big-endian data. Ensure the RSEQ_SIG data signature matches code
> - * endianness. Prior to ARMv6, -mbig-endian generates big-endian code and data
> - * (which match), so there is no need to reverse the endianness of the data
> - * representation of the signature. However, the choice between BE32 and BE8
> - * is done by the linker, so we cannot know whether code and data endianness
> - * will be mixed before the linker is invoked.
> - */
> -
> -#define RSEQ_SIG_CODE	0xe7f5def3
> -
> -#ifndef __ASSEMBLER__
> -
> -#define RSEQ_SIG_DATA							\
> -	({								\
> -		int sig;						\
> -		asm volatile ("b 2f\n\t"				\
> -			      "1: .inst " __rseq_str(RSEQ_SIG_CODE) "\n\t" \
> -			      "2:\n\t"					\
> -			      "ldr %[sig], 1b\n\t"			\
> -			      : [sig] "=r" (sig));			\
> -		sig;							\
> -	})
> -
> -#define RSEQ_SIG	RSEQ_SIG_DATA
> -
> -#endif
> +#define RSEQ_SIG	0x53053053

I don't get why you're reverting back to this old signature value, when the
one we came up with will work well when interpreted as an instruction in the
*vast* majority of scenarios that people care about (A32/T32 little-endian).
I think you might be under-estimating just how dead things like BE32 really
are.

That said, when you ran into .inst.n/.inst.w issues, did you try something
along the lines of the WASM() macro we use in arch/arm/, which adds the ".w"
suffix when targetting Thumb?

Will
