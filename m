Return-Path: <linux-kselftest+bounces-45026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F577C3D854
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 22:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A373A5558
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 21:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787D2FBDFA;
	Thu,  6 Nov 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IRcWGWRx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D149A3074BE
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762465332; cv=none; b=fi5HsTSg1jWKYCDxv/EsNtCoTJwa6xHBWGVInYKJLo2/P7sND7NzQzdbtcs4Z88nHjDF6S4azLEQbHUQDP85ieetms7VkZpg/llU8BBnV6UJn4gqGHmf3zR3OITZB+YV+z2hJKyZ63h4ov+i3tkVMwIbj/WkP9k20E4YV+igqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762465332; c=relaxed/simple;
	bh=RRBP0RoZ6W/MmOWTTmOU5jvk86h+eUqx3w0BaX/UHfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpV62fgUwpY9UHbWcFJfO8A1vmw/xAjeWnGftnGPviAf82l0LLZ7ndDrfXueX5GfF9VaGnFO0geeaWy4PFscecJnhfBL7bhbxEAdhc6f+wtkeJs9cDeu7q3r7XwjBIZPqj/tDMMmzuLfX3msaUtwC1RbNAmwy7g1ObjJyeExep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IRcWGWRx; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c51f56f3fdso63839a34.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 13:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762465329; x=1763070129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmkEl3tfqhQ+7MkrwrxhdgH92T1+g0gCpE4b56GnA50=;
        b=IRcWGWRxPkeA/BuWZl5u56GylgH3g7G/K9KDIe3j9J6BYyNtZa4GJ188gHWW6cJ33J
         M56LnATLob7aVDrH1hmz4XeWim5pMue5iQ54ZBZq27koITzFSa9Cv6nFAgLytdGlzVXX
         UeneBiWqMorBIlbbmEsV8FZq76D6Jl9qPdSI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762465329; x=1763070129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmkEl3tfqhQ+7MkrwrxhdgH92T1+g0gCpE4b56GnA50=;
        b=NPcZUQE8wEoJOWZcUnkDTABQlIDURguTFW0KYnFxKtaxzmhArfufbbIqWohKE4qELY
         iHNdUYcJFw7jbYWFgUGlSMI7d2BDRSrJIfZqd3T2pVSvKhZ/Vzayu6Ge7m93TJPn6Fa0
         2qUalZ/mIWcgp3czyDw1/3t/fY73HXW9D6jHZZA2mPRVmb6e7CopGy5dSqhJXiB89Cjg
         7Oy6DI/itCvjYqfTTN7hrLP+ASEZW9uL226Igul4E0qm6v8LIZ2fHPRI/x/RRuo8RqqA
         05WG125le0QHZWwK7Au4M6rHQ1lpHqIKKLKolib5JzM/VYcQkTF+Pb68HRY3kujO9o8M
         PlhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkA/Ui/ySpf6SfFWZaN+Y+W5upFS0N4eczQ8tokacBml3GkY7NX9xNYr3r7S+hGtmy74qvX/n502e4Y4sdcfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMETC58delmSnUeE5AY2Vr7RFCud56ky+foa+pe6ugcliIqWFZ
	CGNqvj/4u3jcWJ/NwQuSwfUizB+FEg+Ht7LV4GEL5oRgsJtfZHWsJHNunG9fZtcnnUg=
X-Gm-Gg: ASbGnct6HTDidEahPiwDNFNhzt5qzUtjJ73g2IVVWhJ6Vh4dj8kBtbjuYCaOZrzWbSr
	yvU3mVLUczSGt/eBC6QV5s+ReKPcqM/JtR1jJL0MRq3HNf44Qe2ux0mUsdB+EumDpXziW1Dc7BK
	k5jmZeDdz2ogU57rPz50AJZpLxPhGpInkHn6e4VHNIS/QM0Ru4FhINmEs+ZvolmFvePUiGgrgrI
	2dVtiTdXrAVhoOxF9/B1EKbmuOMknwKsD2eknt73zYrmpK361W48z2e7CGz6ye+KpT4mjg//FgN
	9bDAstzuGLAJfAXgXr4HeWvPgDou3olAWQppN3NBBeAGvg7zvFueJ9AOQGyz++1Kepo3KLR3Lbo
	G1Tc9scfpx0wulfA4rUJirJsmcPyTNJyRLpkIG75A6G2vstHlaCXchRiUHYWppmw/YRY21l4Ubv
	wGFfkYHBCqIdkMjuCv1S8shZk=
X-Google-Smtp-Source: AGHT+IHNrUU8ZTQHWIkXmBT3rdXXpLKpHISDM5/fpvNZ+43C8Si9jIHm+HhufeG/7xUJCg0gSAl2Lg==
X-Received: by 2002:a05:6808:190b:b0:450:b3a:539d with SMTP id 5614622812f47-45015d46b99mr556826b6e.7.1762465328723;
        Thu, 06 Nov 2025 13:42:08 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450027f640esm1244973b6e.23.2025.11.06.13.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:42:08 -0800 (PST)
Message-ID: <84faddcb-07c5-4031-a56d-6785d49bf663@linuxfoundation.org>
Date: Thu, 6 Nov 2025 14:42:06 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: harness: Support KCOV.
To: Kuniyuki Iwashima <kuniyu@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251028024339.2028774-1-kuniyu@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251028024339.2028774-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/25 20:42, Kuniyuki Iwashima wrote:
> While writing a selftest with kselftest_harness.h, I often want to
> check which paths are actually exercised.
> 
> Let's support generating KCOV coverage data.
> 
> We can specify the output directory via the KCOV_OUTPUT environment
> variable, and the number of instructions to collect via the KCOV_SLOTS
> environment variable.
> 
>    # KCOV_OUTPUT=$PWD/kcov KCOV_SLOTS=$((4096 * 2)) \
>      ./tools/testing/selftests/net/af_unix/scm_inq
> 
> Both variables can also be specified as the make variable.
> 
>    # make -C tools/testing/selftests/ \
>      KCOV_OUTPUT=$PWD/kcov KCOV_SLOTS=$((4096 * 4)) \
>      kselftest_override_timeout=60 TARGETS=net/af_unix run_tests
> 
> The coverage data can be simply decoded with addr2line:
> 
>    $ cat kcov/* | sort | uniq | addr2line -e vmlinux | grep unix
>    net/unix/af_unix.c:1056
>    net/unix/af_unix.c:3138
>    net/unix/af_unix.c:3834
>    net/unix/af_unix.c:3838
>    net/unix/af_unix.c:311 (discriminator 2)
>    ...
> 
> or more nicely with a script embedded in vock [0]:
> 
>    $ cat kcov/* | sort | uniq > local.log
>    $ python3 ~/kernel/tools/vock/report.py \
>      --kernel-src ./ --vmlinux ./vmlinux \
>      --mode local --local-log local.log --filter unix
>    ...
>    ------------------------------- Coverage Report --------------------------------
>    📄 net/unix/af_unix.c (276 lines)
>     ...
>    942 | static int unix_setsockopt(struct socket *sock, int level, int optname,
>    943 | 			   sockptr_t optval, unsigned int optlen)
>    944 | {
>     ...
>    961 | 	switch (optname) {
>    962 | 	case SO_INQ:
>    963 > 		if (sk->sk_type != SOCK_STREAM)
>    964 | 			return -EINVAL;
>    965 |
>    966 > 		if (val > 1 || val < 0)
>    967 | 			return -EINVAL;
>    968 |
>    969 > 		WRITE_ONCE(u->recvmsg_inq, val);
>    970 | 		break;
> 
> Link: https://github.com/kzall0c/vock/blob/f3d97de9954f9df758c0ab287ca7e24e654288c7/report.py #[0]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Support TEST()
> v1: https://lore.kernel.org/linux-kselftest/20251017084022.3721950-1-kuniyu@google.com/
> ---
>   Documentation/dev-tools/kselftest.rst       |  41 ++++++
>   tools/testing/selftests/Makefile            |  14 ++-
>   tools/testing/selftests/kselftest_harness.h | 133 +++++++++++++++++++-
>   3 files changed, 178 insertions(+), 10 deletions(-)
> 

I am okay with kcov support being added. You probably have to fix a few things.
kernel test robot is still complaining on v2.

thanks,
-- Shuah

