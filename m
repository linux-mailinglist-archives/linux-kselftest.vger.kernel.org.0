Return-Path: <linux-kselftest+bounces-27915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0003A49D61
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5AF189918C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE2025DAE6;
	Fri, 28 Feb 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="cR514c5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J2MERTsJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3271EF38B;
	Fri, 28 Feb 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756333; cv=none; b=Ei/KsZy8Qwhlw45ZPDIf7/mEpCw6nvaTZODoo51NjrXL5RyV/hq3CMwNXU/GG92b/Kn3No7TjkjSdr8O2IrlIEnIjuIb51Z+5QU0XyqQQXlbWnCfzvmvH0PM2nZpd8vwojSSnZN22cLmwKUIx2HulVEwTpMQS8KeXfwnMEnxCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756333; c=relaxed/simple;
	bh=ODmNapznqY8Lme8EQzhzqsVIiFhxyacVEuG07Lrpk8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7TDLb1qf5nXEAI4xEbG5Ez+Lza1UEzsYDL2latfQVWqO4u7l9zHqhm3kXD4eoRpi3eoTSo2t/AVIvGBcuyL+9qKjy2hesq5+OQYgU/W7t8CpE94dTarMZeb3fO4w+1soQLFtUDl6f4t5yMOLjlbG6Qj7zL/ll6ctdICpvORA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=cR514c5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J2MERTsJ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 207FE1140115;
	Fri, 28 Feb 2025 10:25:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Fri, 28 Feb 2025 10:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1740756328; x=
	1740842728; bh=ErdEwWcoExwEOY5i1AObPTgWEmNKaVenoEWoKPxkSio=; b=c
	R514c5kPjM+fYh1kH7V8EFmY/yNHbWD7bka2YKC6ChQeB6LMbR6pWlcZBH1pVmZP
	SRhNuPhncPdKIyNMXt1Q6aNLF8mHSO/g/1g+vWdwrgh57A0gE7UT+f+tr1ycq4QB
	1ikHfMGnpElAGI4jITrdKu11ZyxOK3XF5IXFrzraWdm71jVNAoZCspChAIwwJ+SD
	NkVc5hSJZiOtQViC3hxB11212nSllwoYcHWwncROJUrrNTpjVe8CN9/+1nqfcpcy
	RCrTUcPhev3YSHUMmrh2MZ99tLwDr3lNMybsXQslYpphWFgi+FwIdooxWCab9amk
	MaGoksyQlpg8yAEyobdSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740756328; x=1740842728; bh=ErdEwWcoExwEOY5i1AObPTgWEmNKaVenoEW
	oKPxkSio=; b=J2MERTsJA9SZKVy7proKCTzdmJizI094Ux89ZbR16wKtKr1iWGi
	56NX7V1oHvVfocccxHJqLWk/+xmuc0m35oN7r3X3pxPeHTuODmowTHQ1FZtYwNg0
	w0IwuwqtwR1A1HKm0RvUv9lF031FZcvqoa5vapKfm7YFWuEO6AGQNwmmE1NbQ+Na
	KCXDHspjzyRtnE7O21LhryIiep10x1cUZE3jwoYkTnf4ydkVsubSG57LpnPVvHmU
	EmEzie+qc1S2u+Qps5pf380gvYa1fk265K091pcNuDEaBkDcvCHFsAvgKmZVrcy2
	bQP6Z97tOuhJUlEWhe9Uh/jdUMzmGfBbGvw==
X-ME-Sender: <xms:aNXBZ7zShFUL8VxB5mnlPUfmPmZdzdYBnL15GBbkjGbq6jyggvEFOg>
    <xme:aNXBZzS-KFShLzicVvQVF5VSXyAXS4jTw0fOSpZjsMHgpEDCjvaPcBiAj2Nakjgg7
    Hd3lfWybW4ucWeZzv4>
X-ME-Received: <xmr:aNXBZ1UMjNf6Pzg7oNU46vg1ZfJHLLCqPFzuVc69-ElSX8SPBCxpqW07-adJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtoh
    hnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:aNXBZ1gK9fLxRDIsHr6FK2-sNN-REHCuiak6aiBIypd-dUOzp43XmA>
    <xmx:aNXBZ9A7BK_vw-DNFctbe47SLGYou0vcjkjHoO8ektE2ylZB-Tpx2g>
    <xmx:aNXBZ-LzMFeZtzWuSItq2dU0YDUHd7w9Q26g1Tz2dgUV_IJAjA-rYA>
    <xmx:aNXBZ8B06l3osqXklxmOftSldYp1VWcOD8MUf6EcjHBWT_CYLBK2qQ>
    <xmx:aNXBZ1w9ywBUoD5AK63W6eRjzpySEMVLmIENMhclsoJ_Iog7sJ66Einv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 10:25:28 -0500 (EST)
Date: Fri, 28 Feb 2025 16:25:26 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v20 09/25] ovpn: implement basic RX path (UDP)
Message-ID: <Z8HVZm_eQwNR_r1A@hog>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-9-93f363310834@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-b4-ovpn-v20-9-93f363310834@openvpn.net>

(I'm still reviewing how everything fits together, but one small thing
here:)

2025-02-27, 02:21:34 +0100, Antonio Quartulli wrote:
> +static void ovpn_udp_close(struct sock *sk, long timeout)
> +{
> +	struct ovpn_socket *sock;
> +	struct ovpn_priv *ovpn;
> +
> +	rcu_read_lock();
> +	sock = rcu_dereference_sk_user_data(sk);
> +	if (!sock || !sock->ovpn) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +	ovpn = sock->ovpn;
> +	rcu_read_unlock();
> +
> +	if (ovpn->mode == OVPN_MODE_P2P)
> +		ovpn_peer_release_p2p(ovpn, sk,
> +				      OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
> +	sock->udp_prot->close(sk, timeout);
> +}
> +
> +static void ovpn_udp_build_protos(struct proto *new_prot,
> +				  const struct proto *orig_prot)
> +{
> +	memcpy(new_prot, orig_prot, sizeof(*new_prot));
> +	new_prot->close = ovpn_udp_close;
> +}

Could you set ->encap_destroy in udp_tunnel_sock_cfg, instead of
making up your own struct proto? It should allow to do basically the
same thing, but with less code in ovpn:

->close = udp_lib_close -> sk_common_release -> sk_prot->destroy = udp_destroy_sock -> encap_destroy


-- 
Sabrina

