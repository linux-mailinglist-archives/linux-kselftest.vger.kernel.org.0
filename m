Return-Path: <linux-kselftest+bounces-22353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900179D3E98
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568CF281B7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869941C4A2F;
	Wed, 20 Nov 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q91erEAQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6E1C57A5;
	Wed, 20 Nov 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114670; cv=none; b=M+StwRJDayqefBJ2MsYgjsaQr7Pwg1pxE0aFm9DCxf/H9cSf/K86zxmbQ04j4oFotKHwhVkduNzIr3QjnBoIopGVKQ2zrz9RNVahkNTZbf9X2r/6KSSpCeqHSCeCUpv4RgJ3TC89tAlXkJ89QalM8ta64T9wekeSFdUsYuAzQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114670; c=relaxed/simple;
	bh=w4RwPLlFWRfw71b5zlZiK0uQ/mhhhRbkndbVxlkKVxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmjXmv8ofnjMIxyvIq7GJ9oY7A9oV9pHTF8I2GErlTsYuchZvrmTs7bb5WV92zhzOZSc5ljel/HATvL96VPRAwwMxR4M6aoPoLI9zrkNIxddLebzajKL0GFeaG8UCfzhvewbXwbLELhL0sDy5ndh8roysBC0Pa+GYzuELL5uIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q91erEAQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w4RwPLlFWRfw71b5zlZiK0uQ/mhhhRbkndbVxlkKVxE=; b=q91erEAQYnhO6SfqnSd5192dsu
	TqmUxmxU42V0DCFscJVyv7suDTDbuCguDIG4UHdvpu6y2+t82htk8umoOsHCgIuShf63PZRJ4n/DL
	m5OI36m7dcMC4WYTvPhcUsXymjngJuHK8rzEE4/hnL68pXrGHFdexCyA2HaKm3Ue2oM/yXBW9fSBb
	RoI48xNyA/c2G5AoPjyKbD1fgE/Q6donR5arZSuCXM7ldb+3RN1xSrK6T37B24YTKEomu2ldBFIhj
	vgDoNYHII0bMtq6zSccJvlvraP++zCqREJM3vLTgblrxAkrFSqxssrc85DQ4DiI5zYMvOrfamAd4S
	uvjrPf8Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDm9J-00000005Mwt-2JtI;
	Wed, 20 Nov 2024 14:57:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 722643006AB; Wed, 20 Nov 2024 15:57:46 +0100 (CET)
Date: Wed, 20 Nov 2024 15:57:46 +0100
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
Message-ID: <20241120145746.GL38972@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
 <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120145649.GJ19989@noisy.programming.kicks-ass.net>

On Wed, Nov 20, 2024 at 03:56:49PM +0100, Peter Zijlstra wrote:

> But I think we can make the fall-back safer, we can simply force the IPI
> when we poke at noinstr code -- then NOHZ_FULL gets to keep the pieces,
> but at least we don't violate any correctness constraints.

I should have read more; that's what is being proposed.

