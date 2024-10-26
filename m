Return-Path: <linux-kselftest+bounces-20749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E85C9B141D
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 03:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F8B1F22BAE
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D713B286;
	Sat, 26 Oct 2024 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4XYMxoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD86137932
	for <linux-kselftest@vger.kernel.org>; Sat, 26 Oct 2024 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729907809; cv=none; b=C32b5PwwY6AhjOSJkqk+jsqZAkBlMW47HUrZ8yvTm73y/XIY1B6Hm9jVwBKURnvdz6cN2teGJAHfY+Jdfwz4fXPqSGEkwbPxs73NFU7N/OrQClg7dqbPaPmbBk82vjRIkIkLpMOOfbEXBzz2C0TaXqz+CndDjl4wAEioQqSAAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729907809; c=relaxed/simple;
	bh=T2eCO1HyiiBrCKcuzU+FRZBXXT1rlsa7/FPHbVTSybw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJFdosoNSkJ7ulIPmjXJZ/iCQqrs/e/NVASV8E6WLRuVGe0ziZ4fkzMVUeh7qcNHiaMz9pv4b9/YVBZHxPK3AZKHluhBEYwOENNrzZcBhGbXNf6QjJjBqv+rLAMCUlld5xhvFvsCDHZ1DwBDmnkRpZiTg0z1dbjcZkq2esG8v1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4XYMxoP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729907807; x=1761443807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T2eCO1HyiiBrCKcuzU+FRZBXXT1rlsa7/FPHbVTSybw=;
  b=n4XYMxoPbcgml1bXHa4aNT01wQspxZV9MTkeeeWSmOd2b7cZjrjLsKAE
   KgYftu3AxX0teoS9qqQ6wRG0rdmZJ/qnw5ur44TsOD64LFFJgIHrzVKTS
   Qb/1Lzi1XTPqKpVWFXZTfz49G2Z3OyGx6wQvvXKj7vKQYnGvFwUYojJyo
   t1P2HRFeziqGE07WVnCZCwfdagUZXL97FJOxRZajcUioW2NCSFYijtkZd
   OY/fgSVjTA0kgOnZMDaymi80VwFV7QnHlKhc+OIUcM2sd264LIu24d/VR
   mec6ujkNlQ49tpWuBRc5b2usPs9TXqg253e84jkmoTl/POR9fC3QQy3Pl
   A==;
X-CSE-ConnectionGUID: munTPQrFTlOmj5Ek+ibmcw==
X-CSE-MsgGUID: A/Ck3cKXS9Ox62RNLCcu5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29452098"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29452098"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 18:56:44 -0700
X-CSE-ConnectionGUID: O7JNTABUS6+n1AjC1yeA7w==
X-CSE-MsgGUID: AbO1uwGLREeOS/MF4O2GRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85050156"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Oct 2024 18:56:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4W2h-000Z9M-1e;
	Sat, 26 Oct 2024 01:56:39 +0000
Date: Sat, 26 Oct 2024 09:55:52 +0800
From: kernel test robot <lkp@intel.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	brendan.higgins@linux.dev, davidgow@google.com
Cc: oe-kbuild-all@lists.linux.dev,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org, ricardo@marliere.net,
	linux-kernel-mentees@lists.linuxfoundation.org,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v2] lib/math: Add int_sqrt test suite
Message-ID: <202410260915.z3q6ZOGS-lkp@intel.com>
References: <20241024195511.72674-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024195511.72674-1-luis.hernandez093@gmail.com>

Hi Luis,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.12-rc4]
[also build test ERROR on linus/master]
[cannot apply to akpm-mm/mm-nonmm-unstable next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luis-Felipe-Hernandez/lib-math-Add-int_sqrt-test-suite/20241025-035643
base:   v6.12-rc4
patch link:    https://lore.kernel.org/r/20241024195511.72674-1-luis.hernandez093%40gmail.com
patch subject: [PATCH v2] lib/math: Add int_sqrt test suite
config: m68k-sun3_defconfig (https://download.01.org/0day-ci/archive/20241026/202410260915.z3q6ZOGS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260915.z3q6ZOGS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260915.z3q6ZOGS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/math/tests/int_sqrt_kunit.c:7:10: fatal error: limits.h: No such file or directory
       7 | #include <limits.h>
         |          ^~~~~~~~~~
   compilation terminated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +7 lib/math/tests/int_sqrt_kunit.c

     2	
     3	#include <kunit/test.h>
     4	#include <linux/math.h>
     5	#include <linux/module.h>
     6	#include <linux/string.h>
   > 7	#include <limits.h>
     8	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

