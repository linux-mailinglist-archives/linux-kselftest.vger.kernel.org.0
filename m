Return-Path: <linux-kselftest+bounces-21868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 713909C5A50
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CF51F22676
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12971FDF9C;
	Tue, 12 Nov 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="X+2Bshfb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6A1FCF55
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421598; cv=none; b=ftPD1hP8FEe29ncxVb2FnVaxhwfA0KAXSIqgDdG43xjXQd7kq0xalmrTIbuPMSZZeLrTb7TD+X10BvyG7pcfZBtUV8Zwx8hwxrG6NCkDyJxO8wPViLIPayrtOPXcDWHq/QOp89pzVsUg6RN04jDOM6EfOa3Wq5Xpw58QxfP4zt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421598; c=relaxed/simple;
	bh=f/HvlfkCRjAxJ8giT2huqlXY/k/mQmI42ZzFf5vOQ2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtkcAruRKod1IW+LCjSoNvY7UKBgjk7kd8SRtqtbfVhhgyIxdYAbDpU4PKJe2UzXG1ZjR9lmuEkPvrW50OL3m4/551FkSUbL8HznXfhEyrM37XO6ACUACvqLT2igeyKaL3keJ2SuW08tcaT1Mw6eMqjy3DbHI3cVzFNICJbpBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=X+2Bshfb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a850270e2so1043921666b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731421595; x=1732026395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzu4T+vazNFIi2mWnC9HwDZlKX1lZlU/i0ViDpHIDS8=;
        b=X+2BshfbeyAga1n09nCKLt1iSa1qCPJa1thTHatNi8S36RufjsiykFk1PG2EHAS7H7
         e5Z65Bzffz/H9hCbgUHsGCRyd4KfZETUAkiIyRKqswsDoZMuZUyFFJe0CBkt2CwrLbCi
         kGrmX6QBI2kzZKurnRqSmOFC8xhwvtL7rvV5ZKsn7Bf5wukNl04PAlpDGZKnroU5ENq1
         0Xz7pdFOAtoOmixOcuR9+2e19GqzAJLCxuF3TfI7bsVmyzcf0+8qDtChqoZjUDKRJgSE
         lwnZe6nZ0tgKNRniinMYCyENhyGNZYbgYFsIaJE8xP6y50dw8NN5Q123JN0LCPxEpiKN
         +ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731421595; x=1732026395;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzu4T+vazNFIi2mWnC9HwDZlKX1lZlU/i0ViDpHIDS8=;
        b=RfBHNza8LEPu1KTnIpvUelllrxSwlUo3kZ6UIadsXUsF3WOoUAg+H1Fq7COZSE7VeR
         5UeSB4FHgF6iThHCT4PsGhITuPydxeCT17SK3IdG+/mhVGg2awA5yqmAA8NPs0zxd9MQ
         M79XYppNWQO5bPYartu4XEnZ2fdrVcfTArPBNiS/6K/pyPNqgCfQDaF12+iqdjDTmPiZ
         QhxpzwssAe/UdCyX5Xsu4MTOqnX3PHYydAOZf5hWWl341euevCNDBO8iBzQLd8bdO/g9
         UESUpAXdOczKlCe4I8xpeSU6JB4F/XxSKJa2wCUhyEfnRjtxYA99x4lB1+EcbPElhD8L
         HIYA==
X-Forwarded-Encrypted: i=1; AJvYcCXSvLUSzbB8J87jRjfYwfycgOQsVGijqIBQw5o7m4CtszcMwNWsxN/bGbJoIgnyy7chZvCcilpD8DMIckPseTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26E6sv99f/ECN7PyDFCdHM61Sc31z1koIJj2/IN4qC6RWtgp0
	CCDpCoDYiHzhALkNsRmSKE5idEjM7ZPsTvYDF37CPimPF/QMaN7IyRVg8cb2jF4=
X-Google-Smtp-Source: AGHT+IHYbVEJ+TnRc83fkYSLRlczPRBgWnEGR/KYb4k0V61W5RWwzkl7uS4AY/5gY0THviVrGXbk+w==
X-Received: by 2002:a17:907:a4e:b0:a9d:e1d6:42a1 with SMTP id a640c23a62f3a-a9eeff26af8mr1718384966b.30.1731421595072;
        Tue, 12 Nov 2024 06:26:35 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e829:c484:5241:93b2? ([2001:67c:2fbc:1:e829:c484:5241:93b2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4c3f5sm730091266b.76.2024.11.12.06.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:26:34 -0800 (PST)
Message-ID: <136282ad-77d9-4799-bd2d-f3c3c9df99c0@openvpn.net>
Date: Tue, 12 Nov 2024 15:26:59 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net> <ZzIlxRbic7qLVD4F@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EZmhJFwEIAOAWiIj1EYkbikxXSSP3AazkI+Y/ICzdFDmiXXrYnf/mYEzORB0K
 vqNRQOdLyjbLKPQwSjYEt1uqwKaD1LRLbA7FpktAShDK4yIljkxhvDI8semfQ5WE/1Jj/I/Q
 U+4VXhkd6UvvpyQt/LiWvyAfvExPEvhiMnsg2zkQbBQ/M4Ns7ck0zQ4BTAVzW/GqoT2z03mg
 p1FhxkfzHMKPQ6ImEpuY5cZTQwrBUgWif6HzCtQJL7Ipa2fFnDaIHQeiJG0RXl/g9x3YlwWG
 sxOFrpWWsh6GI0Mo2W2nkinEIts48+wNDBCMcMlOaMYpyAI7fT5ziDuG2CBA060ZT7qqdl6b
 aXUAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJmaEkXAhsMBQkB4TOA
 AAoJEEjwzLaPWdFMbRUP/0t5FrjF8KY6uCU4Tx029NYKDN9zJr0CVwSGsNfC8WWonKs66QE1
 pd6xBVoBzu5InFRWa2ed6d6vBw2BaJHC0aMg3iwwBbEgPn4Jx89QfczFMJvFm+MNc2DLDrqN
 zaQSqBzQ5SvUjxh8lQ+iqAhi0MPv4e2YbXD0ROyO+ITRgQVZBVXoPm4IJGYWgmVmxP34oUQh
 BM7ipfCVbcOFU5OPhd9/jn1BCHzir+/i0fY2Z/aexMYHwXUMha/itvsBHGcIEYKk7PL9FEfs
 wlbq+vWoCtUTUc0AjDgB76AcUVxxJtxxpyvES9aFxWD7Qc+dnGJnfxVJI0zbN2b37fX138Bf
 27NuKpokv0sBnNEtsD7TY4gBz4QhvRNSBli0E5bGUbkM31rh4Iz21Qk0cCwR9D/vwQVsgPvG
 ioRqhvFWtLsEt/xKolOmUWA/jP0p8wnQ+3jY6a/DJ+o5LnVFzFqbK3fSojKbfr3bY33iZTSj
 DX9A4BcohRyqhnpNYyHL36gaOnNnOc+uXFCdoQkI531hXjzIsVs2OlfRufuDrWwAv+em2uOT
 BnRX9nFx9kPSO42TkFK55Dr5EDeBO3v33recscuB8VVN5xvh0GV57Qre+9sJrEq7Es9W609a
 +M0yRJWJEjFnMa/jsGZ+QyLD5QTL6SGuZ9gKI3W1SfFZOzV7hHsxPTZ6
Organization: OpenVPN Inc.
In-Reply-To: <ZzIlxRbic7qLVD4F@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2024 16:41, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
>> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
>> +			       struct nlattr **attrs)
>> +{
>> +	struct sockaddr_storage ss = {};
>> +	u32 sockfd, interv, timeout;
>> +	struct socket *sock = NULL;
>> +	u8 *local_ip = NULL;
>> +	bool rehash = false;
>> +	int ret;
>> +
>> +	if (attrs[OVPN_A_PEER_SOCKET]) {
>> +		/* lookup the fd in the kernel table and extract the socket
>> +		 * object
>> +		 */
>> +		sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
>> +		/* sockfd_lookup() increases sock's refcounter */
>> +		sock = sockfd_lookup(sockfd, &ret);
>> +		if (!sock) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot lookup peer socket (fd=%u): %d",
>> +					       sockfd, ret);
>> +			return -ENOTSOCK;
>> +		}
>> +
>> +		/* Only when using UDP as transport protocol the remote endpoint
>> +		 * can be configured so that ovpn knows where to send packets
>> +		 * to.
>> +		 *
>> +		 * In case of TCP, the socket is connected to the peer and ovpn
>> +		 * will just send bytes over it, without the need to specify a
>> +		 * destination.
>> +		 */
>> +		if (sock->sk->sk_protocol != IPPROTO_UDP &&
>> +		    (attrs[OVPN_A_PEER_REMOTE_IPV4] ||
>> +		     attrs[OVPN_A_PEER_REMOTE_IPV6])) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "unexpected remote IP address for non UDP socket");
>> +			sockfd_put(sock);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (peer->sock)
>> +			ovpn_socket_put(peer->sock);
>> +
>> +		peer->sock = ovpn_socket_new(sock, peer);
> 
> I don't see anything preventing concurrent updates of peer->sock. I
> think peer->lock should be taken from the start of
> ovpn_nl_peer_modify. Concurrent changes to peer->vpn_addrs and
> peer->keepalive_* are also not prevented with the current code.

Yeah, this came up to my mind as well when checking the keepalive worker 
code.

I'll make sure all updates happen under lock.

> 
> 
>> +		if (IS_ERR(peer->sock)) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot encapsulate socket: %ld",
>> +					       PTR_ERR(peer->sock));
>> +			sockfd_put(sock);
>> +			peer->sock = NULL;
>> +			return -ENOTSOCK;
>> +		}
>> +	}
>> +
>> +	if (ovpn_nl_attr_sockaddr_remote(attrs, &ss) != AF_UNSPEC) {
>> +		/* we carry the local IP in a generic container.
>> +		 * ovpn_peer_reset_sockaddr() will properly interpret it
>> +		 * based on ss.ss_family
>> +		 */
>> +		local_ip = ovpn_nl_attr_local_ip(attrs);
>> +
>> +		spin_lock_bh(&peer->lock);
>> +		/* set peer sockaddr */
>> +		ret = ovpn_peer_reset_sockaddr(peer, &ss, local_ip);
>> +		if (ret < 0) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot set peer sockaddr: %d",
>> +					       ret);
>> +			spin_unlock_bh(&peer->lock);
>> +			return ret;
>> +		}
>> +		spin_unlock_bh(&peer->lock);
>> +	}
>> +
>> +	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
>> +		rehash = true;
>> +		peer->vpn_addrs.ipv4.s_addr =
>> +			nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
>> +	}
>> +
>> +	if (attrs[OVPN_A_PEER_VPN_IPV6]) {
>> +		rehash = true;
>> +		peer->vpn_addrs.ipv6 =
>> +			nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
>> +	}
>> +
>> +	/* when setting the keepalive, both parameters have to be configured */
>> +	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
>> +	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
>> +		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
>> +		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
>> +		ovpn_peer_keepalive_set(peer, interv, timeout);
>> +	}
>> +
>> +	netdev_dbg(peer->ovpn->dev,
>> +		   "%s: peer id=%u endpoint=%pIScp/%s VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
>> +		   __func__, peer->id, &ss,
>> +		   peer->sock->sock->sk->sk_prot_creator->name,
>> +		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
>> +
>> +	return rehash ? 1 : 0;
>> +}
>> +
> 
> [...]
>> +void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
>> +	__must_hold(&peer->ovpn->peers->lock)
> 
> Changes to peer->vpn_addrs are not protected by peers->lock, so those
> could be getting updated while we're rehashing (and taking peer->lock
> in ovpn_nl_peer_modify as I'm suggesting above also wouldn't prevent
> that).
> 

/me screams :-D

Indeed peers->lock is only about protecting the lists, not the content 
of the listed objects.

How about acquiring the peers->lock before calling ovpn_nl_peer_modify()?
This way we prevent concurrent updates to interfere with each other, 
while at the same time we avoid concurrent adds/dels of the peer (the 
second part should already be protected as of today).

None of them is time critical and the lock should avoid the issue you 
mentioned.


Thanks a lot.

Regards,

>> +{
>> +	struct hlist_nulls_head *nhead;
>> +
>> +	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
>> +		/* remove potential old hashing */
>> +		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
>> +
>> +		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
>> +					   &peer->vpn_addrs.ipv4,
>> +					   sizeof(peer->vpn_addrs.ipv4));
>> +		hlist_nulls_add_head_rcu(&peer->hash_entry_addr4, nhead);
>> +	}
>> +
>> +	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
>> +		/* remove potential old hashing */
>> +		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
>> +
>> +		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_vpn_addr,
>> +					   &peer->vpn_addrs.ipv6,
>> +					   sizeof(peer->vpn_addrs.ipv6));
>> +		hlist_nulls_add_head_rcu(&peer->hash_entry_addr6, nhead);
>> +	}
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


