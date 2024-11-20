Return-Path: <linux-kselftest+bounces-22356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 800F29D3EE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B01B1F25327
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115CD5588F;
	Wed, 20 Nov 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q5p8dJVp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35697AD58;
	Wed, 20 Nov 2024 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116142; cv=none; b=puu8i7+UZIEd4QfXX5+OWKY+yOWk1vuxSy8oH1O2mdQVaxLe7C/WUp+kdPpDWUYHeMbB529e2XQX/0knfomorbLC+SexA/m7rj6R2m7bY16Sx8/3k8nPWDSU+yjpUcL4/mTMzTddVJyea0hAFmomtbng5BJVmFZxsWn7EqtQE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116142; c=relaxed/simple;
	bh=WbvCYI5FQOAQYXBCr2RLO2b6uAXeaNOyafQmb6z/s/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlrjNvjpY4ohkFcVzRZF+N83moPY7M4LB6y5SH6GS79QYjUIyv2f4Bo+MRbvC1eh0Tj5pCsf1yMANFnsdKAZ1wjSES+UPrA0QA5BizucsU2JP/cjPoK2IqJBQuHTr9oBCjkPkWrfVemkX5MzP6C//BHhRmwAveQE/FEXH6U4upE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q5p8dJVp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MlJHDcSjdk0fhBS8nKpdUNl5QedDLuvNa80aSphcDYs=; b=Q5p8dJVp1KwwHDiejvBYhLvkf5
	6ue7MbFQitMoSVB4a1MYU4+rrx18IbFL14GYmi846BSWMz59zvGewA8OVZ15KcoHIaTwcr4Wy+2qp
	xic0MF2qpRf1I0tNDzB154ZAgtXA+TkusWwJdxXKlphQ41qPn1Mxg+hG8DqVFiuI3yZdnM6rrA+of
	QCxM5tgnJBfFuUH/E4I57SEF2Ihfh6QtFjAGsq0weG1vLY0InzJ/Wqvp3WCWWKs2ODbWjHUB2jAzy
	Wawv484kPn4bewWwdKBoRLNHtmXGT6iYlrzevGQgODUfp1aGCnJo0cQwL+h+TvFsLdyBd8ELWroPB
	FcugpBOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDmX2-00000005OFm-1ZBt;
	Wed, 20 Nov 2024 15:22:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5E3F300446; Wed, 20 Nov 2024 16:22:16 +0100 (CET)
Date: Wed, 20 Nov 2024 16:22:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	x86@kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
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
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure to
 defer kernel TLBI
Message-ID: <20241120152216.GM19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-14-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-14-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:35:00PM +0100, Valentin Schneider wrote:

> +void noinstr __flush_tlb_all_noinstr(void)
> +{
> +	/*
> +	 * This is for invocation in early entry code that cannot be
> +	 * instrumented. A RMW to CR4 works for most cases, but relies on
> +	 * being able to flip either of the PGE or PCIDE bits. Flipping CR4.PCID
> +	 * would require also resetting CR3.PCID, so just try with CR4.PGE, else
> +	 * do the CR3 write.
> +	 *
> +	 * XXX: this gives paravirt the finger.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_PGE))
> +		__native_tlb_flush_global_noinstr(this_cpu_read(cpu_tlbstate.cr4));
> +	else
> +		native_flush_tlb_local_noinstr();
> +}

Urgh, so that's a lot of ugleh, and cr4 has that pinning stuff and gah.

Why not always just do the CR3 write and call it a day? That should also
work for paravirt, no? Just make the whole write_cr3 thing noinstr and
voila.



