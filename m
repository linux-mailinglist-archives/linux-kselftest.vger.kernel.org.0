Return-Path: <linux-kselftest+bounces-22493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F39D7861
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 22:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DBEB22733
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E51815B153;
	Sun, 24 Nov 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNg7MJ2I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F112500BB;
	Sun, 24 Nov 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732484764; cv=none; b=kYM5bQmZSVHSvWuWczJfOe8dMwF44gWf0nTxk8htqeliEQsZ1hcQyT/hCsldQh9O85i0fraFcex97vJ6iawOMiGEhxzC5g6KHqU+f1OYRitWdCyu4v9DDxPxVDeFst7XF54Jh1uDD742RAOFvrJb9o0FqvIWRkWMk5hCuQwLfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732484764; c=relaxed/simple;
	bh=/qhmFmtGTN/yG2NensqYHITpZ/haNfld1Woay8hK220=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVpy1P9Z6baVEDcUdk8nWBa/qcNsdWfLH92XwRiQ5WKSSLHpFqlfrMnT1Nl3v/FvklT9OHJPp29+yAotpBYrJaCq0Z9sKJWsWQZMUC+fjkPEs3E3U9hTWIRWnAKOa0eAKZ0PFTonQ8tlXZtheAJDWz8t0l7FuRpWRnISz5Ovvh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNg7MJ2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE06C4CECC;
	Sun, 24 Nov 2024 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732484763;
	bh=/qhmFmtGTN/yG2NensqYHITpZ/haNfld1Woay8hK220=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNg7MJ2IIU3CeTaHZ48HzrmcZZAw0SYc+qCR/IKYfojob4+a9LbntBCi696q0OjUN
	 3nQvd8ihsO2okerTSi3qXbeP7+LNX7rk2RZTot29gYFw3eku4E/jStldwicIm8jQSq
	 Jpvge98weBKXSdbt5FHI9opC+dsG48zcJQqC4EpSMqFwt5BAyZtTlcIZ8F1rOycM8t
	 gBXJmsYnFDfxgSh+rxCGS5FXmXw2NvRkPX7hznrkisrgC//vxx85ldSGSXAXmR7YTU
	 3LHIuIqDGcPS9H2ByV200QW0+2+eVwzg+CINe8g2Q9xl4+OtQ3aiK5W+MZpdqpHY8C
	 k9ocOhptHnk2g==
Date: Sun, 24 Nov 2024 22:46:01 +0100
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
Message-ID: <Z0Oeme2yhxF_ArX0@pavilion.home>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-12-vschneid@redhat.com>
 <Zz2_7MbxvfjKsz08@pavilion.home>
 <Zz3w0o_3wZDgJn0K@localhost.localdomain>
 <xhsmho729hlv0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Zz4cqfVfyb1enxql@localhost.localdomain>
 <xhsmh1pz39v0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmh1pz39v0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Fri, Nov 22, 2024 at 03:56:59PM +0100, Valentin Schneider a écrit :
> On 20/11/24 18:30, Frederic Weisbecker wrote:
> > Le Wed, Nov 20, 2024 at 06:10:43PM +0100, Valentin Schneider a écrit :
> >> On 20/11/24 15:23, Frederic Weisbecker wrote:
> >>
> >> > Ah but there is CT_STATE_GUEST and I see the last patch also applies that to
> >> > CT_STATE_IDLE.
> >> >
> >> > So that could be:
> >> >
> >> > bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
> >> > {
> >> >    struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> >> >    unsigned int old;
> >> >    bool ret = false;
> >> >
> >> >    preempt_disable();
> >> >
> >> >    old = atomic_read(&ct->state);
> >> >
> >> >    /* CT_STATE_IDLE can be added to last patch here */
> >> >    if (!(old & (CT_STATE_USER | CT_STATE_GUEST))) {
> >> >            old &= ~CT_STATE_MASK;
> >> >            old |= CT_STATE_USER;
> >> >    }
> >>
> >> Hmph, so that lets us leverage the cmpxchg for a !CT_STATE_KERNEL check,
> >> but we get an extra loop if the target CPU exits kernelspace not to
> >> userspace (e.g. vcpu or idle) in the meantime - not great, not terrible.
> >
> > The thing is, what you read with atomic_read() should be close to reality.
> > If it already is != CT_STATE_KERNEL then you're good (minus racy changes).
> > If it is CT_STATE_KERNEL then you still must do a failing cmpxchg() in any case,
> > at least to make sure you didn't miss a context tracking change. So the best
> > you can do is a bet.
> >
> >>
> >> At the cost of one extra bit for the CT_STATE area, with CT_STATE_KERNEL=1
> >> we could do:
> >>
> >>   old = atomic_read(&ct->state);
> >>   old &= ~CT_STATE_KERNEL;
> >
> > And perhaps also old |= CT_STATE_IDLE (I'm seeing the last patch now),
> > so you at least get a chance of making it right (only ~CT_STATE_KERNEL
> > will always fail) and CPUs usually spend most of their time idle.
> >
> 
> I'm thinking with:
> 
>         CT_STATE_IDLE		= 0,
>         CT_STATE_USER		= 1,
>         CT_STATE_GUEST		= 2,
>         CT_STATE_KERNEL		= 4, /* Keep that as a standalone bit */

Right!

> 
> we can stick with old &= ~CT_STATE_KERNEL; and that'll let the cmpxchg
> succeed for any of IDLE/USER/GUEST.

Sure but if (old & CT_STATE_KERNEL), cmpxchg() will consistently fail.
But you can make a bet that it has switched to CT_STATE_IDLE between
the atomic_read() and the first atomic_cmpxchg(). This way you still have
a tiny chance to succeed.

That is:

   old = atomic_read(&ct->state);
   if (old & CT_STATE_KERNEl)
      old |= CT_STATE_IDLE;
   old &= ~CT_STATE_KERNEL;


   do {
      atomic_try_cmpxchg(...)

Hmm?


