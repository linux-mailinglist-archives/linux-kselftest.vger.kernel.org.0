Return-Path: <linux-kselftest+bounces-24720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54A8A14F24
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 13:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5188D3A6E2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B01FECD3;
	Fri, 17 Jan 2025 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bo7oyRED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1761FE45E
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116864; cv=none; b=qc73nO9T39z1wuSOEhguYS6qN/UVLtyBqGMdV0f0r30gSQr089qIrjb2b7VH8JkJaV4mEzCfQzzfzqy7LQaYbsIta/MZNBd9MPJBZ+dSyuEfv+ZRE5xz5Px2Ww6zIJVgWl5CaMNNbQY6eEfNPE9XIqKpihTtJ51g5/9gwO3yE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116864; c=relaxed/simple;
	bh=n7JIFaUpzLMmjke6jiJJ78m6HqJgWSraMzRkvdqmlng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cw2QX953nO4iq5VAMQYuTNBPa3tTVRuiWbzyxJ1GJDW6pi/ZCRCUpaejoLYVtJvJ+42VNPXGuYckv+GXOChWFy3YE1p6I/PhC8gBvZMoKkRbauIzmq27F580aT9nLNTuiJN8x5F0fL9XQEFNhIQ6T6Wm8/JnU/SC452/q2MepGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bo7oyRED; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38637614567so973363f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 04:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737116860; x=1737721660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U/ywgdQqRdWagz+3QDsZ+uwPbQn1KKALcsBHVUlaYmo=;
        b=bo7oyREDb7N220TyFmgt9PcAfKbD8T7jyjJqgeDrjtCCcZzbwHyBAToAqS30b8G/jb
         TA+0PBt1CuU91EdoYk2JptTcioljZ/ugEojZUVDRwgHyDIynTbTpbZg1ZUvk1CW6ewJz
         rklti7XaeiJbOvPYmliZBXbWk0sZ/47EWwa9QXQiKP8BQIEJ7NAM5A9hILdeCVhR0Cv7
         vt19vReKRs7iH/hIID/FU6RyElNxpyj6wekZXna3Q7qxIdc/uZyhDeXsqalIENZyLSrF
         mb1ns6F/LLCW5DCpcB4+JE0gGiJHn2GVuDZCWrPh47vllrb0kU/aNDfhUOXrNryl9GsU
         nH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737116860; x=1737721660;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/ywgdQqRdWagz+3QDsZ+uwPbQn1KKALcsBHVUlaYmo=;
        b=WpW7vP3JuFx/FYY6utw5XqkM6r+JRQ9ZwZJ6lJ0GMrBe/aRmdhkBHLAlYundSMvsBa
         xcqIUy71T1SQcqWdM0w8ZmgNJ63ZYiNiB7+W3WgTWjnVKYCgUu3uUiue68S9fx2NcLff
         xecMUE8Mh2Ds3PUHMqaWp+mXKK9DJqALs/eN/FfHpojCYZYwMnsdReZpc83PdE/SzH3l
         FU1ga583MdrCQmJeMgCSzzxZaMBfdq2JV9ku9eliPvl/HIO3lf3L5XdR4v9Mmpoo1RGY
         08iwK+TpfWQAhae+ch2aUSsIZg/SwOFy2oOcjqeNC0wSJJWMCMLvuHNm08vYrXid0fQd
         HBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvUgJ3+dZqxTxlffMsoGWXn2J7E5I8xuOR8JXTGG8RqfXMYnMeeBPXnoeMBCDf7H7qohqvZjZbH72d+17AeTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQuFYlWPm0dILGzsjWMgaNREYej9N0RqHljIloTBMKLJBaEm9
	NTsFXcI17f6w/Khg2U+T6SmZQdMrAaA5a160b2KWSVe7K6WrUAII7jD0N4d+N1g=
X-Gm-Gg: ASbGncuyePAiSoqmBooltXAWWUEc94INg4huJQOP9OJScQpwo5gH9bt6GNb7eIr8aAY
	H5DM+SeTCrYvRSTPp+iw58YiasDVbhdjebVAFZ5pW2/nvbPo+Urc99YU2QLfpUbmKxVt4x+ipvD
	inAEYuNXVB9ECR39VTs3XqfPZseqTCuvKjDp3PXLuxCcd/YmLjYsG3sFYeLXNqTdGCBel6ZlrrC
	Q9J+2jwBNBmqoVbIYSCpvzpw6xR6+YYVuSht0JO/nerG+f1dZzroQK2ITatb0qtEK8Hqs7lQAEm
	TyGI4CBm3HiWL6EMhtg=
X-Google-Smtp-Source: AGHT+IGfLzzJ7vZlc+8sqiP+zb0S4DkfVNWBk9IiMR4T3jQ7OCc77FUbOhvVrwl/2YhSgTkg6/08yA==
X-Received: by 2002:adf:f381:0:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-38bf5687fc8mr1901653f8f.32.1737116860043;
        Fri, 17 Jan 2025 04:27:40 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:217f:1ce8:9888:d2ed? ([2001:67c:2fbc:1:217f:1ce8:9888:d2ed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275622sm2426201f8f.69.2025.01.17.04.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 04:27:39 -0800 (PST)
Message-ID: <1bbbde25-ef86-4890-9984-bd2f502e9e9e@openvpn.net>
Date: Fri, 17 Jan 2025 13:28:33 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 09/25] ovpn: implement packet processing
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-9-1f00db9c2bd6@openvpn.net> <Z4pKMkDrujMWMlCW@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z4pKMkDrujMWMlCW@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2025 13:16, Sabrina Dubroca wrote:
> 2025-01-13, 10:31:28 +0100, Antonio Quartulli wrote:
>>   static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
>>   {
>> -	ovpn_skb_cb(skb)->peer = peer;
>> +	struct ovpn_crypto_key_slot *ks;
>> +
>> +	if (unlikely(skb->ip_summed == CHECKSUM_PARTIAL &&
>> +		     skb_checksum_help(skb))) {
>> +		net_warn_ratelimited("%s: cannot compute checksum for outgoing packet for peer %u\n",
>> +				     netdev_name(peer->ovpn->dev), peer->id);
>> +		return false;
>> +	}
>> +
>> +	/* get primary key to be used for encrypting data */
>> +	ks = ovpn_crypto_key_slot_primary(&peer->crypto);
>> +	if (unlikely(!ks))
>> +		return false;
>>   
>>   	/* take a reference to the peer because the crypto code may run async.
>>   	 * ovpn_encrypt_post() will release it upon completion
>> @@ -118,7 +244,8 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
> 
> Adding in the few lines that got snipped:
> 
> 	/* take a reference to the peer because the crypto code may run async.
> 	 * ovpn_encrypt_post() will release it upon completion
> 	 */
> 	if (unlikely(!ovpn_peer_hold(peer))) {
> 		DEBUG_NET_WARN_ON_ONCE(1);
> 		return false;
> 	}
> 
> This should never happen, but just in case, we'd want
> ovpn_crypto_key_slot_put() here.

ACK

> 
>>   		return false;
>>   	}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


