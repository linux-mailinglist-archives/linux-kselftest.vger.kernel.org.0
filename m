Return-Path: <linux-kselftest+bounces-13402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4320692C3B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 21:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748A11C21190
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5E182A5B;
	Tue,  9 Jul 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HTtQSZVJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D2182A4A
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jul 2024 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552037; cv=none; b=seZ05sGL+2dQtOO/XvLWDbVf/Njld35k7fGu00IZzJnKuKCTNzgkgEnVaQgLxxXg5zo74ebd0RB3Wd75j5jh1HbvRhqxFDXk2q0K0Pj6HxlHzIGcVweJdHey9epwhhavbRNdM3vhXhdBw5oEnkexHmsnf8kGMEeIH98MIgiksp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552037; c=relaxed/simple;
	bh=WXaDUSer1JeKpTsguBNZfMDkgjQaVnYvPPrgYNXt9Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWa0+GL15pI7ypHl5S9cNUv+wUsBorSY2dctOM6vtGm0M/X53+sVzmfhCfcemeAxJ9y+yg3FivAP2Z0XAv5JhOn8llXZB4332fGYHYwnNTRPtuxCeZqu/Yy5aAafMxL0K4v0fj+AdFg2zhRu2cpOUQHqGgl1CEykI9UVAZHAA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HTtQSZVJ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7eb41831704so19488939f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jul 2024 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720552034; x=1721156834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLDDHSbnn2NLMgl2QCrOLZUDA51mpDhgOIgigd+xu94=;
        b=HTtQSZVJ5XUWXYqi7T5tgCynynDlI2XFpr/26qIGBncVmeCh6asOobwNmS1zt+tM+W
         L7rYc0G+ZL/BLxz4BP/cCrCVD3xiTHIO3AfsRjWD3tAdFqlk28S4h3LBmSTPHQXf2CUP
         /92B1Cfd8Fwxs/hEsXA8XVn+yxoeXk5cnJpF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720552034; x=1721156834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLDDHSbnn2NLMgl2QCrOLZUDA51mpDhgOIgigd+xu94=;
        b=TLaHWrnzSJQqCQVhZv3f22qOnqivhmOX9d+JBryQdeyOoNUUqlEC9hswzrZHSpnN4P
         slqVQOcuWjoT3usJJ53i2fhkHZpmjaYhRyYmzzzj/0qvcJdusaLZrwwGMaGsODnTIVKm
         WbmCQern9X3WeETbQ5QM+aitK8m5aKLE4Rnpvxro/3vQkqBz93kp7hdcEQ0WQMyJFifV
         kfVcABvcoNoLFDfPqml6v96FEYqs6fbbpmsZQ/QyTASPumyMOjCOfiuLGT2bp17rc74q
         HR0sFaAViagTRQeZyAOa3zvms4wIFwPZAnbHMGHoQdJvOrpSV144DMRI6oUbOul8cR45
         T/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs8zNJNhn1mKuHCo0aAJnRnbEtaRMKoRBrhkm+nalovMT/vFBUWarK167QMrOmtDae8aKkwu1M4EZpl3NhbGbonT+Pt+nNlgtwNPz8KjDt
X-Gm-Message-State: AOJu0YwM+LPIklw7PHAXYUi0bCp/AxyrOL6LEABT2haroV9YCeYiukZh
	mK3O+HoVN3x3+FMABwG047Br7P4+wbvpCLauinYLFyvYx0J6tt9DjgXrPBsFxjlJkcRiKidU4ER
	D
X-Google-Smtp-Source: AGHT+IENiOsKcIna/f3mRvugF36IMwmpCnRhZ9tM0YYxJXeBBmTvMn2hHy+f1Cuni3zz30X2KQSCAA==
X-Received: by 2002:a05:6602:6103:b0:7f3:9dd3:15b2 with SMTP id ca18e2360f4ac-7fff92c5be4mr375342739f.0.1720552034605;
        Tue, 09 Jul 2024 12:07:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffea4712d2sm66026739f.27.2024.07.09.12.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 12:07:14 -0700 (PDT)
Message-ID: <aeb63fb8-d966-4aab-ad5f-aa62219048db@linuxfoundation.org>
Date: Tue, 9 Jul 2024 13:07:13 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] selftests/breakpoints:Remove unused variable
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: angquan21@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240709094443.3648-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240709094443.3648-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 03:44, Zhu Jun wrote:
> This variable is never referenced in the code, just remove them.
> 

Please add information on how this problem was found. If you used a
tool, include which tool and warning from the tool.

> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/breakpoints/step_after_suspend_test.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> index b8703c499d28..dfec31fb9b30 100644
> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> @@ -130,7 +130,6 @@ int run_test(int cpu)
>   void suspend(void)
>   {
>   	int power_state_fd;
> -	struct sigevent event = {};
>   	int timerfd;
>   	int err;
>   	struct itimerspec spec = {};

thanks,
-- Shuah

