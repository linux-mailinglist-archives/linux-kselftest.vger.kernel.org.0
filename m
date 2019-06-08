Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011633A08A
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfFHPwv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jun 2019 11:52:51 -0400
Received: from mail.efficios.com ([167.114.142.138]:34554 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfFHPwv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jun 2019 11:52:51 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C034F1D3995;
        Sat,  8 Jun 2019 11:52:46 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id RDGBH0FwZAY9; Sat,  8 Jun 2019 11:52:46 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4028F1D3990;
        Sat,  8 Jun 2019 11:52:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4028F1D3990
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560009166;
        bh=1zYPEOa390T+4ygk6CtXUOuek0d/tel39qFmVv01juo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nmY+u3lkKGhd4/aQFS9wb3Y9ZomWqTVuBO+UzEIHuF3VVQ9HR2N5MffthLUcypuV+
         O4SVrRQd/kc70mezBkUXbFa9I3mSAb5PLmTO1H7GsFmohcsfB3XBPzgVCHK9VJp4Vy
         4iOSurbuqnJOn0IH8VkH0nKd+bUdguycBTHWmt6zllSHXlnJPj/BBk5LBhCdwwGkqn
         KDBiczy+fKgFc585bxrqFDOSZADWJYtIA+fxGZbcCFo4xXIBh2Qn2kRMasmv6L0PuC
         IUDil25QL5GgHV2GKmiZffrGBIdbNvQWadJtePVf6Em4CFXxniKH03lOBVXtlcWU/R
         eNk74JO39IXtA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id v03xN4kWi2lL; Sat,  8 Jun 2019 11:52:46 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 1D44F1D3986;
        Sat,  8 Jun 2019 11:52:46 -0400 (EDT)
Date:   Sat, 8 Jun 2019 11:52:45 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>,
        Russell King <linux@arm.linux.org.uk>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>, shuah <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <716499178.40175.1560009165920.JavaMail.zimbra@efficios.com>
In-Reply-To: <1975020343.35751.1559844149532.JavaMail.zimbra@efficios.com>
References: <20190429152803.7719-9-mathieu.desnoyers@efficios.com> <20190503193858.9676-1-mathieu.desnoyers@efficios.com> <1975020343.35751.1559844149532.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH v2 for 5.2 08/12] rseq/selftests: arm: use udf
 instruction for RSEQ_SIG
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: arm: use udf instruction for RSEQ_SIG
Thread-Index: YcGezvm7ivFdjjSZdlA+YYoxUnlhzUxULrHf
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Jun 6, 2019, at 8:02 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On May 3, 2019, at 3:38 PM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> Use udf as the guard instruction for the restartable sequence abort
>> handler.
>> 
>> Previously, the chosen signature was not a valid instruction, based
>> on the assumption that it could always sit in a literal pool. However,
>> there are compilation environments in which literal pools are not
>> available, for instance execute-only code. Therefore, we need to
>> choose a signature value that is also a valid instruction.
>> 
>> Handle compiling with -mbig-endian on ARMv6+, which generates binaries
>> with mixed code vs data endianness (little endian code, big endian
>> data).
>> 
>> Else mismatch between code endianness for the generated signatures and
>> data endianness for the RSEQ_SIG parameter passed to the rseq
>> registration will trigger application segmentation faults when the
>> kernel try to abort rseq critical sections.
>> 
>> Prior to ARMv6, -mbig-endian generates big-endian code and data, so
>> endianness should not be reversed in that case.
> 
> And of course it cannot be that easy. This breaks when building in
> thumb mode (-mthumb). Output from librseq arm32 build [1] (code similar
> to what is found in the rseq selftests):
> 
>  CC       rseq.lo
> /tmp/ccu6Jw1b.s: Assembler messages:
> /tmp/ccu6Jw1b.s:297: Error: cannot determine Thumb instruction size. Use
> .inst.n/.inst.w instead
> /tmp/ccu6Jw1b.s:490: Error: cannot determine Thumb instruction size. Use
> .inst.n/.inst.w instead
> Makefile:460: recipe for target 'rseq.lo' failed
> 
> This appears to be caused by a missing .arm directive in RSEQ_SIG_DATA.
> Fixing with:
> 
> -               asm volatile ("b 2f\n\t"                                \
> +               asm volatile (".arm\n\t"                                \
> +                             "b 2f\n\t"                                \
> 
> gets the build to go further, but breaks at:
> 
>  CC       basic_percpu_ops_test.o
> /tmp/ccpHOMHZ.s: Assembler messages:
> /tmp/ccpHOMHZ.s:148: Error: misaligned branch destination
> /tmp/ccpHOMHZ.s:956: Error: misaligned branch destination
> Makefile:378: recipe for target 'basic_percpu_ops_test.o' failed
> 
> I suspect it's caused by the change from:
> 
> -               ".word " __rseq_str(RSEQ_SIG) "\n\t"                    \
> 
> to
> 
> +               ".arm\n\t"                                              \
> +               ".inst " __rseq_str(RSEQ_SIG_CODE) "\n\t"               \
> 
> which changes the mode from thumb to arm for the rest of the
> inline asm within __RSEQ_ASM_DEFINE_ABORT. Better yet, there appears
> to be no way to save the arm/thumb state and restore it afterwards.
> 
> I'm really starting to wonder if we should go our of our way to try
> to get this signature to be a valid instruction on arm32. Perhaps
> we should consider going back to use ".word" on arm32 so it ensures
> it uses data endianness (which matches the parameter received by the
> sys_rseq system call), let objdump and friends print it as a literal
> pool (which it is), and just choose an instruction which has little
> chances to appear for the cases we care about between ARM32 BE, LE
> and THUMB. Perhaps a 32-bit palindrome ? Bonus points if this is a
> trap instruction in common configurations for odd-cases-debugging
> purposes.

So I'm not particularly proud of the result, but I found a rather
ugly way to figure out if we are currently in thumb mode within an
inline asm, and restore that mode: test the length of a nop
instruction with a ".if" asm statement.

Do we want to go for this kind of approach, or should we revert
back to a ".word" and accept that the rseq signature before the
abort handler will be seen as data rather than an instruction
on arm32 ?

Is there a better way to do this ?

Thanks,

Mathieu

diff --git a/include/rseq/rseq-arm.h b/include/rseq/rseq-arm.h
index 1ce9231..b6c36dd 100644
--- a/include/rseq/rseq-arm.h
+++ b/include/rseq/rseq-arm.h
@@ -43,7 +43,14 @@
        ({                                                              \
                int sig;                                                \
                asm volatile ("b 2f\n\t"                                \
+                             "3:\n\t"                                  \
+                             "nop\n\t"                                 \
+                             "4:\n\t"                                  \
+                             ".arm\n\t"                                \
                              "1: .inst " __rseq_str(RSEQ_SIG_CODE) "\n\t" \
+                             ".if ((4b - 3b) == 2)\n\t"                \
+                             ".thumb\n\t"                              \
+                             ".endif\n\t"                              \
                              "2:\n\t"                                  \
                              "ldr %[sig], 1b\n\t"                      \
                              : [sig] "=r" (sig));                      \
@@ -125,8 +132,14 @@ do {                                                                       \
                __rseq_str(table_label) ":\n\t"                         \
                ".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
                ".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
+               "333:\n\t"                                              \
+               "nop\n\t"                                               \
+               "444:\n\t"                                              \
                ".arm\n\t"                                              \
                ".inst " __rseq_str(RSEQ_SIG_CODE) "\n\t"               \
+               ".if ((444b - 333b) == 2)\n\t"                          \
+               ".thumb\n\t"                                            \
+               ".endif\n\t"                                            \
                __rseq_str(label) ":\n\t"                               \
                teardown                                                \
                "b %l[" __rseq_str(abort_label) "]\n\t"






-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
