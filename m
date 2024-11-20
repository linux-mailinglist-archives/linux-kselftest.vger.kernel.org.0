Return-Path: <linux-kselftest+bounces-22369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEE59D409B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 17:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883161F2457C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55AB1553BC;
	Wed, 20 Nov 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbZmQLWm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95F150994;
	Wed, 20 Nov 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121719; cv=none; b=VBfKs1uzWSUKnRc4mDUdamgMEOIdLF4ju87iwYyVgC4dM9oVaIrQOHpz+ZhbUOBPa6A0eQLERRIDdFdnIqHC4llpb9xI8NlqMWq2S6SF5XM2inA/kZz/2ofCyBLEsROaye1smi/1NaZBLLioY0IiAn/PXssnzmajy50RyUg7axM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121719; c=relaxed/simple;
	bh=hmI5ldVmxI65EUniu7IXHlhGVAjmlmRhEepVsBj3yHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HC54dsjqgnXEeX5N+w1tdKcE0BNRPGh+HHtZEppFu65csJS74d13CdAAf9jDDE7szacKsgslL+uv625ulX8qUq92okSKDH1ng6xVngsdRNweRTUtfE3vB//2VCCHqEwONalUB4GtNJNFAB+/UOhXuPLtwlzI/2RXtmQkPAWFf4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbZmQLWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F11C4CECD;
	Wed, 20 Nov 2024 16:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732121719;
	bh=hmI5ldVmxI65EUniu7IXHlhGVAjmlmRhEepVsBj3yHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbZmQLWmmmhDFqloOrHNd4yk7zq1dsIkllT9SF5uvvll0QwATG2pV1ycjrppEHw5P
	 sZMIojJZMgd8G5VEWG1M0j6a41cDR/IuouRcbUEMms2HwFIqzPp/reboy6M9n0vvuK
	 V6mJNRXXet8swxaCH11Fx/Pv2yUn7fUuZT82hObC+atTl6QPJ3XZlINEVMvAa2bsFo
	 7HMtT4+usHwkxflPaBIzCClgHSBDsVV8tdWdJ3U8eKB480Sl1VsFL0DJeFcMKkST9M
	 MkYTY2gpnxWCH+uxLkWrkyquIPO429sA2Mz+/bt6VGSde9kz8OkJWvEUD9xYatR8Z2
	 FEPKOJmD/ITAg==
Date: Wed, 20 Nov 2024 08:55:15 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
Message-ID: <20241120165515.qx4qyenlb5guvmfe@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
 <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
 <20241120145746.GL38972@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120145746.GL38972@noisy.programming.kicks-ass.net>

On Wed, Nov 20, 2024 at 03:57:46PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 20, 2024 at 03:56:49PM +0100, Peter Zijlstra wrote:
> 
> > But I think we can make the fall-back safer, we can simply force the IPI
> > when we poke at noinstr code -- then NOHZ_FULL gets to keep the pieces,
> > but at least we don't violate any correctness constraints.
> 
> I should have read more; that's what is being proposed.

Hm, now I'm wondering what you read, as I only see the text poke IPIs
being forced when the caller sets force_ipi, rather than the text poke
code itself detecting a write to .noinstr.

-- 
Josh

