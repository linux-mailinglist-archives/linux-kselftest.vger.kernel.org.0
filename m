Return-Path: <linux-kselftest+bounces-22349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FBD9D3D72
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDC91F2210B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE21A9B53;
	Wed, 20 Nov 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOJXeO4d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB2174EDB;
	Wed, 20 Nov 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732112598; cv=none; b=i+veCh2GrVZ+m21hIjN8PiAmiyRcv0E2cVcz1BI5AHbbjOie57rvvgdf9eFuLf1UFpRBJ5LfFu9HBVATLrZLsK6uToC27RWPwegRWh4ga1GJH8MQkamFpYAs6qJmD/EAZqzrWABy6PW1W//oAQotHY72qRT69VpJJTCUcJfafm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732112598; c=relaxed/simple;
	bh=BPomXTZqeEIbKC5DTXtaQe0v+mhLEggg8jnDCvzzxp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfaXEWEO/Nvi/M9qBQD3QuzF8is182h5vZ4SWCyZo5oTlYZXI1jNv+EYRm1PWfTEabLswKbQUnW2cHD/rRtzSCbB13UaYvA9fyQbdAQptWxbzQZM+rlRBkOuB8u23g2fvJQOxnbndlHNF4JHZXGHTpaqmsXrZyJPYE4p4Wy8k3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOJXeO4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89846C4CECD;
	Wed, 20 Nov 2024 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732112597;
	bh=BPomXTZqeEIbKC5DTXtaQe0v+mhLEggg8jnDCvzzxp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOJXeO4d8M/mqZJUH8CB5566vq/Z0/bAxmaeq/2Nxtiwpe+wtSTC/6SmNIk1+SJJZ
	 /yfnF9ol9QoOk56ZHEfwKjQmx6of+pGKJ41lVxK6LciOHxIWC4LDlvEfsKiEw6qmmN
	 xn8oMPj1juCbMl2rXRmHxZLhxeB8ztWS3vWIitW8S9/QUIWBjEk1ljtW5W2sHBrAE5
	 LmPZgcJ5DcNO+8n0fSgyIa1KdjDoyIK0TpURmc4pOHSp48VL2utv8hHs0RYNGkAP0k
	 2LtN6sF3YaFxsShTVjNTq6ScITbdERYtqS12vfHNP/f+2EzmOb9f0mMb/yfMQ5mPxo
	 DRkZFo/Kh54Fg==
Date: Wed, 20 Nov 2024 15:23:14 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	x86@kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>, Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 11/15] context-tracking: Introduce work deferral
 infrastructure
Message-ID: <Zz3w0o_3wZDgJn0K@localhost.localdomain>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-12-vschneid@redhat.com>
 <Zz2_7MbxvfjKsz08@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zz2_7MbxvfjKsz08@pavilion.home>

Le Wed, Nov 20, 2024 at 11:54:36AM +0100, Frederic Weisbecker a écrit :
> Le Tue, Nov 19, 2024 at 04:34:58PM +0100, Valentin Schneider a écrit :
> > +bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
> > +{
> > +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> > +	unsigned int old;
> > +	bool ret = false;
> > +
> > +	preempt_disable();
> > +
> > +	old = atomic_read(&ct->state);
> > +	/*
> > +	 * Try setting the work until either
> > +	 * - the target CPU has entered kernelspace
> > +	 * - the work has been set
> > +	 */
> > +	do {
> > +		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_START));
> > +	} while (!ret && ((old & CT_STATE_MASK) != CT_STATE_KERNEL));
> > +
> > +	preempt_enable();
> > +	return ret;
> 
> Does it ignore the IPI even if:
> 
>      (ret && (old & CT_STATE_MASK) == CT_STATE_KERNEL))
> 
> ?
> 
> And what about CT_STATE_IDLE?
> 
> Is the work ignored in those two cases?
> 
> But would it be cleaner to never set the work if the target is elsewhere
> than CT_STATE_USER. So you don't need to clear the work on kernel exit
> but rather on kernel entry.
> 
> That is:
> 
> bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
> {
> 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> 	unsigned int old;
> 	bool ret = false;
> 
> 	preempt_disable();
> 
> 	old = atomic_read(&ct->state);
> 
> 	/* Start with our best wishes */
> 	old &= ~CT_STATE_MASK;
> 	old |= CT_STATE_USER
> 
> 	/*
> 	 * Try setting the work until either
> 	 * - the target CPU has exited userspace
> 	 * - the work has been set
> 	 */
> 	do {
> 		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_START));
> 	} while (!ret && ((old & CT_STATE_MASK) == CT_STATE_USER));
> 
> 	preempt_enable();
> 
> 	return ret;
> }

Ah but there is CT_STATE_GUEST and I see the last patch also applies that to
CT_STATE_IDLE.

So that could be:

bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
{
	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
	unsigned int old;
	bool ret = false;

	preempt_disable();

	old = atomic_read(&ct->state);

	/* CT_STATE_IDLE can be added to last patch here */
	if (!(old & (CT_STATE_USER | CT_STATE_GUEST))) {
		old &= ~CT_STATE_MASK;
		old |= CT_STATE_USER;
	}

	/*
	 * Try setting the work until either
	 * - the target CPU has exited userspace / guest
	 * - the work has been set
	 */
	do {
		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_START));
	} while (!ret && old & (CT_STATE_USER | CT_STATE_GUEST));

	preempt_enable();

	return ret;
}

Thanks.

