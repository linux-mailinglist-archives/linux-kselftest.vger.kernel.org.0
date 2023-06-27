Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335EB7404E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 22:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjF0UZW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 16:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjF0UZV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 16:25:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674CD212D;
        Tue, 27 Jun 2023 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687897520; x=1719433520;
  h=date:from:to:cc:subject:message-id;
  bh=CZtQQkjwBTjIsN2Lz5HDJSCfMhdSSF8YauQRpgSzeq0=;
  b=faBD1Te1bDoAjdR0cnZb6Xy4D+w+BP2aaX1FwVqOqSuf33R9JvzW5Pqv
   JmpolW7wdnF2GdFiPUMKcx6fpc0MWktOPaEJQp9OTiZY6coGCa5daehWD
   n2iyjYzqWncaUfqzjTvVQquXxPIffTdorl2MXQbmT9R/RmdDNa0ObMCy/
   bC7fNxmVrd/PgClOsODLurqIGyjFtQEUdofJ4kzu4ab8apFV0OP+T7w93
   x8q7GiEFZ7O1raDPS+2ZoHbcHkJb6Is8qw+fuXq2QtoMKOewBTjZY9XYv
   y/kI5Z0I+cAXMLeI/mS+a17R6y7r4bkM4Kd4FHjSvfJZ4fQywVOEYZ9NL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="365129100"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="365129100"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 13:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="716669046"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="716669046"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Jun 2023 13:25:17 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEFFU-000CBp-2F;
        Tue, 27 Jun 2023 20:25:16 +0000
Date:   Wed, 28 Jun 2023 04:24:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        intel-gfx@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 53cdf865f90ba922a854c65ed05b519f9d728424
Message-ID: <202306280406.l3OXp90D-lkp@intel.com>
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
branch HEAD: 53cdf865f90ba922a854c65ed05b519f9d728424  Add linux-next specific files for 20230627

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306122223.HHER4zOo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306212119.fBNByIyn-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306260401.qZlYQpV2-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/parisc/kernel/pdt.c:66:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
drivers/char/mem.c:164:25: error: implicit declaration of function 'unxlate_dev_mem_ptr'; did you mean 'xlate_dev_mem_ptr'? [-Werror=implicit-function-declaration]
drivers/gpu/drm/i915/soc/intel_gmch.c:41:13: warning: variable 'mchbar_addr' set but not used [-Wunused-but-set-variable]
drivers/mfd/max77541.c:176:18: warning: cast to smaller integer type 'enum max7754x_ids' from 'const void *' [-Wvoid-pointer-to-enum-cast]
lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
lib/kunit/test.c:775:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/usb/cdns3/cdns3-starfive.c:23: warning: expecting prototype for cdns3(). Prototype was for USB_STRAP_HOST() instead
net/wireless/scan.c:373 cfg80211_gen_new_ie() warn: potential spectre issue 'sub->data' [r]
net/wireless/scan.c:397 cfg80211_gen_new_ie() warn: possible spectre second half.  'ext_id'
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined
{standard input}:1097: Error: pcrel too far
{standard input}:13: Error: symbol `__export_symbol_alpha_mv' is already defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r024-20230627
|   `-- standard-input:Error:symbol-__export_symbol_alpha_mv-is-already-defined
|-- i386-randconfig-m021-20230627
|   |-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:possible-spectre-second-half.-ext_id
|   `-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:potential-spectre-issue-sub-data-r
|-- parisc-allnoconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-allyesconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-defconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r012-20230627
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r013-20230627
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r052-20230627
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc64-defconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- riscv-allmodconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- riscv-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- sh-allmodconfig
|   |-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|   |-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
|   `-- standard-input:Error:pcrel-too-far
|-- sh-j2_defconfig
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|-- sh-randconfig-r015-20230627
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|-- sh-rsk7203_defconfig
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
`-- x86_64-buildonly-randconfig-r001-20230627
    `-- drivers-gpu-drm-i915-soc-intel_gmch.c:warning:variable-mchbar_addr-set-but-not-used
clang_recent_errors
|-- arm-randconfig-r031-20230627
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r041-20230627
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- powerpc-randconfig-r023-20230627
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- riscv-randconfig-r042-20230627
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
`-- x86_64-randconfig-r011-20230627
    `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void

elapsed time: 725m

configs tested: 137
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230627   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230627   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r031-20230627   clang
arm                  randconfig-r035-20230627   clang
arm                  randconfig-r046-20230627   gcc  
arm                       spear13xx_defconfig   clang
arm                       versatile_defconfig   clang
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230627   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230627   clang
hexagon              randconfig-r045-20230627   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230627   gcc  
i386         buildonly-randconfig-r005-20230627   gcc  
i386         buildonly-randconfig-r006-20230627   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230627   gcc  
i386                 randconfig-i002-20230627   gcc  
i386                 randconfig-i003-20230627   gcc  
i386                 randconfig-i004-20230627   gcc  
i386                 randconfig-i005-20230627   gcc  
i386                 randconfig-i006-20230627   gcc  
i386                 randconfig-i011-20230627   clang
i386                 randconfig-i012-20230627   clang
i386                 randconfig-i013-20230627   clang
i386                 randconfig-i014-20230627   clang
i386                 randconfig-i015-20230627   clang
i386                 randconfig-i016-20230627   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r024-20230627   gcc  
loongarch            randconfig-r032-20230627   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           mtx1_defconfig   clang
mips                 randconfig-r022-20230627   gcc  
mips                           xway_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230627   gcc  
nios2                randconfig-r026-20230627   gcc  
openrisc             randconfig-r005-20230627   gcc  
openrisc             randconfig-r016-20230627   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230627   gcc  
parisc               randconfig-r013-20230627   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                    mvme5100_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r023-20230627   clang
powerpc                     tqm8540_defconfig   clang
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230627   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230627   clang
s390                 randconfig-r044-20230627   clang
sh                               allmodconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r015-20230627   gcc  
sh                          rsk7203_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r001-20230627   gcc  
sparc64              randconfig-r025-20230627   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230627   gcc  
x86_64       buildonly-randconfig-r002-20230627   gcc  
x86_64       buildonly-randconfig-r003-20230627   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r011-20230627   clang
x86_64               randconfig-x001-20230627   clang
x86_64               randconfig-x002-20230627   clang
x86_64               randconfig-x003-20230627   clang
x86_64               randconfig-x004-20230627   clang
x86_64               randconfig-x005-20230627   clang
x86_64               randconfig-x006-20230627   clang
x86_64               randconfig-x011-20230627   gcc  
x86_64               randconfig-x012-20230627   gcc  
x86_64               randconfig-x013-20230627   gcc  
x86_64               randconfig-x014-20230627   gcc  
x86_64               randconfig-x015-20230627   gcc  
x86_64               randconfig-x016-20230627   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa               randconfig-r002-20230627   gcc  
xtensa               randconfig-r006-20230627   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
