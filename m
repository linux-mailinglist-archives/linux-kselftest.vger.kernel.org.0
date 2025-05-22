Return-Path: <linux-kselftest+bounces-33524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DAAAC167A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 00:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82361C02C94
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 22:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B87626B95D;
	Thu, 22 May 2025 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YRc4X0pM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950B26B96C
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952047; cv=none; b=SZTpTo3epTmgZLYAQF8AkL0lVA3Hjx2Tti2jLgFRp5r9VHOkNUk75JgBQqkcIDtO+ezbTdlsedH7TldAQ6MH4w00vLExZCU3v0WO6/nTr1H4QP0ugIAQBT4wK9JRDzmZm0FRGHXbknhuVq/WW1QEKPSnDZYIgxWrrO1EVPcT5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952047; c=relaxed/simple;
	bh=jQxZc8Y032ak08Q0emttPc7dQ2u6AroqvGo538WQ7Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKe3CuzE+hEzcrQ2swzWuEz0iePMHak05fZwgNPHRIOkZ96aO06a4YoywDMVQF5ulSCp8GGDfHeYaIp5QSlN8wrzI7fUqCAci6JpSIRO9wXDr+T8Uu7ADgU9zGj8AjXKd3gvAsFOxR/7hUSd46wmgWnBjkM6MIsuB+aNXiP3mXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YRc4X0pM; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso67424295ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 15:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747952044; x=1748556844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5J4a3zUt5UqnI9NTo1FnvOQZ+RKzfc651OJ0pMNk2Gs=;
        b=YRc4X0pMfPYUWM1bs4/3+Q4/UXN1G1BG9c58s0XSuE2Tj/D4eSEhk+n0IZ7eKTw8mw
         7w1lSKvLswgLZdnWm4pt4gS4VgRpJkzq24KPKzLA0beCXKAhtJasey3a+yvr6PgWJEY+
         4xMazALxFNZ2njUdhYPOQPJDU5274rspYIo6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747952044; x=1748556844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5J4a3zUt5UqnI9NTo1FnvOQZ+RKzfc651OJ0pMNk2Gs=;
        b=cPStml8RFRh6kVr3DH2BeZN6+4iL0XpUP964l+52yNfxJN/J8xsuHuDOU/Tjbfa6XF
         CjaCzZB4dr4qD9t741I8k12Wyk3P1dUOk/4EMcTiHvI8MVCoMXe0SsChAyv4oTsFltrD
         O5fyMUyIuOYFRYR6csmf6VApcRP95Yo//IGVVzEUm3GyCQlOCBxgNxn3VHFddDdASmjx
         Gk1HcN+h6Clgn8bu7UrhYUPWQRS0iojl5Ccscj969oZ9+8UHYTxJrRF0lXGSnbE3Z2ZS
         1nQLKek5SguKo4r1EI3YEg0JoM9fF27X29AMVmpvGRy+kCyNWqkheoW2y3ytCNzCQFti
         NIlQ==
X-Gm-Message-State: AOJu0YyoOv68UwBj4Ef9rJVG4J61r4hzU5+r+xDczXcBjoXm60k9FG5O
	RBHwP+JbUuMIHKVAngk+bwlICU+gnW60oMtNcbfSJ7vjr6GWBPdiufbSR5mDcT+/GJ0=
X-Gm-Gg: ASbGncse0eFaBVUNIzacPO7dMjPVjPisJYyFMBGXtWeXnTuRBdyvqdRuruL5i8xFR+B
	gyrmxgT1cN8RzQ1BQw+V4IDwHouxjZxbDsZf4u/xQ7f3H3/cF6sJlEsxukWIrS8C0sCes3EgBOg
	gmMw6MvOa1OiNzK8yWzact9+WsHA1v5ul9zU+W52MetcykFWzf+X1oQmzPtAkgqSyZwgN4SjvtI
	/ec4KpbLeTdaGGjUHN44KB9BpE4n0r4fgW7uHT+gazn+zc8j+4XuMNXPaIGrH3fuii1SQHY+GBE
	jOP2eRv6gDFNC3vedaCIy6CKx8r+pi303p6i9YFNg092C9tDyIJUmP/kakmkXKf6+Y5urxXF
X-Google-Smtp-Source: AGHT+IHZwWolaO+Fli0MkyNXJU+s8LgK5LKgl/nzRVICPjKpFxXTDptFKvju9PZib6E6vi0/FV/j5w==
X-Received: by 2002:a05:6e02:3b89:b0:3ce:8ed9:ca94 with SMTP id e9e14a558f8ab-3db84321c68mr281912535ab.14.1747952044306;
        Thu, 22 May 2025 15:14:04 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc879a918esm9653705ab.41.2025.05.22.15.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:14:03 -0700 (PDT)
Message-ID: <9d502cef-b2cb-4309-b268-7c75f8451833@linuxfoundation.org>
Date: Thu, 22 May 2025 16:14:02 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: Improve test output grammar, code style
To: =?UTF-8?B?SGFubmUtTG90dGEgTcOkZW5ww6TDpA==?= <hannelotta@gmail.com>,
 shuah@kernel.org, alexandre.belloni@bootlin.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250516084233.66594-1-hannelotta@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250516084233.66594-1-hannelotta@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/25 02:42, Hanne-Lotta Mäenpää wrote:
> Add small grammar fixes in perf events and Real Time Clock tests'
> output messages.
> 
> Include braces around a single if statement, when there are multiple
> statements in the else branch, to align with the kernel coding style.

This patch combines several changes in one including combining changes
to two tests.

> 
> Signed-off-by: Hanne-Lotta Mäenpää <hannelotta@gmail.com>
> ---
> 
> Notes:
>      v1 -> v2: Improved wording in RTC tests based on feedback from
>      Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
>   tools/testing/selftests/perf_events/watermark_signal.c |  7 ++++---
>   tools/testing/selftests/rtc/rtctest.c                  | 10 +++++-----
>   2 files changed, 9 insertions(+), 8 deletions(-)
> 

Send separate patches for selftests/perf_events and selftests/rtc/rtctest.c


> diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
> index 49dc1e831174..6176afd4950b 100644
> --- a/tools/testing/selftests/perf_events/watermark_signal.c
> +++ b/tools/testing/selftests/perf_events/watermark_signal.c
> @@ -65,8 +65,9 @@ TEST(watermark_signal)
>   
>   	child = fork();
>   	EXPECT_GE(child, 0);
> -	if (child == 0)
> +	if (child == 0) {
>   		do_child();
> +	}
>   	else if (child < 0) {
>   		perror("fork()");
>   		goto cleanup;
> @@ -75,7 +76,7 @@ TEST(watermark_signal)
>   	if (waitpid(child, &child_status, WSTOPPED) != child ||
>   	    !(WIFSTOPPED(child_status) && WSTOPSIG(child_status) == SIGSTOP)) {
>   		fprintf(stderr,
> -			"failed to sycnhronize with child errno=%d status=%x\n",
> +			"failed to synchronize with child errno=%d status=%x\n",

This change is good.

>   			errno,
>   			child_status);
>   		goto cleanup;
> @@ -84,7 +85,7 @@ TEST(watermark_signal)
>   	fd = syscall(__NR_perf_event_open, &attr, child, -1, -1,
>   		     PERF_FLAG_FD_CLOEXEC);
>   	if (fd < 0) {
> -		fprintf(stderr, "failed opening event %llx\n", attr.config);
> +		fprintf(stderr, "failed to setup performance monitoring %llx\n", attr.config);

This change make it hard to understand what went wrong unlike the original
message.

>   		goto cleanup;
>   	}
>   
> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> index be175c0e6ae3..930bf0ce4fa6 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
> @@ -138,10 +138,10 @@ TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
>   		rtc_read = rtc_time_to_timestamp(&rtc_tm);
>   		/* Time should not go backwards */
>   		ASSERT_LE(prev_rtc_read, rtc_read);
> -		/* Time should not increase more then 1s at a time */
> +		/* Time should not increase more than 1s per read */
>   		ASSERT_GE(prev_rtc_read + 1, rtc_read);
>   
> -		/* Sleep 11ms to avoid killing / overheating the RTC */
> +		/* Sleep 11ms to avoid overheating the RTC */

This change removes important information. What is the reason for this
change?

>   		nanosleep_with_retries(READ_LOOP_SLEEP_MS * 1000000);
>   
>   		prev_rtc_read = rtc_read;
> @@ -236,7 +236,7 @@ TEST_F(rtc, alarm_alm_set) {
>   	if (alarm_state == RTC_ALARM_DISABLED)
>   		SKIP(return, "Skipping test since alarms are not supported.");
>   	if (alarm_state == RTC_ALARM_RES_MINUTE)
> -		SKIP(return, "Skipping test since alarms has only minute granularity.");
> +		SKIP(return, "Skipping test since alarm has only minute granularity.");
>   
>   	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>   	ASSERT_NE(-1, rc);
> @@ -306,7 +306,7 @@ TEST_F(rtc, alarm_wkalm_set) {
>   	if (alarm_state == RTC_ALARM_DISABLED)
>   		SKIP(return, "Skipping test since alarms are not supported.");

This one still says "alarms"

>   	if (alarm_state == RTC_ALARM_RES_MINUTE)
> -		SKIP(return, "Skipping test since alarms has only minute granularity.");
> +		SKIP(return, "Skipping test since alarm has only minute granularity.");

Isn't "alarms" consistent with other messages?

>   
>   	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>   	ASSERT_NE(-1, rc);
> @@ -502,7 +502,7 @@ int main(int argc, char **argv)
>   	if (access(rtc_file, R_OK) == 0)
>   		ret = test_harness_run(argc, argv);
>   	else
> -		ksft_exit_skip("[SKIP]: Cannot access rtc file %s - Exiting\n",
> +		ksft_exit_skip("Cannot access RTC file %s - exiting\n",
>   						rtc_file);

I don't see any reason for this change either.

>   
>   	return ret;

thanks,
-- Shuah

