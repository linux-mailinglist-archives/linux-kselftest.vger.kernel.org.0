Return-Path: <linux-kselftest+bounces-24719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEF7A14F20
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 13:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D681889E6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D81FE47A;
	Fri, 17 Jan 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="U517Axio"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AE1FC7FF
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116737; cv=none; b=a+UfymBBTZsd/Y7ZyvJUg4UwtdoRVcEtBVSZ9WPkdYJtw4jXNfmJPK7FgK+3hz+OX/u1rFF/EwET5FAplonkWrv8O/FdejaQ+q7V805G/UfAwDqtYY4PDWozEXk1+KpTi0C6RgwLELcNlwTSQToxYUTGRVPE8oFX+9S0JHzggkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116737; c=relaxed/simple;
	bh=lGH/GhHfwi2oK/keQpe2m4py36JcMZvdK0bU1A1fGkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXMcDbbm7RLUzxTPFgKgvH+ob31knf41/3OkIaCFyPCOFCiHwrEbPs1wKF5QFtHzPQNLRjL8DLIUT+gHN2JaPa2IIW5bvm3uKP9QW0Np9ssCy6DE/SrrrzadhQRb3xw/OGi3b5PeU9SX6p3BAPltz0V0ek8KSRXxgbf+yycZ7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=U517Axio; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436202dd730so13428075e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737116734; x=1737721534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vesb6nRB4O5TK8ZWK7Xw3/thTweQDL/NKzYzRpM56B4=;
        b=U517AxiojYM3AOpzwRF3fHtvcFIkpG4yZ8bangL/xwH/ILftT3M7v6EafxcbvVFiyV
         chaIhVC6zJB6gzV0p2rxw6a+odjB9gpL2NQukcak1xwVJ/YiZTOMLoqL2wOaBQQo0jOF
         Tmnhhikk5tddo8sqQXDaSu7p1x6Ku9gYB0duUgvDDZ4YjyUsZXWwHuwzA8iBkfDHTwAG
         oSDe7MWaWvGry2f1yitKptXYu5ejptM3G1qjTWEi1mAe1aEc6XTS6I2mcmY56OKIm+UW
         hQ1jHvdTrgTe/29o7Q1AjMfex7XHgm0uPjddM9ulDJQtdLHpCRi+5Mfgec8kkhyoBxtr
         MjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737116734; x=1737721534;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vesb6nRB4O5TK8ZWK7Xw3/thTweQDL/NKzYzRpM56B4=;
        b=wT6p6lpGgKlDVH7ddH30Bn0P/OMCwzXY4MHOSMAP5wNWTabgfX7wHncE7r93pKuPq2
         bISY4U5uDtVj7J/O0+qLxx53PcXQXatcZpaNzga//+YCX/nA5sydv3Zi2p2Wd64PW/6x
         FkcamW932+ZGo2ZovjIYPWNzhkMC06XDAxzPvqtrmDcKRzLVOcAvuV4nGAsctCI6M89y
         U6058pvpBciZTN1gAwsgnuwVnqk3hGROIQSF8yIjc/rS7IoOEpQXh5ATlsrfU/PyZN1r
         QwAjudid3b3W7gXyakrOKtNXvZILMlgpWchwo6nHyCzFtW7/AHniQ10Si2sHKWpU76XB
         IU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkHR5EnQfPWWbnY1iaScEFw7g+e1Rl6G/8cuGKOiSvZ2+sgts75SW4PzDst3sajZBUHGoHm3KHyQ5WZ+tXKGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVh5ZQldZjOwY1Y2YZ0Xt4tayLsb+fX72vOvjxlDUqi3vAutc0
	VNXpC30ldgcGVypJFhFWscxfPrgTzCPYzj4Gd/ef+4IYbozLdv4JGeRCcQaa4h0=
X-Gm-Gg: ASbGnctaQ/lpqdmAHV4HNv8CYaZHMv2NisTE3oic0KlLoIHJXGpn1Wwjp4AaiHBzuZY
	BVn8bDg4nq+YZ34uRygS9XiDvDdB1z4f8GCVBXhwQtsGiByYfhkwVTBE5uF8IhHzekpW+Q0BgLO
	UyjXPxhZK59jvJ53oXxagbPo2SfIxA80BPdUWhaNVuwfl/VncZAsRg5vIkdTEXiRtG6DA82et8s
	crh/3vibMqY/YE/0a1H655XIDTUM+eOpAiKGrZSJGyK0gwkV8STq3LpPRv2FqJxMBgk2g4pSHnD
	0cHC99ZdE1gjqv08WiE=
X-Google-Smtp-Source: AGHT+IG8EVaB6FneV85A3hCwQvZ+HFS/LNXG3CBBbPSemfRdQ+Fo7Be9x98+dpo1HyT55obJIKFALA==
X-Received: by 2002:a05:600c:1f82:b0:436:fbe0:cebe with SMTP id 5b1f17b1804b1-43891452f6emr26438395e9.30.1737116734039;
        Fri, 17 Jan 2025 04:25:34 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:217f:1ce8:9888:d2ed? ([2001:67c:2fbc:1:217f:1ce8:9888:d2ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7525ee9sm91222785e9.32.2025.01.17.04.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 04:25:32 -0800 (PST)
Message-ID: <3c114fd0-4665-40ae-8a62-bbf69904e87f@openvpn.net>
Date: Fri, 17 Jan 2025 13:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 05/25] ovpn: introduce the ovpn_peer object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-5-1f00db9c2bd6@openvpn.net> <Z4pFyxhmBgKBA4-Z@hog>
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
In-Reply-To: <Z4pFyxhmBgKBA4-Z@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2025 12:58, Sabrina Dubroca wrote:
> 2025-01-13, 10:31:24 +0100, Antonio Quartulli wrote:
>> +static void ovpn_peer_release(struct ovpn_peer *peer)
>> +{
>> +	ovpn_bind_reset(peer, NULL);
>> +	netdev_put(peer->ovpn->dev, &peer->dev_tracker);
> 
> I think this needs to move after the call_rcu. Otherwise, module
> unload could proceed (no more ref on the last ovpn netdevice), not see
> any pending work in the final rcu_barrier of ovpn_cleanup, and finish
> unloading. Then when ovpn_peer_release_rcu gets called, it's not there
> anymore.

ACK

will move netdev_put after call_rcu.

> 
>> +	call_rcu(&peer->rcu, ovpn_peer_release_rcu);
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


