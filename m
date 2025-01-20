Return-Path: <linux-kselftest+bounces-24795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FBEA16E28
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 15:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4400B18885D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6B1E2858;
	Mon, 20 Jan 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="H46XUhvW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4181E1C36
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382296; cv=none; b=qpGwT80mGO4/DlLoKAEKiXJtRS9FYXOoyGyhgspwpZjriQ93uzZ390jIBn1N/4ucqDOzJccv9jsxy9n5DCGMJgrduDbmqqm5AwH559tUqFjMfEUVJmUDJw4Ml/fAbR0PHEtMa7Ai3vbKWjyv2fC0HLc9MqJxIxvf7AiND1tzq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382296; c=relaxed/simple;
	bh=G91iRyy8ZPXaiIGve01rfDfu+Q4c72Z1k+bMghsZFCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGB12BX5vanfMJvOwpXWalRSaU96CjOC5ElBk5zFpT7yy/1v3MiyxzEPRX/RAa1JhpPnIYFcT7YuvCmYSUgCDP34G6zDv2P5BIV07BXL7GkAMT66Ke2ITEvSozO+jsjpoh4o+X5cjSrNvWHr6kWTRQjMAoyylZSWdEdmNAuC2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=H46XUhvW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec111762bso866472566b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 06:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737382292; x=1737987092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u3WDal9+fBArGWLpYhtoY9HwUqfaEAbQY8/AzPXfmcw=;
        b=H46XUhvWDMyH+knFvbBF8WNxdpGygPHOJAtP5mcm1zebm7BX43l4Z72s/lQMe81nZ8
         vFss8IXGVrGQPk8s7d5nOQfJIFw8WWSMB/iSU9S9CsrpsAeFtwt8I5/Sj2+Xu2mJe2eR
         kxGZsuV3rbFhw4cOfek8R8KKhT3+YguLcYYgmpQbh/KK2Cy1RdYBsuG1FZO2bKZgmwNM
         1UjV98AfPe3m80/9SuoNd5VtC536wv3A234+kRgOZrdixUORAAkJ1NEqh/wD1RFG5AZa
         xCTBJAD/YPJ9c6Q2AojaH7mokgUzhq2KVISWmmz8gp4BkceaK1UQLUu1OhaNKrHZwg6x
         Yz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737382292; x=1737987092;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3WDal9+fBArGWLpYhtoY9HwUqfaEAbQY8/AzPXfmcw=;
        b=HfZQWAaPWWG0CY9tPrJPFYUeR074qjyQafgOVkItcuA0uWwOdxLNYHvhIuhd6hb+RH
         T8REjXs72uTD/2S/3X+WD5AqGmiWGzfQdOMMRWgdekodHDqp3WQtx0JmA8u2QBPYxOVc
         4fAbdErkNI/i5PhTRZRpnVY1e/X/M8vmCt4A+SI2YLYSsExMuOTUTS7fmCDLpnc0/Tgd
         aAMaMFJ+66HHT61MXnqAYQyUwDirhEd12RoKWEU/tSvc84TfJdkUjPKCwa6+bqjzLlK5
         Fm+a5xSiTckn8TwEtOboe9vDvZLdqmzmJOupJ2R5Pgv3fOo1UdsxYNFMczfnPvLQTrYQ
         q0HA==
X-Forwarded-Encrypted: i=1; AJvYcCWFAMeGKUmWxEr+Uk0EQ9alYxGWHTOsTSPbJBAEi5miX68m5O9KWdtmj6fMWhyhPWilT5MMvHUq7Jjf4YoPYLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jw7DzaAIZIBEZVj6KimSZ5kI0XOxEk44SEY4YDL/hpmcHRlY
	0nS4YgoigzPfAZ7O92yX+wJp7nha2IOoSoL5VLOLVdL/ID8oxfdGPsMCMWyCvxY=
X-Gm-Gg: ASbGncuN0RbbxofOUEmWSyU/uICbVW+0pkk10GHV+H+SLXValm5e8Vtjr0hq7f7g7cr
	WNLOPyaUjen+q8gtkTn9ygU+liaVSCqorDoNMOPANNkMF3WSj1c6WQTo1UETLwHqIS6O4SwGh3p
	w4T1EY612QDrsrDuRF+LJFjyf2bFilh8AZwato/WWa3wmiXEw/5YLnFJHvKdaeH1KNLkbPyjgUg
	CcdRJzkvwjMQkb8/cfZILvNnanSncQVYZUToBF9QIYazUuAXIZt6sPj1ysBoo+ONqMRvgeH9EXm
	o+2Xoe1LBKC6qVTSs3nhHsMmF3Mh5nCU
X-Google-Smtp-Source: AGHT+IHQx7EFjdBMAzc2wTch6cot/TbyJDRmy0xgRMOZOBQgwY8dt49gB0eWKuVf4Bqp8dXelVYULg==
X-Received: by 2002:a17:907:6d1b:b0:aaf:ada2:181e with SMTP id a640c23a62f3a-ab38b162851mr1050918466b.26.1737382292257;
        Mon, 20 Jan 2025 06:11:32 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:113d:ece6:3d2f:3a40? ([2001:67c:2fbc:1:113d:ece6:3d2f:3a40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f29260sm624491566b.94.2025.01.20.06.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 06:11:31 -0800 (PST)
Message-ID: <6ef40195-9648-40db-8e36-a2a0095aa411@openvpn.net>
Date: Mon, 20 Jan 2025 15:12:28 +0100
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

Going back now to this specific comment:

> 
> Not anymore since v12? [*]
> 
> I think it's ok here because we're only using peer and sk (not
> anything from ovpn_socket), but it is relevant in _sendmsg, which has
> the same peer_hold pattern without this comment.

After applying to _sendmsg() the modifications you suggested (i.e. 
reference peer directly instead of sock->peer), it also only uses peer 
and sk, but not ovpn_socket.
Therefore it should be fine too.

This said, the comment above should go away or at least should be modified.

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

Right - the lifetime of ovpn_socket is not tied to ovpn_peer anymore.
However, with the current code I don't think we ever assume that.


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


