Return-Path: <linux-kselftest+bounces-22395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8F49D4B28
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 12:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5D41F217AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39401D0B83;
	Thu, 21 Nov 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aGfumQ4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793A1CC88D;
	Thu, 21 Nov 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186832; cv=none; b=AQC8XXosU6910MXuQCuC5BQbrgypl4u40amRPeZxbO7IPcxh8MUZzh/ZeWbwDzSgEESUt1A6saJfe4Hi1Y5JB7FTrh+I51puby2h0tX5MABRXenMtVmv3bV/QVYoQMqGB9acYRuzW1MwIcxFohLO0RBUclwB1SDzaHcRLkC8uKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186832; c=relaxed/simple;
	bh=9gfsOjXUGyFwnFr59dC+u4M0J91DcAOQbqnLQalZcxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A00AQ33AVVtRyYGqhJML98gNYFCLGtxbWaLqi+Ip2DCYAT+0iSKiq5hHicx5oaE9Y+HaaZzD8BjgijBTSxf7mLRgXqXo0q9V7w/Ikk4CTdFv1bJlDNHs1fr8kp/Ziw+8iLAlAqPI0V614DvgaXCM0v+cs4x93ugENccqMMbOGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aGfumQ4J; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/4UY6ooFSZbuurvbSSxwnqyBmiXRU+RN7sWd/ZeHliw=; b=aGfumQ4JkaRWnYeAD+H/67VZah
	vYz0LMQIP45v3VwBZKvVWDMqLirOmn6oWsQjYIgwz13/QVVo4P7x6kVsqdCp2NSs/LWBA3X+Hzgbe
	uGH6g5kKTrVQ2NKdOtNQZvDqva01ydSWpXjvNPB+1zgOPTYAIevJFZIMJZYYFNPFL1Ifbv3PKnJZv
	OrwEY2eJ4EsvDdm0qUegKwZMVis4ARGSOAgFYvCfKVXYZcaxuES3LHkjrjuAr/MHrhw/5FzBU9PlF
	5qrPQbLKjpWsCQb1aYz5GmVU03v13aN65v2SlUcMnIeL21n/K2hMk8I4crChD6KYZLtY4/0wo5Ris
	TqUAjfTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE4v7-00000000ZU8-1far;
	Thu, 21 Nov 2024 11:00:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0365F30068B; Thu, 21 Nov 2024 12:00:21 +0100 (CET)
Date: Thu, 21 Nov 2024 12:00:20 +0100
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
Message-ID: <20241121110020.GC24774@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
 <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
 <20241120145746.GL38972@noisy.programming.kicks-ass.net>
 <20241120165515.qx4qyenlb5guvmfe@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120165515.qx4qyenlb5guvmfe@jpoimboe>

On Wed, Nov 20, 2024 at 08:55:15AM -0800, Josh Poimboeuf wrote:
> On Wed, Nov 20, 2024 at 03:57:46PM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 20, 2024 at 03:56:49PM +0100, Peter Zijlstra wrote:
> > 
> > > But I think we can make the fall-back safer, we can simply force the IPI
> > > when we poke at noinstr code -- then NOHZ_FULL gets to keep the pieces,
> > > but at least we don't violate any correctness constraints.
> > 
> > I should have read more; that's what is being proposed.
> 
> Hm, now I'm wondering what you read, as I only see the text poke IPIs
> being forced when the caller sets force_ipi, rather than the text poke
> code itself detecting a write to .noinstr.

Right, so I had much confusion and my initial thought was that it would
do something dangerous. Then upon reading more I see it forces the IPI
for these special keys -- with that force_ipi thing.

Now, there's only two keys marked special, and both have a noinstr
presence -- the entire reason they get marked.

So effectively we force the IPI when patching noinstr, no?

But yeah, this is not quite the same as not marking anything and simply
forcing the IPI when the target address is noinstr.

And having written all that; perhaps that is the better solution, it
sticks the logic in text_poke and ensure it automagically work for all
its users, obviating the need for special marking.

Is that what you were thinking?

