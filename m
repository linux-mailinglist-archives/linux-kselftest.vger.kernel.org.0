Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B686EA446
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDUHHO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 03:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDUHHN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 03:07:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430C911A;
        Fri, 21 Apr 2023 00:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682060831; x=1713596831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OZUQs/csUJg3zppeTrY4QrFxyRUcxl5Pm/V/42YW00U=;
  b=CPyYDO9ok3VLVPXzRPMIVIuUvmtW/62f2T61czH5qFDFkvEQhPOE2oai
   bVhNScY/4sGNtqv4TzJ947Q5LthhrULAkn1ahPEEvOGojCM/RJR7viSjn
   pdSVfAivURJokVh+S2GOjYLe6r+MdhdtCEuENeVb/umwSN0MQgfHy2DDq
   5UgpkgxP+Z6UsWpdXjkyqyijNmXa+c7efpiPhv9Pw4K4JYwC9YY9Er+WV
   ctZhLoidV1J7igdkWx2Vo4q80mTZ1C1MKum8QAtnBP0U0ND3SwVIUewRD
   sYr8EbxLV+TmzEzE6O4KDQZAYsCpLCU+oZx4kls2ZhRGR48HplXiuNxeO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="373855789"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="373855789"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 00:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="1021828552"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="1021828552"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2023 00:07:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppkrK-000gPQ-01;
        Fri, 21 Apr 2023 07:07:06 +0000
Date:   Fri, 21 Apr 2023 15:06:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Gow <davidgow@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, David Gow <davidgow@google.com>,
        maxime@cerno.tech, Stephen Boyd <sboyd@kernel.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sadiya Kazi <sadiyakazi@google.com>
Subject: Re: [PATCH v3 1/4] kunit: Always run cleanup from a test kthread
Message-ID: <202304211445.r8UQGW3F-lkp@intel.com>
References: <20230421040218.2156548-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421040218.2156548-1-davidgow@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc7 next-20230420]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Gow/Documentation-kunit-Note-that-assertions-should-not-be-used-in-cleanup/20230421-120437
patch link:    https://lore.kernel.org/r/20230421040218.2156548-1-davidgow%40google.com
patch subject: [PATCH v3 1/4] kunit: Always run cleanup from a test kthread
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230421/202304211445.r8UQGW3F-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e6f2b343739c4656e2090449ad7eac10db57dde9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Gow/Documentation-kunit-Note-that-assertions-should-not-be-used-in-cleanup/20230421-120437
        git checkout e6f2b343739c4656e2090449ad7eac10db57dde9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash lib/kunit/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304211445.r8UQGW3F-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/kunit/test.c: In function 'kunit_catch_run_case':
>> lib/kunit/test.c:440:29: warning: unused variable 'suite' [-Wunused-variable]
     440 |         struct kunit_suite *suite = ctx->suite;
         |                             ^~~~~


vim +/suite +440 lib/kunit/test.c

e6f2b343739c46 David Gow       2023-04-21  434  
e6f2b343739c46 David Gow       2023-04-21  435  
5f3e06208920ee Brendan Higgins 2019-09-23  436  static void kunit_catch_run_case(void *data)
5f3e06208920ee Brendan Higgins 2019-09-23  437  {
5f3e06208920ee Brendan Higgins 2019-09-23  438  	struct kunit_try_catch_context *ctx = data;
5f3e06208920ee Brendan Higgins 2019-09-23  439  	struct kunit *test = ctx->test;
5f3e06208920ee Brendan Higgins 2019-09-23 @440  	struct kunit_suite *suite = ctx->suite;
5f3e06208920ee Brendan Higgins 2019-09-23  441  	int try_exit_code = kunit_try_catch_get_result(&test->try_catch);
5f3e06208920ee Brendan Higgins 2019-09-23  442  
5f3e06208920ee Brendan Higgins 2019-09-23  443  	if (try_exit_code) {
5f3e06208920ee Brendan Higgins 2019-09-23  444  		kunit_set_failure(test);
5f3e06208920ee Brendan Higgins 2019-09-23  445  		/*
5f3e06208920ee Brendan Higgins 2019-09-23  446  		 * Test case could not finish, we have no idea what state it is
5f3e06208920ee Brendan Higgins 2019-09-23  447  		 * in, so don't do clean up.
5f3e06208920ee Brendan Higgins 2019-09-23  448  		 */
5f3e06208920ee Brendan Higgins 2019-09-23  449  		if (try_exit_code == -ETIMEDOUT) {
5f3e06208920ee Brendan Higgins 2019-09-23  450  			kunit_err(test, "test case timed out\n");
5f3e06208920ee Brendan Higgins 2019-09-23  451  		/*
5f3e06208920ee Brendan Higgins 2019-09-23  452  		 * Unknown internal error occurred preventing test case from
5f3e06208920ee Brendan Higgins 2019-09-23  453  		 * running, so there is nothing to clean up.
5f3e06208920ee Brendan Higgins 2019-09-23  454  		 */
5f3e06208920ee Brendan Higgins 2019-09-23  455  		} else {
5f3e06208920ee Brendan Higgins 2019-09-23  456  			kunit_err(test, "internal error occurred preventing test case from running: %d\n",
5f3e06208920ee Brendan Higgins 2019-09-23  457  				  try_exit_code);
5f3e06208920ee Brendan Higgins 2019-09-23  458  		}
5f3e06208920ee Brendan Higgins 2019-09-23  459  		return;
5f3e06208920ee Brendan Higgins 2019-09-23  460  	}
5f3e06208920ee Brendan Higgins 2019-09-23  461  }
5f3e06208920ee Brendan Higgins 2019-09-23  462  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
