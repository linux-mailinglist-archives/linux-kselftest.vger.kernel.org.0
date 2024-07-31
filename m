Return-Path: <linux-kselftest+bounces-14558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A1943488
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46641F2608D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F211BC072;
	Wed, 31 Jul 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WPMHPIO4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D2812B93
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445049; cv=none; b=bEeNCIVKuKT/6O6o+bLqjYQEjyulm8U1Cn84hMwNpzTw3tAV1w1IR2ei1uIGUHcmdRXFr9x8un6/hf1ML3G63H2gq3UQs49345tP3ZAyWJIohsextyfrJkN0vg7xGXmCX0uMhdm4W+3mkpkmoePgNwI9jIE3oDNrhSKMJwiLRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445049; c=relaxed/simple;
	bh=d+kkP0aMvAdSvYfIBJ+5tSpefV4yBmItxJsquTxy+R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jkayokil+mW+YYtZvMLWQkPx2d+6ZtjNNwBO7Y2hk7iOOUohz8FSXKo7eE0kF0OqtVtsadHc8NAmLa4hORHWAWmqZ/ybxv3CcxXsNaeF6zt9OAFYDOilCtkHI8m+1diqN9GvWiYgEqkjgDoWuiULFp7xJ8kbsjDTqWhRYe9iX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WPMHPIO4; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-812796ac793so30581239f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722445046; x=1723049846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ClsNqpEyCM9KvAFI7Prgc5NoHr2vcPiQ1Jhf3PD+rQ=;
        b=WPMHPIO4kTdLXd/BBRmMh3HivCAZ01/2pam6pj+ZPY/PtQGMe/SPzzISGW0OtorOms
         XnN0rPOwZf2LUcrsGdADykUVW98X5Z6mqHs698mLx1cRXCrlKeXbCH8lXdMYexRjaDGp
         TZ3Pb2sqrtQSFOU5osD4Hhx6qMI2AMxW08JIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445046; x=1723049846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ClsNqpEyCM9KvAFI7Prgc5NoHr2vcPiQ1Jhf3PD+rQ=;
        b=AXK6hDpN0+4qngsuR8YoZ9CPL/reo9nzyRnTcJpTcI+i0MnRtlKpJsD7BaZoEob6vT
         sMKaHol3IL9sPzj5SoD2p3GxfV/kJAG3ctsyU2AoUwSSytSH16RR6ick3tNpb/nyyO5t
         ZhTHWt3dlkmTrJb/1m0ZgSsyoHm6KK9QRRQGq9eimz4msEbUPAfZCAYfJPndtg5FCNaO
         07TBMJxbH+J9pPbmNZUSzMjLGvPow97P61Pc6RxAeEtba54X8fnR53ICl4kz+REr298z
         iScuG04uRUD0f7vb+iFTNDFrlMV2P6aXTVmrInyBlXBA+WsceWZUSOwzoVMAKMq+DLPF
         lf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrX0SYrPBdAClCY1i6Kn9I/Ftm7wfLHj/Vs0oFbxuI1iuLXVa7s+3aAEmErvhFY+horPWWxqE07EWPvhW8Kk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8aUK768nZgL/VxQp+wb5RgyO1VnQutGM+gVFzxqhPACfbKuA2
	cisxsrHTXB0KQqDPkGVcCIM6uxNuj/Kv4VVUjNJi9V/nQbvBUUvsDajdfJRwsx0=
X-Google-Smtp-Source: AGHT+IF8+NuvHGohdtP5ed7Ae5GJ+QJAyq6tglX3aLXewVVvJwuPGRQPSgMVbP98OQaYi47qzQt5Zg==
X-Received: by 2002:a6b:7b4d:0:b0:81f:c609:df28 with SMTP id ca18e2360f4ac-81fc609df84mr152809739f.3.1722445046601;
        Wed, 31 Jul 2024 09:57:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d730435sm413578839f.16.2024.07.31.09.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:57:26 -0700 (PDT)
Message-ID: <c1414d9d-61b1-4f92-bc8a-333679362283@linuxfoundation.org>
Date: Wed, 31 Jul 2024 10:57:25 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: openat2: don't print total number of tests
 and then skip
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731133951.404933-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240731133951.404933-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 07:39, Muhammad Usama Anjum wrote:
> Don't print that 88 sub-tests are going to be executed, but then skip.
> This is against TAP compliance. Instead check pre-requisites first
> before printing total number of tests.

Does TAP clearly mention this?

> 
> Old non-tap compliant output:
>    TAP version 13
>    1..88
>    ok 2 # SKIP all tests require euid == 0
>    # Planned tests != run tests (88 != 1)
>    # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> New and correct output:
>    TAP version 13
>    1..0 # SKIP all tests require euid == 0

The problem is that this new output doesn't show how many tests
are in this test suite that could be run.

I am not use if this is better for communicating coverage information
even if meets the TAP compliance.

> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Remove simplifying if condition lines
> - Update the patch message
> ---
>   tools/testing/selftests/openat2/resolve_test.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
> index bbafad440893c..85a4c64ee950d 100644
> --- a/tools/testing/selftests/openat2/resolve_test.c
> +++ b/tools/testing/selftests/openat2/resolve_test.c
> @@ -508,12 +508,13 @@ void test_openat2_opath_tests(void)
>   int main(int argc, char **argv)
>   {
>   	ksft_print_header();
> -	ksft_set_plan(NUM_TESTS);
>   
>   	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
>   	if (geteuid() != 0)
>   		ksft_exit_skip("all tests require euid == 0\n");
>   
> +	ksft_set_plan(NUM_TESTS);
> +
>   	test_openat2_opath_tests();
>   
>   	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)

thanks,
-- Shuah


