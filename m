Return-Path: <linux-kselftest+bounces-11065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C308D6B44
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 23:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7404A1F29F4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760978C83;
	Fri, 31 May 2024 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8M6IzaP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637DE77111
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189819; cv=none; b=O9FN7ZUnjLcblo9DRw4Q0p7/n0wlZGlSOBRHKqC2a64AIzUbeJ9fq1sXjiS+wHIpIYoe7k2CrfM9uns+dd7S1KS0OqbycWRSzJOlgHFprgjcb50Ky0R517SyieRn4uGTTwqMedBCvX8dr1hKbUGuKFoZfyEYLqannqrRABa2vR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189819; c=relaxed/simple;
	bh=N2tq10nFX29kQGqNAS352osxyUaVdPznDkZxoHpHfa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjdmTyGhdr6sRpyPDJY9rxet7RXtf69vB9wJOt9urKnHdgm1qHiLDRMKoVhUZIwvEKvOelcI/A2wuy+PhgDnOXvmmabDXsiT6cXVbRaVKnWMsDnHrY9VkuTVDZboU+/R3gUDI3q3Ki7tlaiQTBNsVKTmNr3R6M0LtxSGoqHCrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8M6IzaP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35dbfe31905so2602551f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717189816; x=1717794616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2tq10nFX29kQGqNAS352osxyUaVdPznDkZxoHpHfa8=;
        b=O8M6IzaPjVWsA+eDbKxrySY44vdZf+M/85NzSyUpFnm5+YqPLHFOaxaob4A3rjv2Wv
         oSWuoVsaXgAVjAw1QqEenIFsKXN3SaBY94b+i836JD2yBdkqKLqOycEFvQzI8xG7O9mD
         Sa39s/7iCQW5wpIB2pdPta4f0SGhfkpCes4nw2Vjs2Vk7mtKsk4VsKnuHcrmMu7Vaofs
         zA8v8FIoIsB1Ob25WniflRRHirPKEijTOa5X41VroCq894JjUQLu6tnmSChakYV5c4Ud
         V73S5jeqG6tMjtCoWw+9VfVomXEmBACl3Ww06sGSwpjwwp8XKXbTsdsPGw8iZNqIVs9G
         OkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717189816; x=1717794616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2tq10nFX29kQGqNAS352osxyUaVdPznDkZxoHpHfa8=;
        b=C1K/aqmYVymqd5bi99qujCuEt70akpk0J98RXUDBGb4fbbde0L8a4CZIaWJMvnm4N0
         4EU6+6ioE3T04f4HTGYuzPDXa6qjb3JMITLmhXxIVDr1y8vuJL1+fnpTLS2zJ7qCA0E8
         +xx+TNEgVehlguMaYzF6gbC/syDJSgV/j3M/t9Q+SCKRcY1blsbPNtzUMBJzzrXifTAr
         xL8uVFUuc0hf0CPKUOibuile6hsn+PloJCQaa81CguARhJKpUEUKcYG6NsHghk+YHSzQ
         NceICipkDjwW5ByRXUAX3JnQ5lAp6WRce/uzOsyval3JmaP7uu6EotBUx35N4hpKdEuc
         LzYg==
X-Forwarded-Encrypted: i=1; AJvYcCU2TfqVuoi2v/6nnku3Q+Z1wkMdmK1jIEWVW8vELcekO66Q43xGzzYNZ/SBrlL4yJVQe/isrEvjgpMPLk7yq/aRGYZ3qajT+JL0vKO2VLws
X-Gm-Message-State: AOJu0YxDf0rDwPnrAqfYZbtBP87yVAfXgwLMaLKcY9KNOorhg7uthH+1
	s6va/SY2ojAXrjRZ26C8HImTZb618WakP4V50l/FqsgU1kkbvRx45sx0vSvbsvF2tQ+NOJ8iLrg
	TBPkMMvcuiLwvGr6yG07M7xOiJW+X+JvFhc/X
X-Google-Smtp-Source: AGHT+IGBXgQKGvGpLJLkAZRNkN3pvPdaYlgrwH8luU8wCcE+kb/FtudP+b0UHW6VTmsTqjv8AVqi9KSPou5NOiUNmXY=
X-Received: by 2002:a05:6000:1b09:b0:357:ca29:f1ca with SMTP id
 ffacd0b85a97d-35e0f2869c8mr2259497f8f.32.1717189815401; Fri, 31 May 2024
 14:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-3-jthoughton@google.com> <CAOUHufYFHKLwt1PWp2uS6g174GZYRZURWJAmdUWs5eaKmhEeyQ@mail.gmail.com>
 <Zll7IuGYGG5uI20W@linux.dev> <CAOUHufa50Dy8CJ5+D10Khs4NU-3Pv0B8qi-GYkcppctTVUkPcA@mail.gmail.com>
 <CALzav=e4PmGV6ayuMCwbKWq8EnOomYKBj-0Lj+gV-kPO=h156A@mail.gmail.com>
In-Reply-To: <CALzav=e4PmGV6ayuMCwbKWq8EnOomYKBj-0Lj+gV-kPO=h156A@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 31 May 2024 14:09:49 -0700
Message-ID: <CALzav=dgV55gwhUdXh9T5k29JrcheAgJooHFodvf=u3YuookHg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] mm: multi-gen LRU: Have secondary MMUs participate
 in aging
To: Yu Zhao <yuzhao@google.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, James Houghton <jthoughton@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Rientjes <rientjes@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, James Morse <james.morse@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 2:06=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Fri, May 31, 2024 at 1:31=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > On Fri, May 31, 2024 at 1:24=E2=80=AFAM Oliver Upton <oliver.upton@linu=
x.dev> wrote:
> > >
> > > On Wed, May 29, 2024 at 03:03:21PM -0600, Yu Zhao wrote:
> > > > On Wed, May 29, 2024 at 12:05=E2=80=AFPM James Houghton <jthoughton=
@google.com> wrote:
> > > > >
> > > > > Secondary MMUs are currently consulted for access/age information=
 at
> > > > > eviction time, but before then, we don't get accurate age informa=
tion.
> > > > > That is, pages that are mostly accessed through a secondary MMU (=
like
> > > > > guest memory, used by KVM) will always just proceed down to the o=
ldest
> > > > > generation, and then at eviction time, if KVM reports the page to=
 be
> > > > > young, the page will be activated/promoted back to the youngest
> > > > > generation.
> > > >
> > > > Correct, and as I explained offline, this is the only reasonable
> > > > behavior if we can't locklessly walk secondary MMUs.
> > > >
> > > > Just for the record, the (crude) analogy I used was:
> > > > Imagine a large room with many bills ($1, $5, $10, ...) on the floo=
r,
> > > > but you are only allowed to pick up 10 of them (and put them in you=
r
> > > > pocket). A smart move would be to survey the room *first and then*
> > > > pick up the largest ones. But if you are carrying a 500 lbs backpac=
k,
> > > > you would just want to pick up whichever that's in front of you rat=
her
> > > > than walk the entire room.
> > > >
> > > > MGLRU should only scan (or lookaround) secondary MMUs if it can be
> > > > done lockless. Otherwise, it should just fall back to the existing
> > > > approach, which existed in previous versions but is removed in this
> > > > version.
> > >
> > > Grabbing the MMU lock for write to scan sucks, no argument there. But
> > > can you please be specific about the impact of read lock v. RCU in th=
e
> > > case of arm64? I had asked about this before and you never replied.
> > >
> > > My concern remains that adding support for software table walkers
> > > outside of the MMU lock entirely requires more work than just deferri=
ng
> > > the deallocation to an RCU callback. Walkers that previously assumed
> > > 'exclusive' access while holding the MMU lock for write must now cope
> > > with volatile PTEs.
> > >
> > > Yes, this problem already exists when hardware sets the AF, but the
> > > lock-free walker implementation needs to be generic so it can be appl=
ied
> > > for other PTE bits.
> >
> > Direct reclaim is multi-threaded and each reclaimer can take the mmu
> > lock for read (testing the A-bit) or write (unmapping before paging
> > out) on arm64. The fundamental problem of using the readers-writer
> > lock in this case is priority inversion: the readers have lower
> > priority than the writers, so ideally, we don't want the readers to
> > block the writers at all.
> >
> > Using my previous (crude) analogy: puting the bill right in front of
> > you (the writers) profits immediately whereas searching for the
> > largest bill (the readers) can be futile.
> >
> > As I said earlier, I prefer we drop the arm64 support for now, but I
> > will not object to taking the mmu lock for read when clearing the
> > A-bit, as long as we fully understand the problem here and document it
> > clearly.
>
> FWIW, Google Cloud has been doing proactive reclaim and kstaled-based
> aging (a Google-internal page aging daemon, for those outside of
> Google) for many years on x86 VMs with the A-bit harvesting
> under the write-lock. So I'm skeptical that making ARM64 lockless is
> necessary to allow Secondary MMUs to participate in MGLRU aging with
> acceptable performance for Cloud usecases. I don't even think it's
> necessary on x86 but it's a simple enough change that we might as well
> just do it.

The obvious caveat here: If MGLRU aging and kstaled aging are
substantially different in how frequently they trigger mmu_notifiers,
then my analysis may not be correct. I'm hoping Yu you can shed some
light on that. I'm also operating under the assumption that Secondary
MMUs are only participating in aging, and not look-around (i.e. what
is implemented in v4).

>
> I suspect under pathological conditions (host under intense memory
> pressure and high rate of reclaim occurring) making A-bit harvesting
> lockless will perform better. But under such conditions VM performance
> is likely going to suffer regardless. In a Cloud environment we deal
> with that through other mechanisms to reduce the rate of reclaim and
> make the host healthy.
>
> For these reasons, I think there's value in giving users the option to
> enable Secondary MMUs participation MGLRU aging even when A-bit
> test/clearing is not done locklessly. I believe this was James' intent
> with the Kconfig. Perhaps a default-off writable module parameter
> would be better to avoid distros accidentally turning it on?
>
> If and when there is a usecase for optimizing VM performance under
> pathological reclaim conditions on ARM, we can make it lockless then.

