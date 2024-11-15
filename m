Return-Path: <linux-kselftest+bounces-22093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D19CDEC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 14:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217F4283AFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999761BDAA1;
	Fri, 15 Nov 2024 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F9NLg249"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38FF1BDA8F
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675611; cv=none; b=E9i0nv5I15Vz7uCV8kNa3CElh486GRibOmYXSIShQFsY7NpKZSrE7iDcqIKS1iES9GiKfqBX5ttC9IdP6bnHml3LI9PiP6w6cc+BC5yCVn9fB91A3Oe4c3VMSuYm31npiWWhNok37Oi3EGBUMYCuyLRtuSeNNsRueNSexZ9IzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675611; c=relaxed/simple;
	bh=zqkdSLDk0bO2OpkEvLkCF2ppLSkpejyNpAvWaPjh6vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axDii66Xz19CGjn//0LH90HsWd0tpdX31inQbg7MlLlbuSpUfwEik+Sqk7jw0coWqVglm9nFUu4kHIXHsSSOCQx6jClEVS33vC7swZ/nnqiiSjhNdLVeieu24Ta1Fyok1HkVTbDoipe5pzxEBvwfqyzXKPjPtQ69NLtRgTivVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F9NLg249; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38207c86695so1285840f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Nov 2024 05:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731675606; x=1732280406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VLNEslv9HCHacJ55c059nrmW06RatWGHFhpMRHITDeo=;
        b=F9NLg249LsBOefY4nDVygEXfMXWvy9LbcCFdNlF/e5sNP1VXbhbGB0K9Ml885CEzB4
         ypf67Tc+3trI1GSnQSHo3MbgMv6QBeoB7HfTFZ1iAoJhrCetxip1A2h9cjmpmt7hN6ix
         UiP1f0DsDwVRo7P2bSyVGFXpfNsAVH631nSMXH51AdKwM2ZP2oVG8bcNREWeMel2Eswg
         ouzEMoCUFUOt/O7MZqbJrZxpD+2E/seQbS54GPHT21Ej3m+oogSlUFal6eTO/Sbfc8t2
         4e3L++kLrnKMvs9n3QC9TNYx0MwUN592X+SsFd9Ro/c3xtC0P6T8EGHYJrxCu4Y7tR9N
         4rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731675606; x=1732280406;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLNEslv9HCHacJ55c059nrmW06RatWGHFhpMRHITDeo=;
        b=jNnlBMnccBqjvHbVxhkm3OkGGP0NOoKHz0uynA8OICMwia6AeyMIQMPt7USGl8rVhK
         k7P7h+e8r2zM1MnHYNUH/uLO18kjXj1thj2Khm6PYo2EXgw7M/olCI8BCnoyk654Rl02
         wXPhYih+oSUbPArbyyb+8shUwAbj/VdMcQULRxOsJn/z4ThAb3GyhJSEnk7q06dIXsPI
         sGZX1OUBc7FZKchf6ihP6GaI8olvBuwO6QzUQj7pt+t1YznCBc1Z3ZkEkp+qa9NiJSD0
         O/TZHW0a/Uowqxqx2kB5HNsZDAfrXZ3Mg4v2NrykK7YH99FTZgRnt+XBkMqE0IFDMcja
         ueFw==
X-Forwarded-Encrypted: i=1; AJvYcCU52CymbYMNIz9JkUYTjwVdZ4+VixDbOEgkLugcnJQhZq/t0/Ter4UsmLtfmV/mqhfzg4KAMj2JxaJpZfY/VOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXTeS+0eQ70aSkDeoLBuHmRnrcjJxep0Tzjcs4xQO15Hx0LkQ
	qJK1R6CHOVkrucz2zr+KseHQ15fqLhuNXE/eUeyG5u56Zc3yJ0aPXwORPhoF7HgYqE7OBpD5Ccq
	P
X-Google-Smtp-Source: AGHT+IG5g2doyh75robqU7KPhJCKq/9B/W2SYrwmzB29tOhOc+RzA2hEaEBv6O6kV4WhhqamoelBYw==
X-Received: by 2002:a05:6000:1543:b0:382:228b:4c34 with SMTP id ffacd0b85a97d-382258f0863mr1996435f8f.2.1731675606229;
        Fri, 15 Nov 2024 05:00:06 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:59f4:10be:886a:27eb? ([2001:67c:2fbc:1:59f4:10be:886a:27eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adad945sm4266176f8f.29.2024.11.15.05.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 05:00:05 -0800 (PST)
Message-ID: <cfd45410-a7b2-4304-a376-1d7a3b443a13@openvpn.net>
Date: Fri, 15 Nov 2024 14:00:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, Andrew Lunn <andrew@lunn.ch>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
 <2fd3dc9c-9d6a-494c-a4d8-a45221bf250d@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <2fd3dc9c-9d6a-494c-a4d8-a45221bf250d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/11/2024 02:01, Sergey Ryazanov wrote:
> On 29.10.2024 12:47, Antonio Quartulli wrote:
>> Add basic infrastructure for handling ovpn interfaces.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   drivers/net/ovpn/main.c       | 115 ++++++++++++++++++++++++++++++++ 
>> ++++++++--
>>   drivers/net/ovpn/main.h       |   7 +++
>>   drivers/net/ovpn/ovpnstruct.h |   8 +++
>>   drivers/net/ovpn/packet.h     |  40 +++++++++++++++
>>   include/uapi/linux/if_link.h  |  15 ++++++
>>   5 files changed, 180 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> index 
>> d5bdb0055f4dd3a6e32dc6e792bed1e7fd59e101..eead7677b8239eb3c48bb26ca95492d88512b8d4 100644
>> --- a/drivers/net/ovpn/main.c
>> +++ b/drivers/net/ovpn/main.c
>> @@ -10,18 +10,52 @@
>>   #include <linux/genetlink.h>
>>   #include <linux/module.h>
>>   #include <linux/netdevice.h>
>> +#include <linux/inetdevice.h>
>> +#include <net/ip.h>
>>   #include <net/rtnetlink.h>
>> -#include <uapi/linux/ovpn.h>
>> +#include <uapi/linux/if_arp.h>
>>   #include "ovpnstruct.h"
>>   #include "main.h"
>>   #include "netlink.h"
>>   #include "io.h"
>> +#include "packet.h"
>>   /* Driver info */
>>   #define DRV_DESCRIPTION    "OpenVPN data channel offload (ovpn)"
>>   #define DRV_COPYRIGHT    "(C) 2020-2024 OpenVPN, Inc."
>> +static void ovpn_struct_free(struct net_device *net)
>> +{
>> +}
> 
> nit: since this handler is not mandatory, its introduction can be moved 
> to the later patch, which actually fills it with meaningful operations.


ehmm sure I will move it



> 
>> +static int ovpn_net_open(struct net_device *dev)
>> +{
>> +    netif_tx_start_all_queues(dev);
>> +    return 0;
>> +}
>> +
>> +static int ovpn_net_stop(struct net_device *dev)
>> +{
>> +    netif_tx_stop_all_queues(dev);
>> +    return 0;
>> +}
>> +
>> +static const struct net_device_ops ovpn_netdev_ops = {
>> +    .ndo_open        = ovpn_net_open,
>> +    .ndo_stop        = ovpn_net_stop,
>> +    .ndo_start_xmit        = ovpn_net_xmit,
>> +};
>> +
>> +static const struct device_type ovpn_type = {
>> +    .name = OVPN_FAMILY_NAME,
> 
> nit: same question here regarding name deriviation. Are you sure that 
> the device type name is the same as the GENL family name?

Like I said in the previous patch, I want all representative strings to 
be "ovpn", that is already the netlink family name.
But I can create another constant to document this explicitly.


> 
>> +};
>> +
>> +static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
>> +    [IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
>> +                        OVPN_MODE_MP),
>> +};
>> +
>>   /**
>>    * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
>>    * @dev: the interface to check
>> @@ -33,16 +67,76 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
>>       return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
>>   }
>> +static void ovpn_setup(struct net_device *dev)
>> +{
>> +    /* compute the overhead considering AEAD encryption */
>> +    const int overhead = sizeof(u32) + NONCE_WIRE_SIZE + 16 +
> 
> Where are these magic sizeof(u32) and '16' came from?

It's in the "nice diagram" you commented later in this patch :-)
But I can extend the comment.

[...]


>> @@ -51,26 +145,37 @@ static int ovpn_netdev_notifier_call(struct 
>> notifier_block *nb,
>>                        unsigned long state, void *ptr)
>>   {
>>       struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>> +    struct ovpn_struct *ovpn;
>>       if (!ovpn_dev_is_valid(dev))
>>           return NOTIFY_DONE;
>> +    ovpn = netdev_priv(dev);
> 
> nit: netdev_priv() returns only a pointer, it is safe to fetch the 
> pointer in advance, but do not dereference it until we are sure that an 
> event references the desired interface type. Takin this into 
> consideration, the assignment of private data pointer can be moved above 
> to the variable declaration. Just to make code couple of lines shorter.

I do it here because it seems more "logically correct" to retrieve the 
priv pointer after having confirmed that this is a ovpn interface with 
ovpn_dev_is_valid().

Moving it above kinda says "I already know there is a ovpn object here", 
but this is not the case until after the valid() check. So I prefer to 
keep it here.

[...]

>> --- a/drivers/net/ovpn/main.h
>> +++ b/drivers/net/ovpn/main.h
>> @@ -12,4 +12,11 @@
>>   bool ovpn_dev_is_valid(const struct net_device *dev);
>> +#define SKB_HEADER_LEN                                       \
>> +    (max(sizeof(struct iphdr), sizeof(struct ipv6hdr)) + \
>> +     sizeof(struct udphdr) + NET_SKB_PAD)
>> +
>> +#define OVPN_HEAD_ROOM ALIGN(16 + SKB_HEADER_LEN, 4)
> 
> Where is this magic '16' came from?

should be the same 16 af the over head above (it's the auth tag len)
Will make this more explicit with a comment.

> 
>> +#define OVPN_MAX_PADDING 16
>> +
>>   #endif /* _NET_OVPN_MAIN_H_ */
>> diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ 
>> ovpnstruct.h
>> index 
>> e3e4df6418b081436378fc51d98db5bd7b5d1fbe..211df871538d34fdff90d182f21a0b0fb11b28ad 100644
>> --- a/drivers/net/ovpn/ovpnstruct.h
>> +++ b/drivers/net/ovpn/ovpnstruct.h
>> @@ -11,15 +11,23 @@
>>   #define _NET_OVPN_OVPNSTRUCT_H_
>>   #include <net/net_trackers.h>
>> +#include <uapi/linux/if_link.h>
>> +#include <uapi/linux/ovpn.h>
>>   /**
>>    * struct ovpn_struct - per ovpn interface state
>>    * @dev: the actual netdev representing the tunnel
>>    * @dev_tracker: reference tracker for associated dev
>> + * @registered: whether dev is still registered with netdev or not
>> + * @mode: device operation mode (i.e. p2p, mp, ..)
>> + * @dev_list: entry for the module wide device list
>>    */
>>   struct ovpn_struct {
>>       struct net_device *dev;
>>       netdevice_tracker dev_tracker;
>> +    bool registered;
>> +    enum ovpn_mode mode;
>> +    struct list_head dev_list;
> 
> dev_list is no more used and should be deleted.

ACK

[...]

>> +
>> +/* OpenVPN nonce size */
>> +#define NONCE_SIZE 12
> 
> nit: is using the common 'OVPN_' prefix here and for other constants any 
> good idea? E.g. OVPN_NONCE_SIZE. It can give some hints where it comes 
> from for a code reader.

ACK

> 
> And another one question. Could you clarify in the comment to this 
> constant where it came from? AFAIU, these 12 bytes is the expectation of 
> the nonce size of AEAD crypto protocol, rigth?

Correct: 12bytes/96bits. Will extend the comment.

> 
>> +
>> +/* OpenVPN nonce size reduced by 8-byte nonce tail -- this is the
>> + * size of the AEAD Associated Data (AD) sent over the wire
>> + * and is normally the head of the IV
>> + */
>> +#define NONCE_WIRE_SIZE (NONCE_SIZE - sizeof(struct ovpn_nonce_tail))
> 
> If the headers and IV are defined as structures, we no more need this 
> constant since the header construction will be done by a compiler 
> according to the structure layout.

yap yap. Will do this later as explained in the other email.

> 
>> +/* Last 8 bytes of AEAD nonce
>> + * Provided by userspace and usually derived from
>> + * key material generated during TLS handshake
>> + */
>> +struct ovpn_nonce_tail {
>> +    u8 u8[OVPN_NONCE_TAIL_SIZE];
>> +};
> 
> Why do you need a dadicated structure for this array? Can we declare the 
> corresponding fields like this:
> 
> u8 nonce_tail_xmit[OVPN_NONCE_TAIL_SIZE];
> u8 nonce_tail_recv[OVPN_NONCE_TAIL_SIZE];
> 

I think the original reason was to have something to pass to sizeof() 
without making it harder for the reader.

At some point I also wanted to get rid of the struct,but something 
stopped me. Not sure what was though. Will give it a try.


Thanks a lot.
Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


