Return-Path: <linux-kselftest+bounces-28506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B33A56F1E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861B01897A2D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2924060E;
	Fri,  7 Mar 2025 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THg05w+r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B85621A44C;
	Fri,  7 Mar 2025 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368886; cv=none; b=bRrbRIXU5Gvlq8Yp6cvAHu/AusWo8IoBultZO/7E7cDUE9okcNkh4z8v9w+vars1raQVCn0xRC6r0zzx7vEqpHsZKw3uPwYI+RR88Ic66wbEonRpVz3+vC+Bw14C382zGBFO4ddCgZzwsoIKZQA+vC17dEJmA1yWZlr4HClKQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368886; c=relaxed/simple;
	bh=t3oEb44DvVDQmSfTcijDsyJHwAnJvsbBsoh/aHSj1cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGA1qfK1V2JP1EZVLsxP3T+FaxpGaQDx2RWQ4ltaRvZQepaQKOzprMEBxfWbBKjXLgv4WjQsHJRUMfmqz4s8rLuid4VZeaVCj/XNrsKTA6K1cD/htmz9gxK28LWfxUCfaQTzfqDCGds996lnE6+4rsmyN15KayNZ9GE/d5e2lP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THg05w+r; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741368884; x=1772904884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t3oEb44DvVDQmSfTcijDsyJHwAnJvsbBsoh/aHSj1cE=;
  b=THg05w+rpOv5zjl6T7j+HHznfWSw+eLOoLtXdvsDlJY2XgtuDd7FhQRq
   HYrbD/9rrDTcDYqsnytBNynqY2CDWB62qpxiTMh3K82RGvINfXaG9ShkR
   pcVFG8dU1iSrdlgqB2HfHCx502bkzQHhNWuzTYbwYQ5ddU70pkWh7Dl+3
   BQWALyzAm4ljpuxUpHdtnI1NMrGStN6zL6bnc+Un8Ho6nW0fG5ZtvXIUc
   Gl//AmZF3mCz5gG3R3vT72BxXctF9tlrq2x0bZtlVKmV8WH5XM0rg7ZZb
   BrbrZ77qxyo0BzAuq6xCwL7Q76r3rr/AHd0XJc5DwUGxCZTdBON0tFsPa
   Q==;
X-CSE-ConnectionGUID: vXWGAlDNQOWbwWbBLbryqQ==
X-CSE-MsgGUID: UPj+xHyuTAKbXBOPMQYsAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42338842"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42338842"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:34:35 -0800
X-CSE-ConnectionGUID: QUcxk5/sRBq2P00oIkWKxQ==
X-CSE-MsgGUID: QGQxTExnQZqDegRMh7rk3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119569679"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:34:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqbaf-00000000TOU-2Bq5;
	Fri, 07 Mar 2025 19:34:29 +0200
Date: Fri, 7 Mar 2025 19:34:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 5/6] scanf: tidy header `#include`s
Message-ID: <Z8suJdZsLYPYF34t@smile.fi.intel.com>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <20250307-scanf-kunit-convert-v9-5-b98820fa39ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-scanf-kunit-convert-v9-5-b98820fa39ff@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 06:27:38AM -0500, Tamir Duberstein wrote:
> Remove the unused `kernel.h`. Replace `string.h` with `sprintf.h` as the
> former doesn't seem to be used directly.

...

>  #include <kunit/test.h>

+ array_size.h

>  #include <linux/bitops.h>

+ bug.h // BUILD_BUG_ON()
+ errno.h // actually asm/errno.h, but in C code the linux/* will suffice

> -#include <linux/kernel.h>

This was used like a "proxy" header to a lot, see around.

>  #include <linux/module.h>
>  #include <linux/overflow.h>
>  #include <linux/prandom.h>
>  #include <linux/slab.h>
> -#include <linux/string.h>
> +#include <linux/sprintf.h>

+ types.h // u32, __scanf, ...

...

Note,the above I made based on the context of your changes, I haven't checked
the resulting file in full, please do it yourself.

-- 
With Best Regards,
Andy Shevchenko



