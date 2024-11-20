Return-Path: <linux-kselftest+bounces-22352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090719D3E91
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35DE281764
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967781DEFEB;
	Wed, 20 Nov 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BC/hsR3w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB41DEFCD;
	Wed, 20 Nov 2024 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114614; cv=none; b=Qiw24Gs8Sq3xLNqOovw6jp+mEKy0MgbOK002LYsCfk+3M+fpQL9h28qd7C0cfhec2kJVWc8THKt9XX4597JMdzhgDVJVwrdD9OkmD9+tJE5urM6fIW7TazwF15NiC4BSxChQlO8NOOpLdYmg/DP1ySz+bGjs6tKDA8MUjfuXeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114614; c=relaxed/simple;
	bh=N/+L+LKAnHPIPI0TGsIUJQK3Ce8pA3wx2Y/f3NNH7LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmkCt7Nn269FBkNnLqkyOCJjZJCS6XUnJjmn6bbgJMDtqxSf/El+9YdWJ6HF/v27SsHoCqhsk8sdkyoF6NVpgYTqZiC0vJuthaw4oO4XS27RWnpW8AbYULWRtgfgBp4T5nHlJaU8HuVk9B3Z+X1BWi8yyAi0+7bmnH1LldoZx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BC/hsR3w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Eo+mDdywb8Jf9eP+Chc4FGyJoIBcp+h8PHa9Dul2QYs=; b=BC/hsR3wyB2ZVLg1n35MzPJWh0
	4ps2oGfQYoJBpzhj0PBPmzHXL1dcC+FXsSuK40XAV7swkJ1+hSfVSMNbv7rqU2Zw8+b9o4e8p95IE
	xbdNUF88st90u4d+1wyg8keMt7R6EmNsIttlBfqCiK5B1rpDq2ONMAxC/D8EgzPczP9OwQp30UftS
	7kTIxpKMfkhE+i9EqYkJgAjMWQib0FtxVk9+4/SucfHB25kKa1Yrluxp0RS4xALoGHVgIE5W2krjW
	Gc63APPVT3AqaJZ3WYeAl2cE9iUcmdx2bNH2/1nxzf0SKfZ1MCGa9OBiARYb807zR76xMX5uypCTB
	YqmNA7Qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDm8O-00000005Mu8-2FSC;
	Wed, 20 Nov 2024 14:56:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 69FC230023F; Wed, 20 Nov 2024 15:56:49 +0100 (CET)
Date: Wed, 20 Nov 2024 15:56:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
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
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
Message-ID: <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119233902.kierxzg2aywpevqx@jpoimboe>

On Tue, Nov 19, 2024 at 03:39:02PM -0800, Josh Poimboeuf wrote:
> On Tue, Nov 19, 2024 at 04:34:53PM +0100, Valentin Schneider wrote:
> > Later commits will cause objtool to warn about non __ro_after_init static
> > keys being used in .noinstr sections in order to safely defer instruction
> > patching IPIs targeted at NOHZ_FULL CPUs.
> 
> Don't we need similar checking for static calls?
> 
> > Two such keys currently exist: mds_idle_clear and __sched_clock_stable,
> > which can both be modified at runtime.
> 
> Not sure if feasible, but it sure would be a lot simpler to just make
> "no noinstr patching" a hard rule and then convert the above keys (or at
> least their noinstr-specific usage) to regular branches.

That'll be a bit of a mess. Also, then we're adding overhead/cost for
all people for the benefit of this fringe case (NOHZ_FULL). Not a
desirable trade-off IMO.

So I do think the proposed solution (+- naming, I like your naming
proposal better) is the better one.

But I think we can make the fall-back safer, we can simply force the IPI
when we poke at noinstr code -- then NOHZ_FULL gets to keep the pieces,
but at least we don't violate any correctness constraints.

