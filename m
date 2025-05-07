Return-Path: <linux-kselftest+bounces-32609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC355AAED94
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 23:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5733A961E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E24728FAB2;
	Wed,  7 May 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fWa8zeS2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1236828F93B
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651980; cv=none; b=k1Wa7SiB6C1NMbCEfBpJS9cGvptZu1HjpxPKI5FQk2hHXJ8GxzR2E1rY2akRteqmpoOnPK7C3JKFcwifvBMQXX31VIQt/xwQpeQPy1ZRboDCdRQlr8K8SCNOiEdW9imDXtp2JWpdk8lWjuAUYR0kQXO8t0KC1nXLzDh0hQzw3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651980; c=relaxed/simple;
	bh=XtTsVAtq5Aa/qds/mZ03c/a2dVfCPxnBWxrBVfFn9qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sh2WEO9GFcQuthhKKdC4VNRqUKTKLdVQKYjvHUw4SPaJB+oCu2TQ06LUk/5d51dvYOxdT0xXIoDoDrB15lKqa+ymesFv6XxBwCrs65g2n5Lofc1GbcW/ZLG1WV8ysHxUEZIonuMTmYOpgHGdYfAON9kvwoK0ZN3Mmod0wNTy6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fWa8zeS2; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85e15dc8035so8017039f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 May 2025 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746651977; x=1747256777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gt0PzsH7dWP1Jv9XAe02KqpL+75JPfquQQIOm1GgXlY=;
        b=fWa8zeS2HzgeRMgxZn7qxzvcXL+ZMJp8IlbLWmKvLBt3IrpSPkEYY8iFfy+1D/jwzm
         ZxY2a/Xlq7O2DcsYFcRc+S35ONMzd+B3/3m5HQ/dIam5IlqnQNjI1KWOIvT1cEC5jMbm
         c+RVNH53YoPxQ45BP7CWP8i2po4P/I7i8+rRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746651977; x=1747256777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gt0PzsH7dWP1Jv9XAe02KqpL+75JPfquQQIOm1GgXlY=;
        b=n43i8iV/25rxWZ2hiwsoss0xhyzPF4wxC+EsqL57t2wuwOw7eo6lyZ9qkw6qd5Dfd/
         B/Q+EVjNg67+eUpwLyhECpvUHog6yPi8n9S8tBsM68XCRaxuowPyx6hYBYtp1dEDvlEq
         MfOWme5VniY6/Y4rgw2RIqBs/ua9iqGJdRustH7ZRCVRGGi0n1euyFtHrKGx69YBGA5Q
         rd1oIzt4VN18xrOz3s486M4YEen9UXBfZA8NByEaEgmJM3EjHxdHZCkfzPrXSDWdJC/y
         Dvsa/jz+6YRQ4oUrAO6lsRjw84s2keiTyQmmFUnGq/fnpp2aT+pIlJks1DXI3giL7UrM
         Sp2w==
X-Gm-Message-State: AOJu0Yzd/ptGzfaATS13myHXJGtWgOjanvioJmXeUyRdZ8f2KCW5FQ6L
	ESAa0JfjhDAKZ4kQWck3yP0CHF90eEv0GRYoPMAbw3KoAFM8pcLPc7kJnYQwg1c=
X-Gm-Gg: ASbGncuDdJfHpXprxLYFGnVUYv5XxkYq2DluXP0vuzlBUYJG+OqqsEiQ7zUwAlS5Z6a
	EXxWFue7sX41tfD8GCXyQs2UhXHnJyIeQwoJOY6fj4YUT+C7AvUa8p3NrfCTbf5zg/2aRNFaOiE
	zOytfuQwOIKJXJMSoFPDE+8zFgyZZ7DhYh21YkiT0DXQy0Ph8pjkr4+sNcxzpyBc0kmDchKLbgZ
	CLCb6+OEd+mmNEafhAzJeiJXLbPJ6Se8cPYu/lIhARAm4AsQI/isURMjIfA9RIyVrlgog3NgWcT
	fEVZ0Is2w9G8TwLXaY1Mt5U3KzYiwus0cM08k5wJfNEzDHvBhVM=
X-Google-Smtp-Source: AGHT+IHil6UBUd1d2VFVV3oLh2+dvDjnd7fFqJ7qiYmhGGigtFWjtbpZGojq+iOGKz2limwEmfyriw==
X-Received: by 2002:a05:6e02:1aae:b0:3d4:337f:121c with SMTP id e9e14a558f8ab-3da738f9f2cmr51404305ab.10.1746651977014;
        Wed, 07 May 2025 14:06:17 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa8e16dsm2886817173.114.2025.05.07.14.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 14:06:16 -0700 (PDT)
Message-ID: <5609c6de-e5cf-4f6d-8412-71149fae2580@linuxfoundation.org>
Date: Wed, 7 May 2025 15:06:16 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/timens: Print TAP headers
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, "Bird, Timothy" <Tim.Bird@sony.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
 <20250502-selftests-timens-fixes-v1-1-fb517c76f04d@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250502-selftests-timens-fixes-v1-1-fb517c76f04d@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/2/25 06:03, Thomas Weißschuh wrote:
> The TAP specification requires that the output begins with a header line.
> These headers lines are missing in the timens tests.
> 
> Print such a line.

There is no cover letter for this - so I will respond to the first
patch. The TAP information is added by the kselftest wrapper if
you were to run the test using ksefltest.

The following will add the TAP header or if you use make kselftest
command from the main Makefile.

make -C timens run_tests

cd timens; make run_tests (will also add TAP header)

The only time you won't see the TAP headers is when you run the test
from the test directory just as a command. Is this what you need
to do? I would rather not see TAP headers added to invidual tests
unless there is a good reason for it.

The problem with adding TAP headers is two-fold:

1. It becomes hard to read the ouptput if test is run using
    the framework a. make -C timens run_tests b. cd timens; make run_tests
2. These headers become bested and TAP doesn't like nested TAP headers.
    My undestansing is parses will have problems.

I am adding Tim Bird to the discussion.

Tim, is this still an issue? Are nested TAP headers still a problem.

Even if they aren't there is the issue of multiple TAP headers for
each test when we run the test using framework.

thanks,
-- Shuah

