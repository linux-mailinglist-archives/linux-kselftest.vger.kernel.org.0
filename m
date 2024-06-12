Return-Path: <linux-kselftest+bounces-11740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60583904CD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 09:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA4128839D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 07:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B816C448;
	Wed, 12 Jun 2024 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Se5AJ7CP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5716B722;
	Wed, 12 Jun 2024 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177199; cv=none; b=LuJKZRVtBiqJVuydRJAHpJVfQ4VsLREYLFWCSeSZwgyjJEbAowvUTWoFeqYCFWNwUcyYk5gw30Vi/7bKDdkzh/Vy9L9i6n3xlhMeyHbAFj7A+8+0F8EZN0N4DbQ9TJ8pXycU6TZ7tt0vTwXf6+SGICmOSIo7pqvjmNauIG0j9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177199; c=relaxed/simple;
	bh=b4lo+LBFixdiocWxssXvmnl9UIdewNdRMFT3TWu3BLs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZxuhwI8YySZej9vFZHScQRfXwERMOvye70caM+fUDRafUROzARa7N3N1ED05Jc7T3gShcATT7MQV8xP0P3bM3dTlFHfW/F2BdyDIbYAIcEvw2nda96z46p5VIEO23Y1/SnruYpMcPE3RUGyvt8t1ByRyQdaRJ+h5ZbM8AWYs2Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Se5AJ7CP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718177195;
	bh=b4lo+LBFixdiocWxssXvmnl9UIdewNdRMFT3TWu3BLs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Se5AJ7CPZ5+/Lhcy3LiOKtCTjrVAsFkIeHvikgidbCril8dSChOK3IIB1zXfhM1i8
	 82y9bMj2MWb27dEKNJ1Dog8KpI8wWwkzQr7bV8tz3dn5I2XO3bMhzBL8Drn3Rx2M0M
	 g/jVpPV+NIb8+qKoswoc/JWgZMP11GChsoMHK9hOoutKzED5SXTe6tAeG5kkI7VCdv
	 bjK4CjHum+6Dsc+9iGLo7b+dfqR3S3d2aWAEvmlccHJJR0DsJ5Ghm80HHMa5N9RDQv
	 jS0BRz3AHVDyQARY8K3mnZXlKZI9iUyBvFwSrd4gB1XFw7TqcR/Jt4iXHsB5PfqGYA
	 pS0UnnxsyB6Ug==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C16993781188;
	Wed, 12 Jun 2024 07:26:33 +0000 (UTC)
Message-ID: <7588c2a8-27c3-4b1c-bebd-9c3b099c8b80@collabora.com>
Date: Wed, 12 Jun 2024 12:27:10 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: Add information about TAP conformance in tests
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20240610083245.1938001-1-usama.anjum@collabora.com>
 <1f46ef8d-2435-4c73-88b0-f954d685d1a9@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <1f46ef8d-2435-4c73-88b0-f954d685d1a9@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/24 1:27 AM, Shuah Khan wrote:
> On 6/10/24 02:32, Muhammad Usama Anjum wrote:
>> Although "TAP" word is being used already in documentation, but it hasn't
>> been defined in informative way for developers that how to write TAP
>> conformant tests and what are the benefits. Write a short brief about it.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   Documentation/dev-tools/kselftest.rst | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/dev-tools/kselftest.rst
>> b/Documentation/dev-tools/kselftest.rst
>> index dcf634e411bd9..b579f491f3e97 100644
>> --- a/Documentation/dev-tools/kselftest.rst
>> +++ b/Documentation/dev-tools/kselftest.rst
>> @@ -228,6 +228,14 @@ In general, the rules for selftests are
>>    * Don't cause the top-level "make run_tests" to fail if your feature is
>>      unconfigured.
>>   + * The output of tests must conform to the TAP standard to ensure high
>> +   testing quality and to capture failures/errors with specific details.
>> +   The kselftest.h and kselftest_harness.h headers provide wrappers for
>> +   outputting test results such as pass, fail, or skip etc. These wrappers
>> +   should be used instead of reinventing the wheel or using raw printf and
> 
> When there are multiple tests supported by a test suite, it doesn't
> make sense to convert every single print statement. That is the reason
> why we have the run_tests wrapper that prints the summary in TAP format.
> 
> I would rephrase this to say "should be used for pass, fail, exit, and
> skip messages".
Makes sense. I'll update.

> 
> This rule is applicable to only the tests that are in the selftests Makefile
> and included in the default run.
> 
> There is no need to convert every single print statement in tests.
> 
>> +   exit statements. CI systems can easily parse TAP output messages to
>> +   detect test failures.
> 
> I would rather see people spending energy writing new tests and fixing
> warnings. TAP conversions need to be focused if they add value.
Some tests don't print pass/fail and just return status by exit value.
Adding pass/fail statements there really add value by exposing what went
wrong. So it can be reproduced in debug environment to fix it.

> 
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

