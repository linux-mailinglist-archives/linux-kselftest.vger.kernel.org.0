Return-Path: <linux-kselftest+bounces-20115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F33D9A387B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6631F2A1FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 08:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A05618E032;
	Fri, 18 Oct 2024 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JCL8YQw/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501515445B;
	Fri, 18 Oct 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240037; cv=none; b=lDfU//SkqR1ppUS2hBAb1oUatW5NfdEjEw8vAec3i1BFPDZz/KIiRx4aBbOjyOZNwM1GTI414L1wMVECsN2VnqQSesceSY+fi7ZxYOz0EXttTUDWaB5qbA1W+0uZ1MyfhrhhB+pIziJ0DbICvwQ4dk2LyqTT7fkTpFsavqHxdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240037; c=relaxed/simple;
	bh=vY66x2SoulDdjzUHC1V5UlWbbN9kMgqwz0Gejb66sPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt7GA8qL26W5wVZPYsOpppeksO4rP2tfon4mrRAn6BY5OtEj0rk639voAh7s/QOwRsu6XQv1NVWLmMGfSW+RTS8ZYDjO8iu1U+aOQcFmB8oyQtERIGbaIHa4aBlJ2yhkJsNwIxeU3uOo49cEoL1CkdGg4AJdLszAYb0eyMqDKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JCL8YQw/; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2848B6000A;
	Fri, 18 Oct 2024 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729240027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYZqWJOrMw2Irw153l1uJNluFx1K3Z8Z9DI3eyECDmk=;
	b=JCL8YQw/xrIPm1niefqTAkk4oOkObcRoN3YA8XYUhIgBh0S+nEBLvb5nonCx8dom4dihUV
	ZAi0tg00z+aNWOoLgLqTtY3Pd3d764iSWJLrRyfk67yg5opeMLKgkyF+aOTOq2JVbv9m0N
	I3jHVMdmut8hClBU6yt99ZyWLK7wLLvX3hOpRTL8Z53vw/0zm9uteV07DKXVDD+rhmQAX9
	qgjMZM17Y6445SFG9FwJHFMtn8Nkwav7Ee1JjV50wL9fFgRdvIwOhnMsZDl0V3QD7+867F
	7D3N2CRqmNg2tc3zJecGWC8jX3hOFuBMIuBXWwNYuI57yh9PPYenc088NjZhFg==
Date: Fri, 18 Oct 2024 10:27:06 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joseph Jang <jjang@nvidia.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
	"avagin@google.com" <avagin@google.com>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	Matt Ochs <mochs@nvidia.com>, Koba Ko <kobak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] selftest: rtc: Add to check rtc alarm status for
 alarm related test
Message-ID: <20241018082706d7b167ab@mail.local>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-2-jjang@nvidia.com>
 <20240620193654d3cd1f05@mail.local>
 <c0db5bd6-8c6a-4017-911e-f3e01cd522ed@nvidia.com>
 <c900db54-d764-4389-ad9a-bc2be61eedd2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c900db54-d764-4389-ad9a-bc2be61eedd2@nvidia.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 18/10/2024 12:26:44+0800, Joseph Jang wrote:
> 
> 
> On 2024/6/24 9:43 AM, Joseph Jang wrote:
> > 
> > 
> > On 2024/6/21 3:36 AM, Alexandre Belloni wrote:
> > > On 23/05/2024 18:38:06-0700, Joseph Jang wrote:
> > > > In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
> > > > ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
> > > > skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
> > > > code. This design may miss detecting real problems when the
> > > > efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
> > > > ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.
> > > > 
> > > > In order to make rtctest more explicit and robust, we propose to use
> > > > RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
> > > > running alarm related tests. If the kernel does not support RTC_PARAM_GET
> > > > ioctl interface, we will fallback to check the error number of
> > > > (RTC_ALM_SET/RTC_WKALM_SET) ioctl call for alarm feature detection.
> > > > 
> > > > Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
> > > > as optional")
> > > > 
> > > > Reviewed-by: Koba Ko <kobak@nvidia.com>
> > > > Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> > > > Signed-off-by: Joseph Jang <jjang@nvidia.com>
> > > > ---
> > > >    tools/testing/selftests/rtc/Makefile  |  2 +-
> > > >    tools/testing/selftests/rtc/rtctest.c | 64 +++++++++++++++++++++++++++
> > > >    2 files changed, 65 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
> > > > index 55198ecc04db..6e3a98fb24ba 100644
> > > > --- a/tools/testing/selftests/rtc/Makefile
> > > > +++ b/tools/testing/selftests/rtc/Makefile
> > > > @@ -1,5 +1,5 @@
> > > >    # SPDX-License-Identifier: GPL-2.0
> > > > -CFLAGS += -O3 -Wl,-no-as-needed -Wall
> > > > +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/
> > > 
> > > Is this change actually needed?
> > 
> > If we didn't include "-I../../../../usr/include/" in rtctest Makefile,
> > we may encounter build errors like the following because rtctest default
> > look at the header file from /usr/include/linux/rtc.h which miss the
> > definition of struct rtc_param, RTC_PARAM_FEATURES and RTC_PARAM_GET.
> > 
> > rtctest.c: In function ‘get_rtc_alarm_state’:
> > rtctest.c:94:15: error: variable ‘param’ has initializer but incomplete
> > type
> >      94 |        struct rtc_param param = { 0 };
> >         |               ^~~~~~~~~
> > rtctest.c:94:35: warning: excess elements in struct initializer
> >      94 |        struct rtc_param param = { 0 };
> >         |                                   ^
> > rtctest.c:94:35: note: (near initialization for ‘param’)
> > rtctest.c:94:25: error: storage size of ‘param’ isn’t known
> >      94 |        struct rtc_param param = { 0 };
> >         |                         ^~~~~
> > rtctest.c:98:22: error: ‘RTC_PARAM_FEATURES’ undeclared (first use in
> > this function)
> >      98 |        param.param = RTC_PARAM_FEATURES;
> >         |                      ^~~~~~~~~~~~~~~~~~
> > rtctest.c:98:22: note: each undeclared identifier is reported only once
> > for each function it appears in
> > rtctest.c:100:23: error: ‘RTC_PARAM_GET’ undeclared (first use in this
> > function); did you mean ‘RTC_ALM_SET’?
> >     100 |        rc = ioctl(fd, RTC_PARAM_GET, &param);
> >         |                       ^~~~~~~~~~~~~
> >         |                       RTC_ALM_SET
> > 
> > After adding "-I../../../../usr/include/", the rtctest will look at
> > linux kernel source header files from
> > <Linux root directory>/usr/include/linux/rtc.h to find the definition of
> > struct rtc_param, RTC_PARAM_FEATURES and RTC_PARAM_GET and fix the
> > rtctest build errors.
> > 
> > 
> > Thank you,
> > Joseph.
> > 
> >  >
> Hi Alexandre,
> 
> Thank you for reviewing the kernel patch [PATCH 1/2].
> We are still not sure if we could include linux headers files from kernel
> source directory by the following change ?
> 
> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/

I guess this is ok, I expected Shuah to take this path too.

> 
> Thank you,
> Joseph.
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

