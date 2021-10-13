Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A5042CA6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 21:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhJMTyp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 15:54:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:45966 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhJMTyp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 15:54:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227417119"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="gz'50?scan'50,208,50";a="227417119"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 12:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="gz'50?scan'50,208,50";a="626485926"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2021 12:52:37 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1makIn-000542-4z; Wed, 13 Oct 2021 19:52:37 +0000
Date:   Thu, 14 Oct 2021 03:52:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 4/7] list: Replace kernel.h with the necessary
 inclusions
Message-ID: <202110140346.TAK3t1ww-lkp@intel.com>
References: <20211013170417.87909-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20211013170417.87909-5-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on media-tree/master linux/master linus/master v5.15-rc5 next-20211013]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/kernel-h-further-split/20211014-010532
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git dd0aa2cd2e9e3e49b8c3b43924dc1a1d4e22b4d1
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/4797f8ad0f7b6807a7af02543f77c0ee1b340537
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andy-Shevchenko/kernel-h-further-split/20211014-010532
        git checkout 4797f8ad0f7b6807a7af02543f77c0ee1b340537
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/um/Makefile:44: FORCE prerequisite is missing
   In file included from include/linux/rcupdate.h:28,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   include/linux/bottom_half.h: In function 'local_bh_disable':
>> include/linux/bottom_half.h:19:24: error: '_THIS_IP_' undeclared (first use in this function)
      19 |  __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
         |                        ^~~~~~~~~
   include/linux/bottom_half.h:19:24: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/bottom_half.h: In function 'local_bh_enable':
   include/linux/bottom_half.h:32:23: error: '_THIS_IP_' undeclared (first use in this function)
      32 |  __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
         |                       ^~~~~~~~~
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h: At top level:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
       9 | void foo(void)
         |      ^~~
   make[2]: *** [scripts/Makefile.build:121: arch/um/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1225: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/_THIS_IP_ +19 include/linux/bottom_half.h

0bd3a173d71185 Peter Zijlstra 2013-11-19  16  
0bd3a173d71185 Peter Zijlstra 2013-11-19  17  static inline void local_bh_disable(void)
0bd3a173d71185 Peter Zijlstra 2013-11-19  18  {
0bd3a173d71185 Peter Zijlstra 2013-11-19 @19  	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
0bd3a173d71185 Peter Zijlstra 2013-11-19  20  }
0bd3a173d71185 Peter Zijlstra 2013-11-19  21  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gKMricLos+KVdGMg--
