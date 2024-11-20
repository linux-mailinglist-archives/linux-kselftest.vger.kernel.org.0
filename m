Return-Path: <linux-kselftest+bounces-22341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF39D38CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 11:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1381F252A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767EF19E802;
	Wed, 20 Nov 2024 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oerig4Qz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3E919C56C;
	Wed, 20 Nov 2024 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100080; cv=none; b=TOHMF9oMcxIhIi7cVwUQ3xhZEqff+uvCAuA7OdLXnyZt/rDGB51S6NoFNDR9z2w4Gd0o2T8fINL0M41blsxhKihZC1vZ/We8w4F47KctN1qKHPNL+tkYvJcUUQYkDt8CXwBR5iKiSXigcb/lSyV+Anqi9reoTT5AqT3odlJse/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100080; c=relaxed/simple;
	bh=v56PH/TC6VfhJinSkV1dT70LzT5v+DrJrRasoRvKhFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVThZ6bq7YTY2BZvws/Er7PoUtNQt2VZVza7r8OHnAsaJxTykK721ELvfUNCiOJ+4+jNzBkKTFv8gmr8jxgv7Szjq/vwOc/MPX5CYqBzY6DvRj/H3ximyySznzJzcgf/YdWTMtZeLyvoJQWTZSi/WGOmZmiR9oCQPkHm+vgSqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oerig4Qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544F2C4CECD;
	Wed, 20 Nov 2024 10:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732100078;
	bh=v56PH/TC6VfhJinSkV1dT70LzT5v+DrJrRasoRvKhFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oerig4QzLHxMLkwFcONbh+QH7JccDk0DYE3OO/JNvQbbuExvz1IHXFtkNKc6ws900
	 Ph+vlJcQywEm83n2EWh8eOD3E6AZfrjvVpMWMXWX3fTt+R3wkNOnwGEEtf5zQCC2uo
	 zm2de2K9vuAY5MO1/HoqnapioBJ0nJglbW9z3CJkqGC66wmic0Hh3Y8wS9bq3PAygE
	 DQRp/srrPst1RiqG1ma/fqzGFR4rh5hRjKE6OJ7Hk2bXvOPwq0Ufil5r28O7veX/F6
	 Ad1KjhFA/txIArs9lwbKNUhi2TBYUTNnd4c9ugCn654jg7d9lyoYTrVJbr+9dD32Ud
	 iibD+W02/qyJg==
Date: Wed, 20 Nov 2024 11:54:36 +0100
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
Message-ID: <Zz2_7MbxvfjKsz08@pavilion.home>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-12-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119153502.41361-12-vschneid@redhat.com>

Le Tue, Nov 19, 2024 at 04:34:58PM +0100, Valentin Schneider a écrit :
> +bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> +	unsigned int old;
> +	bool ret = false;
> +
> +	preempt_disable();
> +
> +	old = atomic_read(&ct->state);
> +	/*
> +	 * Try setting the work until either
> +	 * - the target CPU has entered kernelspace
> +	 * - the work has been set
> +	 */
> +	do {
> +		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_START));
> +	} while (!ret && ((old & CT_STATE_MASK) != CT_STATE_KERNEL));
> +
> +	preempt_enable();
> +	return ret;

Does it ignore the IPI even if:

     (ret && (old & CT_STATE_MASK) == CT_STATE_KERNEL))

?

And what about CT_STATE_IDLE?

Is the work ignored in those two cases?

But would it be cleaner to never set the work if the target is elsewhere
than CT_STATE_USER. So you don't need to clear the work on kernel exit
but rather on kernel entry.

That is:

bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
{
	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
	unsigned int old;
	bool ret = false;

	preempt_disable();

	old = atomic_read(&ct->state);

	/* Start with our best wishes */
	old &= ~CT_STATE_MASK;
	old |= CT_STATE_USER

	/*
	 * Try setting the work until either
	 * - the target CPU has exited userspace
	 * - the work has been set
	 */
	do {
		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_START));
	} while (!ret && ((old & CT_STATE_MASK) == CT_STATE_USER));

	preempt_enable();

	return ret;
}

Thanks.

