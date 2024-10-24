Return-Path: <linux-kselftest+bounces-20570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6B9AF2A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 779192846B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5034117ADF7;
	Thu, 24 Oct 2024 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aX3/TOWt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77922B660
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729798526; cv=none; b=T25f7MQQau28cp5yDuPJx6bFKMFwFXp0P39bS/5lPTeWNGHgI5iIm4XKPG49muWSOjdACU318P6QD4rJvTJFIRI/ZrkY7ZH7TxhbHGaWM3nrBBN5XAA9+Zr6FjjyWh0q32QeTFxwua3TJm5gRCiVMKqpokouLhNbV46BTlN4rPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729798526; c=relaxed/simple;
	bh=BtOPfOz++nM7ImZbRJjtWqJw1z6cTjOA0xjMtChsNuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Myoao28a6BXkVCChaFVtqZoijG4DVbmzPdTSclEk59q7J/Y3c80GWPLARe2UCZ9E9HgtqkFZRAoZMGyD3o5n6j382RiOlUuLa5M3Pxm+aL1Q4trU/IqkoXaN/7aDYE1J/gnnpFO14dQZJt5b+ujxDDK038hBEHuN8uxwshiPsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aX3/TOWt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729798524; x=1761334524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BtOPfOz++nM7ImZbRJjtWqJw1z6cTjOA0xjMtChsNuU=;
  b=aX3/TOWt4BIh9TAJU8OyXBS2Onu9n/FpzqKLYbEtJIf6KPYBvJytjpJC
   /RcwApyZWqjElv6J9/iIiImwm59BaqkZZej57RyMHSPlkReCd6cGs4E5x
   DPLZG7dRk8ZN7CgyBGBQ88uwTqzxF5sLRl79zXhoz6oLKPBdvfxKxefjZ
   vIvsVLfYqo0ZH8r7Hcc8onaEyJSdo2jfH/Syh9+V661KvuBFF8LD86TDk
   noSMKSc35yZyYQluyJw5/shNg2yWLPLrOJJLIWuS5whrZL0rltPYJouRw
   EfO6NQKTw+Gjog9Hp5LkQlnBztuAUvvk67+DdB9W3CB2GT61ER+vwoJkt
   A==;
X-CSE-ConnectionGUID: zpZ1vG3DROC+Mw403ZYSCw==
X-CSE-MsgGUID: iKR/x7oZRVywqRu8nrJx6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="28907808"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="28907808"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:35:23 -0700
X-CSE-ConnectionGUID: pgkgCp+KQEWk7EYmRwVn+g==
X-CSE-MsgGUID: /mylFFwTRnC/WfKFpxUbdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80681549"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:35:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t43c6-00000006gj3-2dQv;
	Thu, 24 Oct 2024 22:35:18 +0300
Date: Thu, 24 Oct 2024 22:35:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org, ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org,
	davidlohr.bueso@hp.com
Subject: Re: [PATCH] lib/math: Add int_sqrt test suite
Message-ID: <ZxqhdgDr_s_4UON7@smile.fi.intel.com>
References: <20241024191730.69542-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024191730.69542-1-luis.hernandez093@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 24, 2024 at 03:17:28PM -0400, Luis Felipe Hernandez wrote:
> Adds test suite for integer based square root function.
> 
> The test suite is designed to verify the correctness of the int_sqrt
> math library function.

...

>  obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
>  obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
>  obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> +obj-y  += tests/
> \ No newline at end of file

^^^ Please, fix this.

...

> +#include <kunit/test.h>

+ limits.h

> +#include <linux/math.h>

+ module.h
+ string.h

-- 
With Best Regards,
Andy Shevchenko



