Return-Path: <linux-kselftest+bounces-30014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AED5A78DDE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 14:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE033B021D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884A5238176;
	Wed,  2 Apr 2025 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fW/lYQdO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B9238166
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595704; cv=none; b=OseJ774HDX4r9U4tYENLcAT4q3oYoYVGSMCOwUuqE3KTvNvZyjDFsvXtvvgDVajueaFUls5SabhxnxtGkKxRlYfpvaz6jkdXfy9K3ZWALShQyDRnQpLhBZVThNmRQOmRAxnG/luWB/5w8zj78oyk4C2AX1KWR2FMngHLOVQAcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595704; c=relaxed/simple;
	bh=0cyQ8kfbsOP5CL/OayFEvuviX2pQwjWQA09VE+ucdsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNcl1SxHI15EW1embkbgXEeHqh5fWFBzUVDoPBgu6Vib7Ju7As6ff6D6Gj+BbikdP2XraHyeSCXVc2DJYxXrFjgk4iDAzyFAOAHlXqNQjF6L2Q24bhw1GVrLTnu23BXSE/AAow1oXFL21DKfHGDSiSNZTi37VGJbwzeIXchLp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fW/lYQdO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so35219665e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Apr 2025 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1743595701; x=1744200501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j5Jfe36OUwvVyT9LS7eCwDhDtrMpAORzy0WnLrxsyVY=;
        b=fW/lYQdOMx3ShdTtWtuKZ5d+28JswJ8BaFOm1WGuv/4f1OD982+RdjTFucLBEyIeQ3
         RWk1CPytGQVcqwKH/bvu7bH1gBwAHxI4miaFtmaPrLJZnf/swb840NBNAYmEZqco350/
         idi8zBo9gcGD8R7dymMV5P2MrRaXC1AX3cGaYi1AMu88rd/dLmvJgHHebajBXvDj9Lep
         HP9HP3smrNFjx9kYtzr86iK1sZnCPsltQ6aCwCPN3fLx33E4QojpvA00064hJHmr4Uga
         zIsc9yj2v9F8jKS1EOH/5SHwLMSjfdV2NM84L8IWMswqqI8vvTMu2OZo734qkdOpxrwP
         vtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743595701; x=1744200501;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5Jfe36OUwvVyT9LS7eCwDhDtrMpAORzy0WnLrxsyVY=;
        b=fD7SYWVhTcFOUNkeD8BRiNyrMQF3ppjv+/cygpi7Xw90lfDEy6qIjoqYVRz8NTk8GM
         oxtxfj+QSrH03aaddH9+UQOR6OTKcpX/aMjWC6HK+Ro7R9PxyH6Re8GZ4iRQ/DQq5vwf
         Nf7QwhtEBBN9LugBAblz69I2bwNO3ENquE6Za4YhcirvamkYvSlYDjb9xhKvrfrHI++I
         nSz6npUDZiV193o884T+4Otldg+YJlQlq6THYBhYMEYSd085w3sCkw6HO35t1Um8CPCJ
         MUSDHTbAnr+W4iNGvYFSA7GTOlf2gOvYzjEwemqqYxRMvPnGFSVRi5TNOJiC9FIAyTyp
         NIGw==
X-Forwarded-Encrypted: i=1; AJvYcCVXuQmFi9cvKImi50E8jC+jRs5EspJ/0lwWEbfvipvobQfIqGI+2V42B8rJrnrJ8Ewr3rEgIcEPhZY57UqAg9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ELOo6PVZszDubeHxPZPqPosVFnA3q8k3E/cyEZRMT883x4Zq
	wIy/rA5vu6NNZWP9MbVVbAtssygJuFoDC0JoBhOs+HzPOGMPysjrbXaW6z6JDVDS5uWrP8XR/CO
	EcaHo+25R66WgYsvjKRWQGB4H6D3kLorTynixhXkXZJoHdgpj4t6TW9CbLBk=
X-Gm-Gg: ASbGncuNs8YXDMFpqOkEjkVRrsv1Ex1Mu4LA49t4NggpaT0tMerdqJJxWkL+707vokd
	gvlMbPmMemr0M49VRyjPvgD8SpH35ZewkbCeGRzcVUhal2XXWSLdGYZgdcyQ2QCW/5J7WK+sEK3
	7tCkeOJ5nd1jm1PQk3GlNxtWpIZHM/lM2UK/xJiYHdtPVv4+t9yre5mchYgOYmbk6cqGaRoSJTp
	o+fdFWpZ7dSbrPO1OFLTfS1jTWR5k/ySo9OVWEGjqNU2TOPz3vtK8goqFgX1wm2JQu49ef3F8iX
	cHizndS4fldB04mGgA/Mi9fg2iie4VTqgkg/XOmVeALYY47mA8kGVe8tog6MgVoXg+5jtgBEul7
	u3HAxA/E=
X-Google-Smtp-Source: AGHT+IG3b1s4SCLE8l25O6MvYbGYEYTk0hwlT/ofXoHltCEE2yp+1M9ogrjFly9DqCR7bodW1lSJ6w==
X-Received: by 2002:a05:6000:40e0:b0:39a:ca0c:fb0c with SMTP id ffacd0b85a97d-39c120e3590mr13131376f8f.28.1743595700585;
        Wed, 02 Apr 2025 05:08:20 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9a9c:dc9e:39c6:2380? ([2001:67c:2fbc:1:9a9c:dc9e:39c6:2380])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e304sm16841996f8f.73.2025.04.02.05.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 05:08:19 -0700 (PDT)
Message-ID: <cd992750-2b8b-4793-8575-89d69ff3624c@openvpn.net>
Date: Wed, 2 Apr 2025 14:08:18 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v24 09/23] ovpn: implement packet processing
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net> <Z-u46_82tkR8TsOa@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z-u46_82tkR8TsOa@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2025 11:59, Sabrina Dubroca wrote:
> 2025-03-18, 02:40:44 +0100, Antonio Quartulli wrote:
>> +/* this swap is not atomic, but there will be a very short time frame where the
>> + * old_secondary key won't be available. This should not be a big deal as most
>> + * likely both peers are already using the new primary at this point.
>> + */
> 
> This is not the case anymore.

Oh right - this comment can go.

> 
>> +void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs)
>> +{
>> +	const struct ovpn_crypto_key_slot *old_primary, *old_secondary;
>> +	u8 idx;
>> +
>> +	spin_lock_bh(&cs->lock);
>> +	idx = cs->primary_idx;
>> +	old_primary = rcu_dereference_protected(cs->slots[idx],
>> +						lockdep_is_held(&cs->lock));
>> +	old_secondary = rcu_dereference_protected(cs->slots[!idx],
>> +						  lockdep_is_held(&cs->lock));
>> +	/* perform real swap by switching the index of the primary key */
>> +	WRITE_ONCE(cs->primary_idx, !cs->primary_idx);
>> +
>> +	pr_debug("key swapped: (old primary) %d <-> (new primary) %d\n",
>> +		 old_primary ? old_primary->key_id : -1,
>> +		 old_secondary ? old_secondary->key_id : -1);
>> +
>> +	spin_unlock_bh(&cs->lock);
>> +}
> 
> [...]
>> +int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>> +		      struct sk_buff *skb)
>> +{
> [...]
>> +	/* encrypt it */
>> +	return crypto_aead_encrypt(req);
>> +free_iv:
>> +	kfree(ovpn_skb_cb(skb)->iv);
>> +	ovpn_skb_cb(skb)->iv = NULL;
>> +free_sg:
>> +	kfree(ovpn_skb_cb(skb)->sg);
>> +	ovpn_skb_cb(skb)->sg = NULL;
> 
> nit: Those shouldn't really be needed, since we'll call
> ovpn_encrypt_post that will take care of iv/sg/req. But it's fine if
> you leave them.

Right!
This code flow was re-arranged a couple of times, and I have missed that 
we now always hit those free()s in post().

I prefer to drop them and put a comment indicating that cleanup happens 
in post().

> 
> (same thing on the decrypt side)

Yep

> 
>> +	return ret;
>> +}
> 
> 
> [...]
>> +/**
>> + * ovpn_key_id_from_skb - extract key ID from the skb head
>> + * @skb: the packet to extract the key ID code from
>> + *
>> + * Note: this function assumes that the skb head was pulled enough
>> + * to access the first byte.
> 
> nit: another "first byte" that I missed previously :(

ACK!

> 
>> + *
>> + * Return: the key ID
>> + */
>> +static inline u8 ovpn_key_id_from_skb(const struct sk_buff *skb)
>> +{
>> +	u32 opcode = be32_to_cpu(*(__be32 *)skb->data);
>> +
>> +	return FIELD_GET(OVPN_OPCODE_KEYID_MASK, opcode);
>> +}
> 

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


