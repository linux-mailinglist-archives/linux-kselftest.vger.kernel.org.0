Return-Path: <linux-kselftest+bounces-32727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E9AB090D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 06:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA921B6366A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 04:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B8F238C36;
	Fri,  9 May 2025 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="H78EiTAG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF502192F3
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746763816; cv=none; b=lsqQKKGuSB6soVuzRQGfcsBmls5VB9nI0hOWc2SJjEpByDMGI1z+kyurZW5f32vDHcPApMY2i/Q19K8G0e5mjue1bI2M/XL/gZBIHvAYE7/wQ5Loc7BCcVV1chogoVZusuVxiiaXoY2aBbUi0Hlkk6pYVzBVGDsB7arhaQdvq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746763816; c=relaxed/simple;
	bh=qn0j00Q4lWXNjM61TVOR73jQu4hSjMBc//b4ByjjlDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcIsQEACqXxHHGUc7McpjPE71fP4EIEkj5jNqDWTpM8VqBoMfjZ/CMrw58oHJe2KLQrNCaIW5DrINNTi/SjoH2knYCemdI9SuIe1s4IOPNERvyDInJBjuoak4e4gpBp72JvONPYQudz8piWknLQNzgJwgdOEyWe8ULGBSFlufYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=H78EiTAG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227b828de00so17481555ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 21:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746763814; x=1747368614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOPt985lsryufrF2f8Rp/LqwNq9TFhhzPNpr6WI7mLk=;
        b=H78EiTAGBP/eSZtpKU4O7AkmbB7c0NwV4GOoLa6j98Z8i5LuY846ffMW9OvosBR57E
         7pTiLxd5Rcpj7vhvmMtlZsQjGkYA3mpJknQThjvk64fpQQq/MA6wOE4xs1smA37QalR4
         t0YLmgoGt6DYQSrleEY14yvZ9E3tW3CS8JFtThPBb4HvE/c6yd8W33X40gDztNwmHbgz
         KBY8dGLlJQEEmfrAPTkQLC2TRl7bwgL7QONB7DsHu7L/RF2N85KiAdiprebR9Wvc2X5+
         +CUfqo9bFSWXa0Z7xyRrKlSHP5KjjYVyvDsGTCfEtyueRVSBPiAHaKerJ1LIBWIKdLa9
         MrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746763814; x=1747368614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOPt985lsryufrF2f8Rp/LqwNq9TFhhzPNpr6WI7mLk=;
        b=cnJIh3pjqJ+v99X/FZNFdtTiu7408QgM1Ulpkdad0SB+50QIHV6uO6aTMKH/jQpP7J
         gvycPathom0RfOZ7iZYfA3G5sYvBAbFaSFk903R+uZDoKyFuP1wwOiC+ZZMbRSNTRoc+
         U0ZZxMGuyCZg6yF8Mv2ENJmeWUIqMu7TOPa15+LsIB+MQVYgwPx3qCdRSgwk7AczCkI+
         nL5unF+ZHWfK1FzlHbOxgJ4wvOBTezpGbx9mDEjTWpSRUHcOJch82kRTcd42Ay8MRpIY
         NqHMdbT8Bk8w0msxWRYFMpjcTlqRxs4bj2EwTHtWnBjFVVq7uBjQAeZwiCXGph8CCJj0
         j/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVntEe/EsXmAK6R4L0yQlrjdIpljCt/SSlDLz86G2CY76agbnoSlHbdcOZyNMbELFbXmG6p1Zl6MT7kWcCriSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrugMsSPPfNn8J21PpEemi441Egd5WnJvkihVyYXiJD8DHnN1S
	f+m4F2hJDeh8jkU2+y4xM2CJhpJ54sGVmRjkAOUqOni9AuRGhPyCuclQXjRTk+Y=
X-Gm-Gg: ASbGncv9paloJ443ok5ZKNrmC98b1FaSlYTblAyRb0FmxGx8k/SM3vDSOKSKStQ6I2Y
	hUAaW8+XNXIj+lqxB4att34PX2k1iCFO3mmKUy4w186JcmgHTqBnuctsY2QqBb8iAeRTx1Eevxx
	7IGNz7HIfip2i9bdYFu+i6cLIdKV9LLEB8AzY2wdEXoHmO5rx+OMtR3Vl0K65hVMFQIqICUec4R
	aWh7uobasY+8qGx/vwtPWPkEyEWOnNRrGUJM6276aHiSfNEybcz5erEAaQRNXa7ufoT5e4vOBQR
	W0m9AUfKxpcoXTnLFJ/1yPxZRBSnoLO6eCXYG12hvyRvhqs=
X-Google-Smtp-Source: AGHT+IGld+rlMK8n8nhzZTd9tL87p1xppP25t3sLIo0ygGvlHlV56UBGyyKEeAa17jr3ahMyKHEBTw==
X-Received: by 2002:a17:902:ea0c:b0:22e:17ac:9dd8 with SMTP id d9443c01a7336-22fc8c7d71emr24684365ad.29.1746763814065;
        Thu, 08 May 2025 21:10:14 -0700 (PDT)
Received: from [192.168.1.21] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc773ee47sm8139185ad.63.2025.05.08.21.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 21:10:13 -0700 (PDT)
Message-ID: <d8693a9b-697a-49d7-a064-fc7349ec2d63@davidwei.uk>
Date: Thu, 8 May 2025 21:10:13 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: ping: make sure the ping
 test restores checksum offload
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250508214005.1518013-1-kuba@kernel.org>
 <e339c382-c0f5-40dd-994e-34b388c68181@davidwei.uk>
 <20250508183736.74707daf@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250508183736.74707daf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/25 18:37, Jakub Kicinski wrote:
> On Thu, 8 May 2025 14:59:12 -0700 David Wei wrote:
>>> +def _schedule_checksum_reset(cfg, netnl) -> None:
>>> +    features = ethtool(f"-k {cfg.ifname}", json=True)
>>> +    setting = ""
>>> +    for side in ["tx", "rx"]:
>>> +        f = features[0][side + "-checksumming"]
>>> +        if not f["fixed"]:
>>
>> I checked and found that "fixed" is a ternary:
>>
>>           "rx-checksumming": {
>>               "active": true,
>>               "fixed": false,
>>               "requested": true
>>           },
>>           "tx-checksumming": {
>>               "active": true,
>>               "fixed": null,
>>               "requested": null
>>           },
>>
>> Python loads this JSON as False and None types respectively, and `not
>> f["fixed"]` is true for both False and None. Maybe this doesn't matter
>> but flagging it.
> 
> I think so, yes.
> 
>>> +            setting += " " + side
>>> +            setting += " " + ("on" if f["requested"] or f["active"] else "off")
>>> +    defer(ethtool, f" -K {cfg.ifname} " + setting)
>>
>> This does rx/tx-gro too even if not explicitly requested. I assume that
>> is okay?
> 
> You mean because those are automatically updated when we change
> checksumming? If so then yes.

Thanks for responding.

Reviewed-by: David Wei <dw@davidwei.uk>

