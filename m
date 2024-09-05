Return-Path: <linux-kselftest+bounces-17282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3E896DF29
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E535F1F23372
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197219EEB1;
	Thu,  5 Sep 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBgN4Pma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AFF4AEF5
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Sep 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552475; cv=none; b=B21SrOf1/7iBrwktHv8ZfCgs+mu/yAMsMOVKNVLYSIZ2z9OP86mKZPVgWuqVrTdM7q9eQFh8NrHCQGWFfoRB9X+oNZy4fFXrYaHyXPO0DnrsaLwR+aEdPM18q9enj8xKm2BnoVY+LHmRPv1ZgddJAgJCv75xnjX3EodgX25lIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552475; c=relaxed/simple;
	bh=3hDV8MPZl2eeco4sWtcX1QKF9GuPivZcxQ7EeyYXZ7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTBmgojsfJRvEWTRKfietjNun03JEMSdLv9LMNwg4AdW+ohYeeUuzdpn2JsUwsBBq25HaDOqpJsWA7RxRYPOPTi/me8Nk8EoTfIma/MmRATXCKqkJ7mWOMhS/B/ZAv/jD8/0mw6cZWbnVRmewvoz9N4ockfIVftMH6ayum3I69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZBgN4Pma; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82a1741aa31so33999939f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Sep 2024 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725552473; x=1726157273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T591UkCT0IYbn+oRGt8t+hSNqz5uHQFl1/H0d1Ig8Os=;
        b=ZBgN4PmaTd4HlJUa+TiRVrrpDOlftgBWpbA/yVPFyLsxa/JU0c5Y82AN+hP5jqzz1H
         pDt01KZ30KMK+UMRTAIlSIZ/K89btg76cstgrOzRt1rpI5GduEchYax8XybL4gW9PQDD
         QugYV/IsXzQ7K8RQ/L7ffKplxfAR/iJZLA7EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552473; x=1726157273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T591UkCT0IYbn+oRGt8t+hSNqz5uHQFl1/H0d1Ig8Os=;
        b=TULHm0q+ckvSjtpl+ZKjh+j0rB/kP3ua1nFuP1RFPGfvrDpBk4FCuy9iEVipVaOb9U
         YscJSDQO0T7UJ9y2xaIxkGoPp8x3LmPOAACpXv5AhxeUwpvJ0OsiTc5DnT3w9flPhC3+
         WlvefZ++RfcxZJq8R0CKtpd4tvaOZp0lxaflxo0dLVHO7w5cmjDFDT92qMB+yr5ihFmy
         ATCy5P87BkrF7AxrK6x6ZtFaPf7N/56v8Nz07qWVvXQnHGNXNXf1Y3P/T73ORgOCHtup
         wHl0DPVu+XnWpFVDGDNmh+bfLBLYwwxB9S/IoPItcTjxjLdMvK0s/YHgnuESxP8SYmzO
         R44w==
X-Forwarded-Encrypted: i=1; AJvYcCVGEZZM7UxMqxsEoc335MwPwxRv3OSfxng2ovnO8TW3D+O14AJlAgDnHdIaS9mueNAmQOcbWLxKhP8cFHk1d28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI9iKVpoAOdHi6GR+JyPTAJOeXLIxXxJRkwrld+Vn2qm4gGMb0
	eherGNUfogkY4inm+NSAhjCnl3NxXvmmGHW6E5huOcXhdFY/pSez+M0cH9Ezwtw=
X-Google-Smtp-Source: AGHT+IH34WOoMeDnGk9Vnz5Oe/4XHQCc9dZANduVVgdF78YsmCXfvLa8Fh7v9CzXGfwh7/TVQaalzg==
X-Received: by 2002:a05:6602:14cc:b0:82a:51a5:bd72 with SMTP id ca18e2360f4ac-82a76fb3aaamr870290839f.2.1725552473085;
        Thu, 05 Sep 2024 09:07:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a5cbba0sm418479939f.51.2024.09.05.09.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 09:07:52 -0700 (PDT)
Message-ID: <7e9edd64-9a2a-4c69-a167-2e8e94fd239b@linuxfoundation.org>
Date: Thu, 5 Sep 2024 10:07:50 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Date: Remove unused macro
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, anna-maria@linutronix.de
Cc: frederic@kernel.org, tglx@linutronix.de, jstultz@google.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240905081325.47673-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905081325.47673-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 02:13, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> This macro NSEC_PER_SEC is never referenced in the code.
> Just remove it.

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
>   tools/testing/selftests/timers/skew_consistency.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
> index c8e6bffe4e0a..83450145fe65 100644
> --- a/tools/testing/selftests/timers/skew_consistency.c
> +++ b/tools/testing/selftests/timers/skew_consistency.c
> @@ -36,8 +36,6 @@
>   #include <sys/wait.h>
>   #include "../kselftest.h"
>   
> -#define NSEC_PER_SEC 1000000000LL
> -
>   int main(int argc, char **argv)
>   {
>   	struct timex tx;


thanks,
-- Shuah

