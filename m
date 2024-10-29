Return-Path: <linux-kselftest+bounces-20885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA559B405B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 03:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23EF9B21F62
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 02:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F314D6F9;
	Tue, 29 Oct 2024 02:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R1xceYQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76FD51C
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730168693; cv=none; b=aT6fVRladaLrkp17XJAl9SRhtJmGjHid+j76wX8CE9dojt81670JeduwKBBI4ayj8IRaf5Gu3gBMZ9q5bRHYoczf7ZYTVH8q23raK9P/qdLrrhw/n0SXcCUISYFm3pbCQyOm+C0PdpWi3c1zJi+yEVRwLGWaJsEysf3gPtk4NBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730168693; c=relaxed/simple;
	bh=BejeLQbo1KIgBvo+J8tJNR3BIiYcqRbZZewiSlPizpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7MsncAU0BQPJABsaNy1xwAABUuh2OmAMOH95dK78C3kbr95ocDsHF2g2CVWODX1YTJ5BJ2fE5nZarqiaORBlIE5V5jIhS0FKdvgff5RgO+zFH/MXWnT1HMEyinc/I+t7QRLHHzavRr0p3CICi190yU9BkPupmwoKqJpkUxLegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R1xceYQw; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e291cbbf05bso5070058276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730168691; x=1730773491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr1MZwBwlO+YKQauQw2Es16qQ1idtsr720ZzDRpS9+Y=;
        b=R1xceYQwsJIwhG6WGlwsbUamI96Tfflhgy7i+SNiH30dcYivLKdpZWJJPQEqRW0P3u
         pGyKq8EK09FVmT/XPt+aHlrP57iLnDQ/jPpVe7ECyQLvxvfbmEMD493V2CDgYd7YMNKK
         7g0g2IkwZKuasJP9014+7AtLTIBzpKZTD6bsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730168691; x=1730773491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr1MZwBwlO+YKQauQw2Es16qQ1idtsr720ZzDRpS9+Y=;
        b=Ao/QwXLaZoWo1aPLz79e6r1CgDOJXRXxhTJ2pZuhbTaSBmslwqF0JR3EZmpqS5q6T/
         EsBaVEZi3982jXuym1JkxSdZW6ZXlXqTIBORzgZhbciDhrp9Rfh2zun21IhAPZzl7/Se
         26vIRJOkkYFoy1Z8omYtR6UJAjlFZS/a0ZD3DXY1OFS8ZH5OQdGsqWl274JlQ2401mrO
         7epnc5OUoTDqrhO02/3p7CWlkWjwD7gy8jFYz5uYjiuEqwlE2VXssxjNZGkFwLoLL+CT
         NMUIL9MjRM+NorQNquq7HXhYBYoZeZ0gFx7bxn0HyxbOA8tscaDosqvuD+v2CNqiEaHO
         SsBg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Ib+GiS08TfRMX+8UP9pVHFQlh0r7ZNui3XOU3XngZdGXrdLJIfH1/ly4VtzKNKG6prlMTPBVEFnCshk6LDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWO2cyp9hOGrhkYDumnfc5ml9TptvNEIdrrSeLSd6yvAy5WOk4
	tk/nL9OiwhATqx/iGp3rEDAXex9Srk/rH9r4T9BfiO8rQ9akvs90k28pdKuiq3w=
X-Google-Smtp-Source: AGHT+IEy08sPP3WsUtLOOnwON+JZxjpLJsAm3I7cFUijFCnA3vDdX1Ydp2n4L/4Ve45L/tFUc29ZCg==
X-Received: by 2002:a05:690c:f87:b0:6e3:2e4b:ad9a with SMTP id 00721157ae682-6e9d895d649mr106694387b3.12.1730168690820;
        Mon, 28 Oct 2024 19:24:50 -0700 (PDT)
Received: from [10.200.3.216] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a433dcsm6461059b3a.217.2024.10.28.19.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 19:24:50 -0700 (PDT)
Message-ID: <3d36bb3c-07b8-43b3-a5ef-fe63b65429ce@linuxfoundation.org>
Date: Mon, 28 Oct 2024 20:24:47 -0600
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
 <f10e8a78-3b50-4212-9b5d-ba99a3421379@linuxfoundation.org>
 <6862e399-b169-4ffb-b9c6-904f99d96e56@fujitsu.com>
 <19579b1c-0a9b-4c72-be00-44871dd37b9a@linuxfoundation.org>
 <a6a5d13b-c550-4a99-9a84-b28e8314ccd1@fujitsu.com>
 <e0bf1824-c476-490c-b63c-0789dabd788b@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <e0bf1824-c476-490c-b63c-0789dabd788b@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 00:44, Shuah Khan wrote:
> On 10/28/24 00:32, Zhijian Li (Fujitsu) wrote:
>>
>>
>> On 28/10/2024 14:25, Shuah Khan wrote:
>>> On 10/28/24 00:06, Zhijian Li (Fujitsu) wrote:
>>>> linux/tools/testing/selftests/watchdog# make run_tests
>>>> TAP version 13
>>>> 1..1
>>>> # timeout set to 45
>>>> # selftests: watchdog: watchdog-test
>>>> # Watchdog Ticking Away!
>>>> # .............................................#
>>>> not ok 1 selftests: watchdog: watchdog-test # TIMEOUT 45 seconds
>>>>
>>>>
>>>> And i got warning in dmesg
>>>>
>>>> [ 1953.229511] watchdog: watchdog0: watchdog did not stop!
>>>>
>>>>
>>>>
>>>>
>>>
>>> Run "make run_tests" under strace and send me the output.
>>
>>
>> Could you share the exact command, how to 'Run "make run_tests" under strace'
>>
> 
> strace make run_tests > strace.out 2>&1
> 
> Send me strace.out

Thank you for the strace output. kselftest uses a timeout to terminate
hung tests - that timeout is 45 seconds. When you run "make run_tests"
under watchdog directory, you are running into this.

Yes your fix to add SIGTERM handling makes sense. Please also handle
other signals - SIGKILL, SIGQUIT.

Thanks for the find.

thanks,
-- Shuah

