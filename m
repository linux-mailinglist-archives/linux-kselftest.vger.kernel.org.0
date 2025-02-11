Return-Path: <linux-kselftest+bounces-26358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EF5A30B87
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 13:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E35E7A4E79
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB281FCFE3;
	Tue, 11 Feb 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUE4WGa4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026B1F0E2B;
	Tue, 11 Feb 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276125; cv=none; b=rO1CKl8AO74VNsw7WC6MqDiRkpTQZGgI6eZyJOkwQ1440/DwIfw4nkGKzmp0QSNH1mDAeHi3NRUSqSuHt0sFAEU5uPxpNi9eUFUdlXAdy+m0qDcVENfVHFXwOgt/NLvaWaK+r5cgD1HRX7GuO+wGrlDgIFpdi9TY6ZbLR8hZeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276125; c=relaxed/simple;
	bh=zoSSmznO7SRSw6TE33qECXNuVo+1epHzg6wm9dkgQc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZeN0N9lgs9gaPTFHgVcGJRPtfVMQfG3l2xZpjy74qtXUOMz9VueE1iBd1QuJsg4LLfpULsWDV28e1Xsc/knvZKOOCFliqL+4LiowopT8AhLzcAtFXi/82zZzfD8J6a1v3QVtotirEENC2e+3phM5V9CrDkWABu+/mjiLFzc1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUE4WGa4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739276124; x=1770812124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zoSSmznO7SRSw6TE33qECXNuVo+1epHzg6wm9dkgQc4=;
  b=NUE4WGa4il3AIBLj/0y4HYO4pJtq5Rz0Q4H8t4zXX0WYEI4TJFFwD52o
   UHhEB7FhiubxKSmP6wUINGgk125LF9J6hB/UhQydAnb35bST2+ZyiXWky
   7UsvWmEDYpSF+hWWwivnnqe5aZya8Beh+BhtnbkkgPn48hSuExzLjckGK
   4GbbBlwqTNE9UB9+UdNosN+Qw2nyCYSSE8SYsL3kW0L5hLdiFhbJQDIUP
   H2wQHHAin5m9a4bKcJQqAmVPUV1kDsunD3Ih8aqvjSPGVQ3AVbwa+SSsw
   k3AH2x+e6FaRM0Xkx+KkLP/AlUmLwR4OK7TlolfDEwxblipgoz/tlcGSW
   Q==;
X-CSE-ConnectionGUID: nU8F/R5fQ7SHuU2U8mejEg==
X-CSE-MsgGUID: BrtafWDQQcye80VcYhUJFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="65245721"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="65245721"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:15:23 -0800
X-CSE-ConnectionGUID: 6l/IhbEUTZWS6GsSNhelHA==
X-CSE-MsgGUID: r/ZCHScQSI6gP4ESi2u1Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117688670"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:15:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thpAb-0000000AUx4-02jL;
	Tue, 11 Feb 2025 14:15:17 +0200
Date: Tue, 11 Feb 2025 14:15:16 +0200
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
Subject: Re: [PATCH v6 1/2] scanf: convert self-test to KUnit
Message-ID: <Z6s_VHExZe7ArgO7@smile.fi.intel.com>
References: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
 <20250210-scanf-kunit-convert-v6-1-4d583d07f92d@gmail.com>
 <Z6s2eqh0jkYHntUL@pathway.suse.cz>
 <CAJ-ks9n5=FYiFdmzWCkkACzX6oEVs=Z261_ZAKVq3tkqgJoSCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9n5=FYiFdmzWCkkACzX6oEVs=Z261_ZAKVq3tkqgJoSCQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 06:45:07AM -0500, Tamir Duberstein wrote:
> On Tue, Feb 11, 2025 at 6:37 AM Petr Mladek <pmladek@suse.com> wrote:
> > On Mon 2025-02-10 13:13:48, Tamir Duberstein wrote:

> > > +     kunit_printk(KERN_DEBUG, test, "\"%s\", \"%s\" ->", str, fmt);  \
> >
> > The switch from pr_debug() to kunit_printk() causes printing huge
> > amount of messages even when the test passes.
> 
> I'm not able to reproduce this. pr_debug expands to printk(KERN_DEBUG,
> ...) which is also what kunit_printk(KERN_DEBUG, ...) expands to. Can
> you help me understand how you're testing?

You are missing something.
https://stackoverflow.com/a/57762255/2511795

-- 
With Best Regards,
Andy Shevchenko



