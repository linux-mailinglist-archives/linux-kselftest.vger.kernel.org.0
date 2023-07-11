Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A774F27D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGKOmL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjGKOmK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 10:42:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4FE54;
        Tue, 11 Jul 2023 07:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689086528; x=1720622528;
  h=date:from:to:cc:subject:message-id;
  bh=Z9jiyaePgsMbmdrujTSUssRF+Y0zC6OSwoYNX9z5U+4=;
  b=ULRUMqdS6SLpldW6jBJUx4j8newgen60zLTqNtAv7agDfNIsTlpFAJYm
   pJhhGP4Kyo7FhLxYQfNonEfUFZBn4NZU4TFxr6YXGHO5QgDsqSMzdx2df
   BPjaNSzBT/0p8jllmf4Zamj6HgAFvcw9+/DRTI5dwx6fdINJZ8qscm/hT
   2bRES0Zm5oyvg52HrDMDVZtUEZ/m2v7A7WoBiD01JoLLFj0lMQtNmI8eE
   J8xupYqc99Yh2oVVG14hHZB9+wVAcuwHAMNfaOA5AAK3vruBf3LcgiuxJ
   zNc54OTlep3GS2A7jI1v+q46073ZcKOJFCRrZU0rUcHy4CK4wFWYUbeBh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430724303"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="430724303"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:42:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="671396922"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="671396922"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2023 07:42:05 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJEZ2-0004rl-0K;
        Tue, 11 Jul 2023 14:42:04 +0000
Date:   Tue, 11 Jul 2023 22:41:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 8e4b7f2f3d6071665b1dfd70786229c8a5d6c256
Message-ID: <202307112207.TIrHLxRW-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 8e4b7f2f3d6071665b1dfd70786229c8a5d6c256  Add linux-next specific files for 20230711

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306122223.HHER4zOo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306260401.qZlYQpV2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307111309.401QvMTN-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/parisc/kernel/pdt.c:67:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
arch/s390/include/asm/io.h:29:17: error: implicit declaration of function 'iounmap'; did you mean 'vunmap'? [-Werror=implicit-function-declaration]
drivers/mfd/max77541.c:176:18: warning: cast to smaller integer type 'enum max7754x_ids' from 'const void *' [-Wvoid-pointer-to-enum-cast]
drivers/net/arcnet/arc-rimi.c:107:13: error: implicit declaration of function 'ioremap'; did you mean 'ifr_map'? [-Werror=implicit-function-declaration]
drivers/net/arcnet/com90xx.c:225:24: error: implicit declaration of function 'ioremap'; did you mean 'ifr_map'? [-Werror=implicit-function-declaration]
drivers/net/ethernet/8390/pcnet_cs.c:290:12: error: implicit declaration of function 'ioremap'; did you mean 'ifr_map'? [-Werror=implicit-function-declaration]
drivers/net/ethernet/fujitsu/fmvj18x_cs.c:549:12: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
drivers/net/ethernet/smsc/smc91c92_cs.c:447:17: error: implicit declaration of function 'ioremap'; did you mean 'ifr_map'? [-Werror=implicit-function-declaration]
drivers/net/ethernet/xircom/xirc2ps_cs.c:843:28: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
drivers/pcmcia/cistpl.c:103:31: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
drivers/tty/ipwireless/main.c:115:30: error: implicit declaration of function 'ioremap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
lib/kunit/test.c:775:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/clk/imx/clk-imx93.c:294 imx93_clocks_probe() error: uninitialized symbol 'base'.
drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:98 mlx5_devcom_register_device() error: uninitialized symbol 'tmp_dev'.
net/wireless/scan.c:373 cfg80211_gen_new_ie() warn: potential spectre issue 'sub->data' [r]
net/wireless/scan.c:397 cfg80211_gen_new_ie() warn: possible spectre second half.  'ext_id'
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-m041-20230710
|   `-- drivers-clk-imx-clk-imx93.c-imx93_clocks_probe()-error:uninitialized-symbol-base-.
|-- parisc-randconfig-r083-20230710
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- s390-allmodconfig
|   |-- arch-s390-include-asm-io.h:error:implicit-declaration-of-function-iounmap
|   |-- drivers-net-arcnet-arc-rimi.c:error:implicit-declaration-of-function-ioremap
|   |-- drivers-net-arcnet-com9x.c:error:implicit-declaration-of-function-ioremap
|   |-- drivers-net-ethernet-fujitsu-fmvj18x_cs.c:error:implicit-declaration-of-function-ioremap
|   |-- drivers-net-ethernet-pcnet_cs.c:error:implicit-declaration-of-function-ioremap
|   |-- drivers-net-ethernet-smsc-smc91c92_cs.c:error:implicit-declaration-of-function-ioremap
|   |-- drivers-net-ethernet-xircom-xirc2ps_cs.c:error:implicit-declaration-of-function-ioremap
|   |-- drivers-pcmcia-cistpl.c:error:implicit-declaration-of-function-ioremap
|   `-- drivers-tty-ipwireless-main.c:error:implicit-declaration-of-function-ioremap
|-- sh-allmodconfig
|   `-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
`-- x86_64-randconfig-m001-20230710
    |-- drivers-net-ethernet-mellanox-mlx5-core-lib-devcom.c-mlx5_devcom_register_device()-error:uninitialized-symbol-tmp_dev-.
    |-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:possible-spectre-second-half.-ext_id
    `-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:potential-spectre-issue-sub-data-r
clang_recent_errors
|-- arm-randconfig-r001-20230710
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- arm64-randconfig-r013-20230710
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- arm64-randconfig-r024-20230710
|   |-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r041-20230710
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r045-20230710
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- riscv-randconfig-r042-20230710
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
`-- x86_64-buildonly-randconfig-r002-20230711
    `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void

elapsed time: 720m

configs tested: 140
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230710   gcc  
alpha                randconfig-r005-20230710   gcc  
alpha                randconfig-r034-20230710   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230710   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                         lpc18xx_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                  randconfig-r001-20230710   clang
arm                  randconfig-r026-20230710   gcc  
arm                  randconfig-r046-20230710   gcc  
arm                           sama5_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm                           stm32_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230710   clang
arm64                randconfig-r024-20230710   clang
csky                                defconfig   gcc  
csky                 randconfig-r006-20230710   gcc  
csky                 randconfig-r016-20230710   gcc  
csky                 randconfig-r036-20230710   gcc  
hexagon                             defconfig   clang
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r045-20230710   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230711   clang
i386         buildonly-randconfig-r005-20230711   clang
i386         buildonly-randconfig-r006-20230711   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230710   gcc  
i386                 randconfig-i002-20230710   gcc  
i386                 randconfig-i003-20230710   gcc  
i386                 randconfig-i004-20230710   gcc  
i386                 randconfig-i005-20230710   gcc  
i386                 randconfig-i006-20230710   gcc  
i386                 randconfig-i011-20230710   clang
i386                 randconfig-i012-20230710   clang
i386                 randconfig-i013-20230710   clang
i386                 randconfig-i014-20230710   clang
i386                 randconfig-i015-20230710   clang
i386                 randconfig-i016-20230710   clang
i386                 randconfig-r011-20230710   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r021-20230710   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                        maltaup_defconfig   clang
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230710   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc                       ppc64_defconfig   gcc  
powerpc              randconfig-r035-20230710   gcc  
powerpc                     tqm8560_defconfig   clang
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230710   gcc  
riscv                randconfig-r031-20230710   gcc  
riscv                randconfig-r032-20230710   gcc  
riscv                randconfig-r042-20230710   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230710   clang
sh                               allmodconfig   gcc  
sh                               j2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r022-20230710   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r023-20230710   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230711   clang
x86_64       buildonly-randconfig-r002-20230711   clang
x86_64       buildonly-randconfig-r003-20230711   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r025-20230710   clang
x86_64               randconfig-r033-20230710   gcc  
x86_64               randconfig-x001-20230710   clang
x86_64               randconfig-x002-20230710   clang
x86_64               randconfig-x003-20230710   clang
x86_64               randconfig-x004-20230710   clang
x86_64               randconfig-x005-20230710   clang
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x011-20230710   gcc  
x86_64               randconfig-x012-20230710   gcc  
x86_64               randconfig-x013-20230710   gcc  
x86_64               randconfig-x014-20230710   gcc  
x86_64               randconfig-x015-20230710   gcc  
x86_64               randconfig-x016-20230710   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r012-20230710   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
