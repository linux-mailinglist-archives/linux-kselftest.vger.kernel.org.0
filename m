Return-Path: <linux-kselftest+bounces-23453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF379F5109
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 17:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3C1188AACE
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C031F6671;
	Tue, 17 Dec 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GDQ9rIaV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6714900B
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453040; cv=none; b=JlXXYLDLWP6DirIHiFh5bnC44iYRN9sfQFUZ6NWWQ7FFodEHAPnjfYw9BBZzshwm07o80wp5hF5KJRHYKHFY9fKlLYlcxSi2fntwakcczaDW9CsrenAXpiDNDWDQtqy1hUx49mEhw2c39q/88/CsnFPo5p8taihR1TvPolsCoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453040; c=relaxed/simple;
	bh=MkPlOU9Np8qUPmVxBacmMIMYl2oSkgbeO8c3DYO4490=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXwgDKgtp7aoDyQDlSHY/8q8NUtF8WpDen9sC48TYuwXQaGOb/bSiDk0iQ/N1W/q7ZpIPGgkEN9yNj7AdJy78tpVx1YiM6ejjkZ/zX+bQBQ2RHp2vIO3TnmIOu1eLaRyYSbGL/tJG/8L12FcPoB55CcS7KhAoW5hhQ+Pc04Vp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GDQ9rIaV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-844e7409f8aso174582939f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2024 08:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734453038; x=1735057838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEDKHfNxLLhMxMAjmKBgYR4NMvDMw6yuLjE3m7stOZQ=;
        b=GDQ9rIaV+h0C0wDMU/feUdX6+6Ihs2QutSHkRav8v44pefXwjPuG0VkDE7g5rgE5kj
         7ux8ZQv+Qxu1zFlt3dtjRUbUPpC75OIy48ua9w9JNBS14pna9jW3u1dK4RAw/Do97wb2
         f7wIS68y0Kj0oYc9c0boyKIU2pdsV3Jtwa8Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453038; x=1735057838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEDKHfNxLLhMxMAjmKBgYR4NMvDMw6yuLjE3m7stOZQ=;
        b=sL94pEmhIZOY/tME9aoSwpX7JuUv1rXrtG5oPCPx2hjabJszAbLHEoit+2QUQ2lcoF
         D2yROm0S+5mdLfiCjNvgHGwFpcUeJsqvAFqCNVjTGQHGM39CrJWoFbxIC2EoVvnLVLvC
         SWwJTL35+WK2uI6b7LHqRL7UrrjI1tgul0jBqM+ztCVPnwV3VcyJV/bWm1JTFrJxBmUi
         o1R4UR4UA4EAyFWezpyYSDx3/uFW6x3rhzslguQ49yW7auKQUEgjyVPX7JMkSKgR9VIE
         Cm4aFXBmK1np/l+4xWZOlTQiJeK0Y4RBiICqLH3F7u4nwEnm4eEbgMtxmxL9BitKdl0y
         mAfw==
X-Gm-Message-State: AOJu0YxqhH6rOteRRf78xUu403nPsiSZPosVdtl+g7IX2AuGlrh3gef2
	0kI3KYTRO71wKcAo5XMcvL4ZLl+P8TM9RDBS7XhHzrHUzq+y0vLaVzp1nj2eUbM=
X-Gm-Gg: ASbGncveKxntRRweAXyOTT44LyxSjdk26UUGqZWxEqFyvR6p9aSTlG1Cf2gnmUAibJG
	NtRIbZfm69mP1n/jAlD0um3cLPCvBs0G9+L5GPbxb8xp53RQ4sEIfUrtKv/ZTeKhnZkah8WTn8K
	clMRih0f0ezLumPJTlgbhIXWUVgS1PrEIq/1jwSNm5hbVEzlrzwvjjPz1rvDhLd4gKwodkGUXGd
	2U3S+yxbRJu6sfsHRy3hXVGk52JgDcfrQxFgrseBNv5VAfAYI1jTvn9QC9w3XmQQNgq
X-Google-Smtp-Source: AGHT+IGg7Gi7gWhTEi4s+1hPh2zcRL+Pf3/Q2M6W75aJGIBtWKQW9xL7s088BBP+ftbhmeE7QbFuhw==
X-Received: by 2002:a05:6e02:12c5:b0:3ab:8db6:12ac with SMTP id e9e14a558f8ab-3aff4616e30mr145746905ab.4.1734453037526;
        Tue, 17 Dec 2024 08:30:37 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2475afae7sm21853645ab.13.2024.12.17.08.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 08:30:36 -0800 (PST)
Message-ID: <41a2e17e-0aaa-4dca-a28d-313a270d2016@linuxfoundation.org>
Date: Tue, 17 Dec 2024 09:30:36 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: kselftest: Fix the wrong format specifier
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241202043111.3888-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241202043111.3888-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/24 21:31, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The format specifier of "unsigned int" in printf()
> should be "%u", not "%d".
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/kselftest.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 29fedf609611..062c02a7be2d 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -403,7 +403,7 @@ static inline __noreturn __printf(1, 2) void ksft_exit_skip(const char *msg, ...
>   	 */
>   	if (ksft_plan || ksft_test_num()) {
>   		ksft_cnt.ksft_xskip++;
> -		printf("ok %d # SKIP ", 1 + ksft_test_num());
> +		printf("ok %u # SKIP ", 1 + ksft_test_num());
>   	} else {
>   		printf("1..0 # SKIP ");
>   	}

Applied to linux-kselftest next for Linux 6.14-rc1

thanks,
-- Shuah

