Return-Path: <linux-kselftest+bounces-30863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC708A89CA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA6F173886
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F12289378;
	Tue, 15 Apr 2025 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2ZwlbJA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080C1CD213;
	Tue, 15 Apr 2025 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717058; cv=none; b=axmg4optlk5eZJnj6eRiSBCoFOEu2Th7VNCkt1SBD+K5EXAWtzCM+Haxu1jmcnQUeSaCTNX/gqrK+6frzZA1SQjI92KTmQJTfmKI8Nm0QPyBAJjfwd1h83FtWBwcEakCQIlOcwtjPL81+H1rY003I4TpPJPCckLTQtSA3JOiEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717058; c=relaxed/simple;
	bh=A2TSmsOW/blYb3WpryncuCWD9dGMjOMZAggqPa01g4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APFxj66CAQtuIvvBtd4P6NXbPLcWJntgcJou0XW6tBrJAR4+of8dH+b0NFMt/uakN0/Ychl8epq/pOppsU9LnsdWkL8AsxgE1TUWnSq8hQbQzSWktjoMnK49Tnvut719Q5d+UVdRBO0UFf0obW+8OkNVSBs8pNPkG6qMk19n8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2ZwlbJA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B137B1380185;
	Tue, 15 Apr 2025 07:37:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 07:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744717055; x=1744803455; bh=xYpBnhlfvA1MSL6hBNxfqsWMQtyi8h9iLjN
	/6UqIjuc=; b=P2ZwlbJAvO+q01o0NnriO2vpssIqaGkTSwEVM4VBJl4Y2VCR0Yh
	QxftKmA3ulAfQYUIVyCLuZn1J1QzKFbWlCQf0LkE9eisUklzOg25A+6fL4F6ga/d
	4+AZcSeRBgbkP5mwcUlxR1qjfSuYVsJmymKQCA0ohNuIpMhjROXixzxaiPLOsno2
	tLkofpj8Xc2l/qKWVVk6UlBAeipvgNoknHsyyaksj2WhWQ3h/Ji6TmNP/kbK0G48
	1S65epLN1hSHct3r2bqs2z4ws3AEDTHkmRPeIium4UZeKyJceCRdKjXb70AxrWAo
	WWkuLZxWnJk0VGMxUlDvb+8v9exnI01F8pQ==
X-ME-Sender: <xms:_0T-Z_OWVxCe6TMOtPdrJWeZkZZuNFBcsX95ugJlGqHjdovh448uJg>
    <xme:_0T-Z5-z49DJRsa_oOH8pcNtrcvFa6gYpUza-Qrv6iOFlcNdXOntL3PBea0Kzg1NI
    MUjwlMjQ7aN4Ag>
X-ME-Received: <xmr:_0T-Z-SsSPSAWILwvIXSCjl-aCZ362LXzlXLklmooj1RyMcLV4Hsw_7tycWV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeffeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhokhdrrgdrth
    hifigrrhhisehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_0T-ZzvhWa1gTpiTtePZxTjJeV3v4eqkL1fYhwsiDdo1P0qnLQNWRA>
    <xmx:_0T-Z3esR5gkU77DdKuj2sm7h-S9bugfxm8JRyfOcKzMc6Yh_uHGSw>
    <xmx:_0T-Z_30Eezv0rE63jg5fDZYjX7RMM-1d5UAO0ptftLIMVSxOnVrMA>
    <xmx:_0T-Zz8vmlciHaf6lrabGvkd-5CvN4QH9XwPnPk0giU20DzRlQdB5g>
    <xmx:_0T-Z8CHlxxvXW_59mtLXknaULys4hIj3QC3LNt7EDfOsSS2XKm7eIPe>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 07:37:34 -0400 (EDT)
Date: Tue, 15 Apr 2025 14:37:31 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, darren.kenny@oracle.com
Subject: Re: [PATCH] selftests: rtnetlink: Fix bridge_parent_id failure on
 interface state
Message-ID: <Z_5E-wuE6b3HyHRU@shredder>
References: <20250414172549.1691612-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414172549.1691612-1-alok.a.tiwari@oracle.com>

On Mon, Apr 14, 2025 at 10:25:33AM -0700, Alok Tiwari wrote:
> The selftest "kci_test_bridge_parent_id" fails with the error:
> "Device can not be enslaved while up" when trying to attach interfaces
> (`eni10np1`, `eni20np1`) to a bonding device (`test-bond0`) while the
> interfaces are in the UP state.

Why are they up? The test creates the interfaces and never brings them
up.

It's most likely caused by some interface manager in your user space. I
suggest fixing that instead.

> 
> Failure log:
> COMMAND: ip link set dev eni10np1 master test-bond0
>     Error: Device can not be enslaved while up.
> COMMAND: ip link set dev eni20np1 master test-bond0
>     Error: Device can not be enslaved while up.
> FAIL: bridge_parent_id
> 
> This behavior aligns with bonding driver requirements, where a slave
> interface must be in the DOWN state before being enslaved. This was
> reinforced in upstream commit: 'ec4ffd100ffb ("Revert 'net: rtnetlink:
> Enslave device before bringing it up'")'.
> 
> This patch updates the test to bring interfaces down explicitly before
> adding them to the bonding device:

I don't see why the test needs to bring them down when it never brought
them up to begin with.

