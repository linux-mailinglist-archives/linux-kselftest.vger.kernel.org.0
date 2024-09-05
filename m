Return-Path: <linux-kselftest+bounces-17283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF7496DF2D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4221C22985
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7A819E7F0;
	Thu,  5 Sep 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hwgKkTyW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EEC19E7E3
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Sep 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552511; cv=none; b=dV1ayxuMjtpPubZfXZWLv6qSvWGRiGSbm48vDkFFBB8goBk1evOYc7spwcQ9BodFo/fG6vqfljdUs8y4CCIoBA+qdPphfHQzInDl5o7jjUZx+NWLoS7h09KY54gVm+KeNobfQubF3RD9kencsMf8E8Gvqr2G/JBOnXMcwzCnIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552511; c=relaxed/simple;
	bh=cuduEfejvKDdkbF8x7hNIMS7Tne31cgqmqyWhN0+h+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4P5I5k5NWuMMQjBoLh6Tv7tMx6uTwDkp6CPF3U74OChwGmSzwHyvROnoYPAkdcacRzPYLbDw+bCg7Ja3dxYlvfSTYTSv1BfKDzjm2+R5D/rCfHSHs49wtDIYo2s78klMXDPBHfO/1krhuiBUbYJKEk97so0zEccKCNgx29hMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hwgKkTyW; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5df9a9f7fe2so654290eaf.2
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Sep 2024 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725552509; x=1726157309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/WCYr1JbYjj0ZMzhtqR6ayRKYajzzVLnjoTs1Mi4yE=;
        b=hwgKkTyW23VpeyAsBgbt2OczXe5oeqUNQ5Q9B7pA/zB9pbTj2D0x9f9SSrgVXZAk0A
         MH5JAjyiqUukIksCkTWq1syZCBzrx7SsoIN8iNWVtkgk424vCS4evwQDbekI8yZV7Qjb
         zvbRoGovMS+8Jpx6BBy0PD39yMyrCopiiy+tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552509; x=1726157309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/WCYr1JbYjj0ZMzhtqR6ayRKYajzzVLnjoTs1Mi4yE=;
        b=CbnQrNkGwzqzreDJcu69+1SxX40qOJno0JBjXsRcTpC00wIXww1jRHEDpMPZh16tm6
         yZPJ8w+iij5Z7KfIeseqieUKZAjWCy7I7FHCd5bYVoNLlHyq2+1raPNLokHpA5hjqxzu
         o1vganxKXS4KjWvEjE9EW6qfVt7cVVfXeIY2PWWtO9ohYeQS5lIi6J4s/Bp45KX15V7P
         6U8QLECJgwCuuY26FKYdfhgg/rlY0u6UjY3r3l2L8czG9y/N6dDfIh2IE1enP76ZW+1f
         NdO2So/Qv+PVZEE6Y7wiiT6EIzfY/DkfzcnzxHIDfD02mGguS52oCGvv6qw2l3g21lra
         3PKw==
X-Forwarded-Encrypted: i=1; AJvYcCUGMcCj1Ftdlj3zyWgM3Qm68npBnSIR43A8TItfsAqnxDpu6+WN517o1JBcLVS0YSuqnHYYXZVxou1Y4yb+tNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+8q3GKMRuaI4sTcZuyJRXILrTS1CRvPEQcR3p/udjBN+40se
	M+WuYQJuw1RQACbgZZzUyVOIgESXTTl2uAB1ia4AznGw8sMSFZ2+E6+g0lyXlAQ=
X-Google-Smtp-Source: AGHT+IFWxPDKxw2DoJfRGTnmYYeDt0CbjxRedAwDovAPjSfmRBCSdw/D2Db1EVj5oCOC5Fs2eM2amA==
X-Received: by 2002:a05:6870:331e:b0:25e:7a1:ea8f with SMTP id 586e51a60fabf-277d06c897amr16978310fac.47.1725552508933;
        Thu, 05 Sep 2024 09:08:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e935a3sm3742992173.108.2024.09.05.09.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 09:08:27 -0700 (PDT)
Message-ID: <f22bc072-c8b0-405f-a4e6-da6213350c1a@linuxfoundation.org>
Date: Thu, 5 Sep 2024 10:08:27 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Date: Remove unused macro
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, shuah@kernel.org
Cc: jstultz@google.com, tglx@linutronix.de, anna-maria@linutronix.de,
 frederic@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240905085230.48438-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905085230.48438-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 02:52, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> This macro NSEC_PER_SEC is never referenced in the code.
> Just remove it.

Is this duplicate patch?

I think I commented on your patch on futex - include how
you found the problem in change logs. Also you have to
include subsystem prefix in the subject line:

selftests/timers: Remove unused NSEC_PER_SEC macro

I see another patch with similar problems from you.
Refer to submitting patches document in the kernel
repo.

> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/timers/change_skew.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/change_skew.c b/tools/testing/selftests/timers/change_skew.c
> index 4421cd562c24..18e794a46c23 100644
> --- a/tools/testing/selftests/timers/change_skew.c
> +++ b/tools/testing/selftests/timers/change_skew.c
> @@ -30,9 +30,6 @@
>   #include <time.h>
>   #include "../kselftest.h"
>   
> -#define NSEC_PER_SEC 1000000000LL
> -
> -
>   int change_skew_test(int ppm)
>   {
>   	struct timex tx;

thanks,
-- Shuah

