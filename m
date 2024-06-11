Return-Path: <linux-kselftest+bounces-11701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ABB9045BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 22:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069C1B2169B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 20:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959D082490;
	Tue, 11 Jun 2024 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KXdwrwqc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0254A150992
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137676; cv=none; b=vE4J7kFNBeVc0jXCMBYYa+lHTolVznNLdaLCpTZzg/TiPj9m2Q4BGs+Y2PtVjFquEQAWp9/az1alBauf47INxdDEHUq4Re5+wFBXv1WEN+iVl9M276axtH2e7gRnYyxmupsgFdpIOHboK2QY5MtDFOjo1cZ8y81FS7xzZ6pfgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137676; c=relaxed/simple;
	bh=ugUCm9Yr68u8EX9EKbsRWgLfIOOy1JUUSq6pq9fS/gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckE8N6QThbS9L1h9RyAStoM8jY2Bw/AsWM846vnGTXYiqzreAumgoJSgeMXHQeuuE71ZZQrJdrfbGSTXS+juQSQQmqXgWe14IIRG6U5YK8Sfjvq+HVWqdiRzxHqwXRND74pmfEv5kjFb4GsROhP58D5cpR2eGSKksEsla4hiOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KXdwrwqc; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfb38841f83so302729276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718137674; x=1718742474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=th6eKAq/LATBnFfZ8l1OQ1G8HtkktsMhv2cX9FNr94k=;
        b=KXdwrwqcCk5M6iChGThNz+ZKUxbkCpNfhpt17o6xLSYtIVnfdMW0SmceNSwOmSeFI1
         a1F48Q1Rqa6qvDfCyeJ4oLySMBN5LyIaRs5B5jsIQF3SYuU636z5E5tMUIBXuTW/c9oG
         pA/jpipkotPZcy5RcG3cOukp//cCtHuzaiFEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718137674; x=1718742474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=th6eKAq/LATBnFfZ8l1OQ1G8HtkktsMhv2cX9FNr94k=;
        b=vBkmqjMutVcSFRT4x6oHAF6KK5r5JVOLDC2b7TKX1cSfYYBYje5dNLn/qiqZoXw/VQ
         9fifzzJWbxvS/JfZ+VbQJ2X2w2vb22VVPlFQF8V3zXcAQ0iVFcT2u8cLXLGPPpywHwIB
         Kx4KIcDGExiTq/2hLxBp7nzE/xW5Wex5LZaUlKPf+1O2/lwNjdpcSnV4FgiyKp466hZ9
         pxnaNpZJaGaPD86lhsuc5uxvYAaQYxieKVZi1LKkJV9zHEMjiXIHXQexms5FgsX2ot3v
         dqcRZ0bYrQ1xenLZr26Y9+68TlT8puFG0hTkMjM+KBrPAeI4Wjqiv+G9AZU9sVBnF+xv
         GO+w==
X-Forwarded-Encrypted: i=1; AJvYcCVSExWlNAPFsB6JYF64QWUcFEkyEWR2u6Czzpvugtn+b1YlTNoukRUNq/K6r186caxI3/W50SrN2LIEHN662GzeP26iX2/JWfQnXMB10EME
X-Gm-Message-State: AOJu0YwJOPSJpt8jDYkJX0OUIzhVgoa2V1DwmTDUiPspGQwBZDb9QEBs
	80hpjwi7H6UVmNEyrRmkNGZq78pAGuOvynJIqSBT8SstC9jkWBkkDvtHnapUL10=
X-Google-Smtp-Source: AGHT+IGTW02Hlw4hL7bwC4c8R5pzfb1VoGT9mdqeIkhRdG7AQbO2+vTAHG0mI8vT422bk0QHPx7l6w==
X-Received: by 2002:a05:6902:b27:b0:dfa:6f65:f068 with SMTP id 3f1490d57ef6-dfaf64befe7mr10269563276.2.1718137673572;
        Tue, 11 Jun 2024 13:27:53 -0700 (PDT)
Received: from [172.20.14.19] (ool-6c3a3e1d.static.optonline.net. [108.58.62.29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06cd275b7sm38092216d6.62.2024.06.11.13.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:27:53 -0700 (PDT)
Message-ID: <1f46ef8d-2435-4c73-88b0-f954d685d1a9@linuxfoundation.org>
Date: Tue, 11 Jun 2024 14:27:52 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Add information about TAP conformance in tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240610083245.1938001-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240610083245.1938001-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 02:32, Muhammad Usama Anjum wrote:
> Although "TAP" word is being used already in documentation, but it hasn't
> been defined in informative way for developers that how to write TAP
> conformant tests and what are the benefits. Write a short brief about it.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   Documentation/dev-tools/kselftest.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index dcf634e411bd9..b579f491f3e97 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -228,6 +228,14 @@ In general, the rules for selftests are
>    * Don't cause the top-level "make run_tests" to fail if your feature is
>      unconfigured.
>   
> + * The output of tests must conform to the TAP standard to ensure high
> +   testing quality and to capture failures/errors with specific details.
> +   The kselftest.h and kselftest_harness.h headers provide wrappers for
> +   outputting test results such as pass, fail, or skip etc. These wrappers
> +   should be used instead of reinventing the wheel or using raw printf and

When there are multiple tests supported by a test suite, it doesn't
make sense to convert every single print statement. That is the reason
why we have the run_tests wrapper that prints the summary in TAP format.

I would rephrase this to say "should be used for pass, fail, exit, and
skip messages".

This rule is applicable to only the tests that are in the selftests Makefile
and included in the default run.

There is no need to convert every single print statement in tests.

> +   exit statements. CI systems can easily parse TAP output messages to
> +   detect test failures.

I would rather see people spending energy writing new tests and fixing
warnings. TAP conversions need to be focused if they add value.

thanks,
-- Shuah

