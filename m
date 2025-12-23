Return-Path: <linux-kselftest+bounces-47928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCECD9980
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 15:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E6493001BDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5612332ED51;
	Tue, 23 Dec 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imrFSS0M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C0C482EB;
	Tue, 23 Dec 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499570; cv=none; b=XrIqsXBwmGgdakeFOgXyWBEUk3FtmfY0f+2RTBM/uxsX9+qzPkLFGnX3ed3XOtzGXB9CM5fZEhiMBcDznWI++5t1tDi4XIPvrGu7WbPqPhzK9nqfqF2I/pAp9G+gNDoBg8qXaflClVsvnip9sqmaZY/fo/xNmnxnnffTlxQDY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499570; c=relaxed/simple;
	bh=ZZQg8s4/nNF1ZlkzREeuw4bYSFY91iLUDaAHPJx09QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl8VpylmDGQ892qe8j+zo5wtFOACqpFfmERMmvQ6vQVICTusYTVrQ+wHKhEIgSropxKaSlp16tpFfFVh/sJHKYz0rJ+PSmnhrVYsULXI+jS/SFAmSKDCyn4pNY2ABMOLC4c7BNQjrBt4QpVK1hCwZRq3PGaj3olGyIQ1njLVgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imrFSS0M; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766499568; x=1798035568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZZQg8s4/nNF1ZlkzREeuw4bYSFY91iLUDaAHPJx09QE=;
  b=imrFSS0MkgdlisaLcn8jnrmqhsbVRfM8yyGnFaYf7sT68ooCcsrJJBxp
   qTAhAWuOT7lhdBvSVpHYN3kmaJ15bwgV6m/vjg8NnBEuBhCjk1PcKJHks
   HIBU8vF13oia1q6CMcVsABdKSy6znjnoIfVwv7Ms6PCzfQ3PN4rU9VDcw
   2DnheXXYEJw9R075TphvkBX1xyONpnk7h72qVjyDMewo1LLzizziOU4DU
   +6qOpe7bwmutM5e2iRSZjyPIojbveNrPMVPBFEarlFvoEaY3usJNYKrrv
   M4jxCSqGjBiE4h4U5uTY6t8PBm8UB1670Ab74ztuaEHlIkq54CMttSBJZ
   Q==;
X-CSE-ConnectionGUID: QFrkT55pS6mZe5Hg/7jcBA==
X-CSE-MsgGUID: eBzanp+0SUS5EchGFucOBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="79463739"
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="79463739"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 06:19:27 -0800
X-CSE-ConnectionGUID: Vg9Iuvx1SiG+8Rwxb+2JDA==
X-CSE-MsgGUID: nMqDeak8TR2g8NmJnysUGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="230813594"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 23 Dec 2025 06:19:23 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vY3EO-00000000217-3Qms;
	Tue, 23 Dec 2025 14:19:20 +0000
Date: Tue, 23 Dec 2025 22:18:06 +0800
From: kernel test robot <lkp@intel.com>
To: Tamir Duberstein <tamird@kernel.org>, David Gow <davidgow@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	Christophe Leroy <chleroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v2 3/3] bitmap: break kunit into test cases
Message-ID: <202512232235.vUHmJH7T-lkp@intel.com>
References: <20251222-bitmap-kunit-convert-v2-3-6a61a5330eff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222-bitmap-kunit-convert-v2-3-6a61a5330eff@gmail.com>

Hi Tamir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/test_bitmap-extract-benchmark-module/20251222-214306
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20251222-bitmap-kunit-convert-v2-3-6a61a5330eff%40gmail.com
patch subject: [PATCH v2 3/3] bitmap: break kunit into test cases
config: arm64-randconfig-004-20251223 (https://download.01.org/0day-ci/archive/20251223/202512232235.vUHmJH7T-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512232235.vUHmJH7T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512232235.vUHmJH7T-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/bitmap_kunit.c: In function 'test_bitmap_printlist':
>> lib/bitmap_kunit.c:468:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
     468 |  memset(bmap, -1, PAGE_SIZE);
         |  ^~~~~~


vim +/memset +468 lib/bitmap_kunit.c

6ea86bdfc169ba lib/test_bitmap.c  Yury Norov       2019-05-14  459  
8ef3340af7139f lib/bitmap_kunit.c Tamir Duberstein 2025-12-22  460  static void test_bitmap_printlist(struct kunit *kunittest)
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  461  {
8ef3340af7139f lib/bitmap_kunit.c Tamir Duberstein 2025-12-22  462  	static long bmap[PAGE_SIZE];
8ef3340af7139f lib/bitmap_kunit.c Tamir Duberstein 2025-12-22  463  	static char buf[PAGE_SIZE];
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  464  	char expected[256];
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  465  	int ret, slen;
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  466  	ktime_t time;
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  467  
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14 @468  	memset(bmap, -1, PAGE_SIZE);
8ef3340af7139f lib/bitmap_kunit.c Tamir Duberstein 2025-12-22  469  	slen = snprintf(expected, sizeof(expected), "0-%ld\n", PAGE_SIZE * 8 - 1);
8ef3340af7139f lib/bitmap_kunit.c Tamir Duberstein 2025-12-22  470  	KUNIT_ASSERT_GT(kunittest, slen, 0);
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  471  
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  472  	time = ktime_get();
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  473  	ret = bitmap_print_to_pagebuf(true, buf, bmap, PAGE_SIZE * 8);
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  474  	time = ktime_get() - time;
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  475  
8ef3340af7139f lib/bitmap_kunit.c Tamir Duberstein 2025-12-22  476  	KUNIT_ASSERT_EQ(kunittest, ret, slen);
8ef3340af7139f lib/bitmap_kunit.c Tamir Duberstein 2025-12-22  477  	KUNIT_ASSERT_STREQ(kunittest, buf, expected);
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  478  
8ef3340af7139f lib/bitmap_kunit.c Tamir Duberstein 2025-12-22  479  	kunit_info(kunittest, "Time: %llu", time);
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  480  }
db7313005e9c2d lib/test_bitmap.c  Yury Norov       2021-08-14  481  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

