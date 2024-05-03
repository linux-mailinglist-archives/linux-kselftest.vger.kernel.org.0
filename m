Return-Path: <linux-kselftest+bounces-9429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5126B8BB462
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC306285CBD
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC65158A3F;
	Fri,  3 May 2024 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PDfg3uv+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13275158219
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714766105; cv=none; b=nyCuZ82CByySmBOxL7Xs+Gz6JV6WCOQhb6acHj2wncdNkyXDOQ3sDaYPJTpoxBiz6WJpdM6KGxFJXAIU88wsGUEzlC5KU9K8kMr2UOZW1MdBAjcUMGXGQ+TuB0A7shvyQTLRiOr3XvGuTYL7f0C2kQKv84wWuoVbvghcQEaqRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714766105; c=relaxed/simple;
	bh=H+O3hAtZlwC5F0x+rCtibViAkb8br0MyxnKFwP8yITs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPSUbROLReLivZ9SD+c6S+QD5tzkatReNTlcAzIWdEXMrGaWT8S6M1x+Io6+B+fqFy7pMaur685Focrf7Pg5gIBYugxVdYpOMrNTA8X+WlFlpVy/OmYVK8aAjIi/Hk9gsgvd8keaCfAkBduKlc0P1K310WjXu9B6iOZLinckWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PDfg3uv+; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6b362115eso470839f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 12:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714766102; x=1715370902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVDV1OeG9hQ/qmATCNcC1pLFdhB98ACZJusaLHASqpk=;
        b=PDfg3uv+K1U261iLrHrxJoV1+BleoujsesJ+cSZarmag8aMArfecMRpz9t0Ssh9DMa
         4ujVDlixbpB21PYUk+a4pGebCe6t6mGFxuUxB6SUwELkENLxVdCHmHxlbK3cchiftomh
         t6dJLfADDYfSHkMOrK50igdhEDQeXMCbmW3f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714766102; x=1715370902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVDV1OeG9hQ/qmATCNcC1pLFdhB98ACZJusaLHASqpk=;
        b=VlUl1+kt5pPIdm9Q2SmNBQSq896bj6fCQ+qvRr00cX+p7/dAKk9HVMaxlKDABYR9UW
         cJvftJfdq1/mkyFLGOubnoq5OY+mz/IcC4QfgnVffFQfJYvXD/v63s7npItCmEXipw+K
         r/3ZT/ikn5jfoOuypzT8vd+TVyXO4GTJN/OOG8d7i3bPQL85QbaYCnToMKoAhPd01cK/
         3Y/NVoGzmeMk2CQfTIy90o5QzACDGn9IebA4hCoV8wDlUF3A6b9JWrilcKopn2akCwWK
         fqoU0Pr/wBhcdqDuCEpk6cZQwArMIXS04PkF9+8246DF+g0oLhanZEU6J9binRjkg8W0
         hL9A==
X-Forwarded-Encrypted: i=1; AJvYcCWapklQyZpK9BuLOOFOhNQXZramTT786x1Y6WhRMp/TWJv6NK2MxBxwCydmvMM8/5+vD3GL89Oug9zL1pXfxyC8U0/2GaTpIal+kJ/emby8
X-Gm-Message-State: AOJu0Yx1KSdc7YH1KpPrsN4yAwhZMPOajX+PthGTcWpBoeauHUlo5wx2
	c5P3mCsaz4Lc/DxOjkcyvEfn+M6ftNG8Vo/wfhz3b+ILuKuJkScxPrIdeuuPDyM=
X-Google-Smtp-Source: AGHT+IEDvSK7zLWibDn57CFEVCFTU9+3wameuwSnNxEOPxolDZ6i9b9QnwmRipUUufkKlsJMbAAXSQ==
X-Received: by 2002:a05:6e02:219c:b0:36b:15e0:de18 with SMTP id j28-20020a056e02219c00b0036b15e0de18mr4223000ila.0.1714766102018;
        Fri, 03 May 2024 12:55:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id w8-20020a056e021a6800b0036c0d4b720asm820586ilv.74.2024.05.03.12.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:55:01 -0700 (PDT)
Message-ID: <3beb08a6-0be7-4305-9ac5-2ccc9e6d02c5@linuxfoundation.org>
Date: Fri, 3 May 2024 13:55:00 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: default to host arch for LLVM builds
To: Valentin Obst <kernel@valentinobst.de>, jhubbard@nvidia.com
Cc: anders.roxell@linaro.org, bpoirier@nvidia.com, broonie@kernel.org,
 guillaume.tucker@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mpdesouza@suse.com, nathan@kernel.org,
 sashal@kernel.org, shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <6d398f1d-6882-40fb-8ced-7fe6bee2aee7@nvidia.com>
 <20240428120806.19275-1-kernel@valentinobst.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240428120806.19275-1-kernel@valentinobst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/24 06:08, Valentin Obst wrote:
>>> Align the behavior for gcc and clang builds by interpreting unset
>>> `ARCH` and `CROSS_COMPILE` variables in `LLVM` builds as a sign that the
>>> user wants to build for the host architecture.
>>>
>>> This patch preserves the properties that setting the `ARCH` variable to an
>>> unknown value will trigger an error that complains about insufficient
>>> information, and that a set `CROSS_COMPILE` variable will override the
>>> target triple that is determined based on presence/absence of `ARCH`.
>>>
>>> When compiling with clang, i.e., `LLVM` is set, an unset `ARCH` variable in
>>> combination with an unset `CROSS_COMPILE` variable, i.e., compiling for
>>> the host architecture, leads to compilation failures since `lib.mk` can
>>> not determine the clang target triple. In this case, the following error
>>> message is displayed for each subsystem that does not set `ARCH` in its
>>> own Makefile before including `lib.mk` (lines wrapped at 75 chrs):
>>>
>>>     make[1]: Entering directory '/mnt/build/linux/tools/testing/selftests/
>>>      sysctl'
>>>     ../lib.mk:33: *** Specify CROSS_COMPILE or add '--target=' option to
>>>      lib.mk.  Stop.
>>>     make[1]: Leaving directory '/mnt/build/linux/tools/testing/selftests/
>>>      sysctl'
>>
>> Thanks for fixing this.
>>
>> And yes, the selftests "normal" (non-cross-compile) build is *broken*
>> right now, for clang. I didn't realize from the patch title that this is
>> actually a significant fix. Maybe we should change the subject line (patch
>> title) to something like:
>>
>>      [PATCH] selftests: fix the clang build: default to host arch for LLVM builds
> 
> Yes, I agree that the title should contain the word 'fix' somewhere. For
> me its okay if maintainers reword the title when applying the patch,
> alternatively I can send a v2. (Is it still a v2 if I change the title, or
> rather a new patch?).
> 
> Any thoughts on whether this also needs a 'Cc stable'? Its not quite
> clear to me if this fix meets the requirements. As above, no objections if
> maintainers should decide to add it.
> 
>>
>> ?
>>
>> Just a thought. The "Fixes:" tag covers it already, I realize.
>>
>> Anyway, this looks correct, and fixes that aspect of the build for me, so
>> either way, please feel free to add:
>>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> 

Thanks for the patch. Applied to linux-kselftest next for Linux 6.10-rc1

thanks,
-- Shuah


