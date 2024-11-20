Return-Path: <linux-kselftest+bounces-22383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456BE9D44BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 00:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F27B2392B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 23:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3541C1F0B;
	Wed, 20 Nov 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEn78HrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABBB1B5808;
	Wed, 20 Nov 2024 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147109; cv=none; b=u80uOu8q7sAg4GX7CEZW+UJTmwAWNvqlnrvpkJ9YON6ff8+UloIEGzX5zMHLbwkQI11jyYKy5wFVkAo2Ep8gOQg+ReOfFdtgRQw5HvI6lzGdGN2/O/tA+kdE/vcEyMTNcyKBD3UdDSfGFtH5ofzlxXumXGBNCn1rkY5XZUpEjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147109; c=relaxed/simple;
	bh=FT7KpVo1Xw4Wyhveq0TEe3D8LUUQtpfN6cDbNDoyYko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4vgMsKFMun2OtZQRreoVhHNp8aApcF52laRFh7dk/0+o1sFfTWbvrS1/bHHdxGZbeYeq8iEliJ2qqaj9QtsoWUAGnK1l36Yd8OGzeDsUDo2xE8Injgh+V1+U8iWNFyNhQ9Znar2btbrajyYKedJdlFQxODLGWEsrRLy+U7svx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEn78HrR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316cce103dso3136285e9.3;
        Wed, 20 Nov 2024 15:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732147105; x=1732751905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSzf26MMooOvVsUekTM/2oVfGFV2k4kNZ8E/KxyEwzk=;
        b=QEn78HrRdLw0uN9Wq5KrBurVbW4lEQbGWSq+8GG4+p3EetgMRJOr6Hi7Fb/5vWbPTc
         ic/YQV2U+BSAbiMTHNNQBhKxp9W5SjfyH+YAK4DJC8hE7d1rj31aiQmDu1OM0Cu9x2vb
         ff1fjqSoiECadbrc4iIAYPQhxpF6KwtjtMfoB0Y8zW5FAzUM5lXm583jkgXwKvEi9fTu
         Q/mnDL/ItUtYb6scUt2wGdpmqLieIdNQubE/suwALwsGya35OaY5o9sFxZv+6Eq6pJ6c
         UmlmB+VkaV3g21iYoK6EwSX8ZRoYPtAYeBW18uce1dNlbN0V8Pv0qdB9TOJ3yEhu4w0W
         44CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732147105; x=1732751905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSzf26MMooOvVsUekTM/2oVfGFV2k4kNZ8E/KxyEwzk=;
        b=GZn+nKiGmA5NNr8IwC6xhV+6lODKcDOv5968y9iMVcM85N7M4X8GM/ZrySqCCMc7/+
         jrMiK3UQRtfP1A75aWGqSwjijY/bs/io5iXU8lJKgNjTCnlTVR74gd/agOiVspSvrhDV
         We2pcZeLCQlLxJaNRGvq3eax3xLD0kQmpslOVRKM8uwa0W+FTyXAcPzeM56y6CzpF5LX
         oVtevkim60V8PaswWkvCjKkEQE1kOUTjPXlSWAOXzXfX+qKbkY/RIRhUlqdFnzrT6WCT
         D9X13aRP9KxO1Fs+r7qlfabvL/GgFaJQHWh0DRrHeVIOHyeJH+7GZ9aR0JYaXhYu2mpK
         rTvA==
X-Forwarded-Encrypted: i=1; AJvYcCU44bpNCyPwpONvthLucvIR2ohMlV1mHDk7rmozPBmu/MdOHSPWB3SHOKN9ee6mgS1CsI59TEVuXRo4Wvo=@vger.kernel.org, AJvYcCUQ1+lMzm63buBGKZjRZ9H2bpmmnDPBPpzsccwo9KL/hESCqEiLDgq7LokF7xOvhW4HQgMR9eGYLh4FTTTDSTYh@vger.kernel.org, AJvYcCVnkofUZ9oqBUurVyUeDoPunTSQsr411p5/pE1EOohkd6vhtJ+RYl8PoMzGVgCM4ZcpqkgleNdG@vger.kernel.org
X-Gm-Message-State: AOJu0YywkfGy5w1RWM1bV5RK+s3T/w1Y7diYS6jNh6CJYOHV5pjErkoE
	tTu0tByzYEi0jB9ozfjNd3MNyIGfaipJCGWj522o9/J2n1lRoUoX
X-Google-Smtp-Source: AGHT+IFdnLy7rwqiIZErl4q76RFF8iGIEXJOmR4TkGveY0gnQTd5KyXsvE+Qee4CVFMz1SkWoxU2LA==
X-Received: by 2002:a05:600c:4f46:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-4334f01d75bmr44748645e9.29.1732147105431;
        Wed, 20 Nov 2024 15:58:25 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1046sm36572785e9.4.2024.11.20.15.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:58:24 -0800 (PST)
Message-ID: <ca5c4c4b-bd9b-4ccc-9258-e78ec7684a85@gmail.com>
Date: Thu, 21 Nov 2024 01:58:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 07/23] ovpn: introduce the ovpn_socket object
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-7-de4698c73a25@openvpn.net>
 <62d382f8-ea45-4157-b54b-8fed7bdafcca@gmail.com>
 <1dffb833-1688-4572-bbf8-c6524cd84402@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <1dffb833-1688-4572-bbf8-c6524cd84402@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.11.2024 16:28, Antonio Quartulli wrote:
> On 10/11/2024 19:26, Sergey Ryazanov wrote:
>> On 29.10.2024 12:47, Antonio Quartulli wrote:

[...]

>>> +static bool ovpn_socket_hold(struct ovpn_socket *sock)
>>> +{
>>> +    return kref_get_unless_zero(&sock->refcount);
>>
>> Why do we need to wrap this kref acquiring call into the function. Why 
>> we cannot simply call kref_get_unless_zero() from ovpn_socket_get()?
> 
> Generally I prefer to keep the API among objects consistent.
> In this specific case, it means having hold() and put() helpers in order 
> to avoid calling kref_* functions directly in the code.
> 
> This is a pretty simple case because hold() is called only once, but I 
> still like to be consistent.

Make sense. The counterpart ovpn_socket_hold() function declared in the 
header file. Probably that's why I missed it. Shall we move the holding 
routine there as well?

[...]

>>> +int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct 
>>> *ovpn)
>>> +{
>>> +    struct ovpn_socket *old_data;
>>> +    int ret = 0;
>>> +
>>> +    /* sanity check */
>>> +    if (sock->sk->sk_protocol != IPPROTO_UDP) {
>>
>> The function will be called only for a UDP socket. The caller makes 
>> sure this is truth. So, why do we need this check?
> 
> To avoid this function being copied/called somewhere else in the future 
> and we forget about this critical assumption.

Shall we do the same for all other functions in this file? E.g. 
ovpn_udp_socket_detach/ovpn_udp_send_skb? And who is giving guarantee 
that the code will be copied together with the check?

> Indeed it's a just sanity check.

Shall we check for pointers validity before dereferencing them?

if (!ovpn || !sock || !sock->sk || !sock->sk->sk_protocol != IPPROTO_UDP) {

With the above questions I would like to show that it's endless number 
of possible mistakes. And no matter how much do we check, a creative 
engineer will find a way to ruin the kernel.

So, is it worth to spend code lines for checking socket for being UDP 
inside a function that has '_udp_' in its name and is called only inside 
the module?

>>> +        DEBUG_NET_WARN_ON_ONCE(1);
>>> +        return -EINVAL;
>>> +    }

--
Sergey

