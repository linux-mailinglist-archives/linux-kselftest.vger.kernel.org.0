Return-Path: <linux-kselftest+bounces-26585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D253A34E95
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 20:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0523A2B31
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44412245AFF;
	Thu, 13 Feb 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TO9C96gR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F31411DE
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476011; cv=none; b=cE/UCq2XzTk7qB+d9hvF5O4W2RuhRvfuNjK0M7sqXitaTGW69sF6fSwcltqy8rD1sTxM1OpYem7MzdgoJn4tvI0f+uXqjlNfEiKAW4Q+iu9flt4HXv2N86sayk3k4Lb3jfeJ4pDrT9+x/jazXGygHqwKxnIWzAWGMwWZ66Uu00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476011; c=relaxed/simple;
	bh=TPLaz7zjy3zkE2OPYHHcRx0GOTQvu1hBDURDHpSWk/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNed53JMexVpMkEiB4tngJXEQTYPLXt1cfXzbRfgQHPzhNbxBRWby+EDtGEdtDdSkDzxjYmfYt1yMXzsgSzIj1KFro1FjSnrezZtuWSujY2XqHWCjWFtnV8DHGI/EOEUAdoWtyser/Y+99M1L544BWc7z+y5Zl8uZohGHpq9nCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TO9C96gR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38ddfee3ba9so998501f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 11:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739476007; x=1740080807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkHXqpDyF1cQnu6X6Y845W/JOuPpcf7g2ixUcfTTjag=;
        b=TO9C96gRtUYo5YF4nBbJgoZ3eKqwdCjOL5/doYPMTSYMF7GdUaj3hsNF3Jw0Yoq7Dg
         Jp72uMPHR7CUO+uVplAvSXfyaSImHcABC4LpUr/q4So1aym/zQQ5ZpyhyhCQkb1tEWSE
         cgxdyAQcDExanHJVpwL0jfhpY/Nh7wRyb/oWp5746LhCiWctBAcPP9eN4Sxim0F3OiNV
         HQFULy//2FrYOixV//zjbEdEeZvwwwdNoSUpCONKL/crDaCXT+YOyj6rbe4EZxpGi+8k
         EzziwkG28O0DfiKUcth9GvCeMFfU41AbcdOsUhsaMv8ZLpdDH6cQpMZpHFwJDpgvcrfn
         bCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739476007; x=1740080807;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkHXqpDyF1cQnu6X6Y845W/JOuPpcf7g2ixUcfTTjag=;
        b=ublGjPb3ejsmpk6CVn1hBZM9yx49jwi8av3M2YzwO9nZoITMaMorc57ntlYOpGbbSc
         aAHXeJjZ4JAIfQVT+H3zmSNKeY55h3/koEnn7nK1EgRWTe3afbeklCL3O0rFD3TfdMFn
         xEUZxspCZ4+/y/tczeJ9fW1CMbofK73AwqnoohOGJxAicqCRIfNxGF/E2UjIU2rfl/Gh
         V33fQXw32l2UgK7iCYxcn7516bb3QQb16oBIG5y52ESK2N8vRbaMUFqsdt4+er9X9tzz
         7xUCz2zPk0WRKCQOrqyPmguSMl/m7ubaGuWpWOcqTKREHVpb/1C83mwBH6wYLH8YTMV6
         44vg==
X-Forwarded-Encrypted: i=1; AJvYcCX/5hdjiZXt4uqYGg7KCVfGC3A3JTBEyum1aOfkTGlDn7xKdDwXobfk4X09Nk81mOWBmd7JB0U78VsUwVUFTh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoNhjoEFfjfprmoClAHQsPZ+UvqKz4JZiaGV8iXRNaK/J7/Buf
	CKlDuCAaClZ6yPB3fXeLmPvf5pgu1uolmBugevpnEZqOAhXwCsL48FoSIaDrW+8=
X-Gm-Gg: ASbGncvIPNq9B/3jqzoJvt3IPxTfywnXjo45F8DxcpsNom4tA2F9ByiiARkWrYyrDmy
	hYL0llv3483hw2SAPIpMvdPDCZIb8aM2UGTAoBUe3D3kEd8srL0LhcgJkUuSGYND0hI4ZLxA9Rk
	mnBGNkzXhZRCHI3eWdhK7P8dCsJWZEcFtl+OauI8myoQD6s90I9K1vQd6WhhdPBonZe18Cd9l+m
	nXwR4UCE6ZG6S8PQod/wT91COglRIdZwRCww7DQ52Enp81Yt+tOEm+crLI+vgsgno1/yNVz15mL
	X0IfVNg4Aj8TdSZHviKvdM0QF/yjd63+gq8dBUZcHK5pqxQMWpTBhg==
X-Google-Smtp-Source: AGHT+IFbRfm/q+D5e5B9OtzP7lF9wXMiYrSTURLmazKapx5hCkJN5kLnPkTh6Is/FD24ZaN+9zmCaQ==
X-Received: by 2002:a05:6000:4027:b0:38d:e401:fd50 with SMTP id ffacd0b85a97d-38dea25a83dmr8676740f8f.6.1739476007347;
        Thu, 13 Feb 2025 11:46:47 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:8ed1:f279:ecc1:ee2e? ([2001:67c:2fbc:1:8ed1:f279:ecc1:ee2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc50sm2733861f8f.34.2025.02.13.11.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:46:46 -0800 (PST)
Message-ID: <558dd7fd-bd6e-464e-8dd2-e211956edc99@openvpn.net>
Date: Thu, 13 Feb 2025 20:46:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 00/26] Introducing OpenVPN Data Channel
 Offload
To: Sean Anderson <seanga2@gmail.com>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
 <2dc054c7-c596-b283-b26a-86c52e48efe0@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <2dc054c7-c596-b283-b26a-86c52e48efe0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

On 13/02/2025 15:26, Sean Anderson wrote:
> Hi Antonio,
> 
> On 2/10/25 19:39, Antonio Quartulli wrote:
>> NOTE: TCP tests are still showing the following warning while running
>> iperf.
>> I have analysed the report several times, but it definitely looks like
>> a false positive to me, so nothing to worry about.
>>
>> Basically the lockdep engine gets confused thinking that we are
>> acquiring the lock twice on the same sock, but actually:
>> 1) the kernel is first locking the 'iperf' (user) TCP socket;
>> 2) ovpn is later locking the underlying TCP trasport socket.
>>
>> So there is NO risk of deadlock (and indeed nothing hangs), but I
>> couldn't find a way to make the warning go away.
> 
> I think you can use a "nested" lock to avoid this. See e.g. commit
> 86a41ea9fd79 ("l2tp: fix lockdep splat") for an example.

Thanks a lot for this pointer.
By reading the commit message it seems I am hitting the very same "issue".

I will try to port the same solution to ovpn then :)

Thanks again!

Regards,

> 
> --Sean
> 
> [1] https://www.kernel.org/doc/html/latest/locking/lockdep- 
> design.html#exception-nested-data-dependencies-leading-to-nested-locking

-- 
Antonio Quartulli
OpenVPN Inc.


