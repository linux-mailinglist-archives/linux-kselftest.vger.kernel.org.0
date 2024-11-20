Return-Path: <linux-kselftest+bounces-22358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0909D3F19
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0449D28223F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9494C74C08;
	Wed, 20 Nov 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FgaVkoEG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1583B1A2;
	Wed, 20 Nov 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116745; cv=none; b=p62xVBrjUGa3zZ7eHnwcGGKmM0qQKQOC/FfqVsAPT0ND3Xb1+6e5y1nGY130ua760HuvkPTVoInyJ2bkYubzbf2YNT5Bgxr/M1PCsy4CG7O0pwY2uOPZblqL7x4d6TTn/8HRvj2Nc6Va/KdYS7INoQYsZJjzzYUCa4oeh7dCviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116745; c=relaxed/simple;
	bh=Eryi4OYXCbHpDEV284F8kC8uQ7m7+bl5Uw0oCZKqmXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaOXR2VS/wc6C2NeIEEOlaaj2Vtm+XFuO+famPsPcqNO4FP1gzYCjpgwJVdjLbZIl6kFaPcp3TsWIsVuOR5jJmGft7XhiKLY286AnPzMvb5198OL8+Fm5iJv7r2p4Lp+eemFv5/xtG4E1eBbSUFCsOuDMzvzNYGvtu3qPk0ywCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FgaVkoEG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tcTMY8ya7ymb7xaXseOqMs9+4oRXdKR5XJcZuGIQGZ4=; b=FgaVkoEG00IplUMFhm2q9bJDcn
	f6lPIFe1mjGu/mzL0QDHreJek22LGkhbkX5aNB+qoQoIiolzWlB1o1Ar51QCtm/bbtkdagk50nH3y
	WiTSE9pgIau4cnAnW/HSBZPgC8VowGKtyI6rMugABbcUVqm00Qf2G39vFqnu3hPJhWqhyGmH/6Hvn
	16Q88vjI7HzOKfej71txLNGyXjGPPRvkuWPEd6mq0x1yM93Q8prU08tfjSrjyHNmBJUG4Aj6nXnHE
	nwFv4JzxtdPHumBy8wrQx8vNyTDlDUvdVQO2sGNjcUu6kpr7uiOs553P3EE+P3n3wld+ZY47zcNu+
	0tmqHdKQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDmgn-00000000U1t-2qD3;
	Wed, 20 Nov 2024 15:32:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4B01A300446; Wed, 20 Nov 2024 16:32:21 +0100 (CET)
Date: Wed, 20 Nov 2024 16:32:21 +0100
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
Message-ID: <20241120153221.GM38972@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-14-vschneid@redhat.com>
 <20241120152216.GM19989@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120152216.GM19989@noisy.programming.kicks-ass.net>

On Wed, Nov 20, 2024 at 04:22:16PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 19, 2024 at 04:35:00PM +0100, Valentin Schneider wrote:
> 
> > +void noinstr __flush_tlb_all_noinstr(void)
> > +{
> > +	/*
> > +	 * This is for invocation in early entry code that cannot be
> > +	 * instrumented. A RMW to CR4 works for most cases, but relies on
> > +	 * being able to flip either of the PGE or PCIDE bits. Flipping CR4.PCID
> > +	 * would require also resetting CR3.PCID, so just try with CR4.PGE, else
> > +	 * do the CR3 write.
> > +	 *
> > +	 * XXX: this gives paravirt the finger.
> > +	 */
> > +	if (cpu_feature_enabled(X86_FEATURE_PGE))
> > +		__native_tlb_flush_global_noinstr(this_cpu_read(cpu_tlbstate.cr4));
> > +	else
> > +		native_flush_tlb_local_noinstr();
> > +}
> 
> Urgh, so that's a lot of ugleh, and cr4 has that pinning stuff and gah.
> 
> Why not always just do the CR3 write and call it a day? That should also
> work for paravirt, no? Just make the whole write_cr3 thing noinstr and
> voila.

Oh gawd, just having looked at xen_write_cr3() this might not be
entirely trivial to mark noinstr :/



