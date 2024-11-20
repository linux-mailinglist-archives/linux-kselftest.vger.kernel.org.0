Return-Path: <linux-kselftest+bounces-22355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC29D3ECD
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FE3285282
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA41AA1C3;
	Wed, 20 Nov 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHQQtivy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF282B9A9;
	Wed, 20 Nov 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115591; cv=none; b=UH3WbdAjnYxTqVUnnHtZq0/lZ823HjRoM3aiVj4bznls3oCjxBqIJaapKOfB8owTsXiD1c1AwF4ZoL33UJZW0HVD8TqkzVmYgEil3QJdQtu8wreHL/crqfWnuIslHW22R9k1YojXuUuwsLnZffLj1T9B+8pQ1GtsB1yiDUHTOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115591; c=relaxed/simple;
	bh=/ICbzWM/m9Ey+tjFGLTbiKkd6MhG4IyhhGiknGWoNjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkOVkuNFbApEuRRvETfjTSw6AiJMFFfS6nUXLxon/6ZbOuKxcILVdNAjMEitzzgzshs6OS7GIiwZ7Bl9SxYPw2gOpmVPhA1ygFrNYWnJ97PonlOOiohIW17yr+y7j6l8zcxWthyQiVFS4ONFSjRfj8Y9/bDYnmOItUyMCeI464k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hHQQtivy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AAZRDzlSytBcEeYbJd2bXyGg47+8MrAXJx0XsTo+ZCk=; b=hHQQtivypT3ptz/3Ng1DE0HYYc
	ui45zM/vkkkWmkIkMIkjF8WnrBlzDbQ/bMF/zf4Sy2NSFsZu+/jaZ2HccJy8QPhMdwzOD7xB2vxP0
	SP/Xhg12scFjjWG65KN1giIEGj498w3S1FHEULPi6tzNACfQ0apQ2otQK9ArVd9G1++V8UvkKGXUF
	O4wb+v87ZdqqKtS9Vmj/jKu2YxhRA7hp4E/eKutXXMDhBsjK2RyWf3kYuoQ+xcd4Pyh4tzfoZelFT
	53b8s43+VeviRTcjem3wSYAvSX+Kad1JoN35MMtbbawjNxeDNPSx06aRS0jG1T0WRY6aZf5eloTsl
	F6cXyBwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDmOB-00000005NpY-0kTk;
	Wed, 20 Nov 2024 15:13:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0D62E300446; Wed, 20 Nov 2024 16:13:08 +0100 (CET)
Date: Wed, 20 Nov 2024 16:13:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
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
	Frederic Weisbecker <frederic@kernel.org>,
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
Subject: Re: [RFC PATCH v3 12/15] context_tracking,x86: Defer kernel text
 patching IPIs
Message-ID: <20241120151308.GL19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-13-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-13-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:34:59PM +0100, Valentin Schneider wrote:

> +static void __text_poke_sync(smp_cond_func_t cond_func)
> +{
> +	on_each_cpu_cond(cond_func, do_sync_core, NULL, 1);
> +}
> +
>  void text_poke_sync(void)
>  {
> -	on_each_cpu(do_sync_core, NULL, 1);
> +	__text_poke_sync(NULL);
> +}
> +
> +void text_poke_sync_deferrable(void)
> +{
> +	__text_poke_sync(do_sync_core_defer_cond);
>  }

How about we unwrap some of that like so:

>  /*
> @@ -2257,6 +2273,8 @@ static int tp_vec_nr;
>  static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
>  {
>  	unsigned char int3 = INT3_INSN_OPCODE;
> +	bool force_ipi = false;
> +	void (*sync_fn)(void);

	smp_cond_func_t cond = do_sync_core_defer_cond;

>  	unsigned int i;
>  	int do_sync;
>  
> @@ -2291,11 +2309,18 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	 * First step: add a int3 trap to the address that will be patched.
>  	 */
>  	for (i = 0; i < nr_entries; i++) {
> +		/*
> +		 * Record that we need to send the IPI if at least one location
> +		 * in the batch requires it.
> +		 */
> +		force_ipi |= tp[i].force_ipi;

		if (tp[i].force_ipi)
			cond = NULL;

>  		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
>  		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
>  	}
>  
> -	text_poke_sync();
> +	sync_fn = force_ipi ? text_poke_sync : text_poke_sync_deferrable;
> +
> +	sync_fn();

	__text_poke_sync(cond);

