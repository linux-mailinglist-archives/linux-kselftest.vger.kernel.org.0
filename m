Return-Path: <linux-kselftest+bounces-22090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CD19CDC59
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 11:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CB0285B17
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CB41B393F;
	Fri, 15 Nov 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dQQXSmFb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396E1B2195
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665941; cv=none; b=LJC30KsMFp23FrumsLpXGC1ogSZpqIaQNioIRpIBHCqYTe8PNlVFsjgKfi1FhRFz7Xyj1CLA7ScF7MPXv7R9+2a7iE+uA3tlFCRTg5fOczIQsVvsqp9TIEjDIeptxmNq6pxZo9o/J9YpICh6yvoJVYunBoMABLl2n9q3gcf23rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665941; c=relaxed/simple;
	bh=X5D0h9UNJl13Pe4z8gullnSJc8fhH65Kg8B35uclJ0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJ6qe2jHoEZZpNiH2brzpOwY3L4duOi0WHb5KjADgHjNCfkG/OjXJnYaAQNQrBfJgFGdyEHMkyBiO5935n82tiKzz3yHOIBBr56DmwsoiABCrLWXn/3fbKMw4rENqtFd+NdURJvN2SrVBHTg+gxL8fwOxUurlvY/pADIPv7dQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dQQXSmFb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so13278855e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 02:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731665937; x=1732270737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=moBXfLDVX5c6Ljj6/t/WvvrljNE0SqwxGCewjZjiArM=;
        b=dQQXSmFb01ocaTBhm7x0t/GB9tAv2BAD49D7Zfa9OIuN1Lbmjg/1hps1qR3e6uzCVr
         UpcbVCCYN7xcg+3WN1Hlu9SnEwInSJaD6dSI8tl75RRDOrA6mG/MS7efDcOduz+pyGi1
         BZ4gUOtUSnmXALrh7ljqACp4oRbEVoTxu1PDKEgCAbLvPc0JWZfXTTp6NOHf1uCrMPb2
         RolgXh8pgOu/BlhTGdbOh0T7rB+/ul5zVDO3O3tOJJEVRP89rdBpo1zfBBXalggcBfgZ
         SYllH5RmpquIl7+E8b67P6ZLBR/TcYodzh5TA5KKIeS4Cbfh9qQQYtjr3Lyecb4sMj0N
         Eubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731665937; x=1732270737;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moBXfLDVX5c6Ljj6/t/WvvrljNE0SqwxGCewjZjiArM=;
        b=C8uZGKiQJ/FNRKLHxAzjHbEaY4Lzi5b5likjoqelnXMdRoH7Qy5l9fRuVkATiCfjnw
         h2RwrKZwxPac55PafeLT/Br3bJ4axYQcj0kWZwF0rYc7Z4xIryBB7W81hV9tzh0pVtZM
         aHY+CYBcI//9fJ5jK/pLYMiAmASsJZ+HHTy68E5IOXGh6NAL95FZRloqbniOwdEzGUKI
         QUGfSkl1Iop7vFQ87DJaN6Rdc3PnUZun0/ijPVxM3tESXiAhBTrTw8RS4/LATgDooiLE
         VrS7Mz+NxHfhOF4R9kOX5B0ISNR58bvW6bkAH0Z0374cEX3jlG+iH+mDRTdPb4EEI6jS
         f/VA==
X-Forwarded-Encrypted: i=1; AJvYcCU62VVgYuGrVS3WvygVXxcpFoYm0ReCOkRv1SimrO40phP2J7WNUbfuB4bL6no7xfZdRwkgtoPeeUUCmqv4yNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHBx+W8aw7L8qj2sExlKPYhp1jhxIovzriL3ESY5cAam1MTrz
	//+mXqnhFJct/OZAqsAivlbblzjrCrt95BI+L0yiTat347m4JtqGwbB4W347QtU=
X-Google-Smtp-Source: AGHT+IGn9S7JhSYSeHgbVmQ2BSBxvX0GWYaTGrCbot1ed9O8BPB4IeK8ajzzLD6HoKiGPR6iN1/CKA==
X-Received: by 2002:a05:600c:3513:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-432df72c555mr18504095e9.12.1731665937243;
        Fri, 15 Nov 2024 02:18:57 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab78783sm49172485e9.12.2024.11.15.02.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 02:18:56 -0800 (PST)
Message-ID: <dc63a3cb-7ace-4aca-9b67-f3c50297b2d2@openvpn.net>
Date: Fri, 15 Nov 2024 11:19:20 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/23] ovpn: add basic netlink support
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-3-de4698c73a25@openvpn.net>
 <21c0887b-1c7d-424d-a723-2a8d212cbde1@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <21c0887b-1c7d-424d-a723-2a8d212cbde1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/11/2024 00:31, Sergey Ryazanov wrote:
> On 29.10.2024 12:47, Antonio Quartulli wrote:
>> This commit introduces basic netlink support with family
>> registration/unregistration functionalities and stub pre/post-doit.
>>
>> More importantly it introduces the YAML uAPI description along
>> with its auto-generated files:
>> - include/uapi/linux/ovpn.h
>> - drivers/net/ovpn/netlink-gen.c
>> - drivers/net/ovpn/netlink-gen.h
>>
>> Cc: donald.hunter@gmail.com
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> [skipped]
> 
>> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ 
>> ovpnstruct.h
>> --- /dev/null
>> +++ b/drivers/net/ovpn/ovpnstruct.h
>> @@ -0,0 +1,25 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
>> + *
>> + *  Author:    James Yonan <james@openvpn.net>
>> + *        Antonio Quartulli <antonio@openvpn.net>
>> + */
>> +
>> +#ifndef _NET_OVPN_OVPNSTRUCT_H_
>> +#define _NET_OVPN_OVPNSTRUCT_H_
>> +
>> +#include <net/net_trackers.h>
>> +
>> +/**
>> + * struct ovpn_struct - per ovpn interface state
>> + * @dev: the actual netdev representing the tunnel
>> + * @dev_tracker: reference tracker for associated dev
>> + */
>> +struct ovpn_struct {
> 
> There is no standard convention how to entitle such structures, so the 
> question is basically of out-of-curiosity class. For me, having a 
> sturcuture with name 'struct' is like having no name. Did you consider 
> to use such names as ovpn_dev or ovpn_iface? Meaning, using a name that 
> gives a clue regarding the scope of the content.

Yes, I wanted to switch to ovpn_priv, but  did not care much for the 
time being :)

I can still do it now in v12.

Thanks!
Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


