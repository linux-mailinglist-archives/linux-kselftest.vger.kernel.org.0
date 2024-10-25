Return-Path: <linux-kselftest+bounces-20673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC099B0806
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 17:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C86283455
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D02B21A4C3;
	Fri, 25 Oct 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNfPtFcP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C421A4A4
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Oct 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869629; cv=none; b=UeN3qnXDFPp4LT3KWTntmc7hrc5kv/sYz4zVv7BHlEgRdS5OJGczQbBQWWSYLKEbJZh0XSCPjQ9VWN3f2LBVEJ21uNjvmuRlacy4eXRHdH2rn15xRvUvZD+IuFuo+yf9T1uQsBUt+WLZcLxS4W8jRjPgcoxuiwOWPwYHQ8XCt5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869629; c=relaxed/simple;
	bh=/CRZccK48TTkm9/y8qzsegbvd/zAcrFx30TxSE7jFb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHlSbQk4e4aIhkHx2lDy04nkejIAINyEJper8J2FvezdZGmJQ996jUYPnP8y/y/l93bBEF0EwTtDertwbsn0mvCGD845VhDUS4rVtiOgNlEGl/t6OFjBWf0gcY+vETboGkfQb9CO+TCqRz3JGVUrpu+0OSSj6j6aEtwY8CVocLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNfPtFcP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729869628; x=1761405628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/CRZccK48TTkm9/y8qzsegbvd/zAcrFx30TxSE7jFb0=;
  b=YNfPtFcPuWdTNfsygtvCL1biFr7oFFlqYNzjwjwvCeLlt6lJW6gRSTFC
   2DvDOV+erTIjRMTSCHDTNEqtT4N+dADfMtunLYrQtWIWAG3wDrrWbnp1d
   6rJ0zD727hO95p6ztQzcAfUjWswgAqxb9UY1kp80dXUTtRPAsF5GswiZS
   vmPuA3f6P9JjZMCcpivVYSDQudpMSjmYo1jNbU4IfD1OESIFq1cCMEHwz
   6lW+eMRSYetaO/z4rs8PlC9X2h55I19IcJ3k3JoTMnQTWD5BLkogV/RFu
   cndvYbi1DQqF+eJAa98K7V9Cbuj157+mgbPJJPFZ7vgEPgExGztvyrwqS
   Q==;
X-CSE-ConnectionGUID: irJFKgmzSMqqr2/NPMxs4g==
X-CSE-MsgGUID: k38Q7dtIQgWoBEYLHMFXRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29438233"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="29438233"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:20:26 -0700
X-CSE-ConnectionGUID: 2FFeEofwSmixujwq9s+nsg==
X-CSE-MsgGUID: QZE9di3AQWuZsctjIjAZUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80965243"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:20:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4M6v-00000006xWS-160X;
	Fri, 25 Oct 2024 18:20:21 +0300
Date: Fri, 25 Oct 2024 18:20:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org, ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] lib/math: Add int_sqrt test suite
Message-ID: <Zxu3Nd_xdOIdyYl9@smile.fi.intel.com>
References: <20241024195511.72674-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024195511.72674-1-luis.hernandez093@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 24, 2024 at 03:55:09PM -0400, Luis Felipe Hernandez wrote:
> Adds test suite for integer based square root function.
> 
> The test suite is designed to verify the correctness of the int_sqrt

int_aqrt()

> math library function.

...

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug

> +config INT_SQRT_KUNIT_TEST
> +	tristate "Integer square root test test" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This option enables the KUnit test suite for the int_sqrt function,
> +	  which performs square root calculation. The test suite checks
> +	  various scenarios, including edge cases, to ensure correctness.
> +
> +	  Enabling this option will include tests that check various scenarios
> +	  and edge cases to ensure the accuracy and reliability of the square root
> +	  function.
> +
> +	  If unsure, say N
> +
> +

One blank line is enough.

Shouldn't the thing to be in lib/tests/Kconfig?

...

>  obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o

Where is this? I don't see it right now in the Linux Next...

...

> +#include <kunit/test.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <limits.h>

linux/limits.h, of course.

Sorry that I wasn't clear about this, but it's kinda rule of thumb that all
headers in 99.999% kernel-space related files in the Linux kernel are from
in-project folders and not from outside.

-- 
With Best Regards,
Andy Shevchenko



