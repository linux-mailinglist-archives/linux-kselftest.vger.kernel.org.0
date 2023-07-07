Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BAD74B3E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjGGPMe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGGPM0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 11:12:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F1C2123;
        Fri,  7 Jul 2023 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688742735; x=1720278735;
  h=date:from:to:cc:subject:message-id;
  bh=jn3qdIaoQnAQpWPE9kq0rlginNfQvB8QhEeTHfRq8NQ=;
  b=LlBZQwBjUbfPDI3FtIwiqbgznF4YJVIzroaBUzOfICgFhZgc5N8WJLGe
   6npvSo/qcaIkzWb1Ca69EpOAZHG0Dw1aXmL62bUKu6BMZRD3+QyDJ/wL5
   XRrKFhMlaVhBvBTpZlsFPDRU031NOC/0mPAbfZydePNOPfI46gJ6JxoFo
   FCjs86VMqE4qr66jIGARVDBtleRbqH+oYnIQWKnOGHATCoAKlMNgHAUa0
   nSjAfdZLKZvNk5wo3uTu1M7uPSTHj8rBxaoW5bt/1dPuWDzE7AtMhLMEK
   0RFtGxMw7Bb7T8VBDV4FBPeQEPQSmkameBNPcnG4dNETwtfAtwgAqOh4Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="362775482"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="362775482"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 08:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="864584020"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="864584020"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2023 08:12:01 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHn7o-00023A-2q;
        Fri, 07 Jul 2023 15:12:00 +0000
Date:   Fri, 07 Jul 2023 23:11:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 123212f53f3e394c1ae69a58c05dfdda56fec8c6
Message-ID: <202307072334.fuhKXXFM-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 123212f53f3e394c1ae69a58c05dfdda56fec8c6  Add linux-next specific files for 20230707

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306122223.HHER4zOo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306240021.qNRc4iHW-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arm64/kernel/entry-ftrace.S:59: Error: undefined symbol FTRACE_OPS_DIRECT_CALL used as an immediate value
arch/parisc/kernel/pdt.c:67:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
drivers/net/arcnet/arc-rimi.c:107:4: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
drivers/net/arcnet/arc-rimi.c:107:6: error: call to undeclared function 'ioremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/net/arcnet/arc-rimi.c:113:3: error: call to undeclared function 'iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/pcmcia/cistpl.c:103:15: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
drivers/pcmcia/cistpl.c:103:17: error: call to undeclared function 'ioremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/pcmcia/cistpl.c:72:3: error: call to undeclared function 'iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/tty/ipwireless/main.c:115:21: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
drivers/tty/ipwireless/main.c:115:23: error: call to undeclared function 'ioremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/tty/ipwireless/main.c:155:2: error: call to undeclared function 'iounmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
lib/kunit/test.c:775:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-r034-20230707
|   `-- arch-arm64-kernel-entry-ftrace.S:Error:undefined-symbol-FTRACE_OPS_DIRECT_CALL-used-as-an-immediate-value
|-- parisc-randconfig-r034-20230707
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r081-20230703
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
`-- sh-allmodconfig
    `-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
clang_recent_errors
|-- arm-randconfig-r036-20230707
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r041-20230707
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
`-- s390-randconfig-r013-20230707
    |-- drivers-net-arcnet-arc-rimi.c:error:call-to-undeclared-function-ioremap-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- drivers-net-arcnet-arc-rimi.c:error:call-to-undeclared-function-iounmap-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- drivers-net-arcnet-arc-rimi.c:error:incompatible-integer-to-pointer-conversion-assigning-to-void-from-int
    |-- drivers-pcmcia-cistpl.c:error:call-to-undeclared-function-ioremap-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- drivers-pcmcia-cistpl.c:error:call-to-undeclared-function-iounmap-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- drivers-pcmcia-cistpl.c:error:incompatible-integer-to-pointer-conversion-assigning-to-void-from-int
    |-- drivers-tty-ipwireless-main.c:error:call-to-undeclared-function-ioremap-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- drivers-tty-ipwireless-main.c:error:call-to-undeclared-function-iounmap-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- drivers-tty-ipwireless-main.c:error:incompatible-integer-to-pointer-conversion-assigning-to-void-from-int

elapsed time: 737m

configs tested: 137
configs skipped: 5

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230707   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r035-20230707   gcc  
arc                  randconfig-r043-20230707   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                  randconfig-r021-20230707   gcc  
arm                  randconfig-r036-20230707   clang
arm                  randconfig-r046-20230707   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230707   clang
arm64                randconfig-r034-20230707   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230707   gcc  
csky                 randconfig-r003-20230707   gcc  
csky                 randconfig-r032-20230707   gcc  
csky                 randconfig-r033-20230707   gcc  
hexagon              randconfig-r041-20230707   clang
hexagon              randconfig-r045-20230707   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230707   gcc  
i386         buildonly-randconfig-r005-20230707   gcc  
i386         buildonly-randconfig-r006-20230707   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230707   gcc  
i386                 randconfig-i002-20230707   gcc  
i386                 randconfig-i003-20230707   gcc  
i386                 randconfig-i004-20230707   gcc  
i386                 randconfig-i005-20230707   gcc  
i386                 randconfig-i006-20230707   gcc  
i386                 randconfig-i011-20230707   clang
i386                 randconfig-i012-20230707   clang
i386                 randconfig-i013-20230707   clang
i386                 randconfig-i014-20230707   clang
i386                 randconfig-i015-20230707   clang
i386                 randconfig-i016-20230707   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230707   gcc  
microblaze           randconfig-r024-20230707   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                           ip22_defconfig   clang
mips                           ip28_defconfig   clang
mips                          malta_defconfig   clang
mips                       rbtx49xx_defconfig   clang
nios2                               defconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r011-20230707   gcc  
openrisc             randconfig-r035-20230707   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r034-20230707   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                   motionpro_defconfig   gcc  
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r031-20230707   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230707   gcc  
riscv                randconfig-r042-20230707   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230707   clang
s390                 randconfig-r014-20230707   clang
s390                 randconfig-r022-20230707   clang
s390                 randconfig-r033-20230707   gcc  
s390                 randconfig-r044-20230707   clang
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r006-20230707   gcc  
sh                   randconfig-r026-20230707   gcc  
sh                   randconfig-r031-20230707   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230707   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64              randconfig-r025-20230707   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r032-20230707   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230707   gcc  
x86_64       buildonly-randconfig-r002-20230707   gcc  
x86_64       buildonly-randconfig-r003-20230707   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230707   clang
x86_64               randconfig-x002-20230707   clang
x86_64               randconfig-x003-20230707   clang
x86_64               randconfig-x004-20230707   clang
x86_64               randconfig-x005-20230707   clang
x86_64               randconfig-x006-20230707   clang
x86_64               randconfig-x011-20230707   gcc  
x86_64               randconfig-x012-20230707   gcc  
x86_64               randconfig-x013-20230707   gcc  
x86_64               randconfig-x014-20230707   gcc  
x86_64               randconfig-x015-20230707   gcc  
x86_64               randconfig-x016-20230707   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa               randconfig-r016-20230707   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
