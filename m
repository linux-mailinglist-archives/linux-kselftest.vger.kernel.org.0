Return-Path: <linux-kselftest+bounces-30333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70348A7F69D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA453BD20B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 07:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80D12641C7;
	Tue,  8 Apr 2025 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TQBC4zLX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACC25FA26
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097846; cv=none; b=aDWDSqMDGYvLZiHAY6GDCRRAwaXqgnJ72R8li77/UeSSfwBXmbPSRmFS5oc2DuZl5GRyCzEx3ni3Ps0KlGl4ypy3uA+AYm2o3Ja+dDDAD94645VOGStLSf5nIkYgysrJMAkQGKfN4P8YNnlqEZOghU1f+q95v27xX7diXwftndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097846; c=relaxed/simple;
	bh=lhptucuRa84eI+sVBc0K01zYfX2ZL/c4XOsEebGLJBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQYq2cP3TJZagEUxXquOWlgTlZEdGgYmTXmldrW4X5O2W6IcvSFgGC5a8R2SPNFFwPV/l2W0ZAQ9h8dqofwx9X3wpWxZ9XXQXpXrSoX48SRQRTkuDVK7651rJVKfNQnsHhDILo7NOnLpTvfUmc59gyb2dw7drTzPRg+rTgJCL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TQBC4zLX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso32771975e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 00:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744097841; x=1744702641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iGBnll+v1vTfK1JeEQuKDVXKtlWhbohIMfsqmj0adgQ=;
        b=TQBC4zLXNxuR8lh2bhBSO1bDi0Jf6z+dNNzIYsdu5ewbhvYfnxqJOXIoRMAY9OtxWl
         J8KUu+qvNQ5o8293sEcRc5Y6V/WZykz3gY1BiZtPAl/rIptd+IXs/aqUIpvcYGhmjJMp
         9bo1Dbgs1BKQm+BVbJ/ENTF0rCagnDuSMqjcJVAfoL6StmvF0uwAck9/ilE/QWfmMN88
         GZ65uIweoRwTu0gWbPsobf9tHIKjmkKxUfMbfX6fEWo0ayMwlwcB40/WuUZvBWE+sdRL
         QNpi7dECB5cCUl6ipl94WQdudjxhVRzqUnwSel3sSUSvxXxaE0Bn9M84T6iPwDhmw8Qs
         xgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744097841; x=1744702641;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGBnll+v1vTfK1JeEQuKDVXKtlWhbohIMfsqmj0adgQ=;
        b=dDlA5ebF4zUlnxNZVXcFNLy8h6d7TElujauj/p6f/Z5eRyCIoxjFxKxMAJjiD1LvAE
         aMPguBhBQWj9S1Iy1sgK0L5XvlXqH07hMsHhwcdyvj+/q5wqluwqV6d796Blv1WKm8Mn
         xoqcVT/jgLVQpNRvF1nhbyp7wxhhsrWRNX5bKEgq1cWf7r+8JNkl4rC88U8WE2eIwchK
         9HU+CiqGw5wWp2arwgblCuP88O5SLjkPc82Vmxu6fbig342MIdGJinIHkjpxp2IBVelz
         2fUXCU79o6SanYYzdsamRSq07VqSi9ZvRZIkl/UhdY5SOzQEOZkYtnIHc25evPTJjoLC
         AZmg==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZKK/rrLTgHSl22EApfBl+7VtXfCB6bLAJNgat3lm9JeFmWu1qq98wiY0Cz8KlTtIyNnlvuBOX0bYghZuP4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzooOH4Zn4IDUGOPmqr0e88+Zw7TtYYmIuWXoxtx9NWpmQI9hes
	Y3hjzGw0eue60Aa+hcjSOq0aKgPVSJ1kwdzb6GnWOlaJGO2Ba+6iY720fyZUJtApBLkef6UHd1g
	ZHcCgAPSPHBtklp6QeShAbWGefc8TcxPsUWBKhkzfyoiyqkaBNWWh/w9y/fw=
X-Gm-Gg: ASbGncvQZf/P1JgF0XH1l2ooYovgOA+SdaUdoyLkmmP6yHdMXqAaA1dWotqfypuLd+z
	mVTKhXVFvgBofcMqCE9tYQsG2R4IWseUrMFebE748WSSc//YIXKxYner8vL5Uz4pOU4TKAwwPi5
	F7IE7ZSvQI55W7Dnx00nDyK82iFvBOzYLeTR2F2LkzcVZSwt0d/SJHgY1fOP3imHQQtdj2cXzOa
	P6vg562S8IIp3wkU5fHwpEnH3JrboEtIRj7TA/8UoMJC3HE4LRv/V10u4UHiDUuu+0Hp1FISozb
	Upfzoi/I75pofspsHmE9H2yXFKa/bzQlfKQpvA27+UM/TQ517VFuUD8RplhEqD2bVRDM4+BHlZn
	Zkj9TkPZsqSXXMzk7SA==
X-Google-Smtp-Source: AGHT+IGBqtrapcUaVmWiPRDGX6VqcVgn8kTldkv63YvvLmqr+RnHjXnpoT5Zwsb4dDsTzOI1Dng3wg==
X-Received: by 2002:a05:600c:450a:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-43f0e545250mr15453105e9.3.1744097841479;
        Tue, 08 Apr 2025 00:37:21 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:65bc:b4a6:4ce5:2ced? ([2001:67c:2fbc:1:65bc:b4a6:4ce5:2ced])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a76cesm14125273f8f.37.2025.04.08.00.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 00:37:21 -0700 (PDT)
Message-ID: <cc2c26d3-c276-4f6a-a05c-e947798d6345@openvpn.net>
Date: Tue, 8 Apr 2025 09:37:19 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 00/23] Introducing OpenVPN Data Channel
 Offload
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ryazanov.s.a@gmail.com, sd@queasysnail.net, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Xiao Liang <shaw.leon@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, steffen.klassert@secunet.com,
 antony.antony@secunet.com, willemdebruijn.kernel@gmail.com,
 netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <bff01a88-1e5d-4855-b7d9-1b1ac4bed650@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <bff01a88-1e5d-4855-b7d9-1b1ac4bed650@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 08/04/2025 08:34, Jiri Slaby wrote:
>> Given:
>  > +#define OVPN_FAMILY_NAME    "ovpn"
> and
>  > ctx->ovpn_dco_id = genl_ctrl_resolve(ctx->nl_sock, OVPN_FAMILY_NAME);
> 
> Is there also an openvpn branch understanding the new (in-kernel) 
> naming? I.e. something like s/ovpn-dco-v2/ovpn/?
> 
> As with 2.6.10, I see:
> $ grep -iE 'offl|dco' log
> 2025-04-08 08:24:59 us=718854 Note: Kernel support for ovpn-dco missing, 
> disabling data channel offload.
> 2025-04-08 08:24:59 us=719060 OpenVPN 2.6.10 x86_64-suse-linux-gnu [SSL 
> (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] [DCO]
> 2025-04-08 08:24:59 us=719110 DCO version: N/A

2.6.x and master do not "speak" the new "ovpn" family, because the new 
uAPI wasn't considered stable yet (due to ongoing reviews).

We have a WIP branch which you can use for test:

https://github.com/mandelbitdev/openvpn/tree/gianmarco/179-ovpn-support

Please do not try to measure performance at this time as we have various 
improvements that we are working on, but we wanted to wait for the first 
version of ovpn to be merged first.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


