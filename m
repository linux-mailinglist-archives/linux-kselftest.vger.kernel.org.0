Return-Path: <linux-kselftest+bounces-29192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0807A6472C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B986F1724CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FB722259D;
	Mon, 17 Mar 2025 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OwbuXlLD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8761C861C
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203442; cv=none; b=AjqmzV1zpP4+4fFLvrV2PFpMG1+n78+QvOigO9nTK54N9/PpHcEb5eRu17dWxkt0o9ZAXxxYh11WhAOqa3GUWjc9uJQaTvEUwPEXti5K9w3fsdrsrRfah4ILdROYAbVvrW8AM1aZibgnTasv7OnhlN3huhjwHL2fvyMSUagRMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203442; c=relaxed/simple;
	bh=EVq1AhucL0DSGBtjqCNwBk9bQ+p1L1JBDrICPMXBitY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CB4y/+qwCuPuL00qy4ujnRIJ7sZog1rjN3nmEP0ZZYxO9Hw9x8ltv6/aFrBCk1qaGU6wrA9kNOhPF+8iretK05Wuem0s0WI2Ns375t8JxAa803wbKCpnvqcmb2AgwQISCM+cl6vcBpXyWsf1Gko+eWhSYjl4YHw7H72FlnOCd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OwbuXlLD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2c663a3daso182203866b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 02:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742203438; x=1742808238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WiCx14/fbOpW7YT89TZj+10cBQJw3y3n1vD7ajH4XHY=;
        b=OwbuXlLD7e41dVYezsTOgT1fBYR5ARQqcbB8eDUiKqwGRD3d24IvSsQWF8STTXp6zF
         DCgNePEtVT23aeAAcuHRHqAujAeQoPGydACZcpMG4bJl1/gee1sxSMFrQkbI63hH2Aim
         yLzh7qnmSRWzo+lLlaJnhn0wxBh85MFUoH42cSRcxbxVJ6lYO0D8I2EZ6jVEAIYWvWpm
         wI1cgIgQDpQu4fFMgplecijo8AKwNcdGXGcr7+QiuuIHa+8WzmTh7ZIif7v3XMB2g69P
         kjUPVOJehfF8/s8UjUywhFiyao1k2V9ajvXs9T/CDhm5FDmkAB2gam7hEllgk5booIO8
         fzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203438; x=1742808238;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiCx14/fbOpW7YT89TZj+10cBQJw3y3n1vD7ajH4XHY=;
        b=hydxQPmFbkmAExiErYGxiVofwW81mzhOMwDx+bRQtzuk1+1GPGMf7ot+i7d8yXhwtN
         KXiQuJAYuYtkUF6l7eGe6+k9Hv+77zW+f5P/nM+Vmx6hBe9wECEpoi85TOeG0l1UOPlW
         weslA0ifa/GdXpE195XqWsg7QcZyiX2GmTZn58rU1mMzRFiiRFhC3ZSI44TauniZl7WH
         X+/OysPzyvVP7ZZKumNCXEZaZfu6lngJe0Ai66q9B8D8uCCyVqJHxIaddPwBuRp9rOq9
         vjQF/AZkdB10vDCFZACGVrlybA8r7noP62QAQ/IsIZovTU6p44NCUSLQa9bAMJucRLOD
         oeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5/ZBE/sdH+m2zXemF0PxGfu0WOzNS9ZCAF1CyPJnhRrwUBzVSSQvzF03ggtkehdLa0iV9+0alYPqB7OvjJJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fqTBAdHJmxH55SzdOhwmDMOh+TLM0r6mKgUSd+RWkVD7Uste
	BUBnAOY/CWJf8CJeLqJte10SZYN2jeIdrOEJXObgo9KLaIS3P5mtWl+nMvXqllLwPUrZpAQybIC
	sCtxiCCMN4OH4dKpvWaJK0UAU5gHbT+im0peMws+MEE5CNMJpBSpRqm+iljk=
X-Gm-Gg: ASbGncueOdum/tZMKoZBSC6PdPSrAzsDnIcsfnrgBepULRMs7JNHzAyH2P1reRHpSHw
	kGFgk061QaTkq+iDYuqgr5/WbZ0lRwe+czbYfwUxlmxpASUqRHHz8rO1egn6OJqpmpuO1n7k2fJ
	/EeoBCFvquUeutvgFTfbm6J56ztqB7fFU5vv+Ud2JP2dz2PmsBccPLNrAYvuEhEYHSz1EPhdJUD
	gUKu2up8n+l5YY/wX3MOdC+xztKmG8RnpjSrB9GL9tOstmqWAzA2crdlMbR/9cC8BVDfXODQgrF
	QrwINZ0P2tdhC7K12kSyosg60eZznNgrhYz6K8B3O1OuM2s4pJEYmONfndG3P9FN7jfEvQdjAlf
	8MEGXDRo=
X-Google-Smtp-Source: AGHT+IErvInbMhT7sGTTX0jJhg0JlOT6PImo4k31XW/PWatNvrne26uyWDQoJh/nc1ZBX2hWlTdBaQ==
X-Received: by 2002:a17:906:4795:b0:ac3:17bb:34f8 with SMTP id a640c23a62f3a-ac330108af4mr1375864166b.4.1742203437660;
        Mon, 17 Mar 2025 02:23:57 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:23e9:a6ad:805e:ca75? ([2001:67c:2fbc:1:23e9:a6ad:805e:ca75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a489e0sm626534366b.151.2025.03.17.02.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 02:23:57 -0700 (PDT)
Message-ID: <f4c9a29f-a5c6-464a-a659-c7ffeaf123c1@openvpn.net>
Date: Mon, 17 Mar 2025 10:23:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 03/23] ovpn: add basic interface
 creation/destruction/management routines
To: Qingfang Deng <dqfext@gmail.com>
Cc: andrew+netdev@lunn.ch, donald.hunter@gmail.com, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, sd@queasysnail.net, shaw.leon@gmail.com,
 shuah@kernel.org
References: <20250312-b4-ovpn-v23-3-76066bc0a30c@openvpn.net>
 <20250317060947.2368390-1-dqfext@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250317060947.2368390-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Qingfang and thanks for chiming in,

On 17/03/2025 07:09, Qingfang Deng wrote:
> Hi Antonio,
> 
> On Wed, 12 Mar 2025 21:54:32 +0100, Antonio Quartulli Wrote:
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> index 28133e7e15e74b8a4a937ed03f70d9f83d7a14c8..e71183e6f42cd801861caaec9eb0f6828b64cda9 100644
>> --- a/drivers/net/ovpn/main.c
>> +++ b/drivers/net/ovpn/main.c
>> @@ -10,14 +10,42 @@
>>   #include <linux/genetlink.h>
>>   #include <linux/module.h>
>>   #include <linux/netdevice.h>
>> +#include <linux/inetdevice.h>
>> +#include <net/ip.h>
>>   #include <net/rtnetlink.h>
>> -#include <uapi/linux/ovpn.h>
>> +#include <uapi/linux/if_arp.h>
>>   
>>   #include "ovpnpriv.h"
>>   #include "main.h"
>>   #include "netlink.h"
>> +#include "io.h"
>> +#include "proto.h"
>> +
>> +static int ovpn_net_open(struct net_device *dev)
>> +{
>> +	netif_tx_start_all_queues(dev);
> 
> This is not required as the virtual interface does not have a queue
> (marked as IFF_NO_QUEUE).

ACK

> 
>> +	return 0;
>> +}
>> +
>> +static int ovpn_net_stop(struct net_device *dev)
>> +{
>> +	netif_tx_stop_all_queues(dev);
> 
> Same as above.

ACK

> 
>> +	return 0;
>> +}
>>   
>>   static const struct net_device_ops ovpn_netdev_ops = {
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
>>   };
>>   
>>   /**
>> @@ -31,44 +59,120 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
>>   	return dev->netdev_ops == &ovpn_netdev_ops;
>>   }
>>   
>> +static void ovpn_setup(struct net_device *dev)
>> +{
>> +	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
> 
> Do not advertise NETIF_F_HW_CSUM or NETIF_F_RXCSUM, as TX/RX checksum is
> not handled in hardware.

The idea behind these flags was that the OpenVPN protocol will take care 
of authenticating packets, thus substituting what the CSUM would do here.
For this I wanted to avoid the stack to spend time computing the CSUM in 
software.

I believe wireguard sets those flags for the same reason.

Does it make sense to you?

> 
>> +				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
>> +				 NETIF_F_HIGHDMA;


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


