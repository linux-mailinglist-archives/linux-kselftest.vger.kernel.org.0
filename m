Return-Path: <linux-kselftest+bounces-26373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D9DA30FF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECBC166860
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A76253329;
	Tue, 11 Feb 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqMGuSHr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99A1D54FE;
	Tue, 11 Feb 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288444; cv=none; b=WOIG35kQPhbJ2rRSwzV4V70zMY5MfFT+7E9P4esChsSVYXQIB1Vu9vjNxXFmF+jSEqy6e+VMGyKLI3xh3SosLH1nNl9lfelFykH9m9N1jV3FRhhpHUg6xdmHXSujhrXNYEiq+aAvaD0gaGCfkkm6diBfZ3JbJ1VOsadoRaw+gXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288444; c=relaxed/simple;
	bh=XhMiLeU60aBB9kTwbXErUUGOtaeA4xJDR705zjYx1r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hbn3yxTm4/jVAy02kJRc/GWVeAntH8OegQ05Ox18uOX+1lOqS0y2Rs7C85ePFNLd/W9gz2cQB8o4ZFkfQJCtInjp+jb7P1tpLXw/6N+YMtw+V7y6sCguFCoJWhffIfXkK6I0LTrLiYPViiHVTAi6wsuD6cbSpAtj3pVxV/ZpVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqMGuSHr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739288443; x=1770824443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XhMiLeU60aBB9kTwbXErUUGOtaeA4xJDR705zjYx1r8=;
  b=lqMGuSHrEIHvVT4pU4iRfQDWJhw+NjzjskCRDZw8a+NQFMvJPs4fBy5h
   nps/WxtN662uk/l+QzZbtWuL11Maad3gyl02XTVL7ISG83BvzuJm0ZWHO
   CZXqBD6hzTDugDbw/3KH7E8MhY566bR8dMMeRIxHDYwiMf9BhF/77Ejlq
   SAglOMJBC6UauQZsdHCJsOqjVcFe0JJOeypvM8FcXnHprbRATFfXXx4It
   /BYMMjR430w8PN3R+t9pB5VwaawzD4AtqTF9hRr67AAgKKxtzulRj2vPY
   Ioa9wD9Z/WyiwQVRRkycKzBABT2Bm3y9qeW2dmMiz/32GSbAQ+ieN5rWT
   w==;
X-CSE-ConnectionGUID: mPyOrvCeSBKVduq7MfzjiA==
X-CSE-MsgGUID: dGfP3FuPTk+CZfoxQT90Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51307167"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="51307167"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:40:42 -0800
X-CSE-ConnectionGUID: YM69FsTPTf2HkR0xqKaQFQ==
X-CSE-MsgGUID: 2SlSAkaJRH+E7ANSpoRSZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149730903"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:40:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thsNG-0000000AY4A-2pV9;
	Tue, 11 Feb 2025 17:40:34 +0200
Date: Tue, 11 Feb 2025 17:40:34 +0200
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
Subject: Re: [PATCH v7 0/3] scanf: convert self-test to KUnit
Message-ID: <Z6tvciJpQgTwYpGx@smile.fi.intel.com>
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 10:13:36AM -0500, Tamir Duberstein wrote:
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and printf), the rest having been converted to KUnit. In
> addition to the enclosed patch, please consider this an RFC on the
> removal of the "Test Module" kselftest machinery.
> 
> I tested this using:
> 
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 scanf
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v7:
> - Remove redundant debug logs. (Petr Mladek)
> - Drop Petr's Acked-by.
> - Use original test assertions as KUNIT_*_EQ_MSG produces hard-to-parse
>   messages. The new failure output is:

It would be good if you put into cover letter, or even in the respectful patch
the example of the error report for the old code and new code that it will be
clear how it changes.

>     vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
>             not ok 1 " "
>         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
>     vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%2hx:%1hx:%4hx:%4hx:%4hx:%1hx:%1hx", ...) expected 892403712 got 28
>             not ok 2 ":"
>         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
>     vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4hx,%4hx,%1hx,%4hx,%1hx,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
>             not ok 3 ","
>         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
>     vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41", "%4hx-%4hx-%1hx-%3hx-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 99381
>             not ok 4 "-"
>         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
>     vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%1hx/%2hx/%1hx/%4hx/%1hx/%4hx/%4hx", ...) expected 65559 got 1507328
>             not ok 5 "/"
>         # numbers_list_field_width_val_width: pass:0 fail:5 skip:0 total:5
>         not ok 4 numbers_list_field_width_val_width
>         # numbers_slice: ASSERTION FAILED at lib/scanf_kunit.c:92
>     vsscanf("3c87eac0f4afa1f9231da52", "%1hx%4hx%4hx%4hx%1hx%4hx%4hx%1hx", ...) expected 1257942031 got 2886715518


-- 
With Best Regards,
Andy Shevchenko



