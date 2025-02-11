Return-Path: <linux-kselftest+bounces-26400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7328A3129C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 18:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C542B3A956E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E86D26217B;
	Tue, 11 Feb 2025 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2S4FqWo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D0262166;
	Tue, 11 Feb 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294280; cv=none; b=OuGOGbt5GJDhxzfEbd6Vlzo3nLCHVy9hz7dgl/f/qTO/U7ZbEC805C7HPuvwtboL5NOtNuE9X5VW/WQjawSiHlhJpfoxHveoTDuVzjiWi7sK/C8wxK3h7CF+Rqa6PIXk6QBGRWdc69PUptjtIB40yu+1Zs/BiiSkFj4IHkBSP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294280; c=relaxed/simple;
	bh=hI2ir19ttm1JZmOsgx3iqdeaROzEgDL5gBVWGc06Umk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQxzPkDIxBwF/eYuKEvgp+jawRxwSFLCbNHuntc8Yoj0pN1m4zvqSJFDiQdkibQ2FLMUar5+e6NuZTBdow2RJ4BuuJmAYGHQmLJ4oQZQ80Ip9R3ZBmN85PCnjO5K0EGfeei6LuCCbS7AXjxzm6y71Hmc4LdReRgFnp9ZOHOEnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2S4FqWo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739294278; x=1770830278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hI2ir19ttm1JZmOsgx3iqdeaROzEgDL5gBVWGc06Umk=;
  b=m2S4FqWoqQIWWd2zzPJrYzXSqFHmLRxmxMicrp68WHiQsJh/RlrDuZEW
   QiBFO1Ea4xdyU7D6VQDptVCsJcPeml9WIs6wRjq4PKLKXVuLQs+SZS4BL
   suAdVBuC+4kLK5HtrfA0b1yrS0jZ08NGdpwkjkuDFVGPzeJeFbZwPWnmi
   wLWUsJ+9QvpZaqHkwrYT6YWQF57HIN4bGC1Y/3vso4GXeMWwISfccrD+W
   s6z3IoAsmJnCsnqI87hN/g7p4vrDB2rYGR8uu9hJ25q+EjnuGYfGx/O6Z
   fZFBEK6iaP9ItuwLgporju6jvBu2CsBvMdZXj/6DiSoOIIr9dt1fdfGfQ
   Q==;
X-CSE-ConnectionGUID: t5SjeLjnTC6ysMdc3MC25Q==
X-CSE-MsgGUID: j+cGfTEaTPiX4tRZ7Wc7kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39838936"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39838936"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:17:55 -0800
X-CSE-ConnectionGUID: su7XAvgHSSyc3ZJvavy+nA==
X-CSE-MsgGUID: y9YDWbK0QWeGNN6f2EzWLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112405691"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:17:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thttN-0000000AZuR-1hgu;
	Tue, 11 Feb 2025 19:17:49 +0200
Date: Tue, 11 Feb 2025 19:17:49 +0200
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
Message-ID: <Z6uGPZZ7LioJmekz@smile.fi.intel.com>
References: <20250211-scanf-kunit-convert-v7-0-c057f0a3d9d8@gmail.com>
 <Z6tvciJpQgTwYpGx@smile.fi.intel.com>
 <CAJ-ks9mcxW7zY33FPB+mZ75dQ2Xqo-viM9CpbL=0i0WXUPJRhw@mail.gmail.com>
 <Z6tytjvT1A-5TOrq@smile.fi.intel.com>
 <CAJ-ks9kSBMh0=dgPC-NiOhibnK_LhBjBdZ_AQ91h-DBZfYR1sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kSBMh0=dgPC-NiOhibnK_LhBjBdZ_AQ91h-DBZfYR1sw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 10:57:11AM -0500, Tamir Duberstein wrote:
> On Tue, Feb 11, 2025 at 10:54 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 11, 2025 at 10:47:03AM -0500, Tamir Duberstein wrote:
> > > On Tue, Feb 11, 2025 at 10:40 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Feb 11, 2025 at 10:13:36AM -0500, Tamir Duberstein wrote:

...

> > > > > - Use original test assertions as KUNIT_*_EQ_MSG produces hard-to-parse
> > > > >   messages. The new failure output is:
> > > >
> > > > It would be good if you put into cover letter, or even in the respectful patch
> > > > the example of the error report for the old code and new code that it will be
> > > > clear how it changes.
> > > >
> > > > >     vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4hx %1hx %1hx %4hx %4hx", ...) expected 837828163 got 1044578334
> > > > >             not ok 1 " "
> > > > >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
> > > > >     vsscanf("dc2:1c:0:3531:2621:5172:1:7", "%3hx:%2hx:%1hx:%4hx:%4hx:%4hx:%1hx:%1hx", ...) expected 892403712 got 28
> > > > >             not ok 2 ":"
> > > > >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
> > > > >     vsscanf("e083,8f6e,b,70ca,1,1,aab1,10e4", "%4hx,%4hx,%1hx,%4hx,%1hx,%1hx,%4hx,%4hx", ...) expected 1892286475 got 757614
> > > > >             not ok 3 ","
> > > > >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
> > > > >     vsscanf("2e72-8435-1-2fc-7cbd-c2f1-7158-2b41", "%4hx-%4hx-%1hx-%3hx-%4hx-%4hx-%4hx-%4hx", ...) expected 50069505 got 99381
> > > > >             not ok 4 "-"
> > > > >         # numbers_list_field_width_val_width: ASSERTION FAILED at lib/scanf_kunit.c:92
> > > > >     vsscanf("403/0/17/1/11e7/1/1fe8/34ba", "%3hx/%1hx/%2hx/%1hx/%4hx/%1hx/%4hx/%4hx", ...) expected 65559 got 1507328
> > > > >             not ok 5 "/"
> > > > >         # numbers_list_field_width_val_width: pass:0 fail:5 skip:0 total:5
> > > > >         not ok 4 numbers_list_field_width_val_width
> > > > >         # numbers_slice: ASSERTION FAILED at lib/scanf_kunit.c:92
> > > > >     vsscanf("3c87eac0f4afa1f9231da52", "%1hx%4hx%4hx%4hx%1hx%4hx%4hx%1hx", ...) expected 1257942031 got 2886715518
> > >
> > > Makes sense. As you can see the error report for the new code is
> > > included here. I'll add the old code's error report if I have to
> > > respin v8.
> >
> > At a bare minimum. can you add in the reply to this email?
> 
> Oh, sure:
> 
> On Tue, Feb 11, 2025 at 6:54 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > [...]
> >
> > [  383.100048] test_scanf: vsscanf("1574 9 64ca 935b 7 142d ff58 0", "%4hx %1hx %4hx %4hx %1hx %4hx %4hx %1hx", ...) expected 2472240330 got 1690959881
> > [  383.102843] test_scanf: vsscanf("f12:2:d:2:c166:1:36b:1906", "%3hx:%1hx:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...) expected 131085 got 851970
> > [  383.105376] test_scanf: vsscanf("4,b2fe,3,593,6,0,3bde,0", "%1hx,%4hx,%1hx,%3hx,%1hx,%1hx,%4hx,%1hx", ...) expected 93519875 got 242430
> > [  383.105659] test_scanf: vsscanf("6-1-2-1-d9e6-f-93e-e567", "%1hx-%1hx-%1hx-%1hx-%4hx-%1hx-%3hx-%4hx", ...) expected 65538 got 131073
> > [  383.106127] test_scanf: vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...) expected 125069 got 3901554741
> > [  383.106235] test_scanf: vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx%1hx%4hx%3hx", ...) expected 571539457 got 106936

> > [  383.106398] test_scanf: failed 6 out of 2545 tests

Is it me who cut something or the above missing this information (total tests)?
If the latter, how are we supposed to answer to the question if the failed test
is from new bunch of cases I hypothetically added or regression of the existing
ones? Without this it seems like I need to go through all failures. OTOH it may
be needed anyway as failing test case needs an investigation.

> This is from https://lore.kernel.org/all/Z6s6WsIw3VCGys6K@pathway.suse.cz/
> (doesn't load for me, seems lore is having problems).

-- 
With Best Regards,
Andy Shevchenko



