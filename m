Return-Path: <linux-kselftest+bounces-27447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7202A43E68
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1119016A4EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5EE267F53;
	Tue, 25 Feb 2025 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVHhDF2g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5024EF9B
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484436; cv=none; b=alR8gxpHLmrGDAeSdctLQDB70m5PiB+OxevsPp8VouUYVrFEvAdL/2ObnwwJdtjGS0cPgFaGuuTorpiE3XfEWf73xVxw/HecSiQsv9hQg5WcP4tZ902FhSSBb7BzOlwzpKS2DzAMd5dntSi8SRYBT2W1eTUyS5G/pxI6fjnvQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484436; c=relaxed/simple;
	bh=2Cm1/5hdJGpRsXa5i9WUTLuqLOaoa32H6ewApOaGaR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3Psy+mupzEP9B7dn5f6zfjcNrPGjyBOd1WTCkcCBAjw9mcgCyiQjAIhOt/tnNikIJ9Nr1SxqNVm8ZzKTHZd74Aa8LJ1WBknNkRPVOVT9uS8B2b+LSEpqtO/NJN1//CGqKqZcPCQWWOD2If5BF6MasANmcWiiveOOG7slef8qb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVHhDF2g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740484433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbzJ0ciiaQnN9IyipfcPCPIA+1eXfEZQWeSNaJG5RbU=;
	b=XVHhDF2gG4hJ939Tj5AqcJ5NPcStH4XaVTcvs6A+XamdAxIDvG3sCaO0FaRQf9se8AVhFD
	gUMFiqeCznF77A4B9LI0N/xzy0WfYV0n70iSwZquupC6i0HaUZ5whDo1p+wd3cEr8XHpPz
	EvqeLr99X9C7kWSXHiYTChjHUXicvgI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-O0OI-GI_OjmPgEDp_q2nLg-1; Tue, 25 Feb 2025 06:53:52 -0500
X-MC-Unique: O0OI-GI_OjmPgEDp_q2nLg-1
X-Mimecast-MFC-AGG-ID: O0OI-GI_OjmPgEDp_q2nLg_1740484431
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso2688565e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 03:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484431; x=1741089231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbzJ0ciiaQnN9IyipfcPCPIA+1eXfEZQWeSNaJG5RbU=;
        b=PqVpw17PB5XhuUV6oaQYXpTvN5vhUXMyFe5pt86VFbsnZhCpQTW/YZAcf/vkTuVzcr
         NckrNNkslwCfJj2vRL1C/NxmruuO5E+qNoln1/7NGg2BO8Ss8+bhX5N+MT0iXcFDwvBK
         0bOvvCLG5CNtJJsyoJ9dAhfTMoljKgEdoiTNgzzj9+PcU046ucoMxy92msuJ7OH1KqbI
         F076wOn3/BBByCL3Xa6fEeXoD8+bdyYUuVt93r/TSco8F21DsaoOSFzmwjAZt5BpucaO
         fUiq+vupXqY3V7g86bI15fuKYltUF4c6ixlUYtSFMEI5xfhIXAIiJVnfcNrIC63FaeBN
         H5EA==
X-Forwarded-Encrypted: i=1; AJvYcCUWjINgRabXsek2DRukKQMh0DmxCl0X+rvmblgJQLNHf60PxppZXHxrevd0O1CKnwUGg6cXBh7a455aO1leMqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vuWV+uWcI21AXT+zsFun5QFphNOdOIW8Hh0584YD7OpvVSpk
	gSxpfcY5NS/6ZFhRxToaYnVyw6jo0DoJUWqcoUDPzgjRNe/MAiwyQ2m36n6k111WG3Tmz9xUaLs
	jmmugqgSwPn4uplWfamGmRGYNK4FRpgw4QWryfBUajqSnOc/k8i4xRU2SfoExIEFN+g==
X-Gm-Gg: ASbGncuyGzCNBFdLbztFpU5eyDHR7ua4JcB5YsIPgmMVE5cBRxMIwc3bZXB5aYylFJ0
	00pjlZ+8uAUUkAc1bzAUgZTRX1bBsnzCD06XCSvCUH55vVFqB0Ar2ILDkBAEjzgNRYhi0FpKlhk
	TwnoH95WjttYUA+ZAEC36ICnWeazcqZH8dP5hf4l9LIA49qByjTlh7ZffNLTmtQ9TOjFpdeNFmm
	U8dzyAsxzEEAn3quMDsAr1ffKSIcRY1anayXG5DAAZD3rPsbctzWvSgxssPzK+DYoXWF9BgF6eR
	uGqKyjE9a/pVrpuh95zQy9JYxgVLDZwoJEn8WYDqRdE=
X-Received: by 2002:a05:600c:4fd3:b0:439:9543:9488 with SMTP id 5b1f17b1804b1-439ae2196a6mr115868595e9.21.1740484431009;
        Tue, 25 Feb 2025 03:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp6HFbG6WupP50Yn0TY2alNimRWue32zDYWfmPTAw366oKsyjmPv7qJLmsbiU0vrQ+3ZRviw==
X-Received: by 2002:a05:600c:4fd3:b0:439:9543:9488 with SMTP id 5b1f17b1804b1-439ae2196a6mr115868405e9.21.1740484430642;
        Tue, 25 Feb 2025 03:53:50 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866f0asm2045732f8f.12.2025.02.25.03.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:53:50 -0800 (PST)
Message-ID: <d0e43d0a-621d-46ee-8cb7-1e5c41e76b8c@redhat.com>
Date: Tue, 25 Feb 2025 12:53:49 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] netconsole: add task name to extra data
 fields
To: Breno Leitao <leitao@debian.org>, Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-5-21c86ae8fc0d@debian.org>
 <20250225101910.GM1615191@kernel.org>
 <20250225-doberman-of-scientific-champagne-640c69@leitao>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250225-doberman-of-scientific-champagne-640c69@leitao>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 12:17 PM, Breno Leitao wrote:
> On Tue, Feb 25, 2025 at 10:19:10AM +0000, Simon Horman wrote:
>> On Fri, Feb 21, 2025 at 05:52:10AM -0800, Breno Leitao wrote:
>>> This is the core patch for this whole patchset. Add support for
>>> including the current task's name in netconsole's extra data output.
>>> This adds a new append_taskname() function that writes the task name
>>> (from current->comm) into the target's extradata buffer, similar to how
>>> CPU numbers are handled.
>>>
>>> The task name is included when the SYSDATA_TASKNAME field is set,
>>> appearing in the format "taskname=<name>" in the output. This additional
>>> context can help with debugging by showing which task generated each
>>> console message.
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> ---
>>>  drivers/net/netconsole.c | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
>>> index 5a29144ae37ee7b487b1a252b0f2ce8574f9cefa..625f4c0be11d8deb454139b1c526abc842697219 100644
>>> --- a/drivers/net/netconsole.c
>>> +++ b/drivers/net/netconsole.c
>>> @@ -1179,12 +1179,22 @@ static int append_cpu_nr(struct netconsole_target *nt, int offset)
>>>  			 raw_smp_processor_id());
>>>  }
>>>  
>>> +static int append_taskname(struct netconsole_target *nt, int offset)
>>> +{
>>> +	if (WARN_ON_ONCE(!current))
>>> +		return 0;
>>
>> Hi Breno,
>>
>> I gather that theoretically this could occur, but it isn't expected
>> to happen in practice. Is that right?
> 
> That's correct. `current` isn't expected to be NULL in practice.
> I've been running this code on several servers for days and have never
> encountered this warning. 
> 
> While the taskname feature isn't enabled during early boot, netconsole
> might be active at that time, which is why I exercised extra caution
> here.

So `current` can't be NULL here. I think it's better to drop such check,
it's presence would be misleading. i.e. like adding checks for UDP stack
being initialized before calling send_msg_fragmented()

Cheers,

Paolo


