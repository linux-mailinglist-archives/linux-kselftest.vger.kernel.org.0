Return-Path: <linux-kselftest+bounces-14995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82BB94B2DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 00:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4241C209AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 22:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51CC1514F8;
	Wed,  7 Aug 2024 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bjAIxSyX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6B146599
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Aug 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068584; cv=none; b=O5CjJJa39v0Zl8fzL/U2VyZxu9W83eo9O4SZZGmtzCXQn7mv/BHivKchP9aA264daURJZUxAqbHAOxk6rbMlKGBiINLjy6GZ6By9dRKFzNcNi3sqW7HYyETsSyhg6Ntpnsj6U9HlsF7SpOykRT9B9f5P8hEI+nsmNNb5jFSJ9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068584; c=relaxed/simple;
	bh=a1jn30+zr5YPPYyEso2pGd6m1pmN4PsGzGLycJHRVv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHoITyMUfYhFVrYjEYS0vfcs3LPZOaA1Is318cpCSdb5TqVQgbBqWUYfaDdXQgo8BSP2uBsHRrB2857lORknwaLS8iK69/ZnGtptobHptx2++YjtW5eXoy1MvYPu9cIC0KJRUYTE22rgWyqs1i82PKMO3YsMxd/EXicuBDQzGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bjAIxSyX; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8223c72bfcfso482639f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Aug 2024 15:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723068582; x=1723673382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFQTF2qes7rLwWDtDPYNEGJ3zLf1qCnO6NbUYmp12hw=;
        b=bjAIxSyXS69W9/IgiUkWmqWYL8ukx7gaRFN7HxN9FtPYIe+GZSQ2YS3OQc1Tvj+HzK
         VpR5spJ5M+WflttxVdRuq875yMZcQ2Hr7AFQ3i1j6LY8CKYMUastFwru2UY5T0Y4aKdo
         ss1PlNGthDVFlWxMf9+Zf9Pdq9bN6gToJ0cv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723068582; x=1723673382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFQTF2qes7rLwWDtDPYNEGJ3zLf1qCnO6NbUYmp12hw=;
        b=Qeln4Ee16hOriwcwTPIjxoF1PmXg1c2bej7/36Thtimb0qkZNZ2SKHube0eGPJ9vAl
         iwpjoSkiGRmpwN2ZZj82gtO5clpK1q7eBtZT7l8NFobf+muwWps9geUhUg3ozUaYN0Xr
         Rhtm7CvK8U2UMo/UxoBRn7qJaxvWqDS8nv8+9dr8r0VceFyCkLZ14aUzG5LV0dJcclLm
         hXeSqfqJaE8oP/ji5XggAoJNiVLud6xh4zvN/pJuC0Y9UQbIRb4o0vUx5yG9gbsz7i9f
         UC1725LRI65/2Z3nQOB8kTOH2ySSzptxJ7gvREwHGbH2dJkAwJQssK3MRiTBWbG/9xVB
         G8dA==
X-Forwarded-Encrypted: i=1; AJvYcCW45g5yO87RpfXP347fx1NvGRB/toi6+ro/2k6kSVhZMIsfpcZL2miOcX8zg4XfS5A2mXbo5mosTs+9wz5aPIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKt05U1wLEfxCQ2Ovg0yW0vZkQPk9hedLpRxW1YqTCtckXQDsR
	heOug74c4LJkmg9fqyR9YgaV+qCYBuLp7iwVKZZaCjT2CyVUP9Z8ukpr+6U2cmU=
X-Google-Smtp-Source: AGHT+IGPZD++Q5SqVElCF4N3hdjTRe/prDOceMSWZpgjkcEzrguk30YA/HWodlJQQVLmZN9Uaw1lWQ==
X-Received: by 2002:a5e:834b:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-82253829aafmr9702139f.2.1723068582147;
        Wed, 07 Aug 2024 15:09:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d69c4d88sm2922264173.77.2024.08.07.15.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 15:09:41 -0700 (PDT)
Message-ID: <dc3b8c77-8051-4232-9feb-753ea0b44f4f@linuxfoundation.org>
Date: Wed, 7 Aug 2024 16:09:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] tools/nolibc: improve LLVM/clang support
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 15:51, Thomas Weißschuh wrote:
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
> Changes in v2:
> - Add support for all architectures
>    - powerpc: "selftests/nolibc: don't use libgcc when building with clang"
>    - mips: "tools/nolibc: mips: load current function to $t9"
>    - s390: "selftests/nolibc: use correct clang target for s390/powerz"
> - Expand commit messages
> - Use __nolibc_ prefix for custom macros
> - Link to v1: https://lore.kernel.org/r/20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net
> 
> ---
> Thomas Weißschuh (15):
>        tools/nolibc: arm: use clang-compatible asm syntax
>        tools/nolibc: mips: load current function to $t9
>        tools/nolibc: powerpc: limit stack-protector workaround to GCC
>        tools/nolibc: compiler: introduce __nolibc_has_attribute()
>        tools/nolibc: move entrypoint specifics to compiler.h
>        tools/nolibc: compiler: use attribute((naked)) if available
>        selftests/nolibc: report failure if no testcase passed
>        selftests/nolibc: avoid passing NULL to printf("%s")
>        selftests/nolibc: determine $(srctree) first
>        selftests/nolibc: add support for LLVM= parameter
>        selftests/nolibc: add cc-option compatible with clang cross builds
>        selftests/nolibc: run-tests.sh: avoid overwriting CFLAGS_EXTRA
>        selftests/nolibc: don't use libgcc when building with clang
>        selftests/nolibc: use correct clang target for s390/powerz
>        selftests/nolibc: run-tests.sh: allow building through LLVM
> 
>   tools/include/nolibc/arch-aarch64.h          |  4 +--
>   tools/include/nolibc/arch-arm.h              |  8 +++---
>   tools/include/nolibc/arch-i386.h             |  4 +--
>   tools/include/nolibc/arch-loongarch.h        |  4 +--
>   tools/include/nolibc/arch-mips.h             |  8 ++++--
>   tools/include/nolibc/arch-powerpc.h          |  6 ++--
>   tools/include/nolibc/arch-riscv.h            |  4 +--
>   tools/include/nolibc/arch-s390.h             |  4 +--
>   tools/include/nolibc/arch-x86_64.h           |  4 +--
>   tools/include/nolibc/compiler.h              | 24 +++++++++++-----
>   tools/testing/selftests/nolibc/Makefile      | 41 +++++++++++++++++++---------
>   tools/testing/selftests/nolibc/nolibc-test.c |  4 +--
>   tools/testing/selftests/nolibc/run-tests.sh  | 16 ++++++++---
>   13 files changed, 83 insertions(+), 48 deletions(-)
> ---
> base-commit: ae1f550efc11eaf1496c431d9c6e784cb49124c5
> change-id: 20240727-nolibc-llvm-3fad68590d4c
> 
> Best regards,

Looks good to me. For selftests patches:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



