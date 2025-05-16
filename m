Return-Path: <linux-kselftest+bounces-33170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAEBAB97FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 10:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25AF3BFCF6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 08:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4022DFA5;
	Fri, 16 May 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/sbU/0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599F21FF5D;
	Fri, 16 May 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385087; cv=none; b=bxRLcztGLHBwPQlRkxa2T1xBytDCUCvPvlBVDF7sDEMZTJtE15aR8toZqkbwFgtQ3MTHJ9X8DYH4SlMKZ60x7xKNAKRre6I+yj0YYsPwMnh1ZJ33b5bT3tfjcde2AlUkxgbHZmqsBFwRSIIBoghMCcVATqLo5218sjSXjx7n1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385087; c=relaxed/simple;
	bh=7e/OXKN0NStJdf9sdGtozg9da3NAhB97YtAKvSLueYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xlt3FAW2Wuif38nVK56XzCI0cys5ahKgXdujxkcwD+QHxfa56IMjI0r0YxR3Yp4taWA+CHXHlc888QsHy6EK8SaXg/NFlIDVkB/vH7gq7f/BfJDRbczI9cZ7boKzsATGXTwRlk7Ik9HeNWqD7eCRuSbqOlC+XrGsJs1Uh/j5a/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/sbU/0K; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54c0fa6d455so2150667e87.1;
        Fri, 16 May 2025 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747385083; x=1747989883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjJUr9oGlf0d4GJbWfHcRPedGVrnjrqGO+ZV1su5URQ=;
        b=W/sbU/0KYWFqkeroEVB0c4MnoBR9tGTR6pxbwvu+KUZeGk6/YrOlDtntLLr3EY3ORj
         ewGevl/EUVjstrozQQq4aLiPVDMIIUuR85ieiXtiKVD2wrQnhqfOKvwInA2EU4ka5RZ2
         7G3/LefKwIuYtPMnHBa9h04hX106Y3f7Ql8i5Zb+a9MkY3nwvQiIFFqa/RJ09C/1k+tR
         ztQQglO+fLVg4cgsafqdYbrcuIhrnXJAq5isbvIaZReTgTYvyZhKQXE3r+PnRsL37f6+
         wQMzfIz9wMT5ld1kOiwQRI0VFXGNWO8FCCN77yNqkR/V2TpwqB3sm65Pl+t7aM86GKL2
         y8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747385083; x=1747989883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjJUr9oGlf0d4GJbWfHcRPedGVrnjrqGO+ZV1su5URQ=;
        b=pvQs0ZQts27l7E4UxfQ75BFySax1P4yDmitTXT62oHmrQFnSnQo8dd1vk24gLS6k0Q
         JCTY77jKCf6J6SrkIKBnA8YxpFzTzccRMuSqowJR5XuaxCxZ/I4QsHOeguRG9S5238Gu
         oLHxc2m4AarehJMjf+T+MqmI4Oq7Uh3MBM4HIlckSJVoiRdV3/8PuePI0AfP0SJhHHS2
         LtOWZQeOot/Yyq8cDcs3AWcblbXregv89BbXCoQri0L9qEWeUBgnyXrj09Rs0PrdJOmK
         kffiscYZhrmznDDSkN+oWKSvTOOWjk6XUYYsJ/XisHDd0/i4/cUvuQiTNwGFp1VMUTY6
         1EcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeEsFhbKrQ4oFHd7ywPLjDOlw+tUHvNCqs+PzyVuoDTCRq0zd2o5aTvsQ7b3fvFCW/uTVAb4r1XI8Zspk=@vger.kernel.org, AJvYcCVs9Amh6Tm4EB9KN9aGavS4HrrKZnXMedd+Z2MKqWYptGA3QIFEVtlBC7+lGqVh/jeedsHzszCi+DuX@vger.kernel.org, AJvYcCXmL9ruG8WBjHMvpz0S/VDIGO7sQnxQI5nlySgyX7Ve25qvhJrxV8vtCdwv0rQZCH1Q9CxI+iwDmDd8S76Bu5Ms@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwBEP5gq4EEIi0txF2k8Y6jnT2U+quAJgo2BZfy64qOnu6JkF
	btWjzxvz1EZiAaM06bd5n7wKctzDr0I4gSCLN+1OTmMdtJl5IH+E/gBo
X-Gm-Gg: ASbGncu0BzNHi4Ng60muKIbUq5WWQ1WPu4iRxl4DHnAwDE4QTiYKqYXctd6Hp1RpujT
	OpwU4iDZmEIVku+GEdtJqp/QkHOhz/CvbuGxTdQu9+mLaFve0RtoLe6Zaw9a+rikuqaI70+q8QP
	3yYC2MZ8KxS4XH4XbgiFJxUuCk8rb6NinIo/H/nPIR1Aq7n2IKJpaFSQ2V8e34CpeTDinYgIiFZ
	BYbLPDhKBCbgt3/h7PQfUHWpZ8ZzK9WvA8qTY2rmJ1P/3koHu3Q5Awed8xfumf50RYkD/ZaMRqK
	dT8az47kNXPy2J1e1fb1KKIogE6hAZXf4nH5xx6f4B6P99oeP/ZOuHwmnGw/7kRvyakKYyocYHs
	CgRetm2m7mjo+PY838Us00Hz9+c+2k9Lw4YzbR4WHhn73i25YU3Mwqrx1kFtYQkygoGOFd761iU
	IFWIRPf7f0p0uD
X-Google-Smtp-Source: AGHT+IGzetvgHg8oZtCko1ljUWov76mE1LJ2yWfIXfTog79PcffiRirbLk3BUeMemY7tVa3DIm1Eiw==
X-Received: by 2002:a05:6512:6614:b0:550:e608:410b with SMTP id 2adb3069b0e04-550e71e9968mr605074e87.33.1747385083071;
        Fri, 16 May 2025 01:44:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:53:1500:af87:7c77:739c:7417? (2001-14ba-53-1500-af87-7c77-739c-7417.rev.dnainternet.fi. [2001:14ba:53:1500:af87:7c77:739c:7417])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e702da4dsm325902e87.202.2025.05.16.01.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 01:44:41 -0700 (PDT)
Message-ID: <b1ac8546-b385-4ed9-b15e-da147c35ade3@gmail.com>
Date: Fri, 16 May 2025 11:44:39 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Improve test output grammar, code style
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: skhan@linuxfoundation.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <20250515162249.29510-1-hannelotta@gmail.com>
 <20250515165629d521d4a2@mail.local>
Content-Language: en-US
From: =?UTF-8?B?SGFubmUtTG90dGEgTcOkZW5ww6TDpA==?= <hannelotta@gmail.com>
In-Reply-To: <20250515165629d521d4a2@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 5/15/25 19:56, Alexandre Belloni wrote:
> Hello,
> 
> On 15/05/2025 19:22:49+0300, Hanne-Lotta Mäenpää wrote:
>> Add small grammar fixes in perf events and Real Time Clock tests'
>> output messages.
>>
>> Include braces around a single if statement, when there are multiple
>> statements in the else branch, to align with the kernel coding style.
>>
>> Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
>> ---
>>   tools/testing/selftests/perf_events/watermark_signal.c |  7 ++++---
>>   tools/testing/selftests/rtc/rtctest.c                  | 10 +++++-----
>>   2 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
>> index 49dc1e831174..6176afd4950b 100644
>> --- a/tools/testing/selftests/perf_events/watermark_signal.c
>> +++ b/tools/testing/selftests/perf_events/watermark_signal.c
>> @@ -65,8 +65,9 @@ TEST(watermark_signal)
>>   
>>   	child = fork();
>>   	EXPECT_GE(child, 0);
>> -	if (child == 0)
>> +	if (child == 0) {
>>   		do_child();
>> +	}
> 
> This change seems unrelated.

It is related as a code style fix. I noticed it while reviewing the 
tests, and decided not to make a separate commit of it. Inspiration is 
from the kernel coding style docs, see the second last example in: 
https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces

> 
>>   	else if (child < 0) {
>>   		perror("fork()");
>>   		goto cleanup;
>> @@ -75,7 +76,7 @@ TEST(watermark_signal)
>>   	if (waitpid(child, &child_status, WSTOPPED) != child ||
>>   	    !(WIFSTOPPED(child_status) && WSTOPSIG(child_status) == SIGSTOP)) {
>>   		fprintf(stderr,
>> -			"failed to sycnhronize with child errno=%d status=%x\n",
>> +			"failed to synchronize with child errno=%d status=%x\n",
>>   			errno,
>>   			child_status);
>>   		goto cleanup;
>> @@ -84,7 +85,7 @@ TEST(watermark_signal)
>>   	fd = syscall(__NR_perf_event_open, &attr, child, -1, -1,
>>   		     PERF_FLAG_FD_CLOEXEC);
>>   	if (fd < 0) {
>> -		fprintf(stderr, "failed opening event %llx\n", attr.config);
>> +		fprintf(stderr, "failed to setup performance monitoring %llx\n", attr.config);
>>   		goto cleanup;
>>   	}
>>   
>> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
>> index be175c0e6ae3..8fd4d5d3b527 100644
>> --- a/tools/testing/selftests/rtc/rtctest.c
>> +++ b/tools/testing/selftests/rtc/rtctest.c
>> @@ -138,10 +138,10 @@ TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
>>   		rtc_read = rtc_time_to_timestamp(&rtc_tm);
>>   		/* Time should not go backwards */
>>   		ASSERT_LE(prev_rtc_read, rtc_read);
>> -		/* Time should not increase more then 1s at a time */
>> +		/* Time should not increase more than 1s per read */
>>   		ASSERT_GE(prev_rtc_read + 1, rtc_read);
>>   
>> -		/* Sleep 11ms to avoid killing / overheating the RTC */
>> +		/* Sleep 11ms to avoid overheating the RTC */
>>   		nanosleep_with_retries(READ_LOOP_SLEEP_MS * 1000000);
>>   
>>   		prev_rtc_read = rtc_read;
>> @@ -236,7 +236,7 @@ TEST_F(rtc, alarm_alm_set) {
>>   	if (alarm_state == RTC_ALARM_DISABLED)
>>   		SKIP(return, "Skipping test since alarms are not supported.");
>>   	if (alarm_state == RTC_ALARM_RES_MINUTE)
>> -		SKIP(return, "Skipping test since alarms has only minute granularity.");
>> +		SKIP(return, "Skipping test since alarms have only minute granularity.");
> 
> I guess the proper fix is to remove the s in alarms as there is only one
> alarm.

You are right. I sent patch v2 in another email, with the proposed change.

> 
>>   
>>   	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>>   	ASSERT_NE(-1, rc);
>> @@ -306,7 +306,7 @@ TEST_F(rtc, alarm_wkalm_set) {
>>   	if (alarm_state == RTC_ALARM_DISABLED)
>>   		SKIP(return, "Skipping test since alarms are not supported.");
>>   	if (alarm_state == RTC_ALARM_RES_MINUTE)
>> -		SKIP(return, "Skipping test since alarms has only minute granularity.");
>> +		SKIP(return, "Skipping test since alarms have only minute granularity.");
>>   
>>   	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>>   	ASSERT_NE(-1, rc);
>> @@ -502,7 +502,7 @@ int main(int argc, char **argv)
>>   	if (access(rtc_file, R_OK) == 0)
>>   		ret = test_harness_run(argc, argv);
>>   	else
>> -		ksft_exit_skip("[SKIP]: Cannot access rtc file %s - Exiting\n",
>> +		ksft_exit_skip("Cannot access RTC file %s - exiting\n",
>>   						rtc_file);
>>   
>>   	return ret;
>> -- 
>> 2.39.5
>>
> 

Best regards,

Hanne-Lotta Mäenpää


