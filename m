Return-Path: <linux-kselftest+bounces-9117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA78B6E28
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 11:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898161F21821
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 09:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0BC1C6887;
	Tue, 30 Apr 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu0vEhkq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B901C6610;
	Tue, 30 Apr 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468754; cv=none; b=F0D5hgjxiOHzkrUDTFEOnnG09/g3D1SxK++1Xza60WgncoeE3lpOv2/dFoN4xSwRTJD8FJdvdKWkpcj8d79CmF7IpyqYX2JzEGZCTBjgpFZL3f8qmAl2jsH9ojCFeVh1H6r71OMEH17R7f3wMkoxbAN3V2qSesNiZpEZHbCvdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468754; c=relaxed/simple;
	bh=/z+mRxU6Est9710HNvuKg2PnG93anRDHiJqsjiw+mGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EoQdQlCTNC7GvMu2k2JRRdY+Zeb9YtTwTlD3jVlu+A9sAp51IMjL4nmGBS5QGkvBB8oltZjb+IsqgGRolaTnIovqCBbN6XfBWp0F3QVaP+dNK81lSIjVO3MX82Mz0PqvzhoB2U33ID7RcJ6doTkJzKKVe1M/z4SGLtQiOHdET20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu0vEhkq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34ca50999cdso102242f8f.2;
        Tue, 30 Apr 2024 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714468751; x=1715073551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWakETl+FYs5RYNH/p5NgHwu54jBOwk7iRY/vYZSzjg=;
        b=mu0vEhkq2q1dEK0/iepAVH4jjZsKY0n+R/RbHSLpj8yFpERW9/xuFVGbls1bOorbaQ
         52zViJwy6I0jcZoIBAZqZvBJFn07mnC9ZsKiy6No+IwpDGQbRwIqLnoICqdS8Vw8ckuL
         cU1eeVHEI49Up4b9LU581U/NfGXd2jFNMQmAIa3xsSQ1qbR7rH/aQf1pEqvNV0B/fouO
         MtT2C4ZD67RT1ZdGFqg62g4HBDQNi/RD1wjJ4WbklFqvCDfrsR4EuQjnqqXIo7MHnw5M
         Ie/pwCUEiKlrzsg2ZuRSr5gdPbxMxImNVzTa2DjjW3kGk9gN+XMMjS7uBDB+6Q8tCV+p
         P4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468751; x=1715073551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWakETl+FYs5RYNH/p5NgHwu54jBOwk7iRY/vYZSzjg=;
        b=ssnF2e2rnyC7PqKYy194XQXgkMT3TAYMWGS7aY6/T4AD7hzQB6/bBBcR88sjJ8v1AW
         Oy7DPUwzjxK/yXTNMcEFqr9sVOPs3hgQlH9vhEhE5pLDOfsfePxNKxydxRY9k6y5j+jR
         kCqPP/d23GxnKWqV5QElf+vVjZAR/KSFzuW2k6NNdkEesYI82rscG5slCtDIv49gJjBf
         c/J6sstqjS1xpfne/r7GpS8L0az192gUR0VRECETlO2c9TqvFsJBRckg9ngpiH8EaPvz
         81HGhIqbcuM87pTLZTR9AjeNQyQM9pzQpf1Z2SGJQOez7+GIpoOt4BzTo1xoUFXW4nJN
         ElhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKElZnkDR5XkYKY9DSf/uzMB8uVrkZDg2Xs2cd+ja9+PK+4+3y0d0xKEinQZyBl6ZFauYgg1G05ZTAaQatHnbTVo3KCtfRj1yKtHTZ3Wcxj4d/tg8xKG6KGb98PuxlmpF1A/umnZGA6AETjnLd
X-Gm-Message-State: AOJu0YyAlp0nUwlSQMMW/hvix0/Yl8shtZY2wQDi6lXFizQMFWWebSAk
	jQdEp4npRf9u8NtL6oec9OmNLCis+/cvI97ajxe9+JfCL3wrHPgM
X-Google-Smtp-Source: AGHT+IEV9k0pcRpO3mYSIc4fMj1G+2ynNMf8CD16YyeCi/RMwSYzTwQzOGS8Ga/4CKrd6M9gA3CwlA==
X-Received: by 2002:a5d:5f52:0:b0:34a:a754:eb51 with SMTP id cm18-20020a5d5f52000000b0034aa754eb51mr10007641wrb.3.1714468750866;
        Tue, 30 Apr 2024 02:19:10 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:49bb:25f0:d018:54ae? ([2a01:4b00:d20e:7300:49bb:25f0:d018:54ae])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d5551000000b0034c5e61ee82sm10513637wrw.67.2024.04.30.02.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 02:19:10 -0700 (PDT)
Message-ID: <fd27b640-f807-4636-bb31-1865a1f1f775@gmail.com>
Date: Tue, 30 Apr 2024 10:19:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: Cover 'assert.c' with tests
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240427220447.231475-1-ivan.orlov0322@gmail.com>
 <CA+GJov5Ve+NksNMXrd32p6RCPcSuf0oCZ-QA8LdhcvFWA48ukA@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CA+GJov5Ve+NksNMXrd32p6RCPcSuf0oCZ-QA8LdhcvFWA48ukA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/29/24 22:26, Rae Moar wrote:
> On Sat, Apr 27, 2024 at 6:04 PM Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>>
>> There are multiple assertion formatting functions in the `assert.c`
>> file, which are not covered with tests yet. Implement the KUnit test
>> for these functions.
>>
>> The test consists of 11 test cases for the following functions:
>>
>> 1) 'is_literal'
>> 2) 'is_str_literal'
>> 3) 'kunit_assert_prologue', test case for multiple assert types
>> 4) 'kunit_assert_print_msg'
>> 5) 'kunit_unary_assert_format'
>> 6) 'kunit_ptr_not_err_assert_format'
>> 7) 'kunit_binary_assert_format'
>> 8) 'kunit_binary_ptr_assert_format'
>> 9) 'kunit_binary_str_assert_format'
>> 10) 'kunit_assert_hexdump'
>> 11) 'kunit_mem_assert_format'
>>
>> The test aims at maximizing the branch coverage for the assertion
>> formatting functions. As you can see, it covers some of the static
>> helper functions as well, so we have to import the test source in the
>> `assert.c` file in order to be able to call and validate them.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Hello,
> 
> I'll give this a full review tomorrow. But with a quick glance and
> test, this is looking good to me.
> 
> Tested-by: Rae Moar <rmoar@google.com>
> 
> Thanks!
> -Rae

Hi Rae,

Thanks a lot for testing the patch.

Looking forward to seeing your review! :)

-- 
Kind regards,
Ivan Orlov


