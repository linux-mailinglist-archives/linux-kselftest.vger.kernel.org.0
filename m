Return-Path: <linux-kselftest+bounces-12361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0444F911249
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 21:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365151C230C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550B1B9AC4;
	Thu, 20 Jun 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VPmr3XBX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACE31B5838;
	Thu, 20 Jun 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912272; cv=none; b=EiGrp/W827W2hd8ZBaeoWW/86y51MhHSKPrdGD4LrlroM6sKZZebsOMJ2b/5Euisb/neHAygs07oXgCvCdhAi62ZLysv1279IujQEIXCbNetdwdzzhPw2vgpMjYUrTumqz2YeFEkBiAg4ruDReAIG3PDy8tm6MlZ5q8o0xtEWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912272; c=relaxed/simple;
	bh=l+txGksSXkWedRfhpqxMxsT0dZ/UG6I+oJkh+sph984=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+6vNbxXGI9DENV+CfHLUgRidQ1F81UvR5FmWbgCPUHMlYkfkWCCQiLOdkaH1ky+979+n79wBX3UinurYACuZQwMDXsER+9VNqyZVfB7Nny83lN9/x0taxRb/4wVAITkydxVWdxpgR36gYR0uenN+P5ySEw2J/cWz29Ag+FEXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VPmr3XBX; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0354FF802;
	Thu, 20 Jun 2024 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718912267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hfsiDXN7DO32VMAYIYhnEukmM3gkt2TBu6DLqrB67Ys=;
	b=VPmr3XBXqLbzz3K/ni8AEblX4K7858QvVnd4eceZQF6IqMGmBRk/rpjlXjq8kL5BqMgNrI
	U24m3YjgMF5kOYFgw9qpJkQanVxCSYpiPwiM6MGOhkKGw4rsW7JoFatsdJRF9Iw5PiHST4
	21WgE1j5vB25KLyZPVpPS3Wzze5K3UcfJYcPP7axAmbDxz8CLOCtdLGf8+nBNfj/GnhPT3
	yq1w/KFeX/ZFFLPwyreiIXp+uB0Vw4ahla7216sUWM1Yvxp1XB0IAUVZHEaAcWPt2soBvL
	yy9/a7SfeJqjvBacSTYHmmA0e3frPLlvsOXaya9zuQF0BeVEfl3kmmij9w0FUA==
Date: Thu, 20 Jun 2024 21:37:46 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, avagin@google.com, amir73il@gmail.com,
	brauner@kernel.org, mochs@nvidia.com, kobak@nvidia.com,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] selftest: rtc: Check if could access /dev/rtc0
 before testing
Message-ID: <202406201937464fc96b1c@mail.local>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-3-jjang@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524013807.154338-3-jjang@nvidia.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 23/05/2024 18:38:07-0700, Joseph Jang wrote:
> The rtctest requires the read permission on /dev/rtc0. The rtctest will
> be skipped if the /dev/rtc0 is not readable.
> 
> Reviewed-by: Koba Ko <kobak@nvidia.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> Signed-off-by: Joseph Jang <jjang@nvidia.com>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  tools/testing/selftests/rtc/rtctest.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> index 2b12497eb30d..d104f5326cf4 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
> @@ -483,6 +483,8 @@ __constructor_order_last(void)
>  
>  int main(int argc, char **argv)
>  {
> +	int ret = -1;
> +
>  	switch (argc) {
>  	case 2:
>  		rtc_file = argv[1];
> @@ -494,5 +496,12 @@ int main(int argc, char **argv)
>  		return 1;
>  	}
>  
> -	return test_harness_run(argc, argv);
> +	/* Run the test if rtc_file is accessible */
> +	if (access(rtc_file, R_OK) == 0)
> +		ret = test_harness_run(argc, argv);
> +	else
> +		ksft_exit_skip("[SKIP]: Cannot access rtc file %s - Exiting\n",
> +						rtc_file);
> +
> +	return ret;
>  }
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

