Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12CE7208C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbjFBSEV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 14:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbjFBSEU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 14:04:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806FE9F;
        Fri,  2 Jun 2023 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685729059; x=1717265059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OpH8w4h7rmgb2ilFDwpfKAz8g4S9v2qEEChc3Sm9WFw=;
  b=AtUM+YcRPLFVda61BbZ+pZEuLRaVp2PMBNF+dY08ndn60oXB1ZAGVGim
   G+IZVzPrI/AijFgXXfq0hxAS3ApcF5b7wrn5X0dNSAplInJCeYteP0E+7
   PJjXwtmBsMZBpSbN9+r1qOnL2YQdp7Vb0pEBA69jJfXPi9j4xDGtXqPmA
   pV011xGWvHXJ+DNKdNM/qX+mpMChO9qoO47HN1qan6/KGr2/MspE0Kejf
   39POLnKKnFitubxBVt0GEHck+zoHSXF4V7gTnF+snE7HpSciQs5/uV6Kh
   KAWt2uM5GNPM3Oi5Hj4ohthUVUxh/SG14DANQKg2y9RC2GJJ5UG1PtIdd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="340558524"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="340558524"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 11:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="737625339"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="737625339"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2023 11:03:53 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q597w-0000oD-0m;
        Fri, 02 Jun 2023 18:03:52 +0000
Date:   Sat, 3 Jun 2023 02:02:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH RESEND 1/2] drivers: base: Add basic devm tests for root
 devices
Message-ID: <202306030141.WvTexQJf-lkp@intel.com>
References: <20230329-kunit-devm-inconsistencies-test-v1-1-015b1574d673@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329-kunit-devm-inconsistencies-test-v1-1-015b1574d673@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a6faf7ea9fcb7267d06116d4188947f26e00e57e]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Ripard/drivers-base-Add-basic-devm-tests-for-root-devices/20230602-232247
base:   a6faf7ea9fcb7267d06116d4188947f26e00e57e
patch link:    https://lore.kernel.org/r/20230329-kunit-devm-inconsistencies-test-v1-1-015b1574d673%40kernel.org
patch subject: [PATCH RESEND 1/2] drivers: base: Add basic devm tests for root devices
config: m68k-randconfig-r013-20230601 (https://download.01.org/0day-ci/archive/20230603/202306030141.WvTexQJf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f685d9ffe8ed7605cf0edbfb05a7e65611216b21
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maxime-Ripard/drivers-base-Add-basic-devm-tests-for-root-devices/20230602-232247
        git checkout f685d9ffe8ed7605cf0edbfb05a7e65611216b21
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306030141.WvTexQJf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/test/.kunitconfig: warning: ignored by one of the .gitignore files
   drivers/clk/.kunitconfig: warning: ignored by one of the .gitignore files
   drivers/gpu/drm/tests/.kunitconfig: warning: ignored by one of the .gitignore files
   drivers/gpu/drm/vc4/tests/.kunitconfig: warning: ignored by one of the .gitignore files
   drivers/hid/.kunitconfig: warning: ignored by one of the .gitignore files
   fs/ext4/.kunitconfig: warning: ignored by one of the .gitignore files
   fs/fat/.kunitconfig: warning: ignored by one of the .gitignore files
   kernel/kcsan/.kunitconfig: warning: ignored by one of the .gitignore files
   lib/kunit/.kunitconfig: warning: ignored by one of the .gitignore files
   mm/kfence/.kunitconfig: warning: ignored by one of the .gitignore files
   net/sunrpc/.kunitconfig: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
