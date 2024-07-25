Return-Path: <linux-kselftest+bounces-14239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C693C621
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0843B1F21E4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B4919CCEA;
	Thu, 25 Jul 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHvVHMO6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3727482
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919934; cv=none; b=HZpp14lL7HYJg/VJ2NNTSgaRGwIZq10IrcvRI/yhs30RHQXSwc/Fvr+e6qr/CoDJ3+tu9dl+DnBtOeNYFkrCpZ6BnybqgNKWD93KqvzDO2uGJ6AVs+K0djuWSeBegKBv61OSd0ZytreQunOJaCk+8eUoRexhl2/Li0IuvjgTu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919934; c=relaxed/simple;
	bh=nwqay9Yzc9V/MdcskLBTA8LUyLT1NESrwzti7d4cEZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHKhYn1z5vbrB6xs/wXUqQR5vcaVFgtRKbBz8+HL4ivVA24auNWnFcQUy//oKg5dQu4hvXrvXbpVt2VzbPzVOkoDM5gIvWXWjYSN8lQPv1338aNn9O6RgQvfvJqdvuJM34DmIdB5A4e56VJP7ntI/NgVQDN3xaGADuB4WEfgkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NHvVHMO6; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-38b4276d643so183675ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2024 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721919932; x=1722524732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvyOYhnjKhkMcy56pvbeVq9X+bXBEVFjavfRZVHgAl0=;
        b=NHvVHMO6EsuObX9eSJa0Wr0M23he8b8pAQ1+vLbFUejxbWaXdqsGaXdAebBJ1oWavJ
         NzVwTkpIt+jwX4xKlAbtCx29vpcTvsVD16G2LJlL/d2R7LFaKxSgYYLN6FQ8gUQgNEAW
         k0BjFab3LxsVt7ZSfg93unOQ8Hy6pw7HivpKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721919932; x=1722524732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvyOYhnjKhkMcy56pvbeVq9X+bXBEVFjavfRZVHgAl0=;
        b=jCbrUOuf21sorr1r/NhDazc+DwIiqhnen/vFmepJgITojeEOob6vnzfQQsVkRYmd+7
         4N8+M/qW7PoL4Dwo6ogb32HpWXI3Nl9jtDyXuQ90ov084n9QCnkTKR7QbXKemeSg1yBw
         avNarHaGvkhC8N12gl0Hk6jyJm5AFFe8qg9Dp49etPraCLX1sECd1bGHJAsgPM5Zwfcv
         7wVhlcpk1yJycoDui67wH0Wa/s+OAeXxh9dp1gFzy/GyCW+nAjH1DtUEfdq2dwfFp4hn
         2NQh2kTBigfHOs//LQo1ynERN1f42/Tg2AQcLvDxNsUemjed5S62L4xvjrVz8cXnWI/I
         6sdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKpZFG/He1jrPsl6IsUrxcDmm0/ffwha/9avgEI6c7eIEEL80PSxnxGm1P4+bJrGGanC3fUdRE3aWlx1jbruQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg9/Rd1gkSooLt32C+EJuP69pvDIslS5v5QQMRk1zoZdzzSQwr
	yaXvLl4z9K/DxriER6CCMRBcE//zlmFd2ikeEhCGH33ed4Ue3CTEkuE6Z+qo8dw=
X-Google-Smtp-Source: AGHT+IFLdCEnuQWY5ReTzoOOPS5jvp18TA2fpDMWDgGVkRl6Jlmv4BH8fa8DGo9D8rxZVrJxNHXW6Q==
X-Received: by 2002:a05:6e02:219b:b0:38e:cde9:cc86 with SMTP id e9e14a558f8ab-39a22d3271amr19643215ab.4.1721919932155;
        Thu, 25 Jul 2024 08:05:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29faa83a0sm359387173.55.2024.07.25.08.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:05:31 -0700 (PDT)
Message-ID: <edd26914-9394-40d4-824f-203c7d4e3833@linuxfoundation.org>
Date: Thu, 25 Jul 2024 09:05:31 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tools/testing:Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, zhang.lyra@gmail.com
Cc: shuah@kernel.org, kees@kernel.org, luto@amacapital.net, wad@chromium.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725023401.13365-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725023401.13365-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/24 20:34, Zhu Jun wrote:
> The format specifier in fprintf is "%u", that "%u" should use
> unsigned int type instead.the problem is discovered by reading code.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   v1->v2:
>   	modify commit info add how to find the problem in the log
>   v2->v3:
>   	Seems this can use macro WTERMSIG like those above usage, rather than
>   	changing the print format.
>   v3->v4:
>   	Now the commit summary doesn't match the change you are making.
> 	 Also WTERMSIG() is incorrect for this conditional code path.
> 	 See comments below in the code path.
> 
> 	 I would leave the v2 code intact. How are you testing this change?
> 	 Please include the details in the change log.
> 
> 
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index e05ac8261046..675b8f43e148 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -910,7 +910,7 @@ void __wait_for_test(struct __test_metadata *t)
>   		.sa_flags = SA_SIGINFO,
>   	};
>   	struct sigaction saved_action;
> -	int status;
> +	unsigned int status;

This change is different from what the subject line says and
what was in your v2. Also you didn't tell me how you tested
this.

Sorry I have to nack this patch.

thanks,
-- Shuah

