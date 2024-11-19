Return-Path: <linux-kselftest+bounces-22227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428469D1EAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 04:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B96B20A80
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 03:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E1146A71;
	Tue, 19 Nov 2024 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBICnhl8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D97613BC18;
	Tue, 19 Nov 2024 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985693; cv=none; b=YNchA0JKT/8Ou8uFwBYFwhBbGC29pldD1qQpMM7kveRaSiCtq5WXNN1/fEaByPkoHgr+7dI9AfAHcwBlPXVq9Ip7yFMLA4fz865LO65Wd1XH3fcmtqLYlhEb6nJ0O/ccZA7HLHB9tbC2zmSRtsfZiXFwgT9wwYNyAsTweDH7l2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985693; c=relaxed/simple;
	bh=KNzg/VnYk/VTOAfCZM0NLYcBHGqbP3/hcG7wRArTaU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyasaLyB0gM5FUlZYfZg47Dqr0YdU5D8Sz/bVO/HL7rI5oMTA9UVG7dUCsbhXrdWyBupScqInojZ52E3IFsXOBArFXmr2dGeLRYTonrowwhZ6UYQAdA5+efsCEdvjH4GTQ9V/JEXXQDMaf2ku0EG7lujHnaN+MZqTND3xjkbGuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBICnhl8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3823cae4be1so1696733f8f.3;
        Mon, 18 Nov 2024 19:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731985689; x=1732590489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udnnZPMjExfUYVnK5AHWuCN3jARchg06X1wj0Aah2mY=;
        b=FBICnhl8+AvChgb/wLckUmEiH4XvLmSJ56DitkDC3SmLZDT5cjsVbTvzN+KRD1Btnc
         jDz+cWrATqN+qbpQglgYzjphSdgw8O9f9pwtuRnl3XUSk9cayNssV1Xja8w+KSAhaOlW
         AKwX9WJ39NyhZfLhgidpoAz+ElGKv1SBSxms2OwsZJBPV0mBdYUaNo7DwhIKgy2wKYwo
         H9YqPOILwc0KkaDvkr3MwksRouq0vaOgwJb4+4IhGp00ewacw2ai97B+Il7jRhLEn9MD
         6Vieyu3JEuwP8DfBVKTB1l2pUuXDd9zZiaWeLkus9G56p3aOocx4wdUuG+ppaGOtj3vX
         Iw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731985689; x=1732590489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udnnZPMjExfUYVnK5AHWuCN3jARchg06X1wj0Aah2mY=;
        b=Rw/iG1rRE3CNHbhATQm5mkp9Ev/LQGulJ4bvyCkLv357v2Zd3g8xHwk17lE95dF2+b
         1QgyMS7H9Ou5/0HZIuGUafzc/g77g4+I1WNUY9afT7bNcMBxCgBibDbM8uy0mPIRbKHb
         IuW887xxg9MG5XPNBx9S25t8zMsz2go/GNJQaCyrtZziSJ34IPwmg44B4SXyA+z2SCCh
         OzS9COYDVJSXhzaHheAVi86Fc97djVqyQCnamsbKLQa40viI4ixx+qCQftZwnKjoUipw
         scSSoriuqEkZ74CMfPuFHOs/X/vZWNEbcZVSPyye1GBBeL/NEj7P1iPSQYWpsylZHsrd
         Z96w==
X-Forwarded-Encrypted: i=1; AJvYcCV0j8yK7bAyQgghPrq3CIgfOkSvhZorncXoIp+9H4opJHsOGozXpxzLJKnFHmQswrJEQIPyvPxKnvklgsm/Qpbe@vger.kernel.org, AJvYcCVo/MuwHnFkV25l1K/Z35YDLB3WRe5mGnHhcnwUA20AgljwkEwIviNPvuZzjF/b1f8L7wKfnLjJyocoo7Q=@vger.kernel.org, AJvYcCX0vjFga6fLFC4tBzo3ycVHiDp5IXfIApGc8veKvGijkFo4RB99YnglqRNRYvpYMVrX6L85bSa0@vger.kernel.org
X-Gm-Message-State: AOJu0YzZZMk6f4IEBaRwXHfRJUYBgi0zR/VblWZrVe8X0W8kFNvMzGDs
	PjGD9ZIE8bXWMYOfXTmG9FQayn8z0aP0jdaZz9wO/6MIaYkMTaxE
X-Google-Smtp-Source: AGHT+IEdfLGGaI6Y6pB0Iwsy3p6pEaPMuglgh3Ki9iAJLY10n8ACLveN9g0Nm9gpewrq4BsQtPxOQA==
X-Received: by 2002:a05:6000:4029:b0:382:4485:2d96 with SMTP id ffacd0b85a97d-38244852f78mr5622255f8f.50.1731985689305;
        Mon, 18 Nov 2024 19:08:09 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28b698sm178652105e9.27.2024.11.18.19.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 19:08:08 -0800 (PST)
Message-ID: <709d415d-859d-4342-80b7-908c04b28621@gmail.com>
Date: Tue, 19 Nov 2024 05:08:42 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
 <4b6f2e30-5e94-475d-97ec-d59e59f0bf6b@gmail.com>
 <0f19828c-9808-427f-b620-fd3bc9f2e5db@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <0f19828c-9808-427f-b620-fd3bc9f2e5db@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.11.2024 16:03, Antonio Quartulli wrote:
> On 10/11/2024 21:42, Sergey Ryazanov wrote:
>> Missed the most essential note regarding this patch :)
>>
>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>> +static int ovpn_net_open(struct net_device *dev)
>>> +{
>>> +    netif_tx_start_all_queues(dev);
>>> +    return 0;
>>> +}
>>> +
>>> +static int ovpn_net_stop(struct net_device *dev)
>>> +{
>>> +    netif_tx_stop_all_queues(dev);
>>
>> Here we stop a user generated traffic in downlink. Shall we take care 
>> about other kinds of traffic: keepalive, uplink?
> 
> Keepalive is "metadata" and should continue to flow, regardless of 
> whether the user interface is brought down.
> 
> Uplink traffic directed to *this* device should just be dropped at 
> delivery time.
> 
> Incoming traffic directed to other peers will continue to work.

How it's possible? AFAIU, the module uses the kernel IP routing 
subsystem. Putting the interface down will effectively block a 
client-to-client packet to reenter the interface.

>> I believe we should remove all the peers here or at least stop the 
>> keepalive generation. But peers removing is better since 
>> administratively down is administratively down, meaning user expected 
>> full traffic stop in any direction. And even if we only stop the 
>> keepalive generation then peer(s) anyway will destroy the tunnel on 
>> their side.
> 
> Uhm, I don't think the user expects all "protocol" traffic (and client 
> to client) to stop by simply bringing down the interface.
> 
>>
>> This way we even should not care about peers removing on the device 
>> unregistering. What do you think?
> 
> I think you are now mixing data plane and control plane.
> 
> The fact that the user is stopping payload traffic does not imply we 
> want to stop the VPN.
> The user may just be doing something with the interface (and on an MP 
> node client-to-client traffic will still continue to flow).
> 
> This would also be a non-negligible (and user faving) change in 
> behaviour compared to the current openvpn implementation.

It's not about previous implementation, it's about the interface 
management procedures. I just cannot image how the proposed approach can 
be aligned with RFC 2863 section 3.1.13. IfAdminStatus and IfOperStatus.

And if we are talking about a user experience, I cannot imagine my WLAN 
interface maintaining a connection to the access point after shutting it 
down. Or even better, a WLAN interface in the AP mode still forwarding 
traffic between wireless clients. Or a bridge interface switching 
traffic between ports and sending STP frames.

> Thanks for your input though, I can imagine coming from different angles 
> things may look not the same.

I believe nobody will mind if a userspace service will do a failover to 
continue serving connected clients. But from the kernel perspective, 
when user says 'ip link set down' the party is over.

--
Sergey

