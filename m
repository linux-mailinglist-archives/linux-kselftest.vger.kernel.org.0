Return-Path: <linux-kselftest+bounces-24521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9356A112E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 22:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3213A2C34
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DB320F09D;
	Tue, 14 Jan 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7nuU18E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E020C499
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889567; cv=none; b=uL4YqHitMDBheoGsmf08VuO+KSiXD9pIx2uG6HsEpotUQlf0MfxddkjJ/5b4RuLVNLNjV9jM+mZTd2bXKmvo4VUqiNzND2BniByzlATWg2kGNSFawfDeCnsFds5JU1TRGvRMUiQH2JctH+eD/CTYnBr3yN8Puz4MTpmGPB5EtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889567; c=relaxed/simple;
	bh=75fcOSQJdhmnq3pSXnEyg1Dd9Gtm+vOQTHqw0XM6WTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W+CU1kz6Qn8mAoBvC37d9skvG208GjSu8gH2irtaRzUds87qnXjJSXgaKiPVpk674/dELQ6eKRAk78p+D6Qi1UaidMU/hWetrTCjnQj9/426HArdrMbWkS4jjlcPzN6ip6QH/Lmyg1PJZJA+EvF/rdR1XkQ0vRcVk2lkUs6saj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7nuU18E; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21650d4612eso156688435ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736889565; x=1737494365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XVbipT56M6kECF5Qh7elLUxboyXWurLrq3UYAkefsoQ=;
        b=e7nuU18EDzPa3x8Kv50KAwIViJ8EPVBsM8MUymYFL554zqnQ1k0kqdoOwE3/zZQ34h
         Zv5YBf6P4119SdKqRmOkS2GHI3dYXbrKdvCaaBEtBWjur2h43o7w6H1c1qPGdelkIXtu
         G7QTE76ZXoSySqTwRVnARtjL/8scp3WMC17ND1v2G7n2zP0FoP0cT2p5APgCFHADwvYa
         x5BgORDkBXQ57agb+txiv4aM780ASXxK3Si0GYmHYXL3vkmktoiKTk0r19w173jsgjiD
         jVgFCBVahj8ghRhFddNQztthZmy4qdGT9lHECb9JKGBk2A4nMITQ8kOoercLllCH+Alb
         Akkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736889565; x=1737494365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVbipT56M6kECF5Qh7elLUxboyXWurLrq3UYAkefsoQ=;
        b=WOjATdaIGF4ImOs3SOOwXQ5AEulX9ilQ53ZYl7gOnqCiOR2JywHWBhzZV0qQ2BDjRK
         U0nLC+zzN2Gmm0xp8WkNDyVRtNXKQBHbXcenaC5PZRrKnpi1HwN/KVuysl+oQy9Lxr2f
         2z9FZDKt8Ke5mYg0AtooLbmw9TqAwWKYH9u+b4RtfBdBM1X2x3zWGVG8mAXn8UX3X58D
         JBFG1mLtLeMlDeK4QuliI19pDlkvmNKsGEDyr4QPMyXXkjYzK53RE1IpBwJyrY/0nyJI
         o1ru1x4nBPbcOWMQ0eSI9u23s0QApR4GJhBQ+rAuGk3oaQP8v8tQgKJeHCz8tnLEyN/Z
         e2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUb2/crTSDdw2SZj9bXfe3zO9MluVAYlBF0m2yP4N72cNBqgL3Xh3vmyjmGkmhTEN6GeXBkf/kI90xSwZbZAwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0B67b6h5hsbKxZN1sBqaSUIULvb5mINRcaa+PZwSNgXWkyxCR
	7qHQwMwEvlHQKRMdPCeeRz/miJ1a0+dgDAH9SQ8/fdclUUpeYvmLMDyI79aq6UgwATr8gJoOkoz
	cEA==
X-Google-Smtp-Source: AGHT+IGTMIc2Hr+w/ebVVGGlbFAB7WFV7TbQJLIjfH34Jlhrw+YYPMlrag1B602JmLWOQ4sU4fLE9W3Pz50=
X-Received: from plap13.prod.google.com ([2002:a17:902:f08d:b0:217:8109:e87])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec1:b0:216:3dc5:1230
 with SMTP id d9443c01a7336-21a83ffc1dbmr401799985ad.42.1736889564696; Tue, 14
 Jan 2025 13:19:24 -0800 (PST)
Date: Tue, 14 Jan 2025 13:19:23 -0800
In-Reply-To: <20250114175143.81438-19-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-19-vschneid@redhat.com>
Message-ID: <Z4bU2xlZXh53lgH6@google.com>
Subject: Re: [PATCH v4 18/30] x86/kvm/vmx: Mark vmx_l1d_should flush and
 vmx_l1d_flush_cond keys as allowed in .noinstr
From: Sean Christopherson <seanjc@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
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
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="us-ascii"

Please use "KVM: VMX:" for the scope.

On Tue, Jan 14, 2025, Valentin Schneider wrote:
> Later commits will cause objtool to warn about static keys being used in
> .noinstr sections in order to safely defer instruction patching IPIs
> targeted at NOHZ_FULL CPUs.
> 
> These keys are used in .noinstr code, and can be modified at runtime
> (/proc/kernel/vmx* write). However it is not expected that they will be
> flipped during latency-sensitive operations, and thus shouldn't be a source
> of interference wrt the text patching IPI.

This misses KVM's static key that's buried behind CONFIG_HYPERV=m|y.

vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x241: __kvm_is_using_evmcs: non-RO static key usage in noinstr
vmlinux.o: warning: objtool: vmx_update_host_rsp+0x13: __kvm_is_using_evmcs: non-RO static key usage in noinstr

Side topic, it's super annoying that "objtool --noinstr" only runs on vmlinux.o.
I realize objtool doesn't have the visilibity to validate cross-object calls,
but couldn't objtool validates calls and static key/branch usage so long as the
target or key/branch is defined in the same object?

