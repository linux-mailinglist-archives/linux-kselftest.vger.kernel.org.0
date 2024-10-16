Return-Path: <linux-kselftest+bounces-19848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833759A0C8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 16:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B380FB24F58
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A55320C013;
	Wed, 16 Oct 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Gp2v7ciE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E7502BE
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088648; cv=none; b=rVFholwqQp0Y0kjDZ+/gsDucBfdbmJyXs8Hg9ybto8GvKbwdA23sUsJBeYot62gqJaBrBbHYGFfugk6J6RaMGV1nUX57tkbO5YGWcJnX8NExixSvYayeCKpzL+D6LiynleSdzDLcxyu6lq0SZm/TsM+S3cIbltPPOv1nHkdDVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088648; c=relaxed/simple;
	bh=vPgCKlp/fkdCqoo25YhOZH+lCfLuAqTff6zAEe4hdhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpfdWChEvamgYBjgmFy3tL4X+HNjXlGKA5Y9OzoR+RMYJUomjCkq/syUmNefiwdh8Op7QPc25ErJtW+yPLMqQm/4Rc0szcS++AbFKuWSkJEBRt7+jDdn64ZuLbC0t0imm3E7a5O5yTaUsFeS9FZcjFXVxzP6YYYLqMRv406rbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Gp2v7ciE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so2385093f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1729088643; x=1729693443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xqaxYfVYHtTEYM/dunJ7hIKbCemvQpX6A9xYcV7v7Jo=;
        b=Gp2v7ciEJhLGDLCNQQnX820T1pHs4luaCKZcKeynI9F22H31VBG16c6Hoy4pKrywdF
         TUFvDwc03mTdBtSwDX+m7x3LLJjgr+KPLCu0AUqgqJH8KldI5YauoBYFjUiIAdvc1kj2
         48N3nh1njD+uL0uCFLc1iqGKuO//b+ywvgUuopL7x1eC1K7nGlCaeFN+ao4tcQhhtMZG
         Jw8P6WZn9daE6w4i+03BJf/M2o7QFFeYUvzkCoWiE6SUw+MGtEn8F5KwzzMEj5nIP5cb
         7PTT8txZpSBu+bHWSQ55g+QQI3iN2hdm45GzHpdME/6eE9OtKD4zhz1EGyNF6WTxJknp
         xlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088643; x=1729693443;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqaxYfVYHtTEYM/dunJ7hIKbCemvQpX6A9xYcV7v7Jo=;
        b=QIIO+4JLunDcXp9OdRWNOQqStt8R31edtLYS7nsqKHh/qvRMcY0Z1ADOxqT5wH2PyA
         a2oB9K9lb3b4v+x2XaA1prqewdDNkG2RDZQIAexGgrk3Mf47kvYexjZxu10iwzRV9DDE
         yiJE5A9TVWYK75eq0tCYnhpfhLSo45DNOmHTWGg7Lo4q02qIH/q0HXF0o8Swid8h0VN8
         9gZr6RCidlNIr2hXkVNpxn/N/GlJJSjPAVPpwMJ02gh2fUPYY22QALR7Ps4KZGsVSgXe
         dhyld9GUnzXlCX7nNcdIzc7BDBkyfUbkA7CrZQd9wKAQ1sGfPNMzNya3K1t9rAgCRBBl
         iUjA==
X-Forwarded-Encrypted: i=1; AJvYcCW5gC0dM7sqbjsceYCUWVBsnfqipnSLaVXkROcVWNjfBQE2rpGOFXGbI1K6hm2xuJaR1wfxQZZJV81G4FhtXOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lavY1uT5Bi/TbF4Z8/0lkY5Tb6nLJbxR+GtqPcXLC9/Ghgrd
	Cr0lzTBl/A8GJQstxh/9DTjb62B80PUEgLDA6IlZX0uBFqWvDJFG7Dqchf5cAH8XkUp1t9r8SIw
	O
X-Google-Smtp-Source: AGHT+IFuG8N98Jj4LDTvTNhKOp3goLcQvvJir6NR+6bYYNpkfJTPphpDDkVGXyDbvEj0os7chUA1Sg==
X-Received: by 2002:a5d:5310:0:b0:37d:481e:8e29 with SMTP id ffacd0b85a97d-37d5ff3020emr8831268f8f.25.1729088643169;
        Wed, 16 Oct 2024 07:24:03 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e5be:11e:5baa:6774? ([2001:67c:2fbc:1:e5be:11e:5baa:6774])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf819dsm4413626f8f.85.2024.10.16.07.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 07:24:02 -0700 (PDT)
Message-ID: <e8e46092-c954-4579-9bdc-563bf30f68f5@openvpn.net>
Date: Wed, 16 Oct 2024 16:24:09 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
 <20241016-b4-ovpn-v9-4-aabe9d225ad5@openvpn.net>
 <Zw947Jb637o-I4RV@nanopsycho.orion>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zw947Jb637o-I4RV@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2024 10:27, Jiri Pirko wrote:
> Wed, Oct 16, 2024 at 03:03:04AM CEST, antonio@openvpn.net wrote:
>> Add basic infrastructure for handling ovpn interfaces.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>> drivers/net/ovpn/main.c       | 115 ++++++++++++++++++++++++++++++++++++++++--
>> drivers/net/ovpn/main.h       |   7 +++
>> drivers/net/ovpn/ovpnstruct.h |   8 +++
>> drivers/net/ovpn/packet.h     |  40 +++++++++++++++
>> include/uapi/linux/if_link.h  |  15 ++++++
>> 5 files changed, 180 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> index d5bdb0055f4dd3a6e32dc6e792bed1e7fd59e101..eead7677b8239eb3c48bb26ca95492d88512b8d4 100644
>> --- a/drivers/net/ovpn/main.c
>> +++ b/drivers/net/ovpn/main.c
>> @@ -10,18 +10,52 @@
>> #include <linux/genetlink.h>
>> #include <linux/module.h>
>> #include <linux/netdevice.h>
>> +#include <linux/inetdevice.h>
>> +#include <net/ip.h>
>> #include <net/rtnetlink.h>
>> -#include <uapi/linux/ovpn.h>
>> +#include <uapi/linux/if_arp.h>
>>
>> #include "ovpnstruct.h"
>> #include "main.h"
>> #include "netlink.h"
>> #include "io.h"
>> +#include "packet.h"
>>
>> /* Driver info */
>> #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
>> #define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
>>
>> +static void ovpn_struct_free(struct net_device *net)
>> +{
>> +}
>> +
>> +static int ovpn_net_open(struct net_device *dev)
>> +{
>> +	netif_tx_start_all_queues(dev);
>> +	return 0;
>> +}
>> +
>> +static int ovpn_net_stop(struct net_device *dev)
>> +{
>> +	netif_tx_stop_all_queues(dev);
>> +	return 0;
>> +}
>> +
>> +static const struct net_device_ops ovpn_netdev_ops = {
>> +	.ndo_open		= ovpn_net_open,
>> +	.ndo_stop		= ovpn_net_stop,
>> +	.ndo_start_xmit		= ovpn_net_xmit,
>> +};
>> +
>> +static const struct device_type ovpn_type = {
>> +	.name = OVPN_FAMILY_NAME,
>> +};
>> +
>> +static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
>> +	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
>> +					    OVPN_MODE_MP),
>> +};
>> +
>> /**
>>   * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
>>   * @dev: the interface to check
>> @@ -33,16 +67,76 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
>> 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
>> }
>>
>> +static void ovpn_setup(struct net_device *dev)
>> +{
>> +	/* compute the overhead considering AEAD encryption */
>> +	const int overhead = sizeof(u32) + NONCE_WIRE_SIZE + 16 +
>> +			     sizeof(struct udphdr) +
>> +			     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
>> +
>> +	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
>> +				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
>> +				 NETIF_F_HIGHDMA;
>> +
>> +	dev->needs_free_netdev = true;
>> +
>> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
>> +
>> +	dev->netdev_ops = &ovpn_netdev_ops;
>> +
>> +	dev->priv_destructor = ovpn_struct_free;
>> +
>> +	dev->hard_header_len = 0;
>> +	dev->addr_len = 0;
>> +	dev->mtu = ETH_DATA_LEN - overhead;
>> +	dev->min_mtu = IPV4_MIN_MTU;
>> +	dev->max_mtu = IP_MAX_MTU - overhead;
>> +
>> +	dev->type = ARPHRD_NONE;
>> +	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
>> +	dev->priv_flags |= IFF_NO_QUEUE;
>> +
>> +	dev->lltx = true;
>> +	dev->features |= feat;
>> +	dev->hw_features |= feat;
>> +	dev->hw_enc_features |= feat;
>> +
>> +	dev->needed_headroom = OVPN_HEAD_ROOM;
>> +	dev->needed_tailroom = OVPN_MAX_PADDING;
>> +
>> +	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
>> +}
>> +
>> static int ovpn_newlink(struct net *src_net, struct net_device *dev,
>> 			struct nlattr *tb[], struct nlattr *data[],
>> 			struct netlink_ext_ack *extack)
>> {
>> -	return -EOPNOTSUPP;
>> +	struct ovpn_struct *ovpn = netdev_priv(dev);
>> +	enum ovpn_mode mode = OVPN_MODE_P2P;
>> +
>> +	if (data && data[IFLA_OVPN_MODE]) {
>> +		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
> 
> Some sanity check perhaps? "validate" op is here for that purpose.

Isn't the parsing happening here enough

https://elixir.bootlin.com/linux/v6.12-rc3/source/net/core/rtnetlink.c#L3659

The IFINFO_DATA is parsed using the policy I provided (which comes with 
limits for the mode attribute).

Or am I misreading the code and I still need to provide an 
implementation for .validate?

Regards,

> 
> 
>> +		netdev_dbg(dev, "setting device mode: %u\n", mode);
>> +	}
>> +
>> +	ovpn->dev = dev;
>> +	ovpn->mode = mode;
>> +
>> +	/* turn carrier explicitly off after registration, this way state is
>> +	 * clearly defined
>> +	 */
>> +	netif_carrier_off(dev);
>> +
>> +	return register_netdevice(dev);
> 
> [...]

-- 
Antonio Quartulli
OpenVPN Inc.


