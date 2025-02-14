Return-Path: <linux-kselftest+bounces-26633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E070A3560D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 06:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E449616CFD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 05:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519F61714D0;
	Fri, 14 Feb 2025 05:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="nII9W+eC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="baep5RrY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2E16CD33;
	Fri, 14 Feb 2025 05:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739509886; cv=none; b=K+LVUWAXJDx/kVS2SS+BTxuMtC/NAWsNGtaQPwlMvW3EAH84KBAqd1c05sEi3EO6t6Pz+Pw8RpGcj3FG69QKjpXxWd5xqxyAgScn9klWJRkh3Zv9XTgRYnkI/1TlVS4QkuQXzmCVNccTBzoLE0+AzVFFZBKp+5mQq81gG5vOk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739509886; c=relaxed/simple;
	bh=izTXpmjkLskuTaKgQ53chP8qGfsAs27u/crrMU1WP+0=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=RaYE+F6M05c3Tkcoy8KpvOZncEldJ0K6sLhV9cpn+uPiTzu+6LA65/qEdtp4mDOqayNkUkM12aSEDQjKg+H95iTB6U0k0PMAroD9PLTW2Z9I3L/WbNmYohR7nZzTtsKiKbQLYAvq+lpU+bAHYOcVFmQOpIaxCT4ztorDuJTwxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=nII9W+eC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=baep5RrY; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F91911400EC;
	Fri, 14 Feb 2025 00:11:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 14 Feb 2025 00:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1739509882; x=
	1739596282; bh=heMlusK5FGA6JqL97UB/JZCAI0C9yt2iHuQEDmaniks=; b=n
	II9W+eCiL7CV2whRTV1Xb/uBvTekDrriJJa5+7d+MVlHYHVK2urzM2PY78tKVLp/
	4cSjy9jLAxuPb9DSx/jfYzRb5dR4Af6EY7NCe7HAWvNerCoarJP0LBH4DFeZtz1p
	JlY/uXO2ahq+y+FfOKrYzvhz9ntGMkz9Fkr95tK+mI8uD3/j4aTTMannZuKQTuPW
	yDRd/IIeizV0nMiuJZ1C32mCct0Fux4x7ewP01DnO7QKvSdtuxH7I8Yax4upRhzN
	JNzUtZVm/RxJNNkkwL/64juXMEmRdpQh7EncNTMLi/puS+oREFevqfxpNaOa3SuF
	5XUkbd+qttR3IdMwBYlGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739509882; x=1739596282; bh=h
	eMlusK5FGA6JqL97UB/JZCAI0C9yt2iHuQEDmaniks=; b=baep5RrYQPiyfvkCh
	06Gdqq7dU36kSjLHnOUNXn39ilKCG8EgKVk7sgNEJ+FJgmjTcDV+eMpAyyw/yHGi
	J2vjUDzoC74zd7FXQa55yCqZVI2JTVE3T98KHxZRXqNVWWjEjwEk51aDAwmYvo+D
	Lysgff/P3j9xRQjCf+s5pp0me7PS1TAn8O+fovcz8H0vvpcJRqL1EQSZau5RpyGa
	85TpIx7l7SwIk/KUQhl+F9bwuchQd/gVoKfSgH1TlZkVYOFVUzpW+oalPl8VANCt
	E8dndfQfuR2qUnT3p4dgxSblVEglTimbbqHk0Q1i4m+pv1QXk5dFBBphFVvr0S2N
	IEM5w==
X-ME-Sender: <xms:edCuZzzKnRIDlAuq4um28_84z9ghYnx_yWxoolndABPFgBEzpiVaCA>
    <xme:edCuZ7QfJ3D7MESVkjfPhmdgAbhSxUsmx_F_Sm-Dbv-ZvghVr_4s-PWsJNHLMMyDc
    YVg9yDeBVttk0YI5m0>
X-ME-Received: <xmr:edCuZ9WPdDAQjpP2S17k5M9SkBMf6cGOqKyaeebzM9D-j5cJ6-eyKagln_51p1L2i4YUOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegkeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtfffksehttdertdertddv
    necuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnh
    gvtheqnecuggftrfgrthhtvghrnhepjedvgffhteevvddufedvjeegleetveekveegtdfh
    udekveeijeeuheekgeffjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthho
    peduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkh
    ifrghllhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhssehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgif
    odhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegsohhrihhsphesnhhvihguih
    grrdgtohhm
X-ME-Proxy: <xmx:edCuZ9gHGu7_p1PU8Gg6KqhcN8jIPFFCGgPzcAG5dSRp7CrHLKGGcg>
    <xmx:edCuZ1ArhYtB1PW9FRZYUvxT_ztQOcpg1chBf0FmixcN3BxiGLSyjQ>
    <xmx:edCuZ2LtQ9vtQsKJ9lDR3h8DhUJkwicN-U_1eXqejy5jj0DFo4Zw3g>
    <xmx:edCuZ0CwJ6gvLFXIG_aXn8tM1ybbJooWBGa4qYKzEkmTI1rpHr9qHg>
    <xmx:etCuZ_T4DGXuhh6UQSGobHRkaXcDoQlvwNv6i1-wfcfYvw7dHoH0qz9h>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 00:11:21 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 6975F9FD37; Thu, 13 Feb 2025 21:11:19 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 689099FD36;
	Thu, 13 Feb 2025 21:11:19 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
    Boris Pismenny <borisp@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
    Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net 0/2] bonding: fix incorrect mac address setting
In-reply-to: <20250207092920.543458-1-liuhangbin@gmail.com>
References: <20250207092920.543458-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Fri, 07 Feb 2025 09:29:18 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <985474.1739509879.1@famine>
Date: Thu, 13 Feb 2025 21:11:19 -0800
Message-ID: <985475.1739509879@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>The mac address on backup slave should be convert from Solicited-Node
>Multicast address, not from bonding unicast target address.
>
>v3: also fix the mac setting for slave_set_ns_maddr. (Jay)
>    Add function description for slave_set_ns_maddr/slave_set_ns_maddrs (Jay)
>v2: fix patch 01's subject
>
>Hangbin Liu (2):
>  bonding: fix incorrect MAC address setting to receive NS messages
>  selftests: bonding: fix incorrect mac address

	For the series:

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

	-J

> drivers/net/bonding/bond_options.c            | 55 ++++++++++++++++---
> .../drivers/net/bonding/bond_options.sh       |  4 +-
> 2 files changed, 49 insertions(+), 10 deletions(-)
>
>-- 
>2.46.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

