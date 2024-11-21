Return-Path: <linux-kselftest+bounces-22396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912CD9D4B32
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 12:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045ACB2406A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666041D0B8A;
	Thu, 21 Nov 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XPKb8Vow"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE41C9B95;
	Thu, 21 Nov 2024 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186967; cv=none; b=HWQxonSkSvcCTNeEKydw6C7YKftxOsb+VOsQF2ivGc7sYbNuTiZ6mGonqoMtDltoQGEl6qmIkOu4au2j/+4nBn9pSyHUV1O+XcL0xH/OMsftOJ1QK7lbapbYiGcVozfJcp5uLFhdSSwfKAUN7++ktsviWorccCMjX6CDi1xrnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186967; c=relaxed/simple;
	bh=28IJcyn5WF2tiP+O72CcHDbeluIq7DCiPoYbU4oOZgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT1aZkByWJmiuBYO8GkwOo+Q41AmK7z1BztPbk7im5nvd1CGY1lnFkvQ6eRdZaIR5LR717TlG37fFFy7KmHkyUIjZeM8qCLjyPWxOJSra9Cq8mktRfFB2IwkcottMPb9QsCnFoPHPtej1tlmyMzWeYP+eg8gbIzM9RVwGIFltTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XPKb8Vow; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zNXZoyeqqFWas/9jC0n8iQIDDwWz6V7tiZVs/eKT/uQ=; b=XPKb8Vow8F3xBJs12GZw/rt+Ow
	VF/GyUTUxJh9qI63kQJho8d0o5b4u5E8hDxO9ShcsfeRFVp/4rkAW3WVDH3KYv4FBUs5QeL3bDFNr
	M2aCUSxGPm77wao4+XcolTgelx3/vUfJRC9ZTa1qpwqLhckqrIoLQCwPBFII/z+3NvmeOaejchepE
	O9kLSIfVQIw8d8FkRpeeViXPOameNIBniXeZmlVNv54ia4JTaw8U/tDSVrqpUmahogiKcjW06qsaB
	7ZnXXj6OLHYDFY3PL0Ifx3GW+EpiJvB3xWocbtKENr0hYiPfi1fSS6O/0nTMqHDkVAYuqiGmwuOiS
	qgVENELw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE4xN-00000006IWH-3lMe;
	Thu, 21 Nov 2024 11:02:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B8FEF30068B; Thu, 21 Nov 2024 12:02:42 +0100 (CET)
Date: Thu, 21 Nov 2024 12:02:42 +0100
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
Subject: Re: [RFC PATCH v3 08/15] sched/clock, x86: Make __sched_clock_stable
 forceful
Message-ID: <20241121110242.GD24774@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-9-vschneid@redhat.com>
 <20241120145904.GK19989@noisy.programming.kicks-ass.net>
 <xhsmhv7whhnjb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhv7whhnjb.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Wed, Nov 20, 2024 at 05:34:32PM +0100, Valentin Schneider wrote:
> On 20/11/24 15:59, Peter Zijlstra wrote:
> > On Tue, Nov 19, 2024 at 04:34:55PM +0100, Valentin Schneider wrote:
> >> Later commits will cause objtool to warn about non __ro_after_init static
> >> keys being used in .noinstr sections in order to safely defer instruction
> >> patching IPIs targeted at NOHZ_FULL CPUs.
> >> 
> >> __sched_clock_stable is used in .noinstr code, and can be modified at
> >> runtime (e.g. KVM module loading). Suppressing the text_poke_sync() IPI has
> >
> > Wait, what !? loading KVM causes the TSC to be marked unstable?
> 

> There is however this:
> 
>   kvm_arch_vcpu_load()
>   `\
>     mark_tsc_unstable()
> 
> So plugging a VCPU might do that.

Right, but that only happens if it observes the TSC doing dodgy, so
that's deserved and shouldn't happen on hardware from this decade, and
possibly the one before that.

