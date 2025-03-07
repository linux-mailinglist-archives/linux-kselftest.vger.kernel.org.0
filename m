Return-Path: <linux-kselftest+bounces-28507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C9A56F4E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19BB7A62FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844B241679;
	Fri,  7 Mar 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+if290H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC382405F2;
	Fri,  7 Mar 2025 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369206; cv=none; b=ZZueyVnNIstvaIV6/+4ORfnP6mb74ocK6C8tzPUvyDPM5tIWm1/g+pkS/f364dbt49gVceFJHMhNBlx2qUhNLF/EXCBBof0+bs1eswYIU4giXT2BxxKn9r2ljuhHhkOPsnWKps0/xUkWJl7qh8xC/pelH9bJuv4WmLv3Yby8zRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369206; c=relaxed/simple;
	bh=Zyf/o8Z6iOWxoO1TXfK8I1oM3VBWYPZ1gVrPS6Vu1es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKQa1goslhB10Uh1Ml46oa5RRT7EGHgNYgenV9vUKC+yeN7dBRyJPY1Jknn+xIGLXXkaZeXIwaJnmezxPeqQYSxdK07/9hKy/V7KajtdUiKd307iORLi8OlD+XL/juBOTrtsm4uNl/r3iCQ2LOdxd9Q9TCdG3hptHjo/FnmZCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+if290H; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741369203; x=1772905203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zyf/o8Z6iOWxoO1TXfK8I1oM3VBWYPZ1gVrPS6Vu1es=;
  b=a+if290Hyh67QoTwPGh7O2lm6m2O/hV15A4XwZAME0qdIpXBoUgOwJH0
   1Y638StRMjIm5uJdSS/idHI4c43Qe/gDy90/3R/pBZp9i+r5sP9e3RPxQ
   LRSJBsClMO4bR6xmGMw1jv+P2L8VXdkRK7bQdF8FfVBcRWXB4r2Kv3JEa
   DS/b8GcMwOLtBhR7NBbaBTJtKjTwUeajsCdtpxiIKI4VRyQFGy6xuDRtG
   ofd3WbJlu98QRFNsDe4aGbHFANkJ+qDwIsaC+P6glY8yNZ0nTjVq8v2PB
   Gz0zA6+aGQ+IbFurZ44Wiz3yeq5twevosadBG7ob7Yqtwd+lVwKUYGwUg
   A==;
X-CSE-ConnectionGUID: fdn3B0OATQuvdfvQIHBnug==
X-CSE-MsgGUID: V07bWPyTRvmVTSNVpanBLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42339534"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42339534"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:40:03 -0800
X-CSE-ConnectionGUID: Qbd/HOKCSEGpF0hYOH1FWQ==
X-CSE-MsgGUID: ptNLZSmxSJ2V/3sEOOzyfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119573267"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:40:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqbfy-00000000TSe-0Qeg;
	Fri, 07 Mar 2025 19:39:58 +0200
Date: Fri, 7 Mar 2025 19:39:57 +0200
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
Message-ID: <Z8svbdT779qxfXuk@smile.fi.intel.com>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <20250307-scanf-kunit-convert-v9-5-b98820fa39ff@gmail.com>
 <Z8suJdZsLYPYF34t@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8suJdZsLYPYF34t@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 07:34:29PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 07, 2025 at 06:27:38AM -0500, Tamir Duberstein wrote:

...

> >  #include <kunit/test.h>
> 
> + array_size.h
> 
> >  #include <linux/bitops.h>

> + bug.h // BUILD_BUG_ON()

Actually if it's only BUILD_BUG_ON(), then we better use build_bug.h.

> + errno.h // actually asm/errno.h, but in C code the linux/* will suffice
> 
> > -#include <linux/kernel.h>
> 
> This was used like a "proxy" header to a lot, see around.
> 
> >  #include <linux/module.h>
> >  #include <linux/overflow.h>
> >  #include <linux/prandom.h>
> >  #include <linux/slab.h>
> > -#include <linux/string.h>
> > +#include <linux/sprintf.h>
> 
> + types.h // u32, __scanf, ...

...

> Note,the above I made based on the context of your changes, I haven't checked
> the resulting file in full, please do it yourself.

-- 
With Best Regards,
Andy Shevchenko



