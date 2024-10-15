Return-Path: <linux-kselftest+bounces-19688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C8099DA83
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 02:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CC2282BD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 00:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B648A29;
	Tue, 15 Oct 2024 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="byeyIuGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41B19A
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950761; cv=none; b=Tdvh3TL9DmIw7qdMJnDRzmedo0GQJHBpRp9TRSGohQcWPhRyhVr0WKWPxKCsUjGBKXaRg/yAqzYOCd1oLTWL4CIpOP/DGatBqz2+CQFcYsq0Z/bIBUd0QeK84UNG3XogybRwPlwvx2LeR8h+4pyoE55ns/TA7crMP9L7Pu1ke3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950761; c=relaxed/simple;
	bh=ZehjK1rwhKlSbWRcVkYC8kqDslvkx7/iyzRyA+OQZ8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qtnop9vyO/88ov7ho4c2sOl+Ez87KBKnAXqMTc/dK2JdAdglPZivfQrmHO0HH/sTdLTZDVqQaALlCkj4H5kUxBnWMDyMxvX7PoEqkPUhT21JcJqH0HrZ+OpN8dpiTIYnL1XEH53J77/xGmfuoIGnd2Zo7gtVKPPoh8u4iNZUoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=byeyIuGM; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8354851fbfaso231383239f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728950759; x=1729555559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TwSGWYk37LzL+nB3Qm3Cccq9jA0yfLg7SdVrI2yTuI=;
        b=byeyIuGMPm5tAdlcDfvC9Onc0kjkW+PQ578wqC9y8CNORMTu9UIDuqdapzR3sFn/1M
         ivvRBdWEA//60NN5HnDdr775wMu8ieYrwVFeqO9Prk5aWD69rmrVqQlfedZafxyVQrO1
         /5AApctqsRvVHkNgm2vP59kg6PvFZJ9C7lFYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950759; x=1729555559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TwSGWYk37LzL+nB3Qm3Cccq9jA0yfLg7SdVrI2yTuI=;
        b=Ktv4HGfKDg017DBS3tjSOmsxtBLy0iuxutA0K10M1FhDcZQfThrvUAPg2kpu1lwfsI
         /9CQDDZQy5iBSZI4BNU3SesQb42gInyEgZJWI+3D4FwyHyJye+XjGSUFm0DTppiAj1MY
         73l63MqBgVpQjVo9ZV7XgriLqoIBjd/ikj9wIrIt9yrwrGjWi1Pm8ENMLZ9js2msfzAF
         yyO3iTTHImI4BvcBUoj72fbUO8m3qgWgljpN8R9zIS1X0owaFUkOQo5eBpWF6TtRfGie
         gZRXnMD+a3PleG9sssdn94eS0CawKMxFZWJnxyCGhLCSsD3eD0sBRUlG1irQvHZgWy5+
         T7yg==
X-Gm-Message-State: AOJu0YwU1YbxljZjuVnY05LrUa5aKV7yRYzJH09RR7nt+b8kvavZwaB2
	ZY/4j3SoYONyrua61FmCCqCMYCKdgHJATfzOorU8zhnx07JgXR+Tf5zEF0aI3e4=
X-Google-Smtp-Source: AGHT+IGRqsQFDY3Ma0cJGFn2I+AneM+oWcFsIjl4jiCDBzYJaEobcPJEKkPQeLj5lCNCHDovZt411w==
X-Received: by 2002:a05:6602:3fc6:b0:82a:4c58:e1e0 with SMTP id ca18e2360f4ac-837946843cbmr1166620739f.12.1728950758843;
        Mon, 14 Oct 2024 17:05:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83a8b2aa095sm3961939f.19.2024.10.14.17.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 17:05:58 -0700 (PDT)
Message-ID: <41d157fc-6413-4061-95af-518ec7b923f1@linuxfoundation.org>
Date: Mon, 14 Oct 2024 18:05:57 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/intel_pstate: fix operand expected
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 anupnewsmail@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20241014172149.324639-1-alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241014172149.324639-1-alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 11:21, Alessandro Zanni wrote:
> This fix solves theses errors, when calling kselftest with
> targets "intel_pstate":
> 
> ./run.sh: line 90: / 1000: syntax error: operand expected (error token is "/ 1000")
> 
> ./run.sh: line 92: / 1000: syntax error: operand expected (error token is "/ 1000")
> 
> To error was found by running tests manually with the command:
> make kselftest TARGETS=intel_pstate
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
> 
> Notes:
>      v2: removed debug echos

See my comments on your v1. It would help to wait a bit
to send v2.

I can't reproduce this problem on Linux 6.12-rc3.
What's you environment like?

> 
>   tools/testing/selftests/intel_pstate/run.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
> index e7008f614ad7..0c1b6c1308a4 100755
> --- a/tools/testing/selftests/intel_pstate/run.sh
> +++ b/tools/testing/selftests/intel_pstate/run.sh
> @@ -87,9 +87,9 @@ mkt_freq=${_mkt_freq}0
>   
>   # Get the ranges from cpupower
>   _min_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $1 } ')
> -min_freq=$(($_min_freq / 1000))
> +min_freq=$((_min_freq / 1000))
>   _max_freq=$(cpupower frequency-info -l | tail -1 | awk ' { print $2 } ')
> -max_freq=$(($_max_freq / 1000))
> +max_freq=$((_max_freq / 1000))
>   
>   
>   [ $EVALUATE_ONLY -eq 0 ] && for freq in `seq $max_freq -100 $min_freq`

thanks,
-- Shuah

