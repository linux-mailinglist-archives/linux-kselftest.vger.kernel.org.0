Return-Path: <linux-kselftest+bounces-22272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C02A9D2734
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 14:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E891283CF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05A61CC8A7;
	Tue, 19 Nov 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gSwFGzia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844B1CC88F
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023867; cv=none; b=ZgAbW5towWEaAUTaVP7Ek4331SDonfqJgfbzH9XgpccClfts6xzqkDBzVDoEkSqOnNahojKgDOlFa7EGa/D9gU3wEYw8b62SqFbVaHaYjPqW1oPYWZoUkBiFm45UbrxLrgVYnxs5fiBz6ARHndbAeSX708snmJISrGeijiRHriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023867; c=relaxed/simple;
	bh=OFTRm7LRQZAyUSigbQ6nRqpQqAPv47FT7sIHM6gDwyw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YJP1i4n7As0okRwzNTAPPZm45EZ1UEOeTpw9ZdUEa847fbdvp/S9WH+RstQQZcxjtcHKvMaTbiuz+uD1hVN+QAMIbjo8UDnlORT3gnH5FNFBEtf7h/tr2jeJtF9QemZjCw09NV+cWgwUEIbh+No3Dj70qe9SWdewXgkcEmCpv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gSwFGzia; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa20944ce8cso974606766b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732023864; x=1732628664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48VrpXY2mkWzYGck/cWClRiF6WW35MKwTazRhdBRft0=;
        b=gSwFGziahw1ewxPfo2qXf96qgmrS5ylk3ZiRt26n2IkuIksNdSDcSYgNOvu2PNuabW
         QZbfX/y0K/ou1DR311nnPx9ulRexn4RS8smofNm92MpfKTgaE7KDlkM2MszHGpK1hN+H
         xsfjkf5j2vp5NhH8N+ElBUbL8SN4J4OmjHMrJ8dyeAQ7wKVBJl2SyVTQ0h0H/tgYRlKh
         TfgNbCokKKV2mOIBaluXzvmYwJuUy9XpISnaL08Ge9RD7KV19AWl/oPGvWYo91EqECM0
         0+sA6XOwJcS+vlCn1o0KFB2gAR8DYGij+jeyq/swy6bHL/8VS1l1BNcRvSZkmGYKXa5k
         WjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732023864; x=1732628664;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=48VrpXY2mkWzYGck/cWClRiF6WW35MKwTazRhdBRft0=;
        b=KGTdTHAhOcl6S2qYkAqb21/0wbY9JlpMbOJwQnkJl/nM70P+gxU2D/1JZ/5cb9tzJD
         qdPJRbzD+3povmrEp/YMvoA0O/8fsvv91P3F8PUVCgpPQ9aOLzoGw3VwXoW150fLQk/k
         dTqpSYYBzmQVeqgAW/9cC0oS1dlrV1QJD8Ie7wndzlYOBV1lVvVONDXUYGC9FUOdEn+N
         MGK3K7yPLuMs7uLf5AjqDljOB7FaXKoJz1MRKed4nAPJ2RebgPyKlsYC4JGCEykTr9bT
         VM5Lviab36ne0Q/IQ34urMHFajQt8r3jNXYfAYoWrA88SnM2ERx6YUHJwEq1VrG7JpBW
         7WjA==
X-Forwarded-Encrypted: i=1; AJvYcCVm0yCYNP7KxPwLSXo2PyP/OW0xxOkNzeyge+ikiZSY9Zru1R1S6++BUbHDxp3mchnyAX0nZ8zOmXz9WIE73aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYdEA5E+FbNfTuFbT1bXJeH1jyuXzYltGEPqOIhOAnHBAYZTP
	F1oy/YK+avLQHjcYlgMFO76hn2t/O3wARZyRHbp2ij64WDT+q/auv7oBxLeXKqQ=
X-Google-Smtp-Source: AGHT+IEKsrovWVogNEbGLCwrR7XMXtJ3TzAzN2ee3eiRBEyCmTdZ8Wriy4SSzUcbTJQaitV5neejvg==
X-Received: by 2002:a17:907:9281:b0:a9a:662f:ff4a with SMTP id a640c23a62f3a-aa4c7c28b5cmr334506366b.0.1732023864047;
        Tue, 19 Nov 2024 05:44:24 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:a2be:8cd5:8845:cfce? ([2001:67c:2fbc:1:a2be:8cd5:8845:cfce])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b9faf4sm5456537a12.33.2024.11.19.05.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 05:44:23 -0800 (PST)
Message-ID: <b8612694-c5b7-4b62-8b9d-783aaec1439f@openvpn.net>
Date: Tue, 19 Nov 2024 14:44:51 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 07/23] ovpn: introduce the ovpn_socket object
From: Antonio Quartulli <antonio@openvpn.net>
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
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <1dffb833-1688-4572-bbf8-c6524cd84402@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/11/2024 15:28, Antonio Quartulli wrote:
[...]
>>> +}
>>> +
>>> +static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
>>> +{
>>> +    struct ovpn_socket *ovpn_sock;
>>> +
>>> +    rcu_read_lock();
>>> +    ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
>>> +    if (!ovpn_socket_hold(ovpn_sock)) {
>>> +        pr_warn("%s: found ovpn_socket with ref = 0\n", __func__);
>>
>> Should we be more specific here and print warning with 
>> netdev_warn(ovpn_sock->ovpn->dev, ...)?
> 
> ACK must be an unnoticed leftover

I take this back.
If refcounter is zero, I'd avoid accessing any field of the ovpn_sock 
object, thus the pr_warn() without any reference to the device.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


