Return-Path: <linux-kselftest+bounces-33756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4BBAC363D
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDB93ADC84
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56A25A350;
	Sun, 25 May 2025 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8BD9X9B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765901F8BC6;
	Sun, 25 May 2025 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748197657; cv=none; b=QzYuUHABt03q2YiPCwyivP9oL7vySDVYhYpy4Ia8KhPB7hsV1OvlK51ZlRlZiZBMxq3auywFE6BnmkhNRrjvCG8F+WRmoXu3W14dsHKu1ENE+M//pXrZee8LcCCVlU3usDLsUc1uXsYg1XuI2U8KIDTZvMNdr6WKi4adGJH7lx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748197657; c=relaxed/simple;
	bh=EmK5KrgeY+hlvx0ciwVsijrOsRcC8LDbW9Fuqgm/vg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hs5cuDXpql9G7nmh+ZjHQ3j2yMlmf/we5dws7l/5b2YgkWqvX/Log2/PXakpBFAFd7fYfU3AexkKwgjFUmVRa+iEY2kx7UIBgJzb9FKFEz1cm2ZutVcCkmUgBrFyCQv9ymUFBYneGnocAo9tmxpqqzosHeYkDi6PNEvpl48F1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8BD9X9B; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-551efcb745eso1888550e87.2;
        Sun, 25 May 2025 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748197653; x=1748802453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B48VNScNT/QxfLi0etrqLliUSsojvYpEKyJ92B1Omqc=;
        b=Z8BD9X9Bc/W/P9Z0+9CPrlgvGvhsIN/TUMzgWZwJIpFybj2fLEP9clwJCxnlcSldQZ
         T4rgz5oilBQLCNasVVZN/gkEWvlgzQKQEnKJFjkI8PxmLccMjpruozZSeBuFLuD20GKT
         4iekhBok+mju4mBYNFQjf1nQt3tBgmWT6izlwCRuTxKQPVUOoinIJ2y57qSUTP+w+kGe
         6bRgqQfdA8h2fuQt/EaEnPXz4Vjx20C2Gvr5c9B23HSGD8I/Lx+Gv2AR3hRuCP2HffX7
         oZIfhYG0PHDVC0sN4kP+fnPoMyps17YHhw6h5wloGQ/d7U8x/xvx5SV4vTuPcuV1V1G3
         n8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748197653; x=1748802453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B48VNScNT/QxfLi0etrqLliUSsojvYpEKyJ92B1Omqc=;
        b=C/JGmkyE/QUjC6bCPtKQh/1GC+yETHLo22Aa0GWgTjnqt8AwJDjNO87FCROBP38aRj
         TfXnnBvEZ2hP/YlG+lMufRSqS9kRvtcJGyelDwq4HGnnl+OaiS1ph805WV5HqduS1MwJ
         5etdYL3VHWvGWwxNlRSOJzQkUL59/wQc/yInM9z0lEcUJxLqbHHEOlw8JmdqerBLKamA
         sCE5M/IsPgt7VHS0EfXwsSNNubAB2EYvO0syCvDHYxR+HcY2Gva6DEsScFGgl+lzZMmq
         IkIsJ1B1yL8XR7sjHynmMKOH4z7Ur6yAc9e6z0t9LKlh0Vx9ywIcpCiMoLqCKrJHRw3f
         TnUA==
X-Forwarded-Encrypted: i=1; AJvYcCUThUMTuWVPVSr72L/e1liRzN6SZtbhBWLx497yBlWDH9AtT0oT5SvrhFUq1ZMWBCgfIldXRAbA+xCG@vger.kernel.org, AJvYcCWvqf3qgeCkiZYskM5JlxllsRHW6URL+K6dqxP3FMoAEwLLR3wiQ2ATXOBlyU+tbH4tOiTq+sx7t8MqBqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5zGah8TcBNQM8GZ+C4b13Hyka9KQF1Nxx7IvB/AlJ91FKB36b
	d0JWHVAtOs6Bq7mTDrEG63hI0dj7ctLphc5xhXfeFWOYxfJcy/QBv5gtvVILxvZ4IzU=
X-Gm-Gg: ASbGncv0EOXjSmbFbRTQ4x04FlIdwDeRCkyYyxNNu+2IKc4XrvQKWZKjgz2kbLgfNZs
	ipy/54BknzzDtRPa6XrYiy6rNtcJbpZIO2Lui3H9zTxMliuyvW/BlFPniLUvCDzeQMWwfFUkDvY
	FDW03of+wIKsGlm/J62T58KlHFTiQPN2OIVKWa9uSh/O6Zb7KXG73XQZRDG+xZivUgGgu6YK5zP
	GX24gLcWmMlZoROyVdK/YqzOKNpPbucqPwi0GVEsqhJwu6GNV6jtJdu8HB0Lx3bFRmWWAHP/7AI
	rB1YIOACLVjXsgjoAsYFv6OMg4r2fryWMBVX6wtIt4OBY1GT5fqasVLkhFqaZEBAzDoD/eoGo8A
	05N1fkEE0kqi9In+cygsGnbr/t/jsDbSD5xlIFOVR8ozvfD3kG5N8UfItQBLCE52OMhv7UF84sC
	Zd9hihlz64dC1W
X-Google-Smtp-Source: AGHT+IEWM5XVf20PpAWnQq93UAhnzpP3HFQIVguA1A4WCMI1OJei9G6FhqGLLLeqeKcDQ4xeFDc81A==
X-Received: by 2002:a05:6512:3c8f:b0:545:62c:4b13 with SMTP id 2adb3069b0e04-5521c9b32bfmr1451595e87.40.1748197652946;
        Sun, 25 May 2025 11:27:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:53:1500:f035:2eb8:ff41:8755? (2001-14ba-53-1500-f035-2eb8-ff41-8755.rev.dnainternet.fi. [2001:14ba:53:1500:f035:2eb8:ff41:8755])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703f5c5sm4785325e87.247.2025.05.25.11.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 11:27:32 -0700 (PDT)
Message-ID: <ff076589-4a93-4e4c-8e85-77499e27898c@gmail.com>
Date: Sun, 25 May 2025 21:27:31 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: Improve test output grammar, code style
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
 alexandre.belloni@bootlin.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <20250516084233.66594-1-hannelotta@gmail.com>
 <9d502cef-b2cb-4309-b268-7c75f8451833@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?B?SGFubmUtTG90dGEgTcOkZW5ww6TDpA==?= <hannelotta@gmail.com>
In-Reply-To: <9d502cef-b2cb-4309-b268-7c75f8451833@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 5/23/25 01:14, Shuah Khan wrote:
> On 5/16/25 02:42, Hanne-Lotta Mäenpää wrote:
>> Add small grammar fixes in perf events and Real Time Clock tests'
>> output messages.
>>
>> Include braces around a single if statement, when there are multiple
>> statements in the else branch, to align with the kernel coding style.
> 
> This patch combines several changes in one including combining changes
> to two tests.
> 
>>
>> Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
>> ---
>>
>> Notes:
>>      v1 -> v2: Improved wording in RTC tests based on feedback from
>>      Alexandre Belloni <alexandre.belloni@bootlin.com>
>>
>>   tools/testing/selftests/perf_events/watermark_signal.c |  7 ++++---
>>   tools/testing/selftests/rtc/rtctest.c                  | 10 +++++-----
>>   2 files changed, 9 insertions(+), 8 deletions(-)
>>
> 
> Send separate patches for selftests/perf_events and selftests/rtc/rtctest.c

Sure, I can do that. If I split this patch into two, is it OK to send 
the other patch as a new one (without version history)? Or should I send 
both patches converted to a patch series (v3)?

> 
> 
>> diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/ 
>> tools/testing/selftests/perf_events/watermark_signal.c
>> index 49dc1e831174..6176afd4950b 100644
>> --- a/tools/testing/selftests/perf_events/watermark_signal.c
>> +++ b/tools/testing/selftests/perf_events/watermark_signal.c
>> @@ -65,8 +65,9 @@ TEST(watermark_signal)
>>       child = fork();
>>       EXPECT_GE(child, 0);
>> -    if (child == 0)
>> +    if (child == 0) {
>>           do_child();
>> +    }
>>       else if (child < 0) {
>>           perror("fork()");
>>           goto cleanup;
>> @@ -75,7 +76,7 @@ TEST(watermark_signal)
>>       if (waitpid(child, &child_status, WSTOPPED) != child ||
>>           !(WIFSTOPPED(child_status) && WSTOPSIG(child_status) == 
>> SIGSTOP)) {
>>           fprintf(stderr,
>> -            "failed to sycnhronize with child errno=%d status=%x\n",
>> +            "failed to synchronize with child errno=%d status=%x\n",
> 
> This change is good.
> 
>>               errno,
>>               child_status);
>>           goto cleanup;
>> @@ -84,7 +85,7 @@ TEST(watermark_signal)
>>       fd = syscall(__NR_perf_event_open, &attr, child, -1, -1,
>>                PERF_FLAG_FD_CLOEXEC);
>>       if (fd < 0) {
>> -        fprintf(stderr, "failed opening event %llx\n", attr.config);
>> +        fprintf(stderr, "failed to setup performance monitoring 
>> %llx\n", attr.config);
> 
> This change make it hard to understand what went wrong unlike the original
> message.

Okay, in that case I will leave out this change.

> 
>>           goto cleanup;
>>       }
>> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/ 
>> selftests/rtc/rtctest.c
>> index be175c0e6ae3..930bf0ce4fa6 100644
>> --- a/tools/testing/selftests/rtc/rtctest.c
>> +++ b/tools/testing/selftests/rtc/rtctest.c
>> @@ -138,10 +138,10 @@ TEST_F_TIMEOUT(rtc, date_read_loop, 
>> READ_LOOP_DURATION_SEC + 2) {
>>           rtc_read = rtc_time_to_timestamp(&rtc_tm);
>>           /* Time should not go backwards */
>>           ASSERT_LE(prev_rtc_read, rtc_read);
>> -        /* Time should not increase more then 1s at a time */
>> +        /* Time should not increase more than 1s per read */
>>           ASSERT_GE(prev_rtc_read + 1, rtc_read);
>> -        /* Sleep 11ms to avoid killing / overheating the RTC */
>> +        /* Sleep 11ms to avoid overheating the RTC */
> 
> This change removes important information. What is the reason for this
> change?

Well, it is less verbose and still informative (avoiding overheating). I 
can leave out this change, though.

> 
>>           nanosleep_with_retries(READ_LOOP_SLEEP_MS * 1000000);
>>           prev_rtc_read = rtc_read;
>> @@ -236,7 +236,7 @@ TEST_F(rtc, alarm_alm_set) {
>>       if (alarm_state == RTC_ALARM_DISABLED)
>>           SKIP(return, "Skipping test since alarms are not supported.");
>>       if (alarm_state == RTC_ALARM_RES_MINUTE)
>> -        SKIP(return, "Skipping test since alarms has only minute 
>> granularity.");
>> +        SKIP(return, "Skipping test since alarm has only minute 
>> granularity.");
>>       rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>>       ASSERT_NE(-1, rc);
>> @@ -306,7 +306,7 @@ TEST_F(rtc, alarm_wkalm_set) {
>>       if (alarm_state == RTC_ALARM_DISABLED)
>>           SKIP(return, "Skipping test since alarms are not supported.");
> 
> This one still says "alarms"

Yes, because "alarms are not supported" refers to alarms as a feature.

> 
>>       if (alarm_state == RTC_ALARM_RES_MINUTE)
>> -        SKIP(return, "Skipping test since alarms has only minute 
>> granularity.");
>> +        SKIP(return, "Skipping test since alarm has only minute 
>> granularity.");
> 
> Isn't "alarms" consistent with other messages?

Yes, plural "alarms" would be consistent with other messages, and when 
referring to them as a feature. The verb form should then change, either:

- alarm has ... OR
- alarms have ...

In the test, only one alarm is set - it makes sense to refer to it as 
singular. I received feedback regarding this from Alexandre, because I 
had plural form in the first version of this patch.

> 
>>       rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>>       ASSERT_NE(-1, rc);
>> @@ -502,7 +502,7 @@ int main(int argc, char **argv)
>>       if (access(rtc_file, R_OK) == 0)
>>           ret = test_harness_run(argc, argv);
>>       else
>> -        ksft_exit_skip("[SKIP]: Cannot access rtc file %s - Exiting\n",
>> +        ksft_exit_skip("Cannot access RTC file %s - exiting\n",
>>                           rtc_file);
> 
> I don't see any reason for this change either.

The function ksft_exit_skip already prints the keyword SKIP. It does not 
need to be passed as an argument to the function. Without this change 
the test output shows a duplicate "SKIP":

# 1..0 # SKIP [SKIP]: Cannot access rtc file /dev/rtc0 - Exiting

With this change applied, the output reads:

# 1..0 # SKIP Cannot access RTC file /dev/rtc0 - exiting

The duplicate keyword is omitted.

It might make sense to have this change in its own patch or patch 
series, because there are a few other similar occurrences in the test 
outputs. What do you think?

> 
>>       return ret;
> 
> thanks,
> -- Shuah

Thank you so much!

Best regards,

Hanne-Lotta Mäenpää



