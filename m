Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C4375B620
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 20:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGTSID (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 14:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGTSIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 14:08:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9C913E;
        Thu, 20 Jul 2023 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689876481; x=1721412481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7dMx1vxlj/xh0eN5dm79YGMH5t91q+NabCzXn9iJnnM=;
  b=aRdKn2nLOjgdxfoQCFiSrh61PKkWCzO+rixnxRKrk/QLtyFVIeEDJP1I
   OkfAIhmbidC4DbjUtNQqADhTxb2mJsq0A4xIlZomyfQBIovyQxKVMYFfO
   cd1naHHA2QLLnQ6k2cehbIMS+KtsXHahTUIZav8dlEqJNCJhoBtyHzFOe
   3PPe7coVm4u+hPnXKmvfi2fxyG0h6iUM9SfPi7lizlSnhbxCYaDhGgU/Z
   ULAohsEyZoNh0stHrQ5ai7oihymRyeoGPIsvOxXriBEx6Zud/HGWKFq+c
   8N9en6yuOjygbm/qp8Ghjv/KsUpgnEumT7zK7o62OuD2cc2bwgoYQRUls
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370419700"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="370419700"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 11:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="848532395"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="848532395"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 20 Jul 2023 11:06:21 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMY2f-0006Ll-0K;
        Thu, 20 Jul 2023 18:06:21 +0000
Date:   Fri, 21 Jul 2023 02:06:15 +0800
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
Subject: Re: [PATCH v2 06/11] drm/tests: helpers: Create a helper to allocate
 an atomic state
Message-ID: <202307210124.Ur3UNuxZ-lkp@intel.com>
References: <20230720-kms-kunit-actions-rework-v2-6-175017bd56ab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720-kms-kunit-actions-rework-v2-6-175017bd56ab@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230720-kms-kunit-actions-rework-v2-6-175017bd56ab%40kernel.org
patch subject: [PATCH v2 06/11] drm/tests: helpers: Create a helper to allocate an atomic state
config: arm64-randconfig-r022-20230720 (https://download.01.org/0day-ci/archive/20230721/202307210124.Ur3UNuxZ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210124.Ur3UNuxZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307210124.Ur3UNuxZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/tests/drm_kunit_helpers.c:54:6: warning: cast from 'void (*)(struct platform_driver *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      54 |                                         (kunit_action_t *)platform_driver_unregister,
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_kunit_helpers.c:62:6: warning: cast from 'void (*)(struct platform_device *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      62 |                                         (kunit_action_t *)platform_device_put,
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_kunit_helpers.c:70:6: warning: cast from 'void (*)(struct platform_device *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      70 |                                         (kunit_action_t *)platform_device_del,
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_kunit_helpers.c:90:9: warning: cast from 'void (*)(struct platform_device *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      90 |                              (kunit_action_t *)platform_device_unregister,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_kunit_helpers.c:94:9: warning: cast from 'void (*)(struct platform_driver *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      94 |                              (kunit_action_t *)platform_driver_unregister,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/tests/drm_kunit_helpers.c:192:6: warning: cast from 'void (*)(struct drm_atomic_state *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
     192 |                                         (kunit_action_t *)drm_atomic_state_put,
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   6 warnings generated.


vim +192 drivers/gpu/drm/tests/drm_kunit_helpers.c

   164	
   165	/**
   166	 * drm_kunit_helper_atomic_state_alloc - Allocates an atomic state
   167	 * @test: The test context object
   168	 * @drm: The device to alloc the state for
   169	 * @ctx: Locking context for that atomic update
   170	 *
   171	 * Allocates a empty atomic state.
   172	 *
   173	 * The state is tied to the kunit test context, so we must not call
   174	 * drm_atomic_state_put() on it, it will be done so automatically.
   175	 *
   176	 * Returns:
   177	 * An ERR_PTR on error, a pointer to the newly allocated state otherwise
   178	 */
   179	struct drm_atomic_state *
   180	drm_kunit_helper_atomic_state_alloc(struct kunit *test,
   181					    struct drm_device *drm,
   182					    struct drm_modeset_acquire_ctx *ctx)
   183	{
   184		struct drm_atomic_state *state;
   185		int ret;
   186	
   187		state = drm_atomic_state_alloc(drm);
   188		if (!state)
   189			return ERR_PTR(-ENOMEM);
   190	
   191		ret = kunit_add_action_or_reset(test,
 > 192						(kunit_action_t *)drm_atomic_state_put,
   193						state);
   194		if (ret)
   195			return ERR_PTR(ret);
   196	
   197		state->acquire_ctx = ctx;
   198	
   199		return state;
   200	}
   201	EXPORT_SYMBOL_GPL(drm_kunit_helper_atomic_state_alloc);
   202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
