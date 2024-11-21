Return-Path: <linux-kselftest+bounces-22416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F99D53E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A636DB22A26
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C81C230E;
	Thu, 21 Nov 2024 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOqjNU7Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF81885B0;
	Thu, 21 Nov 2024 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220470; cv=none; b=T2eRdSWOGOES+WCaUjKu5dM8QwZN7ycNHs+MOsM5MQ+oAhXGQyJkhCvEjBrLo076TgjX57u/mfCUwZ/yuxfCxkx0rEtUuKbtt/ocrM+zv7sXY+pszoeECcVOsSxtJx3MKUt2kXFEg0fw5S+Nd6h+seTmNi9WCvH5ydPu6jFgcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220470; c=relaxed/simple;
	bh=wNYkfuMHGFqeyTu02+G0cxoLxThoICjuoPLXY/5UBYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uklgf66FieT6o14W2A8UAL6pUkr4rY1Qb8jsc+pjb444MItKgXGOBmbZC8G4Ar/0xDtVXArw4dhnYPb/TH00pPkRCI2o6VZ2kHyiPkG0SNfl9+t2YHuFviTlxmLT/bFtyQA3BiuhMq1UTmXEbKMTMj3ATtpo11VTpNJ7+6EFSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOqjNU7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F078FC4CECC;
	Thu, 21 Nov 2024 20:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732220469;
	bh=wNYkfuMHGFqeyTu02+G0cxoLxThoICjuoPLXY/5UBYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOqjNU7YKRRxGlU4c8C939Ds5dQ3oWgCHi+HIi9SAWqhPZoTnaadXgUOKBADkM39p
	 bKpk7g8t61Qm8fZ+XutRzXLc+fMlHcfWWYf4ErODUfSTaQzEDMDnBtGRGjhKTWJ5nq
	 sBttLWdygAiNOBZEQ91PPHm0TUdHHLy1wNXLc99AyW3xbzRVYuQb1kYgS4r/PFeY/e
	 t/Ildf4N3ekcAFa6CEAIhWFEoPBehSXKK+GqSFk0ijuCbucPr+xzJFwlUA5eLkqff6
	 cpmyLXfIcSVA56+JnbQEFKYu5YhmNFA0tldkKGGPV+K3l7DuzWYdVwRgJiiHCFIffG
	 DY7/UWJzfaJag==
Date: Thu, 21 Nov 2024 12:21:06 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
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
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
Message-ID: <20241121202106.nqybif4yru57wgu3@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
 <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
 <20241120145746.GL38972@noisy.programming.kicks-ass.net>
 <20241120165515.qx4qyenlb5guvmfe@jpoimboe>
 <20241121110020.GC24774@noisy.programming.kicks-ass.net>
 <xhsmhcyioa8lu.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmhcyioa8lu.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Thu, Nov 21, 2024 at 04:51:09PM +0100, Valentin Schneider wrote:
> Okay so forcing the IPI for .noinstr patching lets us get rid of all the
> force_ipi faff; however I would still want the special marking to tell
> objtool "yep we're okay with this one", and still get warnings when a new
> .noinstr key gets added so we double think about it.

Yeah.  Though, instead of DECLARE_STATIC_KEY_FALSE_NOINSTR adding a new
jump label type, it could just add an objtool annotation pointing to the
key.  If that's the way we're going I could whip up a patch if that
would help.

-- 
Josh

