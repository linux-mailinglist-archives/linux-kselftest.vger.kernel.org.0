Return-Path: <linux-kselftest+bounces-28329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2564BA50B8E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 20:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3711894495
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64212512F5;
	Wed,  5 Mar 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYb12lad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217CA23027C;
	Wed,  5 Mar 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203330; cv=none; b=kFnJrr2pSKp4hsvL372pH3rUwSC6CV/nuFNilDhK/FpWQps45xZmIRJSWpVeX2d6z7A0tsFieplD3J0xSv6XYvIP1XWYxds+1AESn4045CI908LQGGxdPEHkLuHCAN8E1F6KwL+lc/slA5gPm6a6RxkjHZFbVs4/bZx65KwweKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203330; c=relaxed/simple;
	bh=mGnbkd4hbQAQrMUImRI0AKMF6vtBST1nNXEtdhcVzCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZJIUQTY3v1NPbw1jzCpczcAO2O1fW93AwFgpUfN6cqCvDzZTySvE4eKFn+QyqPMXjD0rVLK9c3BJ+mO3xQUGzRYZALzM4uPAESQAAR+IzS5l3uZtf8NIe0PlnOYRpw570VoOSO2n0QKL3r9mwK8dijNkIkIqSWw3gG5k+KrsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYb12lad; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741203329; x=1772739329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mGnbkd4hbQAQrMUImRI0AKMF6vtBST1nNXEtdhcVzCA=;
  b=mYb12ladYz3UCxsYrHwxUOUeDeOix19lR15KHQeNLITnA3Js3M3bZauh
   uT3EnISy8Dp6+03s5oQ3iIahlbk9auu/z7BWJAeQcGGl5wNqWPWCNjszK
   FHQR2KJYUI6gEz8ApIhgNfeo41FMNO1E8vbr739lbJ/qCIIBgeZcB+M0e
   7b6rZrfGWdScALfSjE2QCGvd532TKCi+qKghNjoayE4UPYNCKsEiohNfZ
   p9kVPVoT9qSR/mx7oCmwr3K9gZebiTLfCxcw/kWnUhYxOF2w1VVzTHJE1
   YT+OoCMkTV+w3fDbX53Mlu6ZHlNrWZM9wxO9WmKfpiXclxGvN5u2CDcQP
   w==;
X-CSE-ConnectionGUID: oAtlXKrrRhym1v7SWOErUQ==
X-CSE-MsgGUID: iw37rypxR0y8RVmEYXveAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41361997"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="41361997"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 11:35:28 -0800
X-CSE-ConnectionGUID: cFbw9MmTS7KDCoKNrjDK1A==
X-CSE-MsgGUID: nWxLVTUGQbipBJHURc84/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="118807304"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 11:35:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpuWY-0000000HVTs-0cLz;
	Wed, 05 Mar 2025 21:35:22 +0200
Date: Wed, 5 Mar 2025 21:35:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 4/4] scanf: break kunit into test cases
Message-ID: <Z8ineT_g9gzcftWe@smile.fi.intel.com>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>
 <Z8hnXIrMV0ct1YR6@pathway.suse.cz>
 <CAJ-ks9k7G31uBqygXNtfXcwVQXWvkaAWJh1vkFw2_VZ5bAz=Vg@mail.gmail.com>
 <Z8hz8-Sa6XRC0W5Z@smile.fi.intel.com>
 <CAJ-ks9kz-fEH1YLiCn3fHR9AtYQLCZS77GKfOObifEL4GLwk8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kz-fEH1YLiCn3fHR9AtYQLCZS77GKfOObifEL4GLwk8A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 05, 2025 at 10:57:47AM -0500, Tamir Duberstein wrote:
> On Wed, Mar 5, 2025 at 10:55 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Mar 05, 2025 at 10:25:51AM -0500, Tamir Duberstein wrote:
> > > On Wed, Mar 5, 2025 at 10:01 AM Petr Mladek <pmladek@suse.com> wrote:
> > > > On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:

...

> > > > >  #include <kunit/test.h>
> > > > > -#include <linux/bitops.h>
> > > > > -#include <linux/kernel.h>
> > > > >  #include <linux/module.h>
> > > > > -#include <linux/overflow.h>
> > > > > -#include <linux/printk.h>
> > > > >  #include <linux/prandom.h>
> > > > >  #include <linux/slab.h>
> > > > > -#include <linux/string.h>
> > > > > +#include <linux/sprintf.h>
> > > > >
> > > > >  #define BUF_SIZE 1024
> > > >
> > > > It would make more sense to do this clean up in the 3rd patch
> > > > where some code was replaced by the kunit macros.
> > > >
> > > > Also I am not sure about the choice. It might make sense to remove
> > > > <include/printk.h> because the pr_*() calls were removed.
> > > > But what about the others? Did anyone request the clean up, please?
> > > >
> > > > I do not want to open a bike shadding because different people
> > > > have different opinion.
> > > >
> > > > I would personally prefer to keep the explicit includes when the
> > > > related API is still used. It helps to optimize nested includes
> > > > in the header files which helps to speedup build. AFAIK, there
> > > > are people working in this optimization and they might need
> > > > to revert this change.
> > >
> > > Yeah, I don't feel strongly. I'll just restore all the includes.
> >
> > It will be blind approach. Please, try to look at them closely and include what
> > you use (IWYU principle). I don't think anybody uses kernel.h here, for
> > example.
> 
> I think I'm getting conflicting instructions here. IWYU is indeed what
> I did: bitops, kernel, overflow, printk are all unused; string is used
> only for sprintf, so I made that replacement.
> 
> However Petr said "Did anyone request the clean up, please?" which
> implies to me an aversion to unwanted cleanup. So, which is it please?

I believe he asks the background of the change. And if it made in a separate
patch it would be clearer to begin with (e.g., Suggested-by tag).

But I don't know how you deducted that it's unwanted. With a separate patch
we may discuss and see if it's wanted or not. In any case I would like to see
such a patch.

-- 
With Best Regards,
Andy Shevchenko



