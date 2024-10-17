Return-Path: <linux-kselftest+bounces-19929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE09A1C17
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680281F231D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51EA1D1F71;
	Thu, 17 Oct 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZOpD3ak3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F91B6CF2
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151817; cv=none; b=nowU64132bHMunSlhSU/ApMmoj0cwsA7HGj7/2tJ/yzD1sJlbfEh0YzY+CrOS4VdhsWS+S/ap0rqSxnkP3jX64oJCRWonAr3lYqc28k6gU7Wml38WKo6zby0NiLeb+v4WkhqVIUBrk08RaELOJMvEi7m/SiXs+gm7LwUvhCnFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151817; c=relaxed/simple;
	bh=LeMQF2sFlDmaRyjomEJWKN/yS9Hkx5TlIwL5RqL9+2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMhzjngvZnwUhZwVJErwYr1sG1DzLeQ+17PIHftlicLv3tdh9/GJUr7JiD71obaPFb1mFVWpm5GvXLTsjpBP+soTQd7UgulGATK84OrNX5Ii+vteqwTGT1WSYvJ8LOpZO+H+RTeF0c+IskjPTdT5v6Ne8rdI31t6V28MR7tPSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZOpD3ak3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so6364615e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729151812; x=1729756612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y/rTfYOYXtcL3NaveLZQOsVTZ7xFjeiUA02E/0hWcpg=;
        b=ZOpD3ak3BCJsXWhfBZ7Zlgh63oIxR8cqF+nykH1VHOVPNtu5atZW05U4cpmeE9xZc8
         F1NTHjsXTDGFlJux4xVyCfjJwUftm3hPTpBrZGRqCDx18Tyjj8risvkbTbWbRG1Lt15f
         m1zt6ReQLXuN+kilOQSM4T9+TFlAMxJtuxoOIRAWkEnb4yYcw4SDSVRXoch5S+trTCKi
         xdgrzjntASg7jdswkXpz1jR5bvTpo8DDyHd2NyiIhKj75hC9YlKaJt4QYoX6Y+0Ia3cr
         Tw0ZxkWH549wN++qSYEvGNKapJVhcAOc4brLp+4n8P1YQuxb+3vR4K0UiYo8wwiCcI56
         pw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729151812; x=1729756612;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/rTfYOYXtcL3NaveLZQOsVTZ7xFjeiUA02E/0hWcpg=;
        b=s1SCzO+MSN9TgY5Ax+YUYKdbRmQF833bGcl71ha5iJvKO1PFxudgh3iIBxuKFdfYKf
         RqeHIz2Yj8WEcbkafrkQdhiIU5wg0FGtJGdTMiNbivYVciQ/8N6Ee0CypqsxWbj6pjPQ
         qw7MEOT9FO+tO41+TcFk41BCl9ZBCC8mDgvjL3WjfALbX1X9lCAgz4nLJeY+AjK3aAsB
         I05vyqLF5tHqFiDMcp2LAN1e0NMsjp6yBFSP6nuXWpvix65mk5vr3a6RSSK5SCRk0D8A
         Trpz3RVw3tEO/6d7/sL0a73GrvIU1EabjXYGDExOB6pnse+1McTFVBFnlHbGgIt4d329
         Qn/w==
X-Forwarded-Encrypted: i=1; AJvYcCUSf7daZOJNK8M3bVQllOuLHjJJHKbJTQ+4jsXPXsGpVah+pTWO+0aG2u/VPD811YMTNwvUupklOJneNnqMIAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVH52yptqjKhjmwhxdc9foVj+HRb8kDQvdfFcYVENfoZM5cAO+
	RP1kkEnJKWM0CUqHG6rZ/E9bLcR2ErIDzra+fJnCNcN4djGw8B2GBhVDjkIAwYI=
X-Google-Smtp-Source: AGHT+IHMW7wK0jw0Eqvlr2MnIiwP3BToh8kiTRm+CSXGNU/Ho41fPMwC7+n32MetigPZzVnD3588Dg==
X-Received: by 2002:a05:600c:4c94:b0:431:52b7:a485 with SMTP id 5b1f17b1804b1-43152b7a7e3mr33361755e9.19.1729151811727;
        Thu, 17 Oct 2024 00:56:51 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:bf6c:6ec4:d449:2088? ([2001:67c:2fbc:1:bf6c:6ec4:d449:2088])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c38b39sm17728305e9.6.2024.10.17.00.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 00:56:51 -0700 (PDT)
Message-ID: <17a138ee-bdf8-467d-8f48-17e8a42d1ce2@openvpn.net>
Date: Thu, 17 Oct 2024 09:56:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 23/23] testing/selftest: add test tool and
 scripts for ovpn module
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 openvpn-devel@lists.sourceforge.net, linux-kselftest@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
 <20241016-b4-ovpn-v9-23-aabe9d225ad5@openvpn.net>
 <a86855c4-3724-43e8-9bdf-fb53743cd723@linuxfoundation.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <a86855c4-3724-43e8-9bdf-fb53743cd723@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2024 23:14, Shuah Khan wrote:
> On 10/15/24 19:03, Antonio Quartulli wrote:
>> The ovpn-cli tool can be compiled and used as selftest for the ovpn
>> kernel module.
>>
>> It implements the netlink API and can thus be integrated in any
>> script for more automated testing.
>>
>> Along with the tool, 2 scripts are added that perform basic
>> functionality tests by means of network namespaces.
>>
>> The scripts can be performed in sequence by running run.sh
>>
>> Cc: shuah@kernel.org
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> I almost gave my Reviewed-by when I saw the very long argument parsing
> in the main() - please see comment below under main().
> 
> Let's simply the logic using getopt() - it is way too long and
> complex.
> 

[...]

> 
> This is loooong arguments parsing. What's the reason to not use getopt()
> Doesn't it simplify all ofthie logic?
> 
> I would like to see it simplified for maintainability.

This tool was originally very simple...then...this happened :-D

I agree getopt() could help making this whole function easier to read 
and maintain.

I will include this change in v10.

Thanks!

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


