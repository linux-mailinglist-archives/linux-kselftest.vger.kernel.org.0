Return-Path: <linux-kselftest+bounces-9346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546078BA777
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 09:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6641F21E07
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980BB146A60;
	Fri,  3 May 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KNoUm58O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28B139CE9;
	Fri,  3 May 2024 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720557; cv=none; b=FhOUEJcnDcNhBdX9PPKOIIp9hDkPmvoDYCgMvfQj7sdKqMKMrQ8x8BbiqltAbI23rFy03nNqpZjDVPonqkZN3tCqhmIpSOFPBqGx/EtxdBpdukguCEHnAU1Qmll2FKED5SImQMERnonTKHIe1rmjiofj/Btay8zkMCbLKT7wTfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720557; c=relaxed/simple;
	bh=v2AR8vS6LaPh1r83qOm8r/3pElbO2ma7dwD3xTfvBJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHyMhKZpgUOpZg5+trqGqWarH64V/tKuTI2QOGpP1tfK1mEbu4fEegkjV8WTrz+TEWRrx0T7uUfa4klXp5pnIrzTaTw5fBgnzx487c9bTvqMtY0Xp2e9sBtiuP6sildXvHAWM5pDiK2NNR1kf5dc+oJBvaTbMBx3s0s7E97zNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KNoUm58O; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 84B5FC58A3;
	Fri,  3 May 2024 06:49:24 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2652F240005;
	Fri,  3 May 2024 06:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714718956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MyI3HpUHVDHWHyDN4OHXQofVHp5yoV5KlAe2xcI+3VU=;
	b=KNoUm58OxyTSa21OKbzck9+5aIZYoR4XIuCwrXAicJQLcGkALW/ayoNBmPHmJnosgVerNT
	2mU6zHbygmvuQ4ivnx5AYHCNStbHboK6p4UPl7KIHgym9s7u5a0J7gTkgRHNwavSuTZ5r5
	/JmnQigLg+EWVQbzTRKamRMEjHNRD7cRFHREJLa317gm2wbU+sygqtvPgB95plYPWyHPLM
	xMd5WmrOb+WuBKwmYU9zP5cgyqbASkQxCENbwuwJ6kMYmJFExvv4NJWKWT2zBMdDX8Swqr
	pBojaZ0eBsmiccEY7P7i/QwD9ob5s9OhNl8T33BONIjb91yZAPpGjjrtjzZo4A==
Date: Fri, 3 May 2024 08:49:15 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, avagin@google.com, amir73il@gmail.com,
	brauner@kernel.org, mochs@nvidia.com, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sdonthineni@nvidia.com, treding@nvidia.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/1] selftest: rtc: Add support rtc alarm content check
Message-ID: <202405030649157e9de2ac@mail.local>
References: <20240503014102.3568130-1-jjang@nvidia.com>
 <20240503014102.3568130-2-jjang@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503014102.3568130-2-jjang@nvidia.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 02/05/2024 18:41:02-0700, Joseph Jang wrote:
> Some platforms do not support WAKEUP service by default, we use a shell
> script to check the absence of alarm content in /proc/driver/rtc.

procfs for the RTC has been deprecated for a while, don't use it.

Instead, you can use the RTC_PARAM_GET ioctl to get RTC_PARAM_FEATURES
and then look at RTC_FEATURE_ALARM.
See https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc.c

> 
> The script will validate /proc/driver/rtc when it is not empty and then
> check if could find alarm content in it according to the rtc wakealarm
> is supported or not.
> 
> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
> as optional")
> 
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> Signed-off-by: Joseph Jang <jjang@nvidia.com>
> ---
>  tools/testing/selftests/Makefile              |  1 +
>  tools/testing/selftests/rtc/property/Makefile |  5 ++++
>  .../selftests/rtc/property/rtc-alarm-test.sh  | 27 +++++++++++++++++++
>  3 files changed, 33 insertions(+)
>  create mode 100644 tools/testing/selftests/rtc/property/Makefile
>  create mode 100755 tools/testing/selftests/rtc/property/rtc-alarm-test.sh
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index e1504833654d..f5d43e2132e8 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -80,6 +80,7 @@ TARGETS += riscv
>  TARGETS += rlimits
>  TARGETS += rseq
>  TARGETS += rtc
> +TARGETS += rtc/property
>  TARGETS += rust
>  TARGETS += seccomp
>  TARGETS += sgx
> diff --git a/tools/testing/selftests/rtc/property/Makefile b/tools/testing/selftests/rtc/property/Makefile
> new file mode 100644
> index 000000000000..c6f7aa4f0e29
> --- /dev/null
> +++ b/tools/testing/selftests/rtc/property/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +TEST_PROGS := rtc-alarm-test.sh
> +
> +include ../../lib.mk
> +
> diff --git a/tools/testing/selftests/rtc/property/rtc-alarm-test.sh b/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
> new file mode 100755
> index 000000000000..3bee1dd5fbd0
> --- /dev/null
> +++ b/tools/testing/selftests/rtc/property/rtc-alarm-test.sh
> @@ -0,0 +1,27 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +if [ ! -f /proc/driver/rtc ]; then
> +	echo "SKIP: the /proc/driver/rtc is empty."
> +	exit 4
> +fi
> +
> +# Check if could find alarm content in /proc/driver/rtc according to
> +# the rtc wakealarm is supported or not.
> +if [ -n "$(ls /sys/class/rtc/rtc* | grep -i wakealarm)" ]; then
> +	if [ -n "$(grep -i alarm /proc/driver/rtc)" ]; then
> +		exit 0
> +	else
> +		echo "ERROR: The alarm content is not found."
> +		cat /proc/driver/rtc
> +		exit 1
> +	fi
> +else
> +	if [ -n "$(grep -i alarm /proc/driver/rtc)" ]; then
> +		echo "ERROR: The alarm content is found."
> +		cat /proc/driver/rtc
> +		exit 1
> +	else
> +		exit 0
> +	fi
> +fi
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

