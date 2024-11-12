Return-Path: <linux-kselftest+bounces-21875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07BE9C5C1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D6B282F3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E0202634;
	Tue, 12 Nov 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LNDR2sPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AC20262A
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426000; cv=none; b=lqDR7/bhxBzSKE/UtTmN0TIdpe/XVfDJ3I7VRdU0pYQI/whd1uaADv2+vIHX4XO7oqJvKrxRhAMNVPbtDyejQwuYKyDKqxL/5oaTo6KaG5g/KWxifDr7BPY8WDvvngXmmCjwY+20IqSB3PrzxWZ5EuBe83bPUGn7pJur3Eo/zVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426000; c=relaxed/simple;
	bh=lSn9tZqbXXMm4ytAopoRf2rbmRp9OS2LoZx9rzlMOSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgGOIPlyaEvy7UaVdXQ8PjFax08/N6JeVadFco/lCnLsivUPZCgv1h6MnKMxm3U9Aa57FNr3VQKa5bUVA77uTXAaspilFvK5k4CdxcpRMmj0V4/4Q1i09eXB38axWL0A2EHlQzG6XMuXRLtyGDMf5AP43596972COoJTNN8SNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LNDR2sPw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso978632266b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 07:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731425996; x=1732030796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tkqstsrPp4KySdsvdodgkejaPTUdxNGqUhtM7D3Jo5A=;
        b=LNDR2sPwvCuVp+/9rgigDnzZ9RLW+z9jU4Pr/pOVGRL89BPe0cSL7SqkEX5lqp4Ije
         gsExYuYoI7UR5ftGdc+jemBt7MB44wGRF8wV5kQx1mTv4SUXDa650BN1tnjUH/xQ5/sB
         +afpsnhU6eRBjwp5J9jA8pzVJqVFDKypQSV7xFQt2eBdGDVoGHHLhsaFJx5xEh3Pn30U
         LRlqbjQwER0VgsqGDcNnyAwVD5w5H+K3vzrGFw+XRCiMYbjX9igMBTm3BDQK2Wdd4MuM
         4lONrY9wgEkzikkYKuBZGtWzxUg+IWydNrtHc/dRtTM5rp5t12Aoy/yQCzKGDHhKQJuj
         Rx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731425996; x=1732030796;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkqstsrPp4KySdsvdodgkejaPTUdxNGqUhtM7D3Jo5A=;
        b=ZGFpRPKN8f8uUuhwJNceWd2NVTL+beauMjaGUGcKY/yBkIXs4fp5Nsur4z/c94cQfo
         IinJjb7OFH5JCL7wKCu98lALQo6IefaVpxCq37GImJwzXlA09FwakHXd8/I03Zxkg57+
         dzrmVYNFMl5tSygs4v3cC84ESqbHmVt4GDhHjTyJ4UfGpRhEz96xTZQbu/hutDEGXXcD
         GMaFnWRlR6td5JRd1A7EN3nSJfXWY2A+dQDwuUnAeVfdfX32c4keaxieqvs87nZ/TcaG
         /8rE9hKPlhQRWwYVlpkpQ+QPiU3ACYyROYa80D3qMmIqS4U5Ry/XufLab3TdQC64+1Bt
         qv/w==
X-Forwarded-Encrypted: i=1; AJvYcCUAozZioiaGkRSllOxUnJa2EbrH88wmPQHA7ZTAq4s3Yz+ESmvtXVHTwmt+duz+yDW6RBcPR3qbmQgW6MsYDnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3c+KTa8MZg3+A2AjM8Fv8KeEzyBeZNJKFNKRR/Ftpu4U0mBjD
	vbxmY/QQEoD857zB3rF3mHBZM+K+EAPyftaaKhqvMEv2kV7Fa/I8vsu20pDUC3Q=
X-Google-Smtp-Source: AGHT+IHevdpcDT+9UCMSKbtTe0SiY9drSWARd9dhjS8G5D91gUBoqMjSSVFPcqZZ7ncLNNwGkLrisQ==
X-Received: by 2002:a17:906:f597:b0:a9a:13dd:2734 with SMTP id a640c23a62f3a-a9eeff44839mr1773883266b.36.1731425996131;
        Tue, 12 Nov 2024 07:39:56 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e829:c484:5241:93b2? ([2001:67c:2fbc:1:e829:c484:5241:93b2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a988sm728455166b.59.2024.11.12.07.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 07:39:55 -0800 (PST)
Message-ID: <8ed53007-cc7c-4747-a690-f27915f2be8d@openvpn.net>
Date: Tue, 12 Nov 2024 16:40:19 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 19/23] ovpn: implement key add/get/del/swap
 via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-19-de4698c73a25@openvpn.net> <ZynwjJNz6kLa4p7x@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZynwjJNz6kLa4p7x@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2024 11:16, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:32 +0100, Antonio Quartulli wrote:
>> This change introduces the netlink commands needed to add, get, delete
>> and swap keys for a specific peer.
>>
>> Userspace is expected to use these commands to create, inspect (non
>> sensible data only), destroy and rotate session keys for a specific
> 
> nit: s/sensible/sensitive/
> 
>> +int ovpn_crypto_config_get(struct ovpn_crypto_state *cs,
>> +			   enum ovpn_key_slot slot,
>> +			   struct ovpn_key_config *keyconf)
>> +{
> [...]
>> +
>> +	rcu_read_lock();
>> +	ks = rcu_dereference(cs->slots[idx]);
>> +	if (!ks || (ks && !ovpn_crypto_key_slot_hold(ks))) {
>> +		rcu_read_unlock();
>> +		return -ENOENT;
>> +	}
>> +	rcu_read_unlock();
> 
> You could stay under rcu_read_lock a little bit longer and avoid
> taking a reference just to release it immediately.

ACK.

> 
>> +	keyconf->cipher_alg = ovpn_aead_crypto_alg(ks);
>> +	keyconf->key_id = ks->key_id;
>> +
>> +	ovpn_crypto_key_slot_put(ks);
>> +
>> +	return 0;
>> +}
> 
> 
> [...]
>>   int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
> [...]
>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
>> +			      OVPN_A_KEYCONF_PEER_ID))
>> +		return -EINVAL;
>> +
>> +	peer_id = nla_get_u32(attrs[OVPN_A_KEYCONF_PEER_ID]);
>> +
>> +	peer = ovpn_peer_get_by_id(ovpn, peer_id);
>> +	if (!peer) {
>> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +				       "cannot find peer with id %u", 0);
> 
>                                                                         peer_id?
> 
>> +		return -ENOENT;
>> +	}
>> +
>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
>> +			      OVPN_A_KEYCONF_SLOT))
>> +		return -EINVAL;
> 
> Move this check before ovpn_peer_get_by_id? We're leaking a reference
> on the peer.

ACK

> 
> 
>> +
>> +	slot = nla_get_u32(attrs[OVPN_A_KEYCONF_SLOT]);
>> +
>> +	ret = ovpn_crypto_config_get(&peer->crypto, slot, &keyconf);
>> +	if (ret < 0) {
>> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +				       "cannot extract key from slot %u for peer %u",
>> +				       slot, peer_id);
>> +		goto err;
>> +	}
>> +
>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> +	if (!msg) {
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	ret = ovpn_nl_send_key(msg, info, peer->id, slot, &keyconf,
>> +			       info->snd_portid, info->snd_seq, 0);
> 
> info->snd_portid and info->snd_seq can be extracted from info directly
> in ovpn_nl_send_key since there's no other caller, and flags=0 can be
> skipped as well.

I tried to keep the signature similar to send_peer, but indeed they can 
both be simplified.

> 
>> +	if (ret < 0) {
>> +		nlmsg_free(msg);
>> +		goto err;
>> +	}
>> +
>> +	ret = genlmsg_reply(msg, info);
>> +err:
>> +	ovpn_peer_put(peer);
>> +	return ret;
>>   }
> 
> 
> 
> [...]
>>   int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
>> +	struct ovpn_struct *ovpn = info->user_ptr[0];
>> +	enum ovpn_key_slot slot;
>> +	struct ovpn_peer *peer;
>> +	u32 peer_id;
>> +	int ret;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_KEYCONF))
>> +		return -EINVAL;
>> +
>> +	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
>> +			       info->attrs[OVPN_A_KEYCONF],
>> +			       ovpn_keyconf_nl_policy, info->extack);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
>> +			      OVPN_A_KEYCONF_PEER_ID))
>> +		return -EINVAL;
>> +
>> +	if (ret)
>> +		return ret;
> 
> leftover?

very likely.

Thanks a lot

Regards,

> 
> 
>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_KEYCONF], attrs,
>> +			      OVPN_A_KEYCONF_SLOT))
>> +		return -EINVAL;
> 

-- 
Antonio Quartulli
OpenVPN Inc.


