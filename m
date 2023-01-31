Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBCD683A45
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Feb 2023 00:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjAaXPe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 18:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjAaXPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 18:15:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B657A8D;
        Tue, 31 Jan 2023 15:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675206932; x=1706742932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nhQKXK4du3QYoITmpjYltXnWiNyEHo74mvQfoZMOFYE=;
  b=BCpCxlkmoxHef0gj2bF5nNJdlCzDqoMwYCgbvYN2nSEDFCxWSwn2zMq8
   dZxu4LdrzBjoXwhqF0s6mskk1kcPcz96i4lMbiyKfzOHWCOvjLbtDG2zT
   8JN8Bdiadblqhn/re5ygXbhXdGM9NFGWgR810X6B/8dMBWKnqBJPnuxu6
   utzs3xUnOatZnx8G1t4dRxVoF87FbUYo90jmBzbP98OjljWjRO0biB1DD
   htrcY7kakdv5XsSEsUVYMqlMeYhFbw+dTYQCcHQjX0FfWTlgH5BBir5dN
   Cy2uuoDxN5KbzYsWKuqCFAcO4nD4O7xJ4+Lt0x35gDy8GA8kxrKF7HxM3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="307643502"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="307643502"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 15:15:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="666693216"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="666693216"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jan 2023 15:15:29 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMzqa-0004mc-36;
        Tue, 31 Jan 2023 23:15:29 +0000
Date:   Wed, 1 Feb 2023 07:14:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        davidgow@google.com, dlatypov@google.com
Cc:     oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v1 1/3] kunit: fix bug in debugfs logs of parameterized
 tests
Message-ID: <202302010709.7ZmEen4w-lkp@intel.com>
References: <20230131220355.1603527-2-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131220355.1603527-2-rmoar@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230201/202302010709.7ZmEen4w-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c8b669e1d139e1ee08121b184d859e45d7a02940
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rae-Moar/kunit-fix-bug-in-debugfs-logs-of-parameterized-tests/20230201-060537
        git checkout c8b669e1d139e1ee08121b184d859e45d7a02940
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/kunit/test.c: In function '__kunit_fail_current_test_impl':
   lib/kunit/test.c:40:9: warning: function '__kunit_fail_current_test_impl' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      40 |         len = vsnprintf(NULL, 0, fmt, args) + 1;
         |         ^~~
   lib/kunit/test.c:48:9: warning: function '__kunit_fail_current_test_impl' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      48 |         vsnprintf(buffer, len, fmt, args);
         |         ^~~~~~~~~
   lib/kunit/test.c: In function 'kunit_log_append':
>> lib/kunit/test.c:133:1: warning: the frame size of 1500 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     133 | }
         | ^


vim +133 lib/kunit/test.c

acd8e8407b8fcc David Gow    2021-08-03  110  
e2219db280e3fe Alan Maguire 2020-03-26  111  /*
e2219db280e3fe Alan Maguire 2020-03-26  112   * Append formatted message to log, size of which is limited to
e2219db280e3fe Alan Maguire 2020-03-26  113   * KUNIT_LOG_SIZE bytes (including null terminating byte).
e2219db280e3fe Alan Maguire 2020-03-26  114   */
e2219db280e3fe Alan Maguire 2020-03-26  115  void kunit_log_append(char *log, const char *fmt, ...)
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
e2219db280e3fe Alan Maguire 2020-03-26 @133  }
e2219db280e3fe Alan Maguire 2020-03-26  134  EXPORT_SYMBOL_GPL(kunit_log_append);
e2219db280e3fe Alan Maguire 2020-03-26  135  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
