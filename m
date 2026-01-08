Return-Path: <linux-kselftest+bounces-48532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D94BD04060
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 16:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9052301D310
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5042C326D;
	Thu,  8 Jan 2026 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JGioc7DD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uWwDB2T4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912B2D0C9D;
	Thu,  8 Jan 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886935; cv=none; b=LdBIgN/4JefUkz3xojwEjbwsDN0dwt1fs9xXYMz179Cdwy4kYfHfIiUVEHA+hKH0vzxipjRe4KZjXZf18i6wdtneJY2dpWNY1gVfy4BPYulP/thgtTk7gaHFAAHv+2FKH+0QJj6Zeu5ZEh5PWAMAy0ZpRqV0G0XVrGfHGYPfa38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886935; c=relaxed/simple;
	bh=/XbdBMAh/KdfaN38bteya/jfnG+4gYxuQ7/yARzs0EY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1FxPzZ2teovMJPKhrLvuBtZviLAyrXttDhWL47+BBmuPQRbqBEL4m7ClU3hjbVF7xM610qMDdbot1SwCbTCMOxGKmeJp8qW+gDyuVqlnb8ZZLCPsFxuTdv+8HrRfyDn7tySaqewhk4twKS9wILjOfC16T9bA8Av03xDWscaRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JGioc7DD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uWwDB2T4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E3B87A004F;
	Thu,  8 Jan 2026 10:42:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 10:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767886930;
	 x=1767973330; bh=g/SZXRCpxe4gpZSJo2wKA9yO49l9ao+IpIcB5KG5aRo=; b=
	JGioc7DD0IsJvDCyV+1t9dyyzHFRN0LSp/8ZosIAPpch7QAsDvoihN4MeAIIcpvO
	rN86RCH9cExU7lRzuZ4gP9iD6mIfQ3ssD/1qI9DUkag46LwIl/OoL0U7wLbDUfRh
	wq/ETq2TVb/atH8QpIkQ2hDDvJfYurtt/5ie90rQ23atM9KKs+REdq/lHuoT7w8n
	ZVSy1rq5PTxplKc2rYi2tQGXsGJqMsqsCA7NvzK5pPkV1DSjzJWTWhBFwXVqzhxz
	6HWGF6m0CBkRgvsVc4h1l+jWBVURrx9t4SnpTm/N7knzrQm+f1OeHUMJ1zsjLINs
	7048WzGQ1yqzy2ZqspdHRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767886930; x=
	1767973330; bh=g/SZXRCpxe4gpZSJo2wKA9yO49l9ao+IpIcB5KG5aRo=; b=u
	WwDB2T4YjvWg/gdV6Tvz5AyXkS9qTiJYtTcl+sPRY4FKD+IsLJ+p3fehd6fcpd6R
	Sdy/1dTB64/9lmPNjfykuUbg50LsIZzIeHygUpntKZ1BSpQAiq1xc4tJ3VZ6AmiA
	ZQHsvEWLDzZ0JHAb0BxeyVtTRm0q8T4D4216uT5KcdwX2fofsfBuz671exOsvm5Y
	Y6qnUZR60a94Oy2jFLn/jcCPv/4NRXFw2jeG2ek3H+tcNUtuQqQKFgZqnCP4IInz
	XHOMlAmUrU4RKuSvYx4e83dhv/Dd8dAJDbdQzbX75aDuc5OL9S14xPS4wYV3vNw6
	exeoWGpHeWO7qPmZw4gzg==
X-ME-Sender: <xms:UdBfaXZyUO64lJxIJN0oaAi3x4Q2iY5R7GsSerM8T2FkeW6JL5aqBg>
    <xme:UdBfaSa-lniRvIWQzSd9v3HbE04zLhPacvlAtJCyXr0uYg37eRvXKdSuUNwEaFOq-
    hvBFdYuah9jOjfe50_XSOBokhPa868WwpZ8DvrTPEOuxVEAgSPAYw>
X-ME-Received: <xmr:UdBfacJq0IjjjWeVR3oWCIzyLtWXQ43C5auhK8j0PbW-SPk76qz1ehBZTXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghmrghsthhrohesfhgsrdgtohhmpdhrtghpthhtoh
    epughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehshhhurghhsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhgghesiihivghpvgdrtggr
X-ME-Proxy: <xmx:UdBfaeugM1oJwHwg8Um7Ba_BCgdDR6R92aZCHV_tLhDhC4zaXKkvjA>
    <xmx:UdBfaQV7UHTZMK4rKbgYxfFJpUTOJVCPTRjugmpO5QCnefk8JkJLFg>
    <xmx:UdBfaZiU86DKidgOiIVCJKeMCNNxrwVlmPqMIvd2NKTUhzIsZR5g5Q>
    <xmx:UdBfaYoE16waTPAiXHfCJHbU-9oA6SLH6qnvKaD8HfY3WgfidKQjDw>
    <xmx:UtBfaUsTDgPIRK9ig40y7IXC4EZ4QT7rgJ3zQahHQiz2gLsTeUzopbha>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 10:42:09 -0500 (EST)
Date: Thu, 8 Jan 2026 08:42:08 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <20260108084208.30edd533@shazbot.org>
In-Reply-To: <aV8mTHk/CUsyEEs1@devgpu015.cco6.facebook.com>
References: <20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com>
	<aV7yIchrL3mzNyFO@google.com>
	<aV8mTHk/CUsyEEs1@devgpu015.cco6.facebook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 19:36:44 -0800
Alex Mastro <amastro@fb.com> wrote:
> On Wed, Jan 07, 2026 at 11:54:09PM +0000, David Matlack wrote:
> > 
> > Speaking of, maybe we can add a test that creating writable IOMMU
> > mappings fails for read-only BARs?  
> 
> I think I'll have to look into this as a follow-on. I'm not sure how to validate
> it yet without mocks or similar since I don't have such HW.

I think the read-only aspect would be in the mmap, not the BAR itself,
ie. can we create a read-write DMA mapping to a read-only mmap.

ROM BARs are the only BARs that are read-only, but they can share a
decoder with the standard BARs and therefore have a separate enable in
the BAR register itself.  Due to this, and their general usage, it's
never been necessary to allow mmap of the ROM BAR, therefore we cannot
actually DMA map the ROM BAR.  Thanks,

Alex

