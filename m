Return-Path: <linux-kselftest+bounces-46781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D09C962B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 09:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9656D4E1088
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD21296BCF;
	Mon,  1 Dec 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VHRIP3Va"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6296433985;
	Mon,  1 Dec 2025 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764577897; cv=none; b=ebj2D6czZxOy0oXoMdrmwD0YvCRzSKNfhIBNp8iGzEaFgUnktR4SwNaSTvKlu2VGBwJ1/HJ0zEE8cJYhBy4hwTFOPMK+mvHFYAYjaU+ydZCCA6CzRslmm3hQk1HZjhf7AWhcpp5XSWt1GnuHGoGlXZMMkFHz+bxioH6IYlyPrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764577897; c=relaxed/simple;
	bh=vMqGvNboBBXSS8uY1TjtE7V3YvfgNXOsABIPU5fXf1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fxjh9PwLflYhm6ab+lr8k+Ye9ZPg+UfU7BmNoe8zo5c5XCyvTooyrp6WvKCGl7zvh1yWAlzHKZgQPOzNdfzFq22uvsAj3NLAIwEnWPrZflOhb7dXeuIdXRG2Aan5Jza0gxtHBt2AvI7oOVJxIvUI+9eQlQVo5YD+sgReG2SvrcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VHRIP3Va; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e+5glRbyh0Qf7t2E3ghkZkSak91rQ0ocUQNnzE3DWTs=;
	b=VHRIP3VaNwCh2tYlW6dFMzGABtIqp/6KX/82pWbOnT6eNeURerH/ETjZ7JLKGDqItqhQfZ2bD
	lMO6olMXPjw+LZfLkQIHxcBrE5583Gs7+p/tJu2zCzbChFSYtkMIPspZ9JfrNNljUGb6KgJO5+x
	StZZLr8Gk4OyYAfLEzdOkU8=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dKcWz4l7Cz1T4GL;
	Mon,  1 Dec 2025 16:29:35 +0800 (CST)
Received: from dggpemr200006.china.huawei.com (unknown [7.185.36.167])
	by mail.maildlp.com (Postfix) with ESMTPS id 598B2180478;
	Mon,  1 Dec 2025 16:31:25 +0800 (CST)
Received: from [10.67.110.145] (10.67.110.145) by
 dggpemr200006.china.huawei.com (7.185.36.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 1 Dec 2025 16:31:24 +0800
Message-ID: <cd97e421-849b-4fc1-aeb0-c0865508a5f7@huawei.com>
Date: Mon, 1 Dec 2025 16:31:24 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: breakpoints: check RTC wakeup alarm support
 before test
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
CC: Moon Hee Lee <moonhee.lee.ca@gmail.com>, <yifei.l.liu@oracle.com>,
	<zhujun2@cmss.chinamobile.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zouyipeng@huawei.com>
References: <20251112061532.2867859-1-zhengxinyu6@huawei.com>
 <b0ceed9c-3ff6-4eee-80e3-f50631bb1230@linuxfoundation.org>
Content-Language: en-US
From: Xinyu Zheng <zhengxinyu6@huawei.com>
In-Reply-To: <b0ceed9c-3ff6-4eee-80e3-f50631bb1230@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemr200006.china.huawei.com (7.185.36.167)



On 11/20/2025 6:15 AM, Shuah Khan wrote:
> On 11/11/25 23:15, Xinyu Zheng wrote:
>> If RTC wakeup alarm feature is unsupported, this testcase may cause
> 
> It may cause infinite suspend? Doesn't sound definitive.> infinite 
> suspend if there is no other wakeup source. To solve this
>> problem, set wakeup alarm up before we trigger suspend. In this case,
>> we can test if RTC support RTC_FEATURE_ALARM and efi_set_alarm function.
>>
> 
> For a "may cause" problem, this change> Signed-off-by: Xinyu Zheng 
> <zhengxinyu6@huawei.com>
>> --->   .../breakpoints/step_after_suspend_test.c     | 23 ++++++++++++ 
>> +++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/tools/testing/selftests/breakpoints/ 
>> step_after_suspend_test.c b/tools/testing/selftests/breakpoints/ 
>> step_after_suspend_test.c
>> index 8d233ac95696..e738af896ce1 100644
>> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
>> @@ -13,6 +13,8 @@
>>   #include <stdio.h>
>>   #include <string.h>
>>   #include <unistd.h>
>> +#include <linux/rtc.h>
>> +#include <sys/ioctl.h>
>>   #include <sys/ptrace.h>
>>   #include <sys/stat.h>
>>   #include <sys/timerfd.h>
>> @@ -159,10 +161,30 @@ void suspend(void)
>>       int count_before;
>>       int count_after;
>>       struct itimerspec spec = {};
>> +    char *rtc_file = "/dev/rtc0";
>> +    int rtc_fd;
>> +    struct rtc_wkalrm alarm = { 0 };
>> +    time_t secs;
>>       if (getuid() != 0)
>>           ksft_exit_skip("Please run the test as root - Exiting.\n");
>> +    rtc_fd = open(rtc_file, O_RDONLY);
>> +    if (rtc_fd < 0)
>> +        ksft_exit_fail_msg("open rtc0 failed\n");
>> +
>> +    err = ioctl(rtc_fd, RTC_RD_TIME, &alarm.time);
>> +    if (err < 0)
>> +        ksft_exit_fail_msg("get rtc time failed\n");
>> +
>> +    secs = timegm((struct tm *)&alarm.time) + 3;
>> +    gmtime_r(&secs, (struct tm *)&alarm.time);
>> +    alarm.enabled = 1;
>> +
>> +    err = ioctl(rtc_fd, RTC_WKALM_SET, &alarm);
>> +    if (err < 0)
>> +        ksft_exit_fail_msg("set wake alarm test failed, errno %d\n", 
>> errno);
> 
> Essentially with this change the test doesn't run unless
> RTC wake is supported. That sounds restrictive - is there
> another way do do this?

Hi, Shuah.

If RTC wake is a must in this testcase?

In my test, when EFI report supporting EFI_RT_SUPPORTED_SET_WAKEUP_TIME.
There will be a alarmtimer.0.auto under /sys/class/rtc/rtc0/，while 
suspending, I found alarmtimer will also been suspended and pass the 
wakeup job to RTC. When RTC calls efi_set_alarm(), this function returns 
EFI_UNSUPPORTED then suspend fails.

When EFI doesn't report supporting EFI_RT_SUPPORTED_SET_WAKEUP_TIME, 
there is no /sys/class/rtc/rtc0/alarmtimer.0.auto and alarmtimer is not 
a suspend target. Then suspend success, but never wakeup.

> 
>> +
>>       timerfd = timerfd_create(CLOCK_BOOTTIME_ALARM, 0);
>>       if (timerfd < 0)
>>           ksft_exit_fail_msg("timerfd_create() failed\n");
>> @@ -180,6 +202,7 @@ void suspend(void)
>>       if (count_after <= count_before)
>>           ksft_exit_fail_msg("Failed to enter Suspend state\n");
>> +    close(rtc_fd);
>>       close(timerfd);
>>   }
>>
> thanks,
> -- Shuah

-- 
Xinyu Zheng


