Return-Path: <linux-kselftest+bounces-21711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1622A9C27FB
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 00:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB39B21E11
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 23:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B761E22FB;
	Fri,  8 Nov 2024 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ3ZbYko"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49FA1DFDE;
	Fri,  8 Nov 2024 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731107699; cv=none; b=HBEEz89VluUSv1VieiVYa+KSQc1mT6bsTUPAIFh4k9K3GrG6eWr8v4q5kpJnly0z+t1i4hQ4MnPUl1Bw0kn0gihdeNUaAJ5DYcq6mEQ+RZIPOGvatAtEgtwZPTybdX7kccK9JDq8Y5cRK1kijoNnoS/0P0zb9h7pwk2TDCBosUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731107699; c=relaxed/simple;
	bh=jtQ4gWG5W6gUv0wlYP+NfwQPWp2o+RPaPgjDPHfmF50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaNliE2pqM5rkyoOrokcG2A+REcbopuQgjgQTpxpS9Ix7B3BvV57KbH6wQxJ0zCSAIXejK67aWCc1LSlcexCaKLTTxStMwqHFp+Uc9XuaoV8n4sDlo2ow25EmbBVKPQ+LDI6vp69/PCMLaA0IVkhGK5b1vTtCpNoGaDvMaIliKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJ3ZbYko; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4c482844so1686204f8f.0;
        Fri, 08 Nov 2024 15:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731107696; x=1731712496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtXcEOPCg2ocd09XknNFCZnpRJHrxr/6pg0EmGnAWYE=;
        b=aJ3ZbYkoIqWb0OuByeuQsDFQan8TSNUJY1CcyBazruA6KI6n9SXoo5FzZqbPxl3Vxk
         tfwV+C/E1oNTfvrGs1DhM1/SjuwKEs0u3eRiD4w/ghaBvalLAoNQZuM+34e2yUmXBRH5
         vCAIC/6Raf2P8FCxt/ipVvbBbFHouv8QnS0X9lCyUrWjOlfS1GNrMFjoVf+I9F6QrJn5
         BDSJWmWBN1CZ60bgPV9DrAGjQlfJPAoH/HbY0Pd29RsQ34ckL8rUzULJPphiKcEA5to8
         D5S9BoOobMiG0a+kdJjNBlbiI8U/LJG875gkz3LWTwxCeJEIABWuqZgSDlU/HWcLjYJx
         0Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731107696; x=1731712496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtXcEOPCg2ocd09XknNFCZnpRJHrxr/6pg0EmGnAWYE=;
        b=cL9SRx3AvC2DDU4JrsOxtKFKlaewZkhb3FGm9OLD+zRCcWZ6HHJPDf1qN+vldtHp2M
         sQqMVovEmxIwgqFW2hxLDY9OdLjJ/qOsbkEtFubAaBKrMugsffl4ah0TGncwUc835IWi
         GhbalXDdqPKkOuItFwUtcrbh/xCSENsM8uzC6ga/z1oVj5x8qPHv9pWdVu5gBEF9LfEl
         ub72rTdfmd0HXNaL3nRdVXcXixU+tTLdsov5+UsTjABj0haaCmz0GblZ+R++A8cJnnpN
         6nfLwogBNDbV6jvOJFXRA9Hda0z7jOtSglN7DYLxqq6MCt2lfFv4PXNRP5JtpEKjJ6nt
         tsFA==
X-Forwarded-Encrypted: i=1; AJvYcCU+oB69FtKskmIxw63V7cI8ADqmxl/vv2/nZtgqxCxlWqwFIZTRJKsDhBhpFHvFcdQ7aXRJdiCJ3UpHRCI=@vger.kernel.org, AJvYcCVie9Tc79tUgwdoxXh96dAnjtKV+ZBCNt8erP3K69CrYIFeJJJ9yaIX4p5Y8DIFVz/biwTcUMcE@vger.kernel.org, AJvYcCX/2tn2yADBFuWpOx+47QhhupgF7MjpjsOTtXmdsGyMh/wEkf1qHyMfq2zJVD7KHUe93HAOCzW5AfmOb/7qsbJC@vger.kernel.org
X-Gm-Message-State: AOJu0YzDiv8HzpXuFnQduiaoECQRwDAwKbdsgNSp1vGvNu5slPm6aIRw
	tRh48fd3RAXh1rK80OlWR6TwBGJ3OAwtxM1VysdAa8ZsZvP1PL3P
X-Google-Smtp-Source: AGHT+IHOQuLBkuZsjEvmIHmHhCEAUx5L8g/Fv+AQv+jyeqZbdnDIhsVZWXcIKesQd6WF3Y5aLEPVaQ==
X-Received: by 2002:a5d:64e5:0:b0:37d:511b:aecc with SMTP id ffacd0b85a97d-381f188c829mr3911211f8f.54.1731107695811;
        Fri, 08 Nov 2024 15:14:55 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5871sm86002445e9.37.2024.11.08.15.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 15:14:55 -0800 (PST)
Message-ID: <52a2f654-29e5-4567-b5f8-8362fa55c1e1@gmail.com>
Date: Sat, 9 Nov 2024 01:15:23 +0200
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

> diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml

[skipped]

> +attribute-sets:
> +  -
> +    name: peer
> +    attributes:
> +      -
> +        name: id
> +        type: u32
> +        doc: |
> +          The unique ID of the peer. To be used to identify peers during
> +          operations

nit: could you specify the scope of uniqueness? I believe it is not 
globally uniq, it is just interface uniq, right?

> +        checks:
> +          max: 0xFFFFFF

[skipped]

> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index 369a5a2b2fc1a497c8444e59f9b058eb40e49524..d5bdb0055f4dd3a6e32dc6e792bed1e7fd59e101 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -7,11 +7,15 @@
>    *		James Yonan <james@openvpn.net>
>    */
>   
> +#include <linux/genetlink.h>
>   #include <linux/module.h>
>   #include <linux/netdevice.h>
>   #include <net/rtnetlink.h>
> +#include <uapi/linux/ovpn.h>
>   
> +#include "ovpnstruct.h"
>   #include "main.h"
> +#include "netlink.h"
>   #include "io.h"
>   
>   /* Driver info */
> @@ -37,7 +41,7 @@ static int ovpn_newlink(struct net *src_net, struct net_device *dev,
>   }
>   
>   static struct rtnl_link_ops ovpn_link_ops = {
> -	.kind = "ovpn",
> +	.kind = OVPN_FAMILY_NAME,

nit: are you sure that the link kind is the same as the GENL family? I 
mean, they are both deriviated from the protocol name that is common for 
both entities, but is it making RTNL kind a derivative of GENL family?

>   	.netns_refund = false,
>   	.newlink = ovpn_newlink,
>   	.dellink = unregister_netdevice_queue,
> @@ -93,8 +97,16 @@ static int __init ovpn_init(void)
>   		goto unreg_netdev;
>   	}

--
Sergey

