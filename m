Return-Path: <linux-kselftest+bounces-22422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B59D54CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 22:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604451F2311E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71421D79BE;
	Thu, 21 Nov 2024 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PrNP4eLK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA412FB1B
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 21:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224954; cv=none; b=XSqCocErUU7A7KHYrAVzIZrK+m9NTdE9HRR+RKPk5KP9dG0Mx+reH97IgjW2SBWS2x1WkvSMSD0virTEFiW0SQQVctNgYq9f37nvdbmmAiIxB8m8AWIHfLWQ+otEy3P7tQq1P96KPkrq42+UuthwONDQFe6f0Q/xqs4ng77Yd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224954; c=relaxed/simple;
	bh=vc2QHq+XPJAyik3NBvz8UxJoTwJdxefiF569McE2BTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLqlB0nhDlV6zEdkhmHyUcEGPewrTtLgvwvanQFM0ktpSPj9QqwxEf9eta83NiB5hPHvUbDU12dIr5UzNL4czOOtYtmD3ESJo2bIRMuJvDJNgHohv4IFOv3HdMOk5/MZ1jaWMdXZsVx4CR722ulA4aR2GhA74AWpIvvvcLigF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PrNP4eLK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ec267b879so233179966b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 13:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732224951; x=1732829751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wzvrme6xhrc1FPoSTNfgVzNymiF3jz2i05A93yDIUck=;
        b=PrNP4eLKXOdLuKxwWCwpE7kO532cgHPDrtW8WJnWjI6w/y3pvFyWSBgoSWXyDKkfQ7
         QDwR8lcNjnoOLsi8Ea7eeEaAsg18Lk1HZg6pSQrmjXC2ZiH1q+F4ej7GpUCZ0EyfZY6L
         eenOgBeOmafZzbmzy0wFaZBX+h5zO3X/zg4uqaaOur7QlYDPYHnrRPhZdI3RQYZxoGNF
         jJ8KoJ5XTOvDL6VH2rc//lt/Vi+FfeTTfWU9W0f5+9BWDc4IyJJpHfgMP6D4YrXOzw0L
         B1hRuT+M9JuQL4o22qVLFEqIobxCK1iPDlkth6Hbwj9y1CNobdTkGXhTvbZEWeTzSH3B
         wAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732224951; x=1732829751;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wzvrme6xhrc1FPoSTNfgVzNymiF3jz2i05A93yDIUck=;
        b=igRpm8icqidzH02RaWxH7+Ij0ll8pwQmfrwjlnO8IjfUT8gf6SA8Ma/o/IuBBVzI9X
         OT3WYInJNHDszG8Ef6KK50TPyCZ3mndbVognsH7k5p2VuMHIeReVZMlXnFOc9ftdFliM
         jZcT27GP1REZHyZqcslLriDEaAVM5jg3MmmtgbdqjtN5IEheAjoE97xhMW1fKh1kNjLy
         mM8VAGWcMKDUnXXJYzD0LCd0erISTOGQgDjojqfbYeTEicCqLGLHrm6AAntmG2JJhbif
         xLz2W0MesZmYnQ2N1XoTwID4kehpcyIa2TFKqVsInQo4r1oVZnvhJLglXzhtYvNhqDwH
         z02w==
X-Forwarded-Encrypted: i=1; AJvYcCVrwmF9QMjFIiosOO9vrCDKz1DQLeIly3/Uj7ZNuh/h3jGdlqIE3jwlXq3BXTSEIssS++MgeNC0igXvbo2j95A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQcaaO/jPAWGWHnwmnSnZGgNX3SkejVMvzP6tfBMl1enq3gDr
	bYRoNFnSCIp2/GLahAG3EX1VNTLyClEgPhbUEgFjczqZE4xjb5io5FzdmTbCH1A=
X-Gm-Gg: ASbGncup+MCEfIypRrXRW6i2Cp5hackWAvRACEVGgF55VgYdcN4qLOIiGDMsp7aWDL+
	zqpcVqBGXslV3TG1EZi0W6jmW7UWBR0W8kHu9R8F9+P0xMPGjZbxpCR6Mmep6afvFvPjZN7NVm1
	du2R2atWCoriRC13unGwMvjqB9xYRFmNR6VO4ZG9000bDt39SPRPZxi6abay3QtrgywPLz83CFP
	jV1r3REDuZY4yeoGnQwC5DBqaCZJEEkreaa4HUOhdyVz1p30o/BhRyZrpw4/TWnC426vZj2ONMe
	cSlJFzJHIQ==
X-Google-Smtp-Source: AGHT+IH0M3y2eiUipInPQ7W2Vnd3e9JU+0FyNA5ACy/5oapwX05Afv158ZLgMCPczHyBX4vOP1e9nA==
X-Received: by 2002:a17:907:8297:b0:aa4:e18e:1ca1 with SMTP id a640c23a62f3a-aa509e95066mr43168166b.60.1732224950895;
        Thu, 21 Nov 2024 13:35:50 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f55:fe70:5486:7392? ([2001:67c:2fbc:1:f55:fe70:5486:7392])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f0899sm16627766b.61.2024.11.21.13.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 13:35:50 -0800 (PST)
Message-ID: <ece57745-183f-49cb-bfd5-76688f51f68b@openvpn.net>
Date: Thu, 21 Nov 2024 22:36:19 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 07/23] ovpn: introduce the ovpn_socket object
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-7-de4698c73a25@openvpn.net>
 <62d382f8-ea45-4157-b54b-8fed7bdafcca@gmail.com>
 <1dffb833-1688-4572-bbf8-c6524cd84402@openvpn.net>
 <ca5c4c4b-bd9b-4ccc-9258-e78ec7684a85@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ca5c4c4b-bd9b-4ccc-9258-e78ec7684a85@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/11/2024 00:58, Sergey Ryazanov wrote:
> On 15.11.2024 16:28, Antonio Quartulli wrote:
>> On 10/11/2024 19:26, Sergey Ryazanov wrote:
>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
> 
> [...]
> 
>>>> +static bool ovpn_socket_hold(struct ovpn_socket *sock)
>>>> +{
>>>> +    return kref_get_unless_zero(&sock->refcount);
>>>
>>> Why do we need to wrap this kref acquiring call into the function. 
>>> Why we cannot simply call kref_get_unless_zero() from ovpn_socket_get()?
>>
>> Generally I prefer to keep the API among objects consistent.
>> In this specific case, it means having hold() and put() helpers in 
>> order to avoid calling kref_* functions directly in the code.
>>
>> This is a pretty simple case because hold() is called only once, but I 
>> still like to be consistent.
> 
> Make sense. The counterpart ovpn_socket_hold() function declared in the 
> header file. Probably that's why I missed it. Shall we move the holding 
> routine there as well?

I prefer not to, because that function is used only in socket.c. 
Moving/declaring it in socket.h would export a symbols that is not used 
anywhere else.

The _put() variant is instead use in peer.c, thus it is exported.

> 
> [...]
> 
>>>> +int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct 
>>>> *ovpn)
>>>> +{
>>>> +    struct ovpn_socket *old_data;
>>>> +    int ret = 0;
>>>> +
>>>> +    /* sanity check */
>>>> +    if (sock->sk->sk_protocol != IPPROTO_UDP) {
>>>
>>> The function will be called only for a UDP socket. The caller makes 
>>> sure this is truth. So, why do we need this check?
>>
>> To avoid this function being copied/called somewhere else in the 
>> future and we forget about this critical assumption.
> 
> Shall we do the same for all other functions in this file? E.g. 
> ovpn_udp_socket_detach/ovpn_udp_send_skb?

Those functions work on a socket that is already owned, thus it already 
passed this precheck, while _attach() is the one seeing the new socket 
for the first time.

If this check is triggered it would only be due to a bug.
Hence the DEBUG_NET_WARN_ON_ONCE().

> And who is giving guarantee 
> that the code will be copied together with the check?

No guarantee is given :)

> 
>> Indeed it's a just sanity check.
> 
> Shall we check for pointers validity before dereferencing them?
> 
> if (!ovpn || !sock || !sock->sk || !sock->sk->sk_protocol != IPPROTO_UDP) {
> 
> With the above questions I would like to show that it's endless number 
> of possible mistakes. And no matter how much do we check, a creative 
> engineer will find a way to ruin the kernel.
> 
> So, is it worth to spend code lines for checking socket for being UDP 
> inside a function that has '_udp_' in its name and is called only inside 
> the module?

Are you suggesting we should drop any kind of check for functions called 
only within the module? I am not sure I follow..

Anyway, I am dropping the check at the beginning in the function.

Regards,


> 
>>>> +        DEBUG_NET_WARN_ON_ONCE(1);
>>>> +        return -EINVAL;
>>>> +    }
> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.


