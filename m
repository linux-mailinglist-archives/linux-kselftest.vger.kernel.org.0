Return-Path: <linux-kselftest+bounces-24716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E29A14EBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 12:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCA01884A48
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4E1FA8F7;
	Fri, 17 Jan 2025 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="QMV4ZnfG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I98CYozK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E83925A658;
	Fri, 17 Jan 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114542; cv=none; b=s3WFarYcuvQ/hk26NzdUpPu2XwQr3gMAqOp2cU3olTrRvhCAaZmAuh5vUiYk8IeHoEk1VUvoQoexKy0hdufTPZViJ1D5Ae9b+rAjhl6oot782uGftrSYX4J69ynFRCKcLRjkheQQ+dM5qcTGf7ucNsA1y/PZQ7lmoJchYdKBVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114542; c=relaxed/simple;
	bh=pm5XyStulbdlAdZ3XkrNSd6Uh7V+g8k83ZiP5Qo02ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fovt9WkZpxkbziBF5RTptF6Hvl9VaOR77jyq1A2uHEq6vVyMKe0jp31xnrh8UiphvIR4gye/DkS2zjOk2a8lUxQeq3M8vOfMDeWbp8amXg3sdGh4I7uBooYwgop48XHE8Z4Lnchh/19VzcvwmB2yc6yCjXj+Zo1WdaVV3uiBQXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=QMV4ZnfG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I98CYozK; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A6B125401BF;
	Fri, 17 Jan 2025 06:48:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 17 Jan 2025 06:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1737114537; x=
	1737200937; bh=6UIyLdVgYKWnhZr+oc5yeC3GlXlKcnWt9bAVcdrQB+s=; b=Q
	MV4ZnfGsdaNHcNxlL6S6E09c+lfyEqwUa3q9QMASapkW5ockhyfgfccDBuzHb0kA
	gtvKZOMlo1KyMFSxbwXNfg0fid6cGfaL2YxJBqIK+w+VACSPrO1ipirWdP12tOdo
	c5w4eeRsuoxsDfLkWOUh54YneO8rdcBzkyVKEP+24WhW/9KgnCvmx15oZIB64wLU
	tFwiZgTU/C+ief+zGGUuNsw1jDjquU84o1gP6cZtQZ6FR4HffymRN/43sQRvC/cB
	H6R9g/tKgg3LGPCP1btYD9iIRCfhU2cRx+yVFiPMUdA8jOzSa6TmLVQ8ThEi++lg
	A5fwCzhcUo6Btn4yqYktQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737114537; x=1737200937; bh=6UIyLdVgYKWnhZr+oc5yeC3GlXlKcnWt9bA
	VcdrQB+s=; b=I98CYozKXcPWVIFeFyuEkQagFrB7M0qMg+X7FV4ym3lvllLy2Wv
	FE+djnbkPRHrZSUCnsOT+iKRg04NQPfsMIksGdZ4ZrugILpDu/csV+hpSOp8S/Ox
	NJjxBIlQsefnC3aTlspsGIB2iU+9Ntb8Uh2BG8yMmPG9lJ77KY85/ZElyy7jdZnG
	OHIrE0FAOOd5fA4TfFrxYuuUpfPojseNmGFizkbwZB3F+C/2WBFI1jIhZ9AoCMuu
	dmZawltVwkpWY7HGwG1nxqAt2+ZSHxHxkBBXCqF+PV0NkdNYA9ARLlk98VZihYR+
	aMH7wErJa9CvyQrKj1sFhE7nUgewt/+tsLw==
X-ME-Sender: <xms:qEOKZ68kyW2-T4OTBe4KiXGJi64tPQPOVAOyi9F9-yRP-Af9VX-KuQ>
    <xme:qEOKZ6v041A9C28BXtnVB_BqbiFo9RUFZQZyz-m7PBsYBln5ZMMJX8EgQ3IpfdSt_
    7tax4muABY60EUCbYU>
X-ME-Received: <xmr:qEOKZwAn5Q3THpKr26_-iGB2VlCOYcSni3WzxjrG7bMQzW45u7QGMO4XWr_j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgfeduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:qEOKZycHfwSeT4XI1OcIdIf4jIrqH-UTndhncuVuxi-o2ClXs88V7Q>
    <xmx:qEOKZ_PZurBAZBHUd0ml44XQciMPOv_ZDiiPdyMxxBBCeD8Csd0seA>
    <xmx:qEOKZ8m6SUZ19KnXX_0mtqQthIhun9afeH3jhTD4ChfyLDBDQiWGDw>
    <xmx:qEOKZxuvHh1g4uEGl4TKjtDTbRT4SxS0C5pMyjkdfW3LYsjuoj1_AQ>
    <xmx:qUOKZ9sFwsv_E_LZPuL_agRD4zwbhfpk_XVj7c_gZNnu3S5GWW3iAyMf>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 06:48:56 -0500 (EST)
Date: Fri, 17 Jan 2025 12:48:54 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
Message-ID: <Z4pDpqN2hCc-7DGt@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net>

2025-01-13, 10:31:39 +0100, Antonio Quartulli wrote:
>  int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
> +	struct ovpn_priv *ovpn = info->user_ptr[0];
> +	struct ovpn_socket *ovpn_sock;
> +	struct socket *sock = NULL;
> +	struct ovpn_peer *peer;
> +	u32 sockfd, peer_id;
> +	int ret;
> +
> +	/* peers can only be added when the interface is up and running */
> +	if (!netif_running(ovpn->dev))
> +		return -ENETDOWN;

Since we're not under rtnl_lock here, the device could go down while
we're creating this peer, and we may end up with a down device that
has a peer anyway.

I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
trying to accomplish. Is it a problem to keep peers when the netdevice
is down?

> +
> +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
> +		return -EINVAL;
> +
> +	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
> +			       ovpn_peer_nl_policy, info->extack);
> +	if (ret)
> +		return ret;
> +
> +	ret = ovpn_nl_peer_precheck(ovpn, info, attrs);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
> +			      OVPN_A_PEER_SOCKET))
> +		return -EINVAL;
> +
> +	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
> +	peer = ovpn_peer_new(ovpn, peer_id);
> +	if (IS_ERR(peer)) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "cannot create new peer object for peer %u: %ld",
> +				       peer_id, PTR_ERR(peer));
> +		return PTR_ERR(peer);
> +	}
> +
> +	/* lookup the fd in the kernel table and extract the socket object */
> +	sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
> +	/* sockfd_lookup() increases sock's refcounter */
> +	sock = sockfd_lookup(sockfd, &ret);
> +	if (!sock) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "cannot lookup peer socket (fd=%u): %d",
> +				       sockfd, ret);
> +		return -ENOTSOCK;

All those returns should be "goto peer_release" (and setting ret) so
that we don't leak peer.

> +	}
> +
> +	/* Only when using UDP as transport protocol the remote endpoint
> +	 * can be configured so that ovpn knows where to send packets to.
> +	 *
> +	 * In case of TCP, the socket is connected to the peer and ovpn
> +	 * will just send bytes over it, without the need to specify a
> +	 * destination.
> +	 */
> +	if (sock->sk->sk_protocol != IPPROTO_UDP &&
> +	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
> +	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "unexpected remote IP address for non UDP socket");
> +		sockfd_put(sock);
> +		return -EINVAL;

goto peer_release

> +	}
> +
> +	ovpn_sock = ovpn_socket_new(sock, peer);
> +	if (IS_ERR(ovpn_sock)) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "cannot encapsulate socket: %ld",
> +				       PTR_ERR(ovpn_sock));
> +		sockfd_put(sock);
> +		return -ENOTSOCK;

goto peer_release

> +	}
> +
> +	peer->sock = ovpn_sock;
> +
> +	ret = ovpn_nl_peer_modify(peer, info, attrs);
> +	if (ret < 0)
> +		goto peer_release;
> +
> +	ret = ovpn_peer_add(ovpn, peer);
> +	if (ret < 0) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "cannot add new peer (id=%u) to hashtable: %d\n",
> +				       peer->id, ret);
> +		goto peer_release;
> +	}
> +
> +	return 0;
> +
> +peer_release:
> +	/* release right away because peer is not used in any context */
> +	ovpn_peer_release(peer);
> +
> +	return ret;
>  }


[...]
>  int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
> +	struct ovpn_priv *ovpn = info->user_ptr[0];
> +	struct ovpn_peer *peer;
> +	u32 peer_id;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
> +		return -EINVAL;
> +
> +	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
> +			       ovpn_peer_nl_policy, info->extack);
> +	if (ret)
> +		return ret;
> +
> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
> +			      OVPN_A_PEER_ID))
> +		return -EINVAL;
> +
> +	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
> +	peer = ovpn_peer_get_by_id(ovpn, peer_id);
> +	if (!peer) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "cannot find peer with id %u", peer_id);
> +		return -ENOENT;
> +	}
> +
> +	netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
> +	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);

With the delayed socket release (which is similar to what was in v11,
but now with refcounting on the netdevice which should make
rtnl_link_unregister in ovpn_cleanup wait [*]), we may return to
userspace as if the peer was gone, but the socket hasn't been detached
yet.

A userspace application that tries to remove the peer and immediately
re-create it with the same socket could get EBUSY if the workqueue
hasn't done its job yet. That would be quite confusing to the
application.

So I would add a completion to wait here until the socket has been
fully detached. Something like below.

[*] I don't think the current refcounting fully protects against that,
I'll comment on 05/25


-------- 8< --------

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 72357bb5f30b..19aa4ee6d468 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -733,6 +733,9 @@ int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
 
 	netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
 	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
+	if (ret >= 0 && peer->sock)
+		wait_for_completion(&peer->sock_detach);
+
 	ovpn_peer_put(peer);
 
 	return ret;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index b032390047fe..6120521d0c32 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -92,6 +92,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
 	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
+	init_completion(&peer->sock_detach);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 7a062cc5a5a4..8c54bf5709ef 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -112,6 +112,7 @@ struct ovpn_peer {
 	struct rcu_head rcu;
 	struct work_struct remove_work;
 	struct work_struct keepalive_work;
+	struct completion sock_detach;
 };
 
 /**
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
index a5c3bc834a35..7cefac42c3be 100644
--- a/drivers/net/ovpn/socket.c
+++ b/drivers/net/ovpn/socket.c
@@ -31,6 +31,8 @@ static void ovpn_socket_release_kref(struct kref *kref)
 
 	sockfd_put(sock->sock);
 	kfree_rcu(sock, rcu);
+
+	complete(&sock->peer->sock_detach);
 }
 
 /**
@@ -181,12 +183,12 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
 
 	ovpn_sock->sock = sock;
 	kref_init(&ovpn_sock->refcount);
+	ovpn_sock->peer = peer;
 
 	/* TCP sockets are per-peer, therefore they are linked to their unique
 	 * peer
 	 */
 	if (sock->sk->sk_protocol == IPPROTO_TCP) {
-		ovpn_sock->peer = peer;
 		ovpn_peer_hold(peer);
 	} else if (sock->sk->sk_protocol == IPPROTO_UDP) {
 		/* in UDP we only link the ovpn instance since the socket is
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
index 15827e347f53..3f5a35fd9048 100644
--- a/drivers/net/ovpn/socket.h
+++ b/drivers/net/ovpn/socket.h
@@ -28,12 +28,12 @@ struct ovpn_peer;
  * @rcu: member used to schedule RCU destructor callback
  */
 struct ovpn_socket {
+	struct ovpn_peer *peer;
 	union {
 		struct {
 			struct ovpn_priv *ovpn;
 			netdevice_tracker dev_tracker;
 		};
-		struct ovpn_peer *peer;
 	};
 
 	struct socket *sock;


-- 
Sabrina

