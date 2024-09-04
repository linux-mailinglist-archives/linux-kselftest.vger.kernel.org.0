Return-Path: <linux-kselftest+bounces-17154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E2D96C484
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4524286DFA
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7FE1E0B99;
	Wed,  4 Sep 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZkFcD23U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EAC1E0B81
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469085; cv=none; b=GfOHSdQ4Q0BgYfAfpj3Xo+ABfYtWGGzNIRJgS+TuhM2gHI1JS6WHo7rBOnlVkaZwGglkfHgBvA5Giikh7doyV46N8IlRxFMg1SM0rDQlQHeNgL0h6j/7yshul6xTqDXWZlh/6n9q86nySwwr0d5S2vm/F2C03MzWcQVEqvok18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469085; c=relaxed/simple;
	bh=DHk7r5GSnoed1W++EtjusnzMP6hLR27PO9RzULp6bSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFAKNz/uzNJWYiUlkIUyrVZF3NI2hkOwq3mh18FHhxoUarpy0h/xYP5NdODX458Sm+IcZuhgRDeZ+eo4QLg1GKvW3HMGw+RrAVfPLuisBJAz9EHR7Hfx24oJKPPLI36N2o3wy7OjxRVnhzJQRnnFPpmD9kCTlKxkupxtxqJdWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZkFcD23U; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a043390030so2268315ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725469081; x=1726073881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BjtNV9LGdeLrtx3HjEExZXdynW3SKUo8isfkGbW18w=;
        b=ZkFcD23UbQmzz56uVLwtGxEHqJfsEKAJRpCWsxNDhRNdGoNnHDInBWcvgMStkvqqLT
         vGWHvPbAGp2HCi/w80ULULzJkO3fTfUqfCeNldUZoTDwBz2CXBEWvzma8bFTFV2PWWWD
         fvt+6idUpOVYO8yWVj1fr2FxZD/3fQVQ670tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469081; x=1726073881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BjtNV9LGdeLrtx3HjEExZXdynW3SKUo8isfkGbW18w=;
        b=t8wXUHfKICoTzA7zH4l2azmZKLTmaRLgxqNA3SiOrp0PT0drjcowuBO26vCJTwMfLr
         I6RoT/3et6kg65zg+DFvE1q8OQtf4SlujLzpeblPS29Kfje/s11H/mYDbwwdKQyKLZg6
         JNVD9YCvb+xgH4vBR4wzyPV57biMlbhS4EE93IgZXdqhzTCh0mKRDil64AaKmlphJwi0
         YLzqJZ4hvQAZ4Edg1CuqT70InsZwcW5LajOKt6qi6wn8YvrdUJvHhVxKCULoK8ZAvzpU
         kr1C3dLQSI2JPtisk2gjMZ1dLlF7asjkD0HtfABYaJcDQ9WFhE0w0SlXfzDAsJe8ZStP
         IZNA==
X-Forwarded-Encrypted: i=1; AJvYcCU/dCh5j4tb4T9Gp0/iseBJ+RyUjZ3+pJ8a89SIO1cB6k5bZMCz1GIZFFkzbkZoAcueDMpQgglbk/L9ktgjq5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YySJC7wqQV/W1fd1wJ+yVUqehHAraxpCwvzYvbH/nw7BY3zZzm1
	C2/xyiza1p0tFL3UVMWHiSOiaTuPcHj/QaFzxvWgqjUjJpkzytpL55NJhcryduk=
X-Google-Smtp-Source: AGHT+IEHnyuMkq3vfvdpdQdsRFrPuM9MRgs0smmPFDdJYEnrA9a3L7tXs+vVEffdLBBwcn6VDhmJcw==
X-Received: by 2002:a05:6e02:160e:b0:382:64d9:1cba with SMTP id e9e14a558f8ab-39f4f55f3d9mr173243655ab.19.1725469080917;
        Wed, 04 Sep 2024 09:58:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afaf411sm37860525ab.20.2024.09.04.09.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:58:00 -0700 (PDT)
Message-ID: <3b7316db-42e6-488c-affb-297b33e08bf6@linuxfoundation.org>
Date: Wed, 4 Sep 2024 10:57:59 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: futex: Fix missing free in main
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, tglx@linutronix.de
Cc: mingo@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240904025559.7356-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240904025559.7356-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 20:55, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Free string allocated by asprintf().

How did you find this problem? Include the details in
the change log - The tool and output from the tool.

> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/futex/functional/futex_requeue_pi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> index 215c6cb539b4..fb2dab46087f 100644
> --- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> +++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> @@ -416,5 +416,8 @@ int main(int argc, char *argv[])
>   	ret = unit_test(broadcast, locked, owner, timeout_ns);
>   
>   	print_result(test_name, ret);
> +	if (strlen(test_name) > strlen(TEST_NAME))
> +		free(test_name);

Why not set a flag to determine if test_name needs freeing
instead of calling strlen() twice?

> +
>   	return ret;
>   }

thanks,
-- Shuah

