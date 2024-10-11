Return-Path: <linux-kselftest+bounces-19543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DA899A588
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984E51F2366A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49E219494;
	Fri, 11 Oct 2024 13:57:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B892141C8;
	Fri, 11 Oct 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655052; cv=none; b=NAM1ZA/4ak+OVBxUhy9Zd5cYJJncfjoeTD04E5UpjUpCJqvD1TEXl5lX+xq3buSUxaiZ+J895t9NiEVB22dn5dTQw5g7+99HchK5uxHUNrHRc4XZ2JmxvzjDtsfZnJlXELLppduHP7ghK6nq0y83pXxi8O9+5d1zgneJjl4orrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655052; c=relaxed/simple;
	bh=FlqDCnWuL4KNQhR+h6uUEKDEhbwcTxPaUFOaJyJ6vok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsrSC07SD16AKKvSyWgRIJndvsCDBfd8BMg4jzPZCERMFVPHeo2GTHFtwqwPERrzB5qOAcs04ZRvdcUkMSWXkB8FnQNNS9eIB6nHz42fphr9LeHWdqm2AvyCUFyMwUfUNjAVhuanxm1ykF+63LWUV8sz5nQ8Oe3CR79gRIvJzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: pNCWxJ7TSm69TECq9dWJWQ==
X-CSE-MsgGUID: +fhCADBgT/6dYiFP86g8GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28003221"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28003221"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:57:30 -0700
X-CSE-ConnectionGUID: 4cV1aK6qSp6BUgLfnhSevw==
X-CSE-MsgGUID: aMc7/KfQQemJwd0eoRBBcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81533277"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:57:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1szG8r-00000001uQy-0nOd;
	Fri, 11 Oct 2024 16:57:17 +0300
Date: Fri, 11 Oct 2024 16:57:16 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Gow <davidgow@google.com>,
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
	Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Message-ID: <ZwkuvKogPuik90fN@smile.fi.intel.com>
References: <20241011072509.3068328-2-davidgow@google.com>
 <20241011072509.3068328-5-davidgow@google.com>
 <ZwkBgkthcQM7rLl7@smile.fi.intel.com>
 <CAMuHMdW=MF0H8YVuY6moLomTaxFEeCHgut1fruRGEkn79sbuTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW=MF0H8YVuY6moLomTaxFEeCHgut1fruRGEkn79sbuTA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 03:38:00PM +0200, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Fri, Oct 11, 2024 at 12:44 PM Andy Shevchenko <andy@kernel.org> wrote:
> > On Fri, Oct 11, 2024 at 03:25:07PM +0800, David Gow wrote:
> > > From: Kees Cook <kees@kernel.org>
> > >
> > > Following from the recent KUnit file naming discussion[1], move all
> > > KUnit tests in lib/ into lib/tests/.
> > >
> > > Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > Acked-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > Acked-by: Jakub Kicinski <kuba@kernel.org>
> > > Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> > > Reviewed-by: David Gow <davidgow@google.com>
> > > [Rebased onto mm-nonmm-unstable, moved usercopy_kunit]
> > > Signed-off-by: David Gow <davidgow@google.com>
> >
> > >  rename lib/{ => tests}/bitfield_kunit.c (100%)
> > >  rename lib/{ => tests}/checksum_kunit.c (100%)
> > >  rename lib/{ => tests}/cmdline_kunit.c (100%)
> > >  rename lib/{ => tests}/cpumask_kunit.c (100%)
> > >  rename lib/{ => tests}/fortify_kunit.c (100%)
> > >  rename lib/{ => tests}/hashtable_test.c (100%)
> > >  rename lib/{ => tests}/is_signed_type_kunit.c (100%)
> > >  rename lib/{ => tests}/kunit_iov_iter.c (100%)
> > >  rename lib/{ => tests}/list-test.c (100%)
> > >  rename lib/{ => tests}/memcpy_kunit.c (100%)
> > >  rename lib/{ => tests}/overflow_kunit.c (100%)
> > >  rename lib/{ => tests}/siphash_kunit.c (100%)
> > >  rename lib/{ => tests}/slub_kunit.c (100%)
> > >  rename lib/{ => tests}/stackinit_kunit.c (100%)
> > >  rename lib/{ => tests}/string_helpers_kunit.c (100%)
> > >  rename lib/{ => tests}/string_kunit.c (100%)
> > >  rename lib/{ => tests}/test_bits.c (100%)
> > >  rename lib/{ => tests}/test_fprobe.c (100%)
> > >  rename lib/{ => tests}/test_hash.c (100%)
> > >  rename lib/{ => tests}/test_kprobes.c (100%)
> > >  rename lib/{ => tests}/test_linear_ranges.c (100%)
> > >  rename lib/{ => tests}/test_list_sort.c (100%)
> > >  rename lib/{ => tests}/test_sort.c (100%)
> > >  rename lib/{ => tests}/usercopy_kunit.c (100%)
> >
> > While I support the idea, I think this adds an additional churn in creating a
> > duplicate 'test' in the filenames. Why they all can't be cut while removing?
> > (at least this question is not answered in the commit message)
> 
> To avoid duplicate *.ko file names?

With what? Sorry, but I don't see how it's a problem. These are test cases.
Do they use kernel command line parameters? If so, shouldn't KUnit take care
about it in a more proper way?

-- 
With Best Regards,
Andy Shevchenko



