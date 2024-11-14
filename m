Return-Path: <linux-kselftest+bounces-22063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9678A9C9509
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 23:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E1128599B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 22:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C081B21AB;
	Thu, 14 Nov 2024 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="judC/vmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225181B0F0E;
	Thu, 14 Nov 2024 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622189; cv=none; b=WAYy5hrfA1oe8MhTH0DJYmpCGiJhOIWp8N7WBx9qaCA7AeNRvajFILVNKWQ5RuJjIyfTdOu80tsLhsVJveTNtCsP/E0uxDujJaVsChL/l1pF0wuE9g1eGAJJbLcmwZFQOARd/HGk6KFd7KeWOa3z4uzAz3QKBEv1JALO7MSVboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622189; c=relaxed/simple;
	bh=6IQyXRC9hYx6rGoIbfTLpkvZlOUYKn8M0olw07FHBkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qosHReXmPEAHic6Qdp56GosnuNcAaxVNPRYv7avgFhdW0xI7d0+A/pQBAcbI4w9STQf3X65OxF68QLGrvnJbgUEPafZ8ocCNZTUIpk0pWW8RA4GSo/cPieSLIoWKKgyv770ebL//lnhnSpDddGA61vqWOsUi3a7SRk8bidWhh1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=judC/vmd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315eac969aso6807125e9.1;
        Thu, 14 Nov 2024 14:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731622186; x=1732226986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LP7Hi3Q6dgrff1lGnR4FQ8i3hpbGOOo16Puyr3RTY9M=;
        b=judC/vmdeGm7YkTeIi5GpQ6slJYMYF4+sgsrWa6Ps5LFITQlu9pTrowKCBQvK6benT
         NoutXvZNGHlupNiBDS6ftiLLBO0kLrTcw0WKPV93eR/FnsJ1oj+8jJ/PlSnUgDdgP+ut
         /NkyLz+ScMGLGdp6+/IJBe3QXIDM56rcI3I4oGwtrE6MtOdN3kWBDtXhmWk8OByFNCm4
         044o0rrLPQOb9QBNt23MHv78jeylvwOHZ5R+wXwOivVYYMe2apzWWoZC9sNEP5w8AqCM
         iu8JfrgnvIrvccc/4h3IqAdRTajstAe74oXqWR8i9idnKNvyzW6zAJi+pX3pxU+gVhn8
         3dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622186; x=1732226986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LP7Hi3Q6dgrff1lGnR4FQ8i3hpbGOOo16Puyr3RTY9M=;
        b=esVefOW3WWU4IuEY+Eih4ZiXcLGzq0Bmv4tSUbS7pOk+CQSFbB4kx0eV8L+zwXDxR3
         G5NpsH1yVu3a2OPct2fUbNo8kO3zblXMNYcKCw+NZVxB7NcUQsXOrr1ZawI1bBo3k01f
         VzISrchkJCJ3Bd1elJOm1ptu/MUJNvbGmYrxS4oModWa0F5ndNFbXCWojovHWrtkVeaY
         /raY/nKlq9Rhube4XOfgrS0jwThdYXrHHVwCUYGZt33Jj+mubFu+rDkIN1nbqGcXUxHb
         Z3Qvk252BgqyOtqVKXm5rnUHrfkroahbIAzjTq4qx+tWxuJDur9HythNtb6m6ZYG0uW8
         6wuA==
X-Forwarded-Encrypted: i=1; AJvYcCVMtaalWZlq7Ib9AkZJBiiX90o4S6aSpIw2/jbEXq+GOaw4Q4viWT3ZL6S2T3B8shSPchvpMUs7dr+KT6Xc+QoX@vger.kernel.org, AJvYcCVZGvzWq6FMLSgUkGUUNx/ev3mc+8GJwQ/BPAHKW5Yuwi+H+51BLPayQ2/D6SGYZARl6UgssSKC@vger.kernel.org, AJvYcCWpu5XmW8M6jGEQZYS9EQGW5K8G45C5pCudlUis5fKDIU9ncOxLwM56AM3ahoLsiGdaK8IFUaJSlOovDeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWvdqYWqbKMqdeLwAv7iVx8L33fzzQyCV4+8YRsiACVoS2y8U
	iLL4WIIpQp12SqBsMHxl3JrglAHAbUD09WtMbTblP2zMNcrvGEU1
X-Google-Smtp-Source: AGHT+IEggJ6DacuYcF0xDEFeIuZNohE2/vFF783XckdAnLBmD+z6MYMYdjru/EsyuHzKMnZgrtoNGQ==
X-Received: by 2002:a05:600c:4514:b0:42c:b67b:816b with SMTP id 5b1f17b1804b1-432d97268d5mr47567085e9.1.1731622186241;
        Thu, 14 Nov 2024 14:09:46 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab80ad9sm33514395e9.25.2024.11.14.14.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 14:09:45 -0800 (PST)
Message-ID: <4fa316ce-c6f7-41d8-bb47-00c15f76faba@gmail.com>
Date: Fri, 15 Nov 2024 00:10:17 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 00/23] Introducing OpenVPN Data Channel
 Offload
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <2828411f-f2e5-4dfc-80ff-577eb5fd359a@gmail.com>
 <a7009e7e-a1f9-4aa5-ad41-2befc64b5d3e@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <a7009e7e-a1f9-4aa5-ad41-2befc64b5d3e@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.11.2024 17:33, Antonio Quartulli wrote:
> On 06/11/2024 02:18, Sergey Ryazanov wrote:
>> Regarding "big" topics I have only two concerns: link creation using 
>> RTNL and a switch statement usage. In the corresponding thread, I 
>> asked Jiri to clarify that "should" regarding .newlink implementation. 
>> Hope he will have a chance to find a time to reply.
> 
> True, but to be honest at this point I am fine with sticking to RTNL, 
> also because we will soon introduce the ability to create 'persistent' 
> ifaces, which a user should be able to create before starting openvpn.

Could you share the use case for this functionality?

> Going through RTNL for this is the best choice IMHO, therefore we have 
> an extra use case in favour of this approach (next to what Jiri already 
> mentioned).

In absence of arguments it's hard to understand, what's the "best" 
meaning. So, I'm still not sure is it worth to split uAPI between two 
interfaces. Anyway, it's up to maintainers to decide is it mergeable in 
this form or not. I just shared some arguments for the full management 
interface in GENL.

--
Sergey

