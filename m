Return-Path: <linux-kselftest+bounces-30016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A303AA78DE9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 14:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861413AA9FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069F823371D;
	Wed,  2 Apr 2025 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SDFrHGi2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE849238166
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595909; cv=none; b=Bq9ZAPZZdGSKCyucXr5A+Ipi6HAGcOwqj6CfnplgRb27SjrAx+yLf1ry7+ArfrXcMtWlq+LBtbnZI4wrfzFxJTqRuDz1j9GzDKz4jjeu2yOaLd4NW2KlatnZvrdrJx5W+WGjHJTSzukUZ37ByV8vJhmJCTgDdxphty3EHp22CJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595909; c=relaxed/simple;
	bh=znh3N/rW7quWQkzFKk/ow5OXIniZs+x02k3aBF1YDno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Blh1aX9SBCtFGEr1WIyLXuJkoRdEhjI5QT9owpC+1YKy9SDX0waoO8xgPwUwTxGfGc/zm5ZsjmfMHe+ZE79JYMuYWDbjP8Xf9eQUM6GGnQbTzCf9dzv4bymRjjwMdi9cghJhqAH1evvJKGqVM/O61UhfubvqDYXeOC7SDVstg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SDFrHGi2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso1129861766b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Apr 2025 05:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1743595906; x=1744200706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+v0JQJZFWiuhbl9dOgj1toLEURVKnByxbc2HMXbSZ+4=;
        b=SDFrHGi2xHK3L4URXbaUYJ0YG6djOEs8qOULHd5fOhCDrAfbRJox3Z1kuYLBCbdbW2
         1L5iqWbM77PgAGip27P0U9ghfHGOvqe6ngo5HJQvlYSOKDvuGZKxHMo/g8NHIndQnmAQ
         bJBL+9qU25YhLz6k8Ay9P1dYhHmE8maA+ryGsvmGEE3aQUSUAVSgeCLb2gtwDy9hpO6U
         QnfyKdAMrFk4bz66Tm5QmL5MG8+1C4E0AKh1zhxKZGsY4d9qFI/017VpLgnZbBehr03a
         SPsPuq8jSFmrvgZE507T4RVuvjAc7Dvhb63QGE+oiMtSygq5jdZCW3zQzhkZFD6aUJ8L
         ZpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743595906; x=1744200706;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v0JQJZFWiuhbl9dOgj1toLEURVKnByxbc2HMXbSZ+4=;
        b=a9YBGDlGWT2bTb5wCly3M4P7lU2NIAtCjqAKRCldoK0teuETLijBr0+QOVSIL2mv6b
         3qFNBur3uPFMOehHDpJvMM6foukBbaYtNuKcMpG2U2jLWJmfNQXKZepf2p/YXZjZzk3D
         0DqeXQfSHeGFw0MBEPKf/kRcI6wUz6pZF00xS6dQ7l2llJIE1+7z1XEdlgDwNHyiWkuS
         FTynqPN59uSQDgBeFygM/YYF3+PUdEI1msEeFw0df43cKi6tOkCVE+dy/IL1c+FdCqM7
         sJHLVsZmJ+jVozVxvmlyl6CAdijY0B2iveQ2jxRwVqASvhpV88eZZV3zQX+/1eEoaFRQ
         8bNg==
X-Forwarded-Encrypted: i=1; AJvYcCUoNI5C50iA374sQ3Uf9VWjGhl6DAmbDAMZVA2PyyjJ+401IkzWhuemE/Q72ggz8OYwUlEAD3eMf4gd4LhPT/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPvBcyjNDSM4ckR8qDqhm0JIVblaZaQM8LLs4Ybr1tYMTcFS4
	Ke1YIRWOYKiKkltHWbpdPUY+WeBYRCVqb/+crXi/38nKtGfu32AD6r8UOh5aIPrjNmGMBGN/HUB
	sCRfh9+6V2BeMC8rLc+W2cDNhEBAa+hOs4Qf1QHMmiAtXsSvwww8iL8+OY7c=
X-Gm-Gg: ASbGncs4JvCnfOwyjQUjKybW2qSPq49UWnCqjKVwAxk4u2joKGZEBvYXkaw2H89iIea
	tK6BWX8yVSl9LzL/FL39RHH9YmBmDRP997Fa54xzQa11z8gP7SkH2Rw8NuyD1mNv9wAaFD0xaHS
	M4ssjdy2AMpZGbcZ7LTxG7UBOSfYxhJt6k9+QVgc6U6DtfjnRlQJ5yZ/iHzbMPlPMDLDyc2vB2+
	29EE+3ZONfOLROiCdh2lLo3JavkWZDs7kSk8lXo1GZ17HQ9YY5qgddizEUZuByo7s33/B5ulDzJ
	jyIfXD3J21VXAHlSOhipiN9fn8ABmDiGKSKAtQIu0V1DnLMPVijxJNgc9ziECrT6r8HbDqB70rf
	FhxyOz1U=
X-Google-Smtp-Source: AGHT+IG1/Ya4jb9p6b1iUEKFuRWbirlB/ADOUvxv+FZqn33gXr5jpoeRL5uo2cZL8kWtEFMzd0mRQg==
X-Received: by 2002:a17:907:1c9c:b0:ac2:baab:681c with SMTP id a640c23a62f3a-ac738a55dffmr1332866466b.28.1743595906097;
        Wed, 02 Apr 2025 05:11:46 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9a9c:dc9e:39c6:2380? ([2001:67c:2fbc:1:9a9c:dc9e:39c6:2380])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719223e1esm906786466b.7.2025.04.02.05.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 05:11:44 -0700 (PDT)
Message-ID: <39b4ca40-a4a8-447f-b2a7-7221437fad22@openvpn.net>
Date: Wed, 2 Apr 2025 14:11:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v24 16/23] ovpn: implement keepalive mechanism
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-16-3ec4ab5c4a77@openvpn.net> <Z-vhVdMThx7NQgW0@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z-vhVdMThx7NQgW0@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2025 14:51, Sabrina Dubroca wrote:
> 2025-03-18, 02:40:51 +0100, Antonio Quartulli wrote:
>> @@ -124,6 +154,13 @@ void ovpn_decrypt_post(void *data, int ret)
>>   			goto drop;
>>   		}
>>   
>> +		if (ovpn_is_keepalive(skb)) {
>> +			net_dbg_ratelimited("%s: ping received from peer %u\n",
>> +					    netdev_name(peer->ovpn->dev),
>> +					    peer->id);
>> +			goto drop_nocount;
>> +		}
>> +
>>   		net_info_ratelimited("%s: unsupported protocol received from peer %u\n",
>>   				     netdev_name(peer->ovpn->dev), peer->id);
>>   		goto drop;
>> @@ -149,6 +186,7 @@ void ovpn_decrypt_post(void *data, int ret)
>>   drop:
>>   	if (unlikely(skb))
>>   		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
>> +drop_nocount:
>>   	if (likely(peer))
>>   		ovpn_peer_put(peer);
>>   	if (likely(ks))
>>   	kfree_skb(skb);
>>   }
> 
> Again a small thing: in the case of a keepalive message, it would also
> be nice to use consume_skb instead of kfree_skb. Quoting from the doc
> for consume_skb:
> 
>   *	Functions identically to kfree_skb, but kfree_skb assumes that the frame
>   *	is being dropped after a failure and notes that

I agree! I always try to pay attention to when consume_skb() should be 
used, but I must have missed this special case.

> 
> 
> 
> Something like this maybe (not compiled):
> 
> 	/* skb is passed to upper layer - don't free it */
> 	skb = NULL;
> drop:
> 	if (unlikely(skb))
> 		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> 	kfree_skb(skb);
> 	skb = NULL;
> drop_nocount:
> 	if (likely(peer))
> 		ovpn_peer_put(peer);
> 	if (likely(ks))
> 		ovpn_crypto_key_slot_put(ks);
> 	consume_skb(skb);
> 
> 
> 

Either that or I can call consume_skb(skb) and set skb = NULL before 
jumping to drop_nocount (haven't fully checked if possible).

I'll see which version is better.

Thanks for pointing this out!

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


