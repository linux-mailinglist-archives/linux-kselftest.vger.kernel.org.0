Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DA675D921
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 04:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGVCbZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 22:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGVCbZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 22:31:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52688119;
        Fri, 21 Jul 2023 19:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689993084; x=1721529084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rmZYm534mz67y/kh+IAlfXuKVDu6Z0GGNVGIAI3/ezg=;
  b=ZXKF2hP/h3ksWLHNKJLA2O7k0K9k7qp1eWS7DJfDxkphcw4KEKD9nib7
   2SzvMUnDQd+/FCtnDvbfubGgxiEBvX5SaiyeftNcNFZBGXEkskvad1+FO
   CHXN01yLFx0jyDIkGsuVVWKCKNpFhlMnf9U8cfG/ePeC6+lO7AgceCOqp
   A27zZuPw8I8Isi/TXMeQZDQQf3sjTnw6dtrDwJl9zLH3ToSUXuGLTckHQ
   N1CYCZJXfI6beMY2lWeEIfF+SULNlIKwcVGtuTJeQGF6W1PSWK+oVxpz+
   zF8uqpphRiH/+EClPNlN82tqM4eVSZ4jQeqGVXtjnkLyP9kNPGE93lXN+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="370758573"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="370758573"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 19:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="849019437"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="849019437"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2023 19:31:19 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qN2Ot-0007sX-0A;
        Sat, 22 Jul 2023 02:31:19 +0000
Date:   Sat, 22 Jul 2023 10:30:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rae Moar <rmoar@google.com>, shuah@kernel.org, davidgow@google.com,
        dlatypov@google.com, brendan.higgins@linux.dev
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v1 4/9] kunit: Add ability to filter attributes
Message-ID: <202307221053.0LbbjwLI-lkp@intel.com>
References: <20230719222338.259684-5-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719222338.259684-5-rmoar@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Rae,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 64bd4641310c41a1ecf07c13c67bc0ed61045dfd]

url:    https://github.com/intel-lab-lkp/linux/commits/Rae-Moar/kunit-Add-test-attributes-API-structure/20230720-062623
base:   64bd4641310c41a1ecf07c13c67bc0ed61045dfd
patch link:    https://lore.kernel.org/r/20230719222338.259684-5-rmoar%40google.com
patch subject: [PATCH v1 4/9] kunit: Add ability to filter attributes
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230722/202307221053.0LbbjwLI-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307221053.0LbbjwLI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307221053.0LbbjwLI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/kunit/attributes.c:109:14: warning: variable 'input_val' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
           for (i = 0; input[i]; i++) {
                       ^~~~~~~~
   lib/kunit/attributes.c:116:7: note: uninitialized use occurs here
           if (!input_val) {
                ^~~~~~~~~
   lib/kunit/attributes.c:109:14: note: remove the condition if it is always true
           for (i = 0; input[i]; i++) {
                       ^~~~~~~~
   lib/kunit/attributes.c:107:23: note: initialize the variable 'input_val' to silence this warning
           const char *input_val;
                                ^
                                 = NULL
   lib/kunit/attributes.c:215:47: error: initializer element is not a compile-time constant
   static struct kunit_attr kunit_attr_list[] = {speed_attr, module_attr};
                                                 ^~~~~~~~~~
   1 warning and 1 error generated.


vim +109 lib/kunit/attributes.c

    96	
    97	/*
    98	 * Returns whether the inputted enum value "attr" matches the filter given
    99	 * by the input string. Note: the str_list includes the corresponding string
   100	 * list to the enum values.
   101	 */
   102	static int attr_enum_filter(void *attr, const char *input, int *err,
   103			const char * const str_list[], int max)
   104	{
   105		int i, j, input_int;
   106		long test_val = (long)attr;
   107		const char *input_val;
   108	
 > 109		for (i = 0; input[i]; i++) {
   110			if (!strchr(op_list, input[i])) {
   111				input_val = input + i;
   112				break;
   113			}
   114		}
   115	
   116		if (!input_val) {
   117			*err = -EINVAL;
   118			pr_err("kunit executor: filter value not found: %s\n", input);
   119			return false;
   120		}
   121	
   122		for (j = 0; j <= max; j++) {
   123			if (!strcmp(input_val, str_list[j]))
   124				input_int = j;
   125		}
   126	
   127		if (!input_int) {
   128			*err = -EINVAL;
   129			pr_err("kunit executor: invalid filter input: %s\n", input);
   130			return false;
   131		}
   132	
   133		return int_filter(test_val, input, input_int, err);
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
