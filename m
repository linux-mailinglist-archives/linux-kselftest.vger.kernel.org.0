Return-Path: <linux-kselftest+bounces-45341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C4C4F521
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FC53A5966
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A90E36A035;
	Tue, 11 Nov 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="HHmHwE2I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UiwBRN/P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F90328272;
	Tue, 11 Nov 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883530; cv=none; b=ZCjy9DkC4avdpc1NblFzddifBArjScsx7CitQhmY8AIfQKdBHdjyh8NkTiJJeOxWefooA3b9/9LAo5GWixlH+EGxeAXZ4UA5XLrPGHouKAeUPQp+rMuMDEHeSim7DtE6CVewFF3DLY4JRRUUxjEwDQ52IEn/2QGWEbMqOU+4XGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883530; c=relaxed/simple;
	bh=8G2KELXbUjPRFu3xLLvW/wsIgrpw69sWEEwoJQlscTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTqnNPIzhrqfdOxnN6TiR1qwKH4e6mYfloszp///Tqci/758WGKVmTOIDoynsOTDGBS/7zUSdV/KfUncT1sRLyVeYGbBzKmzmpGcmNLberGU9D5JJ4k66GHSi4XL39aQVV5iKNeBXcslJfSd9sfpy+4jSS/mDwgDFdT71ck5owI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=HHmHwE2I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UiwBRN/P; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D405EC00A4;
	Tue, 11 Nov 2025 12:52:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 12:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762883526;
	 x=1762969926; bh=6nEKhJAbQCJWATyNEXgrHLBDemDR+VlQVt3uIf9Kxpg=; b=
	HHmHwE2IakZn8f+GqXw4z5L2FQHg5LN0t1TZVIjk/h79qZ+ZFdTE5GNW0cBbIItF
	DJY25grx4MFAeHy3v7KqZjiH9zX/XU8iX7Cq8WH0tIzfux1ZXxkBfgbqdwXvAL4T
	AalPhnxoXYt/cqqLo0JLOBH2kYM2ecJrG11laeaYDGjLxg6hxtXZ46lAWCe6BNfQ
	VnugngO44p92L4OVuKi2GhEumNuIHcD16Pam8ZUO0Gw1aExfKmLO6Alp6orfQSmJ
	osiIOjhxBH5KHxXqVfS3tsum/W7fKn83I6rJChI5pFyz8/7xqmIoibtPLr5jh4sB
	4a+xNk8mCsPcNgNxEVyJ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762883526; x=
	1762969926; bh=6nEKhJAbQCJWATyNEXgrHLBDemDR+VlQVt3uIf9Kxpg=; b=U
	iwBRN/PHFOqdG7Ads0NLHBPPEr5DpaDVE2aiA/Ot/Rm7Eel1gccMTyKR9m5XoRHh
	nciYh75OXOWUgFTKEarpgax6iiSFPnf9tEreDtbPYEDqczP7J7ftDRIfYv8dA5iU
	lNaeBvFDXciOMsVaDHLu1zehotUlWu8KpsDgjdwAa+ukMIONWwYiwOieQejNZhJv
	dmcjDa5a1rqbohTQaLb7AnD8zAgeaSGYXECvzatIMMIdAsnOSbxv3PWyafdkLNQL
	opYVs1j72zGtQlr2MHt+ZKgF2rMeHrmZzb9whOQT32gzHeVHqtpWVj+GPId0NOLG
	u5FTSfhOlvxffiqj5Xusw==
X-ME-Sender: <xms:xXcTaQlnB-gm8YydHbjRnbXBObjOPRU_ZQn9z0noYZIKkdR-TyyiJw>
    <xme:xXcTaZ5UUo6NwvFhkWiLhypk3gBxvzDA28vBpSyA_9gYl7B4apu88S6UWfbQ2T56l
    DFNCZHE4RAG7tNrazX9FPnX4sQeLO2-IgZtt2SDYUw2a_RvxJK6pts>
X-ME-Received: <xmr:xXcTaehWlgqPL-AThl7KvnwefZ5rLF7Qpm-9VX5HlbUdk5BmJ4etzDFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddukeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepteetudelgeekieegudegleeuvdffgeehleeivddtfeektdekkeehffehudet
    hffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrmhgrshhtrhhosehfsgdrtghomhdprhgtphhtthhope
    gumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoh
    epkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    shgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xXcTaeFrYHC-P_9wTFSNvlZdoMCp-dh-1VhDjqXMyPp867iW79lfww>
    <xmx:xXcTacTS8p5LGEKYbQs-3UJM5SRmpWmM-KB-iG5kX76ythx1N4poQg>
    <xmx:xXcTaTzzWJCVimyn0R3LDIV1TOlkkJVEy1Sxb75FYcYoSM0TqyVQfg>
    <xmx:xXcTaQcH9stc-dWLyNYmOu6vUyePpgeui19GLXax3TjdX-tBNNmcIw>
    <xmx:xncTacJxjsd-Mb8hLdVuGvzjKy7GzUTsXuAfoSTuO7ZLCezlDPO8_Equ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 12:52:04 -0500 (EST)
Date: Tue, 11 Nov 2025 10:52:02 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] vfio: selftests: add iova range query helpers
Message-ID: <20251111105202.3aa734aa.alex@shazbot.org>
In-Reply-To: <aRNz4ynek6siv0FZ@devgpu015.cco6.facebook.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
	<20251111-iova-ranges-v2-1-0fa267ff9b78@fb.com>
	<20251111100948.513f013b.alex@shazbot.org>
	<aRNz4ynek6siv0FZ@devgpu015.cco6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 09:35:31 -0800
Alex Mastro <amastro@fb.com> wrote:

> On Tue, Nov 11, 2025 at 10:09:48AM -0700, Alex Williamson wrote:
> > On Tue, 11 Nov 2025 06:52:02 -0800
> > Alex Mastro <amastro@fb.com> wrote:  
> > > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > index a381fd253aa7..7a523e3f2dce 100644
> > > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > @@ -29,6 +29,173 @@
> > >  	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
> > >  } while (0)
> > >  
> > > +static struct vfio_info_cap_header *next_cap_hdr(void *buf, size_t bufsz,
> > > +						 size_t *cap_offset)
> > > +{
> > > +	struct vfio_info_cap_header *hdr;
> > > +
> > > +	if (!*cap_offset)
> > > +		return NULL;
> > > +
> > > +	VFIO_ASSERT_LT(*cap_offset, bufsz);
> > > +	VFIO_ASSERT_GE(bufsz - *cap_offset, sizeof(*hdr));
> > > +
> > > +	hdr = (struct vfio_info_cap_header *)((u8 *)buf + *cap_offset);
> > > +
> > > +	if (hdr->next)
> > > +		VFIO_ASSERT_GT(hdr->next, *cap_offset);  
> > 
> > This might be implementation, but I don't think it's a requirement.
> > The vfio capability chains are based on PCI capabilities, which have no
> > ordering requirement.  Thanks,  
> 
> My main interest was to enforce that the chain doesn't contain a cycle, and
> checking for monotonically increasing cap offset was the simplest way I could
> think of to guarantee such.
> 
> If there isn't such a check, and kernel vends a malformed cycle-containing
> chain, chain traversal would infinite loop.
> 
> Given the location of this test code coupled to the kernel tree, do you think
> such assumptions about implementation still reach too far? If yes, I can either
> remove this check, or try to make cycle detection more relaxed about offsets
> potentially going backwards.

I've seen cycle detection in PCI config space implemented as just a
depth/ttl counter.  Max cycles is roughly (buffer-size/header-size).  I
think that would be sufficient if we want to include that sanity
testing.  Thanks,

Alex

