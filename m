Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92203F4CDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Aug 2021 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhHWPBI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 11:01:08 -0400
Received: from mail.efficios.com ([167.114.26.124]:33538 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhHWPAw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 11:00:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A0106334FC6;
        Mon, 23 Aug 2021 11:00:08 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uKFyB1M3jATS; Mon, 23 Aug 2021 11:00:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0D4FB334EEB;
        Mon, 23 Aug 2021 11:00:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0D4FB334EEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1629730804;
        bh=EGJSeB1m+KUlEGsOyCQNymBM03QrlJxesVoB9WRZFHo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ejPco84GHAXhi1/6wOVyAMnfI8z5LTzjRsTcS73jAocDos/Jg612nxN47CZzMjd1v
         j0dkSxvMADrUUQ6+2XaVpzg41uUfS876bws5Dc9KVmY3TbvU8bfG/GzZtSaU6MD/Br
         qd+yqE3E2LAVx+Wr4bAeKieW105tnSA1qBUEcAIFATAGYjySau7Gt6WOjEkKspWh2B
         avdwWhlGU945C6b8YvfAvk1ZdqEc2nt46fnvC2+SAOAbasQIeDIf96bdMWUzu3FQjr
         7/tGcKmANl6xucIecfrF1a7WCI/NBUZnrQLCXvN+xT53buigZa/MX4DkWxF0/t6oL9
         xwMUBg49cEiGg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3fgpCu_WLZGT; Mon, 23 Aug 2021 11:00:03 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BD2C1335202;
        Mon, 23 Aug 2021 11:00:03 -0400 (EDT)
Date:   Mon, 23 Aug 2021 11:00:03 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
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
        linux-mips <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Ben Gardon <bgardon@google.com>
Message-ID: <733947967.21669.1629730803567.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210820225002.310652-2-seanjc@google.com>
References: <20210820225002.310652-1-seanjc@google.com> <20210820225002.310652-2-seanjc@google.com>
Subject: Re: [PATCH v2 1/5] KVM: rseq: Update rseq when processing
 NOTIFY_RESUME on xfer to KVM guest
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4101 (ZimbraWebClient - FF90 (Linux)/8.8.15_GA_4059)
Thread-Topic: rseq: Update rseq when processing NOTIFY_RESUME on xfer to KVM guest
Thread-Index: CeEx/cQL9qhzvrS0pzwTWVh97FgvJA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Aug 20, 2021, at 6:49 PM, Sean Christopherson seanjc@google.com wrote:

> Invoke rseq's NOTIFY_RESUME handler when processing the flag prior to
> transferring to a KVM guest, which is roughly equivalent to an exit to
> userspace and processes many of the same pending actions.  While the task
> cannot be in an rseq critical section as the KVM path is reachable only
> by via ioctl(KVM_RUN), the side effects that apply to rseq outside of a
> critical section still apply, e.g. the current CPU needs to be updated if
> the task is migrated.
> 
> Clearing TIF_NOTIFY_RESUME without informing rseq can lead to segfaults
> and other badness in userspace VMMs that use rseq in combination with KVM,
> e.g. due to the CPU ID being stale after task migration.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Fixes: 72c3c0fe54a3 ("x86/kvm: Use generic xfer to guest work function")
> Reported-by: Peter Foley <pefoley@google.com>
> Bisected-by: Doug Evans <dje@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> kernel/entry/kvm.c |  4 +++-
> kernel/rseq.c      | 14 +++++++++++---
> 2 files changed, 14 insertions(+), 4 deletions(-)
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
> index 35f7bd0fced0..6d45ac3dae7f 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -282,9 +282,17 @@ void __rseq_handle_notify_resume(struct ksignal *ksig,
> struct pt_regs *regs)
> 
> 	if (unlikely(t->flags & PF_EXITING))
> 		return;
> -	ret = rseq_ip_fixup(regs);
> -	if (unlikely(ret < 0))
> -		goto error;
> +
> +	/*
> +	 * regs is NULL if and only if the caller is in a syscall path.  Skip
> +	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> +	 * kill a misbehaving userspace on debug kernels.
> +	 */
> +	if (regs) {
> +		ret = rseq_ip_fixup(regs);
> +		if (unlikely(ret < 0))
> +			goto error;
> +	}
> 	if (unlikely(rseq_update_cpu_id(t)))
> 		goto error;
> 	return;
> --
> 2.33.0.rc2.250.ged5fa647cd-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
