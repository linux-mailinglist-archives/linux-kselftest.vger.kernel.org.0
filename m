Return-Path: <linux-kselftest+bounces-24523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3DBA11304
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 22:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EBA3A5CC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6720F985;
	Tue, 14 Jan 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4Spa79Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B820FA94
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890017; cv=none; b=jKiQQANVXni3WDIeF6E+otd16ZcFlc5mPBEg9kZ+/mEEdISUK5f4+XljIvZvDDSRmISb5/zPGZYJg7ggZGyXFlEc+ywVe0lvO8pbGhm0Rb0IpfTFQPyEJ74CCa9yXK3laNJVYGOJ5V5dkIwqXC3tEXOqzpQKYUWsc4ku74ULbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890017; c=relaxed/simple;
	bh=oPosukRuS5Ny6CBCBgfqsCfB0dNx94vYjIEcmowMxlo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e1BSUs70goCLqNCsEEnG2Ptn8lxDpb1yXokwjlZgqqSrEwWs48c6DK4ZSjatQs6xJNRSFhHKLUsZ32yjpcmVTCl6R/VYOzho+vzFQrKB+PXGhJTVKJZCS8D/Q9dHbBI3x2ZSQmnRsrtF6bYW11lwqBbUPKhFCtof8WwRj4kr8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O4Spa79Z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so15458728a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 13:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736890015; x=1737494815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8zpuNawVjToL3i20ZYrbUddkmOaJHAfbCZJnZQ478w=;
        b=O4Spa79Ze7aMx+eLKa/MTEJ2OKNEppiXGyLa0JbQI4GPFrrGHhypguuNt1Y89C0J3z
         SRnsPNOgnPv1MVdq6KsS4wOKls4USIirpkBvZRcrxPh1qD8Rqrc3ZYdbt/YINrCEyAs6
         wgr2q/lKBl4JejUObB9lWH5BCxeOypDi6QaN6QtJZZOTSYYJmqy5Cpmv5yMFFw0QyyGZ
         1sGT+N1bWdGiJXsuZacXmLK2BRtUSnu2IV+Qp4Z/DykjpOHDkq5dXpC7uTJoJuoykGcg
         teE0YPCVD/KGVN8Q9o7W1kOs2IUKfB2QWiCzLgg1P2Fzxq+4r56idZhZVrkt2FbwMFaP
         ovDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736890015; x=1737494815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8zpuNawVjToL3i20ZYrbUddkmOaJHAfbCZJnZQ478w=;
        b=BnPvzGcktPO8Taw+U6qDO851hnzQhKGwycVMUELL+2e0x74TXJff+ZuWqGeb5iAPsY
         Iv92YhfMgoJEN/tkYO3GhbvkMz66Efu3McBnDgb648hfD3bfTULiBYraBlB+nlCL5/OL
         QvPRpcsHGB3s9or4VBiu+dBdBpJg35C08CHov6UYTwGHPmCpe6tCZSOu3WjvWLW4AVsU
         ezpo1a6TSDJh3xloGVSGz7faG4TQYucpzRAFSGxcxWW745XvFiX36t/UDEGv1jEnYYnE
         y7ZaYdWc4P9zf428I7wY61xWJaw0+fl8Zd4svx+DuP5lW/UwShZh1GmkAg8AuMcej8HW
         p7uw==
X-Forwarded-Encrypted: i=1; AJvYcCWhtEnFDUlg5+PhdJ4sghxlpW2TZkjvGlnGNMT7wKxYbJ8/ZibRRO5mtKzusWjhJOGXLJYuhUS6wSe3QKA1CKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ZsJ8ZT7mFxD3kWy0b1zI51QfgpzGWMzPxuBYOA5zZJf3R8hC
	h1D1PQAjcZDKNfe/oW9ZYTKag65Vc7arUdPFBSGa/W/lgjmenHw+6JeQIgtMqQ5WVFMbh1u9VkG
	eGg==
X-Google-Smtp-Source: AGHT+IGDv4Ej+tMoSohr/AoTazwT/WbetgA7Nr8qE8BLNxmtc1cUUDk0TRGuDLxFKlrZpHzOjZy+L7iCKdA=
X-Received: from pjbsx15.prod.google.com ([2002:a17:90b:2ccf:b0:2ef:8ef8:2701])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544b:b0:2ee:9902:18b4
 with SMTP id 98e67ed59e1d1-2f548f61fe6mr37131771a91.27.1736890015061; Tue, 14
 Jan 2025 13:26:55 -0800 (PST)
Date: Tue, 14 Jan 2025 13:26:53 -0800
In-Reply-To: <20250114175143.81438-26-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-26-vschneid@redhat.com>
Message-ID: <Z4bWnWYqu1LaD-JG@google.com>
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

On Tue, Jan 14, 2025, Valentin Schneider wrote:
>  static __always_inline void arch_context_tracking_work(enum ct_work work)
>  {
>  	switch (work) {
> -	case CT_WORK_n:
> -		// Do work...
> +	case CT_WORK_SYNC:
> +		sync_core();

Not your bug, but serialize() needs to be __always_inline.  Not sure what exactly
caused it to be uninlined, but this is the obvious new usage.

vmlinux.o: warning: objtool: __static_call_update_early+0x4e: call to serialize() leaves .noinstr.text section
vmlinux.o: warning: objtool: ct_work_flush+0x69: call to serialize() leaves .noinstr.text section

