Return-Path: <linux-kselftest+bounces-11224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7628FBF77
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 01:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBB9B23BA3
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCFE14D435;
	Tue,  4 Jun 2024 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y9kw/6fC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28D14D431;
	Tue,  4 Jun 2024 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542044; cv=none; b=fSDehC0fjSZstFa4o4v3fm9IqieCMErNeKzFFckx4fAEIHMuH2Mw2yF/KagB9HTPgfbjSVJYhnx9MWDQ/vDqCsR0vE1ZD0cdemNzrPiAXp7LYucTefiPp7HFOa3HtRUpftbDIESJoJQDxP17EJIqrq566gMc7m53eW26dezSTTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542044; c=relaxed/simple;
	bh=3aD6TtBD/gMBjuVttDp8+r2L84PgItrVAANYOy++fgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVCfHm+0cQOXJuHFyxyKbJ8HC3Ll3SL1DXZnR66Ha6qs2SYRcc+O6Yyd7469Ei55Zm2JrnchbNZLMtD3WkOhloq7W3ZkGdRXBqCdriSuPJ1gYlKtcK638cJH6wd5C9WnWq8m/a9yS6qUCcfIOgufYwOxDIIT6gK2kDPeH/jwdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y9kw/6fC; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jthoughton@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717542038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MGPWWPfczYg0bV6msWVM8wo7iUe4hq2RoxquwpyNXc=;
	b=Y9kw/6fCw7WeofkUSeTV2BTDMr5jngNUCtFMMUMXtMQwQZ57KMcePca1DBVS/t4qEWis16
	iF4e3V2COwO/t2Yct7KRRLkVhD5NRIOHTq7i/FQgEBT9QWzcLz+QujFnkzpcYe5jZDxDJW
	+mCbFXXZogKs/7ZLafe//WQoP8h37Tw=
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
X-Envelope-To: yuzhao@google.com
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
Date: Tue, 4 Jun 2024 23:00:28 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
	Zenghui Yu <yuzenghui@huawei.com>, kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v4 6/7] KVM: arm64: Relax locking for kvm_test_age_gfn
 and kvm_age_gfn
Message-ID: <Zl-cjHVKaQ0iQE5d@linux.dev>
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-7-jthoughton@google.com>
 <Zlog5Yk_Pjq0jQhC@linux.dev>
 <Zloicw4IU8_-V5Ns@linux.dev>
 <CADrL8HV4SZ9BEQg1j3ojG-v5umL_d3sa4e1k2vMQCMmBEgeFpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HV4SZ9BEQg1j3ojG-v5umL_d3sa4e1k2vMQCMmBEgeFpQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 04, 2024 at 03:20:20PM -0700, James Houghton wrote:
> On Fri, May 31, 2024 at 12:18 PM Oliver Upton <oliver.upton@linux.dev> wrote:
> >
> > On Fri, May 31, 2024 at 12:11:33PM -0700, Oliver Upton wrote:
> > > On Wed, May 29, 2024 at 06:05:09PM +0000, James Houghton wrote:
> > >
> > > [...]
> > >
> > > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > > > index 9e2bbee77491..eabb07c66a07 100644
> > > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > > @@ -1319,10 +1319,8 @@ static int stage2_age_walker(const struct kvm_pgtable_visit_ctx *ctx,
> > > >     data->young = true;
> > > >
> > > >     /*
> > > > -    * stage2_age_walker() is always called while holding the MMU lock for
> > > > -    * write, so this will always succeed. Nonetheless, this deliberately
> > > > -    * follows the race detection pattern of the other stage-2 walkers in
> > > > -    * case the locking mechanics of the MMU notifiers is ever changed.
> > > > +    * This walk may not be exclusive; the PTE is permitted to change
> > > > +    * from under us.
> > > >      */
> > > >     if (data->mkold && !stage2_try_set_pte(ctx, new))
> > > >             return -EAGAIN;
> > >
> > > It is probably worth mentioning that if there was a race to update the
> > > PTE then the GFN is most likely young, so failing to clear AF probably
> > > isn't even consequential.
> 
> Thanks Oliver.
> 
> >
> > Oh, and the WARN_ON() in kvm_pgtable_stage2_test_clear_young() is bogus
> > now. Maybe demote it to:
> >
> >   r = kvm_pgtable_walk(...);
> >   WARN_ON_ONCE(r && r != -EAGAIN);
> 
> Oh, indeed, thank you. Just to make sure -- does it make sense to
> retry the cmpxchg if it fails? For example, the way I have it now for
> x86[1], we retry the cmpxchg if the spte is still a leaf, otherwise we
> move on to the next one having done nothing. Does something like that
> make sense for arm64?

At least for arm64 I do not see a need for retry. The only possible
races are:

 - A stage-2 fault handler establishing / adjusting the mapping for the
   GFN. If the guest is directly accessing the GFN in question, what's
   the point of wiping out AF?

   Even when returning -EAGAIN we've already primed stage2_age_data::young,
   so we report the correct state back to the primary MMU.

 - Another kvm_age_gfn() trying to age the same GFN. I haven't even
   looked to see if this is possible from the primary MMU POV, but in
   theory one of the calls will win the race and clear AF.

Given Yu's concerns about making pending writers wait, we should take
every opportunity to bail on the walk.

-- 
Thanks,
Oliver

