Return-Path: <linux-kselftest+bounces-18986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD34598F9D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 00:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700541F212A0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 22:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E421CC159;
	Thu,  3 Oct 2024 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WmixGB2i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89172148316
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994382; cv=none; b=SjzkukMvnRQWyUBbGrPBeWNeFUDdeSS8DmRrP0+ajScZaevjqIKRaKq3L3ycPdBVFPp6JMpgC31yX5+ybB92xLatrmXcBuDTCJDK+qkEgmY3sXAIoxkBGBt9urQtCuSZ7JWAph8qyb86m3UYecOaNLPcFOsFsqFlt9nzE2nACtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994382; c=relaxed/simple;
	bh=xPOeaIqzyy399mWp3j1JLABvwZIVnneJOdO8eGepAoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaBtm9IwvqECB3OA3afEmS0hZ7Ua+QtAkgfr4pz/fJ1kPfclcCWDvEH7TszT9OPdlEtUbdM4JHBcIQDHhCxl9a6nhyLoxTvZpuZVcoGigvIJBNXwd07QHkW5BogAUsrbqrzsNmS/++qBnvhUA2OOaWys0ItyvrKDDblU+zWaMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WmixGB2i; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82ce1cd2026so59505039f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727994379; x=1728599179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tT0L0c+7PU2Ej+uTg2dcOIbX/VnJHQAzBR3GEEYX4uI=;
        b=WmixGB2ibT9Gbe4NJ4Mh056u31JV9uX7lNQdncgmJFtUkngMwmjE51GZUbwoiLvDxM
         fzbC+uuS/2ROZqMTuHI3w4hJiqkqATd4eq5r330JF54VURCCYeqeZwCPF0ohWuwuGR3p
         3ZY9i7Ot9wyLjxuKRTmobYH91Vx/MHY/vntsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994379; x=1728599179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tT0L0c+7PU2Ej+uTg2dcOIbX/VnJHQAzBR3GEEYX4uI=;
        b=qJJm7F54003bo1blltNbMxXpqnFi8JE674fjUdir9Nxsci78QWSXDYrneZBfG4MsCI
         zMDCG1nTKj+JzcSM0ZhatMhc/qYAGU68tdySX3+Jmq4awz32Y2fDqeFqlIJGLXuPPWRU
         e9rSYrJFzyVCSDt9dAq7zuX775yNBpbISC+EpVCEj0TduMz4ZwYu6ISa6oubLaJqHy95
         UQI5Ne9Rf29drCR1uQuS3qwNe87wHHJ+5EJNh+flDsJ9Nvgd/3WUaC9GQ6nLzkQls8Uq
         T10fB7SCInrAcTfCNkfIvidxp8JFOqhYP18qDlT8IOiOgMqE0z9qwdt9qI5qqggifq4P
         L6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFKRVhqndjcCo/syMqhUcebxKeaxfHcZGgU9TF2J4Cwu194ejSlcMI1UAGXIxYNC6brYTOnUMPcLiF7z0mA04=@vger.kernel.org
X-Gm-Message-State: AOJu0YymU1uG3mHJanNS1idVBGsB6YYQarxhezNuUmRB38NgOwawGKfv
	Uhv61HrJO2l2D6xecIGdV18fmk4hyYGDO+bfbde5lCeO4g8yI6SoY2duPSIt/Ns=
X-Google-Smtp-Source: AGHT+IHcCX7rPbxDB40pLseyRGGR7wxZ7SBLlcOt78NrgLauwTEpR5XalH0BunvR9FDE1sw+XYladw==
X-Received: by 2002:a05:6e02:1a21:b0:3a0:933a:2a0a with SMTP id e9e14a558f8ab-3a375999a8bmr5235935ab.7.1727994379669;
        Thu, 03 Oct 2024 15:26:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db559b186bsm467837173.81.2024.10.03.15.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:26:19 -0700 (PDT)
Message-ID: <62b01355-9d9e-4f17-85ab-2c7d57978f57@linuxfoundation.org>
Date: Thu, 3 Oct 2024 16:26:18 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vdso: Add linux/sched.h to fix CLONE_NEWTIME
 build error
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 SurajSonawane2415 <surajsonawane0215@gmail.com>,
 Yu Liao <liaoyu15@huawei.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241002152849.111841-1-surajsonawane0215@gmail.com>
 <543d4b19-e530-45e3-876c-522101f9a5e6@linuxfoundation.org>
 <Zv3Oaf4gMFyIFrV6@zx2c4.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Zv3Oaf4gMFyIFrV6@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 16:51, Jason A. Donenfeld wrote:
> Wasn't this already submitted and commented on?
> 
> https://lore.kernel.org/all/20240919111841.20226-1-liaoyu15@huawei.com/

Thank you Jason. Yes we reviewed this - I asked Yu Liao to send
me v2 since the define is coming in from pthread.h indirectly.

Suraj, Thank for finding and fixing the problem. However Yu Liao sent
in patch for this before you did. We will take that patch.

thanks,
-- Shuah

