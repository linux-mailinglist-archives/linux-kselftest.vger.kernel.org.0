Return-Path: <linux-kselftest+bounces-10984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5138D5B53
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 09:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FA71C20FDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 07:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A3A81211;
	Fri, 31 May 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r37JI0j7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FCA7FBDA
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717140277; cv=none; b=FRbk0C2ZCsnuasWHwPIDLMi1Qmcp8ltTFCVoGIMEBcv+qjOg75GA76B6ESkx0LFdX3UuZSGkoh9U0PGKnoM0wFYlRQ6JMfQul3qP0L8G/FPyLbotY6/TKWcVIWFFZY83lCmaYEIJCBPKWmw47+f6eR0If5obrC7T77UqYEoeaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717140277; c=relaxed/simple;
	bh=TCC6im0osMHH/ZsvTuf9nvpEoA9dgsRlPGyvUIj8bLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctl6thucfnDx/TKWXEr7wZMvMY2tql0ZfTqjl8v6lkI7MpaB0NXCkbf+RlfN1q5gV4oI8XYfICexUUajf20AfqhcUwEHowIR6V98yn7t4pYgXYhNbPViumSTz+YMFDNwlgRbOixACSJKplrtWU6BDblwhM5zTZANJa0WEnQ2KD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r37JI0j7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yuzhao@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717140273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6pyP4SRO/9BT5GrT52jbiQuxRO/wk0HtBPD4YgPhLk=;
	b=r37JI0j7taWeZmoSnTE82903GeLstAD8AcPnN/lPbb+eAAkY0defxPmiJPHwGWnd294WLb
	FjgHxx1Px9O8RnwjA1f9bxRoJnyH+BVooELFS2MSFgtlTifw+nQzg6kbOK9o4nC/oVDgtV
	trAyzjYJwoWDB3IsG5rivC2BXJjWLQk=
X-Envelope-To: jthoughton@google.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: pbonzini@redhat.com
X-Envelope-To: aou@eecs.berkeley.edu
X-Envelope-To: ankita@nvidia.com
X-Envelope-To: anup@brainfault.org
X-Envelope-To: atishp@atishpatra.org
X-Envelope-To: axelrasmussen@google.com
X-Envelope-To: maobibo@loongson.cn
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: dmatlack@google.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: chenhuacai@kernel.org
X-Envelope-To: james.morse@arm.com
X-Envelope-To: corbet@lwn.net
X-Envelope-To: maz@kernel.org
X-Envelope-To: mpe@ellerman.id.au
X-Envelope-To: npiggin@gmail.com
X-Envelope-To: palmer@dabbelt.com
X-Envelope-To: paul.walmsley@sifive.com
X-Envelope-To: rananta@google.com
X-Envelope-To: ryan.roberts@arm.com
X-Envelope-To: seanjc@google.com
X-Envelope-To: shahuang@redhat.com
X-Envelope-To: shuah@kernel.org
X-Envelope-To: suzuki.poulose@arm.com
X-Envelope-To: zhaotianrui@loongson.cn
X-Envelope-To: will@kernel.org
X-Envelope-To: yuzenghui@huawei.com
X-Envelope-To: kvm-riscv@lists.infradead.org
X-Envelope-To: kvm@vger.kernel.org
X-Envelope-To: kvmarm@lists.linux.dev
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
X-Envelope-To: linux-mips@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-riscv@lists.infradead.org
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
X-Envelope-To: loongarch@lists.linux.dev
Date: Fri, 31 May 2024 00:24:18 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Yu Zhao <yuzhao@google.com>
Cc: James Houghton <jthoughton@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ankit Agrawal <ankita@nvidia.com>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Bibo Mao <maobibo@loongson.cn>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Shaoqin Huang <shahuang@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 2/7] mm: multi-gen LRU: Have secondary MMUs
 participate in aging
Message-ID: <Zll7IuGYGG5uI20W@linux.dev>
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-3-jthoughton@google.com>
 <CAOUHufYFHKLwt1PWp2uS6g174GZYRZURWJAmdUWs5eaKmhEeyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYFHKLwt1PWp2uS6g174GZYRZURWJAmdUWs5eaKmhEeyQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 29, 2024 at 03:03:21PM -0600, Yu Zhao wrote:
> On Wed, May 29, 2024 at 12:05 PM James Houghton <jthoughton@google.com> wrote:
> >
> > Secondary MMUs are currently consulted for access/age information at
> > eviction time, but before then, we don't get accurate age information.
> > That is, pages that are mostly accessed through a secondary MMU (like
> > guest memory, used by KVM) will always just proceed down to the oldest
> > generation, and then at eviction time, if KVM reports the page to be
> > young, the page will be activated/promoted back to the youngest
> > generation.
> 
> Correct, and as I explained offline, this is the only reasonable
> behavior if we can't locklessly walk secondary MMUs.
> 
> Just for the record, the (crude) analogy I used was:
> Imagine a large room with many bills ($1, $5, $10, ...) on the floor,
> but you are only allowed to pick up 10 of them (and put them in your
> pocket). A smart move would be to survey the room *first and then*
> pick up the largest ones. But if you are carrying a 500 lbs backpack,
> you would just want to pick up whichever that's in front of you rather
> than walk the entire room.
> 
> MGLRU should only scan (or lookaround) secondary MMUs if it can be
> done lockless. Otherwise, it should just fall back to the existing
> approach, which existed in previous versions but is removed in this
> version.

Grabbing the MMU lock for write to scan sucks, no argument there. But
can you please be specific about the impact of read lock v. RCU in the
case of arm64? I had asked about this before and you never replied.

My concern remains that adding support for software table walkers
outside of the MMU lock entirely requires more work than just deferring
the deallocation to an RCU callback. Walkers that previously assumed
'exclusive' access while holding the MMU lock for write must now cope
with volatile PTEs.

Yes, this problem already exists when hardware sets the AF, but the
lock-free walker implementation needs to be generic so it can be applied
for other PTE bits.

-- 
Thanks,
Oliver

