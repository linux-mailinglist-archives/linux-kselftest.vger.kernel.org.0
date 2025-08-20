Return-Path: <linux-kselftest+bounces-39393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7F2B2E504
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 20:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FB61CC25A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F172224EA90;
	Wed, 20 Aug 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBUFNct9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DB259C93;
	Wed, 20 Aug 2025 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714696; cv=none; b=CXtaDbMIsZaqFWUSqb/b/TXTfHmarXrnalLhnIdJqXZr9DqD5GAfezfEPxnVWWokQQjgWnTB/tDznM1NRoUOylAZBrkSDXCTIUGKBXIAgus/EPqyfr0FPNfMAb/hKZpVyjoWH3CYwQrmwT115SKPW2dNcuHi+qOOqeD8S90ZN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714696; c=relaxed/simple;
	bh=odKuUwppF1tAKXek3OL0+/6yPLjV/i+MWkX+owgQf/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMbAGjqblL6MeAdyzevoCF2nFyghxbGiWXJO27SQ3hISf0D/1sITTNq4EgAtaRJ7xrUwUq/KR7Rhr+m4HGESHdKLM3l0P/guuKGTzIzkacMB87nun7mbOpOBte8+xsfyldBa4KV3S/uNyAOfuOUZHHaSvWYO3gvlHXBRqwvqfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBUFNct9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755714695; x=1787250695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=odKuUwppF1tAKXek3OL0+/6yPLjV/i+MWkX+owgQf/A=;
  b=cBUFNct985PfJhhv3H5Q2PUlk8P3xPd6E4Wn+uUtSd9dBKUuwZC1UaJz
   pWFqayT2ze4Pg2r9LLa1lWfL7YMI5VHp9qGIJarB2U/2hvwIoGWwcgbEI
   UPG6Xg2lYLrG5Fp7qyDtBTEpw0V/jAV2i5LDC1FO4q/LK/Hf4k2Bnywga
   LLlv5DuXrwCeFeCtTuD0x8ptG3VeaU2UG2cGBXPfWD481pA8N+IJoDDao
   UZiglHk4Ex6JnQW5p8GN+0BWF1kwdd63ncGhizfPg8ctuaV2BGTOI/3fG
   c40wSkN7UqCdPHvFPzFC83iSGBkRs+pOpH8rMbWp468rqdHDCsi53f4dh
   A==;
X-CSE-ConnectionGUID: lRm4LKnNQvKd7TZ5zBcdzA==
X-CSE-MsgGUID: z1x7embQSbKK3T4+J4VIcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="60620377"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="60620377"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 11:31:32 -0700
X-CSE-ConnectionGUID: DWjqdWMDTSKUkQgSr9qtaw==
X-CSE-MsgGUID: L0ZGg7U+QJiBRvH/Uax2HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167406830"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2025 11:31:29 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uonao-000Jb9-2t;
	Wed, 20 Aug 2025 18:31:26 +0000
Date: Thu, 21 Aug 2025 02:31:13 +0800
From: kernel test robot <lkp@intel.com>
To: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Marie Zhussupova <marievic@google.com>, marievictoria875@gmail.com,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Gow <davidgow@google.com>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	intel-xe@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/xe/tests: Fix some additional gen_params
 signatures
Message-ID: <202508210248.4CiPvWGD-lkp@intel.com>
References: <20250819073434.1411114-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819073434.1411114-1-davidgow@google.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/kunit]
[also build test ERROR on linus/master v6.17-rc2 next-20250820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Gow/kunit-Only-output-a-test-plan-if-we-re-using-kunit_array_gen_params/20250819-154731
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
patch link:    https://lore.kernel.org/r/20250819073434.1411114-1-davidgow%40google.com
patch subject: [PATCH 1/2] drm/xe/tests: Fix some additional gen_params signatures
config: x86_64-randconfig-071-20250820 (https://download.01.org/0day-ci/archive/20250821/202508210248.4CiPvWGD-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250821/202508210248.4CiPvWGD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508210248.4CiPvWGD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:4:
>> drivers/gpu/drm/xe/tests/xe_pci_test.h:28:49: error: declaration of 'struct kunit' will not be visible outside of this function [-Werror,-Wvisibility]
      28 | const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void *prev, char *desc);
         |                                                 ^
   drivers/gpu/drm/xe/tests/xe_pci_test.h:29:46: error: declaration of 'struct kunit' will not be visible outside of this function [-Werror,-Wvisibility]
      29 | const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *prev, char *desc);
         |                                              ^
   drivers/gpu/drm/xe/tests/xe_pci_test.h:30:40: error: declaration of 'struct kunit' will not be visible outside of this function [-Werror,-Wvisibility]
      30 | const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, char *desc);
         |                                        ^
   drivers/gpu/drm/xe/tests/xe_pci_test.h:31:49: error: declaration of 'struct kunit' will not be visible outside of this function [-Werror,-Wvisibility]
      31 | const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc);
         |                                                 ^
   4 errors generated.


vim +28 drivers/gpu/drm/xe/tests/xe_pci_test.h

    27	
  > 28	const void *xe_pci_graphics_ip_gen_param(struct kunit *test, const void *prev, char *desc);
    29	const void *xe_pci_media_ip_gen_param(struct kunit *test, const void *prev, char *desc);
    30	const void *xe_pci_id_gen_param(struct kunit *test, const void *prev, char *desc);
    31	const void *xe_pci_live_device_gen_param(struct kunit *test, const void *prev, char *desc);
    32	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

