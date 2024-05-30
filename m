Return-Path: <linux-kselftest+bounces-10921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFFB8D4DE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 16:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205DA284287
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2C17C222;
	Thu, 30 May 2024 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RD+Z1RpA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333017C206
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079124; cv=none; b=o7ssFb1RgmKC5+JhiX5U6LXElqOAd3/RTDy+7vHuqyIaf2mqKKJnLKK+Xn4xcLMPmEbWZhdomyt8h2E9FjeOvIuGBKTBP7CEZP1nm43eaIYA++wM46oPUGYH8/Au+WggNTP6g/ClFYcq/ACxZvI6BQTZLy+ztYJW+vHKAlyahz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079124; c=relaxed/simple;
	bh=g/X45uSF6k+HRkBUhwjSpxSxuIqXtM9kMM336BDvTlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnCiM/86UVwl4VwxIh4dCEarAFojeY7L+dPoowNTD+3qLn3Xc6V4UUJiNuqjHsaEWSNkrSM+lflqdnyZT2TlKOJcvK6VE0WThZC0TqyO8SvdsJtfqc/tJZVWzydHLYi47YeHcOLk2VwezzO1sm2J3zAbIoWZvDCJQK2QRZX+kPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RD+Z1RpA; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e95d1a6c9fso4787639f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717079121; x=1717683921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nsdkf/hEokdRbVfsff4bOqv3Tbq/llwdsETViLwX3BI=;
        b=RD+Z1RpAzQpOdC7U+oHVdomJ6iMeO2XvQo57qkFkRE3lZuzhlcD0OstuzQqPYdcs47
         G6jY/SqKhOvKL2d+WqHDalzPAy5XSLFvXS2S9il20hED8braufeUBbUNKr7b2VK6O8zf
         vNj59lLtWXeH0iFIfQvy5CcoKDmguMLLBniek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079121; x=1717683921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsdkf/hEokdRbVfsff4bOqv3Tbq/llwdsETViLwX3BI=;
        b=reT4XLp7Xs0AWXxLSPA4dyk26sTK5XzK3+Ca2oaXPM9hIqbExQiiTCcsKYMC/2YzTl
         83xWh9zcPUDusoGIcaMjyi80VUhVDXEz9Z8i0HCm9LGhipGks/dZQmppZRWQtm9EnnFG
         n7MyiDey5FJ1Lh+gO+H1xezhT9uC9wGSJsZOY/gFtxUc8UypNuo70OtabTZnkPb+N05N
         oJjPvYTtJRFPfn1IC+iyD/Qj+9JtTU6LHSoUluoU8h/YP078T96dV5+MfLfSaqPgEqbJ
         52yCoCxgp2yOI2cziGRjH9vnHYX9PCW+uJ6pxiiy66GlAeTqJVFb9CZFAPCz/PjqkdHF
         jkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3r2tftrUU0QLqNO/cVZBZzY5QnSH263yJC5TyzS08y2WqS3bIGIwBIbtUQVvd18iW4M/f6TPXmOXlEWOpgBPDnDESiBLo0obB++Oa3YEb
X-Gm-Message-State: AOJu0YzxREDvBVG7fkpGUsHDb1aWwCCXrXLprBskoY7zOldEG1wdaI77
	Y1NgiAuGlUI3ISABxtI2iMe2Aj5FECDhZ8aIVl5mp3MbtC1A3y+RN8N3bZgSnI8=
X-Google-Smtp-Source: AGHT+IF8O6GPnyWjF5VaTmv02b4u4/S8Ekhuksh/BQkhTKKplAGUx/4CG+uFBabO2++mbMvPZsfKCg==
X-Received: by 2002:a05:6602:19c9:b0:7e1:8bc8:8228 with SMTP id ca18e2360f4ac-7eaf5b73813mr241539839f.0.1717079120876;
        Thu, 30 May 2024 07:25:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b10cf31917sm1404185173.45.2024.05.30.07.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:25:20 -0700 (PDT)
Message-ID: <88c64f5e-4586-4b38-b3c8-0c3af93a71ae@linuxfoundation.org>
Date: Thu, 30 May 2024 08:25:18 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/lib.mk: silence some clang warnings that
 gcc already ignores
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 sunliming <sunliming@kylinos.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240529020842.127275-1-jhubbard@nvidia.com>
 <20240529020842.127275-3-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529020842.127275-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 20:08, John Hubbard wrote:
> gcc defaults to silence (off) for the following warnings, but clang
> defaults to the opposite. These warnings are not useful for kselftests,
> so silence them for the clang builds as well:

Please you add more information on why they aren't useful
for kselftests.

> 
>      -Wno-address-of-packed-member
>      -Wno-gnu-variable-sized-type-not-at-end
> 
> This eliminates warnings for the net/ and user_events/ kselftest
> subsystems, in these files:
> 
>      ./net/af_unix/scm_rights.c
>      ./net/timestamping.c
>      ./net/ipsec.c
>      ./user_events/perf_test.c
> 
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/lib.mk | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 2902787b89b2..41e879f3f8a2 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -50,6 +50,12 @@ else
>   CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
>   endif # CROSS_COMPILE
>   
> +# gcc defaults to silence (off) for the following warnings, but clang defaults
> +# to the opposite. These warnings are not useful for kselftests, so silence them
> +# for the clang builds as well.
> +CFLAGS += -Wno-address-of-packed-member
> +CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
> +
>   CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
>   else
>   CC := $(CROSS_COMPILE)gcc

thanks,
-- Shuah


