Return-Path: <linux-kselftest+bounces-29722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C584BA6E72B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 00:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC863B895C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854211DF98C;
	Mon, 24 Mar 2025 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XFNswi0h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505562AEF1
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742858155; cv=none; b=M7B/S4EBOY5mrfJUWZ5bDWvTv0lpyIDlNWwTinPfnZ9s477WNtQiVv+HDVquXzEFkPxjwBT52UxT4nuSnYSS6TTRQfdpX/MamLvko/MY4DG4mM3n3vze2SYxSFqPPdsxdfNg9RESb5Ch4llxqNXade3NCguua5rTrv+5uPIgSBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742858155; c=relaxed/simple;
	bh=GO1ebrwdo1FSnwAlc77xXljzTyj9DumIqG0Jkgk/tts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRzQdfv0V42u5b9V6DTI8CLU+ZWEVVYAdfrOYHG1Ur1VvmInM7fJs60608NhZJ7BpqiosARz7MOskfMF8/g9RMskHiJWrvEkNnIrqWjk8EYIBxeqxsxacrKjHoxkap3dfwBQ7pYTtwCC0S7NdjXHVgBbtuGAHofG/kA/dn4LNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XFNswi0h; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so8816603a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 16:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742858151; x=1743462951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AgmGWXv0jfr3GGGkNjNS9jTuUghBVCf1z+AneBJm0qw=;
        b=XFNswi0hf96Tq8rtuwMpIDOv6lUZUk4nDhOm+EsRRaYPRlWs0nuuvHj5IHpug8kYcm
         0R2xZOH4zU0IzHP+wTCmpOo0RWV1DZa/TTvJh6/Ni3o8sg6NA9vRNq3aNDQY9zcvdqrg
         oCx5HGOd93n62bEUMp+fdA6EViq3rm6b/IXHPAc4FgMERza4wHDDYUbc8L7XUEiRMfb/
         EdyQRrih9lS35T8s12imovs3HY55rfx7RI7emSk5a2ax3/JWw4F8yEArMMhqNZ3adj95
         ssqKQBw7mwCVutDvh8rdK1BrpelPyFoPW9e3QyWkpBdDXNdAmGBkV0VTV1wn1BE4fU6t
         qJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742858151; x=1743462951;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgmGWXv0jfr3GGGkNjNS9jTuUghBVCf1z+AneBJm0qw=;
        b=UhqI+ItwXxQrcAVyzeT1drhILOc8ZlbB4vhJ11/YW8x66cRJGJ7mUzNdjrk7kgOn+L
         8sl4A+vd9vN+mZTu5QLZw5V0oi0IQyK4vWf3+9sF7aF1WsTCEBCEYaCf0JuRvbmZIrw0
         OWg9XSAUUs2j6+384Ki5nKWuKY7GGiO95b/qpvwrTgTG8ANaeSqe2yPRQZTnJ5NRlvx7
         qcG3piDy2VWCWtt3ynKf9fL3INbH/uyqzukTplDEohnT2/1hNIsxmk5tt1bdUuQlGjgG
         kkZSRYXikLIPDSeiEZ/BxsQCt2ZruIk6KsLHhreV17+z7StH3/H747nrg82C41lKFIOB
         142Q==
X-Forwarded-Encrypted: i=1; AJvYcCXj1g2irEK5WmzylCGsY2fUoALtZbL0/s/Zfhzfvu7rmMTCUVB/hqPq182wyyVmYKQXUbzjDH5sd26D/OU5gtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJYI0G+3UF2G9cxvlwHfhruzLFRVwn8wfOh1XSNjVDINvcTpBh
	u0GAOUmEDBrwdOfGoAZMoghejFniMqoYnoK4oqAEwMRIqk9FdTXavslkkF5Z+mk56xpYCCd4kuP
	e5OGVfZYBeo81nhSjgFT1A6tjwbnWnxT7GsyCv0my3FuTqtl93AMxjWLkWQg=
X-Gm-Gg: ASbGncubTTLnZyWgICFT3P84gWql7O+WPcjb+KD/i0qfX9vwkQCCYWG3eyyQsbRlRDS
	2Fa97O0Jml/hSIPqUkNs3t3PLf0hZ2nN3JDO7fDm2NF69sXbNfgBfcRUjwud0Sq1z5pxiNbODuZ
	XdR3BWlw7dut6Vsg8wp6eXADDTP6OdEC+I72Uzz9N1dBtX5djG+Ng50BmiW/JV1u3j+Eywq6/aO
	ePn1di9RmeVtsoYMcVKYtPLOUBPLCDi6IGabZpbjxBv95SisKs6FWYL2XBxkKI1lNm0CaEffLn5
	kzA3PR60HAlITI2UsqES3p/QLOOXbxFctYLrjT23dqX8+XAQeujxWSzr5MKbJAzMt8lwL9+Coa/
	zYaQG6WJgJJDN+aS+mQ==
X-Google-Smtp-Source: AGHT+IEt17iZNpdcR6SgMxLlZ4A8lGTl/ZXe0zo6nF6crB1UEU2qqCrAEPEV0yeB8qVk2vqUoQE1qw==
X-Received: by 2002:a05:6402:2355:b0:5e5:bdfe:6bfb with SMTP id 4fb4d7f45d1cf-5ebcd467233mr13717191a12.16.1742858151435;
        Mon, 24 Mar 2025 16:15:51 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:a58e:e6d3:e372:ec08? ([2001:67c:2fbc:1:a58e:e6d3:e372:ec08])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0e040dsm6680087a12.72.2025.03.24.16.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 16:15:51 -0700 (PDT)
Message-ID: <86fea40c-6b8b-4ac3-bb14-4a24c63cf167@openvpn.net>
Date: Tue, 25 Mar 2025 00:15:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v24 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-18-3ec4ab5c4a77@openvpn.net> <Z-E4i587M54Os5Yo@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z-E4i587M54Os5Yo@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/03/2025 11:48, Sabrina Dubroca wrote:
> Hello Antonio,
> 
> A few questions wrt the API:
> 
> 2025-03-18, 02:40:53 +0100, Antonio Quartulli wrote:
>> +static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
>> +					 struct sockaddr_storage *ss)
>> +{
>> +	struct sockaddr_in6 *sin6;
>> +	struct sockaddr_in *sin;
>> +	struct in6_addr *in6;
>> +	__be16 port = 0;
>> +	__be32 *in;
>> +
>> +	ss->ss_family = AF_UNSPEC;
>> +
>> +	if (attrs[OVPN_A_PEER_REMOTE_PORT])
>> +		port = nla_get_be16(attrs[OVPN_A_PEER_REMOTE_PORT]);
> 
> What's the expected behavior if REMOTE_PORT isn't provided? We'll send
> packets do port 0 (which I'm guessing will get dropped on the other
> side) until we get a message from the peer and float sets the correct
> port/address?

I have never seen a packet going out with port 0 :)
But being dropped is most likely what's going to happen.

I'd say this is not something that we expect the user to do:
if the remote address if specified, the user should specify a non-zero 
port too.

We could add a check to ensure that a port is always specified if the 
remote address is there too, just to avoid the user to shoot himself in 
the foot.
But we expect the user to pass an addr:port where the peer is listening 
to (and that can't be a 0 port).

> 
> 
>> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
>> +			       struct nlattr **attrs)
>> +{
> [...]
>> +	/* when setting the keepalive, both parameters have to be configured */
>> +	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
>> +	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
>> +		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
>> +		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
>> +		ovpn_peer_keepalive_set(peer, interv, timeout);
> 
> Should we interpret OVPN_A_PEER_KEEPALIVE_INTERVAL = 0 &&
> OVPN_A_PEER_KEEPALIVE_TIMEOUT == 0 as "disable keepalive/timeout" on
> an active peer?  And maybe "one set to 0, the other set to some
> non-zero value" as invalid?  Setting either value to 0 doesn't seem
> very useful (timeout = 0 will probably kill the peer immediately, and
> I suspect interval = 0 would be quite spammy).
> 

Considering "0" as "disable keepalive" is the current intention.

In ovpn_peer_keepalive_work_single() you can see that if either one if 
0, we just skip the peer:

1217         /* we expect both timers to be configured at the same time,
1218          * therefore bail out if either is not set
1219          */
1220         if (!peer->keepalive_timeout || !peer->keepalive_interval) {
1221                 spin_unlock_bh(&peer->lock);
1222                 return 0;
1223         }

does it make sense?

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


