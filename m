Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864AD75B553
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 19:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGTRPi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 13:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjGTRPh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 13:15:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E84B3;
        Thu, 20 Jul 2023 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689873334; x=1721409334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ajwiDjEM37bJTrbE3/73m8Y1Bz0d/plYeHBMuGcnQlQ=;
  b=d28e0eJFv2m6nYUAwrkxafUzoaA2suayn+KUyDHNWFbBa8uIsxmxOiCU
   kmQ6sIsus2yEzePtoimeR7pGi+QGjdw/MNh343/ZIJkTbwZSCuPcD65Va
   XhJcP+OiiV+piIcQk2PCLYBW48o66H3m+BKl9pjAjBsLV8bCktnqNHwRE
   1him/MQrE3waM+U7RmQmpA5UG5rp7JW4QlXoEzdMFQXksVFeqAcZCKz52
   2j09QDKwYPBCuLH4y6YXC6vKo9eSP7ucGPCrYcn6SRX+awPybwltquqZL
   NaZEnf4HWdzEAS8Q77TBhzgMbwzndcGQb/eH+PltWcodt++LEvd8m1oU3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346401618"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="346401618"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 10:15:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="727776415"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="727776415"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2023 10:15:29 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMXFM-0006JP-16;
        Thu, 20 Jul 2023 17:15:25 +0000
Date:   Fri, 21 Jul 2023 01:14:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 01/11] drm/tests: helpers: Switch to kunit actions
Message-ID: <202307210148.7gWzLOtn-lkp@intel.com>
References: <20230720-kms-kunit-actions-rework-v2-1-175017bd56ab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720-kms-kunit-actions-rework-v2-1-175017bd56ab@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c58c49dd89324b18a812762a2bfa5a0458e4f252]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Ripard/drm-tests-helpers-Switch-to-kunit-actions/20230720-191901
base:   c58c49dd89324b18a812762a2bfa5a0458e4f252
patch link:    https://lore.kernel.org/r/20230720-kms-kunit-actions-rework-v2-1-175017bd56ab%40kernel.org
patch subject: [PATCH v2 01/11] drm/tests: helpers: Switch to kunit actions
config: arm64-randconfig-r022-20230720 (https://download.01.org/0day-ci/archive/20230721/202307210148.7gWzLOtn-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210148.7gWzLOtn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307210148.7gWzLOtn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/tests/drm_kunit_helpers.c:53:6: warning: cast from 'void (*)(struct platform_driver *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      53 |                                         (kunit_action_t *)platform_driver_unregister,
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tests/drm_kunit_helpers.c:61:6: warning: cast from 'void (*)(struct platform_device *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      61 |                                         (kunit_action_t *)platform_device_put,
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_kunit_helpers.c:69:6: warning: cast from 'void (*)(struct platform_device *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      69 |                                         (kunit_action_t *)platform_device_del,
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_kunit_helpers.c:89:9: warning: cast from 'void (*)(struct platform_device *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      89 |                              (kunit_action_t *)platform_device_unregister,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_kunit_helpers.c:93:9: warning: cast from 'void (*)(struct platform_driver *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      93 |                              (kunit_action_t *)platform_driver_unregister,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   5 warnings generated.


vim +53 drivers/gpu/drm/tests/drm_kunit_helpers.c

    28	
    29	/**
    30	 * drm_kunit_helper_alloc_device - Allocate a mock device for a KUnit test
    31	 * @test: The test context object
    32	 *
    33	 * This allocates a fake struct &device to create a mock for a KUnit
    34	 * test. The device will also be bound to a fake driver. It will thus be
    35	 * able to leverage the usual infrastructure and most notably the
    36	 * device-managed resources just like a "real" device.
    37	 *
    38	 * Resources will be cleaned up automatically, but the removal can be
    39	 * forced using @drm_kunit_helper_free_device.
    40	 *
    41	 * Returns:
    42	 * A pointer to the new device, or an ERR_PTR() otherwise.
    43	 */
    44	struct device *drm_kunit_helper_alloc_device(struct kunit *test)
    45	{
    46		struct platform_device *pdev;
    47		int ret;
    48	
    49		ret = platform_driver_register(&fake_platform_driver);
    50		KUNIT_ASSERT_EQ(test, ret, 0);
    51	
    52		ret = kunit_add_action_or_reset(test,
  > 53						(kunit_action_t *)platform_driver_unregister,
    54						&fake_platform_driver);
    55		KUNIT_ASSERT_EQ(test, ret, 0);
    56	
    57		pdev = platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_NONE);
    58		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
    59	
    60		ret = kunit_add_action_or_reset(test,
  > 61						(kunit_action_t *)platform_device_put,
    62						pdev);
    63		KUNIT_ASSERT_EQ(test, ret, 0);
    64	
    65		ret = platform_device_add(pdev);
    66		KUNIT_ASSERT_EQ(test, ret, 0);
    67	
    68		ret = kunit_add_action_or_reset(test,
    69						(kunit_action_t *)platform_device_del,
    70						pdev);
    71		KUNIT_ASSERT_EQ(test, ret, 0);
    72	
    73		return &pdev->dev;
    74	}
    75	EXPORT_SYMBOL_GPL(drm_kunit_helper_alloc_device);
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
