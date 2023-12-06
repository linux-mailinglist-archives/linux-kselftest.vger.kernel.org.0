Return-Path: <linux-kselftest+bounces-1299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F76680750B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 17:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491DA1F211F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB5B45BFB;
	Wed,  6 Dec 2023 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dctMhG+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3B0D44
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 08:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701880411; x=1733416411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=htX4iDGNzlMTy6lmTdVTpUZwaIRb7KEUVU3EoBWvnLk=;
  b=dctMhG+F/vzM6UoeWHIImpWDs79+4fm4BRHO1UC3G2Rnvd+ZGxaWSGjW
   vSWkonRYUuTKHhvDPPQzYvCX5PUE4WAXbjU9OfqYPDJsdoLps+72tHoOF
   EpRhM4BwJL8+qQTLveb5ZLO3sW5RsFHZ0IMhV+2K0FwM8KSpbpBxbAoz3
   uL01w9UCMd5gPbmbxCBdEIQD9m/VZClpy5R0DzWeYtG23LtPpDt/De+tH
   UFptTZgrRr+K1Qq1XU9XPxRmTZj7080U5o4fSoJGRpNRZzVbnczbgJAHd
   DUqTELy2VlUtt3N8GyNtXjpBfUFGhalXqiYP2eBBHC/BrkZ3pHF8uFR+h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="957925"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="957925"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 08:33:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="889404516"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="889404516"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2023 08:33:27 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAupw-000B8t-2n;
	Wed, 06 Dec 2023 16:33:24 +0000
Date: Thu, 7 Dec 2023 00:31:56 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Ripard <mripard@kernel.org>, davidgow@google.com,
	Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	David Airlie <airlied@linux.ie>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] drm/tests: Switch to kunit devices
Message-ID: <202312070011.fDjYhKoz-lkp@intel.com>
References: <20231205090405.153140-1-mripard@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205090405.153140-1-mripard@kernel.org>

Hi Maxime,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231205]
[cannot apply to drm-misc/drm-misc-next v6.7-rc4 v6.7-rc3 v6.7-rc2 linus/master v6.7-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Ripard/drm-tests-Switch-to-kunit-devices/20231205-170508
base:   next-20231205
patch link:    https://lore.kernel.org/r/20231205090405.153140-1-mripard%40kernel.org
patch subject: [PATCH] drm/tests: Switch to kunit devices
config: i386-buildonly-randconfig-004-20231206 (https://download.01.org/0day-ci/archive/20231207/202312070011.fDjYhKoz-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312070011.fDjYhKoz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312070011.fDjYhKoz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/tests/drm_kunit_helpers.c:8:10: fatal error: 'kunit/device.h' file not found
   #include <kunit/device.h>
            ^~~~~~~~~~~~~~~~
   1 error generated.


vim +8 drivers/gpu/drm/tests/drm_kunit_helpers.c

     7	
   > 8	#include <kunit/device.h>
     9	#include <kunit/resource.h>
    10	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

