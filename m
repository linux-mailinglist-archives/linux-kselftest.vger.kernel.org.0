Return-Path: <linux-kselftest+bounces-22821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B67F9E38A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 12:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EDC4B3CD15
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82791B3948;
	Wed,  4 Dec 2024 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DHcbSxTn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97E1B0F2D
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310882; cv=none; b=M2AmuFoiwIz5QMUDfydc8bDMxM8DhQ4MgWxRpU4n6FxLCcpr+gOzVXi5iU/tmVnPneY5B0GCqst1B6mksXWEj5YWIfo+XhFP8bTZ7RIGaqez+9odagq/15HdgVB+EQrLJYApUhp3a+M+tda03qyZQVT5ATpDEGlFBsv1C3lzUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310882; c=relaxed/simple;
	bh=9OLhs2SzV/pCzSUkig7J9m6Sox+2hEhjUdbeM9Ztw2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZOI/TlVDlNXNGC1stCpJ8Ua0VukwIOvm3DowYIx+a5YONPPP55CJjBi1MIBY2ur9lCdn22M3XXFF8Fl0Ty0jMwXaUKB0C8hrh5Zf3525EaJQ7xBsuUH7NoitZ7sGxRLQIDsvAd3smI+HJJVfMAfIKFVK1QB+YH0GCzpEaaqh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DHcbSxTn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53de92be287so10080014e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 03:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733310878; x=1733915678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ez2v/hFK48GJBwcBEU6ORn4LsLhEflZ+7+C1VR4AmbE=;
        b=DHcbSxTnRWfR74T4K+DSrnKQ7X3Hjtu/9vMoVGk4rnI7NHF998POYiEQ7STuaA4s5l
         2ibeeBBOt+V2FugFDxAWgQha0LyCHc81OYFBSax3m2c7rn8ji/j43j3/Pj0q53UMA8jC
         VqqfYygguOKMyGvD38rPsL6dRCObZC8gboFfc+sRmuJxIwYh2p03oqO5Ln8GsCvSDIcv
         s58AgVfPIrtVhW1z1O0tLahpqGjqmOPSQWzDEizSQbn/7WDjtmSz4pmOAwB+uocaPVXt
         Hb7RqcVfbD6Nr6wvKh+XLAN60zhvWjmAPt6NxvWIPCYgfUv+mZCe4xhRSz+n96CYVgn0
         X64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310878; x=1733915678;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez2v/hFK48GJBwcBEU6ORn4LsLhEflZ+7+C1VR4AmbE=;
        b=XaVU2Xj/lPPGK6RL58y3gB9/2OYas/sEBI/i3v9aDXxSJX5NejM39Evb0doUYWoMpe
         qHeZVIWkZviav9Bwge+O0JrKfg26kzWLcdnhEG1I3FfDA9UkAZx6ZcvOw6/dlArnSTXb
         FGWrlOTnPe6gu9GMnrKIvQl+ncRzBEmug5qXeKpP/DSAvMn0NbTfmriXzV8VRR6tlq/x
         6wOJYxrpO4OKcA4z88saSYt5wdjSNgowCnKb6VXKTvYlXVF/uwewkiwFqdb588Uu7zvM
         3xMQoKNoVEw9oOeJwzq1ohjP3o658L4MVgpxbD8VakkGzxRc8GHxnwiI5fs9g08w1sHQ
         d7+A==
X-Forwarded-Encrypted: i=1; AJvYcCU8dNlZ6DT6LZuq9c50fSvznw0jrlwqXr0MzSVzlvPIsB9/zIHCSSoyFbvGrNIWn+micBlHFPlkHIzaPUzkIo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiv9tx6a31yP6YXSw30wT1tvP15zwks3bOIcxcL2tlvENUyBKs
	Cljz+uZ8L1/Cs8jXt/9yF/rGzIU0+hVQrbpFTb8dLdAlMokqL8tNlHKlvcvWrro=
X-Gm-Gg: ASbGncvkhqVdIgiwXqjhKh0yPxsOD5xDKUzcW4m7mWSnwKZApvSaG29smMxu1MLJvb2
	A1ZBy69IxzmPLJAUIUw7bFmehMA79ZLh7y4h7KkjxDEfrmlRl6VKuIN6iJQjTKS9X2PPDe4czan
	as8Vf1t7TkYfVAd6SKKHPFC5e9VtFlhIb3Qod8TLPGB3r3nIPxgYRM30YMI8pcptcKh79HOTcJp
	4jiIS1PnVAtrdB5Qyk6QZ3XwKcuiPsCJUqMcC9i01OdljZYQ2xLlLDYmh+s9cjLGb1l+QsVTZb1
	0u2Frv+x/ZNG
X-Google-Smtp-Source: AGHT+IHjWaqG1rXyWFR8Wi2Ha3hd2f8CVysn1B6oBnd2IW0Yh1Bn5HcpN52v67q0BsPdR2Y8WU7QnA==
X-Received: by 2002:a05:6512:3e06:b0:53d:d3cb:d90b with SMTP id 2adb3069b0e04-53e12a38999mr5628954e87.47.1733310878264;
        Wed, 04 Dec 2024 03:14:38 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:85f4:5278:b2f6:64fb? ([2001:67c:2fbc:1:85f4:5278:b2f6:64fb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c192fsm730780566b.27.2024.12.04.03.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 03:14:37 -0800 (PST)
Message-ID: <2a1b614c-c52d-44c7-8cb8-c68a8864508d@openvpn.net>
Date: Wed, 4 Dec 2024 12:15:16 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 11/22] ovpn: implement TCP transport
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-11-239ff733bf97@openvpn.net>
 <784fddc4-336c-4674-8277-c7cebea6b94f@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <784fddc4-336c-4674-8277-c7cebea6b94f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 16:19, Paolo Abeni wrote:
> On 12/2/24 16:07, Antonio Quartulli wrote:
>> +void ovpn_tcp_socket_detach(struct socket *sock)
>> +{
>> +	struct ovpn_socket *ovpn_sock;
>> +	struct ovpn_peer *peer;
>> +
>> +	if (!sock)
>> +		return;
>> +
>> +	rcu_read_lock();
>> +	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
>> +
>> +	if (!ovpn_sock->peer) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +
>> +	peer = ovpn_sock->peer;
>> +	strp_stop(&peer->tcp.strp);
>> +
>> +	skb_queue_purge(&peer->tcp.user_queue);
>> +
>> +	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
>> +	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
>> +	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
>> +	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
>> +	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
>> +	/* drop reference to peer */
>> +	rcu_assign_sk_user_data(sock->sk, NULL);
>> +
>> +	rcu_read_unlock();
>> +
>> +	barrier();
> 
> It's unclear to me the role of the above barrier. A comment would help

Unless I misinterpreted Sabrina's previous comment, the barrier() is 
needed to prevent reordering and therefore ensure that the assumption 
described in the comment below is true.

I can re-arrange the comment to make it clear that the barrier() is 
serving this specific purpose.

> 
>> +	/* cancel any ongoing work. Done after removing the CBs so that these
>> +	 * workers cannot be re-armed
>> +	 */
>> +	cancel_work_sync(&peer->tcp.tx_work);
>> +	strp_done(&peer->tcp.strp);
>> +	skb_queue_purge(&peer->tcp.out_queue);
>> +
>> +	ovpn_peer_put(peer);
>> +}
>> +
>> +static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
>> +{
>> +	struct sk_buff *skb = peer->tcp.out_msg.skb;
>> +
>> +	if (!skb)
>> +		return;
>> +
>> +	if (peer->tcp.tx_in_progress)
>> +		return;
>> +
>> +	peer->tcp.tx_in_progress = true;
>> +
>> +	do {
>> +		int ret = skb_send_sock_locked(peer->sock->sock->sk, skb,
>> +					       peer->tcp.out_msg.offset,
>> +					       peer->tcp.out_msg.len);
>> +		if (unlikely(ret < 0)) {
>> +			if (ret == -EAGAIN)
>> +				goto out;
>> +
>> +			net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
>> +					     netdev_name(peer->ovpn->dev),
>> +					     peer->id, ret);
>> +
>> +			/* in case of TCP error we can't recover the VPN
>> +			 * stream therefore we abort the connection
>> +			 */
>> +			ovpn_peer_del(peer,
>> +				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
>> +			break;
>> +		}
>> +
>> +		peer->tcp.out_msg.len -= ret;
>> +		peer->tcp.out_msg.offset += ret;
>> +	} while (peer->tcp.out_msg.len > 0);
>> +
>> +	if (!peer->tcp.out_msg.len)
>> +		dev_sw_netstats_tx_add(peer->ovpn->dev, 1, skb->len);
>> +
>> +	kfree_skb(peer->tcp.out_msg.skb);
>> +	peer->tcp.out_msg.skb = NULL;
>> +	peer->tcp.out_msg.len = 0;
>> +	peer->tcp.out_msg.offset = 0;
>> +
>> +out:
>> +	peer->tcp.tx_in_progress = false;
>> +}
>> +
>> +static void ovpn_tcp_tx_work(struct work_struct *work)
>> +{
>> +	struct ovpn_peer *peer;
>> +
>> +	peer = container_of(work, struct ovpn_peer, tcp.tx_work);
>> +
>> +	lock_sock(peer->sock->sock->sk);
>> +	ovpn_tcp_send_sock(peer);
>> +	release_sock(peer->sock->sock->sk);
>> +}
>> +
>> +static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	if (peer->tcp.out_msg.skb)
>> +		ovpn_tcp_send_sock(peer);
>> +
>> +	if (peer->tcp.out_msg.skb) {
>> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
>> +		kfree_skb(skb);
>> +		return;
>> +	}
>> +
>> +	peer->tcp.out_msg.skb = skb;
>> +	peer->tcp.out_msg.len = skb->len;
>> +	peer->tcp.out_msg.offset = 0;
>> +	ovpn_tcp_send_sock(peer);
>> +}
>> +
>> +void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	u16 len = skb->len;
>> +
>> +	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
>> +
>> +	bh_lock_sock(peer->sock->sock->sk);
> 
> Are you sure this runs in BH context? AFAICS we reach here from an AEAD
> callback.

It could be from the AEAD callback (crypto async case), but it may also 
be directly from the packet RX path (crypto sync case).

If I am not wrong, in the latter case we are in BH context.

> 
> 
> 
>> +	if (sock_owned_by_user(peer->sock->sock->sk)) {
>> +		if (skb_queue_len(&peer->tcp.out_queue) >=
>> +		    READ_ONCE(net_hotdata.max_backlog)) {
>> +			dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
>> +			kfree_skb(skb);
>> +			goto unlock;
>> +		}
>> +		__skb_queue_tail(&peer->tcp.out_queue, skb);
>> +	} else {
>> +		ovpn_tcp_send_sock_skb(peer, skb);
>> +	}
>> +unlock:
>> +	bh_unlock_sock(peer->sock->sock->sk);
>> +}
> 
> [...]
> 
>> +static void ovpn_tcp_build_protos(struct proto *new_prot,
>> +				  struct proto_ops *new_ops,
>> +				  const struct proto *orig_prot,
>> +				  const struct proto_ops *orig_ops);
>> +
>> +/* Set TCP encapsulation callbacks */
>> +int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
>> +{
>> +	struct strp_callbacks cb = {
>> +		.rcv_msg = ovpn_tcp_rcv,
>> +		.parse_msg = ovpn_tcp_parse,
>> +	};
>> +	int ret;
>> +
>> +	/* make sure no pre-existing encapsulation handler exists */
>> +	if (sock->sk->sk_user_data)
>> +		return -EBUSY;
>> +
>> +	/* sanity check */
>> +	if (sock->sk->sk_protocol != IPPROTO_TCP) {
>> +		net_err_ratelimited("%s: provided socket is not TCP as expected\n",
>> +				    netdev_name(peer->ovpn->dev));
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* only a fully connected socket are expected. Connection should be
>> +	 * handled in userspace
>> +	 */
>> +	if (sock->sk->sk_state != TCP_ESTABLISHED) {
>> +		net_err_ratelimited("%s: provided TCP socket is not in ESTABLISHED state: %d\n",
>> +				    netdev_name(peer->ovpn->dev),
>> +				    sock->sk->sk_state);
>> +		return -EINVAL;
>> +	}
>> +
>> +	lock_sock(sock->sk);
>> +
>> +	ret = strp_init(&peer->tcp.strp, sock->sk, &cb);
>> +	if (ret < 0) {
>> +		DEBUG_NET_WARN_ON_ONCE(1);
>> +		release_sock(sock->sk);
>> +		return ret;
>> +	}
>> +
>> +	INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
>> +	__sk_dst_reset(sock->sk);
>> +	skb_queue_head_init(&peer->tcp.user_queue);
>> +	skb_queue_head_init(&peer->tcp.out_queue);
>> +
>> +	/* save current CBs so that they can be restored upon socket release */
>> +	peer->tcp.sk_cb.sk_data_ready = sock->sk->sk_data_ready;
>> +	peer->tcp.sk_cb.sk_write_space = sock->sk->sk_write_space;
>> +	peer->tcp.sk_cb.prot = sock->sk->sk_prot;
>> +	peer->tcp.sk_cb.ops = sock->sk->sk_socket->ops;
>> +
>> +	/* assign our static CBs and prot/ops */
>> +	sock->sk->sk_data_ready = ovpn_tcp_data_ready;
>> +	sock->sk->sk_write_space = ovpn_tcp_write_space;
>> +
>> +	if (sock->sk->sk_family == AF_INET) {
>> +		sock->sk->sk_prot = &ovpn_tcp_prot;
>> +		sock->sk->sk_socket->ops = &ovpn_tcp_ops;
>> +	} else {
>> +		mutex_lock(&tcp6_prot_mutex);
>> +		if (!ovpn_tcp6_prot.recvmsg)
>> +			ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops,
>> +					      sock->sk->sk_prot,
>> +					      sock->sk->sk_socket->ops);
>> +		mutex_unlock(&tcp6_prot_mutex);
> 
> This looks like an hack to avoid a build dependency on IPV6, I think the
> explicit

I happily copied this approach from espintcp.c:espintcp_init_sk() :-D

> 
> #if IS_ENABLED(CONFIG_IPV6)
> 
> at init time should be preferable

Ok, will try to take this other approach.

I also have the feeling that by going this way I can get rid of the 
checkpatch warning about proto_ops not being consts.

> 
>> +
>> +		sock->sk->sk_prot = &ovpn_tcp6_prot;
>> +		sock->sk->sk_socket->ops = &ovpn_tcp6_ops;
>> +	}
> 
> [...]
> 
>> +static void ovpn_tcp_close(struct sock *sk, long timeout)
>> +{
>> +	struct ovpn_socket *sock;
>> +
>> +	rcu_read_lock();
>> +	sock = rcu_dereference_sk_user_data(sk);
>> +
>> +	strp_stop(&sock->peer->tcp.strp);
>> +	barrier();
> 
> Again, is not clear to me the role of the above barrier, please document it.

Also taken from espintcp_close(), with the idea to avoid reordering 
during the shut down sequence.

Will add a comment here too.


Thanks a lot.

Regards,

> 
> Thanks,
> 
> Paolo
> 

-- 
Antonio Quartulli
OpenVPN Inc.


