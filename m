Return-Path: <linux-kselftest+bounces-22311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5459D2FB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF36B295F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 20:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436581D4150;
	Tue, 19 Nov 2024 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqgdvrBa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD11D3566;
	Tue, 19 Nov 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048693; cv=none; b=sN4L4nFR+I2BzAXdAeAdbeNXrIbG2C5/pIp1juRfUIWmmxmkn77Z3OwPVKyCFaBcq8vqU+amY8gVaRFAlQ2jwXsYeJF+wM89Tunj+/iDpFw2sp6GWLp5FFKaf3ndyFRlgY5NBRpWc/ijmBeoTS8PJ6WhbwAAQCBlwAzHg98LJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048693; c=relaxed/simple;
	bh=aZtx8D0JIDJUy4jb6paGGJ/YMK9y9mdX3qt+a6Plzbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaR8W2PRDDoacaYXWZHvMSCnD6cNgBGBxm5XWnpb8c4K8ngIU1omD8g2pBVb9hL9HdVuZjYDRjMdPcHdvQ9SZUFIHRtn/g0u3GLpyVQVLDjHso6Is/oITxr5df/Nprw1L0p5XIf4tzTA2ZGxmmN3iXzQKbBjdO4ejB+PXclR/3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqgdvrBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDC1C4CECF;
	Tue, 19 Nov 2024 20:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048692;
	bh=aZtx8D0JIDJUy4jb6paGGJ/YMK9y9mdX3qt+a6Plzbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqgdvrBaiDxMyjQzGHu5p8KD0C93igpPKRnUy5UtfEkVZeMzkIQnh6cOad/ipuMEy
	 njpfahWj2R+Pw7cFV/WOF3ln/QTjXH6a10DMilFsgRWhnLiymRWLkgI4WHjk7UWhVO
	 t3SicS6vDAbW1mWdeQbBEPdaPSutxU3lpYTvB+wylx3hxuogimYFLPm2J+H/cv25CB
	 ya04g52bgAmigcw7PCCBUL/QtnTsn1pWHVHOKQZM4cor/+Kdsrr1gXdNn+XJ4IDSdd
	 HY5mKjOk90Yh8I/NZniAmGJGWiWuzfbser0fX1fvvnhQUWi6aetB+obxHsJ8dDzcR+
	 7ATtWmfHSb1uw==
Date: Tue, 19 Nov 2024 12:38:08 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
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
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [RFC PATCH v3 01/15] objtool: Make validate_call() recognize
 indirect calls to pv_ops[]
Message-ID: <20241119203808.rb2yfqbuin35iye3@jpoimboe>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-2-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-2-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:34:48PM +0100, Valentin Schneider wrote:
> call_dest_name() does not get passed the file pointer of validate_call(),
> which means its invocation of insn_reloc() will always return NULL. Make it
> take a file pointer.
> 
> While at it, make sure call_dest_name() uses arch_dest_reloc_offset(),
> otherwise it gets the pv_ops[] offset wrong.
> 
> Fabricating an intentional warning shows the change; previously:
> 
>   vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: call to {dynamic}() leaves .noinstr.text section
> 
> now:
> 
>   vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: call to pv_ops[1]() leaves .noinstr.text section
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

