Return-Path: <linux-kselftest+bounces-45033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4369EC3DF7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 01:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E6AA4E4A88
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557F5278156;
	Fri,  7 Nov 2025 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T17NiJgt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D62765C4
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475090; cv=none; b=fd86w3+7+g0ncXOK1S/tdiaTHqyaGIvcMFAZ8nZZIARjsWUAllZVJ6OuvHznT8oC/rJiaf4xy7MKTi7aZ6gYDplzaeCv6AeND33vMDXVzen/RdD3xmnCxishM+TD+K1K6bvOmPOb2cfQ/2UGOKs+9cgiPnjN6Iio5avpGVZC1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475090; c=relaxed/simple;
	bh=XLWrFmYgf6F7bc1tZSN8JYD8e8DrgBT0ubR8anh20os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fj5iMsrD2AgDVy226AVg73vGWbK+QSA9CVL/JhMfNZPtxvQS22T45ySPH7hP7+928ItAOQCqP7x/iFe+v01YTBwxPqFm8tEumeLJyx//U05TxP/tvPm5P3rXZ1UYnIz0IRjhVTaEo5h3P9y6vELGgw/MluDsmrUp9slxjC17zRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T17NiJgt; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4330e912c51so767675ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 16:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762475087; x=1763079887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3Pf8rkEr6SoORFVa8JIykJJgQV3sWej0HFDn8C7mOI=;
        b=T17NiJgtQaJWtsaUddS2jcfHHb+C/j7kecEYm3ceFgxFNSB5ydVtiYcp7bBxu+gCOw
         uINVLIDwRAazsuvxJGyJOj6GAylrH8nw6tUTFYdEF6rx3gK+M/9R79nP5Pma5IocqdHU
         88K4ruzbvHdmm5eu/LoCxnKZfoQ7ovZCQvyyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762475087; x=1763079887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3Pf8rkEr6SoORFVa8JIykJJgQV3sWej0HFDn8C7mOI=;
        b=Xg5lg1Z64FPKigdFYLCHrSAAgFnwmkj5ZS7wfxhbzGBc37e5gBaXqvXD2fdpNK2V6F
         0q3oFDCHpTwTPn2QikLEY0XcPidA1xuJCLWxroE9Q8bS6nD2fdMtG1PBV4Sp/Mi3G985
         y+z8UOSFgT5euRyyMvGZvrwbQywQcKlnWfG5zg62rF8OzxtHGnxLObobMuWXSVt0hBtn
         Nvg5Bg/6NYfU/lDonHb2UVrAk77b0D7/0QUOq1/naexMwgaWLNbUEVVPH+L5odq1lVQE
         G9iJvkL2NheFzXKmPhWivQ0G2w0HHexhnJPQcigOkLMqSSY6vJDGv7froRhByJu5xj5D
         b+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHfJ++oOtXb9OhFDLUOQuR8I7K+4mIrMohRbuzlfEuZFPwZqa9MLkt3jv+UetTO7RELKDGzJaTa8Xvm8tPGF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nPZO8AK6V9IJEFjWUTOcf+1+gqMeBopL8vmDsKk4l1yMRR0R
	xllCB6AbignvvwsZ0vhEWoPL/n4UYaZgrLxcYc4YohNh3uCEdVN8dy76QSXelqAlNMI=
X-Gm-Gg: ASbGnct6cl8m56p5aiMS54oK5qodQtpYReHzRpkwiFaIkooNmrulB50XktB1fEN+F88
	8GQOVPj8tpQJyf8uM+BO2UoCgYVt2LSoyN/TL+hB/6RR4+wbYUXIHLogou/oPSnzpGQU0HzLFKy
	5WHBVQNXd2BmFlhy3xSFdbOb8/7SeZMPIgBeK8h3Ym/2/l+lUHieAeHz8Ca2eqc8O7yVS4gIVGM
	6q8fzkxOeUYhj8lhA4BNYs8qOoMZL681NIGxUG9WfABFV3tK+KJGTW/DpQmv7quWYa9IY4FqIzg
	2dBE48mC7rwf96jjOYNkb32EImsLpKBj7YlskoMAZ7Z1KYkagDrHsMOGUPXtW/ugMrLv7YwSfMY
	OQDwPpZzWbdLSVkl5NalHCwyI937pIK+LmZS2z9bdwKwC9KJyeJw8nUZyfDamSkXLhEVRJe/r1S
	3Y+sFG2L4F1wt06Ym6srUN9+M=
X-Google-Smtp-Source: AGHT+IESdNVTthD8LhJvh07byEKJ/B5pSJJsTsGTK9uvLAxX+Fv/PmXAeTZAJeM3pQ4++Nl3hlozjQ==
X-Received: by 2002:a05:6e02:310b:b0:433:3102:b0f5 with SMTP id e9e14a558f8ab-4335f4a7b53mr19451525ab.30.1762475086940;
        Thu, 06 Nov 2025 16:24:46 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b74695ed6dsm1374158173.52.2025.11.06.16.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 16:24:46 -0800 (PST)
Message-ID: <250fe2c8-eeef-4764-ad50-d5e5987fbd38@linuxfoundation.org>
Date: Thu, 6 Nov 2025 17:24:45 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma: fix invalid array access in printf
To: Zhang Chujun <zhangchujun@cmss.chinamobile.com>, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251106033056.1926-1-zhangchujun@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251106033056.1926-1-zhangchujun@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 20:30, Zhang Chujun wrote:
> The printf statement attempts to print the DMA direction string using
> the syntax 'dir[directions]', which is an invalid array access. The
> variable 'dir' is an integer, and 'directions' is a char pointer array.
> This incorrect syntax should be 'directions[dir]', using 'dir' as the
> index into the 'directions' array. Fix this by correcting the array
> access from 'dir[directions]' to 'directions[dir]'.
> 
> Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index b12f1f9babf8..b925756373ce 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -118,7 +118,7 @@ int main(int argc, char **argv)
>   	}
>   
>   	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
> -			threads, seconds, node, dir[directions], granule);
> +			threads, seconds, node, directions[dir], granule);
>   	printf("average map latency(us):%.1f standard deviation:%.1f\n",
>   			map.avg_map_100ns/10.0, map.map_stddev/10.0);
>   	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",

Looks like you sent the same patch again. I replied to your previous
patch asking you how you found this problem. It looks like a needed
change. Compiler doesn't complain about it which is strange.

thanks,
-- Shuah

