Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41173F054
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 03:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjF0BXs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 21:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjF0BXr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 21:23:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2887C199;
        Mon, 26 Jun 2023 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687829026; x=1719365026;
  h=date:from:to:cc:subject:message-id;
  bh=M8nCIoe7kTxc9Ig5mKDgF4P2+mZfoLv6sPtI8q067os=;
  b=Mj2JKeGpEYfFHnc0zKSBn3TcLOYyAolPO7oICtJAhC8EtpjQT2nka8d+
   tPSN3gDCG5tlIB75WutDYd+7cH6GlTYVD514/hzCjdD/4etp3GYhhGWK4
   MxxKOrbs6TRzV8RrI3gb7GN5FSfJrCclvyJuoMqYgWsQ2YloCcSKkAEoL
   B9kEonptm9hskMYbRZyb3dE2CGsU2vstYhW3CMnGBM1fktp4lnxn8phDD
   Kc9XlEygThoY/VSjBZUtL2H7qSau14uwOc8bMDO2o20kAZGAabR2pcfTM
   o2kJLJXnV9dkWHfNGyGZRMUQs4soZFKBqZGZLlr32hIpYrpUoac6rsWTr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="360303199"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="360303199"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="746028807"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="746028807"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2023 18:23:42 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDxQj-000BQX-3C;
        Tue, 27 Jun 2023 01:23:41 +0000
Date:   Tue, 27 Jun 2023 09:22:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        intel-gfx@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 60e7c4a25da68cd826719b685babbd23e73b85b0
Message-ID: <202306270937.nbX3swxD-lkp@intel.com>
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
branch HEAD: 60e7c4a25da68cd826719b685babbd23e73b85b0  Add linux-next specific files for 20230626

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306122223.HHER4zOo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306262024.HUr6WfyW-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/parisc/kernel/pdt.c:66:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
drivers/char/mem.c:164:25: error: implicit declaration of function 'unxlate_dev_mem_ptr'; did you mean 'xlate_dev_mem_ptr'? [-Werror=implicit-function-declaration]
drivers/gpu/drm/i915/display/intel_display_power.h:255:70: error: declaration of 'struct seq_file' will not be visible outside of this function [-Werror,-Wvisibility]
drivers/gpu/drm/i915/display/intel_display_power.h:256:70: error: declaration of 'struct seq_file' will not be visible outside of this function [-Werror,-Wvisibility]
lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
lib/kunit/test.c:775:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/usb/cdns3/cdns3-starfive.c:23: warning: expecting prototype for cdns3(). Prototype was for USB_STRAP_HOST() instead
fs/btrfs/volumes.c:6407 btrfs_map_block() error: we previously assumed 'mirror_num_ret' could be null (see line 6244)
lib/kunit/test.c:336 __kunit_abort() warn: ignoring unreachable code.
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined
{standard input}:1097: Error: pcrel too far

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20230625
|   `-- fs-btrfs-volumes.c-btrfs_map_block()-error:we-previously-assumed-mirror_num_ret-could-be-null-(see-line-)
|-- parisc-allyesconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-defconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-generic-64bit_defconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r012-20230626
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r026-20230626
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r053-20230625
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc64-defconfig
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- powerpc-randconfig-m041-20230625
|   `-- lib-kunit-test.c-__kunit_abort()-warn:ignoring-unreachable-code.
|-- riscv-allmodconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- riscv-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- sh-allmodconfig
|   |-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|   |-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
|   `-- standard-input:Error:pcrel-too-far
|-- sh-rsk7201_defconfig
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|-- sh-se7619_defconfig
|   `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
`-- sparc64-randconfig-r053-20230625
    `-- net-bluetooth-hci_conn.c:WARNING-opportunity-for-kmemdup
clang_recent_errors
|-- arm-randconfig-r016-20230626
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r041-20230626
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- i386-randconfig-i004-20230626
|   `-- drivers-gpu-drm-i915-display-intel_display_power.h:error:declaration-of-struct-seq_file-will-not-be-visible-outside-of-this-function-Werror-Wvisibility
|-- um-randconfig-r024-20230626
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
`-- x86_64-randconfig-r004-20230626
    `-- drivers-gpu-drm-i915-display-intel_display_power.h:error:declaration-of-struct-seq_file-will-not-be-visible-outside-of-this-function-Werror-Wvisibility

elapsed time: 1076m

configs tested: 124
configs skipped: 8

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230626   gcc  
alpha                randconfig-r036-20230626   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r023-20230626   gcc  
arc                  randconfig-r043-20230626   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                          ixp4xx_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                       netwinder_defconfig   clang
arm                  randconfig-r003-20230626   gcc  
arm                  randconfig-r006-20230626   gcc  
arm                  randconfig-r016-20230626   clang
arm                  randconfig-r034-20230626   gcc  
arm                  randconfig-r046-20230626   clang
arm                         s5pv210_defconfig   clang
arm                        spear3xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230626   clang
csky                                defconfig   gcc  
csky                 randconfig-r013-20230626   gcc  
hexagon              randconfig-r041-20230626   clang
hexagon              randconfig-r045-20230626   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230626   clang
i386         buildonly-randconfig-r005-20230626   clang
i386         buildonly-randconfig-r006-20230626   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230626   clang
i386                 randconfig-i002-20230626   clang
i386                 randconfig-i003-20230626   clang
i386                 randconfig-i004-20230626   clang
i386                 randconfig-i005-20230626   clang
i386                 randconfig-i006-20230626   clang
i386                 randconfig-i011-20230626   gcc  
i386                 randconfig-i012-20230626   gcc  
i386                 randconfig-i013-20230626   gcc  
i386                 randconfig-i014-20230626   gcc  
i386                 randconfig-i015-20230626   gcc  
i386                 randconfig-i016-20230626   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                 randconfig-r011-20230626   gcc  
m68k                 randconfig-r015-20230626   gcc  
microblaze           randconfig-r005-20230626   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                           ip22_defconfig   clang
mips                     loongson2k_defconfig   clang
mips                          malta_defconfig   clang
mips                malta_qemu_32r6_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                 randconfig-r035-20230626   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230626   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r012-20230626   gcc  
parisc               randconfig-r026-20230626   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r021-20230626   gcc  
powerpc                    socrates_defconfig   clang
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230626   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230626   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r024-20230626   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230626   clang
x86_64       buildonly-randconfig-r002-20230626   clang
x86_64       buildonly-randconfig-r003-20230626   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r022-20230626   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
