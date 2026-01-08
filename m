Return-Path: <linux-kselftest+bounces-48529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E7BD0448D
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF583311784C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C98F331A4B;
	Thu,  8 Jan 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TclmQzJ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07201DE89A;
	Thu,  8 Jan 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885929; cv=none; b=ggwxy4/Z0c2s+WqFUoOqMvRy5uJWSksfgBZWVS8bFRqQCd12r5fo3uzHbNLYc43CZ9KUneZjIA6XqvE7OM5iXXmwzuAgjChUYKK/yczKKL3GViliLBj4JaYwHtQu/urxHgatsEtCuTAwHexZmizqHiUoDBsApO1t0qxQ00ldXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885929; c=relaxed/simple;
	bh=TnqqVmU/omsPxInzuSAB4rkZpzVUW/rbaQABAZOlvDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyFd9NHO4aPGxpEDLDUkJEOxp1L3rlcfKZlDGpLj3OcZHytjk7CQ9goG+P4uxJEX0olJgYYl6/DegALXyMtcHkw/RgJsyp4xccfpeec6vgMhx1g8Yhrg5V/PsWbnKf6kLKxQIyc2Gz+2xUVHufWSZRspclcEd1PGzeGvGBK6ioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TclmQzJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10F7C116C6;
	Thu,  8 Jan 2026 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767885928;
	bh=TnqqVmU/omsPxInzuSAB4rkZpzVUW/rbaQABAZOlvDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TclmQzJ329uswzMXiYuO2Eutn4XRM7OD7mfBmDL7EQBj516Ey1Qy/E4Uma/gRYZhi
	 vl3GizN/80KGJ0hy1UP7252jedXvGMdJiF7ee6Xyvq/Z9+cwgAzbWH/6Beu0T9DUlq
	 YqcTBU2xVsA1PCv2Qy7OxUm5FhMTzb5Yg6knHHJSa4yhdGrrHoXnkfqPdYLkkJICtH
	 bUK+7L8fMLtyEGJD6m6vJwPEpnbW9y6RNmrD+uC8SnimxlkKA4NM8zCcX/XBOCeFUE
	 N+v/MQHeFH9StyoY6g8r5JVvbA1lEye0xmwRRqwQ6CGKYWG61C8N6ETdVQP6nYVjPu
	 lCaq+Q/+OKvbQ==
Date: Thu, 8 Jan 2026 16:25:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Paul E McKenney <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Kai Yao <yaokai34@huawei.com>, Tengda Wu <wutengda2@huawei.com>
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
Message-ID: <aV_MZfdIfsITRfFD@localhost.localdomain>
References: <aV7o36CHTLc-tD41@pavilion.home>
 <A88C7853-504A-496E-93A2-C9FE7D80E0D5@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A88C7853-504A-496E-93A2-C9FE7D80E0D5@joelfernandes.org>

Le Wed, Jan 07, 2026 at 08:02:43PM -0500, Joel Fernandes a écrit :
> 
> 
> > On Jan 7, 2026, at 6:15 PM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > 
> > ﻿Le Thu, Jan 01, 2026 at 11:34:10AM -0500, Joel Fernandes a écrit :
> >> From: Yao Kai <yaokai34@huawei.com>
> >> 
> >> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
> >> __rcu_read_unlock()") removes the recursion-protection code from
> >> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
> >> raise_softirq_irqoff() with ftrace enabled as follows:
> >> 
> >> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.constprop.0+0x172/0x180
> >> Modules linked in: my_irq_work(O)
> >> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PREEMPT(full)
> >> Tainted: [O]=OOT_MODULE
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> >> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
> >> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
> >> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
> >> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
> >> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
> >> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
> >> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
> >> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
> >> PKRU: 55555554
> >> Call Trace:
> >> <IRQ>
> >> trace_buffer_unlock_commit_regs+0x6d/0x220
> >> trace_event_buffer_commit+0x5c/0x260
> >> trace_event_raw_event_softirq+0x47/0x80
> >> raise_softirq_irqoff+0x6e/0xa0
> >> rcu_read_unlock_special+0xb1/0x160
> >> unwind_next_frame+0x203/0x9b0
> >> __unwind_start+0x15d/0x1c0
> >> arch_stack_walk+0x62/0xf0
> >> stack_trace_save+0x48/0x70
> >> __ftrace_trace_stack.constprop.0+0x144/0x180
> >> trace_buffer_unlock_commit_regs+0x6d/0x220
> >> trace_event_buffer_commit+0x5c/0x260
> >> trace_event_raw_event_softirq+0x47/0x80
> >> raise_softirq_irqoff+0x6e/0xa0
> >> rcu_read_unlock_special+0xb1/0x160
> >> unwind_next_frame+0x203/0x9b0
> >> __unwind_start+0x15d/0x1c0
> >> arch_stack_walk+0x62/0xf0
> >> stack_trace_save+0x48/0x70
> >> __ftrace_trace_stack.constprop.0+0x144/0x180
> >> trace_buffer_unlock_commit_regs+0x6d/0x220
> >> trace_event_buffer_commit+0x5c/0x260
> >> trace_event_raw_event_softirq+0x47/0x80
> >> raise_softirq_irqoff+0x6e/0xa0
> >> rcu_read_unlock_special+0xb1/0x160
> >> unwind_next_frame+0x203/0x9b0
> >> __unwind_start+0x15d/0x1c0
> >> arch_stack_walk+0x62/0xf0
> >> stack_trace_save+0x48/0x70
> >> __ftrace_trace_stack.constprop.0+0x144/0x180
> >> trace_buffer_unlock_commit_regs+0x6d/0x220
> >> trace_event_buffer_commit+0x5c/0x260
> >> trace_event_raw_event_softirq+0x47/0x80
> >> raise_softirq_irqoff+0x6e/0xa0
> >> rcu_read_unlock_special+0xb1/0x160
> >> __is_insn_slot_addr+0x54/0x70
> >> kernel_text_address+0x48/0xc0
> >> __kernel_text_address+0xd/0x40
> >> unwind_get_return_address+0x1e/0x40
> >> arch_stack_walk+0x9c/0xf0
> >> stack_trace_save+0x48/0x70
> >> __ftrace_trace_stack.constprop.0+0x144/0x180
> >> trace_buffer_unlock_commit_regs+0x6d/0x220
> >> trace_event_buffer_commit+0x5c/0x260
> >> trace_event_raw_event_softirq+0x47/0x80
> >> __raise_softirq_irqoff+0x61/0x80
> >> __flush_smp_call_function_queue+0x115/0x420
> >> __sysvec_call_function_single+0x17/0xb0
> >> sysvec_call_function_single+0x8c/0xc0
> >> </IRQ>
> >> 
> >> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> >> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
> >> setting a flag before calling irq_work_queue_on(). We fix this issue by
> >> setting the same flag before calling raise_softirq_irqoff() and rename the
> >> flag to defer_qs_pending for more common.
> >> 
> >> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
> >> Reported-by: Tengda Wu <wutengda2@huawei.com>
> >> Signed-off-by: Yao Kai <yaokai34@huawei.com>
> >> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Looks good but, BTW, what happens if rcu_qs() is called
> > before rcu_preempt_deferred_qs() had a chance to be called?
> 
> Could you provide an example of when that can happen?

It can happen because rcu_qs() is called before rcu_preempt_deferred_qs()
in rcu_softirq_qs(). Inverting the calls could help but IRQs must be disabled
to ensure there is no read side between rcu_preempt_deferred_qs() and rcu_qs().

I'm not aware of other ways to trigger that, except perhaps this:

https://lore.kernel.org/rcu/20251230004124.438070-1-joelagnelf@nvidia.com/T/#u

Either we fix those sites and make sure that rcu_preempt_deferred_qs() is always
called before rcu_qs() in the same IRQ disabled section (or there are other
fields set in ->rcu_read_unlock_special for later clearance). If we do that we
must WARN_ON_ONCE(rdp->defer_qs_pending == DEFER_QS_PENDING) in rcu_qs().

Or we reset rdp->defer_qs_pending from rcu_qs(), which sounds more robust.

Ah an alternative is to make rdp::defer_qs_pending a field in union rcu_special
which, sadly, would need to be expanded as a u64.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

