Return-Path: <linux-kselftest+bounces-21272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70C29B8949
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 03:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D6428216B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 02:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49561369AE;
	Fri,  1 Nov 2024 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZK/EOftj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69046132106
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427965; cv=none; b=LjFRKndeGz0kAbD1g32iRmYUUe1zvik8JnUCF0c88JwyZrQWVdv7YxUurDNGblR36/2BIGpFJeQ++yadWSR7ylHC8Qa/mC5FFGZXNi/QvmaQcpVWlNTu2gwhg53/DPZRqyzPCk6ZbozhK5zbGEMZ0NcoMruzcyCdwTMpNnfHllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427965; c=relaxed/simple;
	bh=isrbn6EYcEzs5iUMEs7MLuxGYggTLZ3mlD/ARBA2Q60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWz4cEw/flaf946K2VKLx6hSRwR6zJQsKN+YvYrHW5LgHgTvsPBcls6ru9KDG0NmlUzLW6KLWZka6R6+je7S8O4BRr9csg/baZpQxCV9llc7QWZCJoKNlP18apTzIpcj+es53bDlgT5UTY4+kiJKHQLcT5UHrlgp1E/5WmxYIOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZK/EOftj; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83aacecc8efso78537639f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 19:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730427958; x=1731032758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9PP5OUZKSxt9w/+Lhs2fVip8LzoowBW6uYRcN2k+fA=;
        b=ZK/EOftjLdP0p7a8j5qImyPxRJjj54iBvp/cg4e4SRCILjTZ0iJOXIns48CnUpfIqQ
         fcro5bwBgUf1jWsC6fxA14rUpMvfKltdOWmNJ3Tf9jRpsUQdSMZbm7Bx1BbP2ruhv1I/
         HsVwli48bhnbb55dgyESGnp2Eky5Pi7NOCma0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730427958; x=1731032758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9PP5OUZKSxt9w/+Lhs2fVip8LzoowBW6uYRcN2k+fA=;
        b=E0YLc9EeRd1wdx2nscAKmxgpXSvVzanD28hR2F/soMksgoRJeUbBnInANArtH2Zq2k
         5adAx6b6zLheiKGLsMsoh577CfEAHopVt77X6f0DPuDH2wQh1P5MPXnGRwx8tItWxlV9
         pe4aMb8oXF43jsqZG5w2WlTD3NKlF1g8LlD9DFQOg2yY9fucc0JlVNGwbboPIpFkEzZe
         eTluXr5fp64iVKjA7YmOw3gGsF8icelrGtLpEKsvh7X3ZLFTT6aFxqhQLLd0jIJmP6xe
         EkIBbaqa2clV2hzx5rbM4wve5vu2p8GcCPRbS4v+dO7EkTGmePYKpWw5tIp8m9Y4lPPe
         YbKA==
X-Forwarded-Encrypted: i=1; AJvYcCWfN+46EculIcXOukCMa916oTUliJCDoVdy54vfNV2V4mcbJyuzrEtjDBJAiPjIPlD0miS3KcLmyBOVBLeYap4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcm6Ot8U4qpv9IUTYqYjUKpMXr/ZDgxZIbwWOns/dJFyDv7Tnf
	BBpaEHfq5+5x9PhyypryqhAL78J5EnfMB/xgKlq/kg4DxzkZMYzujC7dibnOoGo=
X-Google-Smtp-Source: AGHT+IGbzrRisQU8oq/lZylfKAV7nYtIg3h5+eZKf3TwSBnm5JaztVcEX6HAUF2Byk6mTF3PQf2MpA==
X-Received: by 2002:a05:6602:3355:b0:83a:ab58:a84d with SMTP id ca18e2360f4ac-83b71370717mr147537439f.8.1730427958408;
        Thu, 31 Oct 2024 19:25:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de04978461sm546663173.107.2024.10.31.19.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 19:25:57 -0700 (PDT)
Message-ID: <388a8b6c-1acf-413c-bbf4-3b23156117f8@linuxfoundation.org>
Date: Thu, 31 Oct 2024 20:25:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/math: Add int_sqrt test suite
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 ricardo@marliere.net, linux-kernel-mentees@lists.linuxfoundation.org,
 andriy.shevchenko@linux.intel.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20241030134355.14294-1-luis.hernandez093@gmail.com>
 <c213dbcb-35de-4afd-9d4b-f42f6a9e3de6@linuxfoundation.org>
 <20241031173941.3487ccbfd7421d81d9b0cb97@linux-foundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241031173941.3487ccbfd7421d81d9b0cb97@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/24 18:39, Andrew Morton wrote:
> On Thu, 31 Oct 2024 11:50:16 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 10/30/24 07:43, Luis Felipe Hernandez wrote:
>>> Adds test suite for integer based square root function.
>>>
>>> The test suite is designed to verify the correctness of the int_sqrt()
>>> math library function.
>>>
>>> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
>>> ---
>>> Changes in v2
>>>     - Add new line at the end of int_sqrt_kunit.c
>>>     - Add explicit header includes for MODULE_* macros, strscpy, and ULONG_MAX
>>>
>>> Changes in v3
>>>     - Remove unnecesary new line after Kconfig entry for INT_SQRT_KUNIT_TEST
>>>     - Correct int_sqrt instances with int_sqrt() in commit message and kconfig
>>> entry desc
>>>     - Fix limits.h header include path
>>
>> Adding Andrew to the thread.
> 
> Thanks.
> 
>> I think this depends on the other lib kunit
>> content that is already in next.
> 
> Actually the patch applies cleanly to 6.12-rc5.
> 
>>> --- a/lib/math/Makefile
>>> +++ b/lib/math/Makefile
>>> @@ -9,3 +9,4 @@ obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
>>>    obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
>>>    obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
>>>    obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
>>> +obj-y  += tests/
> 
> What's this change about?  It seems somewhat unrelated to adding a
> single test.  I mean, there's an unrelated test listed in
> lib/math/tests/Makefile so what change does this patch have upon that
> one?
> 

I think this is a new test. I can take this for 6.13-rc1

I thought the conflicts might persist in case you have any 6.13 material
already in linux-next. Doesn't look like it if you could apply to 6.12-rc5

Sorry for the confusion.  I can take this for 6.13-rc1

thanks,
-- Shuah

