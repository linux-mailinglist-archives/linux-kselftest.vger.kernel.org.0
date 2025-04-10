Return-Path: <linux-kselftest+bounces-30487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3BEA847FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F221C1888DF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A761E9B0E;
	Thu, 10 Apr 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A/qqkkvZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9731E0E0D
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299200; cv=none; b=E+dGQ6xVpBEpjlPNmw6jbK4fDtAhvP3AGpVrOta/7aWIh6408xFBKw5n8f35MZtKK/8AwMYeU4Bq46VP9kFfNzhpxoaxO5MATAqhYk0sAVivTGUisEcKEm8MXgxQsnR3OIEUl6SDb2cks3BJkD5/c3YNmIwf7squmpjQ9e+cIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299200; c=relaxed/simple;
	bh=R4JcdOP5ZS2NZpHV1skCSE3ooXP17ubX1xad66aelU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7z1oZ6WCtJj/AmtZTzdMza+0bqrvMuakdmmJmKjV85vJwmrsnkbIBtPIvQRnKQIhalDNu+BOx9ghKzJc4W4Pg4feLIeaMvPobTn/86ozdciRi9oZnL6lenBQLZUinTfzh1Ffn7d2IPnEvDjEDCQJNMo9y+eYzPQFJwV98M3WnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A/qqkkvZ; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso24121839f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744299198; x=1744903998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVBSqrkQs33y/UfJ4YzZEYB1/aRTPmE1UaXspipmDPM=;
        b=A/qqkkvZJ/KkODb9kng1/fvp3u+IbpSwBWV/JctcVH7Ms0Om6+pDfxsegpQ/uv0/Hg
         uBigzSFfY3jyZqYsg16bZuXMWIrVVI+6gwVLD1041edmy46QpZI5bTo9ny5gIFjVr30Z
         3QeN6OzGlStopEEBFhwpwAAFFVxaiVApSmGj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744299198; x=1744903998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVBSqrkQs33y/UfJ4YzZEYB1/aRTPmE1UaXspipmDPM=;
        b=w7UkwIN4XKqBA8EDrsM1XjdO4x20d9PNnNE9zci/2KkngEc1SSCoSzmf2ff5KQN7jA
         RAZfJDTE3jtaM45xFqU6vgF9wpVmntPhurLH1Nv/06IWwVSdw2KJjNp3tOKNM0PyCGY1
         N5YwtOUCuGG/2H56tboeZnrfswcVsBw1+Qt49VHltSXUnCg05j6vtzP7/LOXK1+I3uHv
         uIBiuO4t1dw0qqh2ebrzVeAkdioied5amFSVBo/afhTrAgDAAfdSbg45aF5GgIham2DS
         r+j075RfbPq5o0wVT9HbjdIJcLnMwt0qUHij6IfQ9BW1c0QiMN+O951joLrWavs5WpGN
         JN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFh38RY/7GP82XxjCzxnR17TscrEdjtrszZuvjZql69Pgnj2oshK8/K2/jTcKYQrxxStSYNtcinM50LCcbIZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPAfZSJLMSOlICzznoB4W9G+4H6dUDLGLXlFftUXGRuiiMrvy
	u9n0JjTkw4tuawHVje1TzHHaXyilCadcYzG5k73BXn2O3amG6cLA0EVFkRVfu+iLgistNnw5MNC
	p
X-Gm-Gg: ASbGncumUYa3dxahwF1s42yqRIrSBxTzhNIVed/p0Or4t69RVu0Hmo/XpzFk56iUstF
	7rGjLqnWSRUBUUhdwCrMRKFgrsvgTWVY/sjS9nMGouZYR0HzrlVLzMJWuxVYU7+kHWugPmB3xCB
	sm1V4fG5Tk7wFMTgTcEoZo0a8hPiGMIy24ydjuMM+A7Btqaqq7/iVUU34PNF+0PUoJDDiPW2oNr
	3HCEVXRNIwgA20WUIPzaN2XJ+dm+sut3zMNOuGH9hevmACJMXSGc/aedWD2ZJ8CfLvtXIZ/NKKA
	HgGvqmGBQpNsnOMVOIWtphkOkTyWXGiauE6bOTgkm2LETHltDPU=
X-Google-Smtp-Source: AGHT+IHjEffLROVPgH62sq+jvKud/CttzorBFAX4lZm7gaew3ZmymtkyTnvSGgylg5WNPumk3cnUAA==
X-Received: by 2002:a05:6602:4c02:b0:85e:183e:4c00 with SMTP id ca18e2360f4ac-8616ecea937mr335117339f.1.1744299197785;
        Thu, 10 Apr 2025 08:33:17 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf8259sm785148173.29.2025.04.10.08.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 08:33:17 -0700 (PDT)
Message-ID: <ffd1f317-f4d9-4a39-ae6c-04afd7fddc0f@linuxfoundation.org>
Date: Thu, 10 Apr 2025 09:33:16 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/32] selftests: harness: Ignore unused variant
 argument warning
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Willy Tarreau <w@1wt.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
 <20250407-nolibc-kselftest-harness-v2-3-f8812f76e930@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-3-f8812f76e930@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/7/25 00:52, Thomas Weißschuh wrote:
> For tests without fixtures the variant argument is unused.
> This is intentional, prevent to compiler from complaining.
> 

Include the warning in the change log for reference.

> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index bac4327775ea65dbe977e9b22ee548bedcbd33ff..2b350ed60b2bf1cbede8e3a9b4ac5fe716900144 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -174,7 +174,7 @@
>   	static void test_name(struct __test_metadata *_metadata); \
>   	static inline void wrapper_##test_name( \
>   		struct __test_metadata *_metadata, \
> -		struct __fixture_variant_metadata *variant) \
> +		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
>   	{ \
>   		_metadata->setup_completed = true; \
>   		if (setjmp(_metadata->env) == 0) \
> 

thanks,
-- Shuah

