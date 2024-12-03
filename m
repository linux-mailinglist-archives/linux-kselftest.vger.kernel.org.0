Return-Path: <linux-kselftest+bounces-22756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249879E20C8
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92E9284FA3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204711F130E;
	Tue,  3 Dec 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aLeULJb6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA251F706C
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238218; cv=none; b=r7WeewTyw1DmOxw4fE5sdugCcz6z2GB2s4+6aip/RQvq70d8+Cy9p4p299+y/HU9qVjGW68gM9q5w0U+kxeFptcnm3K1uk3UxW1YjSz/o9NPRnlkdxjeDgr8OfFKAMbSSJIf4WRsV2OJy2tWoXF3Cx8yHomZ/0qRY8ZsB2ghatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238218; c=relaxed/simple;
	bh=Y+Nv76JuimdwOlgZdxhPKuAZhbr3eXr/RrZVVR1Jszc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dd8d1G68DXXzH0i7U/TQAN1vbHZy7JD3v1ppaFM9mP7xWTK3ohX8rCuccfLOH9imlcH8edeQyqKo0mdW0yCEUqIU1RiMoEP9zBNMkGlewSs8qvyaSbjhHlFYb51r5EFhRvCsU8DHHgy10CTTtIbxshHdd2E2Ht1lZQ0qIdl2A6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aLeULJb6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385eed29d7fso1770440f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 07:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733238214; x=1733843014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UUc2U6b8AsvwMKbUGdD9RXYUFtONNeSR6k1MPBCihcM=;
        b=aLeULJb6Bgh7WyL+VeFoJp9l0qCJsv7OvahlhAXcQhy37SJoRHTblnXpqdcbTzvXbe
         Zmae/ZNIenjrvbN1IjPrW6ifBMReqXde1eCzHfP8/ga8CDFU1Y148BTarBJjqs5ofCsK
         2DhP4k8t1KV0qmgSlkzGOoXz1IYwxYo4mi4GAO+WU5Khzl4Tx4jb/onJkAgvOQH5sygU
         aYdy6zjUxoGzSPuzBbH3QI6TgheVHBYM32yJbdvYSdQCb81ZcuUkKbi5p+3cd3XjfESQ
         SlWHGBewuXdqrpRH8C9F5kl5/0UJ+3tXWQ/Ln7RgMHzco+xH+vo5HbmDRo98XufHC8N5
         9mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238214; x=1733843014;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUc2U6b8AsvwMKbUGdD9RXYUFtONNeSR6k1MPBCihcM=;
        b=gU4c9dKIJEzlZvEnSAqLc10XAr4hGhlS3jRidczcATEsgcNkdqSC4zxhTz3lz2dBHE
         O3qXcRTO3G9Ox72Suqx1TznRRbdw82AFvY1AYE+58vt3/gTsrdj54SPiNkai8LV6qHr0
         fu5A0wQmWeW9WYcNXJ/qkvfC5Pu7YfkgSSiAdkkOeTuEzd0vlLLCIOm6Dz8PdNgXPdsS
         9nzfDUQ0PjVGAXalfgi7RyaQFEvglpJ8w4uwoaw1k55H/R+vIEBnvXlEtcWZLXAvtLl7
         IFYnauAgS3bAvYFnwP/yFKoHqQuv48Q9kAw2TdNXmPwxFqzR/+sWnmsYTtXeJ0kM6MKT
         o7KA==
X-Forwarded-Encrypted: i=1; AJvYcCWx6tFq8ZXShAbXYP+Fcc96bPN+9PUrUcloe35E1SH6nwTmp1JPQH5wHzkn+dzUVWfvl9ZbHhA6MPztbL3kH+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYvzDjRAfB5nUkgO4/rjVpLv057UQx23CmyYI5Tzt1NhefO7Z
	rFHqr8ZKLTVZB2Xx2/sDozSaEn8z5i0IE9YYU1spyVfqIvBUb0ksEt+DT0e+kNZseojx76ioK9q
	3
X-Gm-Gg: ASbGnctqVaDYF2m8g34CuSI8mOss4o48oUX058ZgpwNVCDzn5+FDMPwrxpkqQCnrM/j
	HH2MsY4Blw5HaIhmY88DyM+oCMkaH7p2I/qg9RViVp77T5oVuNTG4Tmians+fsihPyN+C5UtqXq
	UQESGiXbTvZzfCkXBLZTSYsK2p0eQIJIRhPnBd2Q/d2dlCY5qQa95OlMv/0GFWbS9cca19j/PQM
	SFMoc/Qw5EvtkrSqmxUeYugoibu66wgzCN35TtaVwbmDSqEKz0CBJqVognHGRwHWe8Y+3C6Slwd
	f8iu00ePcvTJ
X-Google-Smtp-Source: AGHT+IGX4qlJajenQzrAt/pIuQUZzcr+mvo9oyzKhTai61NwFS1z9iEGZQMMyKzVXX2SQcLM+nGCGw==
X-Received: by 2002:a5d:5c05:0:b0:385:d7f9:f15f with SMTP id ffacd0b85a97d-385d7f9f229mr18702317f8f.19.1733238213983;
        Tue, 03 Dec 2024 07:03:33 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:138c:c1e3:75bf:72b5? ([2001:67c:2fbc:1:138c:c1e3:75bf:72b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa76b52bsm224254745e9.18.2024.12.03.07.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 07:03:33 -0800 (PST)
Message-ID: <943b6994-f87b-4e8b-a5ff-3f6680070cc4@openvpn.net>
Date: Tue, 3 Dec 2024 16:04:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 09/22] ovpn: implement packet processing
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-9-239ff733bf97@openvpn.net>
 <d3d942c0-ceed-484f-8f2a-28abbdd132aa@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <d3d942c0-ceed-484f-8f2a-28abbdd132aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 15:58, Paolo Abeni wrote:
> On 12/2/24 16:07, Antonio Quartulli wrote:
>> @@ -286,6 +292,31 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
>>   	return peer;
>>   }
>>   
>> +/**
>> + * ovpn_peer_check_by_src - check that skb source is routed via peer
>> + * @ovpn: the openvpn instance to search
>> + * @skb: the packet to extract source address from
>> + * @peer: the peer to check against the source address
>> + *
>> + * Return: true if the peer is matching or false otherwise
>> + */
>> +bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
>> +			    struct ovpn_peer *peer)
>> +{
>> +	bool match = false;
>> +
>> +	if (ovpn->mode == OVPN_MODE_P2P) {
>> +		/* in P2P mode, no matter the destination, packets are always
>> +		 * sent to the single peer listening on the other side
>> +		 */
>> +		rcu_read_lock();
>> +		match = (peer == rcu_dereference(ovpn->peer));
>> +		rcu_read_unlock();
> 
> Here you are not dereferencing ovpn->peer, so you can use
> rcu_access_pointer() instead and avoid the rcu_read_lock/unlock() pair.

I see - thanks for pointing this out!
Will switch to rcu_access_pointer().

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


