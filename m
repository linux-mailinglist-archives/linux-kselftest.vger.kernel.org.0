Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21767CE9E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 23:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjJRVT7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 17:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJRVT6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 17:19:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1E79B;
        Wed, 18 Oct 2023 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697663997; x=1729199997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIu9z+tFwfzAtcAyz0GEBJOPGiC9oJKOaIE8fTDqMVE=;
  b=b9xA82EqKOXvy8OmG1j8PperUGbNkURCwc5VCt4Rgy2OxvBylFeG5XLo
   b+7ciyi3n8KaT5R6Q9GKxsoxfKNIa5QlTYJtRDv5r6cw9ooaFwyTpdKIa
   rLeMv0c882yLS2adydOmvG+C81WfUn5bZ4o5gNje/qUXKYBIkT8YcvTbE
   /wDu6z42y94wi3GeD3hSavrLwEBvCxbYkHbBwzAuibEtiILoXR4rp5ghK
   nxB167ZeBjK8/lVHLMrmvpNkTSi8jcqrY52ptpBrAaQKONjTunfFdYtF6
   UGc3RJRu7IvZvkVXJNvSTn09OpuuXowSx9/WZSD/oom6pAL9+IK8YLZV1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7665636"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="7665636"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 14:15:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="827072602"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="827072602"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Oct 2023 14:15:25 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtDsx-00014C-1U;
        Wed, 18 Oct 2023 21:15:23 +0000
Date:   Thu, 19 Oct 2023 05:14:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Pagani <marpagan@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, Marco Pagani <marpagan@redhat.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: run test suites only after module initialization
 completes
Message-ID: <202310190514.uKp3bS5Q-lkp@intel.com>
References: <20231016203548.21993-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016203548.21993-1-marpagan@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Marco,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc6 next-20231018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Pagani/kunit-run-test-suites-only-after-module-initialization-completes/20231017-161611
base:   linus/master
patch link:    https://lore.kernel.org/r/20231016203548.21993-1-marpagan%40redhat.com
patch subject: [PATCH] kunit: run test suites only after module initialization completes
config: arm-randconfig-004-20231019 (https://download.01.org/0day-ci/archive/20231019/202310190514.uKp3bS5Q-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190514.uKp3bS5Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310190514.uKp3bS5Q-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/include/asm/page.h:188,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/kref.h:16,
                    from include/kunit/test.h:22,
                    from include/kunit/resource.h:12,
                    from lib/kunit/test.c:9:
   lib/kunit/test.c: In function 'kunit_module_exit':
>> arch/arm/include/asm/memory.h:391:116: error: 'high_memory' undeclared (first use in this function)
     391 | #define virt_addr_valid(kaddr)  (((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory) \
         |                                                                                                                    ^~~~~~~~~~~
   lib/kunit/test.c:772:34: note: in expansion of macro 'virt_addr_valid'
     772 |         if (!suite_set.start || !virt_addr_valid(suite_set.start))
         |                                  ^~~~~~~~~~~~~~~
   arch/arm/include/asm/memory.h:391:116: note: each undeclared identifier is reported only once for each function it appears in
     391 | #define virt_addr_valid(kaddr)  (((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory) \
         |                                                                                                                    ^~~~~~~~~~~
   lib/kunit/test.c:772:34: note: in expansion of macro 'virt_addr_valid'
     772 |         if (!suite_set.start || !virt_addr_valid(suite_set.start))
         |                                  ^~~~~~~~~~~~~~~


vim +/high_memory +391 arch/arm/include/asm/memory.h

05944d74bc28ff include/asm-arm/memory.h      Russell King   2006-11-30  389  
e26a9e00afc482 arch/arm/include/asm/memory.h Russell King   2014-03-25  390  #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
efea3403d4b7c6 arch/arm/include/asm/memory.h Laura Abbott   2013-12-21 @391  #define virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory) \
e26a9e00afc482 arch/arm/include/asm/memory.h Russell King   2014-03-25  392  					&& pfn_valid(virt_to_pfn(kaddr)))
^1da177e4c3f41 include/asm-arm/memory.h      Linus Torvalds 2005-04-16  393  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
