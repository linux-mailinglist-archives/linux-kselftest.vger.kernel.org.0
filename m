Return-Path: <linux-kselftest+bounces-41105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5046EB50DF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 08:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8E41C263D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 06:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0462DFF04;
	Wed, 10 Sep 2025 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3A9FrUX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569BF22259D;
	Wed, 10 Sep 2025 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485205; cv=none; b=VAu7tcPnoiXPe07GmYZh+fHAqVDphRKcY/WHUo/vnBqDe5Ng2GO9Ep8WGyoNxQcltDi9MpWr48zl+85R9X2sKWLcyL+ZFbdaOhjYAeiUaAoc38As1B4Xeo5UVAAEwGzVby5GFbmNlpYjLZn7XMozI6XW+9bIZP310XQJHq6MDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485205; c=relaxed/simple;
	bh=GNr5fSQdvX6LdqB/W1EZ8Bb6oXPTAA6ZnpCtLjpI0F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGEbV4IYVNsf5UHnC8B3al9O747UbP5QoNn/HgRxjwnsTitLRahkIFWi8skJjFpM5BCY6WeRvVeeNWMhAOmyNMcxYxKQ2Z+pb5FOcecei/2dhNHYsiICy5A6reuu9gIPIUxbml3o0w8Kln8RLeFqqML8cOtm5a2OLS2sZTOmWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3A9FrUX; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D14877A0226;
	Wed, 10 Sep 2025 02:20:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 10 Sep 2025 02:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757485201; x=1757571601; bh=olvJU0Qy+Cu3De8cG+SQ0iQ+feuXB8WHAz5
	1Z2X5bxs=; b=e3A9FrUXfqCYN+Z1VXm1vmK8p1g31UUM+gOpvbK8X4vL1WJbOnZ
	ZuyiKrP5shMmqqm8fviRgSod8O5FCkoMi7UqkfQ21fm1tSYLpXPepJK782qEdMjP
	XCRVQfn/ZHHsg51CgPEsamm1/oEDRkdPvLn9CFx9uoW9sPXeCCB/QftmDvoEAfnV
	crk+8/3FK8dgHVAeqUAQ5+QX61kDIGxpFviboBW3/phFHXhOHVRqLTZYIfstCSWb
	uUmOMS2BPTHbYlplCrV1dlzqIu9nw456cYeJf0qSc88VlMSnbU339Z5N5T6ICxA1
	pDNITfGyCjrwJ4efy99LbkL4nCFmBWh8y2A==
X-ME-Sender: <xms:kBjBaBfnR2EAOSwulVIjvh1JNRdwP0Sbr9mmSNtYyg9Bxu0o8YmtYQ>
    <xme:kBjBaOITm5T2x3sXdfGjQP87pQcShU44V0Ohk9FkpYB_ukHSfEorsCgSjXbhwfJJq
    ImGAWYFbeYS0gA>
X-ME-Received: <xmr:kBjBaGn25h3RLlXChcYVX-C0WGGnL9X0rpdMZYGrV6qZzEXG-tmjXMOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepihdrmhgrgihimhgvthhssehovhhnrdhorhhgpdhrtghpth
    htohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsth
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kBjBaOewaNQh3bOjkY4Lxlco38ywE736U85fc0wme3K30rbGddbbxw>
    <xmx:kBjBaPyrCD3R8H9890vLqp3aI_sufil0HV264vKQhSsm1bnsV3hMcw>
    <xmx:kBjBaPKsMPYC-f3cKh0_TTLdZ_dGXLihPjLY8n111UxbCbHL2fsalQ>
    <xmx:kBjBaItu5oxZQLmd5rkC3nAvF_0T_PZiIG7VnG5jlMscnvEmY7ovGg>
    <xmx:kRjBaLF9L6GpgRy7DDEtIbSTDS3LbPtjx795p_gjUTZ27zA09BU3i09g>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 02:20:00 -0400 (EDT)
Date: Wed, 10 Sep 2025 09:19:58 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, dev@openvswitch.org,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net v2 1/2] net: dst_metadata: fix IP_DF bit not
 extracted from tunnel headers
Message-ID: <aMEYjvSNvxfD7iJz@shredder>
References: <20250909165440.229890-1-i.maximets@ovn.org>
 <20250909165440.229890-2-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909165440.229890-2-i.maximets@ovn.org>

On Tue, Sep 09, 2025 at 06:54:15PM +0200, Ilya Maximets wrote:
> Both OVS and TC flower allow extracting and matching on the DF bit of
> the outer IP header via OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT in the
> OVS_KEY_ATTR_TUNNEL and TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT in
> the TCA_FLOWER_KEY_ENC_FLAGS respectively.  Flow dissector extracts
> this information as FLOW_DIS_F_TUNNEL_DONT_FRAGMENT from the tunnel
> info key.
> 
> However, the IP_TUNNEL_DONT_FRAGMENT_BIT in the tunnel key is never
> actually set, because the tunneling code doesn't actually extract it
> from the IP header.  OAM and CRIT_OPT are extracted by the tunnel
> implementation code, same code also sets the KEY flag, if present.
> UDP tunnel core takes care of setting the CSUM flag if the checksum
> is present in the UDP header, but the DONT_FRAGMENT is not handled at
> any layer.
> 
> Fix that by checking the bit and setting the corresponding flag while
> populating the tunnel info in the IP layer where it belongs.
> 
> Not using __assign_bit as we don't really need to clear the bit in a
> just initialized field.  It also doesn't seem like using __assign_bit
> will make the code look better.
> 
> Clearly, users didn't rely on this functionality for anything very
> important until now.  The reason why this doesn't break OVS logic is
> that it only matches on what kernel previously parsed out and if kernel
> consistently reports this bit as zero, OVS will only match on it to be
> zero, which sort of works.  But it is still a bug that the uAPI reports
> and allows matching on the field that is not actually checked in the
> packet.  And this is causing misleading -df reporting in OVS datapath
> flows, while the tunnel traffic actually has the bit set in most cases.
> 
> This may also cause issues if a hardware properly implements support
> for tunnel flag matching as it will disagree with the implementation
> in a software path of TC flower.
> 
> Fixes: 7d5437c709de ("openvswitch: Add tunneling interface.")
> Fixes: 1d17568e74de ("net/sched: cls_flower: add support for matching tunnel control flags")
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

