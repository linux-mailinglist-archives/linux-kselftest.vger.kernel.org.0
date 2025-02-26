Return-Path: <linux-kselftest+bounces-27631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1EA46712
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC253A8B86
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7419005F;
	Wed, 26 Feb 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+gLlw62"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEEA1A01BF
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588779; cv=none; b=X/5I6VsqsWc8Q0fE80UASGYVFmmhpI23FdE/ADUq8rCq63JJtx7RgnjRpJUMru7/qT2R8vjs6Rphj/FikQVyjFC8SeSEMxJ7nGXugh5mtr4Ln8tbWOMGEfaMWh/Ab2Bx31H9UqQqrrexgRilm7ndA/q7uQmyqRX7CwVBhiiXum8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588779; c=relaxed/simple;
	bh=Qf/Qm0nkzf7U3vlvRsLDs3vQoV9ABJSWnA6WtOiN2ig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D+58hBp18OmDeZCFEqakEaqutkwmrX8DtPYDjTlAuSdBGYHLKcmxoMv4f1FHlZFRZnLD3kyvCEcIU02GG63pERlP9qjhyrHPTXsajXPXknR9H+qrcI1fmRNELnAAM2JkCZPCqpinD0vVUyLCTArcsMIIJEICihsPdvPczPsdXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+gLlw62; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740588776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf/Qm0nkzf7U3vlvRsLDs3vQoV9ABJSWnA6WtOiN2ig=;
	b=J+gLlw62K7t4nQLqh/eCztgxf5Fg2RUFnZfalzbLz7G4JkaSaI98fxLoJofLamUdKiq9lF
	AR5TImaky7EeD9LjA8lc2AfffaIe1F5zPSAVzupIlXI8hJbREi5Xvylty0oavr+Tqbm+xj
	K1XIY0YigzYySnTUVOWTEqhsAoXWxVI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-fD21C53VPi-u4vRt6PUcag-1; Wed, 26 Feb 2025 11:52:55 -0500
X-MC-Unique: fD21C53VPi-u4vRt6PUcag-1
X-Mimecast-MFC-AGG-ID: fD21C53VPi-u4vRt6PUcag_1740588774
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4388eee7073so4954905e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 08:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588774; x=1741193574;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf/Qm0nkzf7U3vlvRsLDs3vQoV9ABJSWnA6WtOiN2ig=;
        b=mMDisny+vq59n58pqv0Fg5g2ugA7YBCaLjy8McU+Qr/VR0QajAQOTzYIelSzkhCFTl
         PZg7SVqiAWMjEZFfX962W9w3LoRbDd+OfvPqe7ne38LPnDV/C9VkkkX3ArDJTPeZ+dxF
         aGbtrKkVtPth+SL/TU976wQTHTXvQtf1v8017egxukyaWoW/yHehtPRuCrDbvYquAgkW
         MBn9kS5ycMIFn8+6lfGNtlQmkpv2PiZ4KGnwZ3OdZ7FAl/1zxX45ZGDRUHAjeVOT9VPV
         I57wwJO5P+KJRyvNRUARNXDH0lD3HWfcoNbvfio4+xTAY8U2dXXd3yuwMrq3TvU2/l1Q
         8+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF5T5oSrbGml+ZIllhjpSlJVVykhATxDG7v4KxxL2umbmI8bAqWvOvKj/TCZKdWOW0Uk59wYG2oggJaRx//Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOp9JP9bpc6K0PJOomP0qGzthwZqP7IU4p+hl0kIwIlVYVozq
	7dgS86xN/xrmo1IT5Zul6iMO5o1LO6spq6ybZLnqrR4Hl8ODt+kBAlPAtWFIX1PaxbI/owY/CGu
	+tYI50v0reDHSZ9Jzr40QSjU+X0xj37NtfGlW5T1ZYWF/YccBTtKvO+Ul0UQeuHiFbA==
X-Gm-Gg: ASbGncuuLWPZ0vLwQCOEnW5IOn7gCod9OWVbya5dNTY6aGvPo7jmiNYhFUfcsRb/sAh
	1BQdyawD+Gk48IH6slT26VSV9h2cJk8POMHJvLAL193Ud/p/6i9IeDwCRnp1liYsv66+L+VUuKr
	5v/304BX6vqtp4GxoW/TYli05Rmq5VqX/mH8R1AHEGalg61B8JZRHZf6kzxzjO77ut2mvoVHuxK
	5zb9+8bfNePj1/k922m0Wdlki4Bo5Ff4yHVsTRwJ6N8waNBKZHeHtZFrZoxVIolb9lNyUkhMx4F
	nIDnAv5rEIM2rCULCu5KN8kTuEiBEaELqWFtBML059P4PaaUdaKYLJaCMJeAMP7m+C4MI4NMRKf
	T
X-Received: by 2002:a05:600c:ca:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-43afddc6489mr797605e9.7.1740588774304;
        Wed, 26 Feb 2025 08:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWpDWParbyEFSiQubNArY/pYMHk4T+vY7Yfjqs/xu0tXoSgFv+Leti7F7TfR+hujI+3HmBjw==
X-Received: by 2002:a05:600c:ca:b0:439:91c7:895a with SMTP id 5b1f17b1804b1-43afddc6489mr797035e9.7.1740588773857;
        Wed, 26 Feb 2025 08:52:53 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390d98c0642sm2242326f8f.81.2025.02.26.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:52:53 -0800 (PST)
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
In-Reply-To: <408ebd8b-4bfb-4c4f-b118-7fe853c6e897@intel.com>
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
 <xhsmhfrk84k5k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <408ebd8b-4bfb-4c4f-b118-7fe853c6e897@intel.com>
Date: Wed, 26 Feb 2025 17:52:50 +0100
Message-ID: <xhsmhfrk0lkbh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/02/25 09:38, Dave Hansen wrote:
> On 2/20/25 09:10, Valentin Schneider wrote:
>>> The LDT and maybe the PEBS buffers are the only implicit supervisor
>>> accesses to vmalloc()'d memory that I can think of. But those are both
>>> handled specially and shouldn't ever get zapped while in use. The LDT
>>> replacement has its own IPIs separate from TLB flushing.
>>>
>>> But I'm actually not all that worried about accesses while actually
>>> running userspace. It's that "danger zone" in the kernel between entry
>>> and when the TLB might have dangerous garbage in it.
>>>
>> So say we have kPTI, thus no vmalloc() mapped in CR3 when running
>> userspace, and do a full TLB flush right before switching to userspace -
>> could the TLB still end up with vmalloc()-range-related entries when we're
>> back in the kernel and going through the danger zone?
>
> Yes, because the danger zone includes the switch back to the kernel CR3
> with vmalloc() fully mapped. All bets are off about what's in the TLB
> the moment that CR3 write occurs.
>
> Actually, you could probably use that.
>
> If a mapping is in the PTI user page table, you can't defer the flushes
> for it. Basically the same rule for text poking in the danger zone.
>
> If there's a deferred flush pending, make sure that all of the
> SWITCH_TO_KERNEL_CR3's fully flush the TLB. You'd need something similar
> to user_pcid_flush_mask.
>

Right, that's what I (roughly) had in mind...

> But, honestly, I'm still not sure this is worth all the trouble. If
> folks want to avoid IPIs for TLB flushes, there are hardware features
> that *DO* that. Just get new hardware instead of adding this complicated
> pile of software that we have to maintain forever. In 10 years, we'll
> still have this software *and* 95% of our hardware has the hardware
> feature too.

... But yeah, it pretty much circumvents arch_context_tracking_work, or at
the very least adds an early(er) flushing of the context tracking
work... Urgh.

Thank you for grounding my wild ideas into reality. I'll try to think some
more see if I see any other way out (other than "buy hardware that does
what you want and ditch the one that doesn't").


