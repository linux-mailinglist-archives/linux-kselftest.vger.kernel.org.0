Return-Path: <linux-kselftest+bounces-19556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D2F99A9D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 19:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C1F1F23A83
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA511A08CC;
	Fri, 11 Oct 2024 17:23:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ECA81AD7;
	Fri, 11 Oct 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667385; cv=none; b=Agivt58RmvLBbBJvDbqAJyC7kMGf1x3vUXpLlfDzmbcgZOcIO6kRBNCrmjjiuOrrD+PoIAxF0qjyABZgQiL30pWjsfAQn693CFKy9HaovO6E3M2Tkjun/60pIPfO7AuVevVGQtC5vBYX4Eq65GtDIusIned0ZM7dNbeb0kuFIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667385; c=relaxed/simple;
	bh=18BtVOjyvnnHLDd5j0hRByjZMiG+iF1kHNIlumGHGZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjiZ5KuSJ2BwGqlF1Mf02xaoJZlkwVFE+Dbp2r0ZuAeBRs88fjFNsG+QfFgvzB/QS3xoaLb9AQs6dhUlq9QdrNUWWHIWYC//zlDwLfYHKDOR3ZYc8XoICsYYVDzuXLHuyHb+iAw5sWsQ2PSm7PaXMPK8iZK1HLnvE0b80hAR3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: L3Ga3IuDS2uqaN1q23K2sg==
X-CSE-MsgGUID: iXT8DvEKRfW8I5ttXueu/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="27881798"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="27881798"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:23:03 -0700
X-CSE-ConnectionGUID: ICfa8/EYTgKURgel5779rA==
X-CSE-MsgGUID: lSMYAuD+QbO10JiMebE9ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="76612540"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:22:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1szJLm-00000001zNk-0VkT;
	Fri, 11 Oct 2024 20:22:50 +0300
Date: Fri, 11 Oct 2024 20:22:49 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	David Gow <davidgow@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Daniel Latypov <dlatypov@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	David Howells <dhowells@redhat.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Fangrui Song <maskray@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH 3/6] lib: Move KUnit tests into tests/ subdirectory
Message-ID: <Zwle6aDpkf_0ZCaX@smile.fi.intel.com>
References: <20241011072509.3068328-2-davidgow@google.com>
 <20241011072509.3068328-5-davidgow@google.com>
 <ZwkBgkthcQM7rLl7@smile.fi.intel.com>
 <CAMuHMdW=MF0H8YVuY6moLomTaxFEeCHgut1fruRGEkn79sbuTA@mail.gmail.com>
 <ZwkuvKogPuik90fN@smile.fi.intel.com>
 <CAMuHMdU_1oZEeJ5Onrbtx-iZjrK_bQ6YWNMdRYp-E1_5E7rMSQ@mail.gmail.com>
 <CAHp75Vecwe_LaSKSprwfrdpDhoJbXgajQUVY23L+VyGoxtGH7A@mail.gmail.com>
 <600a11af-cf42-45d9-9be8-b7066d90c89f@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <600a11af-cf42-45d9-9be8-b7066d90c89f@csgroup.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 06:29:49PM +0200, Christophe Leroy wrote:
> Le 11/10/2024 à 17:21, Andy Shevchenko a écrit :
> > [Vous ne recevez pas souvent de courriers de andy.shevchenko@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Fri, Oct 11, 2024 at 5:20 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Oct 11, 2024 at 3:57 PM Andy Shevchenko <andy@kernel.org> wrote:
> > > > On Fri, Oct 11, 2024 at 03:38:00PM +0200, Geert Uytterhoeven wrote:
> > > > > On Fri, Oct 11, 2024 at 12:44 PM Andy Shevchenko <andy@kernel.org> wrote:
> > > > > > On Fri, Oct 11, 2024 at 03:25:07PM +0800, David Gow wrote:

...

> > > > > > >   rename lib/{ => tests}/bitfield_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/checksum_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/cmdline_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/cpumask_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/fortify_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/hashtable_test.c (100%)
> > > > > > >   rename lib/{ => tests}/is_signed_type_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/kunit_iov_iter.c (100%)
> > > > > > >   rename lib/{ => tests}/list-test.c (100%)
> > > > > > >   rename lib/{ => tests}/memcpy_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/overflow_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/siphash_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/slub_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/stackinit_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/string_helpers_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/string_kunit.c (100%)
> > > > > > >   rename lib/{ => tests}/test_bits.c (100%)
> > > > > > >   rename lib/{ => tests}/test_fprobe.c (100%)
> > > > > > >   rename lib/{ => tests}/test_hash.c (100%)
> > > > > > >   rename lib/{ => tests}/test_kprobes.c (100%)
> > > > > > >   rename lib/{ => tests}/test_linear_ranges.c (100%)
> > > > > > >   rename lib/{ => tests}/test_list_sort.c (100%)
> > > > > > >   rename lib/{ => tests}/test_sort.c (100%)
> > > > > > >   rename lib/{ => tests}/usercopy_kunit.c (100%)
> > > > > > 
> > > > > > While I support the idea, I think this adds an additional churn in creating a
> > > > > > duplicate 'test' in the filenames. Why they all can't be cut while removing?
> > > > > > (at least this question is not answered in the commit message)
> > > > > 
> > > > > To avoid duplicate *.ko file names?
> > > > 
> > > > With what? Sorry, but I don't see how it's a problem. These are test cases.
> > > > Do they use kernel command line parameters? If so, shouldn't KUnit take care
> > > > about it in a more proper way?
> > > 
> > > If .e.g. lib/list_sort.o could be modular, its module would be called
> > > "list_sort.ko", conflicting with the "list_sort.ko" test module.
> 
> But as it is now in lib/tests/, the module will also be installed in tests/
> subdir, so it shouldn't clash anymore ?
> 
> You'd have:
> 
> /lib/modules/lib/list_sort.ko and
> /lib/modules/lib/tests/list_sort.ko
> 
> Or did I miss something ?

I believe Geert is talking about `modprobe list-sort` in the userspace.
Which one will be loaded?

> > Can't this be solved by automatically adding a prefix in Makefile for
> > kunit tests, for example?

-- 
With Best Regards,
Andy Shevchenko



