Return-Path: <linux-kselftest+bounces-22411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F89D4FE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 16:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3259EB24F1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030EA19B3ED;
	Thu, 21 Nov 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/DBLHPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCB41A8F;
	Thu, 21 Nov 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203485; cv=none; b=K7OSZrUvyEOKOCKH0GOxPF6kV8bDx56Cee8xN7g6M7ry8GQh+wzMo3iYnF4BqPHfpRygIn6Ukw0hnRmJ4LnqtJUup1BfWOMGY7NZ9NYw8p8kkEUgaThhusEZU39THiKxvKQQhe5Hgl6X1+iSoRaahNhX1ZewZ8x/2aYOcZXQ7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203485; c=relaxed/simple;
	bh=iMGDwYNrJI3EdUwArTwdQPBRSEQDPz1TvZbtZxtrmsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1nGCpfCLyWBeCbwwdmaySZTfPgXxKuIfpoWWbeJQ4hjeEGVpBILyOB6UJ8WeXMe/rEPpGMyQ1q0fjKNMluMjZ4XWS+9rmp6RVnvgMqzmjP8Z5c2Q4FEhgkLDow2c8naGhkWYQMASAiBrJ6yJMT5ObXmCdiBWAoCRROJPnEn484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/DBLHPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EE1C4CECC;
	Thu, 21 Nov 2024 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732203485;
	bh=iMGDwYNrJI3EdUwArTwdQPBRSEQDPz1TvZbtZxtrmsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/DBLHPFUgWRywDCFIXEK+SISpdl7LvUmwBPfH1doxqCCPPLV8yi72H7SxEGvNvd+
	 fSzIaQwKyP/xtQv6AuqkHTZyDEx5CScCQH6lWb8/9WKFdA4T8/TdmxYnor3vcKhXR1
	 AnUf3fE/FS5COU4mNH9kr3Um97kU+J+NqDplmdaQgU3u4nLBKFoNZapfxI5a0ikl3v
	 c009KkvNpy26xZqxPkTpdOUE+LmDgvbgFsTJNpI8zeBo7prztovd9IItUNLaDtpgNP
	 sbkH7NYSVvLtsPmTDxuM+Oq2h8LrMQ44oCpkmX3FSmL00J9k/NwBcV5ffTPKvat1QR
	 u5busJkdRwLYA==
Date: Thu, 21 Nov 2024 07:38:01 -0800
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
Message-ID: <20241121153801.es5y72zjefzvbrnk@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
 <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
 <20241120145746.GL38972@noisy.programming.kicks-ass.net>
 <20241120165515.qx4qyenlb5guvmfe@jpoimboe>
 <20241121110020.GC24774@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241121110020.GC24774@noisy.programming.kicks-ass.net>

On Thu, Nov 21, 2024 at 12:00:20PM +0100, Peter Zijlstra wrote:
> But yeah, this is not quite the same as not marking anything and simply
> forcing the IPI when the target address is noinstr.
> 
> And having written all that; perhaps that is the better solution, it
> sticks the logic in text_poke and ensure it automagically work for all
> its users, obviating the need for special marking.
> 
> Is that what you were thinking?

Yes, though I can't take credit for the idea as that's what I thought
you were suggesting!  That seems simpler and more bulletproof.

-- 
Josh

