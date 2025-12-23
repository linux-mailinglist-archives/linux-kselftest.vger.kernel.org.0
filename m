Return-Path: <linux-kselftest+bounces-47927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E568CCD96DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 14:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BF1F3002FC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69E33DEE5;
	Tue, 23 Dec 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/P/0Moe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EA33CE95;
	Tue, 23 Dec 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766496207; cv=none; b=AIxDz8t3wf5nS+XedDsq5wWjcFzWOkjwWoMpSy2WbE4LWHuMSROGh/4b5Qz4+zhM5+6NaPjGlkRPzUK61pnd6CE9lOcNWk79xP/h755/fmS3Nfhm2VJby1chOyfAN2AYiOylwp7TDJrE22G8Z3WjXG4+Aj3EF3HaaOdvlmTl18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766496207; c=relaxed/simple;
	bh=sVjyIGQrrpkyBkTFumzOYIT7xsfvu4X4mrPIwnTXsuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3PtwOekwbap79B9y3rB77tDr5kuv6qLpdmIwWkIAW7tiP3K9yLLGEjVYWldsiDdRmmAno1yaBSleNAKayWYI/+a5GcpzkcnDxdX/I0zltWw93qhv1CcBk5x/K3624B5vUatsujrqhEoabjSkScs0/ke2WFzRhjw3Nz3xUIEdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/P/0Moe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766496206; x=1798032206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sVjyIGQrrpkyBkTFumzOYIT7xsfvu4X4mrPIwnTXsuo=;
  b=f/P/0Moepvb7BnAMUboIJSl1RnjRacL07LzIuYcQPkII/cFfZSceKxmU
   UMoxIIC8zHCDFFBRsjsz9Qn0WmgaKZ7d07WOLwSHHTUQSPHLGPmwd6mGG
   KB5ZZJ98zPzGpjTb5im3AwQnJqi/KLWy9CXBoj3XmuWg0XqI4702MDxWQ
   B1jjFsGFRaXsoBaFMZTAZpA8PyLC8GofIcNcntTZhxMMMpJGqYN2WZqif
   0ka/7DAWsHwf57ZO9WVPeGR2s0vlQ5sDvRRnGSVyXQLKbpXB37hl9ZV22
   vZikZcj8/axlwGarXH7dvXpVekroxdCjMJDkPL2xnjOEMAb+XAj/+TxMc
   A==;
X-CSE-ConnectionGUID: BAkJ7ThNTSGAsBKDLcIv9Q==
X-CSE-MsgGUID: P9hdgKp3T9qR8kMWHpY7wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68226172"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="68226172"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 05:23:25 -0800
X-CSE-ConnectionGUID: trY28Fj2ScOhqzvD2TJVPw==
X-CSE-MsgGUID: pablz/scS8mrJb7R/PPP9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="199691761"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 23 Dec 2025 05:23:21 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vY2MA-000000001xh-2Udu;
	Tue, 23 Dec 2025 13:23:18 +0000
Date: Tue, 23 Dec 2025 21:22:27 +0800
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
Message-ID: <202512232124.O36Ud5C2-lkp@intel.com>
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
config: sparc-randconfig-001-20251223 (https://download.01.org/0day-ci/archive/20251223/202512232124.O36Ud5C2-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512232124.O36Ud5C2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512232124.O36Ud5C2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:65,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/kref.h:16,
                    from include/kunit/test.h:22,
                    from lib/bitmap_kunit.c:6:
   lib/bitmap_kunit.c: In function 'test_bitmap_printlist':
>> arch/sparc/include/asm/string.h:18:29: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
      18 | #define memset(s, c, count) __builtin_memset(s, c, count)
         |                             ^~~~~~~~~~~~~~~~
   lib/bitmap_kunit.c:468:9: note: in expansion of macro 'memset'
     468 |         memset(bmap, -1, PAGE_SIZE);
         |         ^~~~~~


vim +/memset +18 arch/sparc/include/asm/string.h

70a6fcf3283a0a Al Viro 2016-01-17  16  
70a6fcf3283a0a Al Viro 2016-01-17  17  #define __HAVE_ARCH_MEMSET
70a6fcf3283a0a Al Viro 2016-01-17 @18  #define memset(s, c, count) __builtin_memset(s, c, count)
70a6fcf3283a0a Al Viro 2016-01-17  19  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

