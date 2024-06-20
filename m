Return-Path: <linux-kselftest+bounces-12360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF991123E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 21:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA62816B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 19:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB2B1B9AAB;
	Thu, 20 Jun 2024 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Iqx0o8GG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE01B3727;
	Thu, 20 Jun 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912223; cv=none; b=HPZFbPnb/hoYKcCzex9xo+4RFx5WjQSg/jUWR/PPwF3LJubSDzRz3gLYzrwW8bQ1b6WsBkFQ8dqNJJxD5kLaKELRA+VUBPc6hKMnRLju5S82jfgLS8PU4ZcyOqYvxxF+4XrCJ2+i6NzhRW8plBmQEC0kkhs1hn/68qHK4ucX9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912223; c=relaxed/simple;
	bh=5IdMw3CS1Y7sK1lonjSlEocrecNZz6o8+weAxEgWr3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UctYpf07hmJ3haURztyf2jwmAq3mtzv4jbQ5rbUIV8okPPN69kTAGT/+ayULE80RT7Emp1KDa88UTO/fE/bI9UDmFqo03SfIae/+va7Q4HfyMBxv+JBkf6g/8z8bLIXjb8ogcSAqXrqXC1qLR8ahuYEbEmVVx5v6hbQpmfSghqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Iqx0o8GG; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C1851C0003;
	Thu, 20 Jun 2024 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718912216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5I7UdPfxtD1iHOoR6mQl8rKZBvIJT2OuGxvghk0fROk=;
	b=Iqx0o8GGvnpfXdtfCyUqdTTnWO3tw0V67hm0sLPQSRpXklMHtfFDJZa8xiywocXm0RMkki
	joMEruEX0uf1FftOx8a+ynLw77d1NbrF9j1LA9gHDnAwoymjba5IXB5MiK2kzlNJYECZiO
	Jk9Jd565OPKm1R87IZ2cdHHd+0wSgyy7J1WEl52e/1k6olrpSuAowwUVWLUzeeg0c+3uxZ
	Dr6NNvHJfqKYuz6wgzL++WkO4FyZYYlCqz9Nl3DoB/JyfvyJ7xmzfwF04qOGgF1h02o642
	66IOwM9ckZSnPFiJ9OooSYgRmET8V8gYRgKIS69EnHBFCZIeic1tOZPgOpfZcg==
Date: Thu, 20 Jun 2024 21:36:54 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, avagin@google.com, amir73il@gmail.com,
	brauner@kernel.org, mochs@nvidia.com, kobak@nvidia.com,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] selftest: rtc: Add to check rtc alarm status for
 alarm related test
Message-ID: <20240620193654d3cd1f05@mail.local>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-2-jjang@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524013807.154338-2-jjang@nvidia.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 23/05/2024 18:38:06-0700, Joseph Jang wrote:
> In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
> ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
> skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
> code. This design may miss detecting real problems when the
> efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
> ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.
> 
> In order to make rtctest more explicit and robust, we propose to use
> RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
> running alarm related tests. If the kernel does not support RTC_PARAM_GET
> ioctl interface, we will fallback to check the error number of
> (RTC_ALM_SET/RTC_WKALM_SET) ioctl call for alarm feature detection.
> 
> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
> as optional")
> 
> Reviewed-by: Koba Ko <kobak@nvidia.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> Signed-off-by: Joseph Jang <jjang@nvidia.com>
> ---
>  tools/testing/selftests/rtc/Makefile  |  2 +-
>  tools/testing/selftests/rtc/rtctest.c | 64 +++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
> index 55198ecc04db..6e3a98fb24ba 100644
> --- a/tools/testing/selftests/rtc/Makefile
> +++ b/tools/testing/selftests/rtc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/

Is this change actually needed?

>  LDLIBS += -lrt -lpthread -lm
>  
>  TEST_GEN_PROGS = rtctest
> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> index 63ce02d1d5cc..2b12497eb30d 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
> @@ -25,6 +25,12 @@
>  
>  static char *rtc_file = "/dev/rtc0";
>  
> +enum rtc_alarm_state {
> +	RTC_ALARM_UNKNOWN,
> +	RTC_ALARM_ENABLED,
> +	RTC_ALARM_DISABLED,
> +};
> +
>  FIXTURE(rtc) {
>  	int fd;
>  };
> @@ -82,6 +88,24 @@ static void nanosleep_with_retries(long ns)
>  	}
>  }
>  
> +static enum rtc_alarm_state get_rtc_alarm_state(int fd)
> +{
> +	struct rtc_param param = { 0 };
> +	int rc;
> +
> +	/* Validate kernel reflects unsupported RTC alarm state */
> +	param.param = RTC_PARAM_FEATURES;
> +	param.index = 0;
> +	rc = ioctl(fd, RTC_PARAM_GET, &param);
> +	if (rc < 0)
> +		return RTC_ALARM_UNKNOWN;
> +
> +	if ((param.uvalue & _BITUL(RTC_FEATURE_ALARM)) == 0)
> +		return RTC_ALARM_DISABLED;
> +
> +	return RTC_ALARM_ENABLED;
> +}
> +
>  TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
>  	int rc;
>  	long iter_count = 0;
> @@ -197,11 +221,16 @@ TEST_F(rtc, alarm_alm_set) {
>  	fd_set readfds;
>  	time_t secs, new;
>  	int rc;
> +	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
>  
>  	if (self->fd == -1 && errno == ENOENT)
>  		SKIP(return, "Skipping test since %s does not exist", rtc_file);
>  	ASSERT_NE(-1, self->fd);
>  
> +	alarm_state = get_rtc_alarm_state(self->fd);
> +	if (alarm_state == RTC_ALARM_DISABLED)
> +		SKIP(return, "Skipping test since alarms are not supported.");
> +
>  	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>  	ASSERT_NE(-1, rc);
>  
> @@ -210,6 +239,11 @@ TEST_F(rtc, alarm_alm_set) {
>  
>  	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
>  	if (rc == -1) {
> +		/*
> +		 * Report error if rtc alarm was enabled. Fallback to check ioctl
> +		 * error number if rtc alarm state is unknown.
> +		 */
> +		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
>  		ASSERT_EQ(EINVAL, errno);
>  		TH_LOG("skip alarms are not supported.");
>  		return;
> @@ -255,11 +289,16 @@ TEST_F(rtc, alarm_wkalm_set) {
>  	fd_set readfds;
>  	time_t secs, new;
>  	int rc;
> +	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
>  
>  	if (self->fd == -1 && errno == ENOENT)
>  		SKIP(return, "Skipping test since %s does not exist", rtc_file);
>  	ASSERT_NE(-1, self->fd);
>  
> +	alarm_state = get_rtc_alarm_state(self->fd);
> +	if (alarm_state == RTC_ALARM_DISABLED)
> +		SKIP(return, "Skipping test since alarms are not supported.");
> +
>  	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>  	ASSERT_NE(-1, rc);
>  
> @@ -270,6 +309,11 @@ TEST_F(rtc, alarm_wkalm_set) {
>  
>  	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
>  	if (rc == -1) {
> +		/*
> +		 * Report error if rtc alarm was enabled. Fallback to check ioctl
> +		 * error number if rtc alarm state is unknown.
> +		 */
> +		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
>  		ASSERT_EQ(EINVAL, errno);
>  		TH_LOG("skip alarms are not supported.");
>  		return;
> @@ -307,11 +351,16 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
>  	fd_set readfds;
>  	time_t secs, new;
>  	int rc;
> +	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
>  
>  	if (self->fd == -1 && errno == ENOENT)
>  		SKIP(return, "Skipping test since %s does not exist", rtc_file);
>  	ASSERT_NE(-1, self->fd);
>  
> +	alarm_state = get_rtc_alarm_state(self->fd);
> +	if (alarm_state == RTC_ALARM_DISABLED)
> +		SKIP(return, "Skipping test since alarms are not supported.");
> +
>  	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>  	ASSERT_NE(-1, rc);
>  
> @@ -320,6 +369,11 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
>  
>  	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
>  	if (rc == -1) {
> +		/*
> +		 * Report error if rtc alarm was enabled. Fallback to check ioctl
> +		 * error number if rtc alarm state is unknown.
> +		 */
> +		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
>  		ASSERT_EQ(EINVAL, errno);
>  		TH_LOG("skip alarms are not supported.");
>  		return;
> @@ -365,11 +419,16 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
>  	fd_set readfds;
>  	time_t secs, new;
>  	int rc;
> +	enum rtc_alarm_state alarm_state = RTC_ALARM_UNKNOWN;
>  
>  	if (self->fd == -1 && errno == ENOENT)
>  		SKIP(return, "Skipping test since %s does not exist", rtc_file);
>  	ASSERT_NE(-1, self->fd);
>  
> +	alarm_state = get_rtc_alarm_state(self->fd);
> +	if (alarm_state == RTC_ALARM_DISABLED)
> +		SKIP(return, "Skipping test since alarms are not supported.");
> +
>  	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>  	ASSERT_NE(-1, rc);
>  
> @@ -380,6 +439,11 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
>  
>  	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
>  	if (rc == -1) {
> +		/*
> +		 * Report error if rtc alarm was enabled. Fallback to check ioctl
> +		 * error number if rtc alarm state is unknown.
> +		 */
> +		ASSERT_EQ(RTC_ALARM_UNKNOWN, alarm_state);
>  		ASSERT_EQ(EINVAL, errno);
>  		TH_LOG("skip alarms are not supported.");
>  		return;
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

