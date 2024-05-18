Return-Path: <linux-kselftest+bounces-10380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CC78C9235
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 May 2024 22:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B3BB212F2
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 May 2024 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879C754917;
	Sat, 18 May 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ks9HmXPB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCC1DA32;
	Sat, 18 May 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716063845; cv=none; b=i/ZOrDwoo1yTBQORiB6vQvuLUvooWtDurEj47FNzKMvck3lPVURkcNiOFfw7AfKJ0YuzS83UEj5EAdWIJtkFJajQ8k/qcD8vW66OQ//rg6TSPvAPeLx/GroOlpbEh4ToTAypCQzOEWlbI046a85anZMUvz4ZwaqgJVs9/Q0Wi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716063845; c=relaxed/simple;
	bh=YiD1ycF15N6PaFBhh9tpXdWF4xWXfiVXebccqOFhXVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0pokd0XE84ZXB67jNOcYtG/mXg5OLQ1BLZBPMYrkx1WdmqTx+hTrJhIg5SFmIx6uzdslbuV2LAiAm3cKs0gtf9oWsR+GD5Z24RiCQozA7+1UD+9oINMzu/i15lHsJ6LakVI/SXHCdq1YtEX4c9yW1WYDUb38ZiodTmlFEW8oJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ks9HmXPB; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63DCF240003;
	Sat, 18 May 2024 20:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716063834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RR3IeFPTXcx+EVwTZpzFwWNydln/CbCYUcUKiGCqsiA=;
	b=ks9HmXPBU71nW4aw0C+/3xXKONfJuSnO7a2sk2xrghhirOLw26OqVzMjF+JvcWBSFQadrf
	/EVEo+aWhqKz/fdQTnatXV09wVdzGTU/IEiEo0HdERfCa1tZSUrafmYGB3F5/HXZ1B77Aa
	nlbJlgaQYygquAq5ykjOcGYWwRx3ua1RCQrBa/40Z+mnKETDioxB/PyzFplToGSpOg3gY/
	hsXMtmeXcJDDXmbE4Ej8rPbvU9RU5fxLgmlMapVJ0RVJbPHR8mbvfehNgKt2QEAESmxshy
	j7WdX9FwCj/FcgqU/xsLrVsLHU5toViFEjPwHgtLZzOJgEOsOFaLEaEVnkXyqA==
Date: Sat, 18 May 2024 22:23:54 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: rtc: rtctest: Do not open-code
 TEST_HARNESS_MAIN
Message-ID: <20240518202354d5422c77@mail.local>
References: <20240518001655.work.053-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518001655.work.053-kees@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 17/05/2024 17:16:58-0700, Kees Cook wrote:
> Argument processing is specific to the test harness code. Any optional
> information needs to be passed via environment variables. Move alternate
> path to the RTC_DEV environment variable. Also do not open-code
> TEST_HARNESS_MAIN because its definition may change.

Th main issue doing that is that this breaks the main use case of
rtctest as /dev/rtc1 is usually the main target for those tests. Having
the RTC_DEV environment variable only documented n this commit message
is definitively not enough, I'm going to have to handle zillion of
complaints that this is not working anymore.

> 
> Additionally, setup checking can be done in the FIXTURE_SETUP(). With
> this adjustment, also improve the error reporting when the device cannot
> be opened.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/rtc/Makefile  |  2 +-
>  tools/testing/selftests/rtc/rtctest.c | 66 +++++----------------------
>  2 files changed, 13 insertions(+), 55 deletions(-)
> 
> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
> index 55198ecc04db..654f9d58da3c 100644
> --- a/tools/testing/selftests/rtc/Makefile
> +++ b/tools/testing/selftests/rtc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
> +CFLAGS += -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>  LDLIBS += -lrt -lpthread -lm
>  
>  TEST_GEN_PROGS = rtctest
> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> index 63ce02d1d5cc..41cfefcc20e1 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
> @@ -30,7 +30,18 @@ FIXTURE(rtc) {
>  };
>  
>  FIXTURE_SETUP(rtc) {
> +	char *alternate = getenv("RTC_DEV");
> +
> +	if (alternate)
> +		rtc_file = alternate;
> +
>  	self->fd = open(rtc_file, O_RDONLY);
> +
> +	if (self->fd == -1 && errno == ENOENT)
> +		SKIP(return, "Skipping test since %s does not exist", rtc_file);
> +	EXPECT_NE(-1, self->fd) {
> +		TH_LOG("%s: %s\n", rtc_file, strerror(errno));
> +	}
>  }
>  
>  FIXTURE_TEARDOWN(rtc) {
> @@ -41,10 +52,6 @@ TEST_F(rtc, date_read) {
>  	int rc;
>  	struct rtc_time rtc_tm;
>  
> -	if (self->fd == -1 && errno == ENOENT)
> -		SKIP(return, "Skipping test since %s does not exist", rtc_file);
> -	ASSERT_NE(-1, self->fd);
> -
>  	/* Read the RTC time/date */
>  	rc = ioctl(self->fd, RTC_RD_TIME, &rtc_tm);
>  	ASSERT_NE(-1, rc);
> @@ -88,10 +95,6 @@ TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
>  	struct rtc_time rtc_tm;
>  	time_t start_rtc_read, prev_rtc_read;
>  
> -	if (self->fd == -1 && errno == ENOENT)
> -		SKIP(return, "Skipping test since %s does not exist", rtc_file);
> -	ASSERT_NE(-1, self->fd);
> -
>  	TH_LOG("Continuously reading RTC time for %ds (with %dms breaks after every read).",
>  	       READ_LOOP_DURATION_SEC, READ_LOOP_SLEEP_MS);
>  
> @@ -126,10 +129,6 @@ TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
>  	int i, rc, irq = 0;
>  	unsigned long data;
>  
> -	if (self->fd == -1 && errno == ENOENT)
> -		SKIP(return, "Skipping test since %s does not exist", rtc_file);
> -	ASSERT_NE(-1, self->fd);
> -
>  	/* Turn on update interrupts */
>  	rc = ioctl(self->fd, RTC_UIE_ON, 0);
>  	if (rc == -1) {
> @@ -155,10 +154,6 @@ TEST_F(rtc, uie_select) {
>  	int i, rc, irq = 0;
>  	unsigned long data;
>  
> -	if (self->fd == -1 && errno == ENOENT)
> -		SKIP(return, "Skipping test since %s does not exist", rtc_file);
> -	ASSERT_NE(-1, self->fd);
> -
>  	/* Turn on update interrupts */
>  	rc = ioctl(self->fd, RTC_UIE_ON, 0);
>  	if (rc == -1) {
> @@ -198,10 +193,6 @@ TEST_F(rtc, alarm_alm_set) {
>  	time_t secs, new;
>  	int rc;
>  
> -	if (self->fd == -1 && errno == ENOENT)
> -		SKIP(return, "Skipping test since %s does not exist", rtc_file);
> -	ASSERT_NE(-1, self->fd);
> -
>  	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>  	ASSERT_NE(-1, rc);
>  
> @@ -256,10 +247,6 @@ TEST_F(rtc, alarm_wkalm_set) {
>  	time_t secs, new;
>  	int rc;
>  
> -	if (self->fd == -1 && errno == ENOENT)
> -		SKIP(return, "Skipping test since %s does not exist", rtc_file);
> -	ASSERT_NE(-1, self->fd);
> -
>  	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>  	ASSERT_NE(-1, rc);
>  
> @@ -308,10 +295,6 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
>  	time_t secs, new;
>  	int rc;
>  
> -	if (self->fd == -1 && errno == ENOENT)
> -		SKIP(return, "Skipping test since %s does not exist", rtc_file);
> -	ASSERT_NE(-1, self->fd);
> -
>  	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>  	ASSERT_NE(-1, rc);
>  
> @@ -366,10 +349,6 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
>  	time_t secs, new;
>  	int rc;
>  
> -	if (self->fd == -1 && errno == ENOENT)
> -		SKIP(return, "Skipping test since %s does not exist", rtc_file);
> -	ASSERT_NE(-1, self->fd);
> -
>  	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>  	ASSERT_NE(-1, rc);
>  
> @@ -410,25 +389,4 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
>  	ASSERT_EQ(new, secs);
>  }
>  
> -static void __attribute__((constructor))
> -__constructor_order_last(void)
> -{
> -	if (!__constructor_order)
> -		__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD;
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	switch (argc) {
> -	case 2:
> -		rtc_file = argv[1];
> -		/* FALLTHROUGH */
> -	case 1:
> -		break;
> -	default:
> -		fprintf(stderr, "usage: %s [rtcdev]\n", argv[0]);
> -		return 1;
> -	}
> -
> -	return test_harness_run(argc, argv);
> -}
> +TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

