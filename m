Return-Path: <linux-kselftest+bounces-14392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE24A93FE35
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 21:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65885B2114E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A2187851;
	Mon, 29 Jul 2024 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iY76AxuA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BB84D34
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281190; cv=none; b=OxOSxu9RaSBm3y1o1hKQhLTfioAiwe6cdeP85c5t2Sh6nJf7TgWyqOB/gsL1C7YVXAOyZf3B9afnGhb15Yp1NS8eH13lO7ET8IELT8BLhcNLIoHPFW0kvPf9rF0CxkYkbM0nxyp6MxzmaUlY+HxXqLbd7GyC9NKerxJhqRl5ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281190; c=relaxed/simple;
	bh=12r+qoVgIwNMujUj1Lw9nLCpW580cxRA8WuCewWiy8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaQQLzKTgfLTjxvsbjs0uO9dmOTaq99cx8ydF+1iGD+AcxxOqzu4TX1TtyEx27uf1/VtzXKReQNdP2V3ETs+DGvHKGApNzIrbjI5arL5wzLNEo+23NKpbyvL+Sc0kSqZT0zPWYF/JTC1Q7k2hoiawsbwYiuWVnwrZUwvqV5UiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iY76AxuA; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81f86cebca3so22452739f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722281187; x=1722885987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kwWLpKJa8JQmE+XMPSbBE95rM7lCL8UnHLXXsddUg0=;
        b=iY76AxuASfYwPjBb4cu2hEubkGwrSTBudFXsE55AviLcihah8C3TRs4syeBz2t/BCV
         NfoXZjeQbljOmTqi6Vn5RLbIVLMCebe52xJ3S13s9uVRx/axWRnTwqMLEMbnd0SMXhp2
         W8GQqpFVnwK4iYtaMMDXerM1xbWCvxp1gCQOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281187; x=1722885987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+kwWLpKJa8JQmE+XMPSbBE95rM7lCL8UnHLXXsddUg0=;
        b=wQRfb3DxmPUwpKk7f+eBpH/lT8ufi75WZ2h8/0TTw+dDLSacQLP3o6F3i6+Aifj0pe
         ptvbj44XwVCHMR8fdo5ZTOOEhsfcRAKpfzbq8rAA16ztzKNQp1zBZ2VC8jIoWTQtl4oa
         1RqAa3JFfpwjZJrVCjkBPKfyIjWK0PDZSocgd3BbO9UsqDHmylnd6JH36dAqdmREfRbe
         4p6OT9XqqjrK/0c52C3WzmzJnrAXuMACzIT4Hb7fbo3EuF37Y9VxO7kCikIKSenRmjoZ
         Jqv30Ux93DyGZhARtoFNtJDQi+KRAhSpFpBk0gZwE4vPvVD4GEOLr64759XgIJPcuzHs
         +8HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYe3QHO0mxSxe3F/LIT3Mv/7CDHQScFmnzPzBqobJIcDibwTfkboxaAaZ3UqI8zTWrjkEr7MT2EWg5OJStk8Krf4f9HL3wHL5LdcwFdfn5
X-Gm-Message-State: AOJu0YzIpD5SnsGuYaWf9Gg2yvZ27IpztpIsYLrJQMLcAcYwWf+A+g+T
	cZV8jSs0AQQP+iPgpQW9ABI1KhjAw+AQplC3zxL+b0JEuq0b+UpPBNdb110kaR8=
X-Google-Smtp-Source: AGHT+IH5qDpmLWMY5mYooQOyIzYHn29X3m+a786VYmBRROEY+94JBvmh76Ky2yQETad5sL8Ac8mbfQ==
X-Received: by 2002:a5e:c91a:0:b0:81f:922a:efdb with SMTP id ca18e2360f4ac-81f922af876mr527827439f.1.1722281187035;
        Mon, 29 Jul 2024 12:26:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d6cbfedsm308183539f.10.2024.07.29.12.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:26:26 -0700 (PDT)
Message-ID: <120ddb22-34c4-4d18-8238-306485680c5a@linuxfoundation.org>
Date: Mon, 29 Jul 2024 13:26:25 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] tools/nolibc: improve LLVM/clang support
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/24 04:09, Thomas Weißschuh wrote:
> The current support for LLVM and clang in nolibc and its testsuite is
> very limited.
> 
> * Various architectures plain do not compile
> * The user *has* to specify "-Os" otherwise the program crashes
> * Cross-compilation of the tests does not work
> * Using clang is not wired up in run-tests.sh
> 
> This series extends this support.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (12):
>        tools/nolibc: use clang-compatible asm syntax in arch-arm.h
>        tools/nolibc: limit powerpc stack-protector workaround to GCC
>        tools/nolibc: move entrypoint specifics to compiler.h
>        tools/nolibc: use attribute((naked)) if available
>        selftests/nolibc: report failure if no testcase passed
>        selftests/nolibc: avoid passing NULL to printf("%s")
>        selftests/nolibc: determine $(srctree) first
>        selftests/nolibc: setup objtree without Makefile.include
>        selftests/nolibc: add support for LLVM= parameter
>        selftests/nolibc: add cc-option compatible with clang cross builds
>        selftests/nolibc: run-tests.sh: avoid overwriting CFLAGS_EXTRA
>        selftests/nolibc: run-tests.sh: allow building through LLVM
> 

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

