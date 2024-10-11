Return-Path: <linux-kselftest+bounces-19570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F27599AEFE
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 01:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED071C20C3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 23:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3F1D049D;
	Fri, 11 Oct 2024 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cml+EH3Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2528EB
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687646; cv=none; b=J4eQijQ8/MQj0pMLmlSQkFoI3MjkmVJ0pw9jMIr3JoGqGgNDH4Ija6DZcG4pWkRopu7KLtbglAZ/vX3vRlaaYwbSWg2S8BYQgXjW4xJJiugXWb1AQmXNKYGn+g2clAi0Ke+VBoCtGwctWZl09B3mR4y90cJQmngJDgJmsgKSye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687646; c=relaxed/simple;
	bh=X3bWSeZTnOc7MAGzLkXIcsbWyQNpl5VHwrJcbNUK1gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tL4YeEdoVdFgV7VfG3o07bF9yPxZz++lY84z3M2A+TEhnk/J9yIKHNDIYLZRHkj+nvP6koVF8PsmjPiJZ8E+clLu78BdMY2Of0MyxHMDF66TjNZ0CX3yp8bxXoH2gjy0DvFxTefBbd5edPE7WxmBrUhAFv2Mi3UsdUVM1EaLhb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cml+EH3Z; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3bd422b52so839305ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728687643; x=1729292443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5NifOOd36N6AdmfZ9L3pQ43h2cP6xrBPCX/Z1jtyYg=;
        b=Cml+EH3Zk7eIPftCEB2WfgOsmyGjVzE6bXegE7D8fLctRcvQhooAS1qbQXU2ywgalm
         Ju61zra7z15/YxyTRO1k1bWrHB9LCGUB17eaMG14zCOZVemKvWJrtDqt1nLRCNNWS5M9
         LqBKh+Q9nnXq2k5LlPjRG3e1D1vbWfFPbTJTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728687643; x=1729292443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5NifOOd36N6AdmfZ9L3pQ43h2cP6xrBPCX/Z1jtyYg=;
        b=RkA18BQ1k5wUn07ZjewQR9kAjYCEAOAB3BTGjzXWKAGjXsYgP1gctch44/nOQ9AByD
         WyCPcIOfzpayKa//ie64ytX0YLCCdQnzW7BAnAHAK1CsfSglH+atCGTQXuXF6FznC/Is
         3O4TsUuFHCInB5tUbQdOmj+qD+F1doIkqLkZYKqI5imMiF41EXDmLKtT3ZB8x/9Mroof
         6T7J5fbtyKmHTIbh+O863yuEplh36QMbfYIBiEQzI5xbzr3cc8TxUlbvPzCm5LxIPxP5
         x2MeiIIPxlNM/Dq4jD74mfQoIXY4bEYVFm1DrMpIw8z5WoWNKQR8xJ05wGX0QH/ooZQW
         4jWw==
X-Forwarded-Encrypted: i=1; AJvYcCUxDd/hK/gwSykuU5JHVnFNbMwMq7Jzp1umnfd8dx1aMThw849RbxgfO8ngopT8iQyRxG+Uk/bbXJFpH8DIc5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWR0sGqWAHLtgMNl8vMpA9GliGJ9CMVCkelmwHi8it4aCCJH9I
	aUvWjCNJr0vJx2mC2BBDdBJNpWNXDFCOTnZr8EMOjvSZNrfJsm8Xqb4l583EiW4=
X-Google-Smtp-Source: AGHT+IFEcyoXbqU+16RY6ik4nYc4ZIBFu6kUHHy/pTQc27WlEIC6PZiuhbH/pQpiplX19mTm6syTng==
X-Received: by 2002:a92:c241:0:b0:3a2:91f:497b with SMTP id e9e14a558f8ab-3a3b5fa76f0mr40556545ab.13.1728687643360;
        Fri, 11 Oct 2024 16:00:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdb3688sm9148835ab.28.2024.10.11.16.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 16:00:42 -0700 (PDT)
Message-ID: <87492b3f-84d1-426f-ad71-7784a1c1dfc3@linuxfoundation.org>
Date: Fri, 11 Oct 2024 17:00:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: Remove unneeded semicolon
To: Chen Ni <nichen@iscas.ac.cn>, jstultz@google.com, tglx@linutronix.de,
 sboyd@kernel.org, anna-maria@linutronix.de, frederic@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241010073707.4038081-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241010073707.4038081-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 01:37, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   tools/testing/selftests/timers/set-timer-lat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
> index 5365e9ae61c3..7a1a2382538c 100644
> --- a/tools/testing/selftests/timers/set-timer-lat.c
> +++ b/tools/testing/selftests/timers/set-timer-lat.c
> @@ -79,7 +79,7 @@ char *clockstring(int clockid)
>   		return "CLOCK_BOOTTIME_ALARM";
>   	case CLOCK_TAI:
>   		return "CLOCK_TAI";
> -	};
> +	}
>   	return "UNKNOWN_CLOCKID";
>   }
>   

Looks good to me.

John, I will apply this for next of you are okay with it.

Also I noticed clockstring() is defined in multiple tests.
Any thoughts on removing the duplicates and adding it to
a header file? This will add a dependency on another source
file, but might be good to remove the duplicate code.

thanks,
-- Shuah

