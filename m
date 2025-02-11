Return-Path: <linux-kselftest+bounces-26387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 137F2A31057
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59110188A355
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA4253B6B;
	Tue, 11 Feb 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwtJoYxR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0C230D0E;
	Tue, 11 Feb 2025 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289278; cv=none; b=L6yO8hyo/ZgHU7aRboP6rx+rZMmOSg8MaWVl2Y0w39ngDfXwyLTYHuhbOOCCBLONBx+BENAr2tKD+hS2NXaJIXzZNhlFYVISWDS7TQEfXZs9Xxl31lHkdkyOmMcwLbxoNDtNCUNLRM6oVjgiYuBqe8OKYbuVV3bWzqkbvaB/EVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289278; c=relaxed/simple;
	bh=E1IBsIlWBxI5SBq09TRvUhIsQ20BynYMYhlkDWEjGOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb9AAwEs57b9s0OLNEnRNznnqegBCk8XJBmCiIQS0ihb2aPloaKJ76x0K0RnPZ7Q28+4UVVr4yqS+K0tOmx/N0WuCehdSWTw7gq+Hkeu1hPQTKk7/KAWxqcE9liwl8uKSPBF2DhwelYB+272+8F9JZMHskzsGjJLdU6l0Cyralg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwtJoYxR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739289277; x=1770825277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E1IBsIlWBxI5SBq09TRvUhIsQ20BynYMYhlkDWEjGOk=;
  b=YwtJoYxRxov71AfQaK5g/jR6Q7U1TDFMdBJ4twqtl7JFxpitbpy7FNXE
   pENL0TTzukyvP55RiSJM2+Z6o6+gbU/1pI54qoRhF8+tYWRF4dcabQmoM
   cq3yQzf1ObN1yO6hYtIUnrKWYcZFQP0lZSe5CmCPPkjZ3O2/WRveqCi/A
   uqdNVcih8z5qy3NpKLe79t8UNnLsQlSllwh/0miFUv9TjoMTFYp9SWMw4
   QI7N18U4YT3iOcAjUaSVmN6YF3JkJaAlx3Pf3wlTNuEB/Jxo42EPOheda
   uENQJNsezl07p/h/U5VDuXjIqu7YhtBeFJwEPW5NAfk5rBnNzldc+jn9x
   A==;
X-CSE-ConnectionGUID: TCY3L/WDRfC3POu8ClpeKQ==
X-CSE-MsgGUID: gMpe6u4YTpmPCMsPNJyJKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39777681"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="39777681"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:54:37 -0800
X-CSE-ConnectionGUID: ed+vfaGSRiC0jEmquMnNkQ==
X-CSE-MsgGUID: AKrmrPMFS7q8VgBLB+QeUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="143403706"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:54:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thsak-0000000AYIK-3PG9;
	Tue, 11 Feb 2025 17:54:30 +0200
Date: Tue, 11 Feb 2025 17:54:30 +0200
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
Message-ID: <Z6tytjvT1A-5TOrq@smile.fi.intel.com>
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <Z6tvciJpQgTwYpGx@smile.fi.intel.com>
 <CAJ-ks9mcxW7zY33FPB+mZ75dQ2Xqo-viM9CpbL=0i0WXUPJRhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mcxW7zY33FPB+mZ75dQ2Xqo-viM9CpbL=0i0WXUPJRhw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 10:47:03AM -0500, Tamir Duberstein wrote:
> On Tue, Feb 11, 2025 at 10:40 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 11, 2025 at 10:13:36AM -0500, Tamir Duberstein wrote:

...

> > > - Use original test assertions as KUNIT_*_EQ_MSG produces hard-to-parse
> > >   messages. The new failure output is:
> >
> > It would be good if you put into cover letter, or even in the respectful patch
> > the example of the error report for the old code and new code that it will be
> > clear how it changes.
> >
> > >     vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> > >             not ok 1 " "
> > >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
> > >     vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%2hx:%1hx:%4hx:%4hx:%4hx:%1hx:%1hx", ...) expected 892403712 got 28
> > >             not ok 2 ":"
> > >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
> > >     vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4hx,%4hx,%1hx,%4hx,%1hx,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
> > >             not ok 3 ","
> > >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
> > >     vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41", "%4hx-%4hx-%1hx-%3hx-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 99381
> > >             not ok 4 "-"
> > >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
> > >     vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%1hx/%2hx/%1hx/%4hx/%1hx/%4hx/%4hx", ...) expected 65559 got 1507328
> > >             not ok 5 "/"
> > >         # numbers_list_field_width_val_width: pass:0 fail:5 skip:0 total:5
> > >         not ok 4 numbers_list_field_width_val_width
> > >         # numbers_slice: ASSERTION FAILED at lib/scanf_kunit.c:92
> > >     vsscanf("3c87eac0f4afa1f9231da52", "%1hx%4hx%4hx%4hx%1hx%4hx%4hx%1hx", ...) expected 1257942031 got 2886715518
> 
> Makes sense. As you can see the error report for the new code is
> included here. I'll add the old code's error report if I have to
> respin v8.

At a bare minimum. can you add in the reply to this email?

-- 
With Best Regards,
Andy Shevchenko



