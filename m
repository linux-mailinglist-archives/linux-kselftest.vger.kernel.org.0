Return-Path: <linux-kselftest+bounces-48633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F1BD0C577
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 22:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 932E13027589
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B5F33D518;
	Fri,  9 Jan 2026 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="fJdZcUro";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7CTJaPo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59A33D4F6;
	Fri,  9 Jan 2026 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994719; cv=none; b=eEPd3O57Zk5QSL6zrtzsAywKuGt9K7S85fNBcomxjCKlPW3BBJpfZz2jjjmGtsNhdZ9vEGPvTnSj/LDcH6za8WmgPYep1g9mIt1qWLzC8jcrsZxh1dX6fPSm46rhL5ISbYgnqxVPIZatwk87amnC/5uCUuq3q3j1VKzyQ//YP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994719; c=relaxed/simple;
	bh=iFcbhGt4sl07dI/vgTsNt/XXjlhieSN2X15MCPhWfTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MU56B5RV7iXjZfKyjTZ6gfsS41RL6UHjveQuqCAUz/6GDZla7qoPfys3Uw3DYh4PDk9wE2VlmBZ7uqD83eEQmJPZrkuSQbQ0HW6NT6B7Y8zL/E+dZD0veOM8ILHP29GEBE3XOLnJaa4VnZxZ+Y0WafEqO3uO8ZBWweJLYm8nfek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=fJdZcUro; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7CTJaPo; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EC2BEC0129;
	Fri,  9 Jan 2026 16:38:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 09 Jan 2026 16:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767994713;
	 x=1768081113; bh=gvtvSAYi4oFbZNkjA+PRpLh/s0xkmUKgjuZp66x8+6I=; b=
	fJdZcUroaBUWu505kk5QVkdyQb9ZZc2ZLuIZPelLw80Q98edrJ+km3L3a/fA2Nc+
	3UId0xTKzJF6wwIhbZSUKIIGIyQ0OFSUHCF4uvAoY4WqYXoavDSU3hNqo/Xea0T2
	j62h8E+GchdgzdhCjLbsZhr5WhNAUOry8qeLDk1W5Ska4MrFyr5yl/CH0rKy/dYE
	H/aVyUa3pFLoAZsV633MjyNeLUX9bVUiO7cOAn6uV9PhQn5JDd/mFe1XcNlYvxZN
	GtjmwJDKyZ8ZlGqaF2CGJFNlV4ApQc4iQ8hHuFKGI0rnzoVQ3dG8uEeJi15TOnD5
	jOl015QCshOf8ieKofA87A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767994713; x=
	1768081113; bh=gvtvSAYi4oFbZNkjA+PRpLh/s0xkmUKgjuZp66x8+6I=; b=O
	7CTJaPomy1TOqAV138g6AiRzpF26Nq+IqNY1mWuXaXG4P1Ua0g2EkJbFP/D30zZ+
	32kcEwDqICG51QjtmB7yn+hygqGra90oOP6w1FJBE7y4yC67IwSjF4l5rSEqjBZr
	kywNqeYe+jUQD65K5AHuITvU3csfdxCN9J8gIomZt1ru39Bc/qEOd/rAgxa/vJ+P
	w7sWA361vA9tgTanRJVeeqj9kzc50U/WObhmP3Vi2aXGJLpbFELTnbr2vWimuha5
	d1Pu1MprwWPSkxp5bUSDy6dmBw9f7BMTX5XotkbwyetVc+ce+PB7ZheeSx4Arf7Z
	5RR+OtgIhC1CEtqkQRsXg==
X-ME-Sender: <xms:WHVhaWPoUTXswz-TyFSypR8CTtjJLG5qugBXfmRPctJQ3a2c033iKw>
    <xme:WHVhaQ_ipEA1qy5GI2yfUxcSw6WXhdQkvSf85xmN2LJfbu-4IsW8-b-6r2_LAQisW
    rixyi0OOACmF9mBtthAPTNdSQ2WNB2_ogWLwwVmK_Dh3lM5VpS2iA>
X-ME-Received: <xmr:WHVhafcK5ZN_Q7b7gPGZdfvS2ojOFoUsRnYTPCjyCdKNy_DwLvuhyHcPjY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohepug
    hmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegrmhgrshhtrhhosehf
    sgdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WHVhaXx1x0A8sokKqYTsh5-uaI6p7H-hpPFYgRAhwgufMo5KjEEPJA>
    <xmx:WHVhacJC6CWuwpDqaVVQkRxCPbT3wWdqtHPMUGmXB7E6jUqVaW-fXg>
    <xmx:WHVhaRFuQ6SK5RXxhfVm_4LiCuDHCs1k51MdlZYy49qz7jBZqNfEOw>
    <xmx:WHVhaQ9TxTyCbhPfOeebSxtg9AfNWJz-sD_ERB40lZAHVrm5R_MNLw>
    <xmx:WXVhacwCEhJEi9X6hZTXQQvwvPOiafZbBlkY1AjsNBRBrcUi_P92jw9Y>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 16:38:32 -0500 (EST)
Date: Fri, 9 Jan 2026 14:38:30 -0700
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Matlack <dmatlack@google.com>, Alex Mastro <amastro@fb.com>, Shuah
 Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
Message-ID: <20260109143830.176dc279@shazbot.org>
In-Reply-To: <20260109180153.GI545276@ziepe.ca>
References: <aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com>
	<20260108141044.GC545276@ziepe.ca>
	<20260108084514.1d5e3ee3@shazbot.org>
	<CALzav=eRa49+2wSqrDL1gSw8MpMwXVxb9bx4hvGU0x_bOXypuw@mail.gmail.com>
	<20260108183339.GF545276@ziepe.ca>
	<aWAhuSgEQzr_hzv9@google.com>
	<20260109003621.GG545276@ziepe.ca>
	<aWBPNHOsaP1sNvze@google.com>
	<20260109005440.GH545276@ziepe.ca>
	<CALzav=cBGkhbbyggkfaYh3wfqodxRHZKXTNdnmjoXOgwMouBuA@mail.gmail.com>
	<20260109180153.GI545276@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 14:01:53 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Fri, Jan 09, 2026 at 09:04:30AM -0800, David Matlack wrote:
> > > If you really want to test TYPE1 you need to test what makes it
> > > unique, which is that you can map any VMA and then unmap any slice of
> > > it. Including within what should otherwise be a 1G page.
> > >
> > > But I doubt anyone cares enough to fix this, so just exclude
> > > VFIO_TYPE1_IOMMU from this test?  
> > 
> > Ah, ok, thanks for the explanation. So VFIO_TYPE1_IOMMU should always
> > use 4K mappings regardless of backend (VFIO or iommufd) so that unmap
> > can work as intended.  
> 
> IDK, I think you should just ignore testing TYPE1v0. The actual real
> semantics that it had are quite confusing and iommufd provides an
> emulation that is going to be functionally OK (indeed, functionally
> more capable) but is not the exactly the same.
> 
> The old comment here is sort of enlightening:
> 
> +        * vfio-iommu-type1 (v1) - User mappings were coalesced together to
> +        * avoid tracking individual mappings.  This means that the granularity
> +        * of the original mapping was lost and the user was allowed to attempt
> +        * to unmap any range.  Depending on the contiguousness of physical
> +        * memory and page sizes supported by the IOMMU, arbitrary unmaps may
> +        * or may not have worked.  We only guaranteed unmap granularity
> +        * matching the original mapping; even though it was untracked here,
> +        * the original mappings are reflected in IOMMU mappings.  This
> +        * resulted in a couple unusual behaviors.  First, if a range is not
> +        * able to be unmapped, ex. a set of 4k pages that was mapped as a
> +        * 2M hugepage into the IOMMU, the unmap ioctl returns success but with
> +        * a zero sized unmap.  Also, if an unmap request overlaps the first
> +        * address of a hugepage, the IOMMU will unmap the entire hugepage.
> +        * This also returns success and the returned unmap size reflects the
> +        * actual size unmapped.
> 
> iommufd does not try to do this "returned unmap size reflects the
> actual size unmapped" part, it always unmaps exactly what was
> requested, because it disables huge pages.

I think there was also some splitting code in the IOMMU drivers that
has since been removed that may have made the v1 interface slightly
more sane.  It certainly never restricted mappings to PAGE_SIZE in
order to allow arbitrary unmaps, it relied on users to do sane things
and examine the results.  Those "sane things" sort of became the v2
interface.

In any case, we've had v2 for a long time and if IOMMUFD compat make v1
more bloated and slow such that users realize they're using an old,
crappy interface, that's probably for the best.  Examining what page
size is used for v1 is probably not worthwhile though.  Thanks,

Alex

