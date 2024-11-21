Return-Path: <linux-kselftest+bounces-22410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3329D4FBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 16:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E879AB28073
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74761865FD;
	Thu, 21 Nov 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jtbwyGXC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993B1553AB;
	Thu, 21 Nov 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203021; cv=none; b=oOrVJU6a/UqtsxndvDzmHU8e63LW/zWUbW7ZIKVf47v5wOM7b78uR5QA4C9dvxr7oo5HrZG/rE7AGLDE1QPGSwpf+68nApjnMAc6gnxB50sTtRzrTqhcLXgxFe9okfO6d9iQMG1nNuBpO27WfMykQuQFAwH7UMfhxrFW/YyWU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203021; c=relaxed/simple;
	bh=t1OS0SZ4JnSMKv7XRJ70eysyTs6yIg/uNEDpFJowCak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUqcPhvNphSBgYEGneiMuI/oqQ0xehM2cq7QsoMybNcAAG1XMxGkht/LQSL2m8XtwRnF016jnc8ZtAtJSFt30OE70mYUaYTOqZjlGfgYnePRLxe2euJzc+YyVb8z9Fb+49orh9r07sErPgpKsVsRni2fIPszjTWFemzEzorgLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jtbwyGXC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=idhvmbSpjgyt1zH7fW+NeMIym2Pxx0s6Zv4Z+MCkqpE=; b=jtbwyGXCj+fwhrEMqG86bsZNay
	X+Nhdx5L2GrnjsPVKZMH/9Xlth2dXn7V1q8B2uGnwZSnS6VwBnDlo5l2mF+gNGa53bifeHhjLxjzg
	LuuxbLivsvnoJwHFWwJ9HtpsFFWT8w0DB1+4DsJiSAIW+c3l+jOZYuC50VHY94USWDg0cH0Q7S79T
	1ZsOjEJHR7cDhHo4Vg+1JyCeUwWbUtSCdu8Z1iaCD/rwUxfrFtSe4/gPhcmFLw431+Dp/q/9biI53
	QSscxd44bVnld3NBcnhmjIxaeXKZ8sAp+fCs+CkEKohDWDGM4zASCp/XotZ1Hh/spjqUWQHzjx5dH
	aH1ns5Yg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tE98L-00000000av5-0FLU;
	Thu, 21 Nov 2024 15:30:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3DCD6300848; Thu, 21 Nov 2024 16:30:16 +0100 (CET)
Date: Thu, 21 Nov 2024 16:30:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
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
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure to
 defer kernel TLBI
Message-ID: <20241121153016.GL39245@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-14-vschneid@redhat.com>
 <20241120152216.GM19989@noisy.programming.kicks-ass.net>
 <20241120153221.GM38972@noisy.programming.kicks-ass.net>
 <xhsmhldxdhl7b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20241121111221.GE24774@noisy.programming.kicks-ass.net>
 <4b562cd0-7500-4b3a-8f5c-e6acfea2896e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b562cd0-7500-4b3a-8f5c-e6acfea2896e@intel.com>

On Thu, Nov 21, 2024 at 07:07:44AM -0800, Dave Hansen wrote:
> On 11/21/24 03:12, Peter Zijlstra wrote:
> >> I see e.g. ds_clear_cea() clears PTEs that can have the _PAGE_GLOBAL flag,
> >> and it correctly uses the non-deferrable flush_tlb_kernel_range().
> > 
> > I always forget what we use global pages for, dhansen might know, but
> > let me try and have a look.
> > 
> > I *think* we only have GLOBAL on kernel text, and that only sometimes.
> 
> I think you're remembering how _PAGE_GLOBAL gets used when KPTI is in play.

Yah, I suppose I am. That was the last time I had a good look at this
stuff :-)

> Ignoring KPTI for a sec... We use _PAGE_GLOBAL for all kernel mappings.
> Before PCIDs, global mappings let the kernel TLB entries live across CR3
> writes. When PCIDs are in play, global mappings let two different ASIDs
> share TLB entries.

Hurmph.. bah. That means we do need that horrible CR4 dance :/



