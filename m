Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F00550567
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jun 2022 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiFRODM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Jun 2022 10:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346954AbiFRN7Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Jun 2022 09:59:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896815724;
        Sat, 18 Jun 2022 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655560763; x=1687096763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KhvgxqN/MU+pbySf6/r74IVdKy4xbfE7RP+iY5t+B5U=;
  b=B9iOExdJf08mDFLNaM+bv9WGAXEMgla2TUGbq/LaNmcNc3qr/bbMh3jv
   ZC/N6bc5M+lLYPGgl/lSQZX5ZBi8GjgQLgz5f3J5JNZLQQJO6XnD45VWf
   hFoU3FwFc46j2y2qUHDi3LfIWNHzX28Rb19uK/i44IH7KQ/AqIfX12nYm
   AWQmy78erfYYLRjOM+VFJSye8DyoQ9XzrJsweaNmJc7L4j5I1pk/5zhfv
   4gW3o1RssPRlkMuirvn47DfuxV2VUYXXI7aXdP0o6kH6ugR4L+DZFFKe2
   8IqVhkX5aHjoIIGUmBf63lFJqJlylerTgc3T/TR/oX89963KRROlh0Vbt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280717413"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280717413"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 06:59:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584348783"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jun 2022 06:59:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2Yyr-000QLv-Sb;
        Sat, 18 Jun 2022 13:59:17 +0000
Date:   Sat, 18 Jun 2022 21:58:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>
Cc:     kbuild-all@lists.01.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>,
        David Gow <davidgow@google.com>
Subject: Re: [PATCH 2/5] kunit: flatten kunit_suite*** to kunit_suite** in
 .kunit_test_suites
Message-ID: <202206182117.58z5vWxq-lkp@intel.com>
References: <20220618090310.1174932-3-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618090310.1174932-3-davidgow@google.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc2 next-20220617]
[cannot apply to mcgrof/modules-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4b35035bcf80ddb47c0112c4fbd84a63a2836a18
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220618/202206182117.58z5vWxq-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c2386c54cc9fd471e5353f375ff71734214ed3c6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
        git checkout c2386c54cc9fd471e5353f375ff71734214ed3c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-review/David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653 HEAD fddb3ea0ed5627098eabc542fdba5a8b4b769066 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-of-aspeed.c: In function 'aspeed_sdc_tests_init':
>> drivers/mmc/host/sdhci-of-aspeed.c:612:16: error: too few arguments to function '__kunit_test_suites_init'
     612 |         return __kunit_test_suites_init(aspeed_sdc_test_suites);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mmc/host/sdhci-of-aspeed-test.c:4,
                    from drivers/mmc/host/sdhci-of-aspeed.c:608:
   include/kunit/test.h:240:5: note: declared here
     240 | int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-of-aspeed.c: In function 'aspeed_sdc_tests_exit':
>> drivers/mmc/host/sdhci-of-aspeed.c:617:9: error: too few arguments to function '__kunit_test_suites_exit'
     617 |         __kunit_test_suites_exit(aspeed_sdc_test_suites);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mmc/host/sdhci-of-aspeed-test.c:4,
                    from drivers/mmc/host/sdhci-of-aspeed.c:608:
   include/kunit/test.h:242:6: note: declared here
     242 | void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-of-aspeed.c: In function 'aspeed_sdc_tests_init':
   drivers/mmc/host/sdhci-of-aspeed.c:613:1: error: control reaches end of non-void function [-Werror=return-type]
     613 | }
         | ^
   cc1: some warnings being treated as errors


vim +/__kunit_test_suites_init +612 drivers/mmc/host/sdhci-of-aspeed.c

4af307f574260c Andrew Jeffery 2021-01-22  609  
4af307f574260c Andrew Jeffery 2021-01-22  610  static inline int aspeed_sdc_tests_init(void)
4af307f574260c Andrew Jeffery 2021-01-22  611  {
4af307f574260c Andrew Jeffery 2021-01-22 @612  	return __kunit_test_suites_init(aspeed_sdc_test_suites);
4af307f574260c Andrew Jeffery 2021-01-22  613  }
4af307f574260c Andrew Jeffery 2021-01-22  614  
4af307f574260c Andrew Jeffery 2021-01-22  615  static inline void aspeed_sdc_tests_exit(void)
4af307f574260c Andrew Jeffery 2021-01-22  616  {
4af307f574260c Andrew Jeffery 2021-01-22 @617  	__kunit_test_suites_exit(aspeed_sdc_test_suites);
4af307f574260c Andrew Jeffery 2021-01-22  618  }
4af307f574260c Andrew Jeffery 2021-01-22  619  #else
4af307f574260c Andrew Jeffery 2021-01-22  620  static inline int aspeed_sdc_tests_init(void)
4af307f574260c Andrew Jeffery 2021-01-22  621  {
4af307f574260c Andrew Jeffery 2021-01-22  622  	return 0;
4af307f574260c Andrew Jeffery 2021-01-22  623  }
4af307f574260c Andrew Jeffery 2021-01-22  624  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
