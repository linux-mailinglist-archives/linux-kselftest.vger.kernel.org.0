Return-Path: <linux-kselftest+bounces-26719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9279CA37039
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 19:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400D41703B4
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 18:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DF1EDA23;
	Sat, 15 Feb 2025 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCCkP0o2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F91F4180;
	Sat, 15 Feb 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739645487; cv=none; b=tKqWsuHvtMWZ1jzfiLO+4lTcxdT5ElRrKmxKHO+Kcu/m6CHbvdocBqsxLzNLBwlIAKkw+Y5BXAHWq/0a1cg5Iilg9JnhiQn9fFs2HEDe49kDG1dtBaMNDk28qwrTk797gdFzuEm5A8eilNQOCJM42ScxffFg5C5+zdHy3HDASoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739645487; c=relaxed/simple;
	bh=63NUTSPkfjclQa984MAUwZu52tLXBqvoqpXpqYwVOIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3nMr6DrLh9uk2SZVcF59R86XFB3aPjsx4jmlgPJSoNfGo8RraIG2KSat7R3vNaiDZjuQfdbFCKCAEPLxomL8FfOwVjoq/IIqWdxOvQGhoserV4DgkViVLPw+YYFbmr4vaxWg9/yGBW9VmpiRQ9QFGZNI7OGmNsruouAXr7jwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCCkP0o2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739645484; x=1771181484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=63NUTSPkfjclQa984MAUwZu52tLXBqvoqpXpqYwVOIM=;
  b=hCCkP0o2ZBBe7Xzylpms/0cWVZPcYcLDzBBUJO5YMSC55y9IftwsK8hx
   F8EvX1Qkm6r2g4fi+YMYW8y1WQk1xOcw/jz3NisYkoqE3XlkmaKg8kgo+
   /JdwJRAjDfqgAOAE0s3zFXWz5FlS385TLQarS8/ol4xvKs4VhzX240eAU
   H8uKgFSFj4XiRbGMVAsqcK5p0NdAWeZeq1qJ+vio5JjqHgJwELJ/WRiXH
   pqMkmhiZHMjcTyRuDkLWA1MsejZOCUtJS4M+X5FDlZhqk11OigQNJvDix
   xGvISZ13SdxKPwMjWov4JPNX6z6ypArxXmQibxEbsHngyEjGintbgP+C1
   w==;
X-CSE-ConnectionGUID: ROtn+BPnSsyKGV0jSrSofw==
X-CSE-MsgGUID: G7Dh+hcBRaexeNPyMHHctg==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40234733"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40234733"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 10:51:23 -0800
X-CSE-ConnectionGUID: F8buz/y/Slq76GWXplLgzQ==
X-CSE-MsgGUID: nuYRKGGATeSc1dKW7gmfuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="144596655"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Feb 2025 10:51:19 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjNG0-001B5b-2T;
	Sat, 15 Feb 2025 18:51:16 +0000
Date: Sun, 16 Feb 2025 02:50:45 +0800
From: kernel test robot <lkp@intel.com>
To: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v8 3/4] scanf: convert self-test to KUnit
Message-ID: <202502160245.KUrryBJR-lkp@intel.com>
References: <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-scanf-kunit-convert-v8-3-5ea50f95f83c@gmail.com>

Hi Tamir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7b7a883c7f4de1ee5040bd1c32aabaafde54d209]

url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/scanf-implicate-test-line-in-failure-messages/20250215-002302
base:   7b7a883c7f4de1ee5040bd1c32aabaafde54d209
patch link:    https://lore.kernel.org/r/20250214-scanf-kunit-convert-v8-3-5ea50f95f83c%40gmail.com
patch subject: [PATCH v8 3/4] scanf: convert self-test to KUnit
config: sh-randconfig-002-20250216 (https://download.01.org/0day-ci/archive/20250216/202502160245.KUrryBJR-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502160245.KUrryBJR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160245.KUrryBJR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <command-line>:
   lib/tests/scanf_kunit.c: In function 'numbers_list_ll':
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_ll' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:390:9: note: in expansion of macro 'numbers_list_8'
     390 |         numbers_list_8(unsigned long long, "%llu",   delim, "llu", check_ull);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_ll' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:391:9: note: in expansion of macro 'numbers_list_8'
     391 |         numbers_list_8(long long,          "%lld",   delim, "lld", check_ll);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_ll' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:392:9: note: in expansion of macro 'numbers_list_8'
     392 |         numbers_list_8(long long,          "%lld",   delim, "lli", check_ll);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_ll' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:393:9: note: in expansion of macro 'numbers_list_8'
     393 |         numbers_list_8(unsigned long long, "%llx",   delim, "llx", check_ull);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_ll' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:394:9: note: in expansion of macro 'numbers_list_8'
     394 |         numbers_list_8(unsigned long long, "0x%llx", delim, "llx", check_ull);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_ll' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:395:9: note: in expansion of macro 'numbers_list_8'
     395 |         numbers_list_8(long long,          "0x%llx", delim, "lli", check_ll);
         |         ^~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c: In function 'numbers_list_l':
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_l' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:400:9: note: in expansion of macro 'numbers_list_8'
     400 |         numbers_list_8(unsigned long,      "%lu",    delim, "lu", check_ulong);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_l' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:401:9: note: in expansion of macro 'numbers_list_8'
     401 |         numbers_list_8(long,               "%ld",    delim, "ld", check_long);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_l' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:402:9: note: in expansion of macro 'numbers_list_8'
     402 |         numbers_list_8(long,               "%ld",    delim, "li", check_long);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_l' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:403:9: note: in expansion of macro 'numbers_list_8'
     403 |         numbers_list_8(unsigned long,      "%lx",    delim, "lx", check_ulong);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_l' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:404:9: note: in expansion of macro 'numbers_list_8'
     404 |         numbers_list_8(unsigned long,      "0x%lx",  delim, "lx", check_ulong);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_l' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:405:9: note: in expansion of macro 'numbers_list_8'
     405 |         numbers_list_8(long,               "0x%lx",  delim, "li", check_long);
         |         ^~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c: In function 'numbers_list_d':
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_d' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:410:9: note: in expansion of macro 'numbers_list_8'
     410 |         numbers_list_8(unsigned int,       "%u",     delim, "u", check_uint);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_d' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:411:9: note: in expansion of macro 'numbers_list_8'
     411 |         numbers_list_8(int,                "%d",     delim, "d", check_int);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_d' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:412:9: note: in expansion of macro 'numbers_list_8'
     412 |         numbers_list_8(int,                "%d",     delim, "i", check_int);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_d' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:413:9: note: in expansion of macro 'numbers_list_8'
     413 |         numbers_list_8(unsigned int,       "%x",     delim, "x", check_uint);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_d' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:414:9: note: in expansion of macro 'numbers_list_8'
     414 |         numbers_list_8(unsigned int,       "0x%x",   delim, "x", check_uint);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_d' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:415:9: note: in expansion of macro 'numbers_list_8'
     415 |         numbers_list_8(int,                "0x%x",   delim, "i", check_int);
         |         ^~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c: In function 'numbers_list_h':
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_h' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:420:9: note: in expansion of macro 'numbers_list_8'
     420 |         numbers_list_8(unsigned short,     "%hu",    delim, "hu", check_ushort);
         |         ^~~~~~~~~~~~~~
>> include/linux/compiler.h:197:61: warning: function 'numbers_list_h' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:421:9: note: in expansion of macro 'numbers_list_8'
     421 |         numbers_list_8(short,              "%hd",    delim, "hd", check_short);
         |         ^~~~~~~~~~~~~~
   include/linux/compiler.h:197:61: warning: function 'numbers_list_h' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:422:9: note: in expansion of macro 'numbers_list_8'
     422 |         numbers_list_8(short,              "%hd",    delim, "hi", check_short);
         |         ^~~~~~~~~~~~~~
   include/linux/compiler.h:197:61: warning: function 'numbers_list_h' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                             ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:9: note: in expansion of macro 'BUILD_BUG_ON'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |         ^~~~~~~~~~~~
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/tests/scanf_kunit.c:333:22: note: in expansion of macro 'ARRAY_SIZE'
     333 |         BUILD_BUG_ON(ARRAY_SIZE(arr) != 8);                                     \
         |                      ^~~~~~~~~~
   lib/tests/scanf_kunit.c:356:9: note: in expansion of macro 'test_array_8'
     356 |         test_array_8(fn, expect, test_buffer, fmt_buffer, result);              \
         |         ^~~~~~~~~~~~
   lib/tests/scanf_kunit.c:423:9: note: in expansion of macro 'numbers_list_8'
     423 |         numbers_list_8(unsigned short,     "%hx",    delim, "hx", check_ushort);
         |         ^~~~~~~~~~~~~~
   include/linux/compiler.h:197:61: warning: function 'numbers_list_h' might be a candidate for 'gnu_scanf' format attribute [-Wsuggest-attribute=format]
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))


vim +197 include/linux/compiler.h

230fa253df6352a Christian Borntraeger 2014-11-25  193  
cb7380de9e4cbc9 Kees Cook             2025-02-05  194  #ifdef __CHECKER__
cb7380de9e4cbc9 Kees Cook             2025-02-05  195  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) (0)
cb7380de9e4cbc9 Kees Cook             2025-02-05  196  #else /* __CHECKER__ */
cb7380de9e4cbc9 Kees Cook             2025-02-05 @197  #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
cb7380de9e4cbc9 Kees Cook             2025-02-05  198  #endif /* __CHECKER__ */
cb7380de9e4cbc9 Kees Cook             2025-02-05  199  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

