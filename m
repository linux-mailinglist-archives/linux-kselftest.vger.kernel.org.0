Return-Path: <linux-kselftest+bounces-20408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCDF9AB351
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 18:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4931C22BF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3311BD501;
	Tue, 22 Oct 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pegB8CoT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1A1BD4E0;
	Tue, 22 Oct 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612922; cv=none; b=u4UHXCybuiSIuv4+jY/iCd2Ih4Dwxq8yDoEVB/l7HWIYI/bpQgcFzUVJi08bgBmiontlqX9+5IUC2ugum/TMKuUWiwyB1ExrHSEyL3TE811gbikKNo1HQ50gi6eJva3eKc1lV3R3qfwySPvEvWxgc/3DpkytF5IG1rlEOVhECg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612922; c=relaxed/simple;
	bh=ewumsz+GK1jAcVcRM+HBUcNMz73tC/m0TcrqhvMpLFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8H/zuiqUXKptnf+qNcduzjK6PZSdKr0MI7NsoJ8iL6lFHUTWMzoGguYkpilin8mH5eXh3wQeLI2z7mLrnBHDxHv2lj+php6LQujobOA0TMDcUQyIBUpxmbHFKLu5GqsjBYS7DaAqlzTGamQVmhkRLkssF9h3FGwfQlHs6Cy+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pegB8CoT; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 205A11C000B;
	Tue, 22 Oct 2024 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729612917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlVEyjHwbz0slojlLbzr1PpnHBXIeHtm+szXTJChAAU=;
	b=pegB8CoTggveMjIXnxFvxx8DNAzBeLZVZ/coKMtYdZV6n2tea0u9VOHwlVNUo24WX+5D6O
	63SAgaM/7MVjDxAT9HmfY/XDGFDDIrFFc7wW+ie28KvxFKg7aGH9r1yFff20QAjjKO4Q9i
	j5069MqPLT8V420i7Ajbp4DxzcfK0qX1yQ9qy5FMGY/mOFcGtzu3ySSbKk1l1Ro7A0+zic
	+m+EF8LnVN6GfPCU0+entlecW+rztWOelNEkatHp0EUHmukzOT2wqcZZLgeTRfusR9O3VW
	Wo4vJW+CnqVSCm3QLsFEzDRCgBvMrXExah+7Q5qNVwo5AHsoKdUPCNX6kDoUYQ==
Date: Tue, 22 Oct 2024 18:01:56 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, avagin@google.com, amir73il@gmail.com,
	brauner@kernel.org, mochs@nvidia.com, kobak@nvidia.com,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftest: rtc: Add to check rtc alarm status for
 alarm related test
Message-ID: <202410221601561f631bc7@mail.local>
References: <20241021032213.1915224-1-jjang@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021032213.1915224-1-jjang@nvidia.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 20/10/2024 20:22:13-0700, Joseph Jang wrote:
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

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> Changes in v2:
> - Changed to use $(top_srcdir) instead of hardcoding the path.
> 
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
> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I$(top_srcdir)/usr/include
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

