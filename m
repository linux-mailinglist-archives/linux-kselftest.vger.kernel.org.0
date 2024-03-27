Return-Path: <linux-kselftest+bounces-6717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E824288EAF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 17:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20C3298040
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6512F399;
	Wed, 27 Mar 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hc0el+eH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C1236E
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556262; cv=none; b=kdwkSDrDU+7Bk8+XDUANdlA+wt2MAqm03A8pkhNBB38UW/iKBrriN45RbRYU0dtxVkmhcHv17BDGxABXf8J/H14fUfn3ni6dp5r2NlCzEp/Wu7jqs+CDM14AVrwOJastYKG8QFyjq8q0me0rau53X65nuyngJwG0c061uGAo3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556262; c=relaxed/simple;
	bh=Z1zM4v+LZMPNdR9n/IIXoKoDeuKUfs1IrT0aNWB0JSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mf0/wBokNZALYX/isjjxob16NhyTexNk0T64JjyrH/5Y2pHhijdOhlKQeTFQQtL1T6JhWWc53H3mBVvJdj5j5NZlDd31F4XS/DFv/1XbPQ9UIQg0c269Q8oCZUsxrMaJKwfuMf5Uio63NoTFP/Da5wkL8Vq5ulEhfi07KJLuAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hc0el+eH; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso48480039f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711556259; x=1712161059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ftt6/au+tz9Vn0of2QleLPcLOfmPc15pHJvkugHM6CM=;
        b=Hc0el+eHX53G28dx8CTQVSQ1OSwncbzOd2t1GmSaZI+i67cKWJyJe8oPMDVpdKjYtC
         ee7hxMWD91Uef02fCIRNdqJ30jfhj6Q10FK0e/hgoX/L28iJTFsE64QCbfB9cq0oMEND
         6jEQULnb8lU9hngdOjvK+xDnlk3onliJNFxbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556259; x=1712161059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ftt6/au+tz9Vn0of2QleLPcLOfmPc15pHJvkugHM6CM=;
        b=EcggHz1IY3ulQD/s1xxiH13A6dnqZWNUQsNnlCG4A25cOplMyrN8S6mEomk3Kb4IBM
         gtaLTivxHrde5gJn0JY1ViyhJJ3e92aQOhjWLGanEEt9zl8IvcormOxlZnLBTvuINAbE
         xZwSu3cEaTqtu7hp9h8uqdTtGXKcbTs/+1fvXRmd2CRoDh6jpQnZoYDbM7QG6NO9UpFX
         8YlldrarNBWRM1eN9GFLGpuOBJDqm1gczHMP6moefcg34vGPNZzAIzUeK3Xa43BGLBS1
         au9kRmEfEtMqibDVR8MgnVf4yIe7/XBEVGsn45HOM2JosAmkp4Hh286iDSlmOPMyQX2G
         jNIA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Mge0oCEPYS0l1GvP1dc50DAGUbn+dOIuspb2cJJKJ+wVj5ee+lA4UMUMEEeUQlHOG2yXrCU7lJHW2WOsx3/0bEWwqcsnkDP+9M1l+TV3
X-Gm-Message-State: AOJu0Yzg8GkQBz7xoGFEOrKi440q9Sfe5/D9Dh55U51BOFD/Ih2ziG9Y
	61t5i5kCzK35HksP+pLM9QlsCykwkiMK0iiuPCq7sy38JGlNMgy9SCWOCwy4JWk=
X-Google-Smtp-Source: AGHT+IHJnqZpMatl+qZQ1LDl54iQMZBuwpc4R+dinAMPjeUN8lwQYhJ9H0Tu6qAEhM9wr/eSuSlGag==
X-Received: by 2002:a5e:9402:0:b0:7d0:3d2c:5987 with SMTP id q2-20020a5e9402000000b007d03d2c5987mr667271ioj.0.1711556259240;
        Wed, 27 Mar 2024 09:17:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id a4-20020a631a04000000b005e43cce33f8sm9428118pga.88.2024.03.27.09.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:17:38 -0700 (PDT)
Message-ID: <069b0fc7-0f8c-42f6-9ba4-275fbd830912@linuxfoundation.org>
Date: Wed, 27 Mar 2024 10:17:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: x86: test_vsyscall: conform test to TAP
 format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240314103216.286603-1-usama.anjum@collabora.com>
 <a1a6f5dd-80ab-4d53-90de-eb003c996cc1@linuxfoundation.org>
 <0dacf491-29ec-4c24-927e-978056177648@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0dacf491-29ec-4c24-927e-978056177648@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 06:16, Muhammad Usama Anjum wrote:
> On 3/27/24 1:00 AM, Shuah Khan wrote:
>> On 3/14/24 04:32, Muhammad Usama Anjum wrote:
>>> Conform the layout, informational and status messages to TAP. No
>>> functional change is intended other than the layout of output messages.
>>> Without using TAP messages, the passed/failed/skip test names cannot be
>>> found.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>
>>
>> I am seeing lot more changes than conform and formatting changes.
> Counting total number of tests based on architecture was really difficult
> until the code needed to be moved around. I'll split this patch into 2. The
> first part would just simplify the test by moving functions around and use
> #ifdef precisely. The seconds part would convert it to the TAP.
> 

Yes. That will make is easier to review and maintain.

thanks,
-- Shuah


