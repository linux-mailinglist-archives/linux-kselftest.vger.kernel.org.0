Return-Path: <linux-kselftest+bounces-43764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E0BFCE68
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35553A978A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9C34FF44;
	Wed, 22 Oct 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SveC/HNh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCB34BA52
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146848; cv=none; b=VgYc7ktmv2XwvYfu3runDlApxox2Vk0RuuzSWSO/mZe9ITxRFa935Rvzk1Auz6aJainhW+/sS49ByXasE5HkamiNdN4mky7jypPvdlwl/255ul09klKiw6mg0moD1DRU4hnkDQLvfACvHhORxuMvg25p6lQMeHrrt0qzE+VpX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146848; c=relaxed/simple;
	bh=kNgL40BudYWuJuAsmdNvcDtZ0OwcI9RxNTByNbcVNcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lw94q/DMSzFncx2J9G+lbx0EAW43+qcQj5/RbGN8YtxEsbk0sMfFn3Hb6oAZVMLCtwHcd93PwIUBXZgfUvgNVcjjE3NR7h1rgsoTA9hsS9DdaH4H70sVC/GpzodX9o9z0oBLLOk7wkDrDc485TYvyKT/6F0LpVc1AkoQuS2h6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SveC/HNh; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430d06546d3so43144005ab.3
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761146845; x=1761751645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoALVDG9RnT7BAOdsnJMe54/Tt3GRwf2SgNb0DV4KSQ=;
        b=SveC/HNh42OvRzv5MOYg+5Yqc5Ot+StYw/SM1sELFEHMOk0qF9C2YTFPQdirFHlfZ7
         Xfxeww8wvM+Nzmll4DCkWDne4961S9L8z28yGMhdGunyDdl0nnytO+L4wfpPfSeIWgPQ
         bdiJuLjPp4PtQJJzSKqPX8VjpXby3TV6j3fKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146845; x=1761751645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoALVDG9RnT7BAOdsnJMe54/Tt3GRwf2SgNb0DV4KSQ=;
        b=hxpQ0gOy8WtnsIKfPFWEa7gW4Cd/uCFFsE+Qr4pOnrki7uYOhJYmKNE2+BoxrCM+Uj
         rrgZC907BpYmm2mHM8FeZOcLCzrt6h5azGW+wrgql346y/X9GGBOrIkqIfxkb+9vG4aH
         w02syM6xQxMmz5B0fvNwtbWDAqwYt3/rAoYgHQ9n12Xl47SjraDb2em/Ti3ILsi/BCtf
         RWT5BrxjuUGilrx8eyiT0k5Bd+g15kUxzp+8PaqpUZgo53eHGmXPU6rWBcI9rM2PD6tN
         121R3lQB3I2zHTUTg6Gp8+ESkvGqiPtaNi6sQAuRf3djrgEDNR8fX1aTwlM17uqcBg3o
         Q5qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaPYYtGv/6K/2M/u04f7fHFIOmMuuvqihHLZyL9+AnLTNLcLRhOwOS1OMH9V295HQ21cD//ddJeXyRJkOud14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eGD12WMRHOUA7LDuD3WoTFMGd+EsszA8+DPP6A4K10uH9I8j
	5F8uF7458T8UVPhiaLS0A3Oul4OtF4EYP1KKEPPtsQEA0bdYtfJxUeSCy20tRS5XCKo=
X-Gm-Gg: ASbGncsUiPOVDmfIzs0yQ1HkfKoqv5mbKTfdaQfpzJPIBXbTFBfwbyZRsbGXTJaZGmo
	pjq3mYUh21/XllwcEA7kCi6aVeRekL8nbh95aiXOMF04SPDmYna6Nj4jkYv7bEfJ0eLXS59brk/
	iyChQgTP7sJ3vZL/r+DoI6K3XIJdSNRjia6AzVsppSbJOUux1ez9ZEbqg0/MhJ07k8vtckn0KAC
	fUt7WkdBUkJ+uXXhhJRk1kEIblI5zux3BlQWsGgqv4QmibpXwQaj/64mkxmPVFu6enxB3s4Ypmy
	3/YHDrDgUc8J6jk8PM0UcuXnmCELj84GhhOCpm+M4BltbQ/uDZdCfcowRtvsJHgPHFnpFq4yd8l
	xiT4EgCvhiNzi0HVTe6dXNWHWOkB2f1en0cSIAFAfAWf2XWlgIn49iSFJYFo73D0vKvKgNn4KuJ
	02VU0hu6jGkj3t
X-Google-Smtp-Source: AGHT+IFHrNAgETUq7iHXWj4LaXPG7j1qD4lSrv4wnohCO6eo9eW67OevdQz1fzSz9sygsvW/JqehtA==
X-Received: by 2002:a05:6e02:3101:b0:431:d76b:d133 with SMTP id e9e14a558f8ab-431d76bd17cmr27048295ab.12.1761146845007;
        Wed, 22 Oct 2025 08:27:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a964a8a8sm5288976173.29.2025.10.22.08.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:27:24 -0700 (PDT)
Message-ID: <cb30af9e-c22b-485a-a83c-f395880cd799@linuxfoundation.org>
Date: Wed, 22 Oct 2025 09:27:23 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: cachestat: Fix warning on declaration under
 label
To: Dev Jain <dev.jain@arm.com>, Sidharth Seela <sidharthseela@gmail.com>,
 nphamcs@gmail.com, hannes@cmpxchg.org, nathan@kernel.org, shuah@kernel.org,
 morbo@google.com, justinstitt@google.com, nick.desaulniers+lkml@gmail.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 david.hunter.linux@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20250929115405.25695-2-sidharthseela@gmail.com>
 <486e0d6b-799e-4fec-9e6d-3ddfdd64418c@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <486e0d6b-799e-4fec-9e6d-3ddfdd64418c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/29/25 22:52, Dev Jain wrote:
> 
> On 29/09/25 5:24 pm, Sidharth Seela wrote:
>> Fix warning caused from declaration under a case label. The proper way
>> is to declare variable at the beginning of the function. The warning
>> came from running clang using LLVM=1; and is as follows:
>> -- 

Sidharth,

Make sure to not use "---" in your commit logs. Everything after
this line gets thrown away. I had to go fix it manually.

>> -test_cachestat.c:260:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
>>    260 |                 char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
>>        |
>>
>> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
>> ---
>>
> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> 
Applied to linux-kselftest fixes branch for next rc.

thanks,
-- Shuah

