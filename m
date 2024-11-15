Return-Path: <linux-kselftest+bounces-22097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73099CE198
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D243B32EB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D141CDA3F;
	Fri, 15 Nov 2024 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QXfnUNPK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0503A1CDA01
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679397; cv=none; b=pVbbpe6B8AUph1NPdr9M0Ldc/KgwP9pmkaAYuPheVNpzx5R6DSZEE5fflxlE7QOwZj5prgiNGcij3Gvj4m/+J9kOmXGO7hz9GI0g5ibEN+pkNOhd4yviLinmd9yyG6mnvzDkCBPB9imdHQrdI+2aWTDaMKdP3uph3Z4Gey3mXcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679397; c=relaxed/simple;
	bh=X1T8wraN2eMRNwe5jMMjTPx47E1bLjvbYuInztUsI7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVKtVDJo7fHjspGqlrwZrEmOKcJmbOlCWtF8RPP3ismsyUkJF7ZOMnSBBQ1LNivZ4etbffUZAAJXTgYPLHJWQ27WG/xFimnOdYwssHlHZnLq7fbSbuHAXbdmDEyqP1APHlCCw2IjTFqjHDo87V00XHnDd9u+oPJ8GD+fBbJ8HOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QXfnUNPK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so14856615e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 06:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731679393; x=1732284193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LDf3BEF4GlxnlNsEIrC/wd3fcakFTZQ9c2XGiIKelJs=;
        b=QXfnUNPK7thv3NCnGrjw4v7kfWNgsCwiCDgSDjdcDXc6tj6xvwXJb0DEmyXOXcQPk1
         OtKqCxAU41nH3Ae4btHiuZpw4LfFXTNWqj+Rtrta9rzOALmauxXsOTk7EB09lfKkjmqI
         7NRwnFAnFsXQ13PK2z4Hv6ST4sYgeu49qDNWyETPMOYWnTQe2NvUykKOyBzyQEg7Z6GU
         o2zCh3LnhLv2V2ibaraFm6e4hjCjHFwHLyHM9VrGMtxHLliA51Mch1Erqqm5rVHUE3+y
         peZx5PhYyK2fHWQP+mwxxCJvX1a9kgStfZF6fBFuseU12rdJ9Yv79jUWq4lNBUy10lrW
         nlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679393; x=1732284193;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDf3BEF4GlxnlNsEIrC/wd3fcakFTZQ9c2XGiIKelJs=;
        b=vdCtB8GivKqjHIhm8BMLcJjGsASP4fqZ8hA9wfy+NV5y/zFYXm6WItpgyrtThGLUfX
         OMr/4fAuTDYdocuOEH0oT+xJsef8JeJ4dNCjazh2+VWquVO4bN+RR4inFLC2Ejv79BA7
         P4Fw5r49mW8MVAVV9fujWTc9HGN3zzH08OVr4BRjk2bV7DyBTUc9hrmB9Tabt9wvnGT9
         P0pmTHaW30zj+q/vHESrt9NNE2Osjq4V5wMPFVRwh14AVP5Y/IioMX+T7rnNtdX6Fi2F
         I3V/CXiIC03WXpvlszaJZZC5+WY5yO3M4Qd35GjOaQZlsfX5zCV7CLHNd9LkhFbJBI/D
         UkSg==
X-Forwarded-Encrypted: i=1; AJvYcCV3fkZ+O3rIcEbxp8Io55bhmgXLjMBsLFQOENLAUO2OokYypItIGLsi/v/aBipVWPQOl0iVug97+sH1XmqR4k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWy/TNWgYQIuT4al6LZOZBVcQjOxP79n39PSfUDQKXQyxReNTl
	/pulVQXgXPYWIQV6B6h63dyaZKz7iJwND5Guk3SqXFiV3r3/KiAybfG/XXf3Oh4=
X-Google-Smtp-Source: AGHT+IHqNxl/PqPOrkOUxytfmaFDHh+UynAqP1J2BIQcXgYcJU7TpbsQsZp/fdNMWHE7Oc/oWN+78g==
X-Received: by 2002:a05:600c:3b03:b0:431:6083:cd2a with SMTP id 5b1f17b1804b1-432df74ba87mr24944155e9.15.1731679392600;
        Fri, 15 Nov 2024 06:03:12 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe68sm59253115e9.24.2024.11.15.06.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:03:12 -0800 (PST)
Message-ID: <0f19828c-9808-427f-b620-fd3bc9f2e5db@openvpn.net>
Date: Fri, 15 Nov 2024 15:03:37 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
 <4b6f2e30-5e94-475d-97ec-d59e59f0bf6b@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <4b6f2e30-5e94-475d-97ec-d59e59f0bf6b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/2024 21:42, Sergey Ryazanov wrote:
> Missed the most essential note regarding this patch :)
> 
> On 29.10.2024 12:47, Antonio Quartulli wrote:
>> +static int ovpn_net_open(struct net_device *dev)
>> +{
>> +    netif_tx_start_all_queues(dev);
>> +    return 0;
>> +}
>> +
>> +static int ovpn_net_stop(struct net_device *dev)
>> +{
>> +    netif_tx_stop_all_queues(dev);
> 
> Here we stop a user generated traffic in downlink. Shall we take care 
> about other kinds of traffic: keepalive, uplink?

Keepalive is "metadata" and should continue to flow, regardless of 
whether the user interface is brought down.

Uplink traffic directed to *this* device should just be dropped at 
delivery time.

Incoming traffic directed to other peers will continue to work.

> 
> I believe we should remove all the peers here or at least stop the 
> keepalive generation. But peers removing is better since 
> administratively down is administratively down, meaning user expected 
> full traffic stop in any direction. And even if we only stop the 
> keepalive generation then peer(s) anyway will destroy the tunnel on 
> their side.

Uhm, I don't think the user expects all "protocol" traffic (and client 
to client) to stop by simply bringing down the interface.

> 
> This way we even should not care about peers removing on the device 
> unregistering. What do you think?

I think you are now mixing data plane and control plane.

The fact that the user is stopping payload traffic does not imply we 
want to stop the VPN.
The user may just be doing something with the interface (and on an MP 
node client-to-client traffic will still continue to flow).

This would also be a non-negligible (and user faving) change in 
behaviour compared to the current openvpn implementation.

Thanks for your input though, I can imagine coming from different angles 
things may look not the same.


Regards,


> 
>> +    return 0;
>> +}

-- 
Antonio Quartulli
OpenVPN Inc.


