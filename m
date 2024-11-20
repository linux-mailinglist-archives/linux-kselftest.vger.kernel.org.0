Return-Path: <linux-kselftest+bounces-22354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC339D3EA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1271F281C5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272261DB943;
	Wed, 20 Nov 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ew7HvsRk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66B1C75E4;
	Wed, 20 Nov 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114750; cv=none; b=GQrwG1rtKtaU8zoIVYpr7kRpp3H3M1gGh79MRZlsysnfew6OmFG5hb6j3MR1xdrZwfit+GoTczjU9s8qowCuiLCig2QO2i1BrUZtuaD6B+otOx45W4xgLKzLUtNQ9gu4XAbiVcLAraxP5Fl7Cvjc04s8ojVyj0zVxe54mtXF6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114750; c=relaxed/simple;
	bh=mgj4bvZ/X9lF9Afs6hkeLwqdCb98lX1871WUaw0D2YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lR9z8/eFuwg1UW2ePQRwhG0ltELJBe8h+TRmGaRTlARm5oVwT7vZT2ehMRj9Il+mwlkke8UP42tBVAMjqKe4wP7s1GhKdE3pxEtv9DXDbzbY0qpISnA8Cc7EtzfrtKw3h+G0wwD4VUsZwiJ+qsXsmt3VhJDKrIS0KJUUvAGz/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ew7HvsRk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RkowXip/85xKsOA9eS4V3TnfVFLeWlFM6e9qis0TUFo=; b=ew7HvsRkHFTom5sTnUqzSG0oAO
	ph2CPqO/ygxJ/UPM1WUb+pYR0aHrsOxLuya8BpPk6cbQe7m4o8R6UyxrT56fisaJpI/vFiYU6Bxds
	9kG361m6Pt6bVUEHKciM9MNv6n0DeDnr3UoPQ1HATq0bL/rvVgpKHO/CPebxjZHz2SGumyNYakGU8
	gLKwJSCZ55FiCvjyNICyvPDS/wqrke6fPTkuii22vWFlAQRkd2AK+ZRfhifvacNWLsUjG2bXsE/p7
	Wwtsy0LReGjbKYrASQ0vbBFba1zyTDzJKYiUZiSs1m4+1RHu4gw19DuBmdh21X/FztxkFnivc9Z6I
	zfyYJrNA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDmAb-00000000TrW-1QgA;
	Wed, 20 Nov 2024 14:59:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 025EF3006AB; Wed, 20 Nov 2024 15:59:05 +0100 (CET)
Date: Wed, 20 Nov 2024 15:59:04 +0100
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
Message-ID: <20241120145904.GK19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-9-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-9-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:34:55PM +0100, Valentin Schneider wrote:
> Later commits will cause objtool to warn about non __ro_after_init static
> keys being used in .noinstr sections in order to safely defer instruction
> patching IPIs targeted at NOHZ_FULL CPUs.
> 
> __sched_clock_stable is used in .noinstr code, and can be modified at
> runtime (e.g. KVM module loading). Suppressing the text_poke_sync() IPI has

Wait, what !? loading KVM causes the TSC to be marked unstable?

