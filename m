Return-Path: <linux-kselftest+bounces-38962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C20B26498
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 13:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BEC16A373
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF62F60D3;
	Thu, 14 Aug 2025 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyQakyzR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC3288C81;
	Thu, 14 Aug 2025 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171976; cv=none; b=LyuAEkF+8G8oo4v4iOUmHex8LiMRQf9cV/rHRbW5OZlMvpzutL8+p9I4T3Cw+5awue0wJx4N3iRmfygf32S4qu86FJ7imMXVbNdC57BMlb3xoT1o/zDZOFFZ3fV3rB0BrChXCZFC92zphWk+QdgYl2rXCn5UNczPwJwVuWtVHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171976; c=relaxed/simple;
	bh=EPvdS7aVkBtwB3OhVA+7wiGzFkFTuQ0xT5JdRJ7cvWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJGVS3lVnYRvzXJ0UH+CUFCg1Gk/xIez/AlF8uFustXUu5vS5LkqL/7QKCdjjR3mDDOj/YzD3aqyFgBT9lkjh3AmueDWDKQfFwGZyEUUNkzPdfLuez2EfnE9npP1+U4QyAaejHyIxfPvhAkRfGIwAyJuwZY8XvCPKjulaU1lb/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyQakyzR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so107458666b.3;
        Thu, 14 Aug 2025 04:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755171973; x=1755776773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nlRfwEePLJBrTmXUpP/E3Bax77fjCyq+CaY5BjSJgo=;
        b=IyQakyzRuHh6ghlcoSizosl1W05jnCiumcwD9C9J+0YnEP5V9OXX8zr9Ni9J6ZiXZW
         n75nrkOe7q0l48AuWgzNTSXFKHP98aKurpe8DqWfHhBRYulxK3k5FvqJ77Nw2JVm1PtI
         Ld/8oyypL8UXTBSY6rVHqljBFuz++Yj+5REV3KriQ6i4qmG2I0MlilqY7XHZrKFFhDCc
         ItDAePlOrV6llrefS1crQvucqneGKtbDKTmw2i/uxy7kOTQMAB7EPCNxW/kwFV79dwFq
         OsFHzGeRz+jVxGg/iv2P2kyZqhWZz5v1fx6crolqehm+fSdUy6M4GfPAG8i4aPcOlOQF
         vtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755171973; x=1755776773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nlRfwEePLJBrTmXUpP/E3Bax77fjCyq+CaY5BjSJgo=;
        b=krCNk+oYMSftfRJX6v8i7l4LiW3k8rBaEv6lKN284/UM/Aaa9D5gNv6d1OUz/5q9CY
         UYrG1Te9fZMo6Fot5Tg0gwIItWcDa/7nrROlf4xFbTM9Y7BOvdRMUmOuHDGQb2Z7eHxe
         ngoLCybWNBfoA9cDZQRlBkLgLt4isQFJqXXmeJbwVU1Q+u2TJfAXhyIns7UX7o3EVCFf
         rpeB2mvV1pG7GHgJqT9Jw5HJM0K/HnlYlt4nBC29kzZBBIBuV0o4pBOFpZWQswbwD2yF
         VrrvYCCxcPJyL/B5oaevwkCQZWWVyj5e5gTKQ12VHWYMpheLZEbilFtzJKEELrXnG89d
         3ymQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/VZZAA9zLWKH03/9fIs+sMwL7c+ta4vfWcphW2lG0S/nPcaiNpqOALoxFni/7IyflfoWoyezlGnidBvP0TjPT@vger.kernel.org, AJvYcCVvdzS6Jhc1BLs2pcdOF7k3TqvuAbnN2HqlI3fQ91Ll3sQVE2ni8cmED65RuV9MBaxVBborMH0zc84=@vger.kernel.org, AJvYcCXXaHtdb0AfvWJ015zGq177wwaTulnlSW2xRrZPJvagJVH4+LB2mOhjVbLnEu+P4mRzHugjF2jw@vger.kernel.org
X-Gm-Message-State: AOJu0YxoHTOCV9Fq1406ZPov4N1dkfd97i6hvckF94G8gLxzADIvY8m4
	/KfuAYscs7iW3IdtPRDe7EsXg6vp1oQiUs+Uh0axQOsmk2YvtdJFWd3S
X-Gm-Gg: ASbGncsxclFwDCagqFjcjUF5bf1qHaYoLzdM2k5WPTba4xvbdBn/4EPfkmAXoIhf4EB
	h76aJgSaiIpgU8kliIDGj/pLG3RYM2HY+xRWOiAtSbv0RcticLi4QZ8afmvgBs+jCFryWSWGItH
	n8lMn8pNl1y2AoqGSsQx7GoLM2pDs9p4OkLLdr2Ixwwq3KASYc1YTOa/artyZYjqFWaRmp9cCWQ
	Q32syFHcl5fztd8r+T34wSV/nk8VXMcSjhnG4mdq0+UDod0urfbPXJ+89XAZG2Xq92gveX2ggwP
	qjZrANVvfdSmNEoxL6WzxhcCc+JfiVtlXmqaTtdkHHvXfMEp/1Pf8E3vOnFL5w8hxqXnep5Zhua
	NjzxSARjXveP0us07aD44BF4xyNmytIkEAmEMUWpa473M+g9uhD9VG4F8pjCRdEkWRwXmjdNnyD
	w/j7Sri+M=
X-Google-Smtp-Source: AGHT+IFcNIgWEbldO7XiQAyOiuDDpvpJsZRCwoG05l9vu0kiGbqQ+bpmB/yrTEWAMGKxSxZzCFfjEw==
X-Received: by 2002:a17:907:1c9f:b0:ae3:5e70:32fb with SMTP id a640c23a62f3a-afcb93a233bmr284068266b.4.1755171972570;
        Thu, 14 Aug 2025 04:46:12 -0700 (PDT)
Received: from [192.168.0.2] (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af919e96050sm2561184866b.0.2025.08.14.04.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 04:46:12 -0700 (PDT)
Message-ID: <66bea2a5-b873-4e08-9500-a0093648bc39@gmail.com>
Date: Thu, 14 Aug 2025 13:46:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 1/3] bonding: add support for per-port LACP
 actor priority
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Ahern <dsahern@gmail.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250814104256.18372-1-liuhangbin@gmail.com>
 <20250814104256.18372-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Jonas Gorski <jonas.gorski@gmail.com>
In-Reply-To: <20250814104256.18372-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14.08.25 12:42, Hangbin Liu wrote:
> Introduce a new netlink attribute 'ad_actor_port_prio' to allow setting
> the LACP actor port priority on a per-slave basis. This extends the
> existing bonding infrastructure to support more granular control over
> LACP negotiations.
> 
> The priority value is embedded in LACPDU packets and will be used by
> subsequent patches to influence aggregator selection policies.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/networking/bonding.rst |  9 +++++++
>  drivers/net/bonding/bond_3ad.c       |  2 ++
>  drivers/net/bonding/bond_netlink.c   | 16 +++++++++++++
>  drivers/net/bonding/bond_options.c   | 36 ++++++++++++++++++++++++++++
>  include/net/bond_3ad.h               |  1 +
>  include/net/bond_options.h           |  1 +
>  include/uapi/linux/if_link.h         |  1 +
>  7 files changed, 66 insertions(+)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> index f8f5766703d4..874d8a4681ec 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -193,6 +193,15 @@ ad_actor_sys_prio
>  	This parameter has effect only in 802.3ad mode and is available through
>  	SysFs interface.
>  
> +ad_actor_port_prio
> +
> +	In an AD system, this specifies the port priority. The allowed range
> +	is 1 - 65535. If the value is not specified, it takes 255 as the
> +	default value.
> +
> +	This parameter has effect only in 802.3ad mode and is available through
> +	netlink interface.
> +
>  ad_actor_system
>  
>  	In an AD system, this specifies the mac-address for the actor in
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index 2fca8e84ab10..19b389b81600 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -436,6 +436,7 @@ static void __ad_actor_update_port(struct port *port)
>  
>  	port->actor_system = BOND_AD_INFO(bond).system.sys_mac_addr;
>  	port->actor_system_priority = BOND_AD_INFO(bond).system.sys_priority;
> +	port->actor_port_priority = SLAVE_AD_INFO(port->slave)->port_priority;
>  }
>  
>  /* Conversions */
> @@ -2211,6 +2212,7 @@ void bond_3ad_bind_slave(struct slave *slave)
>  		port->actor_admin_port_key = bond->params.ad_user_port_key << 6;
>  		ad_update_actor_keys(port, false);
>  		/* actor system is the bond's system */
> +		SLAVE_AD_INFO(slave)->port_priority = port->actor_port_priority;

I don't know the code flow well, but the assignment direction here is the
opposite of other values, e.g.

                port->actor_port_number = SLAVE_AD_INFO(slave)->id;

so I would have expected this to be

		port->actor_port_priority = SLAVE_AD_INFO(slave)->port_priority;

Is this intentional?

>  		__ad_actor_update_port(port);
>  		/* tx timer(to verify that no more than MAX_TX_IN_SECOND
>  		 * lacpdu's are sent in one second)
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 57fff2421f1b..3a37298583ed 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -28,6 +28,7 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
>  		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE */
>  		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
>  		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
> +		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO */
>  		0;
>  }
>  
> @@ -77,6 +78,10 @@ static int bond_fill_slave_info(struct sk_buff *skb,
>  					ad_port->partner_oper.port_state))
>  				goto nla_put_failure;
>  		}
> +
> +		if (nla_put_u16(skb, IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO,
> +				SLAVE_AD_INFO(slave)->port_priority))
> +			goto nla_put_failure;


This is an 802.3ad (exclusive) setting, shouldn't this be in the

  if (BOND_MODE(slave->bond) == BOND_MODE_8023AD) { }

block above this?

Regards,
Jonas

