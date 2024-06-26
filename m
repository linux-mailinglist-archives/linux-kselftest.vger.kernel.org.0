Return-Path: <linux-kselftest+bounces-12825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AEF919848
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 21:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C22286477
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E1191494;
	Wed, 26 Jun 2024 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L/qJZoeA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21812E40
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430423; cv=none; b=IrEzNn9JeNRbwDlfpmKdu7GLRX5OkfpbOtOkOca1hwmbPt1gciHmmwbHY5zKnE/RE0RSteqk9UGrSws3G4ypfxMzF8O0qXSMqsTK8fNBalpKmHuqj56JgGYQxKR+ENpbAVUy19OD6LLYvM0ahHfZXvKWFFb/pNMctkk6I9Pc914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430423; c=relaxed/simple;
	bh=l18AoZChb2F1cCrN3a4jLW9ULyXRHxpXYU/VYO2Ydm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kax2JfNJlNKks+XEZvwnNuzBMN3HWi8ghE205+BLnpHZTxg+OCvzWtmDKIKmLLUEmeN8hauSzLx3/xObjXiPaOdlfum6EOOqbm3LclNsPwqFOTngVvsOzdt4WmERZyxF6vaqQqFcqhHLlmonUuN8z5noy7PRuyy52TcFUV480+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L/qJZoeA; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3745eeedc76so2733755ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719430421; x=1720035221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yCyknkf046UKn72zBDthYHwVzB1aWw8u7LDjnxxVfw=;
        b=L/qJZoeATUgTZetSkujzWWSU9ZZ54LzzejvvphO0ppRuOrxro+9z4G7nO9dAtGDV4t
         N+2lDEohWmLXpT0wH7dKgZiHRBJ4uiahQu5jpnBrGEjjBxZxCzxR974EYA3OXFxiCcSl
         lKKXYreQUlgDKGgjOt3JjUk8ZzD+4Vw2tI8tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719430421; x=1720035221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yCyknkf046UKn72zBDthYHwVzB1aWw8u7LDjnxxVfw=;
        b=Ca+0GVeR+ElD+JoiU01hDioQZLvR9L0UM7jIrR0tPfhzfWrQl8NzDKz7d2QF01Nif5
         pkSHNWGEM5vWXVZG9mEMmXAwko3ifTDpLEJ6tIftOEKcjmePbzXn2t/cidFpN7GB78Ne
         rTIJTi+rStuNHrhibk/vE/ivZ8xyaMWBi2/m2eIaV9zFMlx1YKGK/W0mMhlATSlDm5MW
         KYeWZCTOcRS+aEQSeXBWI8+0IwbK+sZayti6+HTHNlFE8RrbwQBfyRNO9xGjfhJlaSK8
         ZD+EQsPOZc4U8zRsh64RDMQcDe0WYUAwKTQkoAxQiu37ayYkMaE9JmxBAYULAAGmWxyY
         1RfA==
X-Gm-Message-State: AOJu0Yx+Wt9YSo/hTHVzekXe7xQdDF7e/yWoIawZNoa0JPVPNNQKvND1
	hBEU8WmV+qEP/3OlIHi2psJ6RDHywuzsvXUElj4XOWjotP9YneDO6qj0CaO4NXQ=
X-Google-Smtp-Source: AGHT+IEjjF/NWVvc/w1eE/GT3HKKvjtViNJcmuej3k1f+T+Ega7cvLKUL+jfMG0VQItoEYBsT4hWJQ==
X-Received: by 2002:a05:6602:25d7:b0:7eb:66a5:d1c with SMTP id ca18e2360f4ac-7f39c44f029mr1196270239f.0.1719430421243;
        Wed, 26 Jun 2024 12:33:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9f733b293sm2103171173.40.2024.06.26.12.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 12:33:40 -0700 (PDT)
Message-ID: <524e2d98-f75f-4004-bd3b-39b64864bc3c@linuxfoundation.org>
Date: Wed, 26 Jun 2024 13:33:40 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/capabilities: Fix possible file leak in
 copy_fromat_to
To: Ma Ke <make24@iscas.ac.cn>, shuah@kernel.org, usama.anjum@collabora.com,
 amer.shanawany@gmail.com, swarupkotikalapudi@gmail.com, kees@kernel.org,
 luto@kernel.org, akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240626072024.2816986-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240626072024.2816986-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/24 01:20, Ma Ke wrote:
> The open() function returns -1 on error. openat() and open() initialize
> 'from' and 'to', and only 'from' validated with 'if' statement. If the
> initialization of variable 'to' fails, we should better check the value
> of 'to' and close 'from' to avoid possible file leak.
> 
> Fixes: 32ae976ed3b5 ("selftests/capabilities: Add tests for capability evolution")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Found this error through static analysis.

Please add this line to change adding details about the tool you used
to find this problem.

> ---
>   tools/testing/selftests/capabilities/test_execve.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
> index 47bad7ddc5bc..de187eff177d 100644
> --- a/tools/testing/selftests/capabilities/test_execve.c
> +++ b/tools/testing/selftests/capabilities/test_execve.c
> @@ -149,6 +149,10 @@ static void copy_fromat_to(int fromfd, const char *fromname, const char *toname)
>   		ksft_exit_fail_msg("open copy source - %s\n", strerror(errno));
>   
>   	int to = open(toname, O_CREAT | O_WRONLY | O_EXCL, 0700);
> +	if (to == -1) {

Changing this check to < instead of checking for just -1 can catch
other error returns.

> +		close(from);
> +		ksft_exit_fail_msg("open copy destination - %s\n", strerror(errno));
> +	}
>   
>   	while (true) {
>   		char buf[4096];

thanks,
-- Shuah


