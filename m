Return-Path: <linux-kselftest+bounces-28216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD4A4E5E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 17:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8898A5394
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 16:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC1F28FFD0;
	Tue,  4 Mar 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RuhhD5gJ";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iTZKGEif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D2428FFC3
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103913; cv=pass; b=ZdozOcdtXxKOWbySyecI/JQVvsr1kdqoQ9NXQDgVAdV36zgPYOlVAoNrAmUNEUuq7funkSDqH1faXwe/2Yyvo6lXxlaffn1IyOcmp2yneFw45x4ZhiD63RW15Bbtat+nm4cyR/wdxHDnC+OLDwmzfa0WtiYRE2aTbxeu+LQA1j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103913; c=relaxed/simple;
	bh=3e4pvZJ6qOzThieTh25YKoc1BBXfGNGYvfQoI44YxU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKediC8IJFzsM+w6nuoXRxB1Ru47NTK7Y5YLUbERUo8RqfXeqgjn1yIxmptPtSTwAlT2nNNnFcWIIGxLxu8NRqTTFGWRZ8ScLCgz/n7GzU8drmebORtsssmPfUVYJq1fJdRbC3UamTKTG7hMeIPG3/lkgnHOfTn7T8pd9GaGK0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=permerror (0-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RuhhD5gJ; dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iTZKGEif; arc=none smtp.client-ip=202.12.124.150; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 979AD40D4DFE
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:58:29 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=permerror header.d=queasysnail.net header.i=@queasysnail.net header.a=rsa-sha1 header.s=fm2 header.b=RuhhD5gJ;
	dkim=permerror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha1 header.s=fm1 header.b=iTZKGEif
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gLF4W3xzG1dq
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:57:25 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 1F18542720; Tue,  4 Mar 2025 18:57:25 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=permerror (0-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RuhhD5gJ;
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iTZKGEif
X-Envelope-From: <linux-kernel+bounces-541762-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RuhhD5gJ;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iTZKGEif
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id A35CA4217A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:09:01 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 72FF52DCE4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:09:01 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EF1188BBE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD652210F6A;
	Mon,  3 Mar 2025 13:08:32 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-b4-ovpn-v20-15-93f363310834@openvpn.net>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gLF4W3xzG1dq
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708646.72909@T58y0UEc3pTOiLvtvuBeCw
X-ITU-MailScanner-SpamCheck: not spam

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


