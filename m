Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDDF550591
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jun 2022 16:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiFROtf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Jun 2022 10:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFROte (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Jun 2022 10:49:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900D17AA5;
        Sat, 18 Jun 2022 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655563774; x=1687099774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w5tzZ7RrqHkJr3FpjfrwlqfOP6Ec32jd0b8PId2bAqg=;
  b=fsbrNLt0H+zjiBlcIhoypCJQYu2Pt1QEdgXVxDk11ZihhHWxwAQZSFig
   BSfgRdMHhuE2kAZJT37KRHNY21C9Rej0bG6gMEqr/aY0Q3MUj5d2At8ae
   naIuAf9so67I5paw2h75iq1F0etN35jqiYm2XpS0sH5uRzLTsdFsW1nDD
   qiRZ62RzxKBH1q/ZvyZgvt9CgbfGgUMykxpvaLz5CR45Lz3iRZQ/WZl+R
   wuytPK94fnDuVMzXM0QU/cvdqVk885AVmcIEm9gPep4NRocpHCbsT6dQ7
   Mj/cFESYpL4pvIp2Y1aumXcRHTqAIccuU8YnxfFLe7nfuOMwXlYCwSHWD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365985672"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365985672"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 07:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="688737041"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2022 07:49:20 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2ZlG-000QNA-KA;
        Sat, 18 Jun 2022 14:49:18 +0000
Date:   Sat, 18 Jun 2022 22:49:16 +0800
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
Message-ID: <202206182258.EahbTrAv-lkp@intel.com>
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
[cannot apply to mcgrof/modules-next joel-aspeed/for-next ulf-hansson-mmc-mirror/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4b35035bcf80ddb47c0112c4fbd84a63a2836a18
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220618/202206182258.EahbTrAv-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c2386c54cc9fd471e5353f375ff71734214ed3c6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653
        git checkout c2386c54cc9fd471e5353f375ff71734214ed3c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-review/David-Gow/Rework-KUnit-test-execution-in-modules/20220618-170653 HEAD fddb3ea0ed5627098eabc542fdba5a8b4b769066 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/thunderbolt/test.c: In function 'tb_test_init':
>> drivers/thunderbolt/test.c:2824:16: error: too few arguments to function '__kunit_test_suites_init'
    2824 |         return __kunit_test_suites_init(tb_test_suites);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/thunderbolt/test.c:9:
   include/kunit/test.h:240:5: note: declared here
     240 | int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thunderbolt/test.c: In function 'tb_test_exit':
>> drivers/thunderbolt/test.c:2829:16: error: too few arguments to function '__kunit_test_suites_exit'
    2829 |         return __kunit_test_suites_exit(tb_test_suites);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/thunderbolt/test.c:9:
   include/kunit/test.h:242:6: note: declared here
     242 | void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thunderbolt/test.c:2829:16: error: 'return' with a value, in function returning void [-Werror=return-type]
    2829 |         return __kunit_test_suites_exit(tb_test_suites);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thunderbolt/test.c:2827:6: note: declared here
    2827 | void tb_test_exit(void)
         |      ^~~~~~~~~~~~
   drivers/thunderbolt/test.c: In function 'tb_test_init':
   drivers/thunderbolt/test.c:2825:1: error: control reaches end of non-void function [-Werror=return-type]
    2825 | }
         | ^
   cc1: some warnings being treated as errors


vim +/__kunit_test_suites_init +2824 drivers/thunderbolt/test.c

2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2821  
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2822  int tb_test_init(void)
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2823  {
2c6ea4e2cefe2e Mika Westerberg 2020-08-24 @2824  	return __kunit_test_suites_init(tb_test_suites);
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2825  }
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2826  
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2827  void tb_test_exit(void)
2c6ea4e2cefe2e Mika Westerberg 2020-08-24  2828  {
2c6ea4e2cefe2e Mika Westerberg 2020-08-24 @2829  	return __kunit_test_suites_exit(tb_test_suites);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
