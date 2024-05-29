Return-Path: <linux-kselftest+bounces-10878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BDD8D4143
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 00:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E3F1C21D90
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 22:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3D169ADC;
	Wed, 29 May 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JuzAeCsu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABE167DAA
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021223; cv=none; b=moqfH5RzFqymWMdbYNJIYb0dh4usbb8QtJR2lnZE4stlwmeRwhmU34OTjsQX2m3YVSOpJs15pJ6U2kGsfds8ZKbsEgosurdIWvfua83OdLu/1W8oXFuHdgz8YoKEpqag4JAMwHLZAzTz1jsLP9E2rb4vjxpBK9D84OER2xinRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021223; c=relaxed/simple;
	bh=mMYi9aNUDo4Cxz3n7+bIVIuoJAd5/aBAYiNtOR+lnT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbmryvzQ/DsJW0oQ5/Ysd4LUFtWzHCt4f74iV7HvOXJs9uB9iKbQPChuua9cJawSK1lbYj8dN7wF/kjgnhhrt09fblANm8IHhRat2kMkcdhSGPa0BNOzYxARBX9eEOYBgQd5rvcJHRnR9VesGE/pcW9L1I07B1oodFqmbX9xktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JuzAeCsu; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7e24aa659abso1538639f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717021221; x=1717626021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqIyzvTkeA6zlhgHopIt1eourCo8hQ0gEK3kB/MiNgM=;
        b=JuzAeCsuj9OuMjzaIQmeHxptLmjXLQnJUJqOYFj4Ptj9FcSXtSR8oW1qX/V+RcxMDs
         KDrYNo7bN/mcEalVoszmkuWs8fYSvpB34Yul5TjotOQxf9IL895Ekv0KJOfks1SVN9s9
         eChywa+O+MGwoO/YKatFbn/K6OH4MENUi2OGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021221; x=1717626021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqIyzvTkeA6zlhgHopIt1eourCo8hQ0gEK3kB/MiNgM=;
        b=Kxc7QXMk3zG2Bwpk/44CBwdTr3RHknPw6UvPKuk4jtfYkjPxK0nVm/qLhaaAgZEdvR
         +fENuS0MWanXEtlY/ep5d1d8/fK73zqXNXYTCojjP+J52EHrXjX/9MrIBZhRwkFrWwaf
         u6POaKX0S54UfuwdkMlyNezwzOFFKjyOLcKXyFUQ9tw4Dn+Fk2SS6ArbaZxffXVJOJr3
         b1d2O+0/DgGSCsfbroTc0615ODFdzAN4zi0KtiVm3LIN08Znv5rW2hArwBOGH2GT/2sY
         rZk7UUSqTvsAYnIJIGN4O3LdArWo7pMJEQEJDO9xL2M5tiWVYiSXiMt6tc2cxsDe0ji+
         3NvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcPLSQ/98OlRZ/ubm6xytr/z9s1waoFqGD3a5DkksUVy7H7Cn/Yk96y+EEan2tZ1HXio3HoUi00gdcF/p09+2x617qNM2hYv9D7JJU4Ork
X-Gm-Message-State: AOJu0YzVDj8ZRoGH5iscYVkS+NwvgFMgBDHd1bN/4k68KVY8ZL5ZxUkg
	2vsqCTFO+0HS0srZnM7PZs2lSbsMgpDBfQY3vi5CC6O9ofviHSHbP0sDgMJWlAA=
X-Google-Smtp-Source: AGHT+IGN1oWI90wrMEiMI6sGuVOqtYT1CiAEw2A2euoSlGnG87X1DOMKyfYSgfTF8XB61Cyt02Mi1g==
X-Received: by 2002:a05:6602:8:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7eaf5b6efddmr43687839f.0.1717021221086;
        Wed, 29 May 2024 15:20:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b0bd61001fsm2138635173.125.2024.05.29.15.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 15:20:20 -0700 (PDT)
Message-ID: <c2eec7d1-27c3-4089-beea-168d19062aaf@linuxfoundation.org>
Date: Wed, 29 May 2024 16:20:20 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/openat2: Fix build warnings on ppc64
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>
References: <20240521030325.58095-1-mpe@ellerman.id.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240521030325.58095-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/24 21:03, Michael Ellerman wrote:
> Fix warnings like:
> 
>    openat2_test.c: In function ‘test_openat2_flags’:
>    openat2_test.c:303:73: warning: format ‘%llX’ expects argument of type
>    ‘long long unsigned int’, but argument 5 has type ‘__u64’ {aka ‘long
>    unsigned int’} [-Wformat=]
> 
> By switching to unsigned long long for u64 for ppc64 builds.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   tools/testing/selftests/openat2/openat2_test.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> index 9024754530b2..5790ab446527 100644
> --- a/tools/testing/selftests/openat2/openat2_test.c
> +++ b/tools/testing/selftests/openat2/openat2_test.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #define _GNU_SOURCE
> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>   #include <fcntl.h>
>   #include <sched.h>
>   #include <sys/stat.h>

Applied to linux-kselftest fixes for the next rc.

Michael, If you want to take this through, let me know, I can drop this.

thanks,
-- Shuah

