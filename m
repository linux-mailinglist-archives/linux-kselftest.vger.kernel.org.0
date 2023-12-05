Return-Path: <linux-kselftest+bounces-1138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775D0805699
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 14:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326D4281CC1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4625FF1E;
	Tue,  5 Dec 2023 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9fCmrbt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0FE122;
	Tue,  5 Dec 2023 05:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701784460; x=1733320460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AMNx/fjJGfvaJNGvGiW3daQJM+aiJW9ZD+58Y4J119c=;
  b=U9fCmrbtg24jDdxfaQ9xeZzKgQlSEvNM21T7pGztQcTR/CBGlihnU/yi
   xOnrAZbTZgkQXDfx6E+ZbP/K0e9uqIGAoH7/pwvM0Rwuo1HOAAXUJVfLs
   KwNcWmELueuBfM5ma17v3mGwAENL7YbvfnzfQlX4vIPoOBsaX4Msw3RA4
   Jxb2Y9tYNWt+oDBtT6w5yWAs0U1+6+GhVSX1yWTwRpZtRkXNASDjBBeF4
   yDkeaNUwDKX6uTB/es8xFk4rlWcMZfVUoZzhvIMMRZutkgjk4uIGpKnhW
   oFEWO07G37+2Z8VXGMSSoDRuEsIgB1Jgj6cXEytNhRzFRP09RNKrGRBFu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="7240125"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="7240125"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 05:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="805278184"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="805278184"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Dec 2023 05:54:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAVsJ-00096M-26;
	Tue, 05 Dec 2023 13:54:11 +0000
Date: Tue, 5 Dec 2023 21:53:56 +0800
From: kernel test robot <lkp@intel.com>
To: davidgow@google.com, Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-sound@vger.kernel.org, David Gow <davidgow@google.com>
Subject: Re: [PATCH 1/4] kunit: Add APIs for managing devices
Message-ID: <202312052114.VQD1viY5-lkp@intel.com>
References: <20231205-kunit_bus-v1-1-635036d3bc13@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-kunit_bus-v1-1-635036d3bc13@google.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c8613be119892ccceffbc550b9b9d7d68b995c9e]

url:    https://github.com/intel-lab-lkp/linux/commits/davidgow-google-com/kunit-Add-APIs-for-managing-devices/20231205-153349
base:   c8613be119892ccceffbc550b9b9d7d68b995c9e
patch link:    https://lore.kernel.org/r/20231205-kunit_bus-v1-1-635036d3bc13%40google.com
patch subject: [PATCH 1/4] kunit: Add APIs for managing devices
config: powerpc-randconfig-r081-20231205 (https://download.01.org/0day-ci/archive/20231205/202312052114.VQD1viY5-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312052114.VQD1viY5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312052114.VQD1viY5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/kunit/device.c:100:22: warning: no previous prototype for function '__kunit_device_register_internal' [-Wmissing-prototypes]
     100 | struct kunit_device *__kunit_device_register_internal(struct kunit *test,
         |                      ^
   lib/kunit/device.c:100:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     100 | struct kunit_device *__kunit_device_register_internal(struct kunit *test,
         | ^
         | static 
   1 warning generated.


vim +/__kunit_device_register_internal +100 lib/kunit/device.c

    99	
 > 100	struct kunit_device *__kunit_device_register_internal(struct kunit *test,
   101							      const char *name,
   102							      struct device_driver *drv)
   103	{
   104		struct kunit_device *kunit_dev;
   105		int err = -ENOMEM;
   106	
   107		kunit_dev = kzalloc(sizeof(struct kunit_device), GFP_KERNEL);
   108		if (!kunit_dev)
   109			return ERR_PTR(err);
   110	
   111		kunit_dev->owner = test;
   112	
   113		err = dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name);
   114		if (err) {
   115			kfree(kunit_dev);
   116			return ERR_PTR(err);
   117		}
   118	
   119		/* Set the expected driver pointer, so we match. */
   120		kunit_dev->driver = drv;
   121	
   122		kunit_dev->dev.release = kunit_device_release;
   123		kunit_dev->dev.bus = &kunit_bus_type;
   124		kunit_dev->dev.parent = &kunit_bus;
   125	
   126		err = device_register(&kunit_dev->dev);
   127		if (err) {
   128			put_device(&kunit_dev->dev);
   129			return ERR_PTR(err);
   130		}
   131	
   132		kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
   133	
   134		return kunit_dev;
   135	}
   136	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

