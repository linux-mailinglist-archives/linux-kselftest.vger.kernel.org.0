Return-Path: <linux-kselftest+bounces-22843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5449E482A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 23:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426CA1880447
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 22:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A01F1F542D;
	Wed,  4 Dec 2024 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PJMZgcOa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00371C3C13
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352728; cv=none; b=X/u66cvn+u6svUZ2g+JHGyGUx/Onc9+d235khwteOyZBkRypebxngroY0XahiJgt0cGVKZVo8JP4UmzJnlorYKmNu4eqaGBuTgDuteEUP4YQejJJRV9iNrnoEu4wqUxa+oUvUzTFovaK+JnfFZv3B0vbq2mku+Qi0Ij4SYc6Ro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352728; c=relaxed/simple;
	bh=BbpJCvn1MXnXbQgrGMkRVTBZLntlssDle2nhEWUHgOQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JfcHwXOlrIyhiFSkfPlOMLM7frqkLUaVPPEgnRonU4U6sR3ekzsWvs6+ixnN1cUc1x3dn8He8ZjaBwF7ztItbkRro1rBB3rxUima513oYV1qaaL0KUyryg9OZK65ZoS6a8lIp05KUYMEEwh2Jg7bUgqeyAzmzigd5C47pTUWg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PJMZgcOa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a95095efso8764145e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 14:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733352724; x=1733957524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJY4PGEWGLtki4js6cDocdleyzRKIiiLi+utb9IeRFw=;
        b=PJMZgcOaZa+nlhakIYl1e6CtGmQGbwC8CwDnKgkyU6NxtFMGIec8Q4kbjsXkG8HA5m
         mdm+Y0mhgJvJKWgsQuB0iKwa88irR9fdiMl1Jp71OJ3ClgJ1Q/Xu6WgcfnDQV0x6Z3+A
         FFxmeXID7XmTONVN4WPFa6WETx6nmYCK8Bxbcy6FsZ5xuiz4ZBJmlhOR7H5BU1Y5prZV
         C4updvjWN/3r8lasnhFORYfz3ZxOlB/Rbj5WNtLiY5TXQQ/BWtupDyieMKqfFfmO+xS4
         rE7MnogdtPEoHNRNrtw0cgdaAYE03byb9VVeAl84SZoL8Jq7Tox71nndKX0M4L5adATE
         X5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733352724; x=1733957524;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QJY4PGEWGLtki4js6cDocdleyzRKIiiLi+utb9IeRFw=;
        b=I82p3kn9iN7nbyNAX6DFEQNKOpWF9PYy0QWn4B8i3ONBDgt8xhiyGzNK/3aV44++V/
         2S2OkWW9nuEcnHwJzdF8I0O3sBBALHaOn+BOxuLNU1INMtxLDp8p5uTYwsX9qQ8oeP7w
         l490iBmSoBHNZ8zt9BicKTe9uTzjTWVIPggqkKDukRCcjO74B92h5M2FTx9/tXvUKIuc
         vIPX19HV9hya8rmLtao0OYAddI+T4Qz0TEnOMsl+A+naw3BdTQTNoA/Y7C4LDRI4H6wU
         diglGvEz7tGRqVJdrxmFn1S7fMh6kc9w1yvLhsPVPceFWg1VgU8dOPh+Dc5K1FPXaCX1
         gryg==
X-Forwarded-Encrypted: i=1; AJvYcCXCl3yg/+N8Pj8i5CGtdKz/a7Qge5woQrdVHPPqhYWiyKQbDM6SLV6TvGk3CbM7eQO2tJcY25OHmHykeuH4nO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHBhCg4uRxcpBwqX53OfQWUi3XlRZMKpSgMhXj7MkVZTPVce6
	5yVYI2ca4U2fVOgO/SAW4LxGq5NOzHg/02DZXJ9K7dbc2Ey4TMsh5Buy/tW8wrE=
X-Gm-Gg: ASbGncsM79hIL0ZmPs3mWStSB55uHSJJDQx+aTF2hn0lNMO0hI14tGxz7jDuvCCL/by
	QCK84rlr+t1Vky/arB+mK+jVoGLylAyKhhZY68uLZDKtH8hfchnO2mvtfOWG2ghBX9LuciEaazr
	mwglcrwXojYU8rrnES7PF2KpKJsZCax58AG41UiGPjbAJQMs34XafOWp6oVORZb/klEGDhXaBmb
	ynwc1SR7qFexywFhIyYuLUvxryXXxazhfn8NhyEyOCjOx7pE8Tbai9iz5P2hnjRceqPnlTSZ6GN
	f4opyO835/Bn
X-Google-Smtp-Source: AGHT+IGJvHmmwLo8TCWd+PrCzT2NE0wYUpSiiKV93ZLkT6NdCnrMxrorsSCHOXAsAtRXhafH20MZlw==
X-Received: by 2002:a05:600c:1c88:b0:434:9dcb:2f84 with SMTP id 5b1f17b1804b1-434d9253d19mr7729455e9.2.1733352724248;
        Wed, 04 Dec 2024 14:52:04 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:9715:a35f:73a4:7403? ([2001:67c:2fbc:1:9715:a35f:73a4:7403])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d43809fdsm25998785e9.1.2024.12.04.14.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 14:52:03 -0800 (PST)
Message-ID: <8714deae-c1f7-42ff-9e76-fabd9ca5188b@openvpn.net>
Date: Wed, 4 Dec 2024 23:52:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 11/22] ovpn: implement TCP transport
From: Antonio Quartulli <antonio@openvpn.net>
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-11-239ff733bf97@openvpn.net>
 <784fddc4-336c-4674-8277-c7cebea6b94f@redhat.com>
 <2a1b614c-c52d-44c7-8cb8-c68a8864508d@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <2a1b614c-c52d-44c7-8cb8-c68a8864508d@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Paolo,

On 04/12/2024 12:15, Antonio Quartulli wrote:
[...]
>>> +        mutex_lock(&tcp6_prot_mutex);
>>> +        if (!ovpn_tcp6_prot.recvmsg)
>>> +            ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops,
>>> +                          sock->sk->sk_prot,
>>> +                          sock->sk->sk_socket->ops);
>>> +        mutex_unlock(&tcp6_prot_mutex);
>>
>> This looks like an hack to avoid a build dependency on IPV6, I think the
>> explicit
> 
> I happily copied this approach from espintcp.c:espintcp_init_sk() :-D
> 
>>
>> #if IS_ENABLED(CONFIG_IPV6)
>>
>> at init time should be preferable

To get this done at init time I need inet6_stream_ops to be accessible, 
but it seems there is no EXPORT_SYMBOL() for this object.

However, I see that mptcp/protocol.c is happily accessing it.
Any clue how this is possible?

If I try to access it within ovpn I get the usual error:
ERROR: modpost: "inet6_stream_ops" [drivers/net/ovpn/ovpn.ko] undefined!

but mptcp compiles just fine.

Any hint?

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


