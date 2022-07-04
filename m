Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82A7565F87
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jul 2022 00:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiGDWxL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 18:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGDWxL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 18:53:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBE9B23;
        Mon,  4 Jul 2022 15:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656975190; x=1688511190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EF9dl0452LU3/NvdBZYs6VHCKpRhav142HLvgvNvh6g=;
  b=BPgBoXzP/FN2+s4Sypj6prD+jyf/sUWltHDbI/ukFZZsuX/bH8hFKAuV
   ue+g0zedrDOXgu+UifWpB3IVzJ1JDt3ROh0BDKBvposb1EO4rd3LziAPG
   EJt7dSliVmB4MSAqviXgHfVTi42Ia19wjtsoPhqQZTdRj8fPWrDO+f7tU
   yJIG+ABKMggpRkycda6yl6FNix8men4GT/9f+hQp5GIwNQxUa/q1u2tfY
   M8/PvRDUasf15IyglDoBchsTccxUGrRkCZYSc+V8dvFHKohSn+weG6Izx
   mhrwYtGWmPlS6chtuE3ljfzY4Qfwd7HWlFnL4PjtMy+eFNSLvF3IsS+PA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="266231445"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="266231445"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 15:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="769437620"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Jul 2022 15:53:03 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8UwA-000INt-SE;
        Mon, 04 Jul 2022 22:53:02 +0000
Date:   Tue, 5 Jul 2022 06:52:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     kbuild-all@lists.01.org,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        "Djakson C . G . Filho" <djakson.filho@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Anderson Fraga <aaafraga@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v4 5/9] drm: selftest: convert drm_plane_helper selftest
 to KUnit
Message-ID: <202207050658.cIRAae6i-lkp@intel.com>
References: <20220702131116.457444-6-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220702131116.457444-6-maira.canal@usp.br>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi "Maíra,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next drm-tip/drm-tip next-20220704]
[cannot apply to drm-intel/for-linux-next linus/master v5.19-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-ra-Canal/drm-selftest-Convert-to-KUnit/20220702-211445
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: csky-randconfig-s031-20220703 (https://download.01.org/0day-ci/archive/20220705/202207050658.cIRAae6i-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a5699b8df7e7e995c42cf6ab89badac0e2156b85
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ma-ra-Canal/drm-selftest-Convert-to-KUnit/20220702-211445
        git checkout a5699b8df7e7e995c42cf6ab89badac0e2156b85
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/gpu/drm/tests/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/tests/drm_plane_helper_test.c:112:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tests/drm_plane_helper_test.c:123:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tests/drm_plane_helper_test.c:143:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tests/drm_plane_helper_test.c:160:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tests/drm_plane_helper_test.c:173:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tests/drm_plane_helper_test.c:185:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tests/drm_plane_helper_test.c:196:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tests/drm_plane_helper_test.c:207:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/tests/drm_plane_helper_test.c:219:9: sparse: sparse: Using plain integer as NULL pointer

vim +112 drivers/gpu/drm/tests/drm_plane_helper_test.c

    76	
    77	static void igt_check_plane_state(struct kunit *test)
    78	{
    79		int ret;
    80	
    81		static const struct drm_crtc_state crtc_state = {
    82			.crtc = ZERO_SIZE_PTR,
    83			.enable = true,
    84			.active = true,
    85			.mode = {
    86				DRM_MODE("1024x768", 0, 65000, 1024, 1048,
    87					1184, 1344, 0, 768, 771, 777, 806, 0,
    88					DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC)
    89			},
    90		};
    91		static struct drm_plane plane = {
    92			.dev = NULL
    93		};
    94		static struct drm_framebuffer fb = {
    95			.width = 2048,
    96			.height = 2048
    97		};
    98		static struct drm_plane_state plane_state = {
    99			.plane = &plane,
   100			.crtc = ZERO_SIZE_PTR,
   101			.fb = &fb,
   102			.rotation = DRM_MODE_ROTATE_0
   103		};
   104	
   105		/* Simple clipping, no scaling. */
   106		set_src(&plane_state, 0, 0, fb.width << 16, fb.height << 16);
   107		set_crtc(&plane_state, 0, 0, fb.width, fb.height);
   108		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   109							  DRM_PLANE_HELPER_NO_SCALING,
   110							  DRM_PLANE_HELPER_NO_SCALING,
   111							  false, false);
 > 112		KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Simple clipping check should pass\n");
   113		KUNIT_EXPECT_TRUE(test, plane_state.visible);
   114		KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 1024 << 16, 768 << 16));
   115		KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
   116	
   117		/* Rotated clipping + reflection, no scaling. */
   118		plane_state.rotation = DRM_MODE_ROTATE_90 | DRM_MODE_REFLECT_X;
   119		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   120							  DRM_PLANE_HELPER_NO_SCALING,
   121							  DRM_PLANE_HELPER_NO_SCALING,
   122							  false, false);
   123		KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Rotated clipping check should pass\n");
   124		KUNIT_EXPECT_TRUE(test, plane_state.visible);
   125		KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 768 << 16, 1024 << 16));
   126		KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
   127		plane_state.rotation = DRM_MODE_ROTATE_0;
   128	
   129		/* Check whether positioning works correctly. */
   130		set_src(&plane_state, 0, 0, 1023 << 16, 767 << 16);
   131		set_crtc(&plane_state, 0, 0, 1023, 767);
   132		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   133							  DRM_PLANE_HELPER_NO_SCALING,
   134							  DRM_PLANE_HELPER_NO_SCALING,
   135							  false, false);
   136		KUNIT_EXPECT_TRUE_MSG(test, ret,
   137				"Should not be able to position on the crtc with can_position=false\n");
   138	
   139		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   140							  DRM_PLANE_HELPER_NO_SCALING,
   141							  DRM_PLANE_HELPER_NO_SCALING,
   142							  true, false);
   143		KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Simple positioning should work\n");
   144		KUNIT_EXPECT_TRUE(test, plane_state.visible);
   145		KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 1023 << 16, 767 << 16));
   146		KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1023, 767));
   147	
   148		/* Simple scaling tests. */
   149		set_src(&plane_state, 0, 0, 512 << 16, 384 << 16);
   150		set_crtc(&plane_state, 0, 0, 1024, 768);
   151		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   152							  0x8001,
   153							  DRM_PLANE_HELPER_NO_SCALING,
   154							  false, false);
   155		KUNIT_EXPECT_TRUE_MSG(test, ret, "Upscaling out of range should fail.\n");
   156		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   157							  0x8000,
   158							  DRM_PLANE_HELPER_NO_SCALING,
   159							  false, false);
   160		KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Upscaling exactly 2x should work\n");
   161		KUNIT_EXPECT_TRUE(test, plane_state.visible);
   162		KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 512 << 16, 384 << 16));
   163		KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
   164	
   165		set_src(&plane_state, 0, 0, 2048 << 16, 1536 << 16);
   166		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   167							  DRM_PLANE_HELPER_NO_SCALING,
   168							  0x1ffff, false, false);
   169		KUNIT_EXPECT_TRUE_MSG(test, ret, "Downscaling out of range should fail.\n");
   170		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   171							  DRM_PLANE_HELPER_NO_SCALING,
   172							  0x20000, false, false);
   173		KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed with exact scaling limit\n");
   174		KUNIT_EXPECT_TRUE(test, plane_state.visible);
   175		KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 2048 << 16, 1536 << 16));
   176		KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
   177	
   178		/* Testing rounding errors. */
   179		set_src(&plane_state, 0, 0, 0x40001, 0x40001);
   180		set_crtc(&plane_state, 1022, 766, 4, 4);
   181		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   182							  DRM_PLANE_HELPER_NO_SCALING,
   183							  0x10001,
   184							  true, false);
   185		KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed by clipping to exact multiple");
   186		KUNIT_EXPECT_TRUE(test, plane_state.visible);
   187		KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 2 << 16, 2 << 16));
   188		KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 1022, 766, 2, 2));
   189	
   190		set_src(&plane_state, 0x20001, 0x20001, 0x4040001, 0x3040001);
   191		set_crtc(&plane_state, -2, -2, 1028, 772);
   192		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   193							  DRM_PLANE_HELPER_NO_SCALING,
   194							  0x10001,
   195							  false, false);
   196		KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed by clipping to exact multiple");
   197		KUNIT_EXPECT_TRUE(test, plane_state.visible);
   198		KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0x40002, 0x40002, 1024 << 16, 768 << 16));
   199		KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
   200	
   201		set_src(&plane_state, 0, 0, 0x3ffff, 0x3ffff);
   202		set_crtc(&plane_state, 1022, 766, 4, 4);
   203		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   204							  0xffff,
   205							  DRM_PLANE_HELPER_NO_SCALING,
   206							  true, false);
   207		KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed by clipping to exact multiple");
   208		KUNIT_EXPECT_TRUE(test, plane_state.visible);
   209		/* Should not be rounded to 0x20001, which would be upscaling. */
   210		KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0, 0, 2 << 16, 2 << 16));
   211		KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 1022, 766, 2, 2));
   212	
   213		set_src(&plane_state, 0x1ffff, 0x1ffff, 0x403ffff, 0x303ffff);
   214		set_crtc(&plane_state, -2, -2, 1028, 772);
   215		ret = drm_atomic_helper_check_plane_state(&plane_state, &crtc_state,
   216							  0xffff,
   217							  DRM_PLANE_HELPER_NO_SCALING,
   218							  false, false);
   219		KUNIT_EXPECT_FALSE_MSG(test, ret, 0, "Should succeed by clipping to exact multiple");
   220		KUNIT_EXPECT_TRUE(test, plane_state.visible);
   221		KUNIT_EXPECT_TRUE(test, check_src_eq(&plane_state, 0x3fffe, 0x3fffe,
   222					1024 << 16, 768 << 16));
   223		KUNIT_EXPECT_TRUE(test, check_crtc_eq(&plane_state, 0, 0, 1024, 768));
   224	}
   225	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
