Return-Path: <linux-kselftest+bounces-10332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5C8C8144
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 09:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5D95B215EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A16417597;
	Fri, 17 May 2024 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B1E5jVNP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491AF16415;
	Fri, 17 May 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930402; cv=none; b=HC5oDAKnFtzt8ERdH8lSw3BrWiTFqVNqB/b1zsZBPxhHe4DzIKHtDhERnzvMTYbYThRyZY4ypww29f4aF988nYAXw+j4tnA2DYLsOl4mxLPrmUGjBLE63Wsoco4s3+DWMZvALxCEz8jLpmxH2riz3AUOUfDt1700UshquWTADmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930402; c=relaxed/simple;
	bh=BGck91VU9beP2abZzw/rtJxU09+f8W3SkIsxCeaIzKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex2gnrfPvbHrekEovTpKRUoZ24v7+HZ9xlioaWmZIVI3FAxsgRmHTqxGPpInMPrjqLyr1tQ07o/alwLakgE9OLbX1eOpKVuex06KA+ccAfN4puqQmeEqdMiUYlFf0Ljauo1BmjBC9sygK1G/CxuMp9yMozQIsj1ZHj7LpibAfYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B1E5jVNP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F1411C000C;
	Fri, 17 May 2024 07:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715930397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vtNkh6lct/Bn//Hd3X1lliFFmrekYtlN0ngpcECGIUU=;
	b=B1E5jVNP6+dsEJDwkBKDWpecNxgeRnRXcNfwDW5Q2qETDxSRVCgB82AwM+bpnqb2oXwV+c
	ocAq5qyOYOggpTa+SY3n35xbcYwndztV8ync4V6t652cnDQXLe1z19pZPK0aI4pS4cep7n
	dBMXEybf9YMuBPpE/9HQO3pYlmeuo4uOzLODEKbgM37y8ZlQqVDYO0T2zztZ58xGoMM9dd
	JFbea6F5/xhiJRogH/I31z675gY5qyPuawBF58E5JoWkLI87Ip4IuA6I+48/CnykID7GAG
	YkTXFmUrIECiNf6dLsKtoGseEsF8Uno7sm4JTofzJUfetBkGqMe9J/N7aWUGFg==
Date: Fri, 17 May 2024 09:19:51 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, avagin@google.com, amir73il@gmail.com,
	brauner@kernel.org, mochs@nvidia.com, jszu@nvidia.com,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] selftest: rtc: Add to check rtc alarm status for alarm
 related test
Message-ID: <202405170719515a9c6d2f@mail.local>
References: <20240517022847.4094731-1-jjang@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517022847.4094731-1-jjang@nvidia.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 16/05/2024 19:28:47-0700, Joseph Jang wrote:
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
> ioctl interface, we will fallback to check the presence of "alarm" in
> /proc/driver/rtc.
> 
> The rtctest requires the read permission on /dev/rtc0. The rtctest will
> be skipped if the /dev/rtc0 is not readable.
> 

This change as to be separated. Also, I'm not sure what happened with
https://lore.kernel.org/all/20230717175251.54390-1-atulpant.linux@gmail.com/

> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
> as optional")
> 
> Reviewed-by: Jeremy Szu <jszu@nvidia.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> Signed-off-by: Joseph Jang <jjang@nvidia.com>
> ---
>  tools/testing/selftests/rtc/Makefile  |  2 +-
>  tools/testing/selftests/rtc/rtctest.c | 72 +++++++++++++++++++--------
>  2 files changed, 53 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
> index 55198ecc04db..6e3a98fb24ba 100644
> --- a/tools/testing/selftests/rtc/Makefile
> +++ b/tools/testing/selftests/rtc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/
>  LDLIBS += -lrt -lpthread -lm
>  
>  TEST_GEN_PROGS = rtctest
> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> index 63ce02d1d5cc..aa47b17fbd1a 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
> @@ -8,6 +8,7 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/rtc.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/ioctl.h>
> @@ -24,12 +25,17 @@
>  #define READ_LOOP_SLEEP_MS 11
>  
>  static char *rtc_file = "/dev/rtc0";
> +static char *rtc_procfs = "/proc/driver/rtc";
>  
>  FIXTURE(rtc) {
>  	int fd;
>  };
>  
>  FIXTURE_SETUP(rtc) {
> +	if (access(rtc_file, R_OK) != 0)
> +		SKIP(return, "Skipping test since cannot access %s, perhaps miss sudo",
> +			 rtc_file);

> +
>  	self->fd = open(rtc_file, O_RDONLY);
>  }
>  
> @@ -82,6 +88,36 @@ static void nanosleep_with_retries(long ns)
>  	}
>  }
>  
> +static bool is_rtc_alarm_supported(int fd)
> +{
> +	struct rtc_param param = { 0 };
> +	int rc;
> +	char buf[1024] = { 0 };
> +
> +	/* Validate kernel reflects unsupported RTC alarm state */
> +	param.param = RTC_PARAM_FEATURES;
> +	param.index = 0;
> +	rc = ioctl(fd, RTC_PARAM_GET, &param);
> +	if (rc < 0) {
> +		/* Fallback to read rtc procfs */
> +		fd = open(rtc_procfs, O_RDONLY);

I think I was clear on the previous thread, no new users of the procfs
interface. You can carry this n your own tree but that can't be
upstream.

> +		if (fd != -1) {
> +			rc = read(fd, buf, sizeof(buf));
> +			close(fd);
> +
> +			/* Check for the presence of "alarm" in the buf */
> +			if (strstr(buf, "alarm") == NULL)
> +				return false;
> +		} else
> +			return false;
> +	} else {
> +		if ((param.uvalue & _BITUL(RTC_FEATURE_ALARM)) == 0)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  TEST_F_TIMEOUT(rtc, date_read_loop, READ_LOOP_DURATION_SEC + 2) {
>  	int rc;
>  	long iter_count = 0;
> @@ -202,6 +238,9 @@ TEST_F(rtc, alarm_alm_set) {
>  		SKIP(return, "Skipping test since %s does not exist", rtc_file);
>  	ASSERT_NE(-1, self->fd);
>  
> +	if (!is_rtc_alarm_supported(self->fd))
> +		SKIP(return, "Skipping test since alarms are not supported.");
> +
>  	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>  	ASSERT_NE(-1, rc);
>  
> @@ -209,11 +248,7 @@ TEST_F(rtc, alarm_alm_set) {
>  	gmtime_r(&secs, (struct tm *)&tm);
>  
>  	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
> -	if (rc == -1) {
> -		ASSERT_EQ(EINVAL, errno);
> -		TH_LOG("skip alarms are not supported.");
> -		return;
> -	}
> +	ASSERT_NE(-1, rc);
>  
>  	rc = ioctl(self->fd, RTC_ALM_READ, &tm);
>  	ASSERT_NE(-1, rc);
> @@ -260,6 +295,9 @@ TEST_F(rtc, alarm_wkalm_set) {
>  		SKIP(return, "Skipping test since %s does not exist", rtc_file);
>  	ASSERT_NE(-1, self->fd);
>  
> +	if (!is_rtc_alarm_supported(self->fd))
> +		SKIP(return, "Skipping test since alarms are not supported.");
> +
>  	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>  	ASSERT_NE(-1, rc);
>  
> @@ -269,11 +307,7 @@ TEST_F(rtc, alarm_wkalm_set) {
>  	alarm.enabled = 1;
>  
>  	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
> -	if (rc == -1) {
> -		ASSERT_EQ(EINVAL, errno);
> -		TH_LOG("skip alarms are not supported.");
> -		return;
> -	}
> +	ASSERT_NE(-1, rc);
>  
>  	rc = ioctl(self->fd, RTC_WKALM_RD, &alarm);
>  	ASSERT_NE(-1, rc);
> @@ -312,6 +346,9 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
>  		SKIP(return, "Skipping test since %s does not exist", rtc_file);
>  	ASSERT_NE(-1, self->fd);
>  
> +	if (!is_rtc_alarm_supported(self->fd))
> +		SKIP(return, "Skipping test since alarms are not supported.");
> +
>  	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
>  	ASSERT_NE(-1, rc);
>  
> @@ -319,11 +356,7 @@ TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
>  	gmtime_r(&secs, (struct tm *)&tm);
>  
>  	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
> -	if (rc == -1) {
> -		ASSERT_EQ(EINVAL, errno);
> -		TH_LOG("skip alarms are not supported.");
> -		return;
> -	}
> +	ASSERT_NE(-1, rc);
>  
>  	rc = ioctl(self->fd, RTC_ALM_READ, &tm);
>  	ASSERT_NE(-1, rc);
> @@ -370,6 +403,9 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
>  		SKIP(return, "Skipping test since %s does not exist", rtc_file);
>  	ASSERT_NE(-1, self->fd);
>  
> +	if (!is_rtc_alarm_supported(self->fd))
> +		SKIP(return, "Skipping test since alarms are not supported.");
> +
>  	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
>  	ASSERT_NE(-1, rc);
>  
> @@ -379,11 +415,7 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
>  	alarm.enabled = 1;
>  
>  	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
> -	if (rc == -1) {
> -		ASSERT_EQ(EINVAL, errno);
> -		TH_LOG("skip alarms are not supported.");
> -		return;
> -	}
> +	ASSERT_NE(-1, rc);
>  
>  	rc = ioctl(self->fd, RTC_WKALM_RD, &alarm);
>  	ASSERT_NE(-1, rc);
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

