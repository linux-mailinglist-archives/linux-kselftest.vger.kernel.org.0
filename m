Return-Path: <linux-kselftest+bounces-22374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C99D4125
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 18:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0AB1F22752
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1971A0BDC;
	Wed, 20 Nov 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf3Dyd2C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE9487BE;
	Wed, 20 Nov 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123821; cv=none; b=kSMpxYOH1zh+7Y3NgAM+M6pOU8ng3FPz1EaO1VV8IXcL763pdnljRpFO/W8LJFC6Q3i8Q3+jA536WYJkz6qsTOSWCdnXrbmjty1KdOdqTRDF9BWxKuCtRun93JtsUlMWWI+hEW5hQuoTLgCHTPw/dBFwmGSxltpbQ+F09kmCKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123821; c=relaxed/simple;
	bh=PFA7J969PABg1BMHj5bUVkB7wuVSRSb1IQcjJeE4WLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gcwn+hQQKNGRbLZdO8uCz1fFesc5gsFP4cOShAsrom6ApGjhp4syIdVNNIpRSuVOwyqo3xqnBhfYAm5z44oWMLCVk2nv+V35CsnmBXElzUPry/N4nDipBjHT5pACImX2fTYBpRG5ScLit8gZEJWwMyuVR/eXiuRUCL1T1LV85bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf3Dyd2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD605C4CECD;
	Wed, 20 Nov 2024 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732123820;
	bh=PFA7J969PABg1BMHj5bUVkB7wuVSRSb1IQcjJeE4WLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kf3Dyd2CKUZa3tMlA5c9d+2ELCZPrv6chpFxvCS+UiOnBey7DGXhhzWANw/Gp+cVf
	 9ekUEtoHku9jwPT9QXn/R2VMK+633Zwv3F8SW/w65Og7YAa79XArf9PDSYf46Yny/f
	 CrYCCnTD0bWSCkL5fF9NGkrNb77XNSWjrPupERZ/bTBF5I2Jc5S3xRmc9IDdaoFlod
	 GylypmxLKgFB8l61QEhIJKuBcBziS7S2je/uwRmgBZtYP0rWwBCTQiHaso7+9c9Aeo
	 QatfyLQ2wrkudg0oAe0ccQENxnmONZH9eFt1AMIDeWXdmNfFX87/aC3WxZnfDlQGNL
	 8lnRD6NSI6heA==
Date: Wed, 20 Nov 2024 18:30:17 +0100
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
Message-ID: <Zz4cqfVfyb1enxql@localhost.localdomain>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-12-vschneid@redhat.com>
 <Zz2_7MbxvfjKsz08@pavilion.home>
 <Zz3w0o_3wZDgJn0K@localhost.localdomain>
 <xhsmho729hlv0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmho729hlv0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Wed, Nov 20, 2024 at 06:10:43PM +0100, Valentin Schneider a écrit :
> On 20/11/24 15:23, Frederic Weisbecker wrote:
> 
> > Ah but there is CT_STATE_GUEST and I see the last patch also applies that to
> > CT_STATE_IDLE.
> >
> > So that could be:
> >
> > bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
> > {
> > 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> > 	unsigned int old;
> > 	bool ret = false;
> >
> > 	preempt_disable();
> >
> > 	old = atomic_read(&ct->state);
> >
> > 	/* CT_STATE_IDLE can be added to last patch here */
> > 	if (!(old & (CT_STATE_USER | CT_STATE_GUEST))) {
> > 		old &= ~CT_STATE_MASK;
> > 		old |= CT_STATE_USER;
> > 	}
> 
> Hmph, so that lets us leverage the cmpxchg for a !CT_STATE_KERNEL check,
> but we get an extra loop if the target CPU exits kernelspace not to
> userspace (e.g. vcpu or idle) in the meantime - not great, not terrible.

The thing is, what you read with atomic_read() should be close to reality.
If it already is != CT_STATE_KERNEL then you're good (minus racy changes).
If it is CT_STATE_KERNEL then you still must do a failing cmpxchg() in any case,
at least to make sure you didn't miss a context tracking change. So the best
you can do is a bet.

> 
> At the cost of one extra bit for the CT_STATE area, with CT_STATE_KERNEL=1
> we could do: 
> 
>   old = atomic_read(&ct->state);
>   old &= ~CT_STATE_KERNEL;

And perhaps also old |= CT_STATE_IDLE (I'm seeing the last patch now),
so you at least get a chance of making it right (only ~CT_STATE_KERNEL
will always fail) and CPUs usually spend most of their time idle.

Thanks.

