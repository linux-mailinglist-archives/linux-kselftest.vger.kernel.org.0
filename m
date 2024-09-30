Return-Path: <linux-kselftest+bounces-18695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6C598AFC5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 00:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CFE1F23E6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 22:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119FA17BB32;
	Mon, 30 Sep 2024 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cwSR8gnt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8815E97
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734797; cv=none; b=paOAP8E18gvnWsfy0EWgIw11CvGbVk9IGTl35EbEkdwEi4Xj/e5ErsY3KVxuVsvy2fqJ8GiWsABBWy+g3tY+b+et+mNgX/ic1dwFo8wzYkcrtZmJWLIDZzW7Ecg84UALv6bUHWjtD8YPpeTU3CN5WpEjEH0UETKhKg3Ge4seZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734797; c=relaxed/simple;
	bh=oqjC83MIkeRgMBwe/vq3UtdbaMGI8ktAjHceC6fdlng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJXIb+FunGQ3bC8fJf9iBXEaf2RflUP6t0wMT0fpp0DCzZI6onvzFFGtXggcwsvo9CSBh5pfA3kXwerWdQY7bp9sdlcXe4huGZmXM/G1lfv9UKTJM7W+lhVV2hqUcifUF5EGrCI02E5MmrzCDydTNS5nsMdTOrgqHdcWXH6EIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cwSR8gnt; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82ce603d8daso168163339f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727734794; x=1728339594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6MDWmHGpB4cCi1tGpX01jk0E/A0pwD2QmjG79qr/ag=;
        b=cwSR8gntrmXSx5S2N0UcZ5S6KLbrNphyY7vP18WNd8T0StMq4Ur5zPzGVZ6XiYqzKJ
         BJLGhqK6334b8pbPkVCPW5gxSvVC9UsJsc4DsHTlJRx5sLLCtRJkUwICVLh51ghcbuGg
         eNchlE8IuIydXYw4fRFZGEEAxsryckijn8ZdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734794; x=1728339594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6MDWmHGpB4cCi1tGpX01jk0E/A0pwD2QmjG79qr/ag=;
        b=gw3A9Qvv7JWKjsbrmgmOiB01WPUwYtL4XJQaXKNKG1dv2OauVG60OutVEirx445dJ4
         1kys8AGavZQQcg9Jit0jUo+5doSX+5o1lDXC3Y0LJZOO85k6PJIZ3LwM6b1dh1txHxKx
         YAypkD72aqnGnTPH+LiX4eACTDrIV735ZVigePM5gcM6pYpv3F5okpC94+YiQwRxeRvv
         fSA16msqf+yWg9JpSpw6UeU1WWbCNyqG77r+wQFoTg8CPyvSb/LXAvGRfgJwp7IcSeyX
         9wML6X4CrCzZkNE5vveRoI6j6n5+7yMlmzWw8qe8HHhSWg0yGLLk2+5y4J4ntWVHW8gR
         23wA==
X-Gm-Message-State: AOJu0Yz6fPIJoFKnfRjo7K1LmrQXRsHmeVQczJ1yYfMHH340NKzQO7zx
	Lv34JoWkxaWMeegu9cCyN1oQKiS6fqlcqLDW4/amXT+iKu/QGSNw+l6i4v4Amzo=
X-Google-Smtp-Source: AGHT+IGgGVXbVX4bsBxojc/hToS74ys9ts7t0yLU4Bj6YcXJg/vbLcgK+vdp8UQHHXAd3Tge0Ndz+g==
X-Received: by 2002:a05:6602:6427:b0:82a:545b:113f with SMTP id ca18e2360f4ac-83493257f13mr1099044939f.12.1727734794199;
        Mon, 30 Sep 2024 15:19:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835064sm2328362173.12.2024.09.30.15.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 15:19:53 -0700 (PDT)
Message-ID: <8d1c1645-8857-4b67-b5dd-2e966aa0d8f5@linuxfoundation.org>
Date: Mon, 30 Sep 2024 16:19:53 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 v6.11 v5.15 v5.4 v4.19 1/1] selftests: breakpoints: use
 remaining time to check if suspend succeed
To: Yifei Liu <yifei.l.liu@oracle.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, ramanan.govindarajan@oracle.com,
 sinadin.shan@oracle.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240930203603.2854629-1-yifei.l.liu@oracle.com>
 <ff1b6eec-06c5-4b5f-bc27-6637510014d9@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ff1b6eec-06c5-4b5f-bc27-6637510014d9@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/24 16:13, Shuah Khan wrote:
> On 9/30/24 14:36, Yifei Liu wrote:
>> "step_after_suspend_test fails with device busy error while

You don't need quotes

>> writing to /sys/power/state to start suspend."

Same here.

  The test believes
>> it failed to enter suspend state with
>>
>> $ sudo ./step_after_suspend_test
>> TAP version 13
>> Bail out! Failed to enter Suspend state
>>
>> However, in the kernel message, I indeed see the system get
>> suspended and then wake up later.
>>
>> [611172.033108] PM: suspend entry (s2idle)
>> [611172.044940] Filesystems sync: 0.006 seconds
>> [611172.052254] Freezing user space processes
>> [611172.059319] Freezing user space processes completed (elapsed 0.001 seconds)
>> [611172.067920] OOM killer disabled.
>> [611172.072465] Freezing remaining freezable tasks
>> [611172.080332] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [611172.089724] printk: Suspending console(s) (use no_console_suspend to debug)
>> [611172.117126] serial 00:03: disabled
>> --- some other hardware get reconnected ---

The above shouldn't be there. git am throws away everything after
this. Get rid of the above line.

>> [611203.136277] OOM killer enabled.
>> [611203.140637] Restarting tasks ...
>> [611203.141135] usb 1-8.1: USB disconnect, device number 7
>> [611203.141755] done.
>> [611203.155268] random: crng reseeded on system resumption
>> [611203.162059] PM: suspend exit
>>
>> After investigation, I noticed that for the code block
>> if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
>>     ksft_exit_fail_msg("Failed to enter Suspend state\n");
>>
>> The write will return -1 and errno is set to 16 (device busy).
>> It should be caused by the write function is not successfully returned
>> before the system suspend and the return value get messed when waking up.
>> As a result, It may be better to check the time passed of those few
>> instructions to determine whether the suspend is executed correctly for
>> it is pretty hard to execute those few lines for 5 seconds.
>>
>> The timer to wake up the system is set to expire after 5 seconds and
>> no re-arm. If the timer remaining time is 0 second and 0 nano secomd,
>> it means the timer expired and wake the system up. Otherwise, the system
>> could be considered to enter the suspend state failed if there is any
>> remaining time.
>>
>> After appling this patch, the test would not fail for it believes the
>> system does not go to suspend by mistake. It now could continue to the
>> rest part of the test after suspend.
>>
>> Fixes: bfd092b8c272 ("selftests: breakpoint: add step_after_suspend_test")
>> Reported-by: Sinadin Shan <sinadin.shan@oracle.com>

Do you have a thread for this report. If so please add
Closes: tag with link to the report.

>> Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
>> ---
> 
> In the future add version to version changes to make it easier for
> reviewers to check for the changes they asked for.
> 
>>   .../testing/selftests/breakpoints/step_after_suspend_test.c  | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>> index dfec31fb9b30d..8d275f03e977f 100644
>> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>> @@ -152,7 +152,10 @@ void suspend(void)
>>       if (err < 0)
>>           ksft_exit_fail_msg("timerfd_settime() failed\n");
>> -    if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
>> +    system("(echo mem > /sys/power/state) 2> /dev/null");
>> +
>> +    timerfd_gettime(timerfd, &spec);
>> +    if (spec.it_value.tv_sec != 0 || spec.it_value.tv_nsec != 0)
>>           ksft_exit_fail_msg("Failed to enter Suspend state\n");
>>       close(timerfd);
> 

Send another version with these changes.

thanks,
-- Shuah


