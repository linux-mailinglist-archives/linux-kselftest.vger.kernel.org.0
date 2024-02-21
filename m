Return-Path: <linux-kselftest+bounces-5095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9373085CC95
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A4228346E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3B17F8;
	Wed, 21 Feb 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bz9nlT6U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46893386
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474462; cv=none; b=uUGrfj/dL6ElBZs4KTPxFRLYU0sWDMBuUA+3zbudHhc6X4Jsu+xNhE4URv2j8Noq4C4gQgTP17x3tNTtGI43pRsLY3cJF9CECppYucPNUGO2z9ubzDN6Cubb5pEgEEsbu6XOsE5byouBUWoJ9g1ywrnXleqNk/H7VF9mIZDuP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474462; c=relaxed/simple;
	bh=arpGt5Xh6mVPL2LI6cxtzQGDGHFhcHS3Qglx7+2cQ78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tykj6OTd9bv0XZ/RrF6+tWO6LXDJOraJuD2qQqG5xCOFdHlkuemLx7fOCUXYeNwwY5zp/YRIh5UdObrj7gCOJ3kzkxJo4pI3kgpKgWsVDI+bE0s0eHD2IZTiGyf83PaEE/54bHSE86TD634BLNW9sMFpyn9WozpLBRJOR3FYC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bz9nlT6U; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c495be1924so66260239f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 16:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708474460; x=1709079260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbwEa+mjRLUTXrnmEQkPmHrBcrA9pXlAMlVI6ey5rh0=;
        b=Bz9nlT6UGL0cd+bbsxchmsdRabIurxYhssemcMkSJB91zuyCMvTEypIMBdfMQdAd1V
         2APvI+X9PltWJm309X6i6VCOtRTu/WQMkgN8VRubFlXJrmIN2F/mRCTsUK2qsCp5Cs62
         I69ceKuVZOpssWn0vtaypRzH0kl5Tlb113ObE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708474460; x=1709079260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbwEa+mjRLUTXrnmEQkPmHrBcrA9pXlAMlVI6ey5rh0=;
        b=gA3yK6TrcW7S45vYLEIYevMwVIFKwZ663tBdivhQo3wxajxlEbyKNi1Hq9QzUEUxnT
         +XYV+5hq/dzIW0UtfE5bSv2oxZOa2Phy1EK9jx0auyzoNy+YeHX4/tD4jNiAf5yr+0xh
         7I8JCSTdn2o4j22+pR0HA81x8RFaovqjYHsTP8kz4kv7Urqlx+RoA9H3dUiFJW7bycGb
         Ehwi3aRAA5VZGzyf2CTBQ8eAnhVXOLCQ8LHr00/TYxHYTQqsoEZuI0kK1i76AWc/oUMl
         wHOBxbvsiw0W1gs+SVpIydo8WGGZmqxY6XblsLcZzXjnGuPfeN7SMu7ib0ONcE/1L5yf
         3JoA==
X-Forwarded-Encrypted: i=1; AJvYcCWzrjWF60FV2Dr91pbMMuth/byLDV+64+O7AHNfeuM2HkZMCxgOS+z/bpw0y7dwiI58lNGfJ2DDEFI0LxrYRqTWDAHQk9iQH/0f0/50AeG/
X-Gm-Message-State: AOJu0YxLC5kA9xFgrilSNfLcocZ/5k+Mo/dqeLoBGaybP2bulmyfNsnM
	cqkxBFIJR9km7zgbj1O1thXoZ/RU0gDvWe6/MmBtodzYboFBHI7XW5w/ge7h0po=
X-Google-Smtp-Source: AGHT+IEHvlYzcObNY1Sb3aVdxtXV1KeGoGTPexv/zoa35da29BCRAWQsfMui+mAB+L8Fdyiump2AXw==
X-Received: by 2002:a5d:9047:0:b0:7c4:c985:145a with SMTP id v7-20020a5d9047000000b007c4c985145amr13481443ioq.2.1708474460385;
        Tue, 20 Feb 2024 16:14:20 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bc11-20020a0566383ccb00b0047414ccf744sm1992399jab.91.2024.02.20.16.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:14:20 -0800 (PST)
Message-ID: <ee74c429-4e71-4076-9b48-064769ffad6c@linuxfoundation.org>
Date: Tue, 20 Feb 2024 17:14:19 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/mqueue: Set timeout to 180 seconds
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>, shuah@kernel.org
Cc: ryan.roberts@arm.com, abuehaze@amazon.com, brauner@kernel.org,
 jlayton@kernel.org, jack@suse.cz, keescook@chromium.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Vijaikumar_Kanagarajan@mentor.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240220000802.162556-1-sj@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240220000802.162556-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 17:08, SeongJae Park wrote:
> While mq_perf_tests runs with the default kselftest timeout limit, which
> is 45 seconds, the test takes about 60 seconds to complete on i3.metal
> AWS instances.  Hence, the test always times out.  Increase the timeout
> to 180 seconds.
> 
> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Cc: <stable@vger.kernel.org> # 5.4.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> Changes from v2
> (https://lore.kernel.org/r/20240220000243.162285-1-sj@kernel.org)
> - Update commit message about the new timeout limit to 180 seconds
> - Remove wrong Link: line
> 
> Changes from v1
> (https://lore.kernel.org/r/20240208212925.68286-1-sj@kernel.org)
> - Use 180 seconds timeout instead of 100 seconds
> 
>   tools/testing/selftests/mqueue/setting | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 tools/testing/selftests/mqueue/setting
> 
> diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
> new file mode 100644
> index 000000000000..a953c96aa16e
> --- /dev/null
> +++ b/tools/testing/selftests/mqueue/setting
> @@ -0,0 +1 @@
> +timeout=180

Applied to next for Linux 6.9-rc1

thanks,
-- Shuah

