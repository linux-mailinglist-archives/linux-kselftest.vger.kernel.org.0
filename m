Return-Path: <linux-kselftest+bounces-26399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B738CA31284
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 18:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2618889C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4835A26215A;
	Tue, 11 Feb 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaeX91BL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49396262154;
	Tue, 11 Feb 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294111; cv=none; b=GNCOcajtbfgv2fkp1FNt/WrH9deGhdL8Bi/elUylHpg1J2zPlZrQrvBdc9Vup7RidvyEjeOOpyNPRb56bZ77t+aDM26Z5C5GSa8ZkLO6CkD567vsQQFarh24vT53jbctgNiHnwn8t1+1n5gXLz6M9S7QOv+i7AMm2Ps9zu53vas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294111; c=relaxed/simple;
	bh=mc25zAjsGl/MLP9YvKWqg7YDGswdp1sX6dk4qdXE2dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2Ymd7xU/uTfQ33Z1Rvo8Hj5jCJfQT26r9OQIDCIusPjUdtWnpRU2VqC1CecesVFvhKTYm7MOSlu35QPyTSTGhg3AXZLFodHRGYo/IVNW+qxOezS2F75T5UwUNSPMP+z1iSZ3/aB/f6k6tVlReyK+04Jh/1HHXOLrHRN3hoPqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaeX91BL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739294109; x=1770830109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mc25zAjsGl/MLP9YvKWqg7YDGswdp1sX6dk4qdXE2dk=;
  b=XaeX91BLqAQgzqtxkI9vgVMkwXixTOU4B9eoMhvLHQSETjFRNE7f8euR
   r+L4dljxNX5LE9FhPCz3Q9sR5mu/Z6/3qmKZymEzS9qwNVYFtiEBttMfl
   1g61CKqJ3NXvDlKWdHrtCTXBF1nweZkf23mmgCmKdlQSBsr4bNR/R02V5
   DGadjEMsTZFfVxLDvLh3d8fZFIiTnkPu+3d5ReTm+cJFuujxZzQXxJ2oC
   2YGzds+kOkiLwHyhyQDg8vhX1oLyoQeb2zkMBxS4W0i4p9HjK4sWoVWdA
   Nnl9fcnWRnUqRNF4XTZwJDeAbqvf7CFjbQnU3MwtaYqJuwOSlU2QeqhkI
   g==;
X-CSE-ConnectionGUID: ZLcod/ahQ/2G52dzAgZDUw==
X-CSE-MsgGUID: zN0446JfQ6iQqGM+JHxy6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39838503"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39838503"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:15:08 -0800
X-CSE-ConnectionGUID: cu4IeDMmTkGPGtxGZfXMCA==
X-CSE-MsgGUID: B/A1HWjMTfqSBo+IwgZKQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112404173"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:15:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thtqg-0000000AZr4-2IgI;
	Tue, 11 Feb 2025 19:15:02 +0200
Date: Tue, 11 Feb 2025 19:15:02 +0200
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
Message-ID: <Z6uFlh6TgXTnwHI-@smile.fi.intel.com>
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <20250211-scanf-kunit-convert-v7-1-c057f0a3d9d8@gmail.com>
 <Z6tvzhZIMVKWH8kK@smile.fi.intel.com>
 <CAJ-ks9=Bf42eojROr1X+BnmeQLa=zF7EAr4Y3n2exwZXum+rbQ@mail.gmail.com>
 <Z6tzkY375ffTVEXQ@smile.fi.intel.com>
 <CAJ-ks9=xqXsEp1_PP82qr_WDm_OF_uW2eKQfqC5+aDapWdoJ2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=xqXsEp1_PP82qr_WDm_OF_uW2eKQfqC5+aDapWdoJ2w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 11:02:59AM -0500, Tamir Duberstein wrote:
> On Tue, Feb 11, 2025 at 10:58 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 11, 2025 at 10:50:33AM -0500, Tamir Duberstein wrote:
> > > On Tue, Feb 11, 2025 at 10:42 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Feb 11, 2025 at 10:13:37AM -0500, Tamir Duberstein wrote:
> > > > > The test already prints the same information on failure; remove
> > > > > redundant pr_debug() logs.

...

> > > > > -     pr_debug("\"%s\", \"%s\" ->\n", str, fmt);                              \
> > > >
> > > > What *if* the n_args == 0 here?
> > >
> > > Then there's no assertion in this block, so the test cannot possibly fail here.
> >
> > Correct, but I'm talking about this in a scope of the removed debug print.
> > I.o.w. how would we even know that this was the case?
> >
> > (I'm not objecting removal, what I want from you is to have a descriptive and
> >  explanatory commit message that's answers to "why is this needed?" and "why is
> >  it safe to do?")
> 
> The true answer to "why is this needed" is Petr requested it in
> https://lore.kernel.org/all/Z6s2eqh0jkYHntUL@pathway.suse.cz/ (again,
> lore is having issues):
> 
> On Tue, Feb 11, 2025 at 6:37 AM Petr Mladek <pmladek@suse.com> wrote:

[...]

> > But when thinking more about it. I think that even pr_debug() is not
> > the right solution.
> >
> > IMHO, we really want to print these details only when the test fails.
> >
> > Best Regards,
> > Petr
> 
> The commit message already answers "why is it safe to do":

Not really. It answers that "why is it safe to do when test case fails?".

> > The test already prints the same information on failure; remove
> > redundant pr_debug() logs.
> 
> Perhaps what you're asking for is an assertion to be added if n_args
> == 0? I think that would make sense. Does it belong in this series?

I don't know if it's possible case. I don't know if we need an assertion.
Please, research.

-- 
With Best Regards,
Andy Shevchenko



