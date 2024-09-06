Return-Path: <linux-kselftest+bounces-17402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D01D96F6AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB70D2817CD
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602901D048B;
	Fri,  6 Sep 2024 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShhvpNBQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F11D0496
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632958; cv=none; b=Xuif2+DY0fARb4Ui5HSYmoJ8KxYC3S8Om5XPmG3qFXrrpzV3vxVlOongOvJYj3HsiJZBaUuWKhQoeTD7lP7d3LFlXxLNBziZpMMYD9SOMmKd1H3E3cXQCe/8oh6pI7QCO8vEMUpkuD2myY0QsaTmfEF++b+blLrrhpvYC8jD6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632958; c=relaxed/simple;
	bh=Z7uwbWLL3gVBlQlRiNwnnYcNEC9uqFop/zsrlqxRwpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHY8j/2yszJjylrEV63W3QKkn8m4c38gg2Ok0l58ABAle3a78uJhOssqYj/+TottEokDikek706hgAwPLfa3GjvZb9wuCl/OVvPTv5Jqyzhx/huk6uOoal8RZfkKsrG/uBOOxtdocFszNS4x2ryq9wYMB9m29QLkxlqqhiFHo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShhvpNBQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-717911ef035so1505659b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725632956; x=1726237756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UwL0oqyE5031Tq289lAQ9RGIe66Rsgl972Tt73uO9Q=;
        b=ShhvpNBQYiuYEC4lnkGWreDRRlaX4Wg9+42DBTYUSkecFoP7k1oF66xeTklBB/v4Pz
         ksNAP4PlLApqVj9dRVu265YBf4LVIK5vbxs552Aq6FIXrEg8gShvDWbWHlqkL9D/jlOB
         n0j7dE1qXOtru/hsqbc03m1tPF6dn7JzGFNmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632956; x=1726237756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UwL0oqyE5031Tq289lAQ9RGIe66Rsgl972Tt73uO9Q=;
        b=k77Xfq65IkVB/jaySGLOJuDWtfQz0ZwtIc5BgSxfCTNi62fcDrEyRRVRGPJB5dSnka
         y9ni1Q6Op6JKGBjiJex2RlRUaYJ/Sin+9wNvMHgTJMpt1yZq+NA6vnDT+bJD5L9gSQqd
         +y6fKQx2yFbBAomkU5HsWZBlESbb4+DJPj4LSwuwhookSraECbHX+ltp0lLXy6cLzIhm
         BlU3XGE4mt/HI1H15vVofsnueG6VhYK6b4KxU2zNzJ6ELofr+J2k2LpkMoTR1UX+7QUE
         JEQpm+IRdPBGwvwk4IYopZYvZUWQdaVnxjx10EwDZEgyolMK2BcDqMkBsoJB9p+MgPCq
         hI4w==
X-Forwarded-Encrypted: i=1; AJvYcCXprgezG5NV9zT0fl4sviEkpDgHjLqPqtv8kpVApmuzrd2VdaTZyV0FeJvXrys7+JG+JU8AUemkQszX76AyRSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWTEA5UJqSmbYFpHQiwIe4sH4NYdVTmrGbKtkDu5MxRih2/2E
	2qZfxKcCKmsK9eFKx61twf9I0yy5gbSMpmVrecmn5MX1vgQunp7fhTSLMnTTvv8=
X-Google-Smtp-Source: AGHT+IGSzBGpMso7huTcEfzmj5vM49oojE2pcaTzBsLBUDADFxzjmFOeHYF0bYrNLu3H6+9i0zZ0EQ==
X-Received: by 2002:a05:6a00:4b53:b0:710:5825:5ba0 with SMTP id d2e1a72fcca58-718d5dec32fmr3353574b3a.3.1725632955887;
        Fri, 06 Sep 2024 07:29:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71782eb5352sm3904280b3a.154.2024.09.06.07.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:29:15 -0700 (PDT)
Message-ID: <49d07daa-622f-4c04-9d00-221f8abfb4f3@linuxfoundation.org>
Date: Fri, 6 Sep 2024 08:29:14 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/timers: Remove unused NSEC_PER_SEC macro
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, jstultz@google.com
Cc: anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tglx@linutronix.de, Shuah Khan <skhan@linuxfoundation.org>
References: <20240906025259.3822-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240906025259.3822-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 20:52, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> By readind the code, I found the macro NSEC_PER_SEC

reading

> is never referenced in the code. Just remove it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Running checkpatch can catch spelling errors.

> ---
> v1->v2:
> 	Put together files with similar problems
> 
>   tools/testing/selftests/timers/change_skew.c      | 3 ---
>   tools/testing/selftests/timers/skew_consistency.c | 2 --
>   2 files changed, 5 deletions(-)
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

This looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

John, I can pick this up with if you are okay with this change.

thanks,
-- Shuah

