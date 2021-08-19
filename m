Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814933F2254
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 23:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhHSVjz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 17:39:55 -0400
Received: from mail.efficios.com ([167.114.26.124]:57280 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhHSVjy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 17:39:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0AFE8378536;
        Thu, 19 Aug 2021 17:39:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sqgMh8PS9est; Thu, 19 Aug 2021 17:39:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7F9FE3784AD;
        Thu, 19 Aug 2021 17:39:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7F9FE3784AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1629409152;
        bh=5UmwxCORiN5yLIQm2BJu9shxBCOVFj1bc8s4bRqQFQo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MF1eZ97b/KNT5hI9VL2d8/bJnxRVnz1puSaP8aXdbA0Yr8sbq1UW1Xnp5ROlOTAxA
         BrBHYFiVE9fyDS+W6acYJK/dsDcXuZ5FxN6/TGgq81Ge5A7ri3UTyOOmZCNrrwpGaX
         CaJRQA/6RdzkBds+FVqCWioAvW9dS868z5YzJqUiWVEa1eSWq/ub7V3SdNutNGYaHW
         /BGNriEzzY77HlrWaGIlJrha5VHDUBgHaX9E9aF4RYwTeW4avIB2YHkFNmb79XRV+u
         RMSG+xk/uZO1X64FabUncXvFyriO1d5efn0OTQ8xv/HTN1zVXC9OXfvrjvq/mcfJyu
         98fIeMx5uJpUQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gNagT47KYem3; Thu, 19 Aug 2021 17:39:12 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 5C6F23784AA;
        Thu, 19 Aug 2021 17:39:12 -0400 (EDT)
Date:   Thu, 19 Aug 2021 17:39:12 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-csky <linux-csky@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Ben Gardon <bgardon@google.com>
Message-ID: <1673583543.19718.1629409152244.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210818001210.4073390-2-seanjc@google.com>
References: <20210818001210.4073390-1-seanjc@google.com> <20210818001210.4073390-2-seanjc@google.com>
Subject: Re: [PATCH 1/5] KVM: rseq: Update rseq when processing
 NOTIFY_RESUME on xfer to KVM guest
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4101 (ZimbraWebClient - FF90 (Linux)/8.8.15_GA_4059)
Thread-Topic: rseq: Update rseq when processing NOTIFY_RESUME on xfer to KVM guest
Thread-Index: bvPQyLDSoOg+aSRtrktKYXzxAVZwCA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Aug 17, 2021, at 8:12 PM, Sean Christopherson seanjc@google.com wrote:

> Invoke rseq's NOTIFY_RESUME handler when processing the flag prior to
> transferring to a KVM guest, which is roughly equivalent to an exit to
> userspace and processes many of the same pending actions.  While the task
> cannot be in an rseq critical section as the KVM path is reachable only
> via ioctl(KVM_RUN), the side effects that apply to rseq outside of a
> critical section still apply, e.g. the CPU ID needs to be updated if the
> task is migrated.
> 
> Clearing TIF_NOTIFY_RESUME without informing rseq can lead to segfaults
> and other badness in userspace VMMs that use rseq in combination with KVM,
> e.g. due to the CPU ID being stale after task migration.

I agree with the problem assessment, but I would recommend a small change
to this fix.

> 
> Fixes: 72c3c0fe54a3 ("x86/kvm: Use generic xfer to guest work function")
> Reported-by: Peter Foley <pefoley@google.com>
> Bisected-by: Doug Evans <dje@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> kernel/entry/kvm.c | 4 +++-
> kernel/rseq.c      | 4 ++--
> 2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
> index 49972ee99aff..049fd06b4c3d 100644
> --- a/kernel/entry/kvm.c
> +++ b/kernel/entry/kvm.c
> @@ -19,8 +19,10 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu,
> unsigned long ti_work)
> 		if (ti_work & _TIF_NEED_RESCHED)
> 			schedule();
> 
> -		if (ti_work & _TIF_NOTIFY_RESUME)
> +		if (ti_work & _TIF_NOTIFY_RESUME) {
> 			tracehook_notify_resume(NULL);
> +			rseq_handle_notify_resume(NULL, NULL);
> +		}
> 
> 		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
> 		if (ret)
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 35f7bd0fced0..58c79a7918cd 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -236,7 +236,7 @@ static bool in_rseq_cs(unsigned long ip, struct rseq_cs
> *rseq_cs)
> 
> static int rseq_ip_fixup(struct pt_regs *regs)
> {
> -	unsigned long ip = instruction_pointer(regs);
> +	unsigned long ip = regs ? instruction_pointer(regs) : 0;
> 	struct task_struct *t = current;
> 	struct rseq_cs rseq_cs;
> 	int ret;
> @@ -250,7 +250,7 @@ static int rseq_ip_fixup(struct pt_regs *regs)
> 	 * If not nested over a rseq critical section, restart is useless.
> 	 * Clear the rseq_cs pointer and return.
> 	 */
> -	if (!in_rseq_cs(ip, &rseq_cs))
> +	if (!regs || !in_rseq_cs(ip, &rseq_cs))

I think clearing the thread's rseq_cs unconditionally here when regs is NULL
is not the behavior we want when this is called from xfer_to_guest_mode_work.

If we have a scenario where userspace ends up calling this ioctl(KVM_RUN)
from within a rseq c.s., we really want a CONFIG_DEBUG_RSEQ=y kernel to
kill this application in the rseq_syscall handler when exiting back to usermode
when the ioctl eventually returns.

However, clearing the thread's rseq_cs will prevent this from happening.

So I would favor an approach where we simply do:

if (!regs)
     return 0;

Immediately at the beginning of rseq_ip_fixup, before getting the instruction
pointer, so effectively skip all side-effects of the ip fixup code. Indeed, it
is not relevant to do any fixup here, because it is nested in a ioctl system
call.

Effectively, this would preserve the SIGSEGV behavior when this ioctl is
erroneously called by user-space from a rseq critical section.

Thanks for looking into this !

Mathieu

> 		return clear_rseq_cs(t);
> 	ret = rseq_need_restart(t, rseq_cs.flags);
> 	if (ret <= 0)
> --
> 2.33.0.rc1.237.g0d66db33f3-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
