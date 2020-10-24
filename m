Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973FD297AF6
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Oct 2020 07:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759663AbgJXFya (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Oct 2020 01:54:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:11277 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759661AbgJXFya (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Oct 2020 01:54:30 -0400
IronPort-SDR: xY+Ve1KRiRYMeCZE1OB9RXVMqeh2R8t9kBz9nkfQrVe5EiltmB36ON0KnYYe6CB21rMps7SXOh
 xJ4+B0IaN4kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9783"; a="185467975"
X-IronPort-AV: E=Sophos;i="5.77,411,1596524400"; 
   d="scan'208";a="185467975"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 22:54:23 -0700
IronPort-SDR: 6fl/ealswHdpGbu0zESN86QWWrsl82DWaHLWJ2Sg2xO8/gkHa1TMgQWcdj0yWrreQ/pg//8QSC
 yYAgH+JgKPwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,411,1596524400"; 
   d="scan'208";a="333507868"
Received: from lkp-server01.sh.intel.com (HELO cda15bb6d7bd) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Oct 2020 22:54:19 -0700
Received: from kbuild by cda15bb6d7bd with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kWCVO-0000Q3-G4; Sat, 24 Oct 2020 05:54:18 +0000
Date:   Sat, 24 Oct 2020 13:54:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Gow <davidgow@google.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     kbuild-all@lists.01.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Subject: Re: [PATCH v4] fat: Add KUnit tests for checksums and timestamps
Message-ID: <202010241330.3jsFukha-lkp@intel.com>
References: <20201024052047.2526780-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024052047.2526780-1-davidgow@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.9 next-20201023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Gow/fat-Add-KUnit-tests-for-checksums-and-timestamps/20201024-132133
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f11901ed723d1351843771c3a84b03a253bbf8b2
config: sparc-randconfig-s031-20201024
compiler: sparc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-17-g2d3af347-dirty
        # https://github.com/0day-ci/linux/commit/3904bec3c79102be934e8021abb02c9176f099d7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-Gow/fat-Add-KUnit-tests-for-checksums-and-timestamps/20201024-132133
        git checkout 3904bec3c79102be934e8021abb02c9176f099d7
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sparc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/fat/Kconfig:121:warning: ignoring unsupported character '&'
>> fs/fat/Kconfig:122: syntax error
   fs/fat/Kconfig:121: invalid statement
   fs/fat/Kconfig:122: invalid statement
   fs/fat/Kconfig:123: invalid statement
   fs/fat/Kconfig:124: unknown statement "This"
   fs/fat/Kconfig:126:warning: ignoring unsupported character ','
   fs/fat/Kconfig:126: unknown statement "For"
   fs/fat/Kconfig:127:warning: ignoring unsupported character '/'
   fs/fat/Kconfig:127:warning: ignoring unsupported character '/'
   fs/fat/Kconfig:127: unknown statement "to"
   fs/fat/Kconfig:129:warning: ignoring unsupported character ','
   fs/fat/Kconfig:129: unknown statement "If"
   make[2]: *** [scripts/kconfig/Makefile:71: oldconfig] Error 1
   make[1]: *** [Makefile:604: oldconfig] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
   fs/fat/Kconfig:121:warning: ignoring unsupported character '&'
>> fs/fat/Kconfig:122: syntax error
   fs/fat/Kconfig:121: invalid statement
   fs/fat/Kconfig:122: invalid statement
   fs/fat/Kconfig:123: invalid statement
   fs/fat/Kconfig:124: unknown statement "This"
   fs/fat/Kconfig:126:warning: ignoring unsupported character ','
   fs/fat/Kconfig:126: unknown statement "For"
   fs/fat/Kconfig:127:warning: ignoring unsupported character '/'
   fs/fat/Kconfig:127:warning: ignoring unsupported character '/'
   fs/fat/Kconfig:127: unknown statement "to"
   fs/fat/Kconfig:129:warning: ignoring unsupported character ','
   fs/fat/Kconfig:129: unknown statement "If"
   make[2]: *** [scripts/kconfig/Makefile:71: olddefconfig] Error 1
   make[1]: *** [Makefile:604: olddefconfig] Error 2
   make: *** [Makefile:185: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.

vim +122 fs/fat/Kconfig

 > 122		default KUNIT_ALL_TESTS

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
