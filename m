Return-Path: <linux-kselftest+bounces-26374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 325DFA30FFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F84218888EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071B253330;
	Tue, 11 Feb 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i97Tuk5C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B52230D0E;
	Tue, 11 Feb 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288535; cv=none; b=iEkYspodDhUvMptVK4hY2y3MOy3/GMRYhRL3o6igcwNecmgYxhXUUY33WJAGAYerLudEhuCwysflX5xsO0O2ZWllXdJCTG7Ss/72kz6jmU+TJlxXvaMZIZSLsKwAX/Z8JIUZVt1+PD7Zwr0MNhAO3RJF+gTZafe1sOoYZhSBmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288535; c=relaxed/simple;
	bh=9TMlr7BDRa9X8bwB/EnlEyJkFUxUUsfy13K+M3cI3+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSRUEoBJKinqlW3UKqn427PXeLev1OzSEr2CA1iHtgIkSkPfB7IWDCBLQuQhXC3y9Vmto7FrAaetOyWsVNZB2GkoP7SSR8F8Lu6Ms6Y1BKajLpHjTwpGZ+h8qMCNEDo9TYW3WE8RUZK2bWK1vEKLy6DIa044aqQzBEamIdB1oes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i97Tuk5C; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739288534; x=1770824534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9TMlr7BDRa9X8bwB/EnlEyJkFUxUUsfy13K+M3cI3+s=;
  b=i97Tuk5Cd2JRogk7jiQniWqHj8HkrqJlOD6sdYLGWY5oUBG6hsvsl4Go
   tUDGtiiGKra2Cz+I3vUP7NXFqBC/kX2mEIBE9hwP04EPj99MO5Z4DWj4u
   ZviB9kaHQzZOL1R98g1scUTjiapA7O6/MlSNVEf7YXdMCtUktlN7rn+ny
   ukW3qOsZxg1JMBaPuZnmHqqyEtQQ1BUnckvb36/q+l3NNdvRtxfTFInsT
   ynu2l8JhHzBpXWt3tGrjvKVnuMNWQXuNn298fBTcilgQQmspM3cb7J7hC
   lQf0GQUQRnw2uyyMIgjz4EDFDL2YGo1JVgu28vC7oQOXrlTsMUZTMSE5u
   A==;
X-CSE-ConnectionGUID: vNWKZU5sRi+ttl5txmlI8A==
X-CSE-MsgGUID: OvkyS+AnQ1mC9mdFmU5/YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39935238"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="39935238"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:42:13 -0800
X-CSE-ConnectionGUID: Rf6D9W7CTk2qlj27jpQ6nQ==
X-CSE-MsgGUID: uWqb9XeSR32GYcFRldVD9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="113060555"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:42:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thsOl-0000000AY5N-0W7b;
	Tue, 11 Feb 2025 17:42:07 +0200
Date: Tue, 11 Feb 2025 17:42:06 +0200
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
Subject: Re: [PATCH v7 1/3] scanf: remove redundant debug logs
Message-ID: <Z6tvzhZIMVKWH8kK@smile.fi.intel.com>
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <20250211-scanf-kunit-convert-v7-1-c057f0a3d9d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-scanf-kunit-convert-v7-1-c057f0a3d9d8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 10:13:37AM -0500, Tamir Duberstein wrote:
> The test already prints the same information on failure; remove
> redundant pr_debug() logs.

...

>  #define _check_numbers_template(arg_fmt, expect, str, fmt, n_args, ap)		\
>  do {										\
> -	pr_debug("\"%s\", \"%s\" ->\n", str, fmt);				\

What *if* the n_args == 0 here?

>  	for (; n_args > 0; n_args--, expect++) {				\
>  		typeof(*expect) got = *va_arg(ap, typeof(expect));		\
> -		pr_debug("\t" arg_fmt "\n", got);				\
>  		if (got != *expect) {						\
>  			pr_warn("vsscanf(\"%s\", \"%s\", ...) expected " arg_fmt " got " arg_fmt "\n", \
>  				str, fmt, *expect, got);			\
> @@ -689,7 +687,6 @@ do {										\
>  	total_tests++;								\
>  	len = snprintf(test_buffer, BUF_SIZE, gen_fmt, expect);			\
>  	got = (fn)(test_buffer, &endp, base);					\
> -	pr_debug(#fn "(\"%s\", %d) -> " gen_fmt "\n", test_buffer, base, got);	\
>  	if (got != (expect)) {							\
>  		fail = true;							\
>  		pr_warn(#fn "(\"%s\", %d): got " gen_fmt " expected " gen_fmt "\n", \

-- 
With Best Regards,
Andy Shevchenko



