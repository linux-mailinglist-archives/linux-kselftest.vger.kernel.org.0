Return-Path: <linux-kselftest+bounces-11061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D798D6AB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 22:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB6B1F24952
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB1E82866;
	Fri, 31 May 2024 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0NBYD5ft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F817442D
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717187519; cv=none; b=UMK4/AISDlWvkebz08ndUdD6O4tm9i2594RufoqIs0TRSIRCEjEcpiyBW5UoFtsR30+UOsIIvcMlTWaZq21A2RN7lFP1vvVjeMB7cVFkgmEMGUVwf/262xsZuSHqzqIoP0b3aSA+Es5f5MUxzZs0tkBAwLnd7zMXYP0DwuymXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717187519; c=relaxed/simple;
	bh=InPM3IgrwlWAIe+nSHKsuhmVDndDnlj7rMcdOWuFi5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfOhsOJpTX1Nj+HJaFD1ng6e9Yt2jcDlKwtYXZPyo+TYpnVt4jspneuPiJGQN27mEGrlHEHoPKk6ErntmeO27YNNSbd0qUNocZzywg+qxxFsxNnJKoHvX9xMMY01KEOchAXP7IXoDbBw06cv3TUsVQ/9js67su9YJFqbHvL3iZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0NBYD5ft; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42133fbe137so4945e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717187516; x=1717792316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InPM3IgrwlWAIe+nSHKsuhmVDndDnlj7rMcdOWuFi5w=;
        b=0NBYD5ftjqzLMMU9S/ShWY0r9adcsacAYrM6QxiDfQawAq5CIU1qD7b8p/9X1Hh9Vn
         lCeav7KbQTZC6WocF6DzhU0JB4kTTRoGMFPgYyLf6liDfGpbROuuf0wi9Ii3IF2Wp6ZH
         LVAHYybeCo0IO6rGM34tdAhVTzb/Y/5xa6yThldfSM2fHLRpWf9tyD3zhhSPVOvMnQ5F
         HsTmc2o2GZfb5q551QKtw3Su6tbc7M+8j+U/aPJi73PXxJ0zf4OgSd+qNvvQsbGx64r9
         MyGt8lz5GklSwzrPofU6xaiWPHie5vbk9RrAhk6LaMlnayWdQ6y7x3a9KE9fRKZisF3z
         z+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717187516; x=1717792316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InPM3IgrwlWAIe+nSHKsuhmVDndDnlj7rMcdOWuFi5w=;
        b=ffZLtuFbXzcfi2/AL41GpMAF/zaNYHYKdC+APLzXGBYmROXHBMnA+nXk2HZRBGUnHd
         fDCJJCSXyWPHnBrsxIfh80Szvq0RuKDd2W8Px7lSWh7xQJ4aZI3Vhf5bvWwF98Sh8+jz
         7wXEdpcOFQKOXVqS/g3i13DFKZ5aqJNtpLwLM5a1quHGGQ3hozVVOvx22rnV41+7DGvN
         a0FiLqXLH11l/wAZoQe9VEx4nJVcA7HVHlPNoEgL/dSz1L/Z6pjeIz41l5ZSqTEbK49L
         VM7ZeDwXFDuGRYryVkrf4igkMA3l2LCPN+o/nzbtjcRceHft1r0EN0kW2CxG4Jam1eSf
         IRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmnJ3Ne7Q+XBZ/bi3PZ/M8mu/ZUXp+zAP3+TpIEtoBRnah3pqzWOLWdpExrc8GmJ9Jld2gSVMbu45kArG/GDKOtyYGnS+WgWVe2Zq25O2A
X-Gm-Message-State: AOJu0YzNFa0zlF2ewGKfFvdg6qIn/D12t/ozo0+fj3KPy3f4+YSYDb/r
	C6ytZtAe+NDrp1wf76o0CeJdSsL5OfDXua3kZaDOAJWKD+PoRkqg6clgfgqbCFkk2ECM76OJU/Z
	cciQwsSM2Cv/tGhem09tF/QRlCVTcBM5Zvlbu
X-Google-Smtp-Source: AGHT+IECr7zScct/L9KDZG2FMT9+ZV9pueXumB1G4qrj8mkBEYnZr/Z/kM44zsq5c/gUQqURoi9spkN6RMIRJ4Ct+FE=
X-Received: by 2002:a05:600c:299:b0:418:97c6:188d with SMTP id
 5b1f17b1804b1-421358ce41bmr41075e9.7.1717187515962; Fri, 31 May 2024 13:31:55
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-3-jthoughton@google.com> <CAOUHufYFHKLwt1PWp2uS6g174GZYRZURWJAmdUWs5eaKmhEeyQ@mail.gmail.com>
 <Zll7IuGYGG5uI20W@linux.dev>
In-Reply-To: <Zll7IuGYGG5uI20W@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 31 May 2024 14:31:17 -0600
Message-ID: <CAOUHufa50Dy8CJ5+D10Khs4NU-3Pv0B8qi-GYkcppctTVUkPcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] mm: multi-gen LRU: Have secondary MMUs participate
 in aging
To: Oliver Upton <oliver.upton@linux.dev>
Cc: James Houghton <jthoughton@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Ankit Agrawal <ankita@nvidia.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Bibo Mao <maobibo@loongson.cn>, Catalin Marinas <catalin.marinas@arm.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
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

On Fri, May 31, 2024 at 1:24=E2=80=AFAM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> On Wed, May 29, 2024 at 03:03:21PM -0600, Yu Zhao wrote:
> > On Wed, May 29, 2024 at 12:05=E2=80=AFPM James Houghton <jthoughton@goo=
gle.com> wrote:
> > >
> > > Secondary MMUs are currently consulted for access/age information at
> > > eviction time, but before then, we don't get accurate age information=
.
> > > That is, pages that are mostly accessed through a secondary MMU (like
> > > guest memory, used by KVM) will always just proceed down to the oldes=
t
> > > generation, and then at eviction time, if KVM reports the page to be
> > > young, the page will be activated/promoted back to the youngest
> > > generation.
> >
> > Correct, and as I explained offline, this is the only reasonable
> > behavior if we can't locklessly walk secondary MMUs.
> >
> > Just for the record, the (crude) analogy I used was:
> > Imagine a large room with many bills ($1, $5, $10, ...) on the floor,
> > but you are only allowed to pick up 10 of them (and put them in your
> > pocket). A smart move would be to survey the room *first and then*
> > pick up the largest ones. But if you are carrying a 500 lbs backpack,
> > you would just want to pick up whichever that's in front of you rather
> > than walk the entire room.
> >
> > MGLRU should only scan (or lookaround) secondary MMUs if it can be
> > done lockless. Otherwise, it should just fall back to the existing
> > approach, which existed in previous versions but is removed in this
> > version.
>
> Grabbing the MMU lock for write to scan sucks, no argument there. But
> can you please be specific about the impact of read lock v. RCU in the
> case of arm64? I had asked about this before and you never replied.
>
> My concern remains that adding support for software table walkers
> outside of the MMU lock entirely requires more work than just deferring
> the deallocation to an RCU callback. Walkers that previously assumed
> 'exclusive' access while holding the MMU lock for write must now cope
> with volatile PTEs.
>
> Yes, this problem already exists when hardware sets the AF, but the
> lock-free walker implementation needs to be generic so it can be applied
> for other PTE bits.

Direct reclaim is multi-threaded and each reclaimer can take the mmu
lock for read (testing the A-bit) or write (unmapping before paging
out) on arm64. The fundamental problem of using the readers-writer
lock in this case is priority inversion: the readers have lower
priority than the writers, so ideally, we don't want the readers to
block the writers at all.

Using my previous (crude) analogy: puting the bill right in front of
you (the writers) profits immediately whereas searching for the
largest bill (the readers) can be futile.

As I said earlier, I prefer we drop the arm64 support for now, but I
will not object to taking the mmu lock for read when clearing the
A-bit, as long as we fully understand the problem here and document it
clearly.

