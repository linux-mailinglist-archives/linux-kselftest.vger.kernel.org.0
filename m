Return-Path: <linux-kselftest+bounces-28047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E0A4C148
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 14:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1468216B082
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946442101A0;
	Mon,  3 Mar 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RuhhD5gJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iTZKGEif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3713FEE;
	Mon,  3 Mar 2025 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007308; cv=none; b=bQE4Kxnf/xz2YxMqQ4mA2kmWv89cuSAcuBcf43GIJWtv+x24iuLAdSEge12TZVem+9nrOt0QnWjT+23+4suiU/TboaK/+QxfEtC88QyFv42JErTJvetqOdinr2Osa2kkGAC7B7lrdluHq1Rk2tacHGhW/kq+sNAan5LrR95uMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007308; c=relaxed/simple;
	bh=3e4pvZJ6qOzThieTh25YKoc1BBXfGNGYvfQoI44YxU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qt/ENZTLcMmS50YUFVAKlKgItomTrzMjQRpm9A88RBRLyK+CNYyEuZUartsywgLN9BHxGmMZSBJvw5r07lGgP62svJLDeWXDQ9erAwS/E+teNIOBA7oHImAoIhHOqNKaHHtX7kBoY2hKal3b+G0eM92j1yGS5QV3b6Utoe+xbVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RuhhD5gJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iTZKGEif; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id DE8E01140097;
	Mon,  3 Mar 2025 08:08:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 03 Mar 2025 08:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741007303; x=
	1741093703; bh=qTD6lTVa1BXKH6rdLuvrwcm57PH71xGunbA3RUF0JyE=; b=R
	uhhD5gJ3/HbwJQkKy9TghXOO0wiCyiqDgMZxnALutwuJjKdsft0z3XQ4LQd40/t7
	kIs0rL/EozpuTwqrX/FyfaX5SRFtqr35/ebWtm4C92qMH5qKGXUvHsOFiGSSMsj1
	/nV0CIswrusOD4fJfi+lie0Ug10x7gqWxLnWqiNV1YqzY9bPuB1ChR3itvQTAQWM
	JI0p2IocMWLtgaeAqOQAA7509Ky9CCrtgjstknU89hzaVk1MEXu86Zf341oIFg6b
	It2JxbK/iOXlwR4DBiKR4RUr2EtKYn18FDXQ/Did6nWTzl6RLtsu1A8qohVxV0OJ
	Lh74zjOUSPi1dd/mDquUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741007303; x=1741093703; bh=qTD6lTVa1BXKH6rdLuvrwcm57PH71xGunbA
	3RUF0JyE=; b=iTZKGEifaNjV4yqaE43/doCqqjkP2xYDmQnopDaMeiM31YGwBMi
	6SDxCC8EO67cD/8YL0VD7J6zlbOOshCB9jR5SFiTI9Ch8KJXt6xmPvL/M/xVOCDY
	zJUYdfVCcl3wH+8vFiLk6AMDX0Derqd4SJkL7qaHeBTGpOisOAYl36LaHETlEv9g
	o7fgsRId1oSExqWCLlPkm6XoXWGC2BM9RTbUpaE6CJv/f6NzT7TtxfinrJpkXsBD
	OArK300FWNLWvK/4l7IWn+59+628juI/1p0hS5e6o5g8xB/e2QTiaVSWWbwFjx8P
	FBnsrJ/7zJbsLHKwjOKPboM93HzqkZ3ruWw==
X-ME-Sender: <xms:x6nFZ_Jx9yS9_qD3ChbuXgO58uf8DYKzvRAXKAXvGoM6pcNdYj-VzA>
    <xme:x6nFZzIMyTxlPNQBo21T4WdMmKU6Kjy6K584TarO34tNPCzPr7QEyUUHeTI8mvXK3
    8My1LgxTNLV0sJSXqQ>
X-ME-Received: <xmr:x6nFZ3t1BxQ51QXmU6CY-FFvCiM1jrghT2MCYYGQ5vjA9ejU36GHpILs7bdT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelledvudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:x6nFZ4bzAHdtU6slJYL2h7yBKStosCfZd_KmKP2tmJHKsssU2Ji6ew>
    <xmx:x6nFZ2bY_XU4d3PRFq90RvT-X_DZjRVsfjnUkk7sBbf1MCby0ipWsQ>
    <xmx:x6nFZ8Bjb8C6TdoDJxGRvRxLdZxeP4dR7TJG_NlOmPonDurhF6rbqw>
    <xmx:x6nFZ0aKqeq9InOuYX8bU-1RJ3IEy9LFB6MskumrkH2ST_EoO3KJoA>
    <xmx:x6nFZ-pqHUmyqDjVpfqpysG892uyY8pn2nsJLTRnLyvAf-aNDEOe5pOE>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 08:08:22 -0500 (EST)
Date: Mon, 3 Mar 2025 14:08:20 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v20 15/25] ovpn: implement multi-peer support
Message-ID: <Z8WpxDpHYzG9pXNl@hog>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-15-93f363310834@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-b4-ovpn-v20-15-93f363310834@openvpn.net>

Hello, a few minor coding style nits on this patch.

2025-02-27, 02:21:40 +0100, Antonio Quartulli wrote:
> @@ -197,9 +254,16 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
>  		netif_carrier_off(dev);
>  		ovpn->registered = false;
>  
> -		if (ovpn->mode == OVPN_MODE_P2P)
> +		switch (ovpn->mode) {
> +		case OVPN_MODE_P2P:
>  			ovpn_peer_release_p2p(ovpn, NULL,
>  					      OVPN_DEL_PEER_REASON_TEARDOWN);
> +			break;
> +		case OVPN_MODE_MP:
> +			ovpn_peers_free(ovpn, NULL,
> +					OVPN_DEL_PEER_REASON_TEARDOWN);
> +			break;
> +		}

nit: maybe that switch could be done inside ovpn_peers_free, since
both places calling ovpn_peers_free do the same thing?
(it would also be more consistent with the rest of the peer-related
functions that are wrappers for the _mp/_p2p variant, rather than
pushing the switch down to the caller)


> +void ovpn_peers_free(struct ovpn_priv *ovpn, struct sock *sk,
> +		     enum ovpn_del_peer_reason reason)
> +{
> +	struct ovpn_socket *ovpn_sock;
> +	LLIST_HEAD(release_list);
> +	struct ovpn_peer *peer;
> +	struct hlist_node *tmp;
> +	bool skip;
> +	int bkt;
> +
> +	spin_lock_bh(&ovpn->lock);
> +	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
> +		/* if a socket was passed as argument, skip all peers except
> +		 * those using it
> +		 */
> +		if (sk) {
> +			skip = true;
> +
> +			rcu_read_lock();
> +			ovpn_sock = rcu_access_pointer(peer->sock);

rcu_dereference, since you're actually accessing ovpn_sock->sock
afterwards?

> +			if (ovpn_sock && ovpn_sock->sock->sk == sk)
> +				skip = false;
> +			rcu_read_unlock();
> +
> +			if (skip)
> +				continue;


The skip/continue logic looks a tiny bit strange to me, maybe this:

	hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id) {
		bool remove = true;

		/* if a socket was passed as argument, skip all peers except
		 * those using it
		 */
		if (sk) {
			rcu_read_lock();
			ovpn_sock = rcu_dereference(peer->sock);
			remove = ovpn_sock && ovpn_sock->sock->sk == sk;
			rcu_read_unlock();
		}

		if (remove)
			ovpn_peer_remove(peer, reason, &release_list);
	}


(only if you agree it looks better - if it's my opinion against yours,
ignore me since it's really just coding style/taste)

-- 
Sabrina

