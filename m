Return-Path: <linux-kselftest+bounces-33091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A960AB8CEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B302170139
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089CE253F12;
	Thu, 15 May 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yeq4xTzq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5751253F05;
	Thu, 15 May 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328200; cv=none; b=J1JHccBhi6AszhE2Cf88VqeLIUYKZOaQdi9OK3XHJrlsdJKNXb5Vz0vvnofPUIJtuvECwvnexATCB+rMb9oAC0ue5sapzIiJ1oduTucivJ/lOnsRYc6OtuxCMKuu7oU++Vxr9auCWiSDmtkWBeYQ2+nGM7F4PKc4OFCeta5aW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328200; c=relaxed/simple;
	bh=liF9HQU73Y1V33+QCLJQcjuo5u/lGOVfvzJrGkjngKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtfxsjJ8/qGcbU4GzOU1QqWhSt7pxWPIY47dYye6Gw+TueB4lza7gTbslu6+My5xvVW7jMCzQz3r+I4HlY++ywjIlUiGNmBhzuhcn28KiJ90cB02/VEZK0wKoCgTEbNNwDvgCpRQOxCllHXPIv9aXXI+AQmPeyEjdM5mawitgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yeq4xTzq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 638EE43A2D;
	Thu, 15 May 2025 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747328190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=raaP+KDofYfVOADwgCehv+q7d8tCAGS8f0t0aRx5CLk=;
	b=Yeq4xTzqoRNxfz75hyllirDVfSLRpQPTjsEiUzWPV1uVeSh/FDMGMe18ms4mTQ7fDJoago
	gq7A3eLSnJQ2YvueSUOQAsO8Qe924MQw0h81BfMOs65DTDlWQfwZr6wnQg9Hg87l0UUKeW
	KebN30kYphNREIopD065oorA+Uh5WRFcZ65JHv8k5DEhur/O8jAnRHyo8QiCK10u3q7h7g
	XtwSWr6zMUBPmr7rAlMyAS8dE1DCeVReV+2Ye5TBK8mky7JbpvHxseWmGky9GN1QyiJNuv
	7Fr/j/2CjfU8cDgi2YfXS0/qftiiCGWX/4I7J0VDmAOKF2hnOZoG8kR3yIM/Og==
Date: Thu, 15 May 2025 18:56:29 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Hanne-Lotta =?iso-8859-1?B?TeRlbnDk5A==?= <hannelotta@gmail.com>
Cc: skhan@linuxfoundation.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH] selftests: Improve test output grammar, code style
Message-ID: <20250515165629d521d4a2@mail.local>
References: <20250515162249.29510-1-hannelotta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515162249.29510-1-hannelotta@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtgedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevudevhfdvheelgfeileefteduuefghefguefgkeeljeeufeeutedtffeuteeivdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepgeeirdduleefrdejkedruddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeegiedrudelfedrjeekrddutddtpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohephhgrnhhnvghlohhtthgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhkhhgrnheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhttgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello,

On 15/05/2025 19:22:49+0300, Hanne-Lotta M‰enp‰‰ wrote:
> Add small grammar fixes in perf events and Real Time Clock tests'
> output messages.
> 
> Include braces around a single if statement, when there are multiple
> statements in the else branch, to align with the kernel coding style.
> 
> Signed-off-by: Hanne-Lotta M‰enp‰‰ <hannelotta@gmail.com>
> ---
>  tools/testing/selftests/perf_events/watermark_signal.c |  7 ++++---
>  tools/testing/selftests/rtc/rtctest.c                  | 10 +++++-----
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
> index 49dc1e831174..6176afd4950b 100644
> --- a/tools/testing/selftests/perf_events/watermark_signal.c
> +++ b/tools/testing/selftests/perf_events/watermark_signal.c
> @@ -65,8 +65,9 @@ TEST(watermark_signal)
>  
>  	child = fork();
>  	EXPECT_GE(child, 0);
> -	if (child == 0)
> +	if (child == 0) {
>  		do_child();
> +	}

This change seems unrelated.

>  	else if (child < 0) {
>  		perror("fork()");
>  		goto cleanup;
> @@ -75,7 +76,7 @@ TEST(watermark_signal)
>  	if (waitpid(child, &child_status, WSTOPPED) != child ||
>  	    !(WIFSTOPPED(child_status) && WSTOPSIG(child_status) == SIGSTOP)) {
>  		fprintf(stderr,
> -			"failed to sycnhronize with child errno=%d status=%x\n",
> +			"failed to synchronize with child errno=%d status=%x\n",
>  			errno,
>  			child_status);
>  		goto cleanup;
> @@ -84,7 +85,7 @@ TEST(watermark_signal)
>  	fd = syscall(__NR_perf_event_open, &attr, child, -1, -1,
>  		     PERF_FLAG_FD_CLOEXEC);
>  	if (fd < 0) {
> -		fprintf(stderr, "failed opening event %llx\n", attr.config);
> +		fprintf(stderr, "failed to setup performance monitoring %llx\n", attr.config);
>  		goto cleanup;
>  	}
>  
> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> index be175c0e6ae3..8fd4d5d3b527 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
> @@ -138,10 +138,10 @@ TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
>  		rtc_read = rtc_time_to_timestamp(&rtc_tm);
>  		/* Time should not go backwards */
>  		ASSERT_LE(prev_rtc_read, rtc_read);
> -		/* Time should not increase more then 1s at a time */
> +		/* Time should not increase more than 1s per read */
>  		ASSERT_GE(prev_rtc_read + 1, rtc_read);
>  
> -		/* Sleep 11ms to avoid killing / overheating the RTC */
> +		/* Sleep 11ms to avoid overheating the RTC */
>  		nanosleep_with_retries(READ_LOOP_SLEEP_MS * 1000000);
>  
>  		prev_rtc_read = rtc_read;
> @@ -236,7 +236,7 @@ TEST_F(rtc, alarm_alm_set) {
>  	if (alarm_state == RTC_ALARM_DISABLED)
>  		SKIP(return, "Skipping test since alarms are not supported.");
>  	if (alarm_state == RTC_ALARM_RES_MINUTE)
> -		SKIP(return, "Skipping test since alarms has only minute granularity.");
> +		SKIP(return, "Skipping test since alarms have only minute granularity.");

I guess the proper fix is to remove the s in alarms as there is only one
alarm.

>  
>  	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>  	ASSERT_NE(-1, rc);
> @@ -306,7 +306,7 @@ TEST_F(rtc, alarm_wkalm_set) {
>  	if (alarm_state == RTC_ALARM_DISABLED)
>  		SKIP(return, "Skipping test since alarms are not supported.");
>  	if (alarm_state == RTC_ALARM_RES_MINUTE)
> -		SKIP(return, "Skipping test since alarms has only minute granularity.");
> +		SKIP(return, "Skipping test since alarms have only minute granularity.");
>  
>  	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>  	ASSERT_NE(-1, rc);
> @@ -502,7 +502,7 @@ int main(int argc, char **argv)
>  	if (access(rtc_file, R_OK) == 0)
>  		ret = test_harness_run(argc, argv);
>  	else
> -		ksft_exit_skip("[SKIP]: Cannot access rtc file %s - Exiting\n",
> +		ksft_exit_skip("Cannot access RTC file %s - exiting\n",
>  						rtc_file);
>  
>  	return ret;
> -- 
> 2.39.5
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

