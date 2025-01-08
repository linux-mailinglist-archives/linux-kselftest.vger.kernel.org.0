Return-Path: <linux-kselftest+bounces-24050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B97A058C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 11:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7573A165049
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110A11F869A;
	Wed,  8 Jan 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PVEsKpeV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D91F8688
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333681; cv=none; b=q6tfaH/KYlAXPvQ68JY/5SnnL81Fq1AUIZOHEslaeZuXjBmhXcLlR/sRiZg9wq8MOMwaJPKh+rmDpOSjkh+pn9xsxXQPO4Af7zW4F3TpmrOEtasLV9uMPslgl7CeIampmsXJE7LkXlAQFGbyV4JwIqC1R6avZ6ZzV+taOp9N2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333681; c=relaxed/simple;
	bh=g6ZQhzF7mtGlfzZbczwKZXO6YJPH8GScrbpoWgLiVsc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Aspj4876OkBmGLpLaAO9309rSJHKYAtuHcRgN6xmIdFoxQ/mX368ptiJGoBqxAd2XLE/H0gOTW6s/BtCFkbFvJDM9i0NkYaT8lEO46WndqFMaQ5ZT5NPLTYNgp+nRx3vKGYXyafTbw/7WWQH/2KPN0Icr8YyBxxwzVYR6l6t6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PVEsKpeV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361c705434so119906795e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 02:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736333677; x=1736938477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkwxKCwTpAbrqB748510yxJKeafTORsRNcShxVPFWuA=;
        b=PVEsKpeVcfb+zH7zYJIGNQa+mscXFDvkUdJyxHK8bATRQfoj6UMQiGQSFXMtoc8lpA
         1Jlu76SrO2+uYE2ccaOv2S/teH+DguuYPuLa4hkk2+pG3774NnE4rXCCR0SBtMzzwLpe
         U6SE1mFlJuiTDtZAeXpreAbLUFYSbu3DAVYLTl5K9UgEblcs/6muP40wJ03LAnfstqCq
         f+hNrV/J0z7PYUt22aY35Z5jH7MUmcRbEFsWwYlf2c4qZotJ8xMFFC8xkCSSyrrjr4G6
         oe3L5YTOIBQagb7GOAE2H+PmV6TH/Keso2P0wKpyFAsABe9fk4rJSDg/zoC7AdN3pSZa
         pICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736333677; x=1736938477;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DkwxKCwTpAbrqB748510yxJKeafTORsRNcShxVPFWuA=;
        b=O/oftxw5ujZ1+3b+ROLQjLeesFPzyAcH37giVlcAV2hPC15rMz7mR8td6mekOcFCUO
         7l76CdZJ9PEVndqp8N+eUS3SvoYFMGrPGSP2/FwWORay1gh/W5riNR35j67elgk7+VmJ
         k3MatvMHXmFroanGF82ft0RIg3/1kxZeJ6tG/axOm58u7teSn4iKCpJcLdDjAaDs2LF2
         6xFm21IzLSw+sSlQhbHmDg3XsLFW7x4ukOhxN6Us0UKXEDdHJwH8PsKrl+CC0Ts2uNFZ
         0bfk/K1Hgzr7481s7GHrK3noGh5L8jSEjIGOaUj3XeVozcrlq61RWUneORUxa5CH5NuW
         ZiHw==
X-Forwarded-Encrypted: i=1; AJvYcCVasMgOUz0dlCYLRhBIRMfCd3ohlxAiFBXphBRH07OHz5y1cT0/uSGMuni4qGoYdH4Z1C//QMOqFTqfno/WAZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQ0G/uTjLzhx3ZLoIrTzmXf4aiLKBTIxjdqW8u9It3lY0TPzO
	OubFQzNShsUjTz6MVU43oYI83wMlA7hx4IIwxp8Cs4xF54G11Lq5SV8TXHmyDls=
X-Gm-Gg: ASbGncuwJE9HwEnZa/q99RXiVM5zsrN8RXG3nqDO26tJGgw5alfhPU9+Kp7CtZBnUAY
	Luo6rxHMgjxmZr7++2UJU7+nhR+SPHYZsGo5FiDjEA43SN0PaRSla1+fFVa/63k4ftxJLypOiZg
	mQPNDmPalN3NRwJMNAvAKq7D3RsAQlfSu2sqvohRv2MmDF5Pq1ylF9BAbnY4iyxD6qSmcc1Pkmz
	bGm+aPGWf0JjprwtmKN5i982D8yPePtab5BchuHBW5yEx3dnTjmZTlVJdLn0zCPSEK8qZMyqgoB
	YxSYrQiCGnpkaKXuAuY=
X-Google-Smtp-Source: AGHT+IFShLsq4++uwixYypmnEUHE4h0DqQHK3B1NS9l/FzEaQoxrCcw3MgQyZ1E4N0GFC1Owtmg1hw==
X-Received: by 2002:a05:600c:4f49:b0:435:194:3cdf with SMTP id 5b1f17b1804b1-436e26bd59amr18373225e9.19.1736333677070;
        Wed, 08 Jan 2025 02:54:37 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:cddc:656c:5e42:308a? ([2001:67c:2fbc:1:cddc:656c:5e42:308a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc12dasm16779275e9.10.2025.01.08.02.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 02:54:36 -0800 (PST)
Message-ID: <3a1349ac-acc2-4db5-a8e7-749cd471d3bc@openvpn.net>
Date: Wed, 8 Jan 2025 11:55:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 07/26] ovpn: introduce the ovpn_socket object
From: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 willemdebruijn.kernel@gmail.com
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
 <20241219-b4-ovpn-v16-7-3e3001153683@openvpn.net> <Z3gXs65jjYc-g2iw@hog>
 <9634a1e1-6cc4-45ef-89d8-30d0e50ba319@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <9634a1e1-6cc4-45ef-89d8-30d0e50ba319@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/01/2025 00:27, Antonio Quartulli wrote:
> Hi Sabrina,
> 
> On 03/01/2025 18:00, Sabrina Dubroca wrote:
>> Hello Antonio,
>>
>> 2024-12-19, 02:42:01 +0100, Antonio Quartulli wrote:
>>> +static void ovpn_socket_release_kref(struct kref *kref)
>>> +    __releases(sock->sock->sk)
>>> +{
>>> +    struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
>>> +                        refcount);
>>> +
>>
>> [extend with bits of patch 9]
>>>     /* UDP sockets are detached in this kref callback because
>>>      * we now know for sure that all concurrent users have
>>>      * finally gone (refcounter dropped to 0).
>>>      *
>>>      * Moreover, detachment is performed under lock to prevent
>>>      * a concurrent ovpn_socket_new() call with the same socket
>>>      * to find the socket still attached but with refcounter 0.
>>
>> I'm not convinced this really works, because ovpn_socket_new() doesn't
>> use the same lock. lock_sock and bh_lock_sock both "lock the socket"
>> in some sense, but they're not mutually exclusive (we talked about
>> that around the TCP patch).
> 
> You're right - but what prevents us from always using bh_lock_sock?
> 
>>
>> Are you fundamentally opposed to making attach permanent? ie, once
>> a UDP or TCP socket is assigned to an ovpn instance, it can't be
>> detached and reused. I think it would be safer, simpler, and likely
>> sufficient (I don't know openvpn much, but I don't see a use case for
>> moving a socket from one ovpn instance to another, or using it without
>> encap).
> 
> I hardly believe a socket will ever be moved to a different instance.
> There is no use case (and no userspace support) for that at the moment.

Actually, there might be situations where userspace may want to close 
and re-open the device, while keeping the original socket alive.

This means the socket should be able to be attached to a new device 
without being destroyed and re-opened again.

The refcount_dec with bh_lock_sock still seems to be the approach 
covering all cases, no?

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


