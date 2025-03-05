Return-Path: <linux-kselftest+bounces-28318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A4A503EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 16:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822C83AEECF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB33724A056;
	Wed,  5 Mar 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkQ81W5h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C991C7000;
	Wed,  5 Mar 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190139; cv=none; b=sPKZRxMkuTclqhlFFpJpP3iulazpdhGWBTQDtoH6zVL8v2DV1zy3dW5ycEcR812R0ZH1Vp4QGG2exjBIpSmcFUJPJNIPr04EaybYJbz2AaDx0tpfzVKghfn9D9M7vsN48k9GeuFp2yBszanJfKTam7fwU01N1i8vSANc8dfLOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190139; c=relaxed/simple;
	bh=tFBN4amNXpctx4FzQkesqJ0A8u1NLRByxK3BhvsQhuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDPG87hh02wirCCknc7Ceu1fpujzhH+b1ovGvzkxdCfs3X35+BLlrsfQdmgvWIFCPm1011kG4zbhmeiT2PLefQMeX4oa8+Az3QX2H1rNMppr8FOiC19SMB4wfXXZgM+akWDUe54MrNFSm6dMdpaNIHRzma6/A3nz28fDoeyodM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WkQ81W5h; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741190138; x=1772726138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tFBN4amNXpctx4FzQkesqJ0A8u1NLRByxK3BhvsQhuw=;
  b=WkQ81W5h+qiIdd5zFtTWp3nKlLKSAi7zctekP4AJBGlm6qHf14vvDzN1
   nMCBYyHK4C7eSrqH0ssgMc2EAKaxour53Gv0PeicNQm2SrWOiewgFSpaz
   plZD5o7g5M7ffiOosDaikIW0css/hPs4soAi6f6o1gIH2EFdcMfTyA/fL
   gfshLPAILKce8huPs69QqOPCuXDFr6CFbotJ+XdS0NbnuavZ9e2puNdJE
   unCe9ZjUzq5DUwsmEnmsN2i2bbSGoENPNZzm/4i9tvSi9LCBMkN2/z7g8
   J45r8Uy9hMEZ96e6nKbLbypj5JanmWuOdEJ4mxnhj0vvQt/idXNK9jUoa
   Q==;
X-CSE-ConnectionGUID: TEkI8aCUThCQ/qz3SG5kbw==
X-CSE-MsgGUID: CJfINz9fSOmRBVWyzwmnmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52797235"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="52797235"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:55:38 -0800
X-CSE-ConnectionGUID: 7nIbSJWgSPKgRoxAnhSEUg==
X-CSE-MsgGUID: l9o1a++8TvqlNqqUv6L8Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="119223853"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:55:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpr5n-0000000HSLE-3NLs;
	Wed, 05 Mar 2025 17:55:31 +0200
Date: Wed, 5 Mar 2025 17:55:31 +0200
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
Message-ID: <Z8hz8-Sa6XRC0W5Z@smile.fi.intel.com>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-4-5ea50f95f83c@gmail.com>
 <Z8hnXIrMV0ct1YR6@pathway.suse.cz>
 <CAJ-ks9k7G31uBqygXNtfXcwVQXWvkaAWJh1vkFw2_VZ5bAz=Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9k7G31uBqygXNtfXcwVQXWvkaAWJh1vkFw2_VZ5bAz=Vg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 05, 2025 at 10:25:51AM -0500, Tamir Duberstein wrote:
> On Wed, Mar 5, 2025 at 10:01 AM Petr Mladek <pmladek@suse.com> wrote:
> > On Fri 2025-02-14 11:20:01, Tamir Duberstein wrote:

...

> > >  #include <kunit/test.h>
> > > -#include <linux/bitops.h>
> > > -#include <linux/kernel.h>
> > >  #include <linux/module.h>
> > > -#include <linux/overflow.h>
> > > -#include <linux/printk.h>
> > >  #include <linux/prandom.h>
> > >  #include <linux/slab.h>
> > > -#include <linux/string.h>
> > > +#include <linux/sprintf.h>
> > >
> > >  #define BUF_SIZE 1024
> >
> > It would make more sense to do this clean up in the 3rd patch
> > where some code was replaced by the kunit macros.
> >
> > Also I am not sure about the choice. It might make sense to remove
> > <include/printk.h> because the pr_*() calls were removed.
> > But what about the others? Did anyone request the clean up, please?
> >
> > I do not want to open a bike shadding because different people
> > have different opinion.
> >
> > I would personally prefer to keep the explicit includes when the
> > related API is still used. It helps to optimize nested includes
> > in the header files which helps to speedup build. AFAIK, there
> > are people working in this optimization and they might need
> > to revert this change.
> 
> Yeah, I don't feel strongly. I'll just restore all the includes.

It will be blind approach. Please, try to look at them closely and include what
you use (IWYU principle). I don't think anybody uses kernel.h here, for
example.

-- 
With Best Regards,
Andy Shevchenko



