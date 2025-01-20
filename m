Return-Path: <linux-kselftest+bounces-24815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F771A17503
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 00:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395A31887BCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 23:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960D51E9900;
	Mon, 20 Jan 2025 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CEG65xJO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400D1AF0DC
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737415609; cv=none; b=Gc9sDTt+I+T6smEBbx9J9SspLUN5wh1AC4wmvHOP+pyrRPBd1w8T4VAbNQzSyqIrS7ZpfliJ6/Z5o23thGSq1eEPnmLCCff5vajdsznUd8U+ri2VNi7sSQWhtIKXxHfu87rsFjtKznTtpyAQaTH2DfmpWxdPagnT2Afo8PsdSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737415609; c=relaxed/simple;
	bh=Hcaq9u8s1XWRc5ZCbUqQ+mTqcKxdwExluRO8x3CEk/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ixhz/hWroWdnLcmroWbG/Ldxquf20aZD6Eno4Sjd/cITsH9bdEUORpFIKXksSK/yb7v4qzHZuYKTA2pKyonnJYxxwLXLMd5Dt4Pn8z6paOm5I4x2qDd92DvkaGVMAoe+ECifeaBKsrFIFOd6tu7BmDGmQCBS/O0+yc1WWjhiJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CEG65xJO; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso15445805ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 15:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737415606; x=1738020406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfEwrjbpPGVxQCdGBsnlU5Jkomq3SsWe4/WSCzZTEWQ=;
        b=CEG65xJOFWOiGI7V58nNdcOSI9hc6IQamot2SOjniJYfwXECfVdw16iRGGS7TPvAP4
         QpiD8pxDMKO/mK9u5vLl3mUJ+CAM3+Vmn5L4wnlAkpPiaFdUf2WELHR5yM8UioLSfBWC
         KwWEbcT1eDjhME4F5yuWP6qhoXnMNHxC02nm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737415606; x=1738020406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfEwrjbpPGVxQCdGBsnlU5Jkomq3SsWe4/WSCzZTEWQ=;
        b=rXATGT59EYA2yxKcDEiaAuIVQ9cgd5zshublbyTWBm5GJTPoNa5V+uWy0Uo6iltAOW
         NZtwPvst5AO4dMSxWuj4NB3plCWhmjerdTE1KKAWjMNblSQGCCJzNISJNa/XfkvZ2KBX
         Wbw62vg4Xt27MHrZ3Ei5lDYKG4jChia4N74CRTn/ABy+Sy8ugSJ1u19PqSRdMPQ+bmnC
         w2mYNbTpLJiqp8f9NFCncf77FziKHtZ4mDX33pZwpT0uGuRHAR13TzMqs2KQQusUp9VW
         STljvhWC4KSBaSy5gsG3KX7MerK4xv1Aw1qmnsxBnfzZnRBLB0h/XDV+v7dFZfeEyARI
         EUrg==
X-Gm-Message-State: AOJu0YymUzt9PxGsj99nNRFqRB7Y3J90A9uOMABmdvf6bBLUdQ/B91Ay
	Orbs7W1gBevNppqZGkgtPXzygh8mcqxFUh9zKYOdcmVlnRqxymojsU7D/wMQfOU=
X-Gm-Gg: ASbGncvMvgFhUT9+FerOPQwZ/4+LCGM4VhHn5x6/JaZqiFddU52Rou6y71/bYCydZ+p
	+JPrEmvyFHAcwCi1rOWhHCBviVEqTcYfznNgB3UkT3A0ATd3kNC6GbmmqkIN6J+g1csD32cyGle
	eY/TGVqoB3akfjJo0ktTxZOI9FY70sS8B1D52FxFQ7wVfk+FmDT80M1Xw3xYkGHxzbd+M5tbaWB
	Xrrr1GpUvkn9L7jekQIrdO/Nd/AwZTPXqH7WyYLcplR18UODvvHmMcJhE1k7u+D6ErUV5rmhsYs
	c5RO
X-Google-Smtp-Source: AGHT+IFzDzkl+V1xTO1l9oqrsepTpbU6RPG2D8PTOu4TBqZeZnjZG6LnqfidgvHS8JTVD3vEUCXZwQ==
X-Received: by 2002:a05:6e02:2607:b0:3ce:8e89:90db with SMTP id e9e14a558f8ab-3cf7447b9c6mr109470875ab.14.1737415605816;
        Mon, 20 Jan 2025 15:26:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea7564940esm2854887173.92.2025.01.20.15.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 15:26:45 -0800 (PST)
Message-ID: <81bcfd10-e88c-455c-be6e-ae15d2ecf3f8@linuxfoundation.org>
Date: Mon, 20 Jan 2025 16:26:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/.gitignore include missing log file
To: Khaled Elnaggar <eng.khaled.elnaggar@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250116085929.313677-1-eng.khaled.elnaggar@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250116085929.313677-1-eng.khaled.elnaggar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/25 01:59, Khaled Elnaggar wrote:
> Add tpm2/AsyncTest.log to .gitignore
> 
> Signed-off-by: Khaled Elnaggar <eng.khaled.elnaggar@gmail.com>
> ---
> Hello
> 
> After running kselftests, AsyncTest.log file showed when running git status.
> I just added it.
> ---
>   tools/testing/selftests/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
> index cb24124ac5b9..87d532c08a3e 100644
> --- a/tools/testing/selftests/.gitignore
> +++ b/tools/testing/selftests/.gitignore
> @@ -4,6 +4,7 @@ gpiogpio-hammer
>   gpioinclude/
>   gpiolsgpio
>   kselftest_install/
> +tpm2/AsyncTest.log
>   tpm2/SpaceTest.log

Please move both tmp2 ones to gitignore under tpm2 test and send
me v2 patch.

thanks,
-- Shuah

