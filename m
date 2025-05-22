Return-Path: <linux-kselftest+bounces-33529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ADEAC16F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 00:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E2B7A3CA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 22:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1249D2882C5;
	Thu, 22 May 2025 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q4ROYLk9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4041286D65
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953823; cv=none; b=GEBq98AHMWKPA4fRryBG1U+lEOrOdSd/J98ysGnvCi01zBUVV3x8Tjvbw6g2DbwBwHmXvkg6GCGHF5AQmstcAA4yTqKXNXO4Dok1RFLnQu6JIKVhp0aLrPo0Q5gRb8jBuvShHwclX4vGl2lIqFEmeK/PR/RiCNd533ZB3meu/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953823; c=relaxed/simple;
	bh=d8ElNV1KxKf1PTMc9BiSriOci7moGD7yluHGQynQVf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkBNBlHJRQmee+d35k+5aqLJKYb1gTlUL7HWr43q7DMvVFYC4G720TryDlU8lYeRO1h7KEpTgWgKpeeEFjKMrAOVAMvblpLx/lx1IxYkLSkXb4ylKISqJRzT4YZ+9GTFuEvHumnISqyKQq5Q5NY7kpWQyydkQzoURvaQbG2AIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q4ROYLk9; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3dc6f6530c5so36104205ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747953819; x=1748558619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgAx9FRjAiSPVmD+10IVtHJnBsxw+8aMplanI2nZMN4=;
        b=Q4ROYLk9WwKxIjKIoOaiWWf9PUKeUP0J+yExkA0SoGTwi2C10purbPzas95RyyCkCK
         ZIq61ypWB2cYSIQSL/6CKRmyN9809QtMSgKWIvvJJhsltEVKKD4qjmQXEJp4Y7Yff+hJ
         tM1x0NB0ZlBRVUEn7aJTJnR48jkCGwI+Hsd6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747953819; x=1748558619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgAx9FRjAiSPVmD+10IVtHJnBsxw+8aMplanI2nZMN4=;
        b=M7ZmUYmBHo6z/8ViwdvZvoaYbeeuJpEVFrr0t5LiaPxskln3lpfEab8+vua4TCFBfm
         pZ7lQOAlQMu1uzLu5mUL7v1eLZsTKBGSw6n2OnEIPGc5RVjLWC4t4M2KDXcYr1Gd6tHZ
         vSIUKND2nI9mzC3qbGEMskdpax/zx4B3rugYf+CphmozhrHZwNtpeLGHGoYT6ihprGwD
         Xgm+GjBb8znKubgOpzs3N4oOVr2F+dKEdVha+39XEDGIS3aSLYZyXTJKk07wUiaZ6qDr
         ikhlY+UrW0kzMm2WrGm/p2+5LJlDcPRX2FlCjh/8C4Qxurt51SsTGckcMCTkaCnC9wpT
         b9cw==
X-Gm-Message-State: AOJu0YwZnmcvRityTg0d/zMhbemWS68OytTiXw3cyD8eSmxWRs7SCBKE
	1vqEPEHxeCuTpNPdMR/PW7+cG3UMr9X7UZfaVJlYcJwGQdziwTANEyCJrRfqGsPdrqgJB41bKEL
	hQAhv
X-Gm-Gg: ASbGnctN+9Bj2fkyEvrbeUJRcbYZ2/8fMF0ekzfHNZ4WLjK5qx+VXdcvIcuO+OG82Fd
	Uvyf9lnvdWf7dPFFzkXmvQZJomiCR8LqvWQRBepcWE6g8pJyq5RhryA9yCSPa8s4oIM1geI1dem
	63OBWFkv6fnSdvnOtUoE18xD47pOObYZ2to8/DOCeJsL5kzC30pl91891LvmtmSRju9J2ugeRsf
	7GGtfZ+irL7XoB0GGVRZ3XtirrfDhqhX8GZsjq5DoI8Gs4DHEj+5e4SrK9i2J6wxSH0EYEcdOQm
	mos8nuXLck32v/iAtwHuUGqpwog+2OmOHAiVNFRMzu8kCUV6Qp6y9P8e2OGD6Q==
X-Google-Smtp-Source: AGHT+IGgZrub3EqyIIKtPGhYUaoxCm8eFkqbXkOsp+d+6Y4GjpSAtke5qsqtY8wSwjMno4kibcNjng==
X-Received: by 2002:a05:6e02:3c02:b0:3d8:1dc7:ca7a with SMTP id e9e14a558f8ab-3db84296d9amr301540885ab.5.1747953818933;
        Thu, 22 May 2025 15:43:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3db843cf8fbsm37711915ab.1.2025.05.22.15.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:43:38 -0700 (PDT)
Message-ID: <a2980c99-6a6e-42ac-8978-8e0ab5319a9c@linuxfoundation.org>
Date: Thu, 22 May 2025 16:43:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Fix typo in cpu-on-off-test selftest script:
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250517011928.673585-1-jihed.chaibi.dev@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250517011928.673585-1-jihed.chaibi.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/25 19:19, Jihed Chaibi wrote:
> Fix typo in hotplaggable_offline_cpus function name:
> 
> "hotplaggable" is replaced by "hotpluggable"
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---

Change looks good to me. Change log should specify the
subsusystem. Check submitting patches document and refer
to a few change logs for this file using git log.

Send v2 with a proper change log.

>   tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> index d5dc7e0dc..6232a46ca 100755
> --- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> +++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> @@ -67,7 +67,7 @@ hotpluggable_cpus()
>   	done
>   }
>   
> -hotplaggable_offline_cpus()
> +hotpluggable_offline_cpus()
>   {
>   	hotpluggable_cpus 0
>   }
> @@ -151,7 +151,7 @@ offline_cpu_expect_fail()
>   
>   online_all_hot_pluggable_cpus()
>   {
> -	for cpu in `hotplaggable_offline_cpus`; do
> +	for cpu in `hotpluggable_offline_cpus`; do
>   		online_cpu_expect_success $cpu
>   	done
>   }

thanks,
-- Shuah


