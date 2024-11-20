Return-Path: <linux-kselftest+bounces-22340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8189D3844
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 11:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04A8B25006
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 10:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0624219C554;
	Wed, 20 Nov 2024 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ud7ivUQk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE80B146D53;
	Wed, 20 Nov 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098144; cv=none; b=r9MIevaYhvbRcjSlfAOtm64MYA7IT19DEHCBoW+VSBzYOEBU7LQjwO8sXhhqJLCUAA4Lru/RCF9DY2kqE/gZE1Zawq7zhlrApIVSUBfbsTTbIW0egqC4vA5r58JDH0maIvge+J7WEwMa9q4wjY8ROJpGIZlkZxnk8fDRVW2VvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098144; c=relaxed/simple;
	bh=kJQDEeMh5yQymd7/4zNyXAyvNMvAn8pbTvK9MW3F1j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1ceEiXzERU9M72UwiT+gQJZQDpcD1vFAo2yEWOzV9bIFzwkcPB6qSUasV0hEUxEqxqh655Ly8zv0k7214q8WG6q6SvaW31gsjSlTrEAjQEVOQ+PMEuoW4u+HfEsI9mt3S0nQvsZ0w+IEFBRVEQwD7L9h40wXOTUnG+FnPKmaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ud7ivUQk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6BHYRXy9lLaaBbd09VImTq6Rn50W4X4567EqZRkeTsQ=; b=Ud7ivUQkqoJelXj28zCQsU+gIU
	rPNqESkMj9Dvu0GcK3GwMBeifTq00wVepK50OM0ITEOdtka/jqFErp6Jd8j999ZICXAW3mvcrtkvK
	CusDuiYnEJ629rY55UUL/cBOjUKRFBuX/QQ0VICN6+DrH4L+Ho55jjI7IoNjs/cWvfyFbmptF1Klx
	vEhnAtqlle6ozdCc/aMWBNbBq7u2ct3VCOEy18Xvn1aIkiTLeG6uKCbmVgjwRnFMZT4eAurE+BZ5H
	x1Ct2ikx1ujlCMCd31kJ29lLgD5iVA3BgXaBQ3K/vEe5Jd7aBT4P21yj4cyyY2YhFQ7RnlBQHq7Pn
	jj1hI06g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDhql-0000000582g-0cwS;
	Wed, 20 Nov 2024 10:22:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 04D013006AB; Wed, 20 Nov 2024 11:22:20 +0100 (CET)
Date: Wed, 20 Nov 2024 11:22:19 +0100
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
Message-ID: <20241120102219.GF19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241120000532.maqzgsn7m34lti6u@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120000532.maqzgsn7m34lti6u@jpoimboe>

On Tue, Nov 19, 2024 at 04:05:32PM -0800, Josh Poimboeuf wrote:
> On Tue, Nov 19, 2024 at 04:34:53PM +0100, Valentin Schneider wrote:
> > +++ b/include/linux/jump_label.h
> > @@ -200,7 +200,8 @@ struct module;
> >  #define JUMP_TYPE_FALSE		0UL
> >  #define JUMP_TYPE_TRUE		1UL
> >  #define JUMP_TYPE_LINKED	2UL
> > -#define JUMP_TYPE_MASK		3UL
> > +#define JUMP_TYPE_FORCEFUL      4UL
> > +#define JUMP_TYPE_MASK		7UL
> 
> Hm, I don't think we can (ab)use this pointer bit on 32-bit arches, as
> the address could be 4 byte aligned?

Right, you can force the alignment of the thing, workqueues do similar
hacks to get more bits.

