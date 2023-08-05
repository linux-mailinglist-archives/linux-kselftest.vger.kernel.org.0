Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3E770CD9
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 03:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjHEBGI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 21:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHEBGH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 21:06:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B794EDD;
        Fri,  4 Aug 2023 18:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691197565; x=1722733565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ibSjDREM3KSlm2Zd9jBWEnIiB5S/qWcUN0yFt86xipE=;
  b=ex0SG4KKlWO/L6cUiNGTXDbv/GCiP0vzIJL53fv5YWDOfxmNuo+7ZIMp
   wQK2+4JsxIT2Zw7o/skGT8bAPznJgh2w3afvk/qvUbvGTs9wVEj+Efo4e
   bYVgyET0eDaJY68WjJITEIs2FRuV1Ugo4vP5BRFTAi3sDvVhhCUMXQbKj
   gee0XLEmetJ6YB4Melwyycs/Tq5PcneMfdmfrv2Zacq8xo1NgAZbbQCoP
   EyKffajuGDe3AuiNsxWRwxO+oaGqxObxB4hNVVT9xWnO+x9vR+1zn9m47
   81zSWESxOquyWJGZmeW9TcrRd0TXEDOAeLvxBdqZ7V3zJehYUfsWBP6cw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="456657222"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="456657222"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 18:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="854003292"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="854003292"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Aug 2023 18:06:02 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS5k1-0003EB-0M;
        Sat, 05 Aug 2023 01:06:01 +0000
Date:   Sat, 5 Aug 2023 09:05:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, igt-dev@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rae Moar <rmoar@google.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH v4 1/3] kunit: Report the count of test suites in a module
Message-ID: <202308050802.0wKtrhu1-lkp@intel.com>
References: <20230804225220.8005-6-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804225220.8005-6-janusz.krzysztofik@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Janusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5a175d369c702ce08c9feb630125c9fc7a9e1370]

url:    https://github.com/intel-lab-lkp/linux/commits/Janusz-Krzysztofik/kunit-Report-the-count-of-test-suites-in-a-module/20230805-065602
base:   5a175d369c702ce08c9feb630125c9fc7a9e1370
patch link:    https://lore.kernel.org/r/20230804225220.8005-6-janusz.krzysztofik%40linux.intel.com
patch subject: [PATCH v4 1/3] kunit: Report the count of test suites in a module
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230805/202308050802.0wKtrhu1-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308050802.0wKtrhu1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308050802.0wKtrhu1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/kunit/executor.c:296:
   lib/kunit/executor_test.c: In function 'filter_suites_test':
>> lib/kunit/executor_test.c:46:16: error: variable 'suite_set' has initializer but incomplete type
      46 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                ^~~~~~~~~
>> lib/kunit/executor_test.c:46:40: error: 'struct suite_set' has no member named 'start'
      46 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                        ^~~~~
   lib/kunit/executor_test.c:46:48: warning: excess elements in struct initializer
      46 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                                ^~~~~~~~
   lib/kunit/executor_test.c:46:48: note: (near initialization for 'suite_set')
>> lib/kunit/executor_test.c:46:59: error: 'struct suite_set' has no member named 'end'
      46 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                                           ^~~
   lib/kunit/executor_test.c:46:65: warning: excess elements in struct initializer
      46 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                                                                 ^
   lib/kunit/executor_test.c:46:65: note: (near initialization for 'suite_set')
>> lib/kunit/executor_test.c:46:26: error: storage size of 'suite_set' isn't known
      46 |         struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
         |                          ^~~~~~~~~
>> lib/kunit/executor_test.c:47:26: error: storage size of 'got' isn't known
      47 |         struct suite_set got;
         |                          ^~~
   In file included from lib/kunit/executor.c:4:
   include/kunit/test.h:797:29: warning: passing argument 1 of 'IS_ERR_OR_NULL' makes pointer from integer without a cast [-Wint-conversion]
     797 |         if (!IS_ERR_OR_NULL(__ptr))                                            \
         |                             ^~~~~
         |                             |
         |                             int
   include/kunit/test.h:1478:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1478 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1475:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1475 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:55:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      55 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/rwsem.h:17,
                    from include/linux/notifier.h:15,
                    from include/linux/reboot.h:6,
                    from lib/kunit/executor.c:3:
   include/linux/err.h:70:68: note: expected 'const void *' but argument is of type 'int'
      70 | static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
         |                                                        ~~~~~~~~~~~~^~~
   include/kunit/test.h:804:64: warning: initialization of 'const void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     804 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:570:49: note: in definition of macro '_KUNIT_FAILED'
     570 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                                 ^~~~~~~~~~~
   include/kunit/test.h:804:23: note: in expansion of macro 'KUNIT_INIT_ASSERT'
     804 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                       ^~~~~~~~~~~~~~~~~
   include/kunit/test.h:1478:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1478 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1475:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1475 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:55:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      55 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:804:64: note: (near initialization for '__assertion.value')
     804 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:570:49: note: in definition of macro '_KUNIT_FAILED'
     570 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                                 ^~~~~~~~~~~
   include/kunit/test.h:804:23: note: in expansion of macro 'KUNIT_INIT_ASSERT'
     804 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                       ^~~~~~~~~~~~~~~~~
   include/kunit/test.h:1478:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1478 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1475:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1475 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:55:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      55 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:797:29: warning: passing argument 1 of 'IS_ERR_OR_NULL' makes pointer from integer without a cast [-Wint-conversion]
     797 |         if (!IS_ERR_OR_NULL(__ptr))                                            \
         |                             ^~~~~
         |                             |
         |                             int
   include/kunit/test.h:1478:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1478 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1475:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1475 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:60:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      60 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/err.h:70:68: note: expected 'const void *' but argument is of type 'int'
      70 | static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
         |                                                        ~~~~~~~~~~~~^~~
   include/kunit/test.h:804:64: warning: initialization of 'const void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     804 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:570:49: note: in definition of macro '_KUNIT_FAILED'
     570 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                                 ^~~~~~~~~~~
   include/kunit/test.h:804:23: note: in expansion of macro 'KUNIT_INIT_ASSERT'
     804 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                       ^~~~~~~~~~~~~~~~~
   include/kunit/test.h:1478:9: note: in expansion of macro 'KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION'
    1478 |         KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,                          \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1475:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG'
    1475 |         KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/executor_test.c:60:9: note: in expansion of macro 'KUNIT_ASSERT_NOT_ERR_OR_NULL'
      60 |         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:804:64: note: (near initialization for '__assertion.value')
     804 |                       KUNIT_INIT_ASSERT(.text = #ptr, .value = __ptr),         \
         |                                                                ^~~~~
   include/kunit/test.h:570:49: note: in definition of macro '_KUNIT_FAILED'
     570 |         const struct assert_class __assertion = INITIALIZER;                   \


vim +/suite_set +46 lib/kunit/executor_test.c

1d71307a6f94df Daniel Latypov 2021-04-20  42  
e5857d396f35e5 Daniel Latypov 2022-07-09  43  static void filter_suites_test(struct kunit *test)
1d71307a6f94df Daniel Latypov 2021-04-20  44  {
e5857d396f35e5 Daniel Latypov 2022-07-09  45  	struct kunit_suite *subsuite[3] = {NULL, NULL};
e5857d396f35e5 Daniel Latypov 2022-07-09 @46  	struct suite_set suite_set = {.start = subsuite, .end = &subsuite[2]};
e5857d396f35e5 Daniel Latypov 2022-07-09 @47  	struct suite_set got;
e5857d396f35e5 Daniel Latypov 2022-07-09  48  	int err = 0;
1d71307a6f94df Daniel Latypov 2021-04-20  49  
a127b154a8f231 Daniel Latypov 2021-09-14  50  	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_test_cases);
a127b154a8f231 Daniel Latypov 2021-09-14  51  	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_test_cases);
1d71307a6f94df Daniel Latypov 2021-04-20  52  
1d71307a6f94df Daniel Latypov 2021-04-20  53  	/* Want: suite1, suite2, NULL -> suite2, NULL */
529534e8cba3e6 Rae Moar       2023-07-25  54  	got = kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &err);
e5857d396f35e5 Daniel Latypov 2022-07-09  55  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
e5857d396f35e5 Daniel Latypov 2022-07-09  56  	KUNIT_ASSERT_EQ(test, err, 0);
e5857d396f35e5 Daniel Latypov 2022-07-09  57  	kfree_at_end(test, got.start);
1d71307a6f94df Daniel Latypov 2021-04-20  58  
a127b154a8f231 Daniel Latypov 2021-09-14  59  	/* Validate we just have suite2 */
e5857d396f35e5 Daniel Latypov 2022-07-09  60  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
e5857d396f35e5 Daniel Latypov 2022-07-09  61  	KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->name, "suite2");
e5857d396f35e5 Daniel Latypov 2022-07-09  62  
e5857d396f35e5 Daniel Latypov 2022-07-09  63  	/* Contains one element (end is 1 past end) */
e5857d396f35e5 Daniel Latypov 2022-07-09  64  	KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
a127b154a8f231 Daniel Latypov 2021-09-14  65  }
a127b154a8f231 Daniel Latypov 2021-09-14  66  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
