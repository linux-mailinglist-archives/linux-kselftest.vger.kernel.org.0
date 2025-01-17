Return-Path: <linux-kselftest+bounces-24717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57FA14EE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 12:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8EE188AEA7
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 11:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0597C1FECD3;
	Fri, 17 Jan 2025 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="bj45IlOm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wvoVoU7S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FF1FA8EB;
	Fri, 17 Jan 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115088; cv=none; b=fq3U1evSEXxpFGUYhFVpYSewELJoL4be2HrC/iqXvS0EgWtRAFEoVRDyVFJVs8XpJpLgRQCOe7soO9VLeMpgiMiRnjNEOQIKpUzKE9L7/UyhWAxP+8s1bP/u+Ez8OqtzS6EJPDOhgEpTcEGB3AO6ljOWohxYcqA576GQrQ1eCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115088; c=relaxed/simple;
	bh=koHy8Fp/KsUbzAZf+xqsbxBSKwdbSs2srJZ9Imy/DCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRI8LFrkjjkJNnJYNMzmcrWVN1z+dzMgl8BnBzCakdLcAou4T7oILYoCSfF6zbnqr2HTuYSQ1dJPyWZFCuGQ3HFwBCh1BdouzuQBCrmeMyq++ryqRwe15XGBbYcCo0pwWHWQXZ5wtf63tMtx4vY8tza6vqzU3GTEh1Vam557JRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=bj45IlOm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wvoVoU7S; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FF4E114017D;
	Fri, 17 Jan 2025 06:58:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 17 Jan 2025 06:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1737115085; x=
	1737201485; bh=HZm3SRxkYdy3LkVuLEa/Tczhe+fjDLKMliYQG59gLac=; b=b
	j45IlOm4K/l2ekjfci40QYgBOq2EnRwuAN6KOuTu0CX3EdEQ+VjKA17V6hh9EKST
	o5rFGCTslyXVL6LOw5Ae9SqPi1aRHUmtDzSA6U0AOabWcQKFKj2jL8RrTzEgEt06
	s6zUfL/6jdX/J/RcPM50SqcgJNvRXR7/IgPj4uDbaY1Lfi72XKtp+0QXPrvzyTfK
	wsIlWhci0OFBjrxjf5BJ4KIBrlB2nTbn8fXWflzn6Ih1rJWdidaqGDfWmNqXOOHZ
	r2DkCUtBHp1LnihBSgsi3heaWMrXO+7V8CJ11wVULzVUqFTprJassb4X/rU8RCyn
	371Xs5v7r6jbRjEAwo0fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737115085; x=1737201485; bh=HZm3SRxkYdy3LkVuLEa/Tczhe+fjDLKMliY
	QG59gLac=; b=wvoVoU7S5Rb/6Nu0WnIXhhyRajkZ8j92pFvGMiMHHzVNTLzNpIn
	p/47VvOnGY3Zn3ucVC4wnyCvmB2SLR2F+fpS2WyzVegDd5E6AwsFCZ3jJQ3pLAA5
	jIQRVSvrcy6ysCFF+GkopJMJ6fEEgSPbh4YoYQeg6C17eMRmBmSjPLxxzc5Scqnm
	sufpwPq2Uota+V//v9xIRqaWZE8nAgosnhr655wGSUkUhUetY0KMVZySeHXjvnnJ
	3R0eAHH9dfUuYdtszFPpHtN2Ye66xWHGqncOyopZyFK3ScfWDUlWP4p3bLF+5XTZ
	7XEOjpUPW/kz32/qyPQafs1BLMz4O5LmAhg==
X-ME-Sender: <xms:zEWKZ9jKb7puFMdeqnm7uVI_25EAvxNcISZx6xWMaLpr0rsIcmk_HQ>
    <xme:zEWKZyCK7WhbpAaC1VYgtOZWx7t3h8fk3xJc0eJA0kYxeKgEGRG-7wLGeej9tBRft
    -4rbZgInvELZ-kOqDs>
X-ME-Received: <xmr:zEWKZ9HnHCSyad-wEeKSW-65Toz3eehKb4uEoai31UDRzCeam8mogc8jfXB2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtphhtth
    hopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:zUWKZyTmI5Do3FhKULD6bJknu4h0bH-ZBUQQhJ5zdKDWRPQYvyBwaw>
    <xmx:zUWKZ6wZgT3lofexLM_0ryuGzbjOKEDAs8K01HuPTsNqaMmSRK6MrA>
    <xmx:zUWKZ44Sf4BlDA8NqQ5ydpXH7z0GFsASXQhO1MjACoVIdYHhOT650w>
    <xmx:zUWKZ_wLTJKEVzOWRpD_Qy0jPvyE7rgqE5pezUni3y7s928ug9Xm3g>
    <xmx:zUWKZ-jE5MjCMytvypE_rPxFn453Rhh2FdjcWBcP7Rt6lI9jN6yeRRvP>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 06:58:04 -0500 (EST)
Date: Fri, 17 Jan 2025 12:58:03 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 05/25] ovpn: introduce the ovpn_peer object
Message-ID: <Z4pFyxhmBgKBA4-Z@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-5-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-5-1f00db9c2bd6@openvpn.net>

2025-01-13, 10:31:24 +0100, Antonio Quartulli wrote:
> +static void ovpn_peer_release(struct ovpn_peer *peer)
> +{
> +	ovpn_bind_reset(peer, NULL);
> +	netdev_put(peer->ovpn->dev, &peer->dev_tracker);

I think this needs to move after the call_rcu. Otherwise, module
unload could proceed (no more ref on the last ovpn netdevice), not see
any pending work in the final rcu_barrier of ovpn_cleanup, and finish
unloading. Then when ovpn_peer_release_rcu gets called, it's not there
anymore.

> +	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
> +}

-- 
Sabrina

