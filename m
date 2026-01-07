Return-Path: <linux-kselftest+bounces-48441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C130D005F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 00:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78D1B300387F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 23:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1034D2F28EF;
	Wed,  7 Jan 2026 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYoE6TV/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48942848A4;
	Wed,  7 Jan 2026 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767827683; cv=none; b=azDdQpoBiSUnH6wI9YcIQ8mEzVod/nbMOfXpackeSXJ2wpHIjfDFr214QKzNsz8bGVvq7HLcviI8l0y3Q5EoniKHCsB9uveR8zd0KL2uh2sHeLauj0LmOl8tqDaKb3jChFBs5a/zDsckuZ6bfDd3EGc3KFGsqd+2tPCh97Di7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767827683; c=relaxed/simple;
	bh=jwzhuclUq0YEJ/+x35hSDia4E3O0OBPCGyLMt/QilZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7lk8fNpvSAbcNWx45mdlOfshmbHYYAQNG3s2DJX09youFj4kFmYMCaMH9zM+1EXWAs58MOfs8lKNCD0HNshs/vfMpSl4880nb1YoQ+fIX0IMxptIpAPXj4Ys/VZpdGmKTYU02x+BA6GLJjUKsV72ZhJwj1HemSTuOwcJdGGBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYoE6TV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035FCC4CEF1;
	Wed,  7 Jan 2026 23:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767827682;
	bh=jwzhuclUq0YEJ/+x35hSDia4E3O0OBPCGyLMt/QilZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYoE6TV/IBrULNqgAljZll+qPP6A/lX0XX3P4heE4j9mZj4PcU04pCtB5xIvAgdan
	 WqrQb5HrV+caAYi81gTGjQcLNcwhBxLUDtUwnu7Fq4Qf8lv5/VYTSEys3QtIMv1esT
	 6iYOBpUGY02oUK4/tZemoTIpMv5+h7n4poOVZY+PWrjSzCY26naSik9mKHdb8Gxu9w
	 bOuYFrwtW0ZRGGBsD0V9JHUCZNpzFDZHF2egknY6ulY4VynjBycaiSYS0rKfXBmjAS
	 SjzCHaLcf6D2WpIUR4GbIj7KNNs78IsGk/2j2jds7dUJxHGI7viLYmmaCgVIsQ1J52
	 6t2CxtADJch7Q==
Date: Thu, 8 Jan 2026 00:14:39 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Yao Kai <yaokai34@huawei.com>, Tengda Wu <wutengda2@huawei.com>
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
Message-ID: <aV7o36CHTLc-tD41@pavilion.home>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-2-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260101163417.1065705-2-joelagnelf@nvidia.com>

Le Thu, Jan 01, 2026 at 11:34:10AM -0500, Joel Fernandes a écrit :
> From: Yao Kai <yaokai34@huawei.com>
> 
> Commit 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in
> __rcu_read_unlock()") removes the recursion-protection code from
> __rcu_read_unlock(). Therefore, we could invoke the deadloop in
> raise_softirq_irqoff() with ftrace enabled as follows:
> 
> WARNING: CPU: 0 PID: 0 at kernel/trace/trace.c:3021 __ftrace_trace_stack.constprop.0+0x172/0x180
> Modules linked in: my_irq_work(O)
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G O 6.18.0-rc7-dirty #23 PREEMPT(full)
> Tainted: [O]=OOT_MODULE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:__ftrace_trace_stack.constprop.0+0x172/0x180
> RSP: 0018:ffffc900000034a8 EFLAGS: 00010002
> RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
> RDX: 0000000000000003 RSI: ffffffff826d7b87 RDI: ffffffff826e9329
> RBP: 0000000000090009 R08: 0000000000000005 R09: ffffffff82afbc4c
> R10: 0000000000000008 R11: 0000000000011d7a R12: 0000000000000000
> R13: ffff888003874100 R14: 0000000000000003 R15: ffff8880038c1054
> FS:  0000000000000000(0000) GS:ffff8880fa8ea000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055b31fa7f540 CR3: 00000000078f4005 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  unwind_next_frame+0x203/0x9b0
>  __unwind_start+0x15d/0x1c0
>  arch_stack_walk+0x62/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  raise_softirq_irqoff+0x6e/0xa0
>  rcu_read_unlock_special+0xb1/0x160
>  __is_insn_slot_addr+0x54/0x70
>  kernel_text_address+0x48/0xc0
>  __kernel_text_address+0xd/0x40
>  unwind_get_return_address+0x1e/0x40
>  arch_stack_walk+0x9c/0xf0
>  stack_trace_save+0x48/0x70
>  __ftrace_trace_stack.constprop.0+0x144/0x180
>  trace_buffer_unlock_commit_regs+0x6d/0x220
>  trace_event_buffer_commit+0x5c/0x260
>  trace_event_raw_event_softirq+0x47/0x80
>  __raise_softirq_irqoff+0x61/0x80
>  __flush_smp_call_function_queue+0x115/0x420
>  __sysvec_call_function_single+0x17/0xb0
>  sysvec_call_function_single+0x8c/0xc0
>  </IRQ>
> 
> Commit b41642c87716 ("rcu: Fix rcu_read_unlock() deadloop due to IRQ work")
> fixed the infinite loop in rcu_read_unlock_special() for IRQ work by
> setting a flag before calling irq_work_queue_on(). We fix this issue by
> setting the same flag before calling raise_softirq_irqoff() and rename the
> flag to defer_qs_pending for more common.
> 
> Fixes: 5f5fa7ea89dc ("rcu: Don't use negative nesting depth in __rcu_read_unlock()")
> Reported-by: Tengda Wu <wutengda2@huawei.com>
> Signed-off-by: Yao Kai <yaokai34@huawei.com>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Looks good but, BTW, what happens if rcu_qs() is called
before rcu_preempt_deferred_qs() had a chance to be called?

current->rcu_read_unlock_special.b.need_qs is reset by rcu_qs()
so subsequent calls to rcu_read_unlock() won't issue rcu_read_unlock_special()
(unless the task is blocked). And further calls to rcu_preempt_deferred_qs()
through rcu_core() will be ignored as well.

But rdp->defer_qs_pending will remain in the DEFER_QS_PENDING state until
the next grace period. And if rcu_read_unlock_special() is called again
during the next GP on unfortunate place needing deferred qs, the state machine
will spuriously assume that either rcu_core or the irq_work are pending, when
none are anymore.

The state should be reset by rcu_qs().

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

