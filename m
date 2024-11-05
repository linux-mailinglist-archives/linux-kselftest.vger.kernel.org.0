Return-Path: <linux-kselftest+bounces-21456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25F99BCD98
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 14:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CFB1F215E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859D41D6190;
	Tue,  5 Nov 2024 13:13:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94821D5ADD
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812437; cv=none; b=hdldJ8QHXBbEsdCagwGMinswiFUy8lnUeLgxDydHc7rT21ObZXn38ffOYal3zN+xLKemvaTfzIi6N2h9D/mhEkroI84m8RNSWfXBAfYIJEmEnr5vgYMw5xeAfMn1JcbcyHDc9ITqA/cnqb24p/HN2+PmMSUJq5wjb39s6OiOuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812437; c=relaxed/simple;
	bh=cTKw4bucyHaUEfDvFtmmDk1lZHQhrQj0jGdKtcdjaqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY18dvQOfDMCjI9Rfg0SrWsgxOoJQQduZ/ftQ5Pgixk5ZR4BwsFas3p4bhiHgI2jCOYJJj4h7gFzBhbHQ5Y9CTG70CFNthQaiVYdUa37zOvCr6UpNpRnilzxcBTQrjn/2s3ZiBEP72bpa8QPVHi0vyI5Ee7N+EBnTRDJOlT6EUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=fail smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-faJWNgejM8q20QJChVO3XQ-1; Tue,
 05 Nov 2024 08:12:41 -0500
X-MC-Unique: faJWNgejM8q20QJChVO3XQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91DA51955F56;
	Tue,  5 Nov 2024 13:12:39 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29E92300018D;
	Tue,  5 Nov 2024 13:12:34 +0000 (UTC)
Date: Tue, 5 Nov 2024 14:12:32 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 06/23] ovpn: introduce the ovpn_peer object
Message-ID: <ZyoZwIOno_U_yMPF@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-6-de4698c73a25@openvpn.net>
 <ZyJgs6Vrvzji8qvS@hog>
 <4df15a91-4bcb-49d8-be78-28c71036ba8a@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4df15a91-4bcb-49d8-be78-28c71036ba8a@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

2024-10-30, 21:47:58 +0100, Antonio Quartulli wrote:
> On 30/10/2024 17:37, Sabrina Dubroca wrote:
> > 2024-10-29, 11:47:19 +0100, Antonio Quartulli wrote:
> > > +static void ovpn_peer_release(struct ovpn_peer *peer)
> > > +{
> > > +	ovpn_bind_reset(peer, NULL);
> > > +
> > > +	dst_cache_destroy(&peer->dst_cache);
> > 
> > Is it safe to destroy the cache at this time? In the same function, we
> > use rcu to free the peer, but AFAICT the dst_cache will be freed
> > immediately:
> > 
> > void dst_cache_destroy(struct dst_cache *dst_cache)
> > {
> > [...]
> > 	free_percpu(dst_cache->cache);
> > }
> > 
> > (probably no real issue because ovpn_udp_send_skb gets called while we
> > hold a reference to the peer?)
> 
> Right.
> That was my assumption: release happens on refcnt = 0 only, therefore no
> field should be in use anymore.
> Anything that may still be in use will have its own refcounter.

My worry is that code changes over time, assumptions are forgotten,
and we end up with code that was a bit odd but safe not being safe
anymore.

> > 
> > > +	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
> > > +	kfree_rcu(peer, rcu);
> > > +}
> > 
> > 
> > [...]
> > > +static int ovpn_peer_del_p2p(struct ovpn_peer *peer,
> > > +			     enum ovpn_del_peer_reason reason)
> > > +	__must_hold(&peer->ovpn->lock)
> > > +{
> > > +	struct ovpn_peer *tmp;
> > > +
> > > +	tmp = rcu_dereference_protected(peer->ovpn->peer,
> > > +					lockdep_is_held(&peer->ovpn->lock));
> > > +	if (tmp != peer) {
> > > +		DEBUG_NET_WARN_ON_ONCE(1);
> > > +		if (tmp)
> > > +			ovpn_peer_put(tmp);
> > 
> > Does peer->ovpn->peer need to be set to NULL here as well? Or is it
> > going to survive this _put?
> 
> First of all consider that this is truly something that we don't expect to
> happen (hence the WARN_ON).
> If this is happening it's because we are trying to delete a peer that is not
> the one we are connected to (unexplainable scenario in p2p mode).
>
> Still, should we hit this case (I truly can't see how), I'd say "leave
> everything as is - maybe this call was just a mistake".

Yeah, true, let's leave it. Thanks.

-- 
Sabrina


