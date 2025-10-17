Return-Path: <linux-kselftest+bounces-43365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F08BE68A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 08:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD8E735564F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 06:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10430F7EB;
	Fri, 17 Oct 2025 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZKZ55eRj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AC30E849
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681415; cv=none; b=Qv6HDqZc3MX9WEcmnXCUU3VSoDCqhbKd5uXECWwa7sMDQVHRIlHFKiWx+E9LstiKoX3ZS1SVX2o4NxIbv5TBghyGz4X64lf4oKpFHboe/433uuUKeK4ytlqDhbvVr0Y7Kny2AhzxZB51ldjtPUQuoHAM58oqJAn0d6vBushkoQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681415; c=relaxed/simple;
	bh=tzvj+dF7GYN05CycS5ptnofaexzJ2122giVs3WVtybQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJKjjCRYteqeuu0ZDaGvlonBRSdslCBDCGAB9seN1Y0B+3n2NRG+sxafBIGGc3uyi0Nz2Fm12scyNSPk/DAbptB1dvqqIlLGviKmC+W1jp4gHwpzS4Kd2uIOhmKa9P5Mi103JIe+GjphnZXu5LrCoL5x1aWyrYZbsN+SmZnd1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZKZ55eRj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b4736e043f9so245472866b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 23:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1760681411; x=1761286211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6waZ7M3zINDb7ZucUBWuxq4+vcAnZAQSMKo/t03dBg=;
        b=ZKZ55eRjp2PPbtOSo/tCzyqUvdmFQ0hDpRxmcwnztEoih5nSOM68YyC609ljp1eocw
         4F41+AkJ9sVkyP93wQCR0Ohn63zepCFXW/2b0WjROi2gertFy9ByZXi+rVmvDHp74ML9
         7smAddL56WOWchBc7RRMhl8x3pzbvz5M0l5XCgFKJqtgV0ctEQiROIU7HyaZgHyzLzyX
         QceR3ZRLs9nNY7jMLu+h+M8DSE1j4d+FIcOYixDMVlKVfFfxYX1hd9kY0qiWIjNI4ha0
         x8XoRnSJHIY+xph0WtnBTQ5xe/gnrpH/hM8veNQVmyWDD/AhVsMTGbCq7QutlJ5ys6UT
         NJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681411; x=1761286211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6waZ7M3zINDb7ZucUBWuxq4+vcAnZAQSMKo/t03dBg=;
        b=WoIv/YK53tyObzNtTNXUDhh3625w5hBY1zOM80xGI+lH2tjJGTKPCmEurozghGvRKl
         0AeYbzm9gr0BwLA5qB9msOEHTGQD9uU1l5LkK9vFJL4matG/ER0916hQU09K1sKdb27Z
         yQeHKnn75jO0hmUzBL6tBkdALnCmbn+to5vhze3AlR9HvfiIfxqgEXjAaruuHy12NtKW
         SONdmqszaWb4B/T/HLEcrx19PQ8l1KbNiC0uOVTP2oiI2hmUmHqrdD1fqPMvs00gu+3v
         EF3lYGdVcTfJI3VV7vrs/4Re7IBwczPXFs5K4h8HAI1+65msLGTgrSQcB9Khllj3y4Or
         xzRg==
X-Forwarded-Encrypted: i=1; AJvYcCUF/9GWZ4mNIkqnTrPUtNGrRaXusPuXVC+Nig/5xx+s3CndqAVBwgrJ6N7Q29opwCWke0RUdFD6ZvqabKsgQoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYGaiL9pblNEl5J/JqBAUhVEIuLpWMqsWv7VP41pDWbcHqlNg
	yrPL/bpxa8/B9NlKMej8FGFlpFVJYrnNyd2HssdJ/11A7b1mQGq5JCLcJGWcgIA3IZ4=
X-Gm-Gg: ASbGnctsVLQtfBGNfFRosNFHpmTsGnMXe5HDaxBUGNZEME6gps4mLi3g1GnhfFn+MPw
	70dVaa124qPMzwnwCUbJZkzh74vt70aHbvS6wXVFiG5Qdbd3Kxx9j7s7Eiqdl/JLtMvXmRZ7xBe
	1AquKwIK9mE9zQ5vnsOI2wtBB4I8uLrMV26I+r2+JiFGyZ4aJyTEKzDeAkEaPYCncnOjERihJ6O
	H8Ym3W/WzJERuTrAPIUoybZhaJNIJQTv5dz104sL/hkPmJSPchOLZxK5z97hYX373KFuDLQoG9X
	Kqa4zCN0Z51DJf7kYNjkOGfK4vG8lzKVnhPG6aLMsyexS40Rb/1g+UMTGivOFDiI/+3cOubUbk2
	K0F9D9Ik9eAam81XcB4lFv31GPAydLzIogVFjf/U36k1Mk1MoeFM6pJmpeBFW24x5KbMJzIs8Yb
	MJS2emYP7XMXdkBklckeE/8Id3YXKevFAr9t5becZSqkI=
X-Google-Smtp-Source: AGHT+IECBBefYDxm3VztfrVoSJFgzWCxr6FwbCzBp/zx5ySKXbWRJApWHiTT/WyzbR2JJ2GvkAYP0A==
X-Received: by 2002:a17:907:fd15:b0:b47:de64:df34 with SMTP id a640c23a62f3a-b6474241266mr309874466b.51.1760681410460;
        Thu, 16 Oct 2025 23:10:10 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdaa2c8sm735915766b.46.2025.10.16.23.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 23:10:10 -0700 (PDT)
Message-ID: <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>
Date: Fri, 17 Oct 2025 09:10:09 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: show master index when dumping slave
 info
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 David Ahern <dsahern@gmail.com>, linux-kselftest@vger.kernel.org
References: <20251017030310.61755-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251017030310.61755-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 06:03, Hangbin Liu wrote:
> Currently, there is no straightforward way to obtain the master/slave
> relationship via netlink. Users have to retrieve all slaves through sysfs
> to determine these relationships.
> 

How about IFLA_MASTER? Why not use that?

> To address this, we can either list all slaves under the bond interface
> or display the master index in each slave. Since the number of slaves could
> be quite large (e.g., 100+), it is more efficient to show the master
> information in the slave entry.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_netlink.c | 4 ++++
>  include/uapi/linux/if_link.h       | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 286f11c517f7..ff3f11674a8b 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -29,6 +29,7 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
>  		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
>  		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
>  		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_ACTOR_PORT_PRIO */
> +		nla_total_size(sizeof(u32)) +	/* IFLA_BOND_SLAVE_MASTER */
>  		0;
>  }
>  
> @@ -38,6 +39,9 @@ static int bond_fill_slave_info(struct sk_buff *skb,
>  {
>  	struct slave *slave = bond_slave_get_rtnl(slave_dev);
>  
> +	if (nla_put_u32(skb, IFLA_BOND_SLAVE_MASTER, bond_dev->ifindex))
> +		goto nla_put_failure;
> +
>  	if (nla_put_u8(skb, IFLA_BOND_SLAVE_STATE, bond_slave_state(slave)))
>  		goto nla_put_failure;
>  
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 3b491d96e52e..bad41a1807f7 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1567,6 +1567,7 @@ enum {
>  	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
>  	IFLA_BOND_SLAVE_PRIO,
>  	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
> +	IFLA_BOND_SLAVE_MASTER,
>  	__IFLA_BOND_SLAVE_MAX,
>  };
>  


