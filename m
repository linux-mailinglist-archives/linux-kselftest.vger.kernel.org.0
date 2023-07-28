Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415A97675D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjG1Stu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjG1Stt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:49:49 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB411D;
        Fri, 28 Jul 2023 11:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690570187; x=1722106187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AmRz+rAZ+Q2waodphVoUUAhBzbM9rXTd8pWInD22nsQ=;
  b=VqiYIvZ8dNgSA3vnV/Ts9dT4UboF0qQBTNBhdn4X4lraE+vG3pzkr48n
   mk8GCb0lRsxEw59dl8QQDf0bI3UCtvvktjKocKbmJzOd8GqNdpRPaM8eK
   ejotMwQrEdw9DwgFA3dKL+pfs6C+rwNihpQnOLHPaZ1ai1GGYo7FBi2wH
   bL3LnhwARdTZyKNxhosnp26XUEKhg02Z61PUhlfRFXt83xkJSiiIbdBAo
   PFczfWm9Eqr5HfGOzvEjKQGZAe7jfddKl4qE1SS5qdKSbv+q091QzPXfZ
   bvE/itcDAjjV0Idc1mkuTVjrQz8hlBgoj3JrqdvTczpCVIPBk3UIdhP7S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="432473594"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="432473594"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 11:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="721360000"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="721360000"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 28 Jul 2023 11:49:43 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPSX0-0003Ux-0z;
        Fri, 28 Jul 2023 18:49:42 +0000
Date:   Sat, 29 Jul 2023 02:48:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, igt-dev@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kunit: Allow kunit test modules to use test filtering
Message-ID: <202307290255.bxxn7jm8-lkp@intel.com>
References: <20230728154419.1810177-8-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728154419.1810177-8-janusz.krzysztofik@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Janusz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/kunit-fixes]
[also build test WARNING on linus/master v6.5-rc3]
[cannot apply to shuah-kselftest/kunit next-20230728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Janusz-Krzysztofik/kunit-Report-the-count-of-test-suites-in-a-module/20230728-234736
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit-fixes
patch link:    https://lore.kernel.org/r/20230728154419.1810177-8-janusz.krzysztofik%40linux.intel.com
patch subject: [PATCH 3/3] kunit: Allow kunit test modules to use test filtering
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230729/202307290255.bxxn7jm8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290255.bxxn7jm8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290255.bxxn7jm8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/kunit/executor.c:182:42: warning: 'struct suite_set' declared inside parameter list will not be visible outside of this definition or declaration
     182 | static void kunit_exec_list_tests(struct suite_set *suite_set)
         |                                          ^~~~~~~~~
   lib/kunit/executor.c: In function 'kunit_exec_list_tests':
   lib/kunit/executor.c:190:32: error: invalid use of undefined type 'struct suite_set'
     190 |         for (suites = suite_set->start; suites < suite_set->end; suites++)
         |                                ^~
   lib/kunit/executor.c:190:59: error: invalid use of undefined type 'struct suite_set'
     190 |         for (suites = suite_set->start; suites < suite_set->end; suites++)
         |                                                           ^~
   lib/kunit/executor.c: In function 'kunit_run_all_tests':
   lib/kunit/executor.c:198:16: error: variable 'suite_set' has initializer but incomplete type
     198 |         struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
         |                ^~~~~~~~~
   lib/kunit/executor.c:198:39: warning: excess elements in struct initializer
     198 |         struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
         |                                       ^~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor.c:198:39: note: (near initialization for 'suite_set')
   lib/kunit/executor.c:198:61: warning: excess elements in struct initializer
     198 |         struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
         |                                                             ^~~~~~~~~~~~~~~~~~
   lib/kunit/executor.c:198:61: note: (near initialization for 'suite_set')
   lib/kunit/executor.c:198:26: error: storage size of 'suite_set' isn't known
     198 |         struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
         |                          ^~~~~~~~~
>> lib/kunit/executor.c:198:26: warning: unused variable 'suite_set' [-Wunused-variable]
   In file included from lib/kunit/executor.c:230:
   lib/kunit/executor_test.c: In function 'filter_suites_test':
   lib/kunit/executor_test.c:45:16: error: variable 'suite_set' has initializer but incomplete type
      45 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                ^~~~~~~~~
   lib/kunit/executor_test.c:45:40: error: 'struct suite_set' has no member named 'start'
      45 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                        ^~~~~
   lib/kunit/executor_test.c:45:48: warning: excess elements in struct initializer
      45 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                                ^~~~~~~~
   lib/kunit/executor_test.c:45:48: note: (near initialization for 'suite_set')
   lib/kunit/executor_test.c:45:59: error: 'struct suite_set' has no member named 'end'
      45 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                                           ^~~
   lib/kunit/executor_test.c:45:65: warning: excess elements in struct initializer
      45 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                                                 ^
   lib/kunit/executor_test.c:45:65: note: (near initialization for 'suite_set')
   lib/kunit/executor_test.c:45:26: error: storage size of 'suite_set' isn't known
      45 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                          ^~~~~~~~~
   lib/kunit/executor_test.c:46:26: error: storage size of 'got' isn't known
      46 |         struct suite_set got;
         |                          ^~~
   In file included from lib/kunit/executor.c:4:
   include/kunit/test.h:737:29: warning: passing argument 1 of 'IS_ERR_OR_NULL' makes pointer from integer without a cast [-Wint-conversion]
     737 |         if (!IS_ERR_OR_NULL(__ptr))                                            \
         |                             ^~~~~
         |                             |
         |                             int
   include/kunit/test.h:1418:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1418 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1415:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1415 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:54:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      54 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/processor.h:36,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:9,
                    from include/linux/preempt.h:79,
                    from include/linux/smp.h:110,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/notifier.h:14,
                    from include/linux/reboot.h:6,
                    from lib/kunit/executor.c:3:
   include/linux/err.h:70:68: note: expected 'const void *' but argument is of type 'int'
      70 | static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
         |                                                        ~~~~~~~~~~~~^~~
   include/kunit/test.h:744:64: warning: initialization of 'const void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:510:49: note: in definition of macro '_KUNIT_FAILED'
     510 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                                 ^~~~~~~~~~~
   include/kunit/test.h:744:23: note: in expansion of macro 'KUNIT_INIT_ASSERT'
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                       ^~~~~~~~~~~~~~~~~
   include/kunit/test.h:1418:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1418 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1415:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1415 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:54:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      54 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:744:64: note: (near initialization for '__assertion.value')
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:510:49: note: in definition of macro '_KUNIT_FAILED'
     510 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                                 ^~~~~~~~~~~
   include/kunit/test.h:744:23: note: in expansion of macro 'KUNIT_INIT_ASSERT'
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                       ^~~~~~~~~~~~~~~~~
   include/kunit/test.h:1418:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1418 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1415:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1415 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:54:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      54 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:737:29: warning: passing argument 1 of 'IS_ERR_OR_NULL' makes pointer from integer without a cast [-Wint-conversion]
     737 |         if (!IS_ERR_OR_NULL(__ptr))                                            \
         |                             ^~~~~
         |                             |
         |                             int
   include/kunit/test.h:1418:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1418 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1415:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1415 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:59:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      59 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/err.h:70:68: note: expected 'const void *' but argument is of type 'int'
      70 | static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
         |                                                        ~~~~~~~~~~~~^~~
   include/kunit/test.h:744:64: warning: initialization of 'const void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:510:49: note: in definition of macro '_KUNIT_FAILED'
     510 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                                 ^~~~~~~~~~~
   include/kunit/test.h:744:23: note: in expansion of macro 'KUNIT_INIT_ASSERT'
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                       ^~~~~~~~~~~~~~~~~
   include/kunit/test.h:1418:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1418 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1415:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1415 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:59:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      59 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:744:64: note: (near initialization for '__assertion.value')
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:510:49: note: in definition of macro '_KUNIT_FAILED'
     510 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                                 ^~~~~~~~~~~
   include/kunit/test.h:744:23: note: in expansion of macro 'KUNIT_INIT_ASSERT'
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                       ^~~~~~~~~~~~~~~~~
   include/kunit/test.h:1418:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1418 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1415:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1415 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:59:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      59 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> lib/kunit/executor_test.c:46:26: warning: unused variable 'got' [-Wunused-variable]
      46 |         struct suite_set got;
         |                          ^~~
>> lib/kunit/executor_test.c:45:26: warning: unused variable 'suite_set' [-Wunused-variable]
      45 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                          ^~~~~~~~~
   lib/kunit/executor_test.c: In function 'filter_suites_test_glob_test':
   lib/kunit/executor_test.c:69:16: error: variable 'suite_set' has initializer but incomplete type
      69 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                ^~~~~~~~~
   lib/kunit/executor_test.c:69:40: error: 'struct suite_set' has no member named 'start'
      69 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                        ^~~~~
   lib/kunit/executor_test.c:69:48: warning: excess elements in struct initializer
      69 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                                ^~~~~~~~
   lib/kunit/executor_test.c:69:48: note: (near initialization for 'suite_set')
   lib/kunit/executor_test.c:69:59: error: 'struct suite_set' has no member named 'end'
      69 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                                           ^~~
   lib/kunit/executor_test.c:69:65: warning: excess elements in struct initializer
      69 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                                                 ^
   lib/kunit/executor_test.c:69:65: note: (near initialization for 'suite_set')
   lib/kunit/executor_test.c:69:26: error: storage size of 'suite_set' isn't known
      69 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                          ^~~~~~~~~
   lib/kunit/executor_test.c:70:26: error: storage size of 'got' isn't known
      70 |         struct suite_set got;
         |                          ^~~
   include/kunit/test.h:737:29: warning: passing argument 1 of 'IS_ERR_OR_NULL' makes pointer from integer without a cast [-Wint-conversion]
     737 |         if (!IS_ERR_OR_NULL(__ptr))                                            \
         |                             ^~~~~
         |                             |
         |                             int
   include/kunit/test.h:1418:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1418 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1415:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1415 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:78:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      78 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/err.h:70:68: note: expected 'const void *' but argument is of type 'int'
      70 | static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
         |                                                        ~~~~~~~~~~~~^~~
   include/kunit/test.h:744:64: warning: initialization of 'const void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:510:49: note: in definition of macro '_KUNIT_FAILED'
     510 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                                 ^~~~~~~~~~~
   include/kunit/test.h:744:23: note: in expansion of macro 'KUNIT_INIT_ASSERT'
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                       ^~~~~~~~~~~~~~~~~
   include/kunit/test.h:1418:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1418 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1415:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1415 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:78:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      78 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:744:64: note: (near initialization for '__assertion.value')
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:510:49: note: in definition of macro '_KUNIT_FAILED'
     510 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                                 ^~~~~~~~~~~
   include/kunit/test.h:744:23: note: in expansion of macro 'KUNIT_INIT_ASSERT'
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                       ^~~~~~~~~~~~~~~~~
   include/kunit/test.h:1418:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1418 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1415:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1415 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:78:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      78 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:737:29: warning: passing argument 1 of 'IS_ERR_OR_NULL' makes pointer from integer without a cast [-Wint-conversion]
     737 |         if (!IS_ERR_OR_NULL(__ptr))                                            \
         |                             ^~~~~
         |                             |
         |                             int
   include/kunit/test.h:1418:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1418 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1415:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1415 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:83:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      83 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/err.h:70:68: note: expected 'const void *' but argument is of type 'int'
      70 | static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
         |                                                        ~~~~~~~~~~~~^~~
   include/kunit/test.h:744:64: warning: initialization of 'const void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     744 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:510:49: note: in definition of macro '_KUNIT_FAILED'


vim +/suite_set +198 lib/kunit/executor.c

9c6b0e1d8993e47 Daniel Latypov  2021-09-30  195  
9c6b0e1d8993e47 Daniel Latypov  2021-09-30  196  int kunit_run_all_tests(void)
9c6b0e1d8993e47 Daniel Latypov  2021-09-30  197  {
e5857d396f35e59 Daniel Latypov  2022-07-09 @198  	struct suite_set suite_set = {__kunit_suites_start, __kunit_suites_end};
1b11063d32d7e11 Daniel Latypov  2022-05-13  199  	int err = 0;
d20a6ba5e3be5f8 Joe Fradley     2022-08-23  200  	if (!kunit_enabled()) {
d20a6ba5e3be5f8 Joe Fradley     2022-08-23  201  		pr_info("kunit: disabled\n");
d20a6ba5e3be5f8 Joe Fradley     2022-08-23  202  		goto out;
d20a6ba5e3be5f8 Joe Fradley     2022-08-23  203  	}
aac35468ca20a3a Alan Maguire    2020-08-04  204  
a02353f491622e4 Daniel Latypov  2022-05-11  205  	if (filter_glob_param) {
a02353f491622e4 Daniel Latypov  2022-05-11  206  		suite_set = kunit_filter_suites(&suite_set, filter_glob_param, &err);
a02353f491622e4 Daniel Latypov  2022-05-11  207  		if (err) {
a02353f491622e4 Daniel Latypov  2022-05-11  208  			pr_err("kunit executor: error filtering suites: %d\n", err);
1b11063d32d7e11 Daniel Latypov  2022-05-13  209  			goto out;
a02353f491622e4 Daniel Latypov  2022-05-11  210  		}
a02353f491622e4 Daniel Latypov  2022-05-11  211  	}
45dcbb6f5ef78b0 Brendan Higgins 2020-08-04  212  
9c6b0e1d8993e47 Daniel Latypov  2021-09-30  213  	if (!action_param)
9c6b0e1d8993e47 Daniel Latypov  2021-09-30  214  		kunit_exec_run_tests(&suite_set);
9c6b0e1d8993e47 Daniel Latypov  2021-09-30  215  	else if (strcmp(action_param, "list") == 0)
9c6b0e1d8993e47 Daniel Latypov  2021-09-30  216  		kunit_exec_list_tests(&suite_set);
9c6b0e1d8993e47 Daniel Latypov  2021-09-30  217  	else
9c6b0e1d8993e47 Daniel Latypov  2021-09-30  218  		pr_err("kunit executor: unknown action '%s'\n", action_param);
aac35468ca20a3a Alan Maguire    2020-08-04  219  
e5857d396f35e59 Daniel Latypov  2022-07-09  220  	if (filter_glob_param) { /* a copy was made of each suite */
a127b154a8f2317 Daniel Latypov  2021-09-14  221  		kunit_free_suite_set(suite_set);
5d31f71efcb6bce Daniel Latypov  2021-02-05  222  	}
5d31f71efcb6bce Daniel Latypov  2021-02-05  223  
1b11063d32d7e11 Daniel Latypov  2022-05-13  224  out:
1b11063d32d7e11 Daniel Latypov  2022-05-13  225  	kunit_handle_shutdown();
1b11063d32d7e11 Daniel Latypov  2022-05-13  226  	return err;
aac35468ca20a3a Alan Maguire    2020-08-04  227  }
aac35468ca20a3a Alan Maguire    2020-08-04  228  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
