Return-Path: <linux-kselftest+bounces-43761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DCCBFCC1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 17:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF06D1899C6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 15:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9734E747;
	Wed, 22 Oct 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDGTaNJa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2C34C9A1
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145336; cv=none; b=SPw4n9rFqrgRkdvc+IJ8pViggL8UpnZg9CWX5FbCwZF95Kbxr8RrpFIFddPMUrhHJYQti07dZCjd8xyUxVGP6f6PCrq0PJNKjrZNT7rAq7IneFUySYHYAUquOtdCe9Jk7LzcGK9xnVky8M7Xsst53IG+/LrtDPmUYaHgF8wFQJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145336; c=relaxed/simple;
	bh=hdYfR8VgCU1ZspHH5xOZyDRebDxd3yGnO9egZSHcGHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bI3XYKCtSQxmWz1UNQujrjmBb9ZYdqFMOnpnkM3fZglQ2Ersl1MIwOGhjcm73MjYVNuzPy/rypf86v9Ky8efs0JZLlQm5bTjSwRRsDUn04TZFSKbsOq/6S1EwFVWhGFynS/xkA6IGRfZHd+NKTlpUNZk3G1UaRuv17VS3RQdxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wDGTaNJa; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-87bbee3ba76so2920506d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761145333; x=1761750133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BnIAOSj9hN5H1aKf2wyJor6fNQ1bM8Ks2ytqG7kDK1w=;
        b=wDGTaNJafp0TkjV2WDjXy2XC8NiDYd9xJwapJG+UdY4c/LxxemLKX9PGb3hvImqsyA
         3t6Yqz7BFatgFlPJBT5Neo9Ve3MOR2Sr14sAloMgwh3DQa1AC3acTxcbHxHZzE5RiIdA
         Qj49gmV6weV95hYSBMqbgew1ONIMcWB5hyWpcz/v4Rr3wYhGZwCXdfiZdr3yGTuqJLDz
         xdFcV23X/HYUnByVCsWdVllwxr/Qh2KCiLgePTkI17t+BNjYDOZs/VmMNEbaR44hYPAf
         3nPdxdls3CotHnVozYv8a2POLaeWu8jiVitkr/J9sizkc3brm+5RF5JIkxyhI/oNAd3l
         j7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145333; x=1761750133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnIAOSj9hN5H1aKf2wyJor6fNQ1bM8Ks2ytqG7kDK1w=;
        b=ivv9JBcKrwRBXmia0LtacsufFrFW8tj/zgN8umeYiTMB3h3Yi7D2mcdoFYRJax+Zj/
         KhZ8h3rBEyM18AOe0XeUOI/tiHaMCsxM7pNf8DvpxnAoqyinYZi/xKrpRZXWXcz2it6L
         sntBdMNBibyXaHwdnsfHEGiFX/rrAiHVfveZqjVbtG0G6hxx2AqVQboD6L/WVM4mmojO
         tcH42btP2XwDWJHjWyW4f/2aiX1FYxfVKz7EON217+bzNCS1Eo1pZS2t9wj6O6hai4CM
         5ysBWZEEw9HfOSGc1c6SL/Kuijnz3sx69k5gdx5m3H5bUgdQKSRGpR2KQ8iyFI/Liehk
         KiCA==
X-Forwarded-Encrypted: i=1; AJvYcCWN6D/ahNAkNJ697hMjmxycUSuyFsB2tLkcCkmjzkBrXX1UPNM6+4XB2IzddCrQiUC3Oy67rUH1ZCZ4YNLQXcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsvjIjLP2Dmm/nP1vFVa1KZR8N6JcofLjJws+RW/7VBmjrGTIc
	vAijKDEpYJnk16vhf4VygXM8UMf4oLuN7OUOuEQbAnV46YnorqN3NcYC1FUy/CXrckHGx+eKpVg
	y1wWA3kq7+l75zIiKi9oKKvLix4DSQb6+te3Q8LIkbg==
X-Gm-Gg: ASbGncteeYWvqkmyF5U8EmfC97zHfJ392P7YRBZb4PWpzqmjp9FgxUYjh76/+LU8f8X
	Ca5JHq8Mwm5O1OXEpoJfVm1hy3cHWKLjmP8IStnTZxZhlscuMsW2tzcgsU0/fC+2oDkbe1iiuOr
	irM5QKVtFko7Auf6cNfIqaFduxEYzRLV2MSl8iwKchunaFFXcwVLr3QwkEAh+1s4ssDvMhf2cHt
	pECzT3Dj2IfBJmGe3+Y9abCJTfP+z6YQRQ/Eq2EPHfotAn2Uo/mKbblTPk1fLrfMpdKpQ==
X-Google-Smtp-Source: AGHT+IHDNBWFGq/lO9UqX3OiuCVmV8mj/OamM0dXHm9H8/TY++90uwy4eHmeOOO7ME2KeAOXQVNRoq9F5JuwtjkDp/g=
X-Received: by 2002:a05:6214:19c6:b0:87d:f8d3:2456 with SMTP id
 6a1803df08f44-87df8d324a4mr21664096d6.2.1761145331914; Wed, 22 Oct 2025
 08:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com>
 <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
In-Reply-To: <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 22 Oct 2025 17:02:00 +0200
X-Gm-Features: AS18NWDwE4wLtG7BZRqK8s-_yLrQzlCdiI_YRXplah4qDB6dhd-o_z_6gw0x-cw
Message-ID: <CADYN=9KxQaQMWNbwDSftj7kcBYHjAQPacE+z7AVRZwxPTpexYQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/x86: Add selftests include path for kselftest.h
 after centralization
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: naresh.kamboju@linaro.org, broonie@kernel.org, arnd@arndb.de, 
	benjamin.copeland@linaro.org, bp@alien8.de, dan.carpenter@linaro.org, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, lkft-triage@lists.linaro.org, 
	mingo@redhat.com, regressions@lists.linux.dev, richard.weiyang@gmail.com, 
	shuah@kernel.org, surenb@google.com, tglx@linutronix.de, x86@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 08:29, Bala-Vignesh-Reddy
<reddybalavignesh9979@gmail.com> wrote:
>
> The previous change centralizing kselftest.h include path in lib.mk
> caused x86 selftests to fail, as x86 Makefile overwrites CFLAGS using
> ":=", dropping the include path added in lib.mk. Therefore, helpers.h
> could not find kselftest.h during compilation.
>
> Fix this by adding the tools/testing/sefltest to CFLAGS in x86 Makefile.
>
> Fixes: 4d89827dfb27 ("selftests: complete kselftest include centralization")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/lkml/CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com/T/#m83fd330231287fc9d6c921155bee16c591db7360
>
> Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

Yes, works.

Tested-by: Anders Roxell <anders.roxell@linaro.org>


Cheers,
Anders

> ---
>  tools/testing/selftests/x86/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 83148875a12c..434065215d12 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -36,6 +36,7 @@ BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
>  BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
>
>  CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
> +CFLAGS += -I $(top_srcdir)/tools/testing/selftests/
>
>  # call32_from_64 in thunks.S uses absolute addresses.
>  ifeq ($(CAN_BUILD_WITH_NOPIE),1)
> --
> 2.43.0
>

