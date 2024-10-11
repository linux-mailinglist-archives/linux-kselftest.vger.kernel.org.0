Return-Path: <linux-kselftest+bounces-19532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BF99A1D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 12:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7005287019
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0B2212F0E;
	Fri, 11 Oct 2024 10:44:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9146212623;
	Fri, 11 Oct 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643474; cv=none; b=R9nXaVSwmmhRd2Y32N81IhZx/TfNJfmkkzX+CfUiYTipwimnEceDYKkqQyUjGB7pKSwkaUuSzk6HLVYCQQYLUO7HzFYsdrK3C6VDAP8wu7K6sDCHHrvLJ6DbYnsBz+dzeCJfpOUA79aH100q9Kao6VIyNPmdMur68ifcSJsTYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643474; c=relaxed/simple;
	bh=aLkwNoL+Bumhk3uwLGo9YRl0ADW9V4dVzznxlZue0eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by5z1+hPF5q4R4kQpleb/D8hPKScypKnCyRYPnJM5RIgyA65Y1izLdvg23O6z+K/HwHtq6EFNOFNzKZcYuoz/uGqPKjnNcbqvOIOF3421vqymLfcztwU1Db20fTPDCW/m5cwAOBBBwpYTCW3Cz6mm/ioF1ae5yxYVPC0Tdnf/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 5Qzed0R0Tzmb8OsOfJEdlw==
X-CSE-MsgGUID: fUouArolRPCUnmxyqtrKRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31945375"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="31945375"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:44:31 -0700
X-CSE-ConnectionGUID: i7HRo/ZrRyqIZExO8A9FwA==
X-CSE-MsgGUID: C8b20lxITgu7qel/zjZDuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="77078265"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:44:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1szD86-00000001rYz-2dPC;
	Fri, 11 Oct 2024 13:44:18 +0300
Date: Fri, 11 Oct 2024 13:44:18 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Fangrui Song <maskray@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH 3/6] lib: Move KUnit tests into tests/ subdirectory
Message-ID: <ZwkBgkthcQM7rLl7@smile.fi.intel.com>
References: <20241011072509.3068328-2-davidgow@google.com>
 <20241011072509.3068328-5-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011072509.3068328-5-davidgow@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 03:25:07PM +0800, David Gow wrote:
> From: Kees Cook <kees@kernel.org>
> 
> Following from the recent KUnit file naming discussion[1], move all
> KUnit tests in lib/ into lib/tests/.
> 
> Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> Acked-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Reviewed-by: David Gow <davidgow@google.com>
> [Rebased onto mm-nonmm-unstable, moved usercopy_kunit]
> Signed-off-by: David Gow <davidgow@google.com>

>  rename lib/{ => tests}/bitfield_kunit.c (100%)
>  rename lib/{ => tests}/checksum_kunit.c (100%)
>  rename lib/{ => tests}/cmdline_kunit.c (100%)
>  rename lib/{ => tests}/cpumask_kunit.c (100%)
>  rename lib/{ => tests}/fortify_kunit.c (100%)
>  rename lib/{ => tests}/hashtable_test.c (100%)
>  rename lib/{ => tests}/is_signed_type_kunit.c (100%)
>  rename lib/{ => tests}/kunit_iov_iter.c (100%)
>  rename lib/{ => tests}/list-test.c (100%)
>  rename lib/{ => tests}/memcpy_kunit.c (100%)
>  rename lib/{ => tests}/overflow_kunit.c (100%)
>  rename lib/{ => tests}/siphash_kunit.c (100%)
>  rename lib/{ => tests}/slub_kunit.c (100%)
>  rename lib/{ => tests}/stackinit_kunit.c (100%)
>  rename lib/{ => tests}/string_helpers_kunit.c (100%)
>  rename lib/{ => tests}/string_kunit.c (100%)
>  rename lib/{ => tests}/test_bits.c (100%)
>  rename lib/{ => tests}/test_fprobe.c (100%)
>  rename lib/{ => tests}/test_hash.c (100%)
>  rename lib/{ => tests}/test_kprobes.c (100%)
>  rename lib/{ => tests}/test_linear_ranges.c (100%)
>  rename lib/{ => tests}/test_list_sort.c (100%)
>  rename lib/{ => tests}/test_sort.c (100%)
>  rename lib/{ => tests}/usercopy_kunit.c (100%)

While I support the idea, I think this adds an additional churn in creating a
duplicate 'test' in the filenames. Why they all can't be cut while removing?
(at least this question is not answered in the commit message)

-- 
With Best Regards,
Andy Shevchenko



