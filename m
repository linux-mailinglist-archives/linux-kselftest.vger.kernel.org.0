Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15C5745F92
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGCPMY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGCPMX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 11:12:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192C7EE;
        Mon,  3 Jul 2023 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688397142; x=1719933142;
  h=date:from:to:cc:subject:message-id;
  bh=W0xbU9nEE3TH0xg7aDTg6qtQ4+f5eySxUTOggB2dw2Q=;
  b=H2vXYsE6b3akL4zVRk9lz2eH0gKJaDz2gpWzA0n2f7Pj0M8pg+d+0EsX
   /z0EM0Nj8X4nh5OykhdSnc8S5mxv0/Pl2/JpGJa9UVCZh7HXXvvnb5SEF
   9DW1lsPRXdJSnXHYiXEeoHxpBZzKH/bbA0vPsgZIdQxpmDgSrQOqz/rhf
   eXjXl6mJNim3Pvlb6tiQvmrADQqlAbUaI6HyIlRNTHH7W61zC5EMEYghJ
   EuWh2Fxq9fu7Eb/sx3jy+wPLIImdhSdABD5AiDuJb4ikPCuVAAtj8xTIs
   CYjJGtYVCnoHrJh2Co3Azl1fNl0vA+o1GPKtxDY+w5EFrGkO+6dlD/AfU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="343239953"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="343239953"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 08:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="788557478"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="788557478"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2023 08:12:13 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGLDo-000HR9-2I;
        Mon, 03 Jul 2023 15:12:12 +0000
Date:   Mon, 03 Jul 2023 23:11:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        kunit-dev@googlegroups.com, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 296d53d8f84ce50ffaee7d575487058c8d437335
Message-ID: <202307032309.v4K1IBoR-lkp@intel.com>
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
branch HEAD: 296d53d8f84ce50ffaee7d575487058c8d437335  Add linux-next specific files for 20230703

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306122223.HHER4zOo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306151954.Rsz6HP7h-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306301709.lvrxzyCj-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306301756.x8dgyYnL-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/parisc/kernel/pdt.c:66:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
drivers/bluetooth/btmtk.c:386:32: error: no member named 'dump' in 'struct hci_dev'
drivers/bluetooth/btmtk.c:386:44: error: 'struct hci_dev' has no member named 'dump'
drivers/char/mem.c:164:25: error: implicit declaration of function 'unxlate_dev_mem_ptr'; did you mean 'xlate_dev_mem_ptr'? [-Werror=implicit-function-declaration]
lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
lib/kunit/test.c:775:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

arch/arm64/kvm/mmu.c:147:3-9: preceding lock on line 140
drivers/clk/qcom/gpucc-sm8550.c:37:22: sparse: sparse: decimal constant 2300000000 is between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compilers are very likely to produce unsigned long (and a warning) here
drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:98 mlx5_devcom_register_device() error: uninitialized symbol 'tmp_dev'.
drivers/usb/cdns3/cdns3-starfive.c:23: warning: expecting prototype for cdns3(). Prototype was for USB_STRAP_HOST() instead
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r025-20230703
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|-- arm-randconfig-r073-20230703
|   `-- drivers-clk-qcom-gpucc-sm8550.c:sparse:sparse:decimal-constant-is-between-LONG_MAX-and-ULONG_MAX.-For-C99-that-means-long-long-C90-compilers-are-very-likely-to-produce-unsigned-long-(and-a-warning)-he
|-- arm64-randconfig-r054-20230703
|   `-- arch-arm64-kvm-mmu.c:preceding-lock-on-line
|-- i386-randconfig-m031-20230703
|   `-- drivers-net-ethernet-mellanox-mlx5-core-lib-devcom.c-mlx5_devcom_register_device()-error:uninitialized-symbol-tmp_dev-.
|-- parisc-allnoconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-allyesconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-defconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r011-20230703
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r035-20230703
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc64-defconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- riscv-allmodconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- riscv-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- riscv-randconfig-r091-20230703
|   |-- arch-riscv-kernel-signal.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-void-__val-got-void-noderef-__user-assigned-datap
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|-- sh-allmodconfig
|   |-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|   `-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
|-- sh-randconfig-r015-20230703
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|-- sh-randconfig-r024-20230703
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|-- sh-se7619_defconfig
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
`-- x86_64-buildonly-randconfig-r003-20230703
    `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
clang_recent_errors
|-- arm-randconfig-r005-20230703
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- arm-randconfig-r035-20230703
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- arm64-randconfig-r026-20230703
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r041-20230703
|   |-- drivers-bluetooth-btmtk.c:error:no-member-named-dump-in-struct-hci_dev
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r045-20230703
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
`-- i386-randconfig-i011-20230703
    `-- drivers-bluetooth-btmtk.c:error:no-member-named-dump-in-struct-hci_dev

elapsed time: 747m

configs tested: 136
configs skipped: 5

tested configs:
alpha                            alldefconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230703   gcc  
alpha                randconfig-r025-20230703   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r014-20230703   gcc  
arc                  randconfig-r043-20230703   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                           omap1_defconfig   clang
arm                          pxa168_defconfig   clang
arm                  randconfig-r005-20230703   clang
arm                  randconfig-r035-20230703   clang
arm                  randconfig-r046-20230703   gcc  
arm                         socfpga_defconfig   clang
arm                         wpcm450_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r026-20230703   clang
csky                                defconfig   gcc  
csky                 randconfig-r006-20230703   gcc  
csky                 randconfig-r021-20230703   gcc  
hexagon              randconfig-r041-20230703   clang
hexagon              randconfig-r045-20230703   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230703   gcc  
i386         buildonly-randconfig-r005-20230703   gcc  
i386         buildonly-randconfig-r006-20230703   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230703   gcc  
i386                 randconfig-i002-20230703   gcc  
i386                 randconfig-i003-20230703   gcc  
i386                 randconfig-i004-20230703   gcc  
i386                 randconfig-i005-20230703   gcc  
i386                 randconfig-i006-20230703   gcc  
i386                 randconfig-i011-20230703   clang
i386                 randconfig-i012-20230703   clang
i386                 randconfig-i013-20230703   clang
i386                 randconfig-i014-20230703   clang
i386                 randconfig-i016-20230703   clang
i386                 randconfig-r036-20230703   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230703   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                 randconfig-r023-20230703   gcc  
mips                 randconfig-r031-20230703   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r034-20230703   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230703   gcc  
parisc               randconfig-r035-20230703   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230703   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230703   gcc  
s390                 randconfig-r033-20230703   gcc  
s390                 randconfig-r044-20230703   clang
sh                               allmodconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                   randconfig-r015-20230703   gcc  
sh                   randconfig-r024-20230703   gcc  
sh                   randconfig-r031-20230703   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230703   gcc  
sparc64              randconfig-r001-20230703   gcc  
sparc64              randconfig-r033-20230703   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r034-20230703   clang
um                   randconfig-r036-20230703   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230703   gcc  
x86_64       buildonly-randconfig-r002-20230703   gcc  
x86_64       buildonly-randconfig-r003-20230703   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230703   clang
x86_64               randconfig-x002-20230703   clang
x86_64               randconfig-x003-20230703   clang
x86_64               randconfig-x004-20230703   clang
x86_64               randconfig-x005-20230703   clang
x86_64               randconfig-x006-20230703   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230703   gcc  
xtensa               randconfig-r012-20230703   gcc  
xtensa               randconfig-r032-20230703   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
