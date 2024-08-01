Return-Path: <linux-kselftest+bounces-14668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC3945173
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 19:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03A3B2373C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628B1B4C39;
	Thu,  1 Aug 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IJGaUuyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C461B4C33
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Aug 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533257; cv=none; b=sppndi0aVRGAUUAyT89R6ATzxBUO0k0Fvh3010YxGrxOWwq2FpIE3RYW9SPJWHCMMxHComTNVTOQxi9j5+BfUNalF7TTsxOyeY8QMD7szqIofjjysp38+ghjJ5sns8QpKqusazXQvRyZXZT568Vt/3yc6ieD7eQucsdHqnFyRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533257; c=relaxed/simple;
	bh=bId7gP/loV8FGzON4JBMqgbZPdmQa1LIMF2T+0984KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYF05nOtS/D3BMyAZOdTDElY9hq2wM1r9TOM/xOmXzkPyCPkKKSFP/8alTcboZL8DWvZE1WnHev9nZJc58XNnwG/FufPozXGHjuRXOAGpHINdOdSFymx6ULr3jIWf0aGoEZEynBbvRYO7NvZYqfXsvceEyLk/1BKGVIm1abhlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IJGaUuyZ; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-398041b6e3dso2409865ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2024 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722533255; x=1723138055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvjXd9+buzfO11kaj0Ak+01IPu1cm6eWry4DAzKlnvU=;
        b=IJGaUuyZd2rqLFTKOcA2lbAAHSfOhEXPScvVhScQLDXemUhVtCzXXFekitjZvVE4pA
         vWn+W+jgcX7biqSmj0ighn79jZmHizgF7WdF77jUNjjLfUyc39+vx2nwyMdOOf8hA1HJ
         4V8dKlemAGu3fPw9xaR6JwaA3WL2QTq90d3uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722533255; x=1723138055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvjXd9+buzfO11kaj0Ak+01IPu1cm6eWry4DAzKlnvU=;
        b=Mj/YNG5x78CIH5P8x8hNPFx3vtFKpJ7ilU00V7WUfJjYHgI1q3FxxkiG+r0yN9J+av
         EqgCdsODWbgE59K3vUKT5LXkAauAUIKDXWakcwlfCmgPLv84VpEv13I1xOhYvI3FbAzp
         uN4wFLnnWWEYKae0gVRs5X8W8EBw9Jlx4zI26MlN5wNnllUupeyuV5EVVfsDEqmsCYTL
         cQQ34Jd51qE6eF9Xjoth2XnZ1mOmIZ+9tAauD0BDyMrr7vfFuKl2GcWPURcP/JH/VTuo
         WIgucCbN86aY4wyDA1zNAjVNzWX6B6zkklSJsHvGsdACw/y2PScG30GhjyRCMXJ/tQBO
         x8MA==
X-Forwarded-Encrypted: i=1; AJvYcCVRD9oHMiAAWpFtsO5MXKBNMe/ZvCD/gi2GLQxmSozdFNhLeRyHG/c4b7g2bhp62Hp/LyymOo/ZVubu4R4JvKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6SmQrTxEPWxRoUsK8ZAUvEhvySmemv+eBmKre/fcKFgfqKTF
	zF4/rig9/Xpvsik73Brf4aRklm3H9L2Yw4JKNNpSitTh+25zXrhsI4ucQECvOl4=
X-Google-Smtp-Source: AGHT+IGUyTv6tUwJDPzdWwPYOqHK6HoT9ZZPInrajbxk2JZzM0qb5kO4EbasMUvOyEOAZf5vkTAOww==
X-Received: by 2002:a05:6602:4613:b0:81f:86e1:5a84 with SMTP id ca18e2360f4ac-81fd43981demr71759239f.2.1722533254768;
        Thu, 01 Aug 2024 10:27:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a3e3casm20125173.147.2024.08.01.10.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:27:34 -0700 (PDT)
Message-ID: <2e1509f5-2a10-4876-8619-6a6b9c29d269@linuxfoundation.org>
Date: Thu, 1 Aug 2024 11:27:33 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: openat2: don't print total number of tests
 and then skip
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731133951.404933-1-usama.anjum@collabora.com>
 <c1414d9d-61b1-4f92-bc8a-333679362283@linuxfoundation.org>
 <d30aa38c-5dbd-4c18-b20f-a6eb9e9e722b@collabora.com>
 <f560819b-3a3c-4999-ad63-422ca31e9b08@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f560819b-3a3c-4999-ad63-422ca31e9b08@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/24 10:27, Shuah Khan wrote:
> On 8/1/24 02:42, Muhammad Usama Anjum wrote:
>> On 7/31/24 9:57 PM, Shuah Khan wrote:
>>> On 7/31/24 07:39, Muhammad Usama Anjum wrote:
>>>> Don't print that 88 sub-tests are going to be executed, but then skip.
>>>> This is against TAP compliance. Instead check pre-requisites first
>>>> before printing total number of tests.
>>>
>>> Does TAP clearly mention this?
>> Yes from https://testanything.org/tap-version-13-specification.html
>>
>> Skipping everything
>> This listing shows that the entire listing is a skip. No tests were run.
>>
>> TAP version 13
>> 1..0 # skip because English-to-French translator isn't installed
> 

One more thing on TAP compliance - we don't strive to be TAP compliant
as it doesn't meet our special needs.

It is important to keep the how many tests could be run to improve testing
coverage.

Refer to: https://www.kernel.org/doc/html/latest/dev-tools/ktap.html

"The Linux Kernel largely uses TAP output for test results. However, Kernel
testing frameworks have special needs for test results which don’t align with
the original TAP specification. Thus, a “Kernel TAP” (KTAP) format is specified
to extend and alter TAP to support these use-cases. This specification describes
the generally accepted format of KTAP as it is currently used in the kernel."

I appreciate the effort you are putting into improving the reports. I request
that you refer to the above document and also keep in mind what would help us
improve our testing over focusing just on reports and compliance.

thanks,
-- Shuah

