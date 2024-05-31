Return-Path: <linux-kselftest+bounces-11041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035648D6919
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4761F27801
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B17E591;
	Fri, 31 May 2024 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Btrcptra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A47E0EA
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180890; cv=none; b=MTKAvC+OaKdMh4ayEmgxhuP4a598fAYGHgqcFw9nF4xEXIpajbTzrmqLrqie4iLSE9Ahy8Npk22JXKvolA7Zif2ZoerxM2SrzV6XBYSSvgDatbRhqZrnupaM03pFuPt0EexU5BS0/RlSZf/XpCUBPF01YsuKtacdCgySoP0n9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180890; c=relaxed/simple;
	bh=N/Blbd63m9rqy+z4+yPkchYJqSbPLzT+F1ELjIofaUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3VSEk7jpizypP1zSk+l8/BLcwXl2fydTEju2F7j8OfVV8JEpyrKC3S0TMXLMLCunzF6oj+dbFM9ZGKz4F3D7t9PqnJF6ACof5PUl/csE+lNPlrM0QqYbL7+yxceA1rpTtUJWUGlMjVHvdqnVA07tjGTyiLh3SUD/1Vnox8lBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Btrcptra; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yuzhao@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717180886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrkvQ09UVgsdWxfCoZpOjcpYyls+3WTdBXC7IWp+Dfo=;
	b=BtrcptrahIHMY/n9/AZA3DXzcLGC2SGPLvU4nGpmgpexhmeAxDztnyub/a9ACk3LuYD+jI
	LdluBPvSaCSCX0KVcSV8bu/k0Ua9VEQflTkBfxkmAhE+NkAnYBC/j5woXAspbTVxmRtrc9
	MlzHXFSR+9wI8QbERC3hyyKRlZW/w/A=
X-Envelope-To: jthoughton@google.com
X-Envelope-To: seanjc@google.com
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
Date: Fri, 31 May 2024 11:41:14 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Yu Zhao <yuzhao@google.com>
Cc: James Houghton <jthoughton@google.com>,
	Sean Christopherson <seanjc@google.com>,
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
Message-ID: <ZloZysAPL0ePk3bY@linux.dev>
References: <20240529180510.2295118-1-jthoughton@google.com>
 <20240529180510.2295118-3-jthoughton@google.com>
 <CAOUHufYFHKLwt1PWp2uS6g174GZYRZURWJAmdUWs5eaKmhEeyQ@mail.gmail.com>
 <ZlelW93_T6P-ZuSZ@google.com>
 <CAOUHufZdEpY6ra73SMHA33DegKxKaUM=Os7A7aDBFND6NkbUmQ@mail.gmail.com>
 <Zley-u_dOlZ-S-a6@google.com>
 <CADrL8HXHWg_MkApYQTngzmN21NEGNWC6KzJDw_Lm63JHJkR=5A@mail.gmail.com>
 <CAOUHufZq6DwpStzHtjG+TOiHaQ6FFbkTfHMCe8Yy0n_M9MKdqw@mail.gmail.com>
 <Zll2ILUNWE-JPi9U@linux.dev>
 <CAOUHufb_-w=B+NfHAUAo=O8bDXZBdXeeGRZD6kY=krN07srbGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufb_-w=B+NfHAUAo=O8bDXZBdXeeGRZD6kY=krN07srbGA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 31, 2024 at 10:45:04AM -0600, Yu Zhao wrote:
> On Fri, May 31, 2024 at 1:03 AM Oliver Upton <oliver.upton@linux.dev> wrote:
> >
> > On Fri, May 31, 2024 at 12:05:48AM -0600, Yu Zhao wrote:
> 
> Let me add back what I said earlier:
> 
>   I'm not convinced, but it doesn't mean your point of view is
>   invalid. If you fully understand the implications of your design
>   choice and document them, I will not object.

Thanks, I appreciate the sentiment. Hopefully we can align here.

> > > All optimizations in v2 were measured step by step. Even that bitmap,
> > > which might be considered overengineered, brought a readily
> > > measuarable 4% improvement in memcached throughput on Altra Max
> > > swapping to Optane:
> >
> > That's great, but taking an iterative approach to the problem allows
> > the reviewers and maintainers to come to their own conclusions about
> > each optimization independently. Squashing all of that together and
> > posting the result doesn't allow for this.
> 
> That's your methodology, which I respect: as I said I won't stand in your way.
> 
> But mine is backed by data, please do respect that as well,

Data is useful and expected for changes that aim to improve the
performance of a system in one way or another. That is, after all, the
sole intention of the work, no?

What I'm also looking for is a controlled experiment, where a single
independent variable (e.g. locking) can be evaluated against the
baseline. All-or-nothing data has limited usefulness.

> by doing what I asked: document your justifications.

The justification for a series is against the upstream tree, not some
out-of-tree stuff. The cover letter explicitly calls out the decision
to simplify the patch series along with performance data I can reproduce
on my own systems.

This is a perfect example of how to contribute changes upstream.

> > > What I don't think is acceptable is simplifying those optimizations
> > > out without documenting your justifications (I would even call it a
> > > design change, rather than simplification, from v3 to v4).
> >
> > No, sorry, there's nothing wrong with James' approach here.
> 
> Sorry, are you saying "without documenting your justifications" is
> nothing wrong? If so, please elaborate.

As I mentioned above, the reasoning is adequately documented and the
discussion that led to v4 is public. OTOH...

> > The discussion that led to the design of v4 happened on list; you were
> > on CC. The general consensus on the KVM side was that the bitmap was
> > complicated and lacked independent justification. There was ample
> > opportunity to voice your concerns before he spent the time on v4.
> 
> Please re-read my previous emails -- I never object to the removal of
> the bitmap or James' approach.
> 
> And please stop making assumptions -- I did voice my concerns with
> James privately.
        ^~~~~~~~~

If it happened in private then its no better than having said nothing at
all.

Please, keep the conversation on-list next time so we can iron out any
disagreements there. Otherwise contributors are put in a *very* awkward
situation of mediating the on- and off-list dialogue.

> > You seriously cannot fault a contributor for respinning their work based
> > on the provided feedback.
> 
> Are you saying I faulted James for taking others' feedback?

No. Sufficient justification is captured in the public review feedback +
series cover letter. Your statement that the approach was changed without
justification is unsubstantiated.

> Also what do you think about the technical flaws and inaccurate
> understandings I pointed out? You seem to have a strong opinion on
> your iterate approach, but I hope you didn't choose to overlook the
> real meat of this discussion.

Serious question: are you not receiving my mail or something?

I re-raised my question to you from ages ago about locking on the arm64
MMU. You didn't answer last time, I'd appreciate a reply this time
around.

Otherwise I couldn't be bothered about the color of the Kconfig bikeshed
and don't have anything meaningful to add there. I think the three of
you are trending in the right direction.

-- 
Thanks,
Oliver

