Return-Path: <linux-kselftest+bounces-12481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9631A912F2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 23:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D481C2129E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D517BB1C;
	Fri, 21 Jun 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PRUEOg8T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43516D4F5
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004097; cv=none; b=QYHesJ70iCdLimCo0jJwQ7Xw5GaPuMSD9bTTyee5D3WbVXI5KhpRY2G30b9C0p5z+G7TyG1WfOULRlqGW6W23QVsmIQiHowi1lyZ/e7Y6dbVXoKrubpoX+hNP5ZL1w1obsQLnPcKVpj9sTuSNIq2iT0tXv/N8GR2Cv4QDrNCIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004097; c=relaxed/simple;
	bh=JMumdYRe5MqCT2MZZGLF5vsCmC4GIKkDyx93oynQhIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtQ3wtjOz+RcIVHnDSeOtg8/J9ggipS78rDv380H3VCy/EkO+vlIt4/SdYpGAu81Ht+c3LJBPQTVaQhUWu4MfsdQEf4TIIwybvIvlEQcjhmcLBeUixJUsCJ9GSkbrF5DIosKmPqTu/f8SealgTdhu2w4KnMsRdXMMJLnYZjOIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PRUEOg8T; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eedf4ae265so8150439f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719004095; x=1719608895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mQ4vgZOJ5q2WQyLMW2uXNqE6ehOvxlLcHgZfu8PLV0=;
        b=PRUEOg8TD7SVIqnqrtVWzFOZaMrAZ7PcBBS3TVTpkSj9KENjPXaskiKb4zIdog2WhF
         vCag65wq1thTMfrzIMYsRQkwiuPUMmFEJhMT2R7HO5l47v52AHZjq7jAFzha1K+RM1WY
         kTEkGahnBfRG5nzkHd42keLW2As8c4HeE48FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004095; x=1719608895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mQ4vgZOJ5q2WQyLMW2uXNqE6ehOvxlLcHgZfu8PLV0=;
        b=By9dWNgWKpCrwx5uaprbV8RrM5H3/E8bi3VwqllsPDva09y+x5bPQnd1YCL71gKPLw
         OiVdAKYLkHcL/juUOe8oDhiXE0avGr5baUPcdoGsk6FCXQgdcDpNuhYaStxqPX/MYv/h
         lsm+HJK1pJWpPg0wTDPcFnP0LCuqhn2SYRGCjWAnOa62kXg1BG5NMqufnLHM6o4+pkyF
         VPm7tPNrCxvi5EwMBvEwjo1jDh2uws1UUj1s0VR81ylHS6zBpqYqFJUYk27XecX5yf2K
         jLbwFlO0TQjTDcMwbLPsF34/W+TNnY5XBnto2KV+NGlW7iaynpG08P7W5tZANkLXc8DU
         bkbw==
X-Forwarded-Encrypted: i=1; AJvYcCWLuueosZ1cfAx90kmb3xsbZ7eh4QypdonAol0eXPltdYKqdDGs9u6D45qVp/rmnr/pDYPiByj8n94LuLSPIUyFzlRNro+wA9aa8ooYrd9P
X-Gm-Message-State: AOJu0YyI/vmBpK07BnK8FBSbPcyT1iDc7eONdTmBx0tguJ/M0rbpYiww
	KN3TMkcA9wpW/m8nVuEtIRmHyMAz1LNMz3Bp9bHq0jFiNFMXLEOxntt3lj1o/QH7dN7KdJ3S0Ha
	a
X-Google-Smtp-Source: AGHT+IHly2iPKMFKgisvWqYeE2koY0dLBp9TIDSB3KVQRHKkiTjk0qPc06yABSkvNb8yIKWt11V3aw==
X-Received: by 2002:a05:6602:1b96:b0:7f3:9cc0:30a9 with SMTP id ca18e2360f4ac-7f39cc030fdmr25219339f.2.1719004095264;
        Fri, 21 Jun 2024 14:08:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d10cfb26sm548268173.30.2024.06.21.14.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 14:08:14 -0700 (PDT)
Message-ID: <76a6a3d1-bbf7-436a-a977-4e5c49db69ac@linuxfoundation.org>
Date: Fri, 21 Jun 2024 15:08:14 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Modify the watchdog selftest for execution with
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <987ba13d-e645-496a-8ec8-91b6399efa4c@linuxfoundation.org>
 <20240618134038.54803-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240618134038.54803-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 07:40, Laura Nao wrote:
> Hi Shuah,
> 
> On 6/7/24 23:07, Shuah Khan wrote:
>> On 6/7/24 03:53, Laura Nao wrote:
>>> Hi Shuah,
>>>
>>> On 6/7/24 01:03, Shuah Khan wrote:
>>>> On 6/6/24 03:57, Laura Nao wrote:
>>>>> Hi Shuah,
>>>>>
>>>>> On 5/6/24 13:13, Laura Nao wrote:
>>>>>> The watchdog selftest script supports various parameters for testing
>>>>>> different IOCTLs. The watchdog ping functionality is validated by
>>>>>> starting
>>>>>> a loop where the watchdog device is periodically pet, which can only
>>>>>> be
>>>>>> stopped by the user interrupting the script.
>>>>>>
>>>>>> This results in a timeout when running this test using the kselftest
>>>>>> runner
>>>>>> with no non-oneshot parameters (or no parameters at all):
>>>>
>>>>
>>>> Sorry for the delay on this.
>>>>
>>>> This test isn't include in the default kselftest run? How are you
>>>> running this?
>>>>
>>>
>>> The goal of this series is to enable the test to be run using the
>>> kselftest runner individually, not as part of the default run. So for
>>> example w/out args:
>>>
>>> make -C tools/testing/selftests TARGETS=watchdog run_tests
>>>
>>> or with args:
>>>
>>> KSELFTEST_WATCHDOG_TEST_ARGS='-b -d -e -s -t 12 -T 3 -n 7 -N -L' make -C
>>> tools/testing/selftests TARGETS=watchdog run_tests
>>>>>>
>>>>>>      TAP version 13
>>>>>>      1..1
>>>>>>      # timeout set to 45
>>>>>>      # selftests: watchdog: watchdog-test
>>>>>>      # Watchdog Ticking Away!
>>>>>>      # .............................................#
>>>>>>      not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds
>>>>>>
>>>>>> To address this issue, the first patch in this series limits the
>>>>>> loop
>>>>>> to 5
>>>>>> iterations by default and adds support for a new '-c' option to
>>>>>> customize
>>>>>> the number of pings as required.
>>>>>>
>>>>>> The second patch conforms the test output to the KTAP format.
>>>>>>
>>>>>
>>>>> Gentle ping - any thoughts on this series? It would simplify running
>>>>> the
>>>>> watchdog kselftest in CI environments by leveraging the runner.
>>>>>
>>>>
>>>> This test isn't intended to be included in the default run. It
>>>> requires
>>>> loading a watchdog driver first. Do you load the driver from the
>>>> runner?
>>>>
>>>
>>> I get this test requires watchdog drivers to be loaded (which in this
>>> case can't be added to a config fragment that goes with the selftest, as
>>> they are platform-specific) and therefore cannot be included in the
>>> default run. However, having ktap output support and limiting the ping
>>> loop would allow the test to be run individually in the same way as
>>> other selftests (so through the kselftest runner).
>>>
>>> Naturally, driver dependencies must be met for the test to run and
>>> produce valid results. From my understanding the runner itself cannot
>>> ensure this, so in this case it would be up to the user or CI to
>>> enable/load the appropriate drivers before running the test.
>>> If these dependencies are not satisfied, the test could just exit
>>> with a skip code.
>>>
>>> Does this make sense to you? or is the kselftest runner intended to be
>>> used to run exclusively a subset of tests in the selftests directory
>>> (i.e. the ones that don't have platform-specific driver requirements)?
>>>
>>
>> There are several tests that aren't included in the default run because
>> they have dependencies and potentially damaging to the running system.
>> These tests are not included for a reason.
>>
>> The first step would to be ensure writing shell script to load and
>> unload the watchdog module and then pass in existing parameters such
>> as the oneshot to run the test.
>>
>> There is no need to add a new parameter yet. Also there is no need to
>> convert this to ktap yet.
>>
> 
> To clarify, I understand that this test is not suitable for the default
> run, and I do not intend to change that. The patch series is meant to
> make the test usable in a non-interactive environment, such as a CI,
> when explicitly enabled and with the required modules already loaded.
> 

The test can be with one shot timer - how is this test currently not
usable and how are your changes making it usable?

thanks,
-- Shuah


