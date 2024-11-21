Return-Path: <linux-kselftest+bounces-22398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6A9D4B4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 12:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFBFB23CA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 11:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F61D172C;
	Thu, 21 Nov 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZnnDDvKB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F11D12F9;
	Thu, 21 Nov 2024 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187545; cv=none; b=fy6YIfi87JWiwPnbY4Ausizuw5mb/9iTbVpm8LXfeP+I756jVyJg/U+PU54SHV5yxSJamSRuR5Fsie3lG3bkreIMRtHm026b74iVpngQXbxDBcVqNo+PjvqJn4zDqcYfxI91wWEpN4km9m8CCoJLM5PqoTakbgEgYIXZg7nA+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187545; c=relaxed/simple;
	bh=46rZ8pT6LBDo++XU0X4+ubvk4/TsYvCXkojRMgrCm2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FURfCPbmDZFgieMSS7iDo1dmSjHpuAfrLPC7iH8YTI3SOVlspiwFOmZj/z8Xoq4XmuavEo143DHWsQjJtFnnA5NXO/3fKUFevl9GaAJ1TDwD8jjpbLgFY7MOZBWFsZBOHIUJej9Jj9+6vUu65CnjgyAXp7G1UAZULLBL7PYGKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZnnDDvKB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7u6hZNi/XuzFou5ujdfwghsus0DK9jsxshgCxjL09s4=; b=ZnnDDvKBvItXFztIL1wgf8XTMK
	ewcwZjNRWSYrjZH+rZT6o49FOe/kRo9OZGytGd+voz+HNGUcuH+PP2GaYPZHs4m/S9nn234JQU+s0
	jcVN8NhToLe9FCA+qM5KpNzoUaPZLKtrF3vHdq2UtRbclGSqWbGDeyTL/5pPoGHMpsaTGnJ6Ar+wJ
	2CDFUxa1pB5WeOoE/5nHHErJ8ykxvkEDM06/dAOiCtOt+bGYezuZWGNQI8o2HOKhnZqVGCA34MRgT
	P2M6Z3Vn21k+nDAjOFXWjNQOUddBYU3AChzpcJxfmgAg0CxIN4kwolN9vrfeY3nk6x7i3pwoH4jPE
	4WMvU03g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE56i-00000006J1a-2zVQ;
	Thu, 21 Nov 2024 11:12:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D85C30068B; Thu, 21 Nov 2024 12:12:21 +0100 (CET)
Date: Thu, 21 Nov 2024 12:12:21 +0100
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
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure to
 defer kernel TLBI
Message-ID: <20241121111221.GE24774@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-14-vschneid@redhat.com>
 <20241120152216.GM19989@noisy.programming.kicks-ass.net>
 <20241120153221.GM38972@noisy.programming.kicks-ass.net>
 <xhsmhldxdhl7b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhldxdhl7b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Wed, Nov 20, 2024 at 06:24:56PM +0100, Valentin Schneider wrote:

> > Oh gawd, just having looked at xen_write_cr3() this might not be
> > entirely trivial to mark noinstr :/
> 
> ... I hadn't even seen that.
> 
> AIUI the CR3 RMW is not "enough" if we have PGE enabled, because then
> global pages aren't flushed.
> 
> The question becomes: what is held in global pages and do we care about
> that when it comes to vmalloc()? I'm starting to think no, but this is x86,
> I don't know what surprises are waiting for me.
> 
> I see e.g. ds_clear_cea() clears PTEs that can have the _PAGE_GLOBAL flag,
> and it correctly uses the non-deferrable flush_tlb_kernel_range().


I always forget what we use global pages for, dhansen might know, but
let me try and have a look.

I *think* we only have GLOBAL on kernel text, and that only sometimes.

