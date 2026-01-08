Return-Path: <linux-kselftest+bounces-48535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9EFD042EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FDA73096006
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF20C2F9D98;
	Thu,  8 Jan 2026 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="FPoGqxK2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tmyu2f8W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA1261B70;
	Thu,  8 Jan 2026 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887118; cv=none; b=NqCCUD5zwzXc2u5dNn7/0CsDpY4+Lqyx0UVcgNdndsaSnnPUoj5ADMtdlvwdMmIRy+sPRWbAUld7qPdLG4Fc/pO6nxVE26U4CL8bexvo5qPrh/5lp63RkPfY1mU5TxjtIIkmLNg9XSvTapD9jMpaub00PS6GUlgHH7RFZn4Gqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887118; c=relaxed/simple;
	bh=cAifuf60VaB009+/fjECv5OLFMBJMnmjJyrVeuq+Ufc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO3HYTchiRjRzzL62Qy4rEuWq/mPw/wjp4clnoiw9fBzahIrA+wF0Xtc0Fe31FJTlDm+mKrZOToiP9O1EVWxblAzeL8hKykZ7SCvLjwQcKiF2DNKxozAYcrjO94I9AqTopdCGRdfSngAFoFP57aL+jEHEbv3r2huCkKVoGNBd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=FPoGqxK2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tmyu2f8W; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02A8C7A012A;
	Thu,  8 Jan 2026 10:45:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 10:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767887115;
	 x=1767973515; bh=P0QqQz8X1HAkcqldFqlq4mLu7Co2xScerhLdHuYGts4=; b=
	FPoGqxK2sOHXMMmn16LA149TDWDmYiIwj8DtPrdORZthooH8lacl9CcIfJGPAf5b
	Hk1g35sQ7yUshKwmzNW47f0jwMSnqOxbPqXYz9r9I2XfdV9+SjqjTUlqTMzutv9W
	v7yBUxTYblWouPvipQ8D/GlBFpZcrUXy0O8eKxV9wNPpxxFDg97CrAwbULQ4fPe9
	OcWCeWELdd4JJ+6MLpTbvB4nurQzjL4rglEMqxCboXEcsnySd4HbMIjPMTAwbZbs
	RGoG+rQGgQvYaTxl7tC3XXHPGwzmNGlY6ph2XJQh9qg+wBzXdh8wNI22D7zkEU5T
	rnpo8653dzT37XiYGWh62g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767887115; x=
	1767973515; bh=P0QqQz8X1HAkcqldFqlq4mLu7Co2xScerhLdHuYGts4=; b=t
	myu2f8W8oYhg5gwf1+A5wtJzJ2IoV4GKw36Za3scc8OHnN7IQsp/qXpn0MvUxKwM
	9niR2SeshqKgiq5x1xryPav8CgVKgiQNmwD5mJ3W4j/X5zt4xoUXbXPQrqbvT7mc
	74rdJQXOvqu398QB+DaPXMNTQzfa7RESEgaS8AhsxldLwYGF+8QsiHoowBdkXynm
	Qr3xi39vfsVv63AJcEp4kumWqcEIAeAw0xN10OKDVMva5u3YMDfzJe/60/K+umbY
	I84ho2uu1Jw24IKAft9yrvIMvl38JXPWVBdH3BTMOOCrgnp1bjAWZVDnOx+isC+L
	iEgprTfbXFhIMCfJy3aiQ==
X-ME-Sender: <xms:C9FfaZnBcaJePHekY8vrQAzoDwfJjE5kBk2EKXDxlU6ClKai5aPcWw>
    <xme:C9FfaQ3iImYSE7ubOrCOaRzKHungFEr1lB8w9APFvGVGdrcAIieGOxOLWCK6AIpDj
    a79bxjgHvydI_Nu2THcnrGCAa8LTuAoQOBcUqsN0RAsci91HQl_>
X-ME-Received: <xmr:C9FfaR0-sQC23k7tmFcvRt691nInzHbBG0abdcWo1acXBbi3WJk_iTtUYp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeifeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoheprg
    hmrghsthhrohesfhgsrdgtohhmpdhrtghpthhtohepughmrghtlhgrtghksehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:C9FfaapgtSQYbM_mfzpZJWcg1sqG3dNoWKHMjV-7-NlkHHwYPDGIZQ>
    <xmx:C9FfaVi56KWE18zpTzg80Ct9DHblFoDI8U6ElSUhmTR30h4zekoC7g>
    <xmx:C9Ffae-vSPUkuBz0xkh4xhmOW_KTSXX9fL63O6rxap5obkNfvkuJ7A>
    <xmx:C9FfaZXS17G5DG5EO3bkBPKY3jv5Wctoo2uSlPPsa4fKCbLmLjkbnA>
    <xmx:C9FfaRqzcTo_BzbE7bzhNUmSWy8napyKwXRNsbj_lYo_AJNKTA1C_Rpm>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 10:45:14 -0500 (EST)
Date: Thu, 8 Jan 2026 08:45:14 -0700
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, Shuah
 Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <20260108084514.1d5e3ee3@shazbot.org>
In-Reply-To: <20260108141044.GC545276@ziepe.ca>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
	<aV7yIchrL3mzNyFO@google.com>
	<20260108005406.GA545276@ziepe.ca>
	<aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com>
	<20260108141044.GC545276@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 10:10:44 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Jan 07, 2026 at 06:41:10PM -0800, Alex Mastro wrote:
> > On Wed, Jan 07, 2026 at 08:54:06PM -0400, Jason Gunthorpe wrote:  
> > > On Wed, Jan 07, 2026 at 11:54:09PM +0000, David Matlack wrote:  
> > > > On 2026-01-07 02:13 PM, Alex Mastro wrote:  
> > > > > Test MMIO-backed DMA mappings by iommu_map()-ing mmap'ed BAR regions.  
> > > > 
> > > > Thanks for adding this!
> > > >   
> > > > > Also update vfio_pci_bar_map() to align BAR mmaps for efficient huge
> > > > > page mappings.
> > > > > 
> > > > > Only vfio_type1 variants are tested; iommufd variants can be added
> > > > > once kernel support lands.  
> > > > 
> > > > Are there plans to support mapping BARs via virtual address in iommufd?
> > > > I thought the plan was only to support via dma-bufs. Maybe Jason can
> > > > confirm.  
> > > 
> > > Only dmabuf.  
> > 
> > Ack. I got confused. I had thought iommufd's vfio container compatibility mode
> > was going to support this, but realized that doesn't make sense given past
> > discussions about the pitfalls of achieving these mappings the legacy way.  
> 
> Oh, I was thinking about a compatability only flow only in the type 1
> emulation that internally magically converts a VMA to a dmabuf, but I
> haven't written anything.. It is a bit tricky and the type 1 emulation
> has not been as popular as I expected??

In part because of this gap, I'd guess.  Thanks,

Alex

