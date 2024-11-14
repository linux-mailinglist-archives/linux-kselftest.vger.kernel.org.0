Return-Path: <linux-kselftest+bounces-22023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4C49C87CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3621F2413A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 10:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3416A1DC18F;
	Thu, 14 Nov 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IWFyIWAm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30DF1EBFEC
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580711; cv=none; b=oNyBM4YoMYdqQG6PlVbg0xALSoUFE7Y97fkbLyqOOfSM0taA7y10mORB2BsZS/VrTDgcTfERSDd0g8jPMeRdZ88K9NML13DvE9CdzVstBQYJsTRgvWJu6m3yIDHUYjW/kCv6wZmxYlrWbV4/A431NbUuj6OOCPxArpCCxfi0VYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580711; c=relaxed/simple;
	bh=H8AMRd4OBFqRbsOnvi0AvnmgwACZ0gjGpRyfXNyeUm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jX8RaMsEqcJEhbEdyuYvAWgOYmNT2fSvzoTPC0caODNRz5aQzJyHBBJrWzt1aw23Fnv0QHEHAs73PnsLPY+dMwqWxnKa4sek9ALgT90mRrj4TO5Kct49WQsZnHkPDNv4C2VHYL8tJLYLIabF2e44EJO6JLtqXdZKpkYN8yRq6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IWFyIWAm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so4104691fa.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1731580707; x=1732185507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=llExbBPE8bseY/8rXUzLPVclRCezstKecmmbZCxnRek=;
        b=IWFyIWAmma/CTG0GGR4eZkfKmKGCxOCxVuYKs5AZh6sPzNL6uSprOW1qEPjFcwxb41
         piC573ewqJnqG7qa2+KvE2QvtOfQwrPhwcMoHHOWZRPoS7zviqzKSX5c12ljZriMvXbP
         h8Zd6xn6P4ZePr4bzu6VY8AR4GkzT4a7fFQ+r2vtF1nkwqH2tMaaSixLmPCjRHzsKlgN
         vuhD6NXU1Uwv81qCsyvkIz4L4fPS3WzAkwwGkCsbkEmpUeu9LUgHl6UxDGzl0j2LbQ7D
         oRA6QecqmG6mqTvWc0/8GQR8pZe5UcpbmezQpPS7Vs6tKr03dTfzM2AiOLCp3WLnik0T
         HeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580707; x=1732185507;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llExbBPE8bseY/8rXUzLPVclRCezstKecmmbZCxnRek=;
        b=KSHrUwleIaaVtcLNurasDd/QUqjCbIZdI2+WjaezoQN/tdDCp9lcZcMaU/Tqefct/U
         6t6ajuFiT8ShJrRwLLDcZ/CjgPT9UDK4HF2OAk6AMtIZqylg7cGBjL5Fh3Osu86sT2S4
         d+NHP3REXWA73GJ3FU4TA837QjiJyYk9zXWP44Gv9A0APWhEUFkrCIWL8FIKTdr8tQul
         sCgNhxQdWEdU7ncYpsVqHgtggn0Ff1/rELNHFKOAQb1aDNf761qKNPRVANCHpLTjiPYO
         KyLvcvwZLhsbvtrEnU8JSnOcS3VicklSEze3RuaJTtXu8tnpp5XJ1TXAciXJf8foAqAz
         l/QA==
X-Forwarded-Encrypted: i=1; AJvYcCWOkv4rWXDi59R5Eda6zOF/oF+wxWJevw5u12QRftNrYg5+ldJ4yAJyJrKkmQeui/naep+TTwZQ1nvNPvJlWRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10z6s2HkkUoXA5/DTcPAxu0nhsBNs+9Q0PS/MSJnm78ihob+e
	GEejbdhGoqzcB/SjxbZ+r1sfWm2BHqsiKsi1JBQsGwwhYUKjaDkr58g0LWYBlpk=
X-Google-Smtp-Source: AGHT+IHuE+m1ft9nvo0ChCkY75Dans03o8VIGRdHionQ5aAL0n+JbDtdNcasgZRSrJ/+XnptxyLq2A==
X-Received: by 2002:a2e:a90a:0:b0:2ef:17f7:6e1d with SMTP id 38308e7fff4ca-2ff201e74b6mr115969721fa.4.1731580706256;
        Thu, 14 Nov 2024 02:38:26 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:3779:22d5:a322:7c13? ([2001:67c:2fbc:1:3779:22d5:a322:7c13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1fbf9sm15761505e9.41.2024.11.14.02.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:38:25 -0800 (PST)
Message-ID: <21330449-fab6-4c0b-a155-84c7419adbcb@openvpn.net>
Date: Thu, 14 Nov 2024 11:38:51 +0100
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
 <816d8b43-8c19-4a4c-9e37-98a3415848b5@openvpn.net> <ZzS3jgNQoDH_0TvK@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZzS3jgNQoDH_0TvK@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 15:28, Sabrina Dubroca wrote:
> 2024-11-12, 16:44:09 +0100, Antonio Quartulli wrote:
>> On 05/11/2024 11:33, Sabrina Dubroca wrote:
>>> 2024-10-29, 11:47:33 +0100, Antonio Quartulli wrote:
>>>> +int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
>>>> +{
>>> [...]
>>>> +
>>>> +	nla_nest_end(msg, k_attr);
>>>> +	genlmsg_end(msg, hdr);
>>>> +
>>>> +	genlmsg_multicast_netns(&ovpn_nl_family, dev_net(peer->ovpn->dev), msg,
>>>> +				0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
>>>> +
>>>
>>> Is openvpn meant to support moving the device to a different netns? In
>>> that case I'm not sure the netns the ovpn netdevice is in is the right
>>> one, the userspace client will be in the encap socket's netns instead
>>> of the netdevice's?
>>>
>>> (same thing in the next patch)
>>
>> Well, moving between netns's may not be among the most common use cases, but
>> I can see people doing all kind of weird things, if not forbidden.
> 
> The idea would be that only the ovpn device is in one particular
> netns, so that no packets can make it out of that netns unencrypted. I
> don't know if anybody actually does that.

Well I can imagine starting openvpn in the main netns and moving the 
device afterwards to something more restrictive (i.e. even a docker 
specific netns).

> 
>> Hence, I would not assume the netdevice to always stay in the same netns all
>> time long.
>>
>> This said, what you say assumes that the userspace process won't change
>> netns after having added the peer.
> 
> That shouldn't matter as long as it's still listening to multicast
> messages in the original netns.

Oky.

> 
> Around that same "which netns" question, ovpn_udp{4,6}_output uses the
> socket's, but ovpn_nexthop_from_rt{4,6} uses the netdev's.

I think this is ok, because routing related decision should be taken in 
the netns where the device is, but the transport layer should make 
decisions based on where the socket lives.

Regards,

> 

-- 
Antonio Quartulli
OpenVPN Inc.


