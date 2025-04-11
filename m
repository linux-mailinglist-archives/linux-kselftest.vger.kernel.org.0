Return-Path: <linux-kselftest+bounces-30530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B7A85617
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 10:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFAA4638EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F77729346D;
	Fri, 11 Apr 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QGebh9SC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23CA28F952
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744358656; cv=none; b=PbXCu/lAaip5NyukvrBIfZIWky/LkXQgfblTLwxarTYAB0igs8FrGHQ2EmEvaI/eyhhpqRBPSG0Im+S6l21E9I58VVI7wu1gIZDGn9EzYEJGktI2dkdW8rRaZcMonhO6TSP7t4xcxD3tUyQk9W2PxFNXkxJl/fjPA1x4ZRwIvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744358656; c=relaxed/simple;
	bh=l2VcdA3YeulrePkCB9vvQsx8l22MvCKUb0C19JBaY5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDMNzs74jKabIny6ZnBj/E8DsSm0HIGsYhP0xCJ3TgrSr2QUOgH4xpSP7550+iXiGmrfcbQkMs9JSPB5LHfKJFhWqlqaOCioMmwaku6DsSwQnprDzq5PE3JFyYaP4nO0ExYhYEt8Uq4cYk/Ug0CElwlGWXFNjvN5cY7NNay6KWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QGebh9SC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913958ebf2so1513822f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Apr 2025 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744358652; x=1744963452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fRXgc2yeSotpusr+TwNESYUQv74jCMGOVv7hGlcYd3k=;
        b=QGebh9SC2JWyJKZJskrHI8qas/GJHNUQpdJYCtn0IIShZf+w0AtB0FKUzMVck6cD4n
         DrUZL5vehUkSCrT9F6/+iS2Es8tlKk1fW/iK9MCvuQ5gm0SA9w/aUh8yFqGqXmAt4YJ7
         MJnH3fJQIQknZ2wHNL9HWfrWy2gSk/JYkifnN9PyepkLgUo4ThnldEcw00nVMLksAYXx
         morczaQZ4YM28BAS06NJD9YXpkE8iJgYXIVvyQ/iyE4BFRuES9I/I2gAru7BW7S1sT9H
         Lw8rY2V2q9WWnOqXItxZaWe1eVc7YAvN4XVYjsUN05lsyXA7vz+FMzzQvDK2iGNSsFeO
         rF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744358652; x=1744963452;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRXgc2yeSotpusr+TwNESYUQv74jCMGOVv7hGlcYd3k=;
        b=sLLjE51CFsMk22WZ2XP2btWobCPx2kg7sZFLY0hSMf1yC7W1MRLLg0B7DdnVcXnbM4
         V3t6S/wburmRYotlC1EsBa84kct540RFOk8bAUuBsQV11aKCz0wDTsBvjYDDJBjz0kuA
         p5N5/u6E9IawnQYeMpPe9nKvxmHy+I5/pYjXlDErhenqVJfHTxXorn6f465nXgCLb9/3
         NuaXwr3D0HBgR6B4OosccRU1C7+Bh4gYl2hQjb1ZZNJBC6sp98k+X8ePuF2Gl50qF3Qd
         yKkaHf5QCtF2OnxsaWgeEt2+7gpQ0KPHFIOMFCU8oSKzYu0S5Lless3yRX7OB/suxdox
         F8lw==
X-Forwarded-Encrypted: i=1; AJvYcCXR84ZHAn5x23MATxSmxICXXbUCR25UcEX+bWiRp6mrH0JDoddT32LULxoRLFOg4m7Hg7hmI2bsO3eKQLWAIpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rFyAnQBkWt7u4/Se5BbIAB/tIKybgJicxKnF9RpQuh0HkAVI
	n7579wTA5dvkdDbcYyIWAwSbvc1wiKCeB6Welrt/5K5yMYvKfAOqZ+943whi/236E+A9zc2gpDR
	QgWqIBVmPsqejg9CPFYI3R9W6leyTWU7Jh7hz1qh2bB03gmA2VIdX0Bdh17Q=
X-Gm-Gg: ASbGncufB76flVW5I/7pYRVfrdejjkxltHkL3On+oDmQbZhe69W9K9LepeQ7rcMGZYL
	1zplDS1kA764E+4mRgxtyFJTgOM/eh6w8r6pWVwbGKOMBkiUPfRB2nym4XWIJIt7m0EcD8GZ0pE
	edaeBlX56ieIfdiJFQE17F5/ZslkvXsSArBdTMPQgxm8cKyAiiEdymmMx1oMv7iH2R7HqkQ1JDf
	mF+kMqD/N40zNxAcEM+/LOK99I67WmwowUXwjTrdKvdENRtj4TA/V3RfYR1quFta4jjz14V6mav
	NxSP575ToEOtgr+YDM5d0gTTkm4Ye3pTSV5lGAB1Ir8Te+rSToYMAEeH7KrHNarqa6o1aiTox/N
	/Jlg=
X-Google-Smtp-Source: AGHT+IENyVLM5p/12g1chaFoiAzlC11eK8uC+Ot8/0ux7IvOoPgK3CJzBt98Vrnsaq3XDTmh9tIEpQ==
X-Received: by 2002:a05:6000:250a:b0:391:39bd:a381 with SMTP id ffacd0b85a97d-39ea521193amr1291092f8f.30.1744358652166;
        Fri, 11 Apr 2025 01:04:12 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e8be:40be:972d:7ee4? ([2001:67c:2fbc:1:e8be:40be:972d:7ee4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96400dsm1286529f8f.11.2025.04.11.01.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:04:11 -0700 (PDT)
Message-ID: <f11e8a14-deb0-456f-bb4a-b5e4e16a79d7@openvpn.net>
Date: Fri, 11 Apr 2025 10:04:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 01/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>, steffen.klassert@secunet.com,
 antony.antony@secunet.com
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-1-a04eae86e016@openvpn.net>
 <20250410195440.3ba7ba0f@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250410195440.3ba7ba0f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jakub,

thanks for taking the time to go through my patchset :)

On 11/04/2025 04:54, Jakub Kicinski wrote:
> On Mon, 07 Apr 2025 21:46:09 +0200 Antonio Quartulli wrote:
>> +static int ovpn_netdev_notifier_call(struct notifier_block *nb,
>> +				     unsigned long state, void *ptr)
>> +{
>> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>> +
>> +	if (!ovpn_dev_is_valid(dev))
>> +		return NOTIFY_DONE;
>> +
>> +	switch (state) {
>> +	case NETDEV_REGISTER:
>> +		/* add device to internal list for later destruction upon
>> +		 * unregistration
>> +		 */
>> +		break;
>> +	case NETDEV_UNREGISTER:
>> +		/* can be delivered multiple times, so check registered flag,
>> +		 * then destroy the interface
>> +		 */
>> +		break;
>> +	case NETDEV_POST_INIT:
>> +	case NETDEV_GOING_DOWN:
>> +	case NETDEV_DOWN:
>> +	case NETDEV_UP:
>> +	case NETDEV_PRE_UP:
>> +	default:
>> +		return NOTIFY_DONE;
>> +	}
> 
> Why are you using a notifier to get events for your own device?

My understanding is that this is the standard approach to:
1) hook in the middle of registration/deregistration;
2) handle events generated by other components/routines.

I see in /drivers/net/ almost every driver registers a notifier for 
their own device.

Isn't this expected?

> 
>> +	return NOTIFY_OK;
>> +}
> 
>> +MODULE_DESCRIPTION("OpenVPN data channel offload (ovpn)");
>> +MODULE_AUTHOR("(C) 2020-2025 OpenVPN, Inc.");
> 
> Companies can't author code, only people. Note that MODULE_AUTHOR()
> is optional.

Ouch, thanks. Will get this addressed.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


