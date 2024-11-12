Return-Path: <linux-kselftest+bounces-21876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B350D9C5C2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 16:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E3D282756
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272102022FD;
	Tue, 12 Nov 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ps90XVo+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068852022CF
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426230; cv=none; b=XlPj36D+etdKVBGSsWQvv2WOiU3s+dZmks5iTYoxE3ofdEA9Wjfy60c+OsReQHE1i45NFamG4oGbD2ymLxU+pI+DRlGjFn6lmam6tQ6zm8LEUVXJvnsZljUX4LQp9zk5xGuPM86yaXiTUqQsiibEoRah/aWgGK228A7DhoLvZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426230; c=relaxed/simple;
	bh=sugKUR1x6AisW4skOVA3ZjQCFFcMRgfFJpnbc5pgqRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QG6UbKuSh82DUvwAdlDrVJBnUdnsjB6IAczNJKA11GHQ8U/RLoynYnIWy0K0cJjTu3qJIcyJDkZZnUL9iZqIzuPM3V/mfRZu7oBn7fJPO8IN/2dfy1yqeI1R7ItW+tlY7hs1GfwiNl42cFv50MtnxGuq0owJq47O0tckqkZ3lZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ps90XVo+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso2494418a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 07:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731426226; x=1732031026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8FjR/IXLb5vtI7LPCkZUeh9a8brNlsLs1nKW+B8ZeXc=;
        b=Ps90XVo+t2KmLOgFV/0jzOWxEm52L2OZgBoSUGhE6MJkngQClGvA1ApBfqL8mIAExG
         y7GueizeTt5kAaNOEgwjB3uvprtzW3fwYDpcH/ms5uozhL2MzOqcDdJ5QKe6hSuDM/ty
         PSm3D9casrO98JpJNhuGLDYu1JGEoJ1E8T0slayxLIVqeJP+HxiBFy0zMUFwGm0+W1PN
         cCHBKrxNMZ7xcKsnimDu2gtFyPLsERKU/y2DhX8W31mo5tPlw8ocFDfgM7tcQ6rl4tQu
         ye8JGhA8iKDY91JsH8O2IYsgXpRPP38EyGxVACGVcCFJaDpUqZa5lOkaaBRDN609EB13
         GbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731426226; x=1732031026;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FjR/IXLb5vtI7LPCkZUeh9a8brNlsLs1nKW+B8ZeXc=;
        b=QjOyd6yBGUPeEReNIAnkiX5JVoyUCm4Ia5Eo7FqijPeMOVdpaY5WzAMe6XuUkeb8wE
         cKi7tzm8EsrQ6+5FtfcVHJYe0H+O4OKQf6ykZZzKkKGfToiwx/I2gPKcPkDobJDIeakg
         Lc6XwHMZxNhbjAEz4pme2GMalc4xobmxGKCL0Rlu3qma/Y02Vs00A8TOieqq5nzVlDg6
         Djt84I86SODt2NjDi8Drf5oO3Ym2rehl/GszJQbNNyMASxRlBaeSh9pcsJ/FarFr5/Sf
         Dd59A8/GgrUWx7hsqMDq15Uw7j4izZ3rnVRcrAPd6ZZEAaf/uvRP2V11fDFst/PI5RoO
         nXcA==
X-Forwarded-Encrypted: i=1; AJvYcCXTEtbLliheLzsvrxDUgg43aqr+cvEnrf5YmiSGK7XkMOlfDjyS16rJxnjnGK7C/zSTldwjEUE37Y10wYN3jvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKwa9fS6dsbZzaTmK1cQ3OLmXxlyo7VFgQiPNOvypfcGJfazZ
	H4WHfov/6s2ehprAbkytjTcrLccaC19NOrKYQOjgVu0FmmVJ1azEs5ZAU2DAhLY=
X-Google-Smtp-Source: AGHT+IGQPjVckld30sw712EyVfRtKY34CfCHYQtIVY+84TH6Fted4MlGcMFRQCkafp+/3JEJyW1jbw==
X-Received: by 2002:a05:6402:27c7:b0:5ce:df98:ea7d with SMTP id 4fb4d7f45d1cf-5cf096f5c1amr17884562a12.8.1731426226420;
        Tue, 12 Nov 2024 07:43:46 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:e829:c484:5241:93b2? ([2001:67c:2fbc:1:e829:c484:5241:93b2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ec9fsm6129828a12.61.2024.11.12.07.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 07:43:45 -0800 (PST)
Message-ID: <816d8b43-8c19-4a4c-9e37-98a3415848b5@openvpn.net>
Date: Tue, 12 Nov 2024 16:44:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 20/23] ovpn: kill key and notify userspace in
 case of IV exhaustion
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-20-de4698c73a25@openvpn.net> <Zyn0aYyPVaaQJg3r@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zyn0aYyPVaaQJg3r@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2024 11:33, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:33 +0100, Antonio Quartulli wrote:
>> +int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
>> +{
> [...]
>> +
>> +	nla_nest_end(msg, k_attr);
>> +	genlmsg_end(msg, hdr);
>> +
>> +	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
>> +				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
>> +
> 
> Is openvpn meant to support moving the device to a different netns? In
> that case I'm not sure the netns the ovpn netdevice is in is the right
> one, the userspace client will be in the encap socket's netns instead
> of the netdevice's?
> 
> (same thing in the next patch)

Well, moving between netns's may not be among the most common use cases, 
but I can see people doing all kind of weird things, if not forbidden.

Hence, I would not assume the netdevice to always stay in the same netns 
all time long.

This said, what you say assumes that the userspace process won't change 
netns after having added the peer.
I think we can live with that.

I will change this call to use the sock's netns then.

Thanks a lot!

Regards,

> 

-- 
Antonio Quartulli
OpenVPN Inc.


