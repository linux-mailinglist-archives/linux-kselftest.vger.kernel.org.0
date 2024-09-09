Return-Path: <linux-kselftest+bounces-17517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2850797146B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 11:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B6D1F23A25
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5D71B3F01;
	Mon,  9 Sep 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCMJGnkA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08381B251C
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Sep 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875460; cv=none; b=a10pihsYPqX0BK0s08/cAu/Nt77sEcdpfJfy83v0lGJ8/W39mKvREn0HOO/EeJGoJ2aKJmWIPwpj7jwllo7zVJoGIp1HvUwYKBCQkGb2ubZlr94H5XEf9P6F6ARhCqbwPrSpDiQdwezh55FOoAsDD5WUYH/v46OfjpEx5mY563Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875460; c=relaxed/simple;
	bh=cpN4c04fp/ArFHGa6SsgZy4awJOaoPGXwyrkhJbDvIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/+3Cq2BWklskgQPp0kev8HQWgTKvSbm+CgUIatn2hLT7V+Dw1cigQYGieFBNVsd3o/b6+iNAnC87j7jeCYMhJc8bTrA8III0wrhXvw0i5SlYs/WLQhlDI+7PDSnTR/YwktyUgFCw8R4QvJuAS11IW//TRYre8BBFBSJ/JW2Yl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCMJGnkA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725875458; x=1757411458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cpN4c04fp/ArFHGa6SsgZy4awJOaoPGXwyrkhJbDvIg=;
  b=dCMJGnkAnDF7ZNBvYW81G8fHgZ6R3jxG+/hZDet+Bf30V4Li4bYgWu43
   strgMYPmPP9/7O4SpFGI7omb1Ap/AkI1irhsaCLB+c8L2nK6Hvt5lNQ5s
   likiPHZ27pqXqYb//x+HAXnS+0kiXwsXVYyQLLVY5UOYMdQ1bpOo/VmLn
   5Ha8rIkX2b0sOfLdjdzgrzt4ctzB8lVOy5rMpMCJ5rCAXCrSWHRib1s9I
   V4yk5tOHDoxg23v/eh09A6Pv0EwYuCNfO7YeJovr++3RdCe4toUdWX/ok
   k+bzWx6DK0FImAQF+B5b/Z7KYAXvtv1BNd7mCnfQvQHiXmYat4qMKjvKl
   Q==;
X-CSE-ConnectionGUID: WaEvWmc8TFahExrYmA/U+Q==
X-CSE-MsgGUID: 3OXvsyyqTdyWSc4qNU/BRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24361718"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24361718"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:50:58 -0700
X-CSE-ConnectionGUID: PwWFr16YRiyxWamW3eHXtQ==
X-CSE-MsgGUID: gv9Tf7MVT4CfRlIE0eicUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="67357831"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 Sep 2024 02:50:56 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snb2r-000EaU-0x;
	Mon, 09 Sep 2024 09:50:53 +0000
Date: Mon, 9 Sep 2024 17:50:26 +0800
From: kernel test robot <lkp@intel.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: oe-kbuild-all@lists.linux.dev,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4] lib/math: Add int_pow test suite
Message-ID: <202409091732.x5CGQKBV-lkp@intel.com>
References: <20240908224901.78595-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908224901.78595-1-luis.hernandez093@gmail.com>

Hi Luis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.11-rc6]
[also build test WARNING on linus/master next-20240906]
[cannot apply to akpm-mm/mm-nonmm-unstable]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luis-Felipe-Hernandez/lib-math-Add-int_pow-test-suite/20240909-065058
base:   v6.11-rc6
patch link:    https://lore.kernel.org/r/20240908224901.78595-1-luis.hernandez093%40gmail.com
patch subject: [PATCH v4] lib/math: Add int_pow test suite
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240909/202409091732.x5CGQKBV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240909/202409091732.x5CGQKBV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409091732.x5CGQKBV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/math/tests/int_pow_kunit.c:22:18: warning: integer constant is so large that it is unsigned
      22 |         { 2, 63, 9223372036854775808, "Large result"},
         |                  ^~~~~~~~~~~~~~~~~~~


vim +22 lib/math/tests/int_pow_kunit.c

    12	
    13	static const struct test_case_params params[] = {
    14		{ 64, 0, 1, "Power of zero" },
    15		{ 64, 1, 64, "Power of one"},
    16		{ 0, 5, 0, "Base zero" },
    17		{ 1, 64, 1, "Base one" },
    18		{ 2, 2, 4, "Two squared"},
    19		{ 2, 3, 8, "Two cubed"},
    20		{ 5, 5, 3125, "Five raised to the fifth power" },
    21		{ U64_MAX, 1, U64_MAX, "Max base" },
  > 22		{ 2, 63, 9223372036854775808, "Large result"},
    23	};
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

