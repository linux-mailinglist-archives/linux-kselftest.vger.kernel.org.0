Return-Path: <linux-kselftest+bounces-24744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF1EA1558D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 18:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACFB168E97
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A41A23BB;
	Fri, 17 Jan 2025 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ag2GoeL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94CF1A23A7
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134132; cv=none; b=EheifbqUP35yU+z7p5q17d2o2UwmIrsQwx+0/bnJZtFAUdl35r+U7RV5wHnorTQkA1rA8kTDQlE0wPhh0IqKaOobgLENES1JI3gzglkiO9VCCkpJkFeNqY4uGy5uulsEz8M3yl82KNb5/ZMbf0cy5c09n8GUnkfqXIYYwYdHxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134132; c=relaxed/simple;
	bh=0MFya64nSwrKA4zsNtkUtWH4IKaadp8mDbPpC2PlrFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SJDvZwx7ZgASolCejPkjfkr6xaMIIE+9lqXocvihumnzj2mIURFtEgSEyzqyZRxOndIFIej4/+tRTUrakNRvYz/x3/sp17Mx6UituooXbpaVVrzYYT3dedbCGiRsRNKlvwWirBt6J8Iw7yC83NcC3EtzAipAfmz2BdUcBQ0JfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ag2GoeL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163dc0f5dbso46348705ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 09:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737134129; x=1737738929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pcx17eniD+ASjh3teIfjrJN/d55a+1SMCIjE05N6Y0=;
        b=4ag2GoeL9Uij5dXXikR/tga2oE333+Z0UZd8JXsw3kqqlw23y0O2WI2cTxZTydYu+y
         maXvrtsG9f/N2QLF8f0bu94m9UUcknp5XYbNi74iypZwo4tFIhp2HhWkkEyjzhf2/U0H
         32YrCRpcmMESOO9ydGjpPlrOkkT3DrRZDdYaUG+6HBYzGmgaskztkRyu5gZTkA934dSS
         O/iA2JJBQinlPO8c5/kzcRCIXdRGBOggWL5m12u/hJpal2N3y59MNhdHTraWJil+EdMo
         PHfryZI3ALsHyW3L+tvcA2D983kD9zAGO5rqwFI43pqgco9MISMa0ubHWJ6wQQmh/Caf
         IjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737134129; x=1737738929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pcx17eniD+ASjh3teIfjrJN/d55a+1SMCIjE05N6Y0=;
        b=ewG8DoCuqv5SU0xHPrVJpycUSrB1P37bxuFsMj9u8iaXwTdcRCmOH8JpQYEtTufHZE
         4wOPqYo8Ldu3XRjLgRsy/ABDl47d3+c/AFgQ/5exyejtezbF6Zwxg8qs+uZGOcDQdE+P
         7VnpYnJQg5iFbpOn7ieb49CbFJxXPzosDWYHekXQw9mJItwt20xJDyDp/tXeB9AkapwY
         zEJmD2E9O+9wRNCSd/QKCgrE1KCga9aoiIsI5qXo6LZTRdGW9jubv597PJ5nSln+ttlk
         reol5cKuOP8FpIrC6cJUisSCgVphJ3xKHpdciJ14hCGXEmKkWnXR/kRNrpQZjfSK251/
         4V7w==
X-Forwarded-Encrypted: i=1; AJvYcCW5Estch6uHvfYtRnnSk9y6BRpsFf+7izy76024O9WIBZLHMAnSC/c/XhJiFjhp6Hs8OhUKhJJYzJF0+oiNdGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkT/QVlVVsofONQ42SEJTsa2Jw3ISnrU+a0nigvxyXZM9BPWSn
	rxdjes24csGGdmreK18gN04GG8Mbq1B38ypWUEv1dOLhqSgjZLdUHRsOVNzRjmlXmaTM8eIuzvc
	7aQ==
X-Google-Smtp-Source: AGHT+IFBt8EUJmCBrYJSR6SbgIXxnZj6fm10TNGjaAj4XRK+x0dRIzGirCE9VGAaKkDPtl0zEYTqCFRnILs=
X-Received: from pfbcv2.prod.google.com ([2002:a05:6a00:44c2:b0:725:a760:4c72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:148d:b0:725:eb85:f802
 with SMTP id d2e1a72fcca58-72daf930e3cmr5815077b3a.2.1737134128872; Fri, 17
 Jan 2025 09:15:28 -0800 (PST)
Date: Fri, 17 Jan 2025 09:15:27 -0800
In-Reply-To: <xhsmhed11hiuy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-26-vschneid@redhat.com>
 <Z4bTlZkqihaAyGb4@google.com> <xhsmhed11hiuy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Message-ID: <Z4qQL89GZ_gk0vpu@google.com>
Subject: Re: [PATCH v4 25/30] context_tracking,x86: Defer kernel text patching IPIs
From: Sean Christopherson <seanjc@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra <peterz@infradead.org>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 17, 2025, Valentin Schneider wrote:
> On 14/01/25 13:13, Sean Christopherson wrote:
> > On Tue, Jan 14, 2025, Valentin Schneider wrote:
> >> +/**
> >> + * is_kernel_noinstr_text - checks if the pointer address is located in the
> >> + *                    .noinstr section
> >> + *
> >> + * @addr: address to check
> >> + *
> >> + * Returns: true if the address is located in .noinstr, false otherwise.
> >> + */
> >> +static inline bool is_kernel_noinstr_text(unsigned long addr)
> >> +{
> >> +	return addr >= (unsigned long)__noinstr_text_start &&
> >> +	       addr < (unsigned long)__noinstr_text_end;
> >> +}
> >
> > This doesn't do the right thing for modules, which matters because KVM can be
> > built as a module on x86, and because context tracking understands transitions
> > to GUEST mode, i.e. CPUs that are running in a KVM guest will be treated as not
> > being in the kernel, and thus will have IPIs deferred.  If KVM uses a static key
> > or branch between guest_state_enter_irqoff() and guest_state_exit_irqoff(), the
> > patching code won't wait for CPUs to exit guest mode, i.e. KVM could theoretically
> > use the wrong static path.
> 
> AFAICT guest_state_{enter,exit}_irqoff() are only used in noinstr functions
> and thus such a static key usage should at the very least be caught and
> warned about by objtool - when this isn't built as a module.

That doesn't magically do the right thing though.  If KVM is built as a module,
is_kernel_noinstr_text() will get false negatives even for static keys/branches
that are annotaed as NOINSTR.

