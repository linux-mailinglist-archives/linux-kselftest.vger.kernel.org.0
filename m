Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B47A07D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbjINOtH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbjINOsv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 10:48:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA226A5
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694702923; x=1726238923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PYbv1CeDR70yYZFWuHi3j2UJXWlRgHS7ah+9vINpQfo=;
  b=SfA7ZWbp6Zj8cZNf6+It4th18R5HTPLdPvm/EoQPFsrL3IyhwDu+u+o2
   EQiIpiCXoUFaFi93W/h3HZoYdatINSHRUWF1ZgP0Yonh64h2NS2DZUQVC
   pKe+s1NdFBGXrIQ31xELVcFsdltcnhTFrTc7JtARndnTYIhPW9iWgee+t
   K44UDBoXIbtYgNuwo/XD5tWktWegRM9MY7J8iBMYbv5972dkeHx3dHstX
   GOOd1fGqSIi/EbHr861+YyaySfQzfJc7qwXgCvzhRZhZh/RK4rXFMPFUA
   1vOAVpEQJtHQZ1CbAdm1A6Nd0ktnq9tkjwpPQ/FuoRaCXrTUU2x32AJIL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443019729"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="443019729"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 07:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="991414624"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="991414624"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2023 07:45:10 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgnae-0001hh-2x;
        Thu, 14 Sep 2023 14:45:08 +0000
Date:   Thu, 14 Sep 2023 22:44:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>, brendan.higgins@linux.dev,
        davidgow@google.com, skhan@linuxfoundation.org,
        dlatypov@google.com, rmoar@google.com,
        janusz.krzysztofik@linux.intel.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     oe-kbuild-all@lists.linux.dev, ruanjinjie@huawei.com
Subject: Re: [PATCH 4/4] kunit: test: Fix the possible memory leak in
 executor_test
Message-ID: <202309142251.uJ8saAZv-lkp@intel.com>
References: <20230914114629.1517650-5-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914114629.1517650-5-ruanjinjie@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jinjie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20230914]
[cannot apply to v6.6-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinjie-Ruan/kunit-Fix-missed-memory-release-in-kunit_free_suite_set/20230914-194915
base:   linus/master
patch link:    https://lore.kernel.org/r/20230914114629.1517650-5-ruanjinjie%40huawei.com
patch subject: [PATCH 4/4] kunit: test: Fix the possible memory leak in executor_test
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230914/202309142251.uJ8saAZv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309142251.uJ8saAZv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309142251.uJ8saAZv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from lib/kunit/executor.c:353:
>> lib/kunit/executor_test.c:274:13: warning: 'kfree_at_end' defined but not used [-Wunused-function]
     274 | static void kfree_at_end(struct kunit *test, const void *to_free)
         |             ^~~~~~~~~~~~


vim +/kfree_at_end +274 lib/kunit/executor_test.c

1d71307a6f94df Daniel Latypov 2021-04-20  270  
1d71307a6f94df Daniel Latypov 2021-04-20  271  /* Use the resource API to register a call to kfree(to_free).
1d71307a6f94df Daniel Latypov 2021-04-20  272   * Since we never actually use the resource, it's safe to use on const data.
1d71307a6f94df Daniel Latypov 2021-04-20  273   */
1d71307a6f94df Daniel Latypov 2021-04-20 @274  static void kfree_at_end(struct kunit *test, const void *to_free)
1d71307a6f94df Daniel Latypov 2021-04-20  275  {
1d71307a6f94df Daniel Latypov 2021-04-20  276  	/* kfree() handles NULL already, but avoid allocating a no-op cleanup. */
1d71307a6f94df Daniel Latypov 2021-04-20  277  	if (IS_ERR_OR_NULL(to_free))
1d71307a6f94df Daniel Latypov 2021-04-20  278  		return;
00e63f8afcfc6b David Gow      2023-05-25  279  
00e63f8afcfc6b David Gow      2023-05-25  280  	kunit_add_action(test,
00e63f8afcfc6b David Gow      2023-05-25  281  			(kunit_action_t *)kfree,
1d71307a6f94df Daniel Latypov 2021-04-20  282  			(void *)to_free);
1d71307a6f94df Daniel Latypov 2021-04-20  283  }
1d71307a6f94df Daniel Latypov 2021-04-20  284  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
