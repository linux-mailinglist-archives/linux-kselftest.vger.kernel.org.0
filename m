Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9C787FB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 08:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjHYGUY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 02:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjHYGT5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 02:19:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59621BFA;
        Thu, 24 Aug 2023 23:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692944394; x=1724480394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OGBvl1cnGQrtc8HrSFXhOT1tuv7/9ybQpO0G7PVk+7o=;
  b=cpNFj/a1yssu8YNoW3jMnT9FUqWXg4g+90PU6xvhekGrciWFHTx6P3tH
   e0cetYU4BkOEFWo8d3uezi7Lbg/5rNjff7IC+1Ocb8pXcRvPmZc+lo+Ge
   YUtivzJ0dyEckxplc8c80fEJ7NS9t1LRJGv5585hldNkbng9uZPE6PeBt
   f8RDJqlm0PsnXCsh0FNO7k1M5xniulIiIwCZ5AweAVEWx6aUOZPVkZngt
   3FHTGS+9EC7GXsAIxajLMP6YwFUjHOHRgwu/ROCWxAFFGtfLqlCB9VSuB
   U0XrnwcyyTl2wajidL9SqOf+IrwYd5/7+oDvxk8kk1BL0OnbXH60XaoZN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="372038778"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="372038778"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="730923770"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="730923770"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2023 23:17:44 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZQ8d-0003Go-1L;
        Fri, 25 Aug 2023 06:17:43 +0000
Date:   Fri, 25 Aug 2023 14:17:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v5 07/10] kunit: string-stream: Decouple string_stream
 from kunit
Message-ID: <202308251401.n2nyRNLW-lkp@intel.com>
References: <20230824143129.1957914-8-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824143129.1957914-8-rf@opensource.cirrus.com>
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
[also build test WARNING on shuah-kselftest/kunit-fixes linus/master v6.5-rc7 next-20230824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Fitzgerald/kunit-string-stream-Don-t-create-a-fragment-for-empty-strings/20230824-223722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
patch link:    https://lore.kernel.org/r/20230824143129.1957914-8-rf%40opensource.cirrus.com
patch subject: [PATCH v5 07/10] kunit: string-stream: Decouple string_stream from kunit
config: hexagon-randconfig-001-20230825 (https://download.01.org/0day-ci/archive/20230825/202308251401.n2nyRNLW-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230825/202308251401.n2nyRNLW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308251401.n2nyRNLW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/kunit/string-stream-test.c:19:25: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
      19 |         kunit_add_action(test, (kunit_action_t *)kfree, (void *)str);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +19 lib/kunit/string-stream-test.c

    13	
    14	static char *get_concatenated_string(struct kunit *test, struct string_stream *stream)
    15	{
    16		char *str = string_stream_get_string(stream);
    17	
    18		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
  > 19		kunit_add_action(test, (kunit_action_t *)kfree, (void *)str);
    20	
    21		return str;
    22	}
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
