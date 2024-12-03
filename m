Return-Path: <linux-kselftest+bounces-22754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA49E2071
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 15:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC8828A42F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFFE1F76B3;
	Tue,  3 Dec 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UAfQXi/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08121F7564
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237862; cv=none; b=U5Gw1UiK4MznuJ6NpZbvmbH6TMJsqlS4NXPU/YZ8zrZxz7z7u1TwLDD3/MlBq3Jk/3xCAlVrC+fnoKfsPIU1AmxVBbcN/4cAgMNm7dypGXbCOe59Omtvx8wkPLJ8Z/N8NIc1I3wCMEb9tGgr7VxQDnmu20cZHWN7Uo6Wy1nZKBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237862; c=relaxed/simple;
	bh=4kaDNuHUFD4chxpEZLuFV8m6+PpKHOu1IP0wRoeVpSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2Gf8EndT4EBUXaoJZIHD0okgT5smv3ypc8mujpjuH70U6FZv5TN7KZfvu2aEgOdaRq1ffAX63QXKH/jh82SsodLXwQb402+abkh7i1VYRCH+vCGI8NKIv/pO1Jx1m8SLQc0M8rILPE59FjydAsU89hjXM9XaXU0cdFYKX48YNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UAfQXi/z; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa549d9dffdso903043166b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733237859; x=1733842659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EM5pCjC2cWoCVnQEQZytwK6ACL0xMoDExcO8DX1QkKw=;
        b=UAfQXi/zZtGdKrNigsY0mda+9yTzSBbyxqygMFDmTq+9u2mCjeF/iK2X6NWC2n5rfC
         gyzVf/DRF2F5Tw07tedg0eq+kdVWzNuduTKbqNlJafQUbR5hdq8h83g6sMZBxDhTWtSU
         TOtqLMxWLKfHMT1s7NzZanuCnlNZ37TP1VFgetmw6F025Wjk3qoqR0VAwfAgfUOVfdhB
         4Hpn7hNs9wHtWnPS9vDfAyXkgZkbYzPEMk9MQ/1W+nnJowVg/NsqD7bnEfn2wG0hC37w
         Wu/YZcOBexPsQwQ20Pr0y5zmhd/KPegjTc+SszT9fi9Jhq/+fqoddQKuNsHCVm3vmRhY
         vhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237859; x=1733842659;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM5pCjC2cWoCVnQEQZytwK6ACL0xMoDExcO8DX1QkKw=;
        b=Lob73IKskuWgwkk60rfYdxdIG1kPIC8RXTPqcAtl38C1/3T8XpXLDRV8n7YJjt3ZlK
         os+GxknqXgwZgBJ0h0xjh7OOopDf8zsvu8AEoNOucV2iCo5m6WQhdJs/ozegBBhQY1/B
         Jgcx4xvBSZmaxnMcUi/UO9HEkHcY2Anh06WanjVltC2ACOv5GU/cMM5GC634hooXK3Gz
         v7VYQZ1tnroB/TJ0vfwg9IvAePVHCf073XKlJkjmbSiOwpQqMVYTFAPFN7/0B2ugGXc2
         1Jst5XLxk/zIwHRp0DdYea/cwe90qMm3+92JOlj3/DkN0CUa1uqMCmRgh+Zq02bjogUu
         hKlg==
X-Forwarded-Encrypted: i=1; AJvYcCWHG7GzuGvW4L39lhLdKKuzqPn+3EqVRiq7CE2tSsnFMcIaIotBPsYh5hJnVAt62nzpeswNAhfdQOHhmn2NnuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/GUaWN9/Tq43c/2G5uqeo5kkdZjm6VKf59vSb9zDUgtlEv6i
	bCRA1fo8vBni19re+sg0judTesZfN+GEmEbnxvfgiXYQxOJRFrSWhoWnIpRE4CI=
X-Gm-Gg: ASbGncuLSbDatMim9nWrNACZWEKLZOivTJTiXMK8XZagNYJThazjvIuQPByZATaU5Ou
	Pqtu/cpuWXMGApfn0A45aCT7EzKAjQkLhzIs3jpXoFgd1nxZe3J31pCPgHUd3at63JAaES2TBAF
	VWWBnJIvDKQorlx6PfHjyhxoDbqDal3TzzAIC2G90kXzGrOEkFriqTew0MKWVuA+V7pSfPjWZWi
	nZK7erPi3nEc2ixZukTNN9SU8iFWTWDJB52aumyawLuOBG0i03w21BoggVMV8xNPHeu8iKgWWyb
	IOohyBIf8hJu
X-Google-Smtp-Source: AGHT+IFm3HTymLpkzHDlJwTdEhqSNPjIwD18EjPQJ7jfnb/TpAAhZxzdIq/8jT2SyS2gFyft4tUmMA==
X-Received: by 2002:a17:906:23ea:b0:a99:5466:2556 with SMTP id a640c23a62f3a-aa5f7f6e957mr195026266b.61.1733237859165;
        Tue, 03 Dec 2024 06:57:39 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:138c:c1e3:75bf:72b5? ([2001:67c:2fbc:1:138c:c1e3:75bf:72b5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c13e7sm617609566b.18.2024.12.03.06.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:57:38 -0800 (PST)
Message-ID: <5052453b-edd8-44e2-8df7-00ea439805ad@openvpn.net>
Date: Tue, 3 Dec 2024 15:58:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 13/22] ovpn: implement peer lookup logic
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 sd@queasysnail.net, ryazanov.s.a@gmail.com
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-13-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20241202-b4-ovpn-v12-13-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 16:07, Antonio Quartulli wrote:
[...]
> +#define ovpn_get_hash_slot(_key, _key_len, _tbl) ({	\
> +	typeof(_tbl) *__tbl = &(_tbl);			\
> +	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl);	\
> +})
> +
> +#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
> +	typeof(_tbl) *__tbl = &(_tbl);				\
> +	&(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];	\
> +})

clang a reporting various warnings like this:

../drivers/net/ovpn/peer.c:406:9: warning: variable '__tbl' is 
uninitialized when used within its own initialization [-Wuninitialized]
   406 |         head = ovpn_get_hash_head(ovpn->peers->by_id, &peer_id,
       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   407 |                                   sizeof(peer_id));
       |                                   ~~~~~~~~~~~~~~~~
../drivers/net/ovpn/peer.c:179:48: note: expanded from macro 
'ovpn_get_hash_head'
   179 |         &(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];  \
       |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
../drivers/net/ovpn/peer.c:173:26: note: expanded from macro 
'ovpn_get_hash_slot'
   173 |         typeof(_tbl) *__tbl = &(_tbl);                  \
       |                       ~~~~~     ^~~~

Anybody willing to help me understand this issue?

I have troubles figuring out how __tbl is being used uninitialized.
I wonder if the parameters naming is fooling clang (or me) somehow.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


