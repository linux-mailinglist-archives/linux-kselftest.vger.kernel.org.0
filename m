Return-Path: <linux-kselftest+bounces-24760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44AA163CE
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Jan 2025 21:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B13A59E3
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Jan 2025 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3B91DF989;
	Sun, 19 Jan 2025 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="V+6xcOog"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B51A2846
	for <linux-kselftest@vger.kernel.org>; Sun, 19 Jan 2025 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737317155; cv=none; b=Tyjbm1jbhw5iSouUi2HjN5GSMYyWN4RAxUtRPfb5IWpmDNqPHOSDsdRDvKmUbSHr4v+vwryndDEWgAKIe7ySHjdY/6A8I7lyBtElz1go4xGkuv+DWl1XlRAhhJ2HoOaP/sLw6/tP7m26YQ0XtoOsxz5qUMLm/UoAxFo/RCmDp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737317155; c=relaxed/simple;
	bh=AOBelxNrqjJU0VR1awbtqU5riS/YrarayQKVIKo9o/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXqjknbJtxAIETcN4eEhG7E5MX53bUfD9C8QwVd1DoB4qPOGUqqluUz5Lk+zSy3QyY0Dvd1NY97tMyJNCS4ZAP5TtNlGYxg+bAH9xA++Xp1CquHbDTQYy2Exs6K4Jue1lBfOBB239IK9+wbhyKBkAotIi75aJez458PeQBDHLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=V+6xcOog; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa679ad4265so957849466b.0
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Jan 2025 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737317152; x=1737921952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yV4ypHv5dd1/vtw9wcV8OTRsLUlUS8P/pDeMYfSHOK4=;
        b=V+6xcOogZDp7D6CLt1SbmlgzClTwp05a/6bO5cxcDQlXjgbqXc1I7awUVRX8AFW/l3
         /k93jCOPniL6NbVyFny6qGouz6UYVtJmYOJTJ7AcBqlCRW2CpIGuZU8elA181R03aWjq
         ZadWGTwZ6jP+FtG/wJsSyWNfQ9M3fMk+QQLzfeBv/ceNovi+HnSDXPUum6mh2ZPWSMH+
         3gSMCv+SjCFpURI6TTtALbo0PJYf985h+Ne7szXFADo3wjHAwQhT6d0v60mfISGCXzZL
         bk5P871sHHPeR4LiuJ1qfS9RHfABtrsYWVeNDy8Qih+4XYfc59vxW9oNWkfN+GXnlRJp
         n7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737317152; x=1737921952;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yV4ypHv5dd1/vtw9wcV8OTRsLUlUS8P/pDeMYfSHOK4=;
        b=VhJLRQjjHpnAB8UfpRg/qrCi8d9bt2HcSLyh3vEdjWZ103O27efVS5MckZbrraPIms
         i/2dT7YD1nIdg6GhloAbFCQoGDsBpFYudWfD6bbHAZg3AnoAVQGOXvRnAwm3XaumlGYT
         BwJFyxfIBV9XU19rVsETsXt+0bOsLXCEin6+QZJ/d79+hGG+RDj0cM7/s0HayDxYzyMw
         nw8mV2UHG+yNztqswrLIoqDMIkEf2jqHxPMcDV/Gxoo4fQTaWipzpjSjiBwbxv6UoiHh
         w0RTyJbNPrkiNV+Pg+kVr+b4QnVcQ4J0LHaEFPwpy7ipw8sqIqSxNgEQyPhb5TLaCbBC
         JPMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhj1pDB4JU4Bx8ZU80GBO4qD57n0WsOfr6iES2oAgmsD4xj9zu1aXZ7zUKTpfxRuxzLZJ9NlR8RQG4IKP96eU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjb3FdnU07J0rvst7NgHj2ASLvsbyfv7PfzWqc4HHCAjhe5GRn
	9NnCvs6q21eSUSDMa4KfHgY3sxA2WGG7UDDh4T3pTA6vd7XK7YRx4lkowjAadf3ZDgIWp/aEjmL
	+
X-Gm-Gg: ASbGncumuPr4qwK6HMCAu/RxDhn4bpzCrhS5Y//p0eJeH1q3q7K7tocBj0/JSJqIULY
	Ot1S5n8s6AlXpvooWpLGWACrcXudRGNxGBmcLt2Wjj+ha446oe5MbgfRSGJD0FPdyViOycy7eR7
	IbNypJ74zwKO1OF5v6ERWOrCktllRLHGgS21x1WDsOBFHX3t+ZjMKhVbWQQ8LiWAXQews7aGQQ3
	JUr3Z/I4BUFxKyCgQqbFvxWFvfxkumtgisAfyM0lqD1oVmpaXOeI6u8JWSCZEHsDjX3ubiBfjXu
	9xqIlRqomTQXNgQIWnxL83zm0XItwa5g
X-Google-Smtp-Source: AGHT+IFeoZAa4GLe4bA6QmHaEdN5Y+fR//FPt2afwLiomRetJ8oJ61PCbHRz6pj79NeJhUI68fju6w==
X-Received: by 2002:a17:907:743:b0:aa6:7ff9:d248 with SMTP id a640c23a62f3a-ab36e242063mr1316645966b.8.1737317151574;
        Sun, 19 Jan 2025 12:05:51 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:113d:ece6:3d2f:3a40? ([2001:67c:2fbc:1:113d:ece6:3d2f:3a40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2e519sm524119266b.83.2025.01.19.12.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 12:05:51 -0800 (PST)
Message-ID: <6e51a8ad-dee1-45ef-ab8e-b5d73c1acd40@openvpn.net>
Date: Sun, 19 Jan 2025 21:06:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 12/25] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-12-1f00db9c2bd6@openvpn.net> <Z4qP-x4F-lQiQTRy@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z4qP-x4F-lQiQTRy@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2025 18:14, Sabrina Dubroca wrote:
> 2025-01-13, 10:31:31 +0100, Antonio Quartulli wrote:
>> +static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>> +			    int flags, int *addr_len)
>> +{
>> +	int err = 0, off, copied = 0, ret;
>> +	struct ovpn_socket *sock;
>> +	struct ovpn_peer *peer;
>> +	struct sk_buff *skb;
>> +
>> +	rcu_read_lock();
>> +	sock = rcu_dereference_sk_user_data(sk);
>> +	if (!sock || !sock->peer) {
>> +		rcu_read_unlock();
>> +		return -EBADF;
>> +	}
>> +	/* we take a reference to the peer linked to this TCP socket, because
>> +	 * in turn the peer holds a reference to the socket itself.
> 
> Not anymore since v12? [*]
> 
> I think it's ok here because we're only using peer and sk (not
> anything from ovpn_socket), but it is relevant in _sendmsg, which has
> the same peer_hold pattern without this comment.
> 
> [*]
> v11:
>   - https://lore.kernel.org/netdev/20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net/
>     ovpn_peer_release -> ovpn_socket_put
> 
> v12:
>   - https://lore.kernel.org/netdev/20241202-b4-ovpn-v12-9-239ff733bf97@openvpn.net/
>     ovpn_peer_release doesn't do ovpn_socket_put
> 
>   - https://lore.kernel.org/netdev/20241202-b4-ovpn-v12-7-239ff733bf97@openvpn.net/
>     ovpn_socket_put is done directly at ovpn_peer_remove time, before the final peer_put
> 
>> +	 * By doing so we also ensure that the peer stays alive along with
>> +	 * the socket while executing this function
>> +	 */
>> +	ovpn_peer_hold(sock->peer);
>> +	peer = sock->peer;
>> +	rcu_read_unlock();
>> +
>> +	skb = __skb_recv_datagram(sk, &peer->tcp.user_queue, flags, &off, &err);
>> +	if (!skb) {
>> +		if (err == -EAGAIN && sk->sk_shutdown & RCV_SHUTDOWN) {
>> +			ret = 0;
>> +			goto out;
>> +		}
>> +		ret = err;
>> +		goto out;
>> +	}
>> +
>> +	copied = len;
>> +	if (copied > skb->len)
>> +		copied = skb->len;
>> +	else if (copied < skb->len)
>> +		msg->msg_flags |= MSG_TRUNC;
>> +
>> +	err = skb_copy_datagram_msg(skb, 0, msg, copied);
>> +	if (unlikely(err)) {
>> +		kfree_skb(skb);
>> +		ret = err;
>> +		goto out;
>> +	}
>> +
>> +	if (flags & MSG_TRUNC)
>> +		copied = skb->len;
>> +	kfree_skb(skb);
>> +	ret = copied;
>> +out:
>> +	ovpn_peer_put(peer);
>> +	return ret;
>> +}
> 
> [...]
>> +static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>> +{
>> +	struct ovpn_socket *sock;
>> +	int ret, linear = PAGE_SIZE;
>> +	struct ovpn_peer *peer;
>> +	struct sk_buff *skb;
>> +
>> +	rcu_read_lock();
>> +	sock = rcu_dereference_sk_user_data(sk);
>> +	if (unlikely(!sock || !sock->peer || !ovpn_peer_hold(sock->peer))) {
>> +		rcu_read_unlock();
>> +		return -EIO;
>> +	}
>> +	peer = sock->peer;
>> +	rcu_read_unlock();
>> +
>> +	lock_sock(peer->sock->sock->sk);
> 
> Isn't that just sk?

Right - it's the same object at this point. I'll use sk.

> 
>> +
>> +	if (msg->msg_flags & ~MSG_DONTWAIT) {
>> +		ret = -EOPNOTSUPP;
>> +		goto peer_free;
>> +	}
>> +
>> +	if (peer->tcp.out_msg.skb) {
>> +		ret = -EAGAIN;
>> +		goto peer_free;
>> +	}
>> +
>> +	if (size < linear)
>> +		linear = size;
>> +
>> +	skb = sock_alloc_send_pskb(sk, linear, size - linear,
>> +				   msg->msg_flags & MSG_DONTWAIT, &ret, 0);
>> +	if (!skb) {
>> +		net_err_ratelimited("%s: skb alloc failed: %d\n",
>> +				    netdev_name(sock->peer->ovpn->dev), ret);
> 
> Since we only have a ref on peer (but not on sock), I'd use
> peer->... directly instead of sock->peer.

ACK

> 
>> +		goto peer_free;
>> +	}
>> +
>> +	skb_put(skb, linear);
>> +	skb->len = size;
>> +	skb->data_len = size - linear;
>> +
>> +	ret = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
>> +	if (ret) {
>> +		kfree_skb(skb);
>> +		net_err_ratelimited("%s: skb copy from iter failed: %d\n",
>> +				    netdev_name(sock->peer->ovpn->dev), ret);
> 
> s/sock->//

ACK

> 
>> +		goto peer_free;
>> +	}
>> +
>> +	ovpn_tcp_send_sock_skb(sock->peer, skb);
> 
> s/sock->//

ACK

> 
>> +	ret = size;
>> +peer_free:
>> +	release_sock(peer->sock->sock->sk);
>> +	ovpn_peer_put(peer);
>> +	return ret;
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


