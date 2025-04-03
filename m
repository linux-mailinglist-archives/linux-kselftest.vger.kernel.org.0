Return-Path: <linux-kselftest+bounces-30055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4CBA7A0FB
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 12:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D75D1733BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411502475CB;
	Thu,  3 Apr 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="BL1hUM+w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="umQ/pjeZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB9161320;
	Thu,  3 Apr 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676142; cv=none; b=a+7ZmIU+TTRyZnNdeX1LBn4LrdaWhelZ6gIKf+1tsy5dsXG/DtxGQ5lIKI3LLv0mLEInlxDQzWWFnBuHa4JvILMHLijcv0KHCdRnbxxgl6mGyYnDZBXNVFqap2ol09iQCuw2Qmydb6GoG8pDu8v5EQezcxy/g8KOdVIYg1beHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676142; c=relaxed/simple;
	bh=dSF/aEX68vuzGeThjYeo1cpD+4IU5IGww9tyfUfsONM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lkk+8mjBiDmh/JGje01GDpBzX02zDq9D5h86ziJxMSJa349+3G7aSb/DpGvznW9dsrneWlnOVKRNMcYu4rwK4lUPquuzZ8xncyfmAuphaLFIVnzfPNutLe/QJBU6kFwKP0CMHVfc+qc96mAtf730Ak46p7yU0GK42oX4fHMURgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=BL1hUM+w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=umQ/pjeZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5BD8D1140191;
	Thu,  3 Apr 2025 06:28:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 03 Apr 2025 06:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1743676137; x=
	1743762537; bh=9eS8zf1c2sh6XxZbfPo1lRB/F6Yx563j0n/tE8GwJV8=; b=B
	L1hUM+wl5huEtZ5zjWrChkA96ajf1EBJoDnu98E1tWmdhxp3Qac6+Oc7pD08AFDE
	i+6i1HX4pOlEmYMKhUNstcAcoquMK5kfwnaD/qzoKgb+7sSkl5j9w6AZufVFKd7b
	ei/q99roZcU+h1nbQ8cCoxQpFt+J5eY0DqEBR3HsdKkUgfesXzUG0eRJ99rlrFGZ
	pj13TsZc6ahya8wobI6zn0GGHW/9M40Ipf3S17LfyqgfNYZAKO3DB1z/Ncyy43Sx
	GytRyHyFR+xFOpsI0LXi769dUITZnlqNa9+wafCYP/xneqX9+3F9kzE0FSTdUQbF
	wmAatTm6+kqrZsgswr78g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743676137; x=1743762537; bh=9eS8zf1c2sh6XxZbfPo1lRB/F6Yx563j0n/
	tE8GwJV8=; b=umQ/pjeZEguT9efjgGYHkLOf+FV3/XAqVdDWTScNQFBK/LW/8T1
	746Dkzpgd4vzIxXfsmsOTNmA/KDX/85X/721lKWKu8GDuP9D7QEPf06U8FG+IZZl
	PRsOa+N/RaGV6CCxG+HgVHXPOVD2lI5dGpbdO35EkPqikqalUY4ZAhn4XG5yW9t6
	xWvlGod78tAXpRkZX6huIeWtNALwSzmih83l/IMGLR3hl0iWSeofTUa6UrFbLxrX
	roZkR2xxKBJkSrU1quZEgRw5xSX0EfgPno5fnMonnsq+M+Kd1htodlZwJXPz0SWU
	95mYkJyviGpPToow7YVLx3ZbzlF1McAusQA==
X-ME-Sender: <xms:6GLuZzaI8u1YS6lGepNy2-uoOk0uibOJfsbw7js9ZlIBTbzdxwp3ow>
    <xme:6GLuZyafYuQCls5-9Cuj63b70sm9LE6tio9kG05dlgzqiS2rj0BqZ5KM8OztNKYRx
    oxeTS7GLMvxXLJvj_w>
X-ME-Received: <xmr:6GLuZ18_YnvmTn4MPo1q7j1RmnKZ_M8KJiE3FktvyQl9g677Ijdtw70kEDxH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuh
    hhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslh
    hunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhr
    tghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuh
    gsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hshhhurghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6GLuZ5rBO-D58IJZVnEPHDZwCI9qYDO8hgdheII9DE8RJXpeXNbRlg>
    <xmx:6GLuZ-qOnWuydf0bGgWcywmy4ySMIURBjXUjsH7cahqWUMhY9Tpo6Q>
    <xmx:6GLuZ_SxGo13c4GlfYEiDZhdWsB4xXTQ_QqRPemLIiTj5GrPK4TnPQ>
    <xmx:6GLuZ2qOzCdtuyeQt23DQddRVDPjAG0PTKlItIAk8FO6D7evZWv37w>
    <xmx:6WLuZyPRBfYlQy088CtY7M4H8_GEvl3GqBBimBaDZjNRlsareqa56UYa>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 06:28:55 -0400 (EDT)
Date: Thu, 3 Apr 2025 12:28:54 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Di Zhu <zhudi21@huawei.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Travis Brown <travisb@arista.com>,
	Suresh Krishnan <skrishnan@arista.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/3] ipvlan: fix NETDEV_UP/NETDEV_DOWN event handling
Message-ID: <Z-5i5rsrIyE0fM-V@krikkit>
References: <20250403085857.17868-1-liuhangbin@gmail.com>
 <20250403085857.17868-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403085857.17868-2-liuhangbin@gmail.com>

Hello Hangbin,

2025-04-03, 08:58:55 +0000, Hangbin Liu wrote:
> When setting the lower-layer link up/down, the ipvlan device synchronizes
> its state via netif_stacked_transfer_operstate(), which only checks the
> carrier state. However, setting the link down does not necessarily change
> the carrier state for virtual interfaces like bonding. This causes the
> ipvlan state to become out of sync with the lower-layer link state.
> 
> If the lower link and ipvlan are in the same namespace, this issue is
> hidden because ip link show checks the link state in IFLA_LINK and has
> a m_flag to control the state, displaying M-DOWN in the flags. However,
> if the ipvlan and the lower link are in different namespaces, this
> information is not available, and the ipvlan link state remains unchanged.

Is the issue with the actual behavior (sending/receiving packets,
etc), or just in how it's displayed by iproute?

> For example:
> 
>   1. Add an ipvlan over bond0.
>   2. Move the ipvlan to a separate namespace and bring it up.
>   3. Set bond0 link down.
>   4. The ipvlan remains up.
> 
> This issue affects containers and pods, causing them to display an
> incorrect link state for ipvlan. Fix this by explicitly changing the
> IFF_UP flag, similar to how VLAN handles it.

I'm not sure this change of behavior can be done anymore. And I'm not
convinced vlan's behavior is better (commit 5e7565930524 ("vlan:
support "loose binding" to the underlying network device") describes
why it's not always wanted). IMO it makes sense to have admin state
separate from link state.

If you want a consistent behavior, the admin should also not be
allowed to set the link UP again while its lower device is not, like
VLAN does:

static int vlan_dev_open(struct net_device *dev)
{
	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
	struct net_device *real_dev = vlan->real_dev;
	int err;

	if (!(real_dev->flags & IFF_UP) &&
	    !(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
		return -ENETDOWN;


(but that would almost certainly break someone's scripts)

-- 
Sabrina

