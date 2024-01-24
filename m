Return-Path: <linux-kselftest+bounces-3466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90DF83B038
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB44B27287
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF27F7DF;
	Wed, 24 Jan 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="o8byVe1X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6997E785
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117205; cv=none; b=PATF/rMHZrZsX5j5lQpQU9Sps4ONAkmQbBV3u4nYX2DQMg9eV6YKFyrEf1PlFd5c08tzv7PryWlCY9YwUvzQpQK5V7R+qBGoeQ17qulWx9rbwitHnjZzWpvlILI+intjlWkxOkTHi5AFiPNDF9+C7cxyEwQk7BAyp0+yTxL/dWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117205; c=relaxed/simple;
	bh=UgbguvdTNq/Vdrlx+51bobZaig0XerOayqshn5Lwl2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbOL5J0ui3EWEPkMTzkvOGZYALlIolTx9nMjR4QB9ic663vrmdB8Vxhh++a0z7/o18PbTn0fEvlamG9d6C9d9EyWty2mKmbPmCbMGIkVqy8WVg6/HYkw93fjLNy3BZGDdqBpgxQn7BunD/Z8wfIG/J7I/0XodqAW7J/a0CIf+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=o8byVe1X; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71cb97937so36044705ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 09:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706117203; x=1706722003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KC4dIipORwUXCXEhvi46+vhyUVrdFLhCkRAmwUvFgiA=;
        b=o8byVe1X09CFIrSdDq3uffqLBawuAZheSsUJddq4arR78SorQdjecGJwc242uyd/Y1
         CupGw6/0KdwlvOmsRhxn6NjOaSYaNCEV2kdGkPEcLvxSDAJvf30F7D2Yg00ECIY2I81S
         1cePZzDus8aJZmryZBtzcwsNxqRMybqev0itWAPddpjJZKv5k9lYKr+niX3hKG8O8RG3
         RoatluDthhLigImY1FGELjOCpfOFtlftylVopbYku+jkDPGpUq+1fOgAzpLSc9BR2xk0
         JpkE9IQIIvzwqqoB1FQXkL3/0dl3aGtoeC+/qsp1HliYgGKLgGgnxCtZSmC3u5bl+4yJ
         Hy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117203; x=1706722003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KC4dIipORwUXCXEhvi46+vhyUVrdFLhCkRAmwUvFgiA=;
        b=QH27B+dgOzDvwGiWssRfWahEQQH2UCmwlermOe6raZ7MBZr/EBYi/3+7ElT0rqECRY
         4TaljzoT/bJwpz3QKNlwFStATgas56byq+R0sox9JaNlK5R8BrgGoiK04qRNHf6zvZVP
         ym3MdI4f8UNIZATcF76BXm2rePoUmXjiNfB0nafGPm92BNVtn38UsFOhdvwJFQovYOG4
         MzvTm15ZveeUXESvzDPwLPAs8z2HxxudTIdzZC3CVoZQN5FzQIVsW+5uMZ+bRKRNv9uA
         cMNU0XDTfTW2dGaWPZTZIFL8Adls+syUJl7TNkdK7zKlQJMgtOKkathSzhIwokLYnxCY
         Mfsg==
X-Gm-Message-State: AOJu0YzDXCHVIUgdZ+KX23lF+XnP1awIcs/jFrIeXn/jeN43SCDxVLcL
	8ULkly0cLKLS1oBtISE1N7aqMGM0dPUZLTeX1ZQKxy7msqLUAC373YG1PbTGoA==
X-Google-Smtp-Source: AGHT+IF8mHO9Vp+yjjWsfcHYMMOE5qtbHkwt7Yveha3fRRuazxP1rHkpDjmz5SEvwAnfDjGIUg3nJg==
X-Received: by 2002:a17:902:a5c5:b0:1d7:2d68:cee9 with SMTP id t5-20020a170902a5c500b001d72d68cee9mr825951plq.27.1706117203254;
        Wed, 24 Jan 2024 09:26:43 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090320cb00b001d71e21767fsm8956786plb.71.2024.01.24.09.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:26:42 -0800 (PST)
Message-ID: <1883bb47-869d-46ac-a231-0a109645df22@mojatatu.com>
Date: Wed, 24 Jan 2024 14:26:38 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] selftests: tc-testing: check if 'jq' is
 available in taprio script
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, kuba@kernel.org,
 vladimir.oltean@nxp.com, edumazet@google.com, pabeni@redhat.com,
 linux-kselftest@vger.kernel.org
References: <20240123122736.9915-1-pctammela@mojatatu.com>
 <20240123122736.9915-3-pctammela@mojatatu.com>
 <CAKa-r6s_DO1tfcZdsQNBCwjbE0ytJKnZWnvcKqTR+5epdNq4YQ@mail.gmail.com>
 <7d92788b-13c5-4f53-8b58-9b6ece26310d@mojatatu.com>
 <CAKa-r6vJPGQjE4YAtofa-=Pog8a_2Tu5mGcxLjhkoGCqu0JENQ@mail.gmail.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CAKa-r6vJPGQjE4YAtofa-=Pog8a_2Tu5mGcxLjhkoGCqu0JENQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/01/2024 07:31, Davide Caratti wrote:
> hello Pedro, thanks for your answer!
> 
> On Tue, Jan 23, 2024 at 5:47 PM Pedro Tammela <pctammela@mojatatu.com> wrote:
>>
>> On 23/01/2024 10:17, Davide Caratti wrote:
>>> hi Pedro,
>>>
>>> On Tue, Jan 23, 2024 at 1:28 PM Pedro Tammela <pctammela@mojatatu.com> wrote:
>>>>
>>>> If 'jq' is not available the taprio tests that use this script will
>>>> run forever. Check if it exists before entering the while loop.
> 
> [...]
> 
>>> nit: what about returning $KSFT_SKIP (that is 4) if jq is not there?
>>> so the test does not fail.
>>> thanks!
>>
>> Since these scripts are run in the setup phase, it has a special treatment.
>>
>> Take for example this run:
>> ok 1 ba39 - Add taprio Qdisc to multi-queue device (8 queues)
>> ok 2 9462 - Add taprio Qdisc with multiple sched-entry
>> ok 3 8d92 - Add taprio Qdisc with txtime-delay
>> ok 4 d092 - Delete taprio Qdisc with valid handle
>> ok 5 8471 - Show taprio class
>> ok 6 0a85 - Add taprio Qdisc to single-queue device
>> ok 7 3e1e - Add taprio Qdisc with an invalid cycle-time
>> ok 8 39b4 - Reject grafting taprio as child qdisc of software taprio #
>> skipped - "-----> prepare stage" did not complete successfully
>>
>> ok 9 e8a1 - Reject grafting taprio as child qdisc of offloaded taprio #
>> skipped - skipped - previous setup failed 9 39b4
> 
> [...]
> 
>> As of today it returns 0, success in ksft, even though it clearly
>> wasn't. Looking at the code any failures in the setup/teardown phase
>> will stop the run, skip all the remaining tests but still return success.
>>
>> About returning skip from the script, aside from marking it as skip and
>> continuing the suite, we would need to run a silent teardown, one that
>> executes all commands in the specified teardown but
>> ignores errors. In this case we are assuming all setup steps follow KSFT
>> return codes. Not sure if it it's reasonable or not...
> 
> wouldn't this be fixed by adding this line:
> 
> "dependsOn" : "command -v jq >/dev/null"
> 
> to test scenarios 39b4 and e8a1 ? I'm asking this because jq is used
> also in verifyCmd after the script, to parse results.
> Background for this question: I see tdc skipping both setup and
> teardown stages for each test case in taprio.json where this line:
> 
>       "dependsOn": "command -v ciao >/dev/null",
> 
> is present. Rather than doing a setup +  silent teardown, just do
> nothing and go to the next test.

Oh indeed! Thanks for the suggestion this is much nicer.
I will send a v2!

> 
>> As your suggestion is not a blocker, I would rather address the above
>> problems in a follow up series since they will require some refactoring.
>> WDYT?
> 
> no objections, but I'm curious to see if "dependsOn" would fix this case :)
> thanks!


