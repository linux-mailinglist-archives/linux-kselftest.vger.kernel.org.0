Return-Path: <linux-kselftest+bounces-21712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168899C2820
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 00:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6151C21A9A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 23:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4C1A9B5C;
	Fri,  8 Nov 2024 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcglRDNL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA4610D;
	Fri,  8 Nov 2024 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731108686; cv=none; b=nd5596sQ8xCFXpSrvoylSrn9qUrrodqiOFhdTdNSeigJgi36TAuUCrOKg4tr1VtDAMB0N7gfc2Go3wVj0o+LIjuXQ5B6NTjbPGfm7oVc6B0WXlPScWZpYg/G1R9kd8pPXAhumcNC6/Nr6qWSYRBWAhRsMQTDdaOFDHGL58YE+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731108686; c=relaxed/simple;
	bh=iz0xZ4OrldyN72hxlwwvIedXENVbkH2RVnLuwHEYJIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGevyd4/cdsmRF33DHwUImuyJgZ0kCscweFV/YM1JgL9bOyTYk+beyaz4PAUf6HLHtTvAbPlVa8nyf1uGid1S3KBcV69FkqSSls16TjS56ZLZY7WIy/1X1Yag3eMwZub7nxo6kxtdAedSVkVf2ocwPhBmcrnCb+mh93uqe+DBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcglRDNL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso21226775e9.1;
        Fri, 08 Nov 2024 15:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731108682; x=1731713482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWrDohYO+E65fwPGOZN9UBAmDMASN0TGavNQ90zX+Bo=;
        b=WcglRDNLkU61TEKCuZI+AHsOW3GjV36VKxK9GA9l745tXJS6nBji6i7F8bbuO8JhzC
         9LX9qs+7S7eda7jlENtEanXFwkE4bMHkcuzfHczCbt+dzMQ/ynx9DzjEdTrFkP7mQRWP
         8gDdYYuUgTr9+IhGJngckO2CsH1MmKkrRWpU0Ab9h+GKNQep1WxWHr05GO/hWStw3e4w
         dDWUFnTi307kb1mcXDNPso+d9rnPVoL3l1gQURPRXkc1/VUIa1zc5h2x5e78XEPDUGkG
         g7urOi39perIddwGlTr9hFJq53gPHsAzu42Gr7z5CxwZwvinnLrpZ69lnSiPzV/5P8iy
         bH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731108682; x=1731713482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWrDohYO+E65fwPGOZN9UBAmDMASN0TGavNQ90zX+Bo=;
        b=hOn0K+n8jO/AfvisGSjue8BxZ07p0flQRUhYoqZdsqnlVgppbD0BTBQANBXj7luvD0
         8x48jfvUw5MGQp1DADseo62IaQb9XsSXC3usnB7qPeIXkQl5JtwkWluT1qrj7DIQokSz
         CQRZ/pDw+UWf1MW4L/szATFW++yxQO+xEM4uZz9mj7ag4Ff0MKOu/Ica8CMWe3FxqDEA
         5+/QIA28DW0rfinxkIXEZYWTwfXKuVU8qJX59YKeHMv/XyL8gV+BjCaPR6pVwuCeNEln
         Vgg1NP1ObVe1sNFPkIv6+b4ZqROHoxgQPY769Ch2D86gZ36eRGb99Ct0ft+QH/x4MINs
         HJZg==
X-Forwarded-Encrypted: i=1; AJvYcCV0DDmSLmXYb3g1yAEaGylNtXQDov+LIYg60rS8qDq39KNkr7gPoHraavLtqB6Y4t2j2eFk1aNEBgftzlZSQOBG@vger.kernel.org, AJvYcCVBRNAh0uZDQ17JQo/UCqPePOMLPAM21ar7/L8OW2E2gxb4eytD6+Jkb2lB+2wOT9bJMrrlj2Ct@vger.kernel.org, AJvYcCVTQTLZySZ+nHOfs8UQhK/Hb8nbJo8xkTBuKWgZyUWGCygWu9JDqSXwBaBRQoYtW2ZlmsGoYItf+9fVi/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIr5L28HXq0SbH4uHnBF7tEG1Ts5QAbIvVmwMihkzmgtXWCp9
	3rSD/OaX/a2aDTMA2XNOxi2SGz1MgQLAhhXFYWe0BAEd1pE+bHY8
X-Google-Smtp-Source: AGHT+IEq0HpFAdbYoKoNxwFjF5hrl6ar3mEYDoZ/2WaWDU7Y0dC50eiEpClDhBtuHHsfPTK8kXu8kQ==
X-Received: by 2002:a05:600c:8608:b0:431:4c14:abf4 with SMTP id 5b1f17b1804b1-432b7887154mr37537395e9.14.1731108682324;
        Fri, 08 Nov 2024 15:31:22 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bc46751asm9938215e9.0.2024.11.08.15.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 15:31:21 -0800 (PST)
Message-ID: <21c0887b-1c7d-424d-a723-2a8d212cbde1@gmail.com>
Date: Sat, 9 Nov 2024 01:31:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/23] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-3-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-3-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.2024 12:47, Antonio Quartulli wrote:
> This commit introduces basic netlink support with family
> registration/unregistration functionalities and stub pre/post-doit.
> 
> More importantly it introduces the YAML uAPI description along
> with its auto-generated files:
> - include/uapi/linux/ovpn.h
> - drivers/net/ovpn/netlink-gen.c
> - drivers/net/ovpn/netlink-gen.h
> 
> Cc: donald.hunter@gmail.com
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

[skipped]

> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
> --- /dev/null
> +++ b/drivers/net/ovpn/ovpnstruct.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_OVPNSTRUCT_H_
> +#define _NET_OVPN_OVPNSTRUCT_H_
> +
> +#include <net/net_trackers.h>
> +
> +/**
> + * struct ovpn_struct - per ovpn interface state
> + * @dev: the actual netdev representing the tunnel
> + * @dev_tracker: reference tracker for associated dev
> + */
> +struct ovpn_struct {

There is no standard convention how to entitle such structures, so the 
question is basically of out-of-curiosity class. For me, having a 
sturcuture with name 'struct' is like having no name. Did you consider 
to use such names as ovpn_dev or ovpn_iface? Meaning, using a name that 
gives a clue regarding the scope of the content.

For interface functions, when the pointer assigned in such manner as 
`ovpn = netdev_priv(dev)`, it is clear what is inside. But for functions 
like ovpn_peer_get_by_id() it is a bit tricky to quickly realize, what 
is this for.

> +	struct net_device *dev;
> +	netdevice_tracker dev_tracker;
> +};
> +
> +#endif /* _NET_OVPN_OVPNSTRUCT_H_ */

--
Sergey

