Return-Path: <linux-kselftest+bounces-27093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92886A3E255
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 18:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B2B7030DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0242147F3;
	Thu, 20 Feb 2025 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAYLnv3k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B021325F
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071425; cv=none; b=p6H1PRAUr62VPRdx8xwsWohlo5WxQ8Szf8jeFyD2OgN8MyyZ8MKl6eRlq+eQ/Ltt+GeNUUYGAaUk5Rr4qM11EwDha2DhexdYvnLnS9l/UV/wphM+qRPh0L8B+t3yHhwNhkeVogpzws2pFYybySS4p1CHP5mibO3cw6IbdDU70iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071425; c=relaxed/simple;
	bh=kg7PYKt74NmqPx2oKNRGx3rLvGEcdQR61JIV5w6PyfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ete71UIzIZDMa8THtgDhZ8s0kw2Go3I5ysLVjvB0+/2Of0OyXyzesXb7taRJ5t/guQCTbeFzwsi10YVJq9FFUBu33hP68lIkD2GndhL4DVM8EniTsBxNcYGKh+1sF0rt5BaaGYoFeoSEp2eLqGc9PDmeCXcbb2Gf4XZXuC8tMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAYLnv3k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740071422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg7PYKt74NmqPx2oKNRGx3rLvGEcdQR61JIV5w6PyfE=;
	b=FAYLnv3k01FlIi2F1YeCJ3tXVndpMzOw4X6OofWUa5hN9FcP+Rde/hf1/PPR6K/yuPIuLw
	ILboncMTc/5qmRsoGpL3alNawfd3guw5PGa3MuCY/GIsjxxCfv1efqf1PChvldWYvAw60k
	c4VDY1zMQ0KZ0ZU3p2/zzKl3S6PXyJE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-zilDS8wFOQ-4Ldyugi2RIA-1; Thu, 20 Feb 2025 12:10:20 -0500
X-MC-Unique: zilDS8wFOQ-4Ldyugi2RIA-1
X-Mimecast-MFC-AGG-ID: zilDS8wFOQ-4Ldyugi2RIA_1740071419
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so8905325e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 09:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071419; x=1740676219;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kg7PYKt74NmqPx2oKNRGx3rLvGEcdQR61JIV5w6PyfE=;
        b=Q+0hcqQYXajgFHbzT5eqXtN8wPF4W9yQm7G9o5cNawS7evoBp0UmStsXUzOR3BeTmv
         vkYCkMoO8ouE3jx5pfridQeeUf/Mk2IxXURwffoZReI6ex1wUfuP18j9HgH2lk+qyK2x
         LBLWxJodmVoFsfGaHTZpXoIlBl8eqAvzBeXWHxlAyzPO2b0jvzZd4tIw6RZidxPoVa9l
         oz4ISa5JSoWEbozA8oAy15r7tPlLNERDoaMWxopKIhlI0j+gure9hLRyeuu2bfjMCum9
         eJVjM0fkqmPnUbZL3s8a0afQZwfLHnf249r1xABQO6caaPwmGK9nQBEloogG6qmGybjn
         6cgg==
X-Forwarded-Encrypted: i=1; AJvYcCWjqld58o4ddcb1NiRQSEc6GDH3735ipleRKmU3UC4aLBQ4MDCrskckx903kReI0p1Fh6A0McFM5l3xHh2pdRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFOq8d6Y81Ky8s26jVjVSTYzru0KFzWXXhpL251CZEkkGqVX3
	FOcUN7HP6V9G36ADr7nuXDltV9vYxZMl8vMNQ9MRdOiQu5GSUhoJM86TDTc57pKXDHi2V+DPy+N
	uRshd3o2JxTBW7vv2tWLhIiQpSbjow2TUGAI0A/CxfF1TIuzemv0yTz1ZxerDiGF9HQ==
X-Gm-Gg: ASbGnctA9yCaQrRHe6zKIowTYYc4vnGIabGaTnj7+zsPqPcWsrvdPK/kAwOb6AZIGAA
	kvs4Wa3zWleZ92VwwXJ1ud2JwN/5OSCrFRDKLg/+ZAwCKehO8hpiWCAwWTVRAcdoaOzgPhyWc8z
	hH1o9BNkLWTfNsHe5T+rTuo07xw1UTJUqpW1rmcnCsRiaK9wfuQg20YCLEib9mjgExhoO4UhTq4
	Bfv/EmNnlB47apVWEYDyM/CiqnqC1p/PFnECDBHTtv6eWeWzaqiaPJpeop5vZFZ4vYsa5hh5+rd
	SAeWzbPgvm+1JCsdJsk6Z81LUVY7rlQIF2KyIQl+XLD3ANoKYR56a+J7Vmp3ap7K6Q==
X-Received: by 2002:a05:600c:4fc2:b0:439:985b:17be with SMTP id 5b1f17b1804b1-439ae1eaa78mr176195e9.9.1740071418831;
        Thu, 20 Feb 2025 09:10:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqI8Joi794bN8Kdq45efIzQ+6oEZ5Dcj9tQjLghCqHxxqvkD27DzVgOIJ2kmb/SIiCpoKjvg==
X-Received: by 2002:a05:600c:4fc2:b0:439:985b:17be with SMTP id 5b1f17b1804b1-439ae1eaa78mr175145e9.9.1740071418347;
        Thu, 20 Feb 2025 09:10:18 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a0558e2sm247191865e9.11.2025.02.20.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:10:17 -0800 (PST)
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
In-Reply-To: <eef09bdc-7546-462b-9ac0-661a44d2ceae@intel.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez1EAATYcX520Nnw=P8XtUDSr5pe+qGH1YVNk3xN2LE05g@mail.gmail.com>
 <xhsmh34gkk3ls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <352317e3-c7dc-43b4-b4cb-9644489318d0@intel.com>
 <xhsmhjz9mj2qo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d0450bc8-6585-49ca-9cad-49e65934bd5c@intel.com>
 <xhsmhh64qhssj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <eef09bdc-7546-462b-9ac0-661a44d2ceae@intel.com>
Date: Thu, 20 Feb 2025 18:10:15 +0100
Message-ID: <xhsmhfrk84k5k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/02/25 12:25, Dave Hansen wrote:
> On 2/19/25 07:13, Valentin Schneider wrote:
>>> Maybe I missed part of the discussion though. Is VMEMMAP your only
>>> concern? I would have guessed that the more generic vmalloc()
>>> functionality would be harder to pin down.
>> Urgh, that'll teach me to send emails that late - I did indeed mean the
>> vmalloc() range, not at all VMEMMAP. IIUC *neither* are present in the user
>> kPTI page table and AFAICT the page table swap is done before the actual vmap'd
>> stack (CONFIG_VMAP_STACK=y) gets used.
>
> OK, so rewriting your question... ;)
>
>> So what if the vmalloc() range *isn't* in the CR3 tree when a CPU is
>> executing in userspace?
>
> The LDT and maybe the PEBS buffers are the only implicit supervisor
> accesses to vmalloc()'d memory that I can think of. But those are both
> handled specially and shouldn't ever get zapped while in use. The LDT
> replacement has its own IPIs separate from TLB flushing.
>
> But I'm actually not all that worried about accesses while actually
> running userspace. It's that "danger zone" in the kernel between entry
> and when the TLB might have dangerous garbage in it.
>

So say we have kPTI, thus no vmalloc() mapped in CR3 when running
userspace, and do a full TLB flush right before switching to userspace -
could the TLB still end up with vmalloc()-range-related entries when we're
back in the kernel and going through the danger zone?

> BTW, I hope this whole thing is turned off on 32-bit. There, we can
> actually take and handle faults on the vmalloc() area. If you get one of
> those faults in your "danger zone", it'll start running page fault code
> which will branch out to god-knows-where and certainly isn't noinstr.

Sounds... Fun. Thanks for pointing out the landmines.


