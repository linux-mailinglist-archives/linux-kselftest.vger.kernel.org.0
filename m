Return-Path: <linux-kselftest+bounces-12826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F9F919851
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 21:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029172864A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF9C1922D3;
	Wed, 26 Jun 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GkDPNE7U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC834157A5B
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430629; cv=none; b=ZzFrDeQWjWkVkFKIVFT7K22bz0mUCRQ+Buaa+oatgyvczid6fzL8htFwm7rr9gce5f+d8JHB+LBR9lxZeDbE8Kfp9l7nCTcJKmUhbwkQI/3FtZDXAQBc25GzRlLExFWON4Jm4gBw1/exXIKAqzlSdy5e8iyXFn4LOGbOR0Us00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430629; c=relaxed/simple;
	bh=kyH0xXB5H1Vg+c/9tiI8tskpqg7dAjXaDu1ITxLHJeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe4LnS6tz2fJCa+RD/OH/pd3Nkd0pcgvFXCU3rms5yWB+WwfoEQuxIFknmGqDdvVjyqgIwQ0GGiYTyoYXMKJcMvARHCVJRzx1D5K7MSWDBmuCsxFRZ42osTpSCA7iVE3/pjV44Aggu734wKhlQ5wj8vwEYTMN8RnwbcWTMKjx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GkDPNE7U; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3762c172d94so3078635ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719430627; x=1720035427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICvcBHP/KZCXzcYm8gtyDmBrp6ePeST6VE9B+ziPf54=;
        b=GkDPNE7UjpOr2wbrLvndSR2hsZ/vpHcFXxc1Wx5IhCtLNwWFZQSKCXbMvrNPaZLshS
         6QaaXZFijsJVBWWH5lUd38mxg5KeuEid56JhA9W826c1sHaqykG+TJUMD90jFPa7kFic
         xNef/Qls+0JAzkf0kKqcZ06E1lBTldcrYgvF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719430627; x=1720035427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICvcBHP/KZCXzcYm8gtyDmBrp6ePeST6VE9B+ziPf54=;
        b=PzwhzSAQRFXqSPDqDPcPuaIFpee9E4iKfVvKYt44Z0ViMdlrNBTDA35f/f256yI2sP
         +91XMzFOp/k+WeMt1svcxuaXHk7UFt7JbcZ/Fyk02TFS0WZNCw3/RsM7/Ve2EcEcELxx
         B6ncLLz6ZZVde6caJWH1i/Tu0/fCMzW3YQQBtJWORsobAr4UJvYhejCKokCpEbGAL55h
         G+pdSElBNNnxa9H7nLmLuMJLrAhPBx/BaHNb3l7kCW9RiJO+0CX0RW4onsnqXu4OBjNB
         6Ddq9lL+6j8NQXLCKxKBrfJutblnZsaxhHgOMLmF6UjQdW3F1JhwZbQ+ZAO9UfU7Ia5O
         pRhQ==
X-Gm-Message-State: AOJu0YwMogu40GbihfFQFlXX+ilF/xU7xbPWGQ48aOnCFVbs2NXPloGW
	AZGQ5KB+PVGw1+UGtCm2PhEu89bnjF2rLyE4EnVZNO4ovmFhd6LiT3GUQ/8/3j0=
X-Google-Smtp-Source: AGHT+IHiRCOVFS4E+cZepyniako41FE5gtIa0MJn5xH54rfOJ6VfGKk+9lRMtzUonfZZ76YfCjUCag==
X-Received: by 2002:a6b:4f0b:0:b0:7f3:cd61:32f5 with SMTP id ca18e2360f4ac-7f3cd613354mr315438739f.2.1719430627107;
        Wed, 26 Jun 2024 12:37:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f392028074sm282015339f.42.2024.06.26.12.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 12:37:06 -0700 (PDT)
Message-ID: <67828a44-9730-45fd-bc4e-73075cd3dc4e@linuxfoundation.org>
Date: Wed, 26 Jun 2024 13:37:06 -0600
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
 <524e2d98-f75f-4004-bd3b-39b64864bc3c@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <524e2d98-f75f-4004-bd3b-39b64864bc3c@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/24 13:33, Shuah Khan wrote:
> On 6/26/24 01:20, Ma Ke wrote:
>> The open() function returns -1 on error. openat() and open() initialize
>> 'from' and 'to', and only 'from' validated with 'if' statement. If the
>> initialization of variable 'to' fails, we should better check the value
>> of 'to' and close 'from' to avoid possible file leak.
>>
>> Fixes: 32ae976ed3b5 ("selftests/capabilities: Add tests for capability evolution")
>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>> ---
>> Found this error through static analysis.
> 
> Please add this line to change adding details about the tool you used
> to find this problem.
> 
>> ---
>>   tools/testing/selftests/capabilities/test_execve.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
>> index 47bad7ddc5bc..de187eff177d 100644
>> --- a/tools/testing/selftests/capabilities/test_execve.c
>> +++ b/tools/testing/selftests/capabilities/test_execve.c
>> @@ -149,6 +149,10 @@ static void copy_fromat_to(int fromfd, const char *fromname, const char *toname)
>>           ksft_exit_fail_msg("open copy source - %s\n", strerror(errno));
>>       int to = open(toname, O_CREAT | O_WRONLY | O_EXCL, 0700);
>> +    if (to == -1) {
> 
> Changing this check to < instead of checking for just -1 can catch
> other error returns.

While you are fining this, can you fix this as well:

  int from = openat(fromfd, fromname, O_RDONLY);
         if (from == -1)
                 ksft_exit_fail_msg("open copy source - %s\n", strerror(errno));

Same change to check for <

thanks,
-- Shuah




