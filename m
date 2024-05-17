Return-Path: <linux-kselftest+bounces-10334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F5A8C826C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 10:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263BB1F22C2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357231A28D;
	Fri, 17 May 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ugytkyag"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B98EC4;
	Fri, 17 May 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933329; cv=none; b=SoWtzRxecwt0/YykL7gyn4FJFNb/y4MQGNE6dSNX56lvb80OJP5QfeR/Le4abIooc/bWwFn8NMAPHsGGHscvbvBToI+YqSvbJ46Yza0vgkcVZyTX8VtP9+bLmBdVB3TRuPA2GRJLCwLTUsJh0ldkDtLhNfXwi6z0gg7m89zNsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933329; c=relaxed/simple;
	bh=/GZC7I1iQgQbBCYI1nHiijMoVtVuU+3h4tz2KzRmCtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0V+9SO4osje47titlQWgVCRHneqijJyCavb4erT1W39S9BqdChoNIT9GAyiPrhy6Fj40/ZE4FsTG1qsavabXmYTlXJn+GBsxhvFXz3xYZJGon8F4W4B3RE7aSxRM4M3+KfiFNeGo8fOv1lr+uHD0rCkhn4ARXNqnRCLNrH92XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ugytkyag; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A537FF80C;
	Fri, 17 May 2024 08:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715933323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Oj78yYCBgvj/zAVon1VfCSSs40udj3FUCdRnvFOfm0=;
	b=UgytkyagotipbBlKbxj2+28X3zFusXNY2lFaFbCWe8lP+3JF9ysNWMZ0nq4xv6xpbNqc2+
	rsgO83qU9aO7pkeaB1v6iKfp3l5Omqq/YWyv1RdJl5FGssrpRvVjD3T7vsozciGKhhfGJg
	hr29U4MS0Gh/TlaT5zutak00paf+oxy++thnWCr+5kGNVXroJHIa0lasL6rOGysb+ljeaS
	daXls87Tq1sx6hLXbb3Wbko4Sre7QV1S7t8bxQfYtc1uKnMtZy2mFIDx0Quzzk4jAnr/6l
	1HZyk5/OwMZSDddzcer1BifpsilMt6ruSxszTz4krws3I2dfN3fTpDL8opwWcA==
Date: Fri, 17 May 2024 10:08:43 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, avagin@google.com, amir73il@gmail.com,
	brauner@kernel.org, mochs@nvidia.com, jszu@nvidia.com,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] selftest: rtc: Add to check rtc alarm status for alarm
 related test
Message-ID: <20240517080843aeb408e4@mail.local>
References: <20240517022847.4094731-1-jjang@nvidia.com>
 <202405170719515a9c6d2f@mail.local>
 <ea0bacc0-2765-4d8f-8b62-0e9c45c560fc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0bacc0-2765-4d8f-8b62-0e9c45c560fc@nvidia.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 17/05/2024 15:53:58+0800, Joseph Jang wrote:
> 
> 
> On 2024/5/17 3:19 PM, Alexandre Belloni wrote:
> > On 16/05/2024 19:28:47-0700, Joseph Jang wrote:
> > > In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
> > > ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
> > > skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
> > > code. This design may miss detecting real problems when the
> > > efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
> > > ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.
> > > 
> > > In order to make rtctest more explicit and robust, we propose to use
> > > RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
> > > running alarm related tests. If the kernel does not support RTC_PARAM_GET
> > > ioctl interface, we will fallback to check the presence of "alarm" in
> > > /proc/driver/rtc.
> > > 
> > > The rtctest requires the read permission on /dev/rtc0. The rtctest will
> > > be skipped if the /dev/rtc0 is not readable.
> > > 
> > 
> > This change as to be separated. Also, I'm not sure what happened with
> > https://lore.kernel.org/all/20230717175251.54390-1-atulpant.linux@gmail.com/
> > 
> 
> I apply above patch and seems like still cannot detect the read
> permission on /dev/rtc0. I guess the 'F_OK' just check the `/dev/rtc0`
> was there.
> 
> I share the error logs by following for your reference.
> 
> TAP version 13
> 1..1
> # timeout set to 210
> # selftests: rtc: rtctest
> # TAP version 13
> # 1..8
> # # Starting 8 tests from 1 test cases.
> # #  RUN           rtc.date_read ...
> # # rtctest.c:53:date_read:Expected -1 (-1) != self->fd (-1)
> # # date_read: Test terminated by assertion
> # #          FAIL  rtc.date_read
> 
> Not sure if we could skip the testing by following change ?
> 
> FIXTURE_SETUP(rtc) {
> +     if (access(rtc_file, R_OK) != 0)
> +             SKIP(return, "Skipping test since cannot access %s, perhaps
> miss sudo",
> +                      rtc_file)
> +
>       self->fd = open(rtc_file, O_RDONLY);
> }
> 
> And I make sure we need root permission to access `/dev/rtc0`.
> 

There is no need to test for every tests of the suite, the check could
be done once. To be clear, you don't need to be root to access the RTC,
you need CAP_SYS_TIME and CAP_SYS_RESOURCE.

> 
> 
> > > Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
> > > as optional")
> > > 
> > > Reviewed-by: Jeremy Szu <jszu@nvidia.com>
> > > Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> > > Signed-off-by: Joseph Jang <jjang@nvidia.com>
> > > ---
> > >   tools/testing/selftests/rtc/Makefile  |  2 +-
> > >   tools/testing/selftests/rtc/rtctest.c | 72 +++++++++++++++++++--------
> > >   2 files changed, 53 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
> > > index 55198ecc04db..6e3a98fb24ba 100644
> > > --- a/tools/testing/selftests/rtc/Makefile
> > > +++ b/tools/testing/selftests/rtc/Makefile
> > > @@ -1,5 +1,5 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > > -CFLAGS += -O3 -Wl,-no-as-needed -Wall
> > > +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/
> > >   LDLIBS += -lrt -lpthread -lm
> > >   TEST_GEN_PROGS = rtctest
> > > diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> > > index 63ce02d1d5cc..aa47b17fbd1a 100644
> > > --- a/tools/testing/selftests/rtc/rtctest.c
> > > +++ b/tools/testing/selftests/rtc/rtctest.c
> > > @@ -8,6 +8,7 @@
> > >   #include <errno.h>
> > >   #include <fcntl.h>
> > >   #include <linux/rtc.h>
> > > +#include <stdbool.h>
> > >   #include <stdio.h>
> > >   #include <stdlib.h>
> > >   #include <sys/ioctl.h>
> > > @@ -24,12 +25,17 @@
> > >   #define READ_LOOP_SLEEP_MS 11
> > >   static char *rtc_file = "/dev/rtc0";
> > > +static char *rtc_procfs = "/proc/driver/rtc";
> > >   FIXTURE(rtc) {
> > >   	int fd;
> > >   };
> > >   FIXTURE_SETUP(rtc) {
> > > +	if (access(rtc_file, R_OK) != 0)
> > > +		SKIP(return, "Skipping test since cannot access %s, perhaps miss sudo",
> > > +			 rtc_file);
> > 
> > > +
> > >   	self->fd = open(rtc_file, O_RDONLY);
> > >   }
> > > @@ -82,6 +88,36 @@ static void nanosleep_with_retries(long ns)
> > >   	}
> > >   }
> > > +static bool is_rtc_alarm_supported(int fd)
> > > +{
> > > +	struct rtc_param param = { 0 };
> > > +	int rc;
> > > +	char buf[1024] = { 0 };
> > > +
> > > +	/* Validate kernel reflects unsupported RTC alarm state */
> > > +	param.param = RTC_PARAM_FEATURES;
> > > +	param.index = 0;
> > > +	rc = ioctl(fd, RTC_PARAM_GET, &param);
> > > +	if (rc < 0) {
> > > +		/* Fallback to read rtc procfs */
> > > +		fd = open(rtc_procfs, O_RDONLY);
> > 
> > I think I was clear on the previous thread, no new users of the procfs
> > interface. You can carry this n your own tree but that can't be
> > upstream.
> > 
> 
> Okay ~ If we use RTC_PARAM_GET ioctl to detect rtc feature only, not
> sure if that is okay for upstream ?

Yes, using RTC_PARAM_GET is ok but I'm pretty sure this is not solving
you are seeing following the efi patch you are pointing to.

The patch clears RTC_FEATURE_ALARM when the alarm is not present which
will ensure the ioctl fails and so the test will already be skipped. My
guess is that your ssue ias actually when the alarm is present and the
test will run and wait forever for an interrupt that will never come.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

