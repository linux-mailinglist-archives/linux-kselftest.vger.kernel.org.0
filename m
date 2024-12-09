Return-Path: <linux-kselftest+bounces-23032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122AC9E93A0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 13:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E15188768E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295DC228CBB;
	Mon,  9 Dec 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KDB6uYED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F02236FA;
	Mon,  9 Dec 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746375; cv=none; b=A9xrwAUxvI95FnlHAmcInFMJvR5Oeg+6drRyaHoVX36r1vR6TGMhXTavmyj9L2oj9JD9l+dIsg9k1dFC1sATZOQFe1h3VS44gSNh5buDxztTvhpvee/gWuaJ2hFnP4MXsj0erhUdCviYT94Q060vE4VONWkTUePwKnF2vVl4z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746375; c=relaxed/simple;
	bh=VmJgxY8JyHe4LPcKfR3zGqif4VDPc4khkHgSpIUKuLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0RnniCFnX+VM2XmA8/PXlFNXrBH+lVe6nYIMeyZX5SufKK/V8gb2OZ3Y05MiL7h/EvIFm+nPkGYpdfF6QOWVzoDA7BiW+6U98B5BAzs5iRAlPB8vsguQMF3temQLYZ+BkcmHC0+2iFXH/4eCQgMNgP7rgURLkRtgOsFLCYB7GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KDB6uYED; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uVT5Gi2KQmMoQpuKPHzUhOIG+qt0YGmH2vT/S1/cY9s=; b=KDB6uYEDfLPVKzKPUOzo8eD3z6
	oLNbK1X3DwOjgnTiEsJ930xFhE1kUwiAEEcdqt5KaAZ4d7H45sMOZ72GVD2kljqEiOxunf3ZeaHBA
	oKPYPvUg3/H8lMDYDTwXM6Rjzo3HpJjJ0LrgUUuVQB8k2p0qQeVolxYqooGEDzVuPKTWy3wi+Y+e8
	zGvxiKlH+29kd/OONbtvefEtZpw66LBUJXc18/7GTsMi18v14Ast8dL4bsGmw+GEOO4agRu7V+tPi
	zhPLoXmG2VJvw23vIYnpHN0wraWDrv/HsDqCWDieYP8tz+T1YhZLA2DBIJbu9ICkjU56I2dedVPx/
	TnlD5zcA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKcd8-00000003X9M-3OPg;
	Mon, 09 Dec 2024 12:12:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6352330040C; Mon,  9 Dec 2024 13:12:49 +0100 (CET)
Date: Mon, 9 Dec 2024 13:12:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Petr Tesarik <ptesarik@suse.com>, Dave Hansen <dave.hansen@intel.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
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
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure to
 defer kernel TLBI
Message-ID: <20241209121249.GN35539@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-14-vschneid@redhat.com>
 <20241120152216.GM19989@noisy.programming.kicks-ass.net>
 <20241120153221.GM38972@noisy.programming.kicks-ass.net>
 <xhsmhldxdhl7b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20241121111221.GE24774@noisy.programming.kicks-ass.net>
 <4b562cd0-7500-4b3a-8f5c-e6acfea2896e@intel.com>
 <20241121153016.GL39245@noisy.programming.kicks-ass.net>
 <20241205183111.12dc16b3@mordecai.tesarici.cz>
 <xhsmh1pyh6p0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh1pyh6p0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Mon, Dec 09, 2024 at 01:04:43PM +0100, Valentin Schneider wrote:

> > But I wonder what exactly was the original scenario encountered by
> > Valentin. I mean, if TLB entry invalidations were necessary to sync
> > changes to kernel text after flipping a static branch, then it might be
> > less overhead to make a list of affected pages and call INVLPG on them.

No; TLB is not involved with text patching (on x86).

> > Valentin, do you happen to know?
> 
> So from my experimentation (hackbench + kernel compilation on housekeeping
> CPUs, dummy while(1) userspace loop on isolated CPUs), the TLB flushes only
> occurred from vunmap() - mainly from all the hackbench threads coming and
> going.

Right, we have virtually mapped stacks.

