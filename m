Return-Path: <linux-kselftest+bounces-14665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC292945086
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 18:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C0D282B28
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6701B3F05;
	Thu,  1 Aug 2024 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BnG9jhG7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836613D89B
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Aug 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529627; cv=none; b=QhLU33JngWVx/jgCANs7UNr5EU/pP5gNxRtt64W7KpYz11zZ0Ea7AIYmO9NWGpIdFeRTihds7EfJ2YOR1bwAKGxAXs1hjOHqw0oXy4c/8Z2UyrwZYLIkk0SgB77fhtHMQVc9bGMo9VAcvzSJFYSu8bg672Nb94aWxNSdldqaLEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529627; c=relaxed/simple;
	bh=kmduuTslR1r6KFhm5dTaAgQsEJDGFeeYrbMrn4J3Cwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGKbCBRulRTROHBBaX9AAuNhAJo22oRV7l7EFbzvXzImxpIca2u/UofKNUpCHuE8JVWef4YzA3VFYppFZScBvYh66ACNud1Pn2ZC/s+mefAGbq7dcTrozLMEoZWe57empW4YkoPGJG95mVxg6TURja3Tn2xwKgy8haMxeFRm+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BnG9jhG7; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3748ec0cae2so2513565ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2024 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722529625; x=1723134425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bS7017cZll4e+874qKazOOkVgc5570pVdFAP9FpAJU=;
        b=BnG9jhG7h/4vbW8oZN5sxsVnuHRlzi+CY+30SpDDReU/x9ziSQxzrViYNZEy2XF8Ji
         DxLTHWsMIfzIxIE5Yh7JNifCBnSQV0zaL7BEheNhZ290L3xWM2Q7YvIIcxJPKJjUuVZD
         JmBSr2t/tVKGR9awBbh26MH4jEHj+Pxgt293E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529625; x=1723134425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bS7017cZll4e+874qKazOOkVgc5570pVdFAP9FpAJU=;
        b=XPQhUn9rD4L3ZPallEgjnb3isNUx71yQjyabl2ZkN07almRlv6a5oRk+t7bj2Q3mGj
         bm+qYRmV3gLjU7il98OIr+MW2I8uipNUy9N/irR0d9Gxug2no3AFXqC7f7Mw7V74+KDi
         FnIPnLjeGIXt90c35wAa6q3WcKJBmLp/jhdO7ChlDsQcWG1Le7DzimT+XbecZhHxhptV
         R2Bs14EXU3oUxsqAkfG5o3QwK/StZQ/SIC9Cd1Hfp9OKwkfVWSogHSzO0yfPOcuW1zUx
         q0u2jZjETYiwgOgsx+i3oy2/UsRuFnTArAZO6WVxSPgnAnAudFxEZ362lQf6FmYqoyf4
         eH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWncg102vn/Q+8iqcGrtudHTjlCk5o+Vrz20GWTBZkEd/mu6h6aAjcf3IGJmo20QqMkNWPchzd2JWmJ5Wi6ZxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTGB5u9xrC5QpAYDbVbzzw7OT+hrGaXrS9JLJfeXFd9lcbim6
	qCpU1mlA6Ju+hbNXVtRJJ+N3agrZJ6EvhY0nGj+CzX8ixtV6bCG6NyNu+apP5V4=
X-Google-Smtp-Source: AGHT+IGErCOry7BajNV/z4Zkr4yfnMJio63Sv6XY9m5JQ814Wk5TMigZr92WLgckQyZqxSB0fNMfFg==
X-Received: by 2002:a05:6e02:18ce:b0:381:c5f0:20d5 with SMTP id e9e14a558f8ab-39b1f772401mr5576285ab.0.1722529625303;
        Thu, 01 Aug 2024 09:27:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20ae3537sm103715ab.61.2024.08.01.09.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 09:27:04 -0700 (PDT)
Message-ID: <f560819b-3a3c-4999-ad63-422ca31e9b08@linuxfoundation.org>
Date: Thu, 1 Aug 2024 10:27:04 -0600
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
 <c1414d9d-61b1-4f92-bc8a-333679362283@linuxfoundation.org>
 <d30aa38c-5dbd-4c18-b20f-a6eb9e9e722b@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d30aa38c-5dbd-4c18-b20f-a6eb9e9e722b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/24 02:42, Muhammad Usama Anjum wrote:
> On 7/31/24 9:57 PM, Shuah Khan wrote:
>> On 7/31/24 07:39, Muhammad Usama Anjum wrote:
>>> Don't print that 88 sub-tests are going to be executed, but then skip.
>>> This is against TAP compliance. Instead check pre-requisites first
>>> before printing total number of tests.
>>
>> Does TAP clearly mention this?
> Yes from https://testanything.org/tap-version-13-specification.html
> 
> Skipping everything
> This listing shows that the entire listing is a skip. No tests were run.
> 
> TAP version 13
> 1..0 # skip because English-to-French translator isn't installed

I don't see how this is applicable to the current scenario. The user
needs to have root privilege to run the test.

It is important to mention how many tests could have been run.
As mentioned before, this information is important for users and testers.

I would like to see this information in the output.

> 
> We can see above that we need to print 1..0 and skip without printing the
> total number of tests to be executed as they are going to be skipped.
> 
>>
>>>
>>> Old non-tap compliant output:
>>>     TAP version 13
>>>     1..88
>>>     ok 2 # SKIP all tests require euid == 0
>>>     # Planned tests != run tests (88 != 1)>>>     # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>>>
>>> New and correct output:
>>>     TAP version 13
>>>     1..0 # SKIP all tests require euid == 0
>>
>> The problem is that this new output doesn't show how many tests
>> are in this test suite that could be run.
>>
>> I am not use if this is better for communicating coverage information
>> even if meets the TAP compliance.
> I think the number of tests represents the number of planned tests. If we
> don't plan to run X number of tests, we shouldn't print it.

88 tests are planned to be run except for the fact the first check
failed.

Planned tests could not be run because of user privileges. So these
tests are all skips because of unmet dependencies.

So the a good report would show that 88 tests could have been run. You
can meet the specification and still make it work for us. When we
adapt TAP 13 we didn't require 100% compliance.

There are cases where you can comply and still provide how many test
could be run.

I think you are applying the spec strictly thereby removing useful
information from the report.

Can you tell me what would fail because of this "non-compliance"?

thanks,
-- Shuah





