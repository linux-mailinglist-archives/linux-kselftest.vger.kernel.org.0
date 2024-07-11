Return-Path: <linux-kselftest+bounces-13630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4F92F162
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 23:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C120528342C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF81A00E3;
	Thu, 11 Jul 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SK4D7d3e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F438F83
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720734990; cv=none; b=uxpwlwN+4jdoKzBfyy/HmfFtCoLw0oJqn7LgQZFjvLiB0lSxAZBLDXRtQuSDtyaB0GmodGUeectwAFHOvT3nU1DzvN2I2teR2lvDCF8SJ16wZNqF2gSFghukBWS6JaWgbW88bLRrrN6MlkL5xfED1R3nV9kB4rWgiAoLMn+JKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720734990; c=relaxed/simple;
	bh=DIDgvcgmFmPsPPavJiQ1Vv4Swv8vnjxFF2oxXNf0ab4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibb4MGj5Ck/AkbjxP81bQiVMp8yZJukXBZxV9yinqklf//iHKH6CE4JRK5MRRX+G9fhj4RBAKyN0HtGQeIouV+SF0WOhmsIKg/rc+tlUWFzYT533M6f5vgnr47A/mRjqQ4+RpEis09zHLeFGutsuzbFtQfwKtYDiqdiNliObVVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SK4D7d3e; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-805fc096a34so2875839f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720734987; x=1721339787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZqXMd/BZwDssF01cs3NfdsNolBEcWg7FCtmoecpdP8=;
        b=SK4D7d3eZw7wdrfdMv0iOtYTZv92TcLEn3eCTAmytFkyskFblR5zGbR3NR5uaBX3wB
         J8zI/9mtB/NB0USE1goNiQ6pJ1NeOAL9CvRpdVDiIVuoDWp0+GeAqtBw8T6IjZLxEobb
         kPkxRG/6ZatpDOcplo8welqidv/QDzTfqwpMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720734987; x=1721339787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZqXMd/BZwDssF01cs3NfdsNolBEcWg7FCtmoecpdP8=;
        b=T4Co/frWD3gomw4PlwLYDFW/YZt71kT9vptDed2dMGDPe4L8cz5q++QpXpEaP4kTiJ
         5cW2iEPw845rNu5JoGZKvDZxy3TtDe/j6PvMKJpbdnP7+fJzbyQGDee/d7jiFUFgnpDd
         gDTOmZqANnZrBsw40zljHEqU5rrxbAcghTZyDCpcsePiG8WjU5mhULLjB7sPpM7Zqtv0
         nYEiHmbxU2HWbYTLk3UdtwEc00MWi4MKWMAQ9s/f+K5/MXFcXNiuBMJz1z0aTUBxsJtp
         Dgg2DoGYUA6Z2UZEhU+RZhqvfwaoE7sZkO0DFF8VlPScG7ofN9XZBVzrwrz+JjQrRYVu
         mJqg==
X-Forwarded-Encrypted: i=1; AJvYcCU9FKJX/e4742r9koaGFV/L/JjBC9e9q1ddLJLlcOPmzcLLpEFolIdbO1JVzpAMp74MM62M6zyxEW5z8OAmfyYrTjLxH0FxmkGz3GgSDNLR
X-Gm-Message-State: AOJu0YwlOaUqSrpdiIZCr+9IQ0JmENUwlFr8elrsDUsEBKckGE2kb77k
	eVTt3qEGiNeunDOscg+hEyjD/7zioLrmf/C/HMMhGePOgCGc0V+tbBqo1E9nzF0=
X-Google-Smtp-Source: AGHT+IHJnvscnRKpA9/toeFRLI32Ul1ZlooCIKoES2PiuCfMQuLDYC5WuBwbOW5FjsA9va7SWmRfSw==
X-Received: by 2002:a6b:6614:0:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-806e21af79cmr362061739f.2.1720734986623;
        Thu, 11 Jul 2024 14:56:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c29d7asm2053421173.162.2024.07.11.14.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 14:56:26 -0700 (PDT)
Message-ID: <e73c745a-5e2f-46f3-806a-739cfde72e8d@linuxfoundation.org>
Date: Thu, 11 Jul 2024 15:56:25 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] kselftest: Add test to report device log errors
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernelci@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
 <2024071003-islamist-expediter-a22c@gregkh>
 <71c479fb-cd25-45ec-8dd3-0521ef951f58@linuxfoundation.org>
 <e1e32c72-6bd3-4c15-b301-c5670690ba99@linuxfoundation.org>
 <1417b57a-ac0b-4e8c-b157-bbe9ebb14e57@notapiano>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1417b57a-ac0b-4e8c-b157-bbe9ebb14e57@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/11/24 15:44, Nícolas F. R. A. Prado wrote:
> On Thu, Jul 11, 2024 at 01:53:37PM -0600, Shuah Khan wrote:
>> On 7/10/24 15:49, Shuah Khan wrote:
>>> On 7/10/24 07:11, Greg Kroah-Hartman wrote:
>>>> On Fri, Jul 05, 2024 at 07:29:53PM -0400, Nícolas F. R. A. Prado wrote:
>>>>> Log errors are the most widely used mechanism for reporting issues in
>>>>> the kernel. When an error is logged using the device helpers, eg
>>>>> dev_err(), it gets metadata attached that identifies the subsystem and
>>>>> device where the message is coming from. This series makes use of that
>>>>> metadata in a new test to report which devices logged errors.
>>>>>
>>>>> The first two patches move a test and a helper script to keep things
>>>>> organized before this new test is added in the third patch.
>>>>>
>>>>> It is expected that there might be many false-positive error messages
>>>>> throughout the drivers code which will be reported by this test. By
>>>>> having this test in the first place and working through the results we
>>>>> can address those occurrences by adjusting the loglevel of the messages
>>>>> that turn out to not be real errors that require the user's attention.
>>>>> It will also motivate additional error messages to be introduced in the
>>>>> code to detect real errors where they turn out to be missing, since
>>>>> it will be possible to detect said issues automatically.
>>>>>
>>>>> As an example, below you can see the test result for
>>>>> mt8192-asurada-spherion. The single standing issue has been investigated
>>>>> and will be addressed in an EC firmware update [1]:
>>>>>
>>>>> TAP version 13
>>>>> 1..1
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `model_name' property: -6
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `energy_full_design' property: -6
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>>    power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>>> not ok 1 +power_supply:sbs-8-000b
>>>>>    Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>>>>>
>>>>> [1] https://lore.kernel.org/all/cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano
>>>>>
>>>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>>
>>>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> Is this dependent on a linux-next?
>>>
>>> Didn't apply to linux-kselftest next.
>>>
>>
>> I tried applying these on top of linux-kselftest next which is at
>> Linux 6.10-rc7 + other patches.
>>
>> I am not sure what is wrong - first patch applies and the second
>> and third don't.
>>
>> git am fails and manual patch application worked for 2/3, same thing
>> with 3.3 - these should apply cleanly since they don't have obvious
>> conflicts.
>>
>> Please clean this up and send me updated series adding Greg's ack.
> 
> Oh, now I see what happened. I recently sent another series that touches the
> same file (tools/testing/selftests/devices/test_discoverable_devices.py):
> "kselftest: devices: Allow running test on more platforms"
> https://lore.kernel.org/all/20240613-kselftest-discoverable-probe-mt8195-kci-v1-1-7b396a9b032d@collabora.com/
> 
> That was already merged through the usb tree, and is present on next (on which I
> based this series).
> 
> In this case I imagine it's best if this series gets picked through the usb
> tree, right? Even if I rebase on kselftest's next, there will be conflicts.
> 

I see. No problem. It can go through usb tree

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


