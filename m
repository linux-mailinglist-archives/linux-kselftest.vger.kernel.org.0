Return-Path: <linux-kselftest+bounces-11704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608169045F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 22:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A46D1C225EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB0152789;
	Tue, 11 Jun 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HXAtt4Yg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694DB657
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138936; cv=none; b=OwI1vJxnbMR4HuUClzCKed3NjeicOJ/xKujDtwACgVNJxx2QF2NWHPyI+8nnYDcN+BXdvynL/M9bJLSg1gSfhx3+rIsU0FYjl5O4DbemeKWytGcZZ0gJ1D8/BAhWZ5GCwvuYMB2lcIOOnLPRFAl3wNuednULwKQj17FTeT+7U8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138936; c=relaxed/simple;
	bh=pJf6oJLRj6fBaf0jbjyNj/7Xde43wr4W4HUXec5nOYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKZiPqJVTCHvNCqAff/Ndxm9z63/clRV+ntMRUcRyfpKo36FiEn6b0442KuGXP2lYtVQ39e/PDaleX8POqYkuddVJVhIeRF/tz0PaP4v+v9FKcscid+uQ5mN24kNCOEsfGOugmDuZ9ANV3OUigTbNO9Rik/op0prWXiw2Vym/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HXAtt4Yg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43fb8cdb29eso4989621cf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718138932; x=1718743732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y79weTWNeYH3OHuSeVZfaP6Dxpg6/VhmFQcWq0YiWSw=;
        b=HXAtt4Ygbe7+VefOwfV0otOanwNSQyqJg+uJzzSw5x1Z7kj+7hdUAuwMm0dBr3VWMI
         cnZAYOA7TUz9FTMBZAQwiDzesbLsPLHfdlQaq4PHYvyNBGYACpkbbOaFuy3OSc1HtkXu
         wEYIzUQJOSAyEWlVN3PMiYtKOkodP5mv7B2EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138932; x=1718743732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y79weTWNeYH3OHuSeVZfaP6Dxpg6/VhmFQcWq0YiWSw=;
        b=geAeefn/bEoo01m7rQlLrMgkglBbSwrr0X8rSLepTn0mAsji3dJ4paa9P3c4CE2w6b
         1wmzONI1yTAbQ7zhwwVOgNhStXw8OYCt6HqfCXLmkfidfxegjgRrV5A5ORZ6+AsU6QTA
         IxnTvOoz/9vsCxBGnQLKVanFq5jzwH6MtQeJnI/d9wDwjn922Y+6gmmqY7hVivUFfCX2
         mp3wTsR7YCBYQdSefhVKeNNR0b2ETmpIN7DS4x6rv/svVDOZCKR/Zoge1UexA6zu9CqH
         NZ5binRKimA4Fqo4eMCjyXNLaBl4Sv0ABt2y/2O/fbP0nbVoJIDiGXGw/tLkhNqNWgXE
         mtpQ==
X-Gm-Message-State: AOJu0Ywzp9LK5/tmoei7JtIt1ZhVctKjJEIHavpylnBaLexL9eiNZ+yo
	9X0e3fe7zV0oYttUtzv6sQEQe7lygcu60B4SRr50vZsBrMEJMYxuQw8Fbn1UawA=
X-Google-Smtp-Source: AGHT+IHRldpAykaEnON3fBkB9QBArbrfuwvf1Dd1I+MToHaIlihAs8rpCVdS2ZOXDCs9HpZv/ySYzw==
X-Received: by 2002:a05:620a:4886:b0:795:6b7b:6923 with SMTP id af79cd13be357-7956b7b6b78mr783398485a.3.1718138932170;
        Tue, 11 Jun 2024 13:48:52 -0700 (PDT)
Received: from [172.20.14.19] (ool-6c3a3e1d.static.optonline.net. [108.58.62.29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79568fc92dasm251822085a.84.2024.06.11.13.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:48:51 -0700 (PDT)
Message-ID: <d6c5ba89-065b-43d5-8584-0c1effa50c07@linuxfoundation.org>
Date: Tue, 11 Jun 2024 14:48:50 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/sched: fix code format issues
To: aigourensheng <shechenglong001@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240611051834.2885-1-shechenglong001@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240611051834.2885-1-shechenglong001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 23:18, aigourensheng wrote:
> There are extra spaces in the middle of #define. It is recommended
> to delete the spaces to make the code look more comfortable.
> 
> Signed-off-by: aigourensheng <shechenglong001@gmail.com>
> ---
>   tools/testing/selftests/sched/cs_prctl_test.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 62fba7356af2..52d97fae4dbd 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -42,11 +42,11 @@ static pid_t gettid(void)
>   
>   #ifndef PR_SCHED_CORE
>   #define PR_SCHED_CORE			62
> -# define PR_SCHED_CORE_GET		0
> -# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
> -# define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
> -# define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
> -# define PR_SCHED_CORE_MAX		4
> +#define PR_SCHED_CORE_GET		0
> +#define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
> +#define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
> +#define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
> +#define PR_SCHED_CORE_MAX		4
>   #endif
>   
>   #define MAX_PROCESSES 128

Applied to linux-ksleftest next for Linux 6.11-rc1

thanks,
-- Shuah

