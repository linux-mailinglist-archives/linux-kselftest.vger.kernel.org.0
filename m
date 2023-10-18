Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6EB7CD533
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjJRHH1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjJRHH1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 03:07:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF2B6;
        Wed, 18 Oct 2023 00:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697612845; x=1729148845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ewKdnUXiJmyWfBcgIVxSzjv6q3oMQteZNTKn7FQdho8=;
  b=A7SiKa5guyFVj2L4yRuX4tea9aFTszskHqt11fju55pPr3SU90qiqhcf
   plGQGawnWegGSxtI7sfIOHVUEuI4AWazVQgNEhjVn3Kzer8/n932iGtgX
   t7/SY57NLqvRsfzoUy46aD9xbVWEolm9e/iV+cVv/18B1ngB3q1Q5thnN
   z7JsR5Pf8ptkhZCVHpcvMJnEV44Wet2F8DZkV6JO0Go7iEYq5cFT7eZE8
   EJkJsYO4qjFn3OtsLDM7JhnRxekr7uzakMMjySmK0M79epm76nFXriyaz
   A1ufECIFiqH6DelTYedq7iJhb/CJxK8s6hCNTDeoJ5ghB6OZNOn9OYHV2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384835616"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="384835616"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="706317395"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="706317395"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Oct 2023 00:07:21 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt0eF-00002s-1Y;
        Wed, 18 Oct 2023 07:07:19 +0000
Date:   Wed, 18 Oct 2023 15:06:37 +0800
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
Message-ID: <202310181220.us7Bvp16-lkp@intel.com>
References: <20231016203548.21993-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016203548.21993-1-marpagan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Marco,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc6 next-20231017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Pagani/kunit-run-test-suites-only-after-module-initialization-completes/20231017-161611
base:   linus/master
patch link:    https://lore.kernel.org/r/20231016203548.21993-1-marpagan%40redhat.com
patch subject: [PATCH] kunit: run test suites only after module initialization completes
config: csky-randconfig-002-20231018 (https://download.01.org/0day-ci/archive/20231018/202310181220.us7Bvp16-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181220.us7Bvp16-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181220.us7Bvp16-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/csky/include/asm/thread_info.h:9,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/kref.h:16,
                    from include/kunit/test.h:22,
                    from include/kunit/resource.h:12,
                    from lib/kunit/test.c:9:
   lib/kunit/test.c: In function 'kunit_module_exit':
>> arch/csky/include/asm/page.h:38:43: error: 'high_memory' undeclared (first use in this function)
      38 |                         (void *)(kaddr) < high_memory)
         |                                           ^~~~~~~~~~~
   lib/kunit/test.c:772:34: note: in expansion of macro 'virt_addr_valid'
     772 |         if (!suite_set.start || !virt_addr_valid(suite_set.start))
         |                                  ^~~~~~~~~~~~~~~
   arch/csky/include/asm/page.h:38:43: note: each undeclared identifier is reported only once for each function it appears in
      38 |                         (void *)(kaddr) < high_memory)
         |                                           ^~~~~~~~~~~
   lib/kunit/test.c:772:34: note: in expansion of macro 'virt_addr_valid'
     772 |         if (!suite_set.start || !virt_addr_valid(suite_set.start))
         |                                  ^~~~~~~~~~~~~~~


vim +/high_memory +38 arch/csky/include/asm/page.h

013de2d6671d89 Guo Ren 2018-09-05  36  
013de2d6671d89 Guo Ren 2018-09-05  37  #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && \
013de2d6671d89 Guo Ren 2018-09-05 @38  			(void *)(kaddr) < high_memory)
013de2d6671d89 Guo Ren 2018-09-05  39  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
