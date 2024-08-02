Return-Path: <linux-kselftest+bounces-14750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FCC946616
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 01:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8064F282CC9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 23:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FF013A402;
	Fri,  2 Aug 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N60NviUs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC11ABEB5
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Aug 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722640256; cv=none; b=jaIKfACnnc89mYZKRPyhyzJvPPsTVSY3AuL5jVyi0cqhgE1+SjDWq/AgKpcUThhprUqT87gpxTsGDLeATz75eYU3vIorhp9WRrmx5gKPF/mhA3DJCdNg/U8UNk9FRPNfl1DnlmwKubgyOJrtpPGvkaeNcEYNdHTOUg22EnTOEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722640256; c=relaxed/simple;
	bh=ZvkTx1+EBn2AL2301uxOLcdHVVDBq23matLKcxBKGyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njVh5/g7wBqkDCQYRJQoP5fJzX07ohGuMUhQpPAZ0I0fMdF8dcAfeuDpvS6z64i/6fIVXFzDXoBdx0G9UhByFx92R+f2FIfHJ+7EWY2JuQPV7P8vdtxW2sY0j7LjdMwdte0j49Xv0DdOIZSpWTqPATfLb60NRkyL8EDrqt6su80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N60NviUs; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-812796ac793so39943039f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2024 16:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722640254; x=1723245054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRFKf5qzMHoSED0gCD78PwbVthWaoZnGQl+PAi2Z4zs=;
        b=N60NviUs5AbPt/3Nn7TbKBb73MPa7PMXJmJohzLmrKci8z/IwKJHLBiaWN0cThze2o
         Zh/QZJDkw50J6BqK22knH78AqL8FqTC7lGwU7sL4ke5s+AYUJ/GTt6E3cbRDaUIhVzdc
         iJobSfknx9JtLeaFsI8mnWtn1SDUvU5O8EHiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722640254; x=1723245054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRFKf5qzMHoSED0gCD78PwbVthWaoZnGQl+PAi2Z4zs=;
        b=CCuA+zpLK7vlEiK6lA4WURZZw5eAEMAFFeI4XS+ww80DkQlqigRYBCFXeWX9i1h86E
         jKgZN26Ax+zhiVJVzXUSEGUx7XAw83GzOxuHXivluwX/FzMeKatrT4LAJWymv6lYNdkL
         l9iCyTtVC2vVWy/ehi8EVQT+qo/uvWas0nqbnKtSao0eOq0nXcxtifh2/6JPsPJf+RA9
         l7TDZ3oic+4ueNS9SEGfTMn5czr0L6QomEDXSrsQVOAmHuSCShy71C6pAd8zgRcuKHDW
         +2lTTfTi9CKVlY0veseT2is1riCsJ/WlwVuYxd8uwXji3AbIm9mdH60N9rEcLe9Wegp6
         cKPw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Euvf0PJj169LSElAxGcn84zWTs0RL/BU5T5XV3823AZwQ+V+IoVTyTyvrSaaDSYoKrctvcJi4cGOIwyBsHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVcSxP5+t9t65hupalSPaPMC8BCnvJ58iGEbiLJ/ssvCrBsBy
	SrzHk/pwVW4rJElgkfxqF/lzGAlLjkWmLx4S9qPCXurYFvcmT5zUXNtBJ32YEzI=
X-Google-Smtp-Source: AGHT+IG4YhnBxlvfM+Pna3a9JI1Fz26gLKM+Cn6KxC4Yo5lYYUsISZwDwAKQgOqUHuJvzNOfvc3RGw==
X-Received: by 2002:a6b:7c4c:0:b0:81f:8f3a:5689 with SMTP id ca18e2360f4ac-81fd42bcd22mr362897339f.0.1722640253702;
        Fri, 02 Aug 2024 16:10:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a2733bsm665167173.101.2024.08.02.16.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 16:10:53 -0700 (PDT)
Message-ID: <6180198e-5086-40a2-bd0a-305009342020@linuxfoundation.org>
Date: Fri, 2 Aug 2024 17:10:52 -0600
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
 <f560819b-3a3c-4999-ad63-422ca31e9b08@linuxfoundation.org>
 <ff70e502-c3c8-4046-9447-5eff56028c9d@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ff70e502-c3c8-4046-9447-5eff56028c9d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/24 23:38, Muhammad Usama Anjum wrote:
> On 8/1/24 9:27 PM, Shuah Khan wrote:
>> On 8/1/24 02:42, Muhammad Usama Anjum wrote:
>>> On 7/31/24 9:57 PM, Shuah Khan wrote:
>>>> On 7/31/24 07:39, Muhammad Usama Anjum wrote:
>>>>> Don't print that 88 sub-tests are going to be executed, but then skip.
>>>>> This is against TAP compliance. Instead check pre-requisites first
>>>>> before printing total number of tests.
>>>>
>>>> Does TAP clearly mention this?
>>> Yes from https://testanything.org/tap-version-13-specification.html
>>>
>>> Skipping everything
>>> This listing shows that the entire listing is a skip. No tests were run.
>>>
>>> TAP version 13
>>> 1..0 # skip because English-to-French translator isn't installed
>>
>> I don't see how this is applicable to the current scenario. The user
>> needs to have root privilege to run the test.
>>
>> It is important to mention how many tests could have been run.
>> As mentioned before, this information is important for users and testers.
>>
>> I would like to see this information in the output.
>>
>>>
>>> We can see above that we need to print 1..0 and skip without printing the
>>> total number of tests to be executed as they are going to be skipped.
>>>
>>>>
>>>>>
>>>>> Old non-tap compliant output:
>>>>>      TAP version 13
>>>>>      1..88
>>>>>      ok 2 # SKIP all tests require euid == 0
>>>>>      # Planned tests != run tests (88 != 1)>>>     # Totals: pass:0
>>>>> fail:0 xfail:0 xpass:0 skip:1 error:0
>>>>>
>>>>> New and correct output:
>>>>>      TAP version 13
>>>>>      1..0 # SKIP all tests require euid == 0
>>>>
>>>> The problem is that this new output doesn't show how many tests
>>>> are in this test suite that could be run.
>>>>
>>>> I am not use if this is better for communicating coverage information
>>>> even if meets the TAP compliance.
>>> I think the number of tests represents the number of planned tests. If we
>>> don't plan to run X number of tests, we shouldn't print it.
>>
>> 88 tests are planned to be run except for the fact the first check
>> failed.
>>
>> Planned tests could not be run because of user privileges. So these
>> tests are all skips because of unmet dependencies.
> Agreed.
> 
>>
>> So the a good report would show that 88 tests could have been run. You
>> can meet the specification and still make it work for us. When we
>> adapt TAP 13 we didn't require 100% compliance.
>>
>> There are cases where you can comply and still provide how many test
>> could be run.
>>
>> I think you are applying the spec strictly thereby removing useful
>> information from the report.
>>
>> Can you tell me what would fail because of this "non-compliance"?
> Some months ago, someone had reported for one of my test that it says it is
> going to execute X number of tests. But then it just skips saying it
> couldn't run X tests and final footer of tests also didn't had the correct
> number of tests in it.
> 
>> TAP version 13
>> 1..88
> This gives information that 88 tests are going to be executed.
>> ok 2 # SKIP all tests require euid == 0

I agree this should be 1 if we ran just one test.

> Why not ok 1 here?
>> # Planned tests != run tests (88 != 1)
> This gives a error occured signal instead of telling us that preconditions
> failed.

This is correct. We report skip and don't fail when dependencies aren't
met. If we did that it would be reporting false failures since tests
couldn't run tests.

I have asked Laura to see if we can add a message to tell the user
that we couldn't run tests that could have run so they can look at the
config and make changes as needed to increase coverage of testing.

>> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

This is correct - it shows 1 skip and rest are zero.

> The tests exit with KSFT_FAIL instead of KSFT_SKIP. This was the biggest
> concern from the report.
> 

Exiting with KSFT_FAIL is the real problem that needs to be fixed.
Please take a look to see why this is and send me the fix.

thanks,
-- Shuah

