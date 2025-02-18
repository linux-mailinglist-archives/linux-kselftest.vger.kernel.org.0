Return-Path: <linux-kselftest+bounces-26907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A462A3ABDA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810513A86E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747A1DC9A7;
	Tue, 18 Feb 2025 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvSDRWjQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FE1D958E
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918441; cv=none; b=JeWUvqO8CTQDdmidbHXPlBX+BfmAxsa3vRoxAdTupewWyElVpDtlqBpnvQy3ikwMmlnoIJAqOSdFbninNmJ80t6NSeDccPHuET9vja0RwwCywyYJoRpWeRy8PcpJVtYmBNyhgvTiF5x8az5lXdbHgEMKsZzltZ1DYuns4ZULOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918441; c=relaxed/simple;
	bh=ivyLIcXrK8i6Sm3bd5ok9RWHX3VEX/cjKUj/8oDDJcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mp1X0B/R+MIjrU4mJkDHvT3CoJbFZa0PklT0dS1a1hfHfG6pBkRIx9YOemt0xN8MMuVlMryf6IksqjOXnRrfYQbIAwuNEJhpJttuUXdtGC9xtt/JdD+Nr0wZvQRd5y+edeiKkrtSabHxZeseY/f15EYvW6ICheGPM1y7n/8Ga0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvSDRWjQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739918438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivyLIcXrK8i6Sm3bd5ok9RWHX3VEX/cjKUj/8oDDJcE=;
	b=IvSDRWjQdRT4NGhiLewqXrvQBjvpefMgEe0SOgJq2yYLYqH11psVSMyQzhuaeplKwQUkdE
	LBmOAI4AKSyzvglau5HjGQeUY7Cru6gGTs8WQiQUx1dBTPSitWTLr8VhR8bnOF+f1tm3na
	CRPw44/drwXLsGZnG2r5HQGa2oaOxZE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-iKhPIujGMGSXjmF_UuchYg-1; Tue, 18 Feb 2025 17:40:36 -0500
X-MC-Unique: iKhPIujGMGSXjmF_UuchYg-1
X-Mimecast-MFC-AGG-ID: iKhPIujGMGSXjmF_UuchYg_1739918435
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4388eee7073so961985e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 14:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739918435; x=1740523235;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivyLIcXrK8i6Sm3bd5ok9RWHX3VEX/cjKUj/8oDDJcE=;
        b=O+ej8PwqD3+fF5gMOf1xP93IMm/Qic4ESICNb1bgPniwDPn0DemJLnr2w2VYADoUnO
         ba6TmSRtM+HOoHC/51TLDUYrDyrzWXbkDkRWQBVm+jgM6w1ErfiLx+Ez5FTMrGnRFliO
         L4S71sQS6yQ7per4iR1YTFGTxIycgLw0yJByIA53AUtdFZV5uTcjFOwMLHcN1nRU+Zbl
         EHP7AZPzDdTDXSv6t5a2mTnJB/fAFnbcRui0aHh4J+cgjp4YEcbGOHHvznpoGfUBEFmv
         7LOadIiFue3eoJUT705DAeuqRSVfgwIoDeOAGnEUisXwH3e+H4jqSiZdtM6m6cdT4OWJ
         6n4w==
X-Forwarded-Encrypted: i=1; AJvYcCVFZUolArme0m2eGz+PB9rHS2uW+YKyHKNbk562naW2f6qt+vvnoZJALLbMUhyDPFcKA8AWJcz6WYUcstAZbA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSMods1gfJpL8IfsG+2oHMVlG2ZmPUAZivd5jJBV8VO5z4ZA0h
	1BhOrP1fbmmD2yTwpDbWgOe7ZfiwOIx1y8x5wM8YH087NCZoBuI2tuMrDKfpItx2rD7F+OmuDGG
	Aj7BKEBc4b8nEUE+7Rl31FWYib1uLfhXaSXi2t8sVaigmCR4rUlcyXrv3eS+de3chCg==
X-Gm-Gg: ASbGncsXx8zYBfWwOP8aiKRjCT9PY2mpK6p83YjbKW5ifB2TuoEdoB4Y+ZU+oygtzz3
	oeLTg19T+U4J9SSHYfbk+4RbILUl6w/ws077/SQM7Erb9YLADFOPmD6+u6xrVadCJerEmub4TUC
	SJwHuSYQ9rOuZB6VBjCKneK0aTNGyQnPZz4VcJ7/O2BujBeONsnKoRjnC1a2i+RZOqMC0yHC2wA
	cDu66mIc/JHpggDQAoG1WRnNsSLmMlBFP3z0pu/B/gwyA2FZKijOT6On8dM5dbR1LQwc+beKmsy
	dsH6unc/R4tTHy3IlKYJaCqokqhAycZ7m/uy6u/3cfGeUK+CImCZQzTxQ2DkWdW8OQ==
X-Received: by 2002:a05:600c:314b:b0:439:86c4:a8d7 with SMTP id 5b1f17b1804b1-43999ae0dc8mr11798075e9.5.1739918435433;
        Tue, 18 Feb 2025 14:40:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI17xveq4qpUoXVn3jaf3vZekMu127UgmikmUhaFlSZ5tyuyrG+gdqtYt1+dNUau7VWeDZUA==
X-Received: by 2002:a05:600c:314b:b0:439:86c4:a8d7 with SMTP id 5b1f17b1804b1-43999ae0dc8mr11797275e9.5.1739918434928;
        Tue, 18 Feb 2025 14:40:34 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43993847f39sm32922065e9.14.2025.02.18.14.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:40:34 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, Jann Horn <jannh@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <352317e3-c7dc-43b4-b4cb-9644489318d0@intel.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez1EAATYcX520Nnw=P8XtUDSr5pe+qGH1YVNk3xN2LE05g@mail.gmail.com>
 <xhsmh34gkk3ls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <352317e3-c7dc-43b4-b4cb-9644489318d0@intel.com>
Date: Tue, 18 Feb 2025 23:40:31 +0100
Message-ID: <xhsmhjz9mj2qo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 11/02/25 06:22, Dave Hansen wrote:
> On 2/11/25 05:33, Valentin Schneider wrote:
>>> 2. It's wrong to assume that TLB entries are only populated for
>>> addresses you access - thanks to speculative execution, you have to
>>> assume that the CPU might be populating random TLB entries all over
>>> the place.
>> Gotta love speculation. Now it is supposed to be limited to genuinely
>> accessible data & code, right? Say theoretically we have a full TLBi as
>> literally the last thing before doing the return-to-userspace, speculation
>> should be limited to executing maybe bits of the return-from-userspace
>> code?
>
> In practice, it's mostly limited like that.
>
> Architecturally, there are no promises from the CPU. It is within its
> rights to cache anything from the page tables at any time. If it's in
> the CR3 tree, it's fair game.
>

So what if the VMEMMAP range *isn't* in the CR3 tree when a CPU is
executing in userspace?

AIUI that's the case with kPTI - the remaining kernel pages should mostly
be .entry.text and cpu_entry_area, at least for x86.

It sounds like it wouldn't do much for arm64 though, if with CnP a CPU executing in
userspace and with the user/trampoline page table installed can still use
TLB entries of another CPU executing in kernelspace with the kernel page
table installed.


