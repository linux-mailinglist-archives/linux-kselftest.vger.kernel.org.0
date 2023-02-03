Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCD0688FDE
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 07:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjBCGxV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 01:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjBCGw7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 01:52:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0754DBC4;
        Thu,  2 Feb 2023 22:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675407178; x=1706943178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YLxRVqzdHX5DYPv0wz35Wx3HFUs0vyQTGtj2YwxzESM=;
  b=TBvkBiCDb1YTBIsZZieknJJJrRDSxsmgENN6ch9Eysc8vPM5ZcZm8bFX
   aGDgxNJMr9qh7rGtM3Vt1SzGGL8clPk6IY7vY64++fVf6VM2KBIH3Vpz4
   wEk4RRG0XG7m/CacWtaKARevXr094RICAjFkcEpOIAx0FllEFqfNwsFHJ
   nytk2ZU3bg1PXsrIcALWHuWKXHgCQFVuz2/9e9gwYvwQE+UZJVnxjh9OZ
   9VLdcC2PJCq8uHmmkmQBvQ/Cl8nnqH7l5On1d6y9b8HDuB8lnQk3ryZuY
   /ZrUvPvWJ7p9Hlmf7im9PQkD4jfb1aUvu3PLKrsJlBEX7vy8XRYcrVBOb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="328691399"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="328691399"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 22:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="665605404"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="665605404"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2023 22:52:43 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNpwA-0000DV-2I;
        Fri, 03 Feb 2023 06:52:42 +0000
Date:   Fri, 3 Feb 2023 14:52:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        davidgow@google.com, dlatypov@google.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v1 1/3] kunit: fix bug in debugfs logs of parameterized
 tests
Message-ID: <202302031414.TsTAA8Dr-lkp@intel.com>
References: <20230131220355.1603527-2-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131220355.1603527-2-rmoar@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Rae,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 766f4f2514d2d18bcbd60a058188fb502dea5ddf]

url:    https://github.com/intel-lab-lkp/linux/commits/Rae-Moar/kunit-fix-bug-in-debugfs-logs-of-parameterized-tests/20230201-060537
base:   766f4f2514d2d18bcbd60a058188fb502dea5ddf
patch link:    https://lore.kernel.org/r/20230131220355.1603527-2-rmoar%40google.com
patch subject: [PATCH v1 1/3] kunit: fix bug in debugfs logs of parameterized tests
config: hexagon-randconfig-r045-20230202 (https://download.01.org/0day-ci/archive/20230203/202302031414.TsTAA8Dr-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c8b669e1d139e1ee08121b184d859e45d7a02940
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rae-Moar/kunit-fix-bug-in-debugfs-logs-of-parameterized-tests/20230201-060537
        git checkout c8b669e1d139e1ee08121b184d859e45d7a02940
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash lib/kunit/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/kunit/test.c:115:6: warning: stack frame size (1536) exceeds limit (1024) in 'kunit_log_append' [-Wframe-larger-than]
   void kunit_log_append(char *log, const char *fmt, ...)
        ^
   12/1536 (0.78%) spills, 1524/1536 (99.22%) variables
   1 warning generated.


vim +/kunit_log_append +115 lib/kunit/test.c

acd8e8407b8fcc David Gow    2021-08-03  110  
e2219db280e3fe Alan Maguire 2020-03-26  111  /*
e2219db280e3fe Alan Maguire 2020-03-26  112   * Append formatted message to log, size of which is limited to
e2219db280e3fe Alan Maguire 2020-03-26  113   * KUNIT_LOG_SIZE bytes (including null terminating byte).
e2219db280e3fe Alan Maguire 2020-03-26  114   */
e2219db280e3fe Alan Maguire 2020-03-26 @115  void kunit_log_append(char *log, const char *fmt, ...)
e2219db280e3fe Alan Maguire 2020-03-26  116  {
e2219db280e3fe Alan Maguire 2020-03-26  117  	char line[KUNIT_LOG_SIZE];
e2219db280e3fe Alan Maguire 2020-03-26  118  	va_list args;
e2219db280e3fe Alan Maguire 2020-03-26  119  	int len_left;
e2219db280e3fe Alan Maguire 2020-03-26  120  
e2219db280e3fe Alan Maguire 2020-03-26  121  	if (!log)
e2219db280e3fe Alan Maguire 2020-03-26  122  		return;
e2219db280e3fe Alan Maguire 2020-03-26  123  
e2219db280e3fe Alan Maguire 2020-03-26  124  	len_left = KUNIT_LOG_SIZE - strlen(log) - 1;
e2219db280e3fe Alan Maguire 2020-03-26  125  	if (len_left <= 0)
e2219db280e3fe Alan Maguire 2020-03-26  126  		return;
e2219db280e3fe Alan Maguire 2020-03-26  127  
e2219db280e3fe Alan Maguire 2020-03-26  128  	va_start(args, fmt);
e2219db280e3fe Alan Maguire 2020-03-26  129  	vsnprintf(line, sizeof(line), fmt, args);
e2219db280e3fe Alan Maguire 2020-03-26  130  	va_end(args);
e2219db280e3fe Alan Maguire 2020-03-26  131  
e2219db280e3fe Alan Maguire 2020-03-26  132  	strncat(log, line, len_left);
e2219db280e3fe Alan Maguire 2020-03-26  133  }
e2219db280e3fe Alan Maguire 2020-03-26  134  EXPORT_SYMBOL_GPL(kunit_log_append);
e2219db280e3fe Alan Maguire 2020-03-26  135  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
