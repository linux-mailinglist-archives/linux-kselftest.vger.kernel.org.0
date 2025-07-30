Return-Path: <linux-kselftest+bounces-38084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F9DB162E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 16:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA36D3A7587
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C991296159;
	Wed, 30 Jul 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bz4SgOuh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973132D77F6;
	Wed, 30 Jul 2025 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886019; cv=none; b=PJDu94IvIXtPVkyH37kUKp0BHI7c29acWHVTPoTCqwn9O+XWsRjAexTxpDab1odLKkMlP/VI6TjjJgW2q10Lz48unb8KpECtXMvr8PoyFhlsTWLOSmoYIkc2Sif1D6D762KkJwOTZ+HyuACdfrJrfNND8vexU+DiQ2fL5ltw5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886019; c=relaxed/simple;
	bh=pmEi+E7y8N1fUJ2Skd77GVL6bd2TokFUGYI1O6z8kE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZc2xhKxXUqR6vZ9ZpKRjicYCaNFprm1a+PyvDHZ6v1nNZwyfRkEoxyZ4RxoTFSbfdKHVg4RmfQih5TmoTQmjHknIXdBTIKFIDrX6y8I1wyIKf4o2nhZkh5cq6k+jZQmNFpjz1uUC87QMeKD3bEWN6U0cuhKRGEwVjCNjiKFIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bz4SgOuh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753886017; x=1785422017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pmEi+E7y8N1fUJ2Skd77GVL6bd2TokFUGYI1O6z8kE8=;
  b=bz4SgOuhTjzo4tbiBXg9uUkDQlvXLWX9kmP7mUaQYk0Kk/ywMx2wZxgA
   rA2UV9FgN7CnvQgnp++gqklDemIpnb1HvaKQlHT7lUtZgCZ/xrx9wzOog
   uWrdeIzH1/kALWNp8DzkQiF2ygBE9ac6guFH9/9DdSPeSiNJ2egaw+64u
   NZ5dYQYWrZDBEMitfc4THthKkyBuVw5Kc04kLOfkE0lh7zL/RcDnk47jN
   OoTyH1PYs8tSNEfMb/WwWkZeCLveT4jL5IL9jR/BMV/unnekACg+pGqSq
   trPrIafJ4GTbNE5WJbd9T0h1u/banmFhq+BG17Mv2VZDCOkl5Z9NPyyxW
   g==;
X-CSE-ConnectionGUID: oSYIRRuPTGCEybDf0ElfwA==
X-CSE-MsgGUID: 1yMVzIKRRU265qP10OSNGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="60013797"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="60013797"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:33:37 -0700
X-CSE-ConnectionGUID: hkTixScCTg6cwK/DCkLisA==
X-CSE-MsgGUID: zW5cvb46RTmWg/nwgXfSFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="167492737"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Jul 2025 07:33:33 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uh7s2-0002pg-1A;
	Wed, 30 Jul 2025 14:33:30 +0000
Date: Wed, 30 Jul 2025 22:32:46 +0800
From: kernel test robot <lkp@intel.com>
To: Marie Zhussupova <marievic@google.com>, rmoar@google.com,
	davidgow@google.com, shuah@kernel.org, brendan.higgins@linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, elver@google.com,
	dvyukov@google.com, lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Marie Zhussupova <marievic@google.com>
Subject: Re: [PATCH 3/9] kunit: Pass additional context to generate_params
 for parameterized testing
Message-ID: <202507302223.BTl33Nvo-lkp@intel.com>
References: <20250729193647.3410634-4-marievic@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729193647.3410634-4-marievic@google.com>

Hi Marie,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/kunit]
[also build test ERROR on shuah-kselftest/kunit-fixes drm-xe/drm-xe-next linus/master v6.16 next-20250730]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marie-Zhussupova/kunit-Add-parent-kunit-for-parameterized-test-context/20250730-033818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
patch link:    https://lore.kernel.org/r/20250729193647.3410634-4-marievic%40google.com
patch subject: [PATCH 3/9] kunit: Pass additional context to generate_params for parameterized testing
config: arm64-randconfig-002-20250730 (https://download.01.org/0day-ci/archive/20250730/202507302223.BTl33Nvo-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507302223.BTl33Nvo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507302223.BTl33Nvo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/xe/xe_migrate.c:1917:
>> drivers/gpu/drm/xe/tests/xe_migrate.c:772:44: error: incompatible function pointer types initializing 'const void *(*)(struct kunit *, const void *, char *)' with an expression of type 'const void *(const void *, char *)' [-Wincompatible-function-pointer-types]
     772 |         KUNIT_CASE_PARAM(xe_migrate_sanity_kunit, xe_pci_live_device_gen_param),
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:215:24: note: expanded from macro 'KUNIT_CASE_PARAM'
     215 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
         |                                      ^~~~~~~~~~
   In file included from drivers/gpu/drm/xe/xe_migrate.c:1917:
   drivers/gpu/drm/xe/tests/xe_migrate.c:773:42: error: incompatible function pointer types initializing 'const void *(*)(struct kunit *, const void *, char *)' with an expression of type 'const void *(const void *, char *)' [-Wincompatible-function-pointer-types]
     773 |         KUNIT_CASE_PARAM(xe_validate_ccs_kunit, xe_pci_live_device_gen_param),
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:215:24: note: expanded from macro 'KUNIT_CASE_PARAM'
     215 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
         |                                      ^~~~~~~~~~
   2 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_dma_buf.c:319:
>> drivers/gpu/drm/xe/tests/xe_dma_buf.c:285:37: error: incompatible function pointer types initializing 'const void *(*)(struct kunit *, const void *, char *)' with an expression of type 'const void *(const void *, char *)' [-Wincompatible-function-pointer-types]
     285 |         KUNIT_CASE_PARAM(xe_dma_buf_kunit, xe_pci_live_device_gen_param),
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:215:24: note: expanded from macro 'KUNIT_CASE_PARAM'
     215 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
         |                                      ^~~~~~~~~~
   1 error generated.
--
   In file included from drivers/gpu/drm/xe/xe_bo.c:3128:
>> drivers/gpu/drm/xe/tests/xe_bo.c:610:41: error: incompatible function pointer types initializing 'const void *(*)(struct kunit *, const void *, char *)' with an expression of type 'const void *(const void *, char *)' [-Wincompatible-function-pointer-types]
     610 |         KUNIT_CASE_PARAM(xe_ccs_migrate_kunit, xe_pci_live_device_gen_param),
         |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:215:24: note: expanded from macro 'KUNIT_CASE_PARAM'
     215 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
         |                                      ^~~~~~~~~~
   In file included from drivers/gpu/drm/xe/xe_bo.c:3128:
   drivers/gpu/drm/xe/tests/xe_bo.c:611:38: error: incompatible function pointer types initializing 'const void *(*)(struct kunit *, const void *, char *)' with an expression of type 'const void *(const void *, char *)' [-Wincompatible-function-pointer-types]
     611 |         KUNIT_CASE_PARAM(xe_bo_evict_kunit, xe_pci_live_device_gen_param),
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:215:24: note: expanded from macro 'KUNIT_CASE_PARAM'
     215 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
         |                                      ^~~~~~~~~~
   In file included from drivers/gpu/drm/xe/xe_bo.c:3128:
   drivers/gpu/drm/xe/tests/xe_bo.c:624:44: error: incompatible function pointer types initializing 'const void *(*)(struct kunit *, const void *, char *)' with an expression of type 'const void *(const void *, char *)' [-Wincompatible-function-pointer-types]
     624 |         KUNIT_CASE_PARAM_ATTR(xe_bo_shrink_kunit, xe_pci_live_device_gen_param,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:228:24: note: expanded from macro 'KUNIT_CASE_PARAM_ATTR'
     228 |                   .generate_params = gen_params,                                \
         |                                      ^~~~~~~~~~
   3 errors generated.
--
   In file included from drivers/gpu/drm/xe/xe_mocs.c:799:
>> drivers/gpu/drm/xe/tests/xe_mocs.c:193:46: error: incompatible function pointer types initializing 'const void *(*)(struct kunit *, const void *, char *)' with an expression of type 'const void *(const void *, char *)' [-Wincompatible-function-pointer-types]
     193 |         KUNIT_CASE_PARAM(xe_live_mocs_kernel_kunit, xe_pci_live_device_gen_param),
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:215:24: note: expanded from macro 'KUNIT_CASE_PARAM'
     215 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
         |                                      ^~~~~~~~~~
   In file included from drivers/gpu/drm/xe/xe_mocs.c:799:
   drivers/gpu/drm/xe/tests/xe_mocs.c:194:45: error: incompatible function pointer types initializing 'const void *(*)(struct kunit *, const void *, char *)' with an expression of type 'const void *(const void *, char *)' [-Wincompatible-function-pointer-types]
     194 |         KUNIT_CASE_PARAM(xe_live_mocs_reset_kunit, xe_pci_live_device_gen_param),
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:215:24: note: expanded from macro 'KUNIT_CASE_PARAM'
     215 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
         |                                      ^~~~~~~~~~
   2 errors generated.


vim +772 drivers/gpu/drm/xe/tests/xe_migrate.c

54f07cfc016226 Akshata Jahagirdar 2024-07-17  770  
0237368193e897 Michal Wajdeczko   2024-07-08  771  static struct kunit_case xe_migrate_tests[] = {
37db1e77628551 Michal Wajdeczko   2024-07-20 @772  	KUNIT_CASE_PARAM(xe_migrate_sanity_kunit, xe_pci_live_device_gen_param),
37db1e77628551 Michal Wajdeczko   2024-07-20  773  	KUNIT_CASE_PARAM(xe_validate_ccs_kunit, xe_pci_live_device_gen_param),
0237368193e897 Michal Wajdeczko   2024-07-08  774  	{}
0237368193e897 Michal Wajdeczko   2024-07-08  775  };
0237368193e897 Michal Wajdeczko   2024-07-08  776  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

