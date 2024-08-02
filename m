Return-Path: <linux-kselftest+bounces-14693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940549457AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 07:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65BC1C24452
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 05:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD94219E0;
	Fri,  2 Aug 2024 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HyBJWRbH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D74C61B;
	Fri,  2 Aug 2024 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577122; cv=none; b=WJ5E+D4XsqRVjVVkipH97+uq9i6ypameor1yLKVoFVSUAnoFEWMGoTBGDNcV+Xv8hv24Z7JFe9oHkrp8RMaVBpFkD57y+nE0kMG4FEyae0dOcJaIyjmkp5eC2Gw93s1vaKQieBemgBsUtcri8SQ/W5uNz4fSsAzL2vz78MsWE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577122; c=relaxed/simple;
	bh=tpiyqJZ1HFHzDigXKuAOzLKCNbVeUJkmfARaulC5BQA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mEHKdOizclVvQIAlGThKnQ6vmJP4nqhZl9+/W6kGK8Fl7eZPBeDBRLr9SftZ/i3RVeE208vbRcVN6IYesWgGYYq620XyQ+XGKUt+l9bKG8xM0xTgoDy0zoSctQhYJvjF6g8h6EBUYiqGGiKgiemrGZKNJohssXfPZjH1yyt5YQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HyBJWRbH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722577118;
	bh=tpiyqJZ1HFHzDigXKuAOzLKCNbVeUJkmfARaulC5BQA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HyBJWRbHhSm3ygzDfcFMJukkm9c9TL7jhx5Dtaz8K84QoMTORTkzne28zyOAuF7CW
	 GSuFqxDum87324JKCJU9HlOt3NvJhbCwTfa/KUgcx5vlvF5mmEs76s6uqEjsipG0FT
	 00y7QiFVyj95MsgTmx+Sqrt9s1Z+3bWo0dRqHEunj9++xt1lS7fxKrP5Gqh/O7oET3
	 Gcc19uI7gAcVXq+33UgKIQOuS/WdIdAJChkqe3sdXAOpDXuTUaTml5GyVfoI4m/hTf
	 yQJ2f6OSMEzMsJmdZX1KBG2lEwPewdyNWVYIBhj6RiFdTkHew4dIZGeltqX4EMC/BI
	 yucM37qgKjOUw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9013437821AD;
	Fri,  2 Aug 2024 05:38:35 +0000 (UTC)
Message-ID: <ff70e502-c3c8-4046-9447-5eff56028c9d@collabora.com>
Date: Fri, 2 Aug 2024 10:38:30 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Aleksa Sarai <cyphar@cyphar.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: openat2: don't print total number of tests
 and then skip
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240731133951.404933-1-usama.anjum@collabora.com>
 <c1414d9d-61b1-4f92-bc8a-333679362283@linuxfoundation.org>
 <d30aa38c-5dbd-4c18-b20f-a6eb9e9e722b@collabora.com>
 <f560819b-3a3c-4999-ad63-422ca31e9b08@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <f560819b-3a3c-4999-ad63-422ca31e9b08@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/1/24 9:27 PM, Shuah Khan wrote:
> On 8/1/24 02:42, Muhammad Usama Anjum wrote:
>> On 7/31/24 9:57 PM, Shuah Khan wrote:
>>> On 7/31/24 07:39, Muhammad Usama Anjum wrote:
>>>> Don't print that 88 sub-tests are going to be executed, but then skip.
>>>> This is against TAP compliance. Instead check pre-requisites first
>>>> before printing total number of tests.
>>>
>>> Does TAP clearly mention this?
>> Yes from https://testanything.org/tap-version-13-specification.html
>>
>> Skipping everything
>> This listing shows that the entire listing is a skip. No tests were run.
>>
>> TAP version 13
>> 1..0 # skip because English-to-French translator isn't installed
> 
> I don't see how this is applicable to the current scenario. The user
> needs to have root privilege to run the test.
> 
> It is important to mention how many tests could have been run.
> As mentioned before, this information is important for users and testers.
> 
> I would like to see this information in the output.
> 
>>
>> We can see above that we need to print 1..0 and skip without printing the
>> total number of tests to be executed as they are going to be skipped.
>>
>>>
>>>>
>>>> Old non-tap compliant output:
>>>>     TAP version 13
>>>>     1..88
>>>>     ok 2 # SKIP all tests require euid == 0
>>>>     # Planned tests != run tests (88 != 1)>>>     # Totals: pass:0
>>>> fail:0 xfail:0 xpass:0 skip:1 error:0
>>>>
>>>> New and correct output:
>>>>     TAP version 13
>>>>     1..0 # SKIP all tests require euid == 0
>>>
>>> The problem is that this new output doesn't show how many tests
>>> are in this test suite that could be run.
>>>
>>> I am not use if this is better for communicating coverage information
>>> even if meets the TAP compliance.
>> I think the number of tests represents the number of planned tests. If we
>> don't plan to run X number of tests, we shouldn't print it.
> 
> 88 tests are planned to be run except for the fact the first check
> failed.
> 
> Planned tests could not be run because of user privileges. So these
> tests are all skips because of unmet dependencies.
Agreed.

> 
> So the a good report would show that 88 tests could have been run. You
> can meet the specification and still make it work for us. When we
> adapt TAP 13 we didn't require 100% compliance.
> 
> There are cases where you can comply and still provide how many test
> could be run.
> 
> I think you are applying the spec strictly thereby removing useful
> information from the report.
> 
> Can you tell me what would fail because of this "non-compliance"?
Some months ago, someone had reported for one of my test that it says it is
going to execute X number of tests. But then it just skips saying it
couldn't run X tests and final footer of tests also didn't had the correct
number of tests in it.

> TAP version 13
> 1..88
This gives information that 88 tests are going to be executed.
> ok 2 # SKIP all tests require euid == 0
Why not ok 1 here?
> # Planned tests != run tests (88 != 1)
This gives a error occured signal instead of telling us that preconditions
failed.
> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
The tests exit with KSFT_FAIL instead of KSFT_SKIP. This was the biggest
concern from the report.

> 
> thanks,
> -- Shuah
> 
> 
> 
> 
> 

-- 
BR,
Muhammad Usama Anjum

