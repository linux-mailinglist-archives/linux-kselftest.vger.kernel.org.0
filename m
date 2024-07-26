Return-Path: <linux-kselftest+bounces-14276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B293D7AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 19:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D096282485
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 17:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEE817CA10;
	Fri, 26 Jul 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TqwiDsSl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099E748A
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015166; cv=none; b=ZsWDJ80tayqn1RbjP3/AfL5aFn0Q/J8dOSPuUzGJCWswwuBUSt3YzuS8mFM9/niPw1ry96wVtwLasJ4DAtOaR7L7mTEU3JtCkfEFdA2qjr+LM5z73oweZ9E8hDQFrYVA/iRQABLcu5uyik9E3z7es4hmmKHUs5AEarCYEN63CeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015166; c=relaxed/simple;
	bh=xGHmK9gWGUp0gHCFdD6XGO+i8NLts1NPaIMeFMTYSnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSzOTx6RLHKj/G4oEg+AJt0CDOB6A+hSOKOwhXwmdXkCCtwp49mJu0yIQGnC8ltdQLOjIirbcem2G/tahT2DJoNS286cLyHK/bn3uEouOdBcdhJBTHFBqnmf7z3jB+skxG2HIAeFxHyzmWx0hqSz3KI6QIsixTU/oSyfpWnV+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TqwiDsSl; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f82478b70so9783839f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722015163; x=1722619963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4GinbwCPpupZoTNERMGOO+CrpcJ/xxlN9pDIVPEVvg=;
        b=TqwiDsSlxmH0txvSaWHWJOkHSM4D+3xUOftZRUZVCpH/lXyGx5TwNHR7+XAfM4tg6t
         FxqfXp+62k8AuKXQjNz86BiFzbnhzDaO1iifmlAAgxr1Ef8yTfWLuOlbBzCOa3asDWXf
         r8WS1/G6awfnmx0bBDR19vyv2psBnELROmW60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015163; x=1722619963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4GinbwCPpupZoTNERMGOO+CrpcJ/xxlN9pDIVPEVvg=;
        b=LB5VKaxkCE6lGh4nbWPCyL6Ic+9SbrfbGO9beWUEMOy4/imhdwqeqhgNSD6LDUNlG4
         2yNkasd9mD/ic+l21pkt1B+1fGn8lYiYbEkb4QnQLIBBe6pJg07pdT31tXRQOEYHvDo/
         HEeo5ffZEvnGEoqj+DZljQCi/YYKEK6EtlbzsAc0oZiGyXeWhulO8Wgs8HZEFzCv88K9
         eYTdR1rRxOxv6gZffaFEGHyobpOOSomoNTRqxRVL2dO3yY90DYKwZ0q9TTODOex0G/8Y
         iog0nNGyrcI1LUFA00vp5eE+qszLzD7AnZDpauDZG+0IaqDCZCWEGE0ueFZjjWTU+P1S
         m4hg==
X-Forwarded-Encrypted: i=1; AJvYcCXXKENanshpSos04Y1JWGNaCTmyIg7qJY8GPeMdz2DBAtRB8p/uFxrQDhvDaV4+K/YRg/rNBxh4Lri33x5JgsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZaHc4YVrZlMt+jEqZqnmJWPqFNrKWtOUMy7SowKZ31vOdWS3
	wOCEBj+gRXEStQdJN5+cV9HpA5LsWL4REQ35cXx9oZTjjeXs1lJb5pRxbmm2REw=
X-Google-Smtp-Source: AGHT+IHbRT3iZRW+Jej5kqYMWBksmgKgeIxN4ONjndWGY3FhrB7Ej8wWWEhyyeycHxTk96AcFxZGNg==
X-Received: by 2002:a5e:8342:0:b0:81f:8f3a:5689 with SMTP id ca18e2360f4ac-81f8f3a5894mr144339139f.0.1722015163088;
        Fri, 26 Jul 2024 10:32:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d7fee0csm118731839f.43.2024.07.26.10.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:32:42 -0700 (PDT)
Message-ID: <3e3d94d5-2a7f-4c05-b4ce-c6c8ca4e1186@linuxfoundation.org>
Date: Fri, 26 Jul 2024 11:32:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tools/testing:Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, zhang.lyra@gmail.com
Cc: shuah@kernel.org, kees@kernel.org, luto@amacapital.net, wad@chromium.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240726023241.17295-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240726023241.17295-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 20:32, Zhu Jun wrote:
> The format specifier in fprintf is "%u", that "%u" should use
> unsigned int type instead.the problem is discovered by reading code.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   v1->v2:
>   	modify commit info add how to find the problem in the log
>   v2->v3:
>   	Seems this can use macro WTERMSIG like those above usage, rather than
>   	changing the print format.
>   v3->v4:
>   	Now the commit summary doesn't match the change you are making.
> 	 Also WTERMSIG() is incorrect for this conditional code path.
> 	 See comments below in the code path.
> 
> 	 I would leave the v2 code intact. How are you testing this change?
> 	 Please include the details in the change log.

I am asking you to send the v2 change with updated change log
to show how this change is tested.

> v4->v5:
> 	Compile the kernel for testing using make

Running make isn't sufficient - please verify running the tests
making sure there are no regressions. Since you are changing the
harness, you want to make sure this change You are changing the
harness.

> 
> 
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index e05ac8261046..675b8f43e148 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -910,7 +910,7 @@ void __wait_for_test(struct __test_metadata *t)
>   		.sa_flags = SA_SIGINFO,
>   	};
>   	struct sigaction saved_action;
> -	int status;
> +	unsigned int status;

I am asking you to send the v2 change with updated change log
to show how this change is tested.
		fprintf(TH_LOG_STREAM,
-			"# %s: Test ended in some other way [%u]\n",
+			"# %s: Test ended in some other way [%d]\n",
  			t->name,

%d makes sense here in this message.

thanks,
-- Shuah

