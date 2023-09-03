Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A7A790B66
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbjICJoA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 05:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjICJn7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 05:43:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B985ACA
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693734236; x=1725270236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WV1JIzKkhcDH8bola0T9EjpDUBkvsSAzngS/stWNuaY=;
  b=B9fboAmn2SpsIb2qyUAf4uAWKsMqym3kHv/B44v8MM3AHOK6oiGzKS2Y
   1+ZbSYdQGdwFl2otiYKVefM/31RNtFNxHYVoR6/5yJT7HESZDlwTnqlMy
   W/aAWA7sCexQYaCdstSJRKxLY7Sx+yjL0ydifYzybMGp1Lv1IhhsW3M/q
   64NKfXXcpZGKHFa5k64DqG1SgcADy+JkGyeSHX+TH7Xikeeiz1Awvaamc
   kSufr3JNPcUXqQDx98BT/DE57SgbzmW+KxtdJrEBsUdq1V3zpqGstlotU
   78Oj1x8uw94IXnlEJpc4SXqczu5CIzEseLfYH5AMnyiWU0/nlqcvKfXsX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="380226625"
X-IronPort-AV: E=Sophos;i="6.02,224,1688454000"; 
   d="scan'208";a="380226625"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 02:43:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="734003108"
X-IronPort-AV: E=Sophos;i="6.02,224,1688454000"; 
   d="scan'208";a="734003108"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Sep 2023 02:43:52 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcje1-00034P-24;
        Sun, 03 Sep 2023 09:43:49 +0000
Date:   Sun, 3 Sep 2023 17:43:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>, brendan.higgins@linux.dev,
        davidgow@google.com, skhan@linuxfoundation.org,
        jk@codeconstruct.com.au, dlatypov@google.com, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/4] kunit: Fix the wrong err path and add goto labels
 in kunit_filter_suites()
Message-ID: <202309031713.CDgtY4ZB-lkp@intel.com>
References: <20230903071028.1518913-3-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903071028.1518913-3-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jinjie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20230831]
[cannot apply to v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinjie-Ruan/kunit-Fix-wild-memory-access-bug-in-kunit_free_suite_set/20230903-151137
base:   linus/master
patch link:    https://lore.kernel.org/r/20230903071028.1518913-3-ruanjinjie%40huawei.com
patch subject: [PATCH v2 2/4] kunit: Fix the wrong err path and add goto labels in kunit_filter_suites()
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230903/202309031713.CDgtY4ZB-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309031713.CDgtY4ZB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309031713.CDgtY4ZB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/kunit/executor.c:221:1: warning: unused label 'free_parsed_glob' [-Wunused-label]
   free_parsed_glob:
   ^~~~~~~~~~~~~~~~~
>> lib/kunit/executor.c:227:1: warning: unused label 'free_copy' [-Wunused-label]
   free_copy:
   ^~~~~~~~~~
   2 warnings generated.


vim +/free_parsed_glob +221 lib/kunit/executor.c

   132	
   133	struct kunit_suite_set
   134	kunit_filter_suites(const struct kunit_suite_set *suite_set,
   135			    const char *filter_glob,
   136			    char *filters,
   137			    char *filter_action,
   138			    int *err)
   139	{
   140		int i, j, k;
   141		int filter_count = 0;
   142		struct kunit_suite **copy, **copy_start, *filtered_suite, *new_filtered_suite;
   143		struct kunit_suite_set filtered = {NULL, NULL};
   144		struct kunit_glob_filter parsed_glob;
   145		struct kunit_attr_filter *parsed_filters = NULL;
   146	
   147		const size_t max = suite_set->end - suite_set->start;
   148	
   149		copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
   150		if (!copy) { /* won't be able to run anything, return an empty set */
   151			return filtered;
   152		}
   153		copy_start = copy;
   154	
   155		if (filter_glob)
   156			kunit_parse_glob_filter(&parsed_glob, filter_glob);
   157	
   158		/* Parse attribute filters */
   159		if (filters) {
   160			filter_count = kunit_get_filter_count(filters);
   161			parsed_filters = kcalloc(filter_count, sizeof(*parsed_filters), GFP_KERNEL);
   162			if (!parsed_filters) {
   163				kfree(copy);
   164				return filtered;
   165			}
   166			for (j = 0; j < filter_count; j++)
   167				parsed_filters[j] = kunit_next_attr_filter(&filters, err);
   168			if (*err)
   169				goto free_parsed_filters;
   170		}
   171	
   172		for (i = 0; &suite_set->start[i] != suite_set->end; i++) {
   173			filtered_suite = suite_set->start[i];
   174			if (filter_glob) {
   175				if (!glob_match(parsed_glob.suite_glob, filtered_suite->name))
   176					continue;
   177				filtered_suite = kunit_filter_glob_tests(filtered_suite,
   178						parsed_glob.test_glob);
   179				if (IS_ERR(filtered_suite)) {
   180					*err = PTR_ERR(filtered_suite);
   181					goto free_parsed_filters;
   182				}
   183			}
   184			if (filter_count > 0 && parsed_filters != NULL) {
   185				for (k = 0; k < filter_count; k++) {
   186					new_filtered_suite = kunit_filter_attr_tests(filtered_suite,
   187							parsed_filters[k], filter_action, err);
   188	
   189					/* Free previous copy of suite */
   190					if (k > 0 || filter_glob) {
   191						kfree(filtered_suite->test_cases);
   192						kfree(filtered_suite);
   193					}
   194	
   195					filtered_suite = new_filtered_suite;
   196	
   197					if (*err)
   198						goto free_parsed_filters;
   199	
   200					if (IS_ERR(filtered_suite)) {
   201						*err = PTR_ERR(filtered_suite);
   202						goto free_parsed_filters;
   203					}
   204					if (!filtered_suite)
   205						break;
   206				}
   207			}
   208	
   209			if (!filtered_suite)
   210				continue;
   211	
   212			*copy++ = filtered_suite;
   213		}
   214		filtered.start = copy_start;
   215		filtered.end = copy;
   216	
   217	free_parsed_filters:
   218		if (filter_count)
   219			kfree(parsed_filters);
   220	
 > 221	free_parsed_glob:
   222		if (filter_glob) {
   223			kfree(parsed_glob.suite_glob);
   224			kfree(parsed_glob.test_glob);
   225		}
   226	
 > 227	free_copy:
   228		if (*err)
   229			kfree(copy);
   230	
   231		return filtered;
   232	}
   233	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
