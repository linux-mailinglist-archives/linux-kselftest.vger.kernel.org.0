Return-Path: <linux-kselftest+bounces-23170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047C79EC9D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 10:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C3E1882A86
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3471EC4C2;
	Wed, 11 Dec 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="J/3p/nYM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448A236FA9
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911167; cv=none; b=WbV0Fzt19xykPV+B4FrBoP8svdZkB8Mi69oESfRLpgGGcPKE5r2yEF5r6UcbKTX4TlWr+672i1bxUqLznVa5nB7hTGJFn/HMC53GQezp5qDXKTtLWx3u1iHJY9ZJkEobyd0iCQe0b6AaR/zz3VjdY3A5ajgER54Tlc9/ja4AkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911167; c=relaxed/simple;
	bh=ZlvieSYp+lFfKY9C2R6v2jjPfDG1Vm3fAT60s2bT+4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Brm2vwrkas4U1Bv562Mr/1WZCdKG9u3hrczAkmnKNXZBWD2B8py8uPp7rXOZhCSg6IttoLmwDC4R99oCXl49Xqb59XqpT6cZEns6yP0kyRz0+RNy/wFeITJGI1Tkvb3XykEWhFPa0IXygR6g8Pt3uny8EKMgVBBH5F8R4KMbncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=J/3p/nYM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43540bdb448so10799235e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 01:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733911163; x=1734515963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IoRCfObFE/0dbWPiqsJpx6TV+b8TV5eKkwKSHj1b0P4=;
        b=J/3p/nYMAUjjA50H6ie+/f54NJteXu6jYS/mZ7+SX+bbIYNBZq5MDCYQ1U1owNZVtC
         o4p1xPDaZynehJi487CELDGjtKh1Vu2UAuJqiROITCD9mGPdNXFU3jwlkK4ciG8AcRZN
         IRxoqX6XRkEEaaW8pgYB6xm5tCnDZb1aZ7YezzdZZ6LvS5D6zc2ffgCuzzPMQn5Sb25n
         3o+QWX7gRjJvgKU0eJHPK4XZIBqH5NFgpfMlhhYh4VmLdgPCpEKYurdNcdzOkgWMJgUV
         LvZJG469PQ7sZP3HJFwwrnciWWSEjDNDoZi5chR7OvGt/rWmTzJH3ng6SJ8AlaxnUJES
         JCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911163; x=1734515963;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoRCfObFE/0dbWPiqsJpx6TV+b8TV5eKkwKSHj1b0P4=;
        b=SLWYVWyK0p2P4Pm7AMrTxceR2dosxRcyrO57+gkLN+5hFxKPUjcULUaRsvek2/2iPm
         FxFbGvlZF2K1xKMty9LBIDyADF2r+brjky9rJAI0HZV8jhWA41j+80JYDl+dj3gGIxLH
         TKSYHkQ6xMN84gFfm+lNyxdXIRHsLtN3FoGXJKIOdTHkL1UBemcRfngBpSDaTYYz7hn+
         ktxYQhLZyRQPMBCMg9rNU1Y2tpJwq97WoDvFjcXmyDUcziRVvnonRTqsJLuZ6MZC9/Vz
         SkASwwKDsuKok9H2wSfU7tXwafKHhBTAopGlBbgoFhm6ydrSCqMTmk945ARCrvM9d2CM
         V65A==
X-Forwarded-Encrypted: i=1; AJvYcCUqhDGKknaY+jMSg7xgfTGMPWJuTt4K1MqKqqvfnD9qJcwFPHP66plxX9jazEjTvs3+7mB5c11VfmiOkt8ZLqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMywxWxb2ACINr+zaMYWP+cmJkpLpeocZx3Y21TVxCFu+Us/NI
	OivoJCojHDXUMxELCgE4Vl4LIUjAZLxz/inECOHl1fcMH/QzQlYxI7YMRNyRjLY=
X-Gm-Gg: ASbGncs19Mqg1tzU2wbcCt/+UTz3Akf4TAgvNpMNOK6KsKCVotI1ZnqItrcTsbaEp+z
	m/wZK0VBPpd37SezMLBFkXq6xURRpmS9FDJSAQHAUKzh1ORBDrMHd1qVKD4WGzCb2pdaAFd6xCQ
	u9HlnOjKvUGW14+Mpd3fEduCH9DrNSJvTTj/y5jfxhLZs4f7sp5wEVJJCCwtZu+UwA60hp9lJUZ
	omjwPkcBgEBK4yV+na0v0hDSXwpni0EXGcG0aNLI0ubKxZcFjCfrpNUcBEkEfYV8esbr6P97zD6
	CdKKtfrU89yO8Q==
X-Google-Smtp-Source: AGHT+IEHjbE4dsJ5tzTwee49t2ek+qPtaomPRduw7MRABYyFDxJIbdcKf+79ZqnixjCxHDteXJKqUw==
X-Received: by 2002:a05:6000:1547:b0:385:f66c:a4b with SMTP id ffacd0b85a97d-3864cec5712mr1635635f8f.47.1733911163223;
        Wed, 11 Dec 2024 01:59:23 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f6e8:f722:d96d:abb? ([2001:67c:2fbc:1:f6e8:f722:d96d:abb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251e12esm886242f8f.95.2024.12.11.01.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 01:59:22 -0800 (PST)
Message-ID: <7d986843-d184-4ed7-930f-d30ae2bc4923@openvpn.net>
Date: Wed, 11 Dec 2024 11:00:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 08/22] ovpn: implement basic RX path (UDP)
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
 <20241209-b4-ovpn-v14-8-ea243cf16417@openvpn.net>
 <20241210164417.GA6554@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20241210164417.GA6554@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/2024 17:44, Simon Horman wrote:
> On Mon, Dec 09, 2024 at 09:53:17AM +0100, Antonio Quartulli wrote:
>> Packets received over the socket are forwarded to the user device.
>>
>> Implementation is UDP only. TCP will be added by a later patch.
>>
>> Note: no decryption/decapsulation exists yet, packets are forwarded as
>> they arrive without much processing.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> ...
> 
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> index c0e7aa289ad3345fcd91e7c890f70961300c356f..975392fc39bc4c0107a07a53795afecd88d72c53 100644
>> --- a/drivers/net/ovpn/udp.c
>> +++ b/drivers/net/ovpn/udp.c
>> @@ -23,9 +23,83 @@
>>   #include "bind.h"
>>   #include "io.h"
>>   #include "peer.h"
>> +#include "proto.h"
>>   #include "socket.h"
>>   #include "udp.h"
>>   
>> +/**
>> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
>> + * @sk: socket over which the packet was received
>> + * @skb: the received packet
>> + *
>> + * If the first byte of the payload is DATA_V2, the packet is further processed,
>> + * otherwise it is forwarded to the UDP stack for delivery to user space.
>> + *
>> + * Return:
>> + *  0 if skb was consumed or dropped
>> + * >0 if skb should be passed up to userspace as UDP (packet not consumed)
>> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
>> + */
>> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>> +{
>> +	struct ovpn_priv *ovpn;
>> +	struct ovpn_peer *peer;
>> +	u32 peer_id;
>> +	u8 opcode;
>> +
>> +	ovpn = ovpn_from_udp_sock(sk);
>> +	if (unlikely(!ovpn)) {
>> +		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
>> +				    netdev_name(ovpn->dev));
> 
> Hi Antonio,
> 
> If we reach here then ovpn is NULL.
> But the like above dereferences it.
> 
> Flagged by Smatch.

Hi Simon,
Thanks for pointing this out. I will get this fixed and add smatch to my 
test battery.

Regards,

> 
>> +		goto drop_noovpn;
>> +	}
> 
> ...
> 

-- 
Antonio Quartulli
OpenVPN Inc.


