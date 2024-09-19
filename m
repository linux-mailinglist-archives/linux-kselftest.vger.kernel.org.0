Return-Path: <linux-kselftest+bounces-18143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B6597CDC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 20:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB1628181D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650D22612;
	Thu, 19 Sep 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EqBicTIl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F581BDDB
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726771009; cv=none; b=V6EjawpVptKGG2dUKcO4bzG9jSFX4X7lBrfjK4BbhPofYFjUxsHyMDgywbUkwpHyrQ8JmNOA52AriRpIAaXzt705fmxiT9tguZte+Pu2SYIILtpJEaFuf8lai4j8jSbr9MWqXcfSpO8+TkoOwmlYl7QkGds4Xk0VenDVwD/n/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726771009; c=relaxed/simple;
	bh=TFiSwmTnazXBqDoOLIdA+S+rN7U/vxqqJP1SSEusk7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzyZb21lxAQhHE+KL8903ggs4oGpJ74jHCBOfUpL8B6J73KMlfNbIforpaG4/eaj3WgColTOaePhbh5mz7yMqEkDKcj1PalWl8euUpUs4EiqsxU+RsyX+LXCJoPhWfkpN5enzwISHvQcitlnd9f8RwYLC1msWWp54zC790+Lr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EqBicTIl; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a043496fdeso4591045ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726771007; x=1727375807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvM+gPXswWXfmSQAojXD5HAY7PuhkDoRsKPawRENUlU=;
        b=EqBicTIlOI4DIkWq+dCxiN+VBvcsGJ5iEsjryMusKDuaeP7vxgm4Xg/3H81ctA2AD7
         beB3KCNco07HsIFvuML1QPWnfYNzTifz9v+UMoD//BWaBmb3kydXGqx7ut4gWrwcjfi4
         TtSoWrEMyzA+XYNB2A2bNiyh9JoLIPQyetk3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726771007; x=1727375807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvM+gPXswWXfmSQAojXD5HAY7PuhkDoRsKPawRENUlU=;
        b=dm6yIiqfiPqcTNpgJ9LpBA++p5FYb5F3xdpzzc7aDE25+9R83BASSMwSsJe4D6Xbj0
         kK3z1sFHyUZVrvcBarhBR8Bt7BtOhwkr1RJpeNBHd3rImJ8tVjOd/xqOOzsc8JtDTFSn
         wTAkAFFze83t0LLtIjaIGaHggNoWVDDAwnIvkCwRX4SKC1RgjzOm5qUHyka1zj4q4PcG
         KS3TKlmn26loikjAPZHwzHWZ5RV/Up4fxQ/D8i664M9lIJnbHe6/YI6hvb3nTCXlCekI
         Og341Z0NYbyMWrcxRuemBk/+fRFqRdhY38e3Q5MOg2pnaC13wqBXbv7iRnaT3/Pk9gc7
         XLeA==
X-Gm-Message-State: AOJu0YyGlkeZqRhDqagOGy+Slsa4VTe8Yp+INYD+n6jos8gjXJj2Zkil
	qlyhhbd7OWE2gB/St7fWGPBLCD9jDZNNbHLplXXeZLyMHZcnXZT+P3D9NGgZTX8=
X-Google-Smtp-Source: AGHT+IFxLq1HDzcm+pRGV7xq/EQUItqZ3RNEp1aIEA/8kiMQKkCAUkNt4+Pk71fmIgoo4qh4nlj0sA==
X-Received: by 2002:a05:6e02:1c86:b0:3a0:52f9:9170 with SMTP id e9e14a558f8ab-3a0c9cd0b0dmr680775ab.1.1726771006943;
        Thu, 19 Sep 2024 11:36:46 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0b637e81bsm14509355ab.9.2024.09.19.11.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 11:36:46 -0700 (PDT)
Message-ID: <6cdd7cc3-e5ca-48b0-bd49-d33bbf908cda@linuxfoundation.org>
Date: Thu, 19 Sep 2024 12:36:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests: breakpoints: use
 time passed to check if suspend succeed
To: Yifei Liu <yifei.l.liu@oracle.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, ramanan.govindarajan@oracle.com,
 sinadin.shan@oracle.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240917224837.478684-1-yifei.l.liu@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240917224837.478684-1-yifei.l.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/24 16:48, Yifei Liu wrote:
> We recently notice that the step_after_suspend_test would
> fail on our plenty devices.  The test believesit failed to

What are "plenty devices"
recently noticed?

Typo - believesit?

> enter suspend state with
> 
> $ sudo ./step_after_suspend_test
> TAP version 13
> Bail out! Failed to enter Suspend state
> 
> However, in the kernel message, I indeed see the system get
> suspended and then wake up later.
> 
> [611172.033108] PM: suspend entry (s2idle)
> [611172.044940] Filesystems sync: 0.006 seconds
> [611172.052254] Freezing user space processes
> [611172.059319] Freezing user space processes completed (elapsed 0.001 seconds)
> [611172.067920] OOM killer disabled.
> [611172.072465] Freezing remaining freezable tasks
> [611172.080332] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [611172.089724] printk: Suspending console(s) (use no_console_suspend to debug)
> [611172.117126] serial 00:03: disabled
> --- some other hardware get reconnected ---
> [611203.136277] OOM killer enabled.
> [611203.140637] Restarting tasks ...
> [611203.141135] usb 1-8.1: USB disconnect, device number 7
> [611203.141755] done.
> [611203.155268] random: crng reseeded on system resumption
> [611203.162059] PM: suspend exit
> 
> After investigation, I notice that for the code block
> if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
> 	ksft_exit_fail_msg("Failed to enter Suspend state\n");
> 
> The write will return -1 and errno is set to 16 (device busy).
> It should be caused by the write function is not successfully returned
> before the system suspend and the return value get messed when waking up.
> As a result, It may be better to check the time passed of those few instructions
> to determine whether the suspend is executed correctly for it is pretty hard to
> execute those few lines for 4 seconds, or even more if it is not long enough.

I don't think this is the right fix. Can you change this to do echo instead.
It does the same thing, but it goes through sysfs interface instead of direct
write:

ret = system("echo mem > /sys/power/state");

> 
> Fixes: bfd092b8c2728 ("selftests: breakpoint: add step_after_suspend_test")
> Reported-by: Sinadin Shan <sinadin.shan@oracle.com>
> Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
> ---
>   .../selftests/breakpoints/step_after_suspend_test.c      | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> index dfec31fb9b30d..d615f091e5bae 100644
> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> @@ -18,6 +18,7 @@
>   #include <sys/timerfd.h>
>   #include <sys/types.h>
>   #include <sys/wait.h>
> +#include <time.h>
>   
>   #include "../kselftest.h"
>   
> @@ -133,6 +134,7 @@ void suspend(void)
>   	int timerfd;
>   	int err;
>   	struct itimerspec spec = {};
> +	clock_t t;
>   
>   	if (getuid() != 0)
>   		ksft_exit_skip("Please run the test as root - Exiting.\n");
> @@ -152,8 +154,11 @@ void suspend(void)
>   	if (err < 0)
>   		ksft_exit_fail_msg("timerfd_settime() failed\n");

I don't think you will need to add clock() code. timerfd_settime()
sets the time for 5 seconds and you can simply extend the alarm
time.

There needs to be some logic to check timer elapse and poll the
timer_fd
  
>   
> -	if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
> -		ksft_exit_fail_msg("Failed to enter Suspend state\n");
> +	t = clock();
> +	write(power_state_fd, "mem", strlen("mem"));
> +	t = clock()-t;
> +	if ((int)(t) < 4)
> +			ksft_exit_fail_msg("Failed to enter Suspend state %d\n",errno);
>   
>   	close(timerfd);
>   	close(power_state_fd);

thanks,
-- Shuah

