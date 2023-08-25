Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE23787FBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 08:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjHYGUZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 02:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbjHYGTz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 02:19:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72E11BF0;
        Thu, 24 Aug 2023 23:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692944393; x=1724480393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bmfd8qRTID5gBvloZQsb4+G4sktL/Sul01ezj7s1kaE=;
  b=AcLzW4a5RAGqwUl5lXjHwqbJUhFpKm+ZxUQXv9gFZ3UhP4k+QR+AAF7S
   94OvEJOTGebAfqS6HNqXSez5meTtePeeopjsCm+7EIDhuNNkpmykRO1eo
   y3NTtwqdycpuR1+yV0zDDEDWCkPCu66urcxdtuyASCBorZs69sFo8RLJl
   83XDSm0ELvuyLPhVO9CoEfhwiLBwaC1NpBzqKhwOpdBbCKG1cYeTCRoR5
   btu3CIAzHg/Kwwuy4cRLCNJDbEtnnJwYW4kkN/OvuGPiIIcsxWl3A5YKB
   D2vO1MzrRc0xymRDhiHYhAAtUA1WWpHrm3oTxRAE0XsGKLm+ab0GGxUS1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="372038773"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="372038773"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="730923769"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="730923769"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2023 23:17:44 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZQ8d-0003Gm-1E;
        Fri, 25 Aug 2023 06:17:43 +0000
Date:   Fri, 25 Aug 2023 14:17:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v5 09/10] kunit: Use string_stream for test log
Message-ID: <202308251443.dMAw1CW3-lkp@intel.com>
References: <20230824143129.1957914-10-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824143129.1957914-10-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Richard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/kunit]
[also build test WARNING on next-20230824]
[cannot apply to shuah-kselftest/kunit-fixes linus/master v6.5-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Fitzgerald/kunit-string-stream-Don-t-create-a-fragment-for-empty-strings/20230824-223722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
patch link:    https://lore.kernel.org/r/20230824143129.1957914-10-rf%40opensource.cirrus.com
patch subject: [PATCH v5 09/10] kunit: Use string_stream for test log
config: hexagon-randconfig-002-20230825 (https://download.01.org/0day-ci/archive/20230825/202308251443.dMAw1CW3-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308251443.dMAw1CW3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308251443.dMAw1CW3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/kunit/kunit-test.c:542:8: warning: unused variable 'full_log' [-Wunused-variable]
     542 |         char *full_log;
         |               ^
   lib/kunit/kunit-test.c:581:26: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
     581 |                 kunit_add_action(test, (kunit_action_t *)kfree, full_log);
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +/full_log +542 lib/kunit/kunit-test.c

   533	
   534	/*
   535	 * Log tests call string_stream functions, which aren't exported. So only
   536	 * build this code if this test is built-in.
   537	 */
   538	#if IS_BUILTIN(CONFIG_KUNIT_TEST)
   539	static void kunit_log_test(struct kunit *test)
   540	{
   541		struct kunit_suite suite;
 > 542		char *full_log;
   543	
   544		suite.log = kunit_alloc_string_stream(test, GFP_KERNEL);
   545		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
   546		string_stream_set_append_newlines(suite.log, true);
   547	
   548		kunit_log(KERN_INFO, test, "put this in log.");
   549		kunit_log(KERN_INFO, test, "this too.");
   550		kunit_log(KERN_INFO, &suite, "add to suite log.");
   551		kunit_log(KERN_INFO, &suite, "along with this.");
   552	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
