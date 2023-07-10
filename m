Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA8E74D8E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 16:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjGJOXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjGJOXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 10:23:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1908E;
        Mon, 10 Jul 2023 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688999002; x=1720535002;
  h=date:from:to:cc:subject:message-id;
  bh=4Jumx6nxrCWGdjFiyUIxNFOqMEbIpj6jCs+e+jNHm5Y=;
  b=ZIeNqBlxb1xfkdU4q5xV1RfVl3gOSRgpNrI2zHHozxm1AREqM4rD6Y/x
   vRy/Q3eTa6x8V314ndUvlBbx+vy10XDkml8P3droPIKaQ3WWn6LiBIrgv
   406OmNybUzf6Yui8aE1+cn96WBaZfvNgtO7TYGv+Nsnc12/DES0Nzn/66
   w0pdpV919fItlftrcjbgr10IxT+7RHo1ecI78XO21xe6YR0pw4PJmYrfB
   T6Vl2jsIGy9VJVXanLebVWKDu73zLuyGxXGlhMn//BlT0lW11Gd4dF4fz
   nCMBJIJh8XHWMe5vZuclBx7ls8eYJ+5cBeSyWu9fvbFHaf95Par3EzvgY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="367849857"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="367849857"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="790813939"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="790813939"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2023 07:23:18 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qIrnJ-0003kO-0w;
        Mon, 10 Jul 2023 14:23:17 +0000
Date:   Mon, 10 Jul 2023 22:23:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        intel-gfx@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 fe57d0d86f03a8b2afe2869a95477d0ed1824c96
Message-ID: <202307102208.Lh6ryqCu-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: fe57d0d86f03a8b2afe2869a95477d0ed1824c96  Add linux-next specific files for 20230710

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306122223.HHER4zOo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306141719.MJHClSrC-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306291857.nyJjYwqk-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/parisc/kernel/pdt.c:67:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
drivers/gpu/drm/i915/soc/intel_gmch.c:41:13: error: variable 'mchbar_addr' set but not used [-Werror=unused-but-set-variable]
lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
lib/kunit/test.c:775:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:98 mlx5_devcom_register_device() error: uninitialized symbol 'tmp_dev'.
net/wireless/scan.c:373 cfg80211_gen_new_ie() warn: potential spectre issue 'sub->data' [r]
net/wireless/scan.c:397 cfg80211_gen_new_ie() warn: possible spectre second half.  'ext_id'
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-buildonly-randconfig-r006-20230710
|   `-- drivers-gpu-drm-i915-soc-intel_gmch.c:error:variable-mchbar_addr-set-but-not-used
|-- parisc-randconfig-r004-20230710
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r024-20230710
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r031-20230710
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- riscv-randconfig-r071-20230710
|   |-- arch-riscv-kernel-signal.c:sparse:sparse:incorrect-type-in-assignment-(different-address-spaces)-expected-void-noderef-__user-datap-got-void
|   `-- arch-riscv-kernel-signal.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-void-__x-got-void-noderef-__user-assigned-datap
|-- sh-allmodconfig
|   `-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
`-- x86_64-randconfig-m001-20230710
    |-- drivers-net-ethernet-mellanox-mlx5-core-lib-devcom.c-mlx5_devcom_register_device()-error:uninitialized-symbol-tmp_dev-.
    |-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:possible-spectre-second-half.-ext_id
    `-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:potential-spectre-issue-sub-data-r
clang_recent_errors
|-- hexagon-randconfig-r041-20230710
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r045-20230710
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
`-- riscv-randconfig-r042-20230710
    |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
    `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type

elapsed time: 725m

configs tested: 133
configs skipped: 5

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230710   gcc  
alpha                randconfig-r016-20230710   gcc  
alpha                randconfig-r021-20230710   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r002-20230710   gcc  
arc                  randconfig-r011-20230710   gcc  
arc                  randconfig-r035-20230710   gcc  
arc                  randconfig-r043-20230710   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                       multi_v4t_defconfig   gcc  
arm                          pxa3xx_defconfig   gcc  
arm                  randconfig-r025-20230710   gcc  
arm                  randconfig-r046-20230710   gcc  
arm                         socfpga_defconfig   clang
arm                       spear13xx_defconfig   clang
arm                    vt8500_v6_v7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230710   gcc  
arm64                randconfig-r035-20230710   gcc  
arm64                randconfig-r036-20230710   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230710   gcc  
csky                 randconfig-r034-20230710   gcc  
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r045-20230710   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230710   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i006-20230710   gcc  
i386                 randconfig-i011-20230710   clang
i386                 randconfig-i012-20230710   clang
i386                 randconfig-i013-20230710   clang
i386                 randconfig-i014-20230710   clang
i386                 randconfig-i015-20230710   clang
i386                 randconfig-i016-20230710   clang
i386                 randconfig-r036-20230710   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230710   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                 randconfig-r033-20230710   gcc  
microblaze           randconfig-r026-20230710   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                          malta_defconfig   clang
mips                        maltaup_defconfig   clang
mips                        vocore2_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230710   gcc  
parisc               randconfig-r024-20230710   gcc  
parisc               randconfig-r031-20230710   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                        icon_defconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     kilauea_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc              randconfig-r032-20230710   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r031-20230710   gcc  
riscv                randconfig-r042-20230710   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230710   clang
sh                               allmodconfig   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r023-20230710   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r012-20230710   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230710   clang
um                   randconfig-r033-20230710   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r013-20230710   clang
x86_64               randconfig-r032-20230710   gcc  
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x016-20230710   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r035-20230710   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
