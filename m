Return-Path: <linux-kselftest+bounces-23017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D39E9111
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FB518858B5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 10:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA3A216E00;
	Mon,  9 Dec 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Bg8Wy2Sf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DF216393
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Dec 2024 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741845; cv=none; b=E8xoBv4JdpxCvxoSMCVQEVUs98uwk4vd+Ja25P2ae84WHQjcNRBGAVSrG84I7mvoRdoXGEWRRkMfh1oupuLvliMv98DR3S8r6pDi25eABzBfoRGAMBZyOtmggTtgIe0GhZz4r2wF9/0ybNPvhYiXiYY7xMznnohRcx7zXKTAPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741845; c=relaxed/simple;
	bh=GLUQzBQyHE9zYIGp67XRL2Ca4WqhjjyKRByvp0MaxkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMmZkmcldMzlq9tcIoiRKkQQB0cmzeOiPxO5+E41R77RDaXWYE94HMZLGN2gLCYoumLyi6dASLrogVJt/Pnkz7WGa8IKg0HPR04RZL1UVg9FkXFJvA9KJw5RHo0cG1ASisfz0ptazLcQtVuj5wRR5va3SoT0Dn9SXqwEdzac8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Bg8Wy2Sf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so43844835e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2024 02:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733741841; x=1734346641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wy3yHy2OmANN+f1kYyzAKGJywK0OhvOUrDvEeFEjjZ4=;
        b=Bg8Wy2SfSeE2bNEBp7YIXQcqy1YG2StMk93zuB9F0QH1Sr/E/vcGEo9OIvmmQUUby3
         5JFn2UNN6Scj9pZ+uvrEZRsjJ32fRj2Lg+mbHzvZ8TxB581r7py1MV1BqLtC5wFjRWC7
         5ZTgOqMYOzMjP7u76vK+3lcToMFSuSBvYGXLOpgq42UApHcjVIrtPBChKYoGjVLdbwUO
         rny3dZ3CNA78KIhRbb4OV+QCVrk5VzAogzpykUSM0DPI+aZFFNgPmgrp4+x02mvwHVtQ
         5k9581L7vCqobXWQY35ZtNIcND/qMs25XUlO3iogoUkOkrisRx0VqzLY8oAzDGxnHPt2
         8fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741841; x=1734346641;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy3yHy2OmANN+f1kYyzAKGJywK0OhvOUrDvEeFEjjZ4=;
        b=gL06QHaAl1N7PVbCH/gDfZrarG/QaqGh1Mu1CnVPuQ8aLuvyfZqcYIfBXNwH+MDyuK
         XxOT7FTti0oh/zFrp8x+58c5qg9IHRISmRTD4nghlvKO+RbNTBxEJjev2wqaTERbt5S8
         C8JgUWseCtQzYifTyOmQ+L2vMezQKtZgPzmCQtxq+nZSyGNXyiHnHLVEph/tX0OzDjBx
         Zj4xJdo0FNuOq0Cj97IOZ/Di9BxWSndIYLXHrrn4cfimfASqh5uXrApu5YY+IYJ5zzrH
         GumqDiZmqjxIbqsCFkE6pAqo/H8QHQSXuDUzdNnoo6KORXd1PZ8Q1xeDeY40Y+HvgYwf
         4zqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmIARtxOrvCNAR4Mi6INMI/gqpxr9hJ+NntINLhy2qm+mfn4bSFCjvnputAadZMhIubGTz7GpLsznPpCBkAEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyktJck412MNByry12cm2eVaxDfjlfL/GpfadEFATAxPNQrEm+A
	TrTvi0K8GwcTqlTs4TMNtg/8zpI/4RzeKFP5eTwYH+tgxJAgAB0gC+mQ34fsQoc=
X-Gm-Gg: ASbGnctS7NlYOEX4T5x+60DajJbO292q+qhDp8e437lwmBTMVon4FHCpXesFqNsmpoe
	UV3H0CdxeafJOVNljV+VMp01cI3tVhBVV9MbUuxR7ZXBb4TFCm4GEQ/xeNI3vtvPg5QP25nG5VD
	ZnVCN7WkPUI+qj9A5aRt+/LC/9PMSXNvzYwzVGB1RKXbnNUxYex0HbMYGf9zbaULflQ6b4JnV5o
	cj1Ic2lAn5kbQY43G3f6e3ovfSr63R9223DcUw9dy3O3tD9GKRdolFDJRzfGvkYEnvm8ZYMVMPx
	uWsce/onaA==
X-Google-Smtp-Source: AGHT+IHb5wXMQHMkPFR/0dh5QXv4YyHugf0iX+enbQGkb9bA4Lm9ZFbWdI4KVrB8xdXTunWDoV9bmg==
X-Received: by 2002:a05:600c:4712:b0:434:a746:9c82 with SMTP id 5b1f17b1804b1-434e29f0392mr79575785e9.5.1733741841394;
        Mon, 09 Dec 2024 02:57:21 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:c60f:6f50:7258:1f7? ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862a9705dfsm10525474f8f.4.2024.12.09.02.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 02:57:20 -0800 (PST)
Message-ID: <e447ef89-e7f1-4c5b-871e-d1cfaa045c6c@openvpn.net>
Date: Mon, 9 Dec 2024 11:58:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 11/22] ovpn: implement TCP transport
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-11-239ff733bf97@openvpn.net>
 <784fddc4-336c-4674-8277-c7cebea6b94f@redhat.com>
 <2a1b614c-c52d-44c7-8cb8-c68a8864508d@openvpn.net>
 <8714deae-c1f7-42ff-9e76-fabd9ca5188b@openvpn.net>
 <17e7d4c6-4912-4d5e-8723-45a06a1ad529@openvpn.net>
 <813d75bf-1d7f-472b-967f-27ab8f9d4759@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <813d75bf-1d7f-472b-967f-27ab8f9d4759@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/12/2024 11:46, Matthieu Baerts wrote:
> Hi Antonio,
> 
> Thank you for working on this, and sharing your work here!
> 
> On 05/12/2024 00:09, Antonio Quartulli wrote:
>> On 04/12/2024 23:52, Antonio Quartulli wrote:
>>> Paolo,
>>>
>>> On 04/12/2024 12:15, Antonio Quartulli wrote:
>>> [...]
>>>>>> +        mutex_lock(&tcp6_prot_mutex);
>>>>>> +        if (!ovpn_tcp6_prot.recvmsg)
>>>>>> +            ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops,
>>>>>> +                          sock->sk->sk_prot,
>>>>>> +                          sock->sk->sk_socket->ops);
>>>>>> +        mutex_unlock(&tcp6_prot_mutex);
>>>>>
>>>>> This looks like an hack to avoid a build dependency on IPV6, I think
>>>>> the
>>>>> explicit
>>>>
>>>> I happily copied this approach from espintcp.c:espintcp_init_sk() :-D
>>>>
>>>>>
>>>>> #if IS_ENABLED(CONFIG_IPV6)
>>>>>
>>>>> at init time should be preferable
>>>
>>> To get this done at init time I need inet6_stream_ops to be
>>> accessible, but it seems there is no EXPORT_SYMBOL() for this object.
>>>
>>> However, I see that mptcp/protocol.c is happily accessing it.
>>> Any clue how this is possible?
>>
>> I answer myself: mptcp is not tristate and it can only be compiled as
>> built-in.
> 
> Indeed, that's why.
> 
> Talking about MPTCP, by chance, do you plan to support it later on? :)

Hi Matthieu,

It is not on our current roadmap (TCP doesn't get much love in the VPN 
world), but I agree it could be an interesting option to explore!

I have to admit that I haven't played much with MPTCP myself yet, but I 
am more than happy to talk about potential advantages for the ovpn use case.

Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.


