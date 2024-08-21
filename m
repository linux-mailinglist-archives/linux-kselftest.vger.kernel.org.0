Return-Path: <linux-kselftest+bounces-15822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C7495952E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 08:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C051C2114C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 06:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956DF193419;
	Wed, 21 Aug 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZfcvXzTF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB4185B53
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223500; cv=none; b=I31rbLm0S9osaMsLQ4Wb2m11MxcdifFEimK1DOc5UDULFhm/p7wEz0p13A1CtQrpr14sGZECf6rZWh/y0X6pAysgpSTZye5moIrIaVLlLCfEWvSuoeD75EJ0lLgQcXFPj583LD85b7yR9TNhIS5QvqltKNM/KGS6Y4qkJ1B/lvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223500; c=relaxed/simple;
	bh=nGwwZKR0gRYMSEgmiBVAnzD1Pp9OdshUmU94NyLhtDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjTXJfNE12Ga2q99CRPRCf/AyuXO+Z+mErLp5jx2yUcDcUKq/kSPtu6O2ibY4Q+A3ZW0qQnxGpQ0eKMaC9pcrkPRDsTb0VPFNTHm1eTJjXhD+ZEdOp5Fv2hiFg8JA1JRRmX+ZBYKIl6DzCPaoZKpdK81KYf7jDH48ALEy7V02b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZfcvXzTF; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5e97b8adbso3688701eaf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 23:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724223498; x=1724828298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcwV5E+ok4Ru342pseyjnU3pRtPhY0hqDhnMEPHRasQ=;
        b=ZfcvXzTFGkfCFK3z9dez8lyTGhgj6gz23qAH/MPvW9twfEeLazeZR/rm0TzqV5X0Qw
         RLLVI8jpT0R/bzVz8ozILE3h5ImiAnJqnJhX45SkU6t6/Mnmp4LIIbkU2ToY6/wD0E6h
         vZAeLf37xClvrzr7RfF1GkofdnvaOl1eoU/zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724223498; x=1724828298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcwV5E+ok4Ru342pseyjnU3pRtPhY0hqDhnMEPHRasQ=;
        b=VCedRWyyaGJCLfkg2Q5CEmHdv3HVV7LiWnjphmqTKn1NDqae2nC71ly1Yp/QLosQZm
         fooyTCSrJmJvYxo6xka1akzB89Dml2M8TYyx49MA8X15AEBCK1IarhZf45kU39dmYRff
         Mr5lHbliw0b/94bnr81V06nisYw65i+KddWRSmoogW2b29rikTjMDZ5xQ756QpBmDpmY
         U/NaAyHjzybr14AYXWy9pAW6jbBVXaL8Jgctq8Dlvyx5pOvY1j7X3Kdm39lxlK77kgYF
         LhrTgipF5vxoU17iQoFP/3JzgtvF2o2Uv3DPEXHQy0imBnojU9Zivk08Zj9pNUg5K2a5
         nMwA==
X-Forwarded-Encrypted: i=1; AJvYcCXcWHMK49DBdDp87hbU2v4F3iUoDOL4dSDPffR4/KhI5q+5lLGDPYF1+A2qmMrnMQLHBiWrDRSumgtYccsnQ3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVYDSp5gG0bwn8esRqCsJ/Svfa75NYvcV7Xy1HtM+/oS0MkaX
	8AHfS5WyS3nYxkc+7eFGHyeqT8PwNMC27C589YyjfxFExutCRMuI0ZJvGI6UN94=
X-Google-Smtp-Source: AGHT+IGW3lZ+wVRaP439HYZTg2+EKRY2iSpAqSNAreo/hH4Ej36HDf8GGY057zCw2mgnCuU1Pw4OyQ==
X-Received: by 2002:a05:6358:531f:b0:1ad:95db:b6f2 with SMTP id e5c5f4694b2df-1b59f97b0e5mr218971355d.17.1724223497985;
        Tue, 20 Aug 2024 23:58:17 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6365afcsm10384733a12.87.2024.08.20.23.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 23:58:17 -0700 (PDT)
Message-ID: <f377d9c2-9bad-418e-b02a-9ef4f45d7b06@linuxfoundation.org>
Date: Wed, 21 Aug 2024 00:58:14 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Fix test to handle both old and new
 kernels
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuahkhan@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240515013620.098cb37a@rorschach.local.home>
 <20240614124322.36ad7652@rorschach.local.home>
 <20240819152002.3ecc8100@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240819152002.3ecc8100@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 13:20, Steven Rostedt wrote:
> On Fri, 14 Jun 2024 12:43:22 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Shuah,
>>
>> Can you take this through your tree?
> 
> Ping.
> 
> -- Steve
> 
>>
>> Thanks,
>>
>> -- Steve
>>
>>
>> On Wed, 15 May 2024 01:36:20 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>
>>> The function "scheduler_tick" was renamed to "sched_tick" and a selftest
>>> that used that function for testing function trace filtering used that
>>> function as part of the test.
>>>
>>> But the change causes it to fail when run on older kernels. As tests
>>> should not fail on older kernels, add a check to see which name is
>>> available before testing.
>>>
>>> Fixes: 86dd6c04ef9f2 ("sched/balancing: Rename scheduler_tick() => sched_tick()")
>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>


Sorry about the delay.

It is now applied to liniux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah

