Return-Path: <linux-kselftest+bounces-20787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C3A9B243F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 06:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40EB4B21E7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 05:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9163B18D658;
	Mon, 28 Oct 2024 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AKN5qZU6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA6418B492
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093519; cv=none; b=Db/sdYYUqnEaUBgLilEZ7BpHaGrGVA2nEV7OadNZEVZw/RJbKBfT6wiPvFXl4oWcY38FGoh9nYYwgrpBw84t8GbFpcuBM0nQI/AuVRCk/30CVXZ2bqHWyTR8HWc5+fvmrBvZWVIN3QYEXVhVWU4C74g8qaT8fT6QXhAR5p9tuVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093519; c=relaxed/simple;
	bh=N8lsVrshF1R/zlRYKM1SLlKplyYpbQd2DmWEJusqdxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnUNhkZAMLn7kSsWSXrYz9alr0r80J+U4zrNR5jaIAcIXsg455lVuyAd/a9A+qLK0AHDHVA8gmZlYSNDFZ3u/umLxr4XvHz/yqcGicqvHO8yZzgGIZKxoTkqi1sVm11MpNffHv+wxJIFz3ZKMUHcJbMQb+81kzJCQVL3HQ89Rz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AKN5qZU6; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so2456042a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Oct 2024 22:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730093517; x=1730698317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnoPcb4o2POZFY1B4JdGuwdYqnl4s0N+bpobnVGDTEo=;
        b=AKN5qZU6S7wzF4UNE3hLEMnHH3oAXtl7mvFuLYj6oEHgbEzN9uxNvHOKaSJhN1SW8e
         YaT0JYgRrDeTv5lb3wi5e41mm9bJWcEabQ1o6unpqlBld2f3Ah3xgbQ/axSD2XtfYlza
         +e4frXI8PRFPMWA0zWgGHR5R1SDI4ab7kYbeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730093517; x=1730698317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnoPcb4o2POZFY1B4JdGuwdYqnl4s0N+bpobnVGDTEo=;
        b=JECJFCwNKsXrfCcXtTbDcsyAvLM5Qwot7I3p262WmbHcHXpTIQcD3O+ROE6p19+OB8
         9JEhjDzXdTG5kv/o/kPWTpwjXFmSKDo8YpzeIhbO15WZUQ570/wshWNKjr2R6ZBLmlkB
         EKzpKMEHoWbSPCLflZc5DDNUjQ0JXG+Ut7VcQEv2zc586XWhZt/rvbog13q1Ij6pK+BF
         vezh1vB3CB50M7ZLSCMJx6jsMdVSU5HW5+Aopr9G3W0QWRy5LOq0AR3JRsxnDBepofik
         +qAvOPPB1l3xkdZLghZ6+sPCWVVY5h2EZBaBZdcRSb3mrJbjvmJ7cIEulcB+1uhwfhDi
         IVEA==
X-Forwarded-Encrypted: i=1; AJvYcCUm+sNwk+VxEsO+lwUs8VIhk/ayy2dOKBLSxG97ZmkFndcmUbBQXdMZFj5fNvisUuYizRdI0S3RQ/CxSpK/yCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4vwjC1dz/P7uQsKnAzGRgqo73FH6oVfDtVCCSvXiWcDH202C
	8OvWNaBmMxC1wx9JFrlFaYyRJXXaZC2AhdCBk+rjNkmkLNuJpPN4puin+n9DiK0=
X-Google-Smtp-Source: AGHT+IETOlSvY+h4Ti/i9dwAqubW6ic1nYtb3qauehyAyGqGVwgT48Us6xjyARsnGHXBDm3NNTupoQ==
X-Received: by 2002:a05:6a21:1707:b0:1d9:386b:5320 with SMTP id adf61e73a8af0-1d9a853a13fmr9289581637.48.1730093516575;
        Sun, 27 Oct 2024 22:31:56 -0700 (PDT)
Received: from [10.200.3.216] (fs96f9c361.tkyc007.ap.nuro.jp. [150.249.195.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720757322d5sm2052649b3a.91.2024.10.27.22.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 22:31:56 -0700 (PDT)
Message-ID: <54cbf018-eba1-4227-b464-78bfa41fa4ae@linuxfoundation.org>
Date: Sun, 27 Oct 2024 23:31:53 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
 <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
 <0861d73d-4fd9-4118-91c8-5a619c7d7ca0@fujitsu.com>
 <e907e67d-9116-4dd2-9b61-f93191737de6@linuxfoundation.org>
 <b7b3deec-47fd-43e4-a9b5-7099e3c00623@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b7b3deec-47fd-43e4-a9b5-7099e3c00623@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/24 22:02, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 28/10/2024 11:29, Shuah Khan wrote:
>> On 10/27/24 18:50, Zhijian Li (Fujitsu) wrote:
>>>
>>>
>>> On 27/10/2024 08:28, Shuah Khan wrote:
>>>> On 10/24/24 19:39, Li Zhijian wrote:
>>>>> Currently, watchdog-test keep running until it gets a SIGINT. However,
>>>>> when watchdog-test is executed from the kselftests framework, where it
>>>>> launches test via timeout which will send SIGTERM in time up. This could
>>>>> lead to
>>>>> 1. watchdog haven't stop, a watchdog reset is triggered to reboot the OS
>>>>>       in silent.
>>>>> 2. kselftests gets an timeout exit code, and judge watchdog-test as
>>>>>      'not ok'
>>>>>
>>>> This test isn't really supposed to be run from kselftest framework.
>>>> This is the reason why it isn't included in the default run.
>>>
>>> May I know what's the default run, is it different from `make run_tests` ?
>>
>> No it isn't. "make kselftest" runs only the targets mentioned in the
>> selftests Makefile. That is considered the kselftest default run.
> 
> Hey, Shuah,
> 
> 
> Thanks for your explanation.
> If that is the case, I do not have an urgent need for the current patch, expect
> I'd like to avoid the reboot issue after an accidentally `make run_tests`
> 
> Some changes are make as below, please take a look. I will send it out we reach a consensus.
> 
> 
> commit 2296f9d88fde4921758a45bf160a7f1b9d4678a0 (HEAD)
> Author: Li Zhijian <lizhijian@fujitsu.com>
> Date:   Mon Oct 28 11:54:03 2024 +0800
> 
>       selftests/watchdog-test: Fix system accidentally reset after watchdog-test
>       
>       After `make run_tests` to run watchdog-test, a system reboot would
>       happen due to watchdog not stop.
>       ```

The system shouldn't reboot just because watchdog test is left running.
watchdog test keeps calling ioctl() with WDIOC_KEEPALIVE to make sure
the watchdog card timer is reset.

If you are seeing reboots, that means watchdog test couldn't reset the
timer. This usually mean system is unresponsive or something is wrong
with the watchdog card on your system.

This is the behavior you would expect from a watchdog timer. Does your
system have a watchdog card ot or you enabling softdog module?

Either way there is some other reason for the system reboot.

thanks,
-- Shuah

