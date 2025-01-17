Return-Path: <linux-kselftest+bounces-24723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97CFA14FC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 13:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05462164FD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A811FFC4C;
	Fri, 17 Jan 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Y4VFKyV6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA81FF1A0
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118728; cv=none; b=icwWtIaBbDIO1VK2TgExsVK5q7DysqYv+LBzUJXdhqwBbHDIHQN289VMgJ+hHiYqh+sfW0AHaLXHFNw6BrCHhmwn21XXdASJ8xMptGRSt+lEK+7TeUIcaEuRFSsqnX9CxIM9KdQ/wDgY56TVTusVQ9m6+GdwGE/raywNsyjPMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118728; c=relaxed/simple;
	bh=WJugkzorubRkma9VgNw+lf8jh9y83GLfI7FmMgDhjkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNY3rEZZ80HrlRFY7yEE9aSCtCC+FmF//46trJBuHeSQ3ZAXja5bw0F5hX1ZqJTRVs3c6t3rkZEZRaORcNh7aIviuFdjYtJRcFrsUyyzFDzYGnl4lapm43bE+X97VFSC+YxXwCImbc4Ptgwd6Z+4GG44ihH1ZNX48N2m2A4UhU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Y4VFKyV6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361f664af5so22270145e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737118722; x=1737723522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jVGvVTJNwvC4Wpg7WxydswxWPnAeM3iFiQjVV/l2OB4=;
        b=Y4VFKyV6zoIbZsmjzHn+rKNKQVXeS1zI9oYde4UiLHkd58SigS/yOhXcC1P5FM9cxQ
         UR9Fk4c0xkLvL7TXWayNrb7RFvEFm8wCgP5LOx+j6AmklJUaJJBKBjOB84GifZmbozmK
         YG5eOfLSIGNDFyTI75tlwWeVPvWz4HQ6lFAdGwuIYpOXz4UahMKJIeLktv3M24CwqC7v
         6dQRs9Qax/vQDwHWYi3dDg29k92Bj9h7eZQh3i91WbgsZ9LAPl//unasyUyaOuuIKAOK
         BjPFOPaahxkXz6k8/0h8b3bKW2BNx5q9EdMyrPhgDBcPP07JpY90aE0xEAHotMHzEnd9
         Mn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118722; x=1737723522;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVGvVTJNwvC4Wpg7WxydswxWPnAeM3iFiQjVV/l2OB4=;
        b=dt5hnraZPBuOhdWybUSDurWHtTPHkdpLXemGZakHOH/8xD5LjGrlYa9xpZvvK08N4p
         9VTJAWDkPvCQvNWhlCpALLES32MNylYqo0UFPGfRFMeXOz4X9A4IVONm62tOruQf4Xh+
         CkTsz5tB2hsEKSERfW0m/Mw8pQ7kLSPeTx/fLqbxQmem71AohWG2ZGTH0mqSf4fRRPoB
         cxSKPFqpSqJ0WnbwrZ8c3bHdNsSrNmeNxoFNPRmhUn4olKuIeoEF245ARdXYL7VoIDcM
         05ypsAWMzi4PLbN/03/UMiTYy2WYj6HHEPbhhZcdkDMIoyQfGe5VjRiRY6JOff+SMprt
         Azug==
X-Forwarded-Encrypted: i=1; AJvYcCXElV6/ZvXWgRFJMTSn+R5TCoKNVVXZUou0+PD+cmRmjbC5wQbuszwHbyUwDvlsb5n4DS/cpuqdCKc6Zu+nrx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyko/NT5eOmmAjGryyhmH82g44SUaV7SYaPMFNN5IPlL4mMNge+
	7VfefvlIlJEnzTG95xDDVv2GG7Nd0RoY9cxkV6FDJ+9jrdsGn9farkxNw9cUCPs=
X-Gm-Gg: ASbGncuzTxdp3AXhK9ghUuFNCrlBBL5FPleWmClZeTT5vzIm1dElz7iAJYDQl4rWHo6
	WsFWEJPU6cb2/FGe05zsvkmApNkugvyTDKaNiIhW1OB8bWK/3emRCEq9Thm4+5kPhOo50aY/57b
	NXVl0OzUlTj9QjCbTgxaYbpGMbTi6g7LxmF8R9RfCn8lq9Xw4Khjig1pVu7qGregt8rJwMFVifH
	/LJ7BV+j+Vi9+H6EoIzFLlKHwyAsrndElWxxbbHmY/Ph2JqqMcOLz1nW3WrrOR01DgDbWHvo3JD
	SmBT3C9gtO1xVvBQkH4=
X-Google-Smtp-Source: AGHT+IED/P2oAxgUrWyPlsOU/pWmjBVzZTUOb3aunt+NEjZDT/VbT/tHwb6JPD4UAKdV9XehnLFC6w==
X-Received: by 2002:a5d:648a:0:b0:385:f349:fffb with SMTP id ffacd0b85a97d-38bf57bfba2mr2446533f8f.45.1737118722445;
        Fri, 17 Jan 2025 04:58:42 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:217f:1ce8:9888:d2ed? ([2001:67c:2fbc:1:217f:1ce8:9888:d2ed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3215482sm2444717f8f.5.2025.01.17.04.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 04:58:42 -0800 (PST)
Message-ID: <f5507529-e61c-4b81-ab93-4ea6c8df46e9@openvpn.net>
Date: Fri, 17 Jan 2025 13:59:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>, ryazanov.s.a@gmail.com
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net> <Z4pDpqN2hCc-7DGt@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z4pDpqN2hCc-7DGt@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2025 12:48, Sabrina Dubroca wrote:
> 2025-01-13, 10:31:39 +0100, Antonio Quartulli wrote:
>>   int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
>> +	struct ovpn_priv *ovpn = info->user_ptr[0];
>> +	struct ovpn_socket *ovpn_sock;
>> +	struct socket *sock = NULL;
>> +	struct ovpn_peer *peer;
>> +	u32 sockfd, peer_id;
>> +	int ret;
>> +
>> +	/* peers can only be added when the interface is up and running */
>> +	if (!netif_running(ovpn->dev))
>> +		return -ENETDOWN;
> 
> Since we're not under rtnl_lock here, the device could go down while
> we're creating this peer, and we may end up with a down device that
> has a peer anyway.

hmm, indeed. This means we must hold the rtnl_lock to prevent ending up 
in an inconsistent state.

> 
> I'm not sure what this (and the peer flushing on NETDEV_DOWN) is
> trying to accomplish. Is it a problem to keep peers when the netdevice
> is down?

This is the result of my discussion with Sergey that started in v23 5/23:

https://lore.kernel.org/r/netdev/20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net/

The idea was to match operational state with actual connectivity to peer(s).

Originally I wanted to simply kee the carrier always on, but after 
further discussion (including the meaning of the openvpn option 
--persist-tun) we agreed on following the logic where an UP device has a 
peer connected (logic is slightly different between MP and P2P).

I am not extremely happy with the resulting complexity, but it seemed to 
be blocker for Sergey.

> 
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
>> +		return -EINVAL;
>> +
>> +	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
>> +			       ovpn_peer_nl_policy, info->extack);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ovpn_nl_peer_precheck(ovpn, info, attrs);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
>> +			      OVPN_A_PEER_SOCKET))
>> +		return -EINVAL;
>> +
>> +	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
>> +	peer = ovpn_peer_new(ovpn, peer_id);
>> +	if (IS_ERR(peer)) {
>> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +				       "cannot create new peer object for peer %u: %ld",
>> +				       peer_id, PTR_ERR(peer));
>> +		return PTR_ERR(peer);
>> +	}
>> +
>> +	/* lookup the fd in the kernel table and extract the socket object */
>> +	sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
>> +	/* sockfd_lookup() increases sock's refcounter */
>> +	sock = sockfd_lookup(sockfd, &ret);
>> +	if (!sock) {
>> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +				       "cannot lookup peer socket (fd=%u): %d",
>> +				       sockfd, ret);
>> +		return -ENOTSOCK;
> 
> All those returns should be "goto peer_release" (and setting ret) so
> that we don't leak peer.

indeed
> 
>> +	}
>> +
>> +	/* Only when using UDP as transport protocol the remote endpoint
>> +	 * can be configured so that ovpn knows where to send packets to.
>> +	 *
>> +	 * In case of TCP, the socket is connected to the peer and ovpn
>> +	 * will just send bytes over it, without the need to specify a
>> +	 * destination.
>> +	 */
>> +	if (sock->sk->sk_protocol != IPPROTO_UDP &&
>> +	    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
>> +	     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
>> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +				       "unexpected remote IP address for non UDP socket");
>> +		sockfd_put(sock);
>> +		return -EINVAL;
> 
> goto peer_release
> 
>> +	}
>> +
>> +	ovpn_sock = ovpn_socket_new(sock, peer);
>> +	if (IS_ERR(ovpn_sock)) {
>> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +				       "cannot encapsulate socket: %ld",
>> +				       PTR_ERR(ovpn_sock));
>> +		sockfd_put(sock);
>> +		return -ENOTSOCK;
> 
> goto peer_release
> 
>> +	}
>> +
>> +	peer->sock = ovpn_sock;
>> +
>> +	ret = ovpn_nl_peer_modify(peer, info, attrs);
>> +	if (ret < 0)
>> +		goto peer_release;
>> +
>> +	ret = ovpn_peer_add(ovpn, peer);
>> +	if (ret < 0) {
>> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +				       "cannot add new peer (id=%u) to hashtable: %d\n",
>> +				       peer->id, ret);
>> +		goto peer_release;
>> +	}
>> +
>> +	return 0;
>> +
>> +peer_release:
>> +	/* release right away because peer is not used in any context */
>> +	ovpn_peer_release(peer);
>> +
>> +	return ret;
>>   }
> 
> 
> [...]
>>   int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
>> +	struct ovpn_priv *ovpn = info->user_ptr[0];
>> +	struct ovpn_peer *peer;
>> +	u32 peer_id;
>> +	int ret;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
>> +		return -EINVAL;
>> +
>> +	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
>> +			       ovpn_peer_nl_policy, info->extack);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
>> +			      OVPN_A_PEER_ID))
>> +		return -EINVAL;
>> +
>> +	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
>> +	peer = ovpn_peer_get_by_id(ovpn, peer_id);
>> +	if (!peer) {
>> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +				       "cannot find peer with id %u", peer_id);
>> +		return -ENOENT;
>> +	}
>> +
>> +	netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
>> +	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
> 
> With the delayed socket release (which is similar to what was in v11,
> but now with refcounting on the netdevice which should make
> rtnl_link_unregister in ovpn_cleanup wait [*]), we may return to
> userspace as if the peer was gone, but the socket hasn't been detached
> yet.
> 
> A userspace application that tries to remove the peer and immediately
> re-create it with the same socket could get EBUSY if the workqueue
> hasn't done its job yet. That would be quite confusing to the
> application.

This may happen only for TCP, because in the UDP case we would increase 
the refcounter and keep the socket attached.

However, re-attaching the same TCP socket is hardly going to happen (in 
TCP we have one socket per peer, therefore if the peer is going away, 
we're most likely killing the socket too).

This said, the complexity added by the completion seems quite tiny, 
therefore I'll add the code you are suggesting below.


> 
> So I would add a completion to wait here until the socket has been
> fully detached. Something like below.
> 
> [*] I don't think the current refcounting fully protects against that,
> I'll comment on 05/25

ok!

> 
> 
> -------- 8< --------
> 
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 72357bb5f30b..19aa4ee6d468 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -733,6 +733,9 @@ int ovpn_nl_peer_del_doit(struct sk_buff *skb, struct genl_info *info)
>   
>   	netdev_dbg(ovpn->dev, "del peer %u\n", peer->id);
>   	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
> +	if (ret >= 0 && peer->sock)
> +		wait_for_completion(&peer->sock_detach);
> +
>   	ovpn_peer_put(peer);
>   
>   	return ret;
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index b032390047fe..6120521d0c32 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -92,6 +92,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
>   	ovpn_peer_stats_init(&peer->vpn_stats);
>   	ovpn_peer_stats_init(&peer->link_stats);
>   	INIT_WORK(&peer->keepalive_work, ovpn_peer_keepalive_send);
> +	init_completion(&peer->sock_detach);
>   
>   	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
>   	if (ret < 0) {
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index 7a062cc5a5a4..8c54bf5709ef 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -112,6 +112,7 @@ struct ovpn_peer {
>   	struct rcu_head rcu;
>   	struct work_struct remove_work;
>   	struct work_struct keepalive_work;
> +	struct completion sock_detach;
>   };
>   
>   /**
> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> index a5c3bc834a35..7cefac42c3be 100644
> --- a/drivers/net/ovpn/socket.c
> +++ b/drivers/net/ovpn/socket.c
> @@ -31,6 +31,8 @@ static void ovpn_socket_release_kref(struct kref *kref)
>   
>   	sockfd_put(sock->sock);
>   	kfree_rcu(sock, rcu);
> +
> +	complete(&sock->peer->sock_detach);
>   }
>   
>   /**
> @@ -181,12 +183,12 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>   
>   	ovpn_sock->sock = sock;
>   	kref_init(&ovpn_sock->refcount);
> +	ovpn_sock->peer = peer;
>   
>   	/* TCP sockets are per-peer, therefore they are linked to their unique
>   	 * peer
>   	 */
>   	if (sock->sk->sk_protocol == IPPROTO_TCP) {
> -		ovpn_sock->peer = peer;
>   		ovpn_peer_hold(peer);
>   	} else if (sock->sk->sk_protocol == IPPROTO_UDP) {
>   		/* in UDP we only link the ovpn instance since the socket is
> diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
> index 15827e347f53..3f5a35fd9048 100644
> --- a/drivers/net/ovpn/socket.h
> +++ b/drivers/net/ovpn/socket.h
> @@ -28,12 +28,12 @@ struct ovpn_peer;
>    * @rcu: member used to schedule RCU destructor callback
>    */
>   struct ovpn_socket {
> +	struct ovpn_peer *peer;
>   	union {
>   		struct {
>   			struct ovpn_priv *ovpn;
>   			netdevice_tracker dev_tracker;
>   		};
> -		struct ovpn_peer *peer;
>   	};
>   
>   	struct socket *sock;
> 
> 

Thanks! will add this.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


