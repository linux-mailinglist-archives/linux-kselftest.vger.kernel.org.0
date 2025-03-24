Return-Path: <linux-kselftest+bounces-29702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F58AA6E4B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 21:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B0017042D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 20:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FB41DDA33;
	Mon, 24 Mar 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HGQYR5in"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4121C7015
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849587; cv=none; b=moVQo90MQ0LyeCZuaFUj/6OVygxyfn6cI4t9/lgSPkTIu+Ht3wxLNLQEvC3qXdoQhhOrDgNP/U3u0FN26gKuWVXbYDUmTsn8lSlIt8kfdxBPm9n187zpzy6ni+UjLojobwuDtQCnRSq4qwFo9MySVbGpuDEOg9kBmMRsuFrK4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849587; c=relaxed/simple;
	bh=i8aZYde1B3RChKKVLyzjLczhEobtRPovvSD01gK4Tbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBhKRN1Y8+HHhh8JeDHgsiofKJZrKejTeyblxmG0HfYzcvXk3NMWyYb6GQLFHFdF3DoyCSHlCLv7RnP1+6wq7JUdv43ec4vC9LFZG+lx4lfiBOjCZ8jkooeXbgnjzJiMzgnfLXfSZoHcIf8BZdQZrr2PUlgOlinbql8AsttLXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HGQYR5in; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2963dc379so828037666b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742849584; x=1743454384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I38U0FrU7lXZPgGiiC6xH++pECXJ1njDUw5kOS4q8JU=;
        b=HGQYR5inf2Plw68ViKAxuDQZZoQiC6rCKf2opcf+B1LCjUujDSG/XGQU2H21epneqA
         QRIG94oanorKWwh32ppV0BGRYdWhDPDyVaV6CmSe+rxoaal7tzbold7iamDO0aMFwnlA
         l5tgkzpwV1GIHx8+5wpvUvj6ivZlCH4oKc+Z7zz6qxlmzffi6WB1kyFp/UC1uGMduxvr
         /1HWnrJiDSWHWpGA45QpDltoD0hRk3xIJwl3MMd4oqRbc9xhWWQitsM5YdHO9MKDnnYw
         xRq3RxaPxHka788hotCFht1wHmKV4VJYJHDK67BFu7FvM/Pmb/ZsPIrsjyeRV9TEzb0F
         7XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849584; x=1743454384;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I38U0FrU7lXZPgGiiC6xH++pECXJ1njDUw5kOS4q8JU=;
        b=Jq+mAMRMxl63PlG263jp+bFpzAU9+SrQoq3wr2l8ZSUKNNNm5pmqPK+kh8MMm1A7w5
         0TShogvLTYZyQXnmFgF2meX0qBckqoDOMH1n2rL/eeJrXCQDqhHanKfqMlCSMnB6a7jk
         U8wxaDU3fPOgFN411ouaBFaFYF/mhEdwGp/EkDoNFzQlJepmWa57A3CL7qdp1dTFOIGM
         8xop6kUAAVXDyM9S3Oj425pnUeePenI0Ah4uEbedl5Y+Sjog9YLb2vtmd8xakvLRrL1O
         flWR3cIBPGZ+DZHjSU6I7Qn4iOaD3TaFM6k8rqPFkoE6He6ZMOivHiEM4MijrCKnl5JH
         a+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWBSncIehROkXp/FiqSC/MHHPJYAfPeVm47rCvJIDzrluRi2jJ9eK0Di3RsIfQcTDOoKWJFwyqwHW3J97el6Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvm10R7FuavREwwhP9wSVAUAczi0MltILUvAjHiv1SX1H971IX
	X23T5uv4kwSf8R42774DnSA8ARyYbzUhYHDwYNqwT1jA+bqBTNLqp3dthROay1vwM1r7G8HYBBP
	6jhddvR/YwLgcdpf1S4VT6zIQPUq1Nlfe6RkZiW0WP+8ZXexCmFv8RWTND08=
X-Gm-Gg: ASbGnct6KIK/mUFpoI0IYSB2nsS3g+YcEUDt2xZufs6KipOl8eZjNDEja28gG5HxaiR
	kdhHYKAplkL7vG0LNekgV0btHHBycnUaAYJchMJjpsMnRHH2HH7sdDKP5Yr4lV2kzkB0OXxFYth
	kMzkqJcI748MYZ7OuW+n2jAC9QqY+pjW8npzWz5kYpygJw83lcCuLaOsbLH5VpK4VqN32IjkTn7
	nxkTLf/0HJKPxd3B6gWcrqsztsvv43NOcyH9SSbP1Wqh0f7W6qJxSZXRsC09NHrM49LcTTQWSUF
	EJ01ObSMpOmThN7EejgCt9jea6C/PRkWfa+XY8Dg0vI0jPPFrap1CfvyIMSfWTQYp6TKlwxwDbx
	qiDqmgMlbs8Jcw4sbQQ==
X-Google-Smtp-Source: AGHT+IFstL4cl4J1iYAxXwRy6hoDu2dOycCyl006ObbtprBV0TprEgXJ2rIAwgqdRUKc9/q3kDAang==
X-Received: by 2002:a17:907:8686:b0:abe:f48c:bcd with SMTP id a640c23a62f3a-ac3f27fd5fbmr1662647866b.50.1742849583835;
        Mon, 24 Mar 2025 13:53:03 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4ced:7dc0:1dc5:471a? ([2001:67c:2fbc:1:4ced:7dc0:1dc5:471a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd3b34fsm733226466b.157.2025.03.24.13.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 13:53:03 -0700 (PDT)
Message-ID: <ae9f3c18-7b03-4a49-83a4-a3e7d8c52a3e@openvpn.net>
Date: Mon, 24 Mar 2025 21:53:02 +0100
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
 <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net> <Z-E70n1tkzKdepTo@krikkit>
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
In-Reply-To: <Z-E70n1tkzKdepTo@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/03/2025 12:02, Sabrina Dubroca wrote:
> 2025-03-18, 02:40:44 +0100, Antonio Quartulli wrote:
>> +int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
>> +			    const struct ovpn_peer_key_reset *pkr)
>> +{
>> +	struct ovpn_crypto_key_slot *old = NULL, *new;
>> +	u8 idx;
>> +
>> +	if (pkr->slot != OVPN_KEY_SLOT_PRIMARY &&
>> +	    pkr->slot != OVPN_KEY_SLOT_SECONDARY)
>> +		return -EINVAL;
>> +
>> +	new = ovpn_aead_crypto_key_slot_new(&pkr->key);
>> +	if (IS_ERR(new))
>> +		return PTR_ERR(new);
>> +
>> +	spin_lock_bh(&cs->lock);
> 
> At this point, should there be a check that we're not installing 2
> keys with the same key_id at the same time? I expect a well-behaved
> userspace never does that, but it would confuse
> ovpn_crypto_key_id_to_slot if it ever happened.
> 
> ["well, then the tunnel is broken. if userspace sets up a broken
> config that's not the kernel's problem." is an acceptable answer]
> 

The behaviour of ovpn_crypto_key_id_to_slot() is still "deterministic" 
as we will first lookup the primary key.

Therefore we will simply always use the primary key and never the other, 
which is what we should expect in this situation from the code.

I'd say this is just an ill-formed configuration, yet not invalid.
As per your statement, I'd say it's userspace's problem.

Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.


