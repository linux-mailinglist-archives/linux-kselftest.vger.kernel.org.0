Return-Path: <linux-kselftest+bounces-22845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7638E9E486F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 00:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E49282C38
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 23:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63071F543E;
	Wed,  4 Dec 2024 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DwT8O8Iu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B51194A43
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353734; cv=none; b=VHwU7UXFi6d9oLBthDU5S5UpFcmH5iGzqpgLLr5ph9fgXJRl4X9vgIaXx6PZroyaY5ZCM6lF4LrLawyENQ+wdXWZpBcTuhBaD9g9zWYt4tdsyOdl5VspA1Y0Pr9uFrGbbQpwHbYQk/yf9Q8YTpyHcCrXk4DwW/esh3z2V4+iiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353734; c=relaxed/simple;
	bh=F0NJ97nCPumDckOXtjnziKIoa/qCK2OpTeS1VsR6/mY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QdCpb92TaaVoIGoS7ptqGtVwTsht9NlSnz9fmX6hZMuWQDY6hwkSoFIeGdEQuTt/swwTdGHdevA+56o979KtynOX6ti1of9xRGji6hFnpVSzAavJYjSlAYGK4hQtvJbfMQ1gI59yG4lnuqpVcyc4XjXnFpfXtZ44DAFK1ud1o/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DwT8O8Iu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ec267b879so47343566b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733353731; x=1733958531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKBLckwxwL3XkslyANGTh154PJ60a+jIScsVyxn68Vk=;
        b=DwT8O8IuhXEkGVjbav8JZkUTs1S49S4y7UKJcs+bhlTGQgsUIt2I5vyC8y4EzW+AM+
         Mo4G8U2OMb21Nd0JF2z24r1ymBBkXcA+ZFbsmbwEyOz4W8NUndxdj6Y6ImaXd2pMVAPY
         bORpL72buIBbKq7MpzjgmiQQeLjLu2sNK4g2/3hyhknO6OUXmmAGedDgwe5H33q/MYo3
         VhwrDR9eYG1YOak/W0ZFLTJHESU4U1aTnmA3wSgX5ZbdVGhWMcgGDL/dTjJ4RGZYp0/E
         uQJAoN4eope32YIXhEc3gcg3v3MZyn8jdjg0XMPZ76k62Sk1QTWjVE6thweVQiUq6SnT
         0Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353731; x=1733958531;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cKBLckwxwL3XkslyANGTh154PJ60a+jIScsVyxn68Vk=;
        b=qZs6MsvtGOoJc/B6JQciGJfJjuLwjo+HsVmkAdlhvmRX4JbcujubA148PZYBNH6iA1
         VwQj0Gujax+izbhP58WC5UG5aFSdpOZae+dMNC3Ua/pl3A4SAMrf4c6x/17Rqlw59jXf
         U+TJHHBwX5Ie8eHGv8NXMd8SD8qRLWD1G7i8Adoh6QJAg4vliWgAWcPD6IXTfMtE07sM
         sH9XFomZkME4vKzfPAuro9ltzeO1nyCAeKRuMWrMprzvLFVAMoGL92CO2LiYDbL036d7
         aEk+HB4BsboZ9rVzwtx8FMr/j6UQxkdwzZzPxuVYXxb3acdPvLMdSL20fIiF14T0m4qM
         1qug==
X-Forwarded-Encrypted: i=1; AJvYcCVlEsUiJCL48CMhdplAIR5zI96SbNj2qxS/qObjjb8+CN2hht02fXmmuLdYRzJ8CKHNTtbAyWGbQMFhszxHHNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8SAz5YHOFCY6V42C+OUYHXYX3X9t1v/8RdaJyjkZcoJYgdsw
	ow4zCwCAO0O8cuB4/63exsitvi03OQOl3JBkw3t4CSLqRB56/PGDJBjIWHM1LZI=
X-Gm-Gg: ASbGnctwl4s9jFYblbA35NfWI25nqCCoFD9u0pAygtzzKUvqU39YB96bT88dJ3dlLYc
	MazPg+2vpXDW6OTisQegV4chJgWgkl9aD6j7zRWf/ZQqy3jyJ0trnOhIR1Ehf4zkRNqJ+biAO15
	Kl/CMjy9wIceQdTo1muGCRCobovSShR9UHwsJTfx7IcHDvLvaCQaOH3KkMYDXYL/pam4WEtSeDW
	TmwHsNwVO3L4uZofoG6gYgKnwIODsN9dHYIQxH+lsD49Aap4n3gHHdDRMDXETAGo8eMSDJtrQFp
	EJn9/sIX7mZ2
X-Google-Smtp-Source: AGHT+IH69+zo0MA6o8lLr+64n7CFOdLqMrTUeqDDP42MbL7K6OX9M+e7TDBwqfrIzYhIfWUgmiWCBQ==
X-Received: by 2002:a17:907:7746:b0:aa6:26d1:b5b3 with SMTP id a640c23a62f3a-aa626d1b716mr25348166b.18.1733353730706;
        Wed, 04 Dec 2024 15:08:50 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:9715:a35f:73a4:7403? ([2001:67c:2fbc:1:9715:a35f:73a4:7403])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625ea38d0sm11700066b.73.2024.12.04.15.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 15:08:50 -0800 (PST)
Message-ID: <17e7d4c6-4912-4d5e-8723-45a06a1ad529@openvpn.net>
Date: Thu, 5 Dec 2024 00:09:30 +0100
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
 <8714deae-c1f7-42ff-9e76-fabd9ca5188b@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <8714deae-c1f7-42ff-9e76-fabd9ca5188b@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2024 23:52, Antonio Quartulli wrote:
> Paolo,
> 
> On 04/12/2024 12:15, Antonio Quartulli wrote:
> [...]
>>>> +        mutex_lock(&tcp6_prot_mutex);
>>>> +        if (!ovpn_tcp6_prot.recvmsg)
>>>> +            ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops,
>>>> +                          sock->sk->sk_prot,
>>>> +                          sock->sk->sk_socket->ops);
>>>> +        mutex_unlock(&tcp6_prot_mutex);
>>>
>>> This looks like an hack to avoid a build dependency on IPV6, I think the
>>> explicit
>>
>> I happily copied this approach from espintcp.c:espintcp_init_sk() :-D
>>
>>>
>>> #if IS_ENABLED(CONFIG_IPV6)
>>>
>>> at init time should be preferable
> 
> To get this done at init time I need inet6_stream_ops to be accessible, 
> but it seems there is no EXPORT_SYMBOL() for this object.
> 
> However, I see that mptcp/protocol.c is happily accessing it.
> Any clue how this is possible?

I answer myself: mptcp is not tristate and it can only be compiled as 
built-in.

If I compile ovpn as built-in I also get everything built fine.

Paolo, do you have any recommendation?
Should I patch net/ipv6/af_inet6.c and add the missing EXPORT_SYMBOL()?

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


