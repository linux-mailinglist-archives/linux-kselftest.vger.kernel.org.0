Return-Path: <linux-kselftest+bounces-23033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0C29E9446
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 13:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7FA166023
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6600226ED1;
	Mon,  9 Dec 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BPBsh1k4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE1226ED7
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747597; cv=none; b=I8d7jFEEM+nKJglmoqVGKEdFXpSqT9vw/Rn0uIu44MCQF3E2JBJiHK4q9DU0t/NsSwXn3GyVqXwmr5ohs1H/G4018OKof1jED6SyDszUzKAGfDcp+RXXyPdJDYKmOPGG+aXgmUhuJhigQpwpk8UGPyHars0eDhXsHeE1WCxzA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747597; c=relaxed/simple;
	bh=ek6JnJryzS8nkolvdBO+WcL7txRzhCqyp5AS4yQyerY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqTC+q7UQ6n+PBbJ45OvNCnIrnNT87mtV1dfyx5H/tm66F7cwKZP+wkgqMkzcuq55wsvB7NrLaetVmb8vcCzbSAbtijpVFriE+relws5zrzP2fISjur9VqM0oSOP9yrQHjpWHP7Du0H9T6K7f5lDLxEiHwtVYJwWospECQCLFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BPBsh1k4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa551d5dd72so78363766b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 04:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733747594; x=1734352394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt1cndHZ8pbXtiRxeB+O52iETLBujQEcUgkGHWv3lYM=;
        b=BPBsh1k44sW9Uvtngsyo0Z/4E0JbXC/ebAX7UVqfON71LrRfKh6Lhw20HWcf/+WQ0g
         KRFyY8FarxwJfNT9qAg2a51N+oG9jQ937eE/V1hN9T4vzfp9lAxVKm99v99uz+y8SPei
         dBmo/qRSHSf6ZOOtlyNkhPryyggxkF2m9D7kPaiVJfC2M+mw/eUtGRJA00FyxW7vPwwn
         kh/puyj7+ad1J9Rusn+HgTvKlhjaVP1rwu7s8YzubkrDhvwGI70oIOTebzCGUWKlftaf
         Qavzuhg618riQvM8cV8BBJBuyutVbnqPshwOTI5SCUJNXsGPHpyaQDoa3TlbFTJ32QGg
         RTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747594; x=1734352394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt1cndHZ8pbXtiRxeB+O52iETLBujQEcUgkGHWv3lYM=;
        b=NsiF4QIPFrWAtuiCM2Rdau6uMpDLslUpx5U4W1PqWUSTmD731gQRS8dWq6GSKmvLMz
         Z9gNPeqHCAQYC0znFqP8gErz/IIC24PndKWbuReFI2jRYslS1Qp6hZdpg5RVCRUQZda6
         uS3dJvnYTdcWggpTsgcnmOE43NKyCusbqx8kOOxdv1ueC3Kf5BmPu9GKmwsio9LnYJv5
         tB/AUNhTPgf1+ed2pwFBQ7vZdd2IArWM7KLkQTGRyEp8YafPbcK9N+CnpvXJvdmL81bi
         Koi6hZIPpcuH+yFAQPe9ngksZF+YEEyVGnVVu/ufF4629/MKOES1gvPS1nDFRQeBVyF8
         q0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgpE/0r8EIpwm1P7411m1YlzW8wQ3Ov9XbLidyI8Z8fHNukxLcxmL47zWiz+Mp8f/YbFEMV0I//rG9NBa8Mv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaieH3pH2wTxR9czO9rcfTcABM9lj4f5BVvGQEPvBUWaVdYHEi
	7Ia4HBsPNHddNfIRAR/C8Euw6yVU4tRCrwEKkrIYaAzlKfKNGjw3vZ45mcHlgVo=
X-Gm-Gg: ASbGncv0MtJI4RaitK7AoUdUrEQIQoenLDoH54IhTM3ULBtt+TXDzTi7l/81mC1RuX8
	zpwxD+NLfmxPJW3vOvrUm48hxYbLA4+GWM87q0ge34oErGZ9LDL3KAyTc0gC88IMag/C1n6Z64v
	SM1W5XT8q4XbZIQLSZxOiF/QNjEunhl0n2upq5Kyl6iwtokZbOUhDOC6jCP8NhVNlIHFXwPUXsA
	wEdoO9Slwy5CTlSMtOF2aYYoiTi9Bcn5wYVERsq69AljOCp1WthMn558ewGN7NdmZY5OX2z3omv
	ny5IEe8hg4uG3fQSyqPxX0JtJFL+gHESlXHC+LUxns048L5mv1/IoCk=
X-Google-Smtp-Source: AGHT+IHhdX0FdatIb0ng+WxBrxtwY6KW2ibAnH43Vj2dTr2Rwd6wvnDl6sDEJjcdHu0Fke7nx/YjOQ==
X-Received: by 2002:a17:907:3fa8:b0:a9a:8216:2f4d with SMTP id a640c23a62f3a-aa639fa5dfamr461325766b.3.1733747593866;
        Mon, 09 Dec 2024 04:33:13 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b5fesm672536266b.117.2024.12.09.04.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:33:13 -0800 (PST)
Date: Mon, 9 Dec 2024 13:33:09 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen
 <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
 <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel Wagner
 <dwagner@suse.de>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure
 to defer kernel TLBI
Message-ID: <20241209133309.794439ca@mordecai.tesarici.cz>
In-Reply-To: <xhsmh1pyh6p0k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
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
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Dec 2024 13:04:43 +0100
Valentin Schneider <vschneid@redhat.com> wrote:

> On 05/12/24 18:31, Petr Tesarik wrote:
> > On Thu, 21 Nov 2024 16:30:16 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >  
> >> On Thu, Nov 21, 2024 at 07:07:44AM -0800, Dave Hansen wrote:  
> >> > On 11/21/24 03:12, Peter Zijlstra wrote:  
> >> > >> I see e.g. ds_clear_cea() clears PTEs that can have the _PAGE_GLOBAL flag,
> >> > >> and it correctly uses the non-deferrable flush_tlb_kernel_range().  
> >> > >
> >> > > I always forget what we use global pages for, dhansen might know, but
> >> > > let me try and have a look.
> >> > >
> >> > > I *think* we only have GLOBAL on kernel text, and that only sometimes.  
> >> >
> >> > I think you're remembering how _PAGE_GLOBAL gets used when KPTI is in play.  
> >>
> >> Yah, I suppose I am. That was the last time I had a good look at this
> >> stuff :-)
> >>  
> >> > Ignoring KPTI for a sec... We use _PAGE_GLOBAL for all kernel mappings.
> >> > Before PCIDs, global mappings let the kernel TLB entries live across CR3
> >> > writes. When PCIDs are in play, global mappings let two different ASIDs
> >> > share TLB entries.  
> >>
> >> Hurmph.. bah. That means we do need that horrible CR4 dance :/  
> >
> > In general, yes.
> >
> > But I wonder what exactly was the original scenario encountered by
> > Valentin. I mean, if TLB entry invalidations were necessary to sync
> > changes to kernel text after flipping a static branch, then it might be
> > less overhead to make a list of affected pages and call INVLPG on them.
> >
> > AFAIK there is currently no such IPI function for doing that, but if we
> > could add one. If the list of invalidated global pages is reasonably
> > short, of course.
> >
> > Valentin, do you happen to know?
> >  
> 
> So from my experimentation (hackbench + kernel compilation on housekeeping
> CPUs, dummy while(1) userspace loop on isolated CPUs), the TLB flushes only
> occurred from vunmap() - mainly from all the hackbench threads coming and
> going.
> 
> Static branch updates only seem to trigger the sync_core() IPI, at least on
> x86.

Thank you, this is helpful.

So, these allocations span more than tlb_single_page_flush_ceiling
pages (default 33). Is THP enabled? If yes, we could possibly get below
that threshold by improving flushing of huge pages (cf. footnote [1] in
Documentation/arch/x86/tlb.rst).

OTOH even though a series of INVLPG may reduce subsequent TLB misses,
it will not exactly improve latency, so it would go against the main
goal of this whole patch series.

Hmmm... I see, the CR4 dance is the best solution after all. :-|

Petr T

