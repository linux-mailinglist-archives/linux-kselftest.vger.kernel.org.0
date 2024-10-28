Return-Path: <linux-kselftest+bounces-20789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D758E9B24B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 06:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D2C1F2132B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 05:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B65718CBE1;
	Mon, 28 Oct 2024 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U6EAWtrS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1C217C220
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094910; cv=none; b=dXqSbOdVTMBUt95ItVbVTeWx7ILN2IWcWOGZM7MIBlTdePC/2LKbnZIJBUJWcANLq82u7OC3XNk6R4B+T0vzjo3OUVVTUYhxit/6/ZmArr7APC6v/ldSSj1KYh//ObSkvHRK2Ubk4s4WVlhnQqTTtUyoPmYQYMedsQxk69m8WC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094910; c=relaxed/simple;
	bh=RFNoSYlj3/Wh73KtWJGXcsU30MLZzQBHnF/nevb0bjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjlTGk9cT4p2xKB8SlUnYLWMb10TLcff4N1YXzYCAKehkI//doRmPQ5GTXYIko02NtR326AGaNlYwYi4DsBM2+dABLzsG4dVjWZHGJwpSYlsPL3iNYeKbiOF4z5XilTyzacSSDfkgzYtAdxTXLgNlBNal5ynQ6Q4Z2Ged1Com70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U6EAWtrS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cf6eea3c0so29955405ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Oct 2024 22:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730094907; x=1730699707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Te0IbbXAnRNWlJ2Rd9606nbBkjynXrLQNO+BlYkZ/0Y=;
        b=U6EAWtrSOXmdYrKmF62Z0350G+JwYx9xrIJZIuZiXsmKtvdB8KTfALEevk5JE5hUZs
         3d2XVXGU2112Fi3e9yHhDxrro2y3qIQvlF4ySmsPBUP+HG8vy3qlRqtkPTr62us4EBRv
         fvMkSigj81Fo/se/ZYcic8Ht4SwALfVz/E0/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730094907; x=1730699707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Te0IbbXAnRNWlJ2Rd9606nbBkjynXrLQNO+BlYkZ/0Y=;
        b=ZIVtpJXUrcgoAzQxC8s3ZZXfp45orDlG5GNjoLVACiAFqVkMMaTRMMUavVBwUaCwSE
         pwB7akqoMZjPsb7jivpwg0uL35hNj+ShzR0HqVDgs03HWtAWp9qAH79J9e7+5alU9fbG
         1hxghr2rDzS3sTP0DMHZk00nbqroH6Ceei5DOWPxlaOr1ejJO1G1gRe1TYI6PZfVqI6k
         68jA8ib+uK3y2Y0ug5Cun8UWwtldr6FCj4dPk3N1+NxgiB4IFg1jiBv5g/rNPFFyfaaF
         LIVo1ran2yOP7B30I94K9XzXWPE2UBsRq6F0CehBkt8JbjVghnz93Fy1jkZ7u36cYWEP
         sOfA==
X-Forwarded-Encrypted: i=1; AJvYcCX/NIz4CqB5JJImWeBleWEqtoCQDLHHG4IxJEPBbtBXV2Np+eeUHlScprpAgt5aqdh3kPcbXWCHsn9whCt/UDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQnTZn//EWebK7LBpkPKzpp7of/YRrrYEcBe3b6KJX39Wt6ab
	eupG36QQ2Te5nM2nQjT8sMX0lsmbp9ln1efFOx1HZebVHvI+rGtHKAYMM1dQs8S/i56aTeVBKq7
	7H2U=
X-Google-Smtp-Source: AGHT+IH2xhFbsQmtRs1tqwgCLeH90AKG1bx15t2eOH3VbGWha9pnJPt3YOJnQnyWiDz4qG4VG/r2Zg==
X-Received: by 2002:a17:903:182:b0:20b:8a71:b5c1 with SMTP id d9443c01a7336-210c6872b1amr97655375ad.1.1730094907330;
        Sun, 27 Oct 2024 22:55:07 -0700 (PDT)
Received: from [10.200.3.216] (fs96f9c361.tkyc007.ap.nuro.jp. [150.249.195.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc063e7esm43020195ad.276.2024.10.27.22.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 22:55:07 -0700 (PDT)
Message-ID: <f10e8a78-3b50-4212-9b5d-ba99a3421379@linuxfoundation.org>
Date: Sun, 27 Oct 2024 23:55:04 -0600
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
 <54cbf018-eba1-4227-b464-78bfa41fa4ae@linuxfoundation.org>
 <3ee0d14a-7f6b-4ef4-9349-d6b0f14ba9e8@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3ee0d14a-7f6b-4ef4-9349-d6b0f14ba9e8@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/24 23:45, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 28/10/2024 13:31, Shuah Khan wrote:
>> On 10/27/24 22:02, Zhijian Li (Fujitsu) wrote:
>>>
>>>
>>> On 28/10/2024 11:29, Shuah Khan wrote:
>>>> On 10/27/24 18:50, Zhijian Li (Fujitsu) wrote:
>>>>>
>>>>>
>>>>> On 27/10/2024 08:28, Shuah Khan wrote:
>>>>>> On 10/24/24 19:39, Li Zhijian wrote:
>>>>>>> Currently, watchdog-test keep running until it gets a SIGINT. However,
>>>>>>> when watchdog-test is executed from the kselftests framework, where it
>>>>>>> launches test via timeout which will send SIGTERM in time up. This could
>>>>>>> lead to
>>>>>>> 1. watchdog haven't stop, a watchdog reset is triggered to reboot the OS
>>>>>>>        in silent.
>>>>>>> 2. kselftests gets an timeout exit code, and judge watchdog-test as
>>>>>>>       'not ok'
>>>>>>>
>>>>>> This test isn't really supposed to be run from kselftest framework.
>>>>>> This is the reason why it isn't included in the default run.
>>>>>
>>>>> May I know what's the default run, is it different from `make run_tests` ?
>>>>
>>>> No it isn't. "make kselftest" runs only the targets mentioned in the
>>>> selftests Makefile. That is considered the kselftest default run.
>>>
>>> Hey, Shuah,
>>>
>>>
>>> Thanks for your explanation.
>>> If that is the case, I do not have an urgent need for the current patch, expect
>>> I'd like to avoid the reboot issue after an accidentally `make run_tests`
>>>
>>> Some changes are make as below, please take a look. I will send it out we reach a consensus.
>>>
>>>
>>> commit 2296f9d88fde4921758a45bf160a7f1b9d4678a0 (HEAD)
>>> Author: Li Zhijian <lizhijian@fujitsu.com>
>>> Date:   Mon Oct 28 11:54:03 2024 +0800
>>>
>>>        selftests/watchdog-test: Fix system accidentally reset after watchdog-test
>>>        After `make run_tests` to run watchdog-test, a system reboot would
>>>        happen due to watchdog not stop.
>>>        ```
>>
>> The system shouldn't reboot just because watchdog test is left running.
>> watchdog test keeps calling ioctl() with WDIOC_KEEPALIVE to make sure
>> the watchdog card timer is reset.
> 
> Err..
> 
> How watchdog test keep calling ioctl() with WDIOC_KEEPALIVE after ./watchdog_test has finished?
> 
> In my understanding, the cause is that, ./watchdog_test didn't goto neither
> A)
> 347 end:
> 348         /*
> 349          * Send specific magic character 'V' just in case Magic Close is
> 350          * enabled to ensure watchdog gets disabled on close.
> 351          */
> 352         ret = write(fd, &v, 1);
> 353         if (ret < 0)
> 354                 printf("Stopping watchdog ticks failed (%d)...\n", errno);
> 
> nor B)

Can you send strace output from "make run_tests" from your system?

thanks,
-- Shuah


