Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1206B7488E2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 18:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjGEQIt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGEQIr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 12:08:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AED112A;
        Wed,  5 Jul 2023 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688573326; x=1720109326;
  h=date:from:to:cc:subject:message-id;
  bh=xKhVmKHnF1tZ/nQOsvw0DFwNyW4SSJnj5G7sLZBwAY8=;
  b=Caot2TkJWlacmPA1rC/KRRT3YQJThLqEEeyw0vvrH7ZdSNV0m0JhQdkd
   VaxrPIjS7OOWX0FsWSBaiKYytQpKPXlvbYHIaf4t7Q8/6helgT4n1gzmJ
   W7tIWjw2aUevKmi7Uq2AkwZrDdhUFTftIRvsu8VCAmgGEJrt8M3GeuFlO
   29rMYjb1CKK959qdr4UoD8GP/uOwmRgDPTz87Qg8F7jD9eRikfMFMqW8a
   jI56hNL6TS1UuH6KLRtMNqGjwNLRW+jljoF2LlpU9MfNUMpzbhgXvEfEE
   KtQTWxkeY3Pl7hoEzb7xiRK4I+zJVVSGaKdDY8IN9Mle8B6Ay4bAUtG+3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="449747158"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="449747158"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 09:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="832600455"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="832600455"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2023 09:08:01 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qH52u-0000iI-1h;
        Wed, 05 Jul 2023 16:08:00 +0000
Date:   Thu, 06 Jul 2023 00:07:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        intel-gfx@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-bluetooth@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 e1f6a8eaf1c271a0158114a03e3605f4fba059ad
Message-ID: <202307060015.uSSLonkv-lkp@intel.com>
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
branch HEAD: e1f6a8eaf1c271a0158114a03e3605f4fba059ad  Add linux-next specific files for 20230705

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306122223.HHER4zOo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306260401.qZlYQpV2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306291857.nyJjYwqk-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306301756.x8dgyYnL-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/parisc/kernel/pdt.c:67:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
arch/riscv/kernel/crash_core.c:12:57: warning: format specifies type 'unsigned long' but the argument has type 'int' [-Wformat]
arch/riscv/kernel/crash_core.c:14:57: error: use of undeclared identifier 'VMEMMAP_START'
arch/riscv/kernel/crash_core.c:15:55: error: use of undeclared identifier 'VMEMMAP_END'; did you mean 'MEMREMAP_ENC'?
arch/riscv/kernel/crash_core.c:8:20: error: use of undeclared identifier 'VA_BITS'
drivers/bluetooth/btmtk.c:386:44: error: 'struct hci_dev' has no member named 'dump'
drivers/char/mem.c:164:25: error: implicit declaration of function 'unxlate_dev_mem_ptr'; did you mean 'xlate_dev_mem_ptr'? [-Werror=implicit-function-declaration]
drivers/gpu/drm/i915/soc/intel_gmch.c:41:13: error: variable 'mchbar_addr' set but not used [-Werror=unused-but-set-variable]
drivers/mfd/max77541.c:176:18: warning: cast to smaller integer type 'enum max7754x_ids' from 'const void *' [-Wvoid-pointer-to-enum-cast]
lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
lib/kunit/test.c:775:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/tty/serial/fsl_lpuart.c:1314 lpuart_timer_func() error: uninitialized symbol 'flags'.
kernel/trace/trace_functions_graph.c:1012 print_graph_return() warn: bitwise AND condition is false here
kernel/trace/trace_functions_graph.c:726 print_graph_entry_leaf() warn: bitwise AND condition is false here
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r026-20230705
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|-- csky-randconfig-m041-20230705
|   `-- drivers-tty-serial-fsl_lpuart.c-lpuart_timer_func()-error:uninitialized-symbol-flags-.
|-- i386-buildonly-randconfig-r004-20230705
|   `-- drivers-gpu-drm-i915-soc-intel_gmch.c:error:variable-mchbar_addr-set-but-not-used
|-- i386-randconfig-m021-20230705
|   |-- kernel-trace-trace_functions_graph.c-print_graph_entry_leaf()-warn:bitwise-AND-condition-is-false-here
|   `-- kernel-trace-trace_functions_graph.c-print_graph_return()-warn:bitwise-AND-condition-is-false-here
|-- loongarch-randconfig-r091-20230703
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|-- microblaze-randconfig-r001-20230705
|   `-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
|-- parisc-randconfig-r081-20230703
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- sh-allmodconfig
|   |-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
|   `-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
`-- sh-randconfig-r004-20230705
    |-- drivers-bluetooth-btmtk.c:error:struct-hci_dev-has-no-member-named-dump
    `-- drivers-char-mem.c:error:implicit-declaration-of-function-unxlate_dev_mem_ptr
clang_recent_errors
|-- arm64-randconfig-r023-20230705
|   |-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- arm64-randconfig-r024-20230705
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- powerpc-randconfig-r011-20230705
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- powerpc-randconfig-r025-20230705
|   `-- clang:error:unsupported-option-fsanitize-thread-for-target-powerpc-unknown-linux-gnu
|-- riscv-randconfig-r042-20230705
|   |-- arch-riscv-kernel-crash_core.c:error:use-of-undeclared-identifier-VA_BITS
|   |-- arch-riscv-kernel-crash_core.c:error:use-of-undeclared-identifier-VMEMMAP_END
|   |-- arch-riscv-kernel-crash_core.c:error:use-of-undeclared-identifier-VMEMMAP_START
|   |-- arch-riscv-kernel-crash_core.c:warning:format-specifies-type-unsigned-long-but-the-argument-has-type-int
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- s390-randconfig-r014-20230705
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- s390-randconfig-r021-20230705
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|-- x86_64-randconfig-r024-20230705
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|-- x86_64-randconfig-x002-20230705
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|-- x86_64-randconfig-x003-20230705
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
`-- x86_64-randconfig-x005-20230705
    `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void

elapsed time: 734m

configs tested: 142
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230705   gcc  
alpha                randconfig-r036-20230705   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r011-20230705   gcc  
arc                  randconfig-r026-20230705   gcc  
arc                  randconfig-r043-20230705   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                          gemini_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r046-20230705   gcc  
arm                          sp7021_defconfig   clang
arm                         wpcm450_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230705   clang
arm64                randconfig-r024-20230705   clang
arm64                randconfig-r035-20230705   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230705   clang
hexagon              randconfig-r045-20230705   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230705   gcc  
i386         buildonly-randconfig-r005-20230705   gcc  
i386         buildonly-randconfig-r006-20230705   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230705   gcc  
i386                 randconfig-i002-20230705   gcc  
i386                 randconfig-i003-20230705   gcc  
i386                 randconfig-i004-20230705   gcc  
i386                 randconfig-i005-20230705   gcc  
i386                 randconfig-i006-20230705   gcc  
i386                 randconfig-i011-20230705   clang
i386                 randconfig-i012-20230705   clang
i386                 randconfig-i013-20230705   clang
i386                 randconfig-i014-20230705   clang
i386                 randconfig-i015-20230705   clang
i386                 randconfig-i016-20230705   clang
i386                 randconfig-r015-20230705   clang
i386                 randconfig-r031-20230705   gcc  
i386                 randconfig-r032-20230705   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230705   gcc  
loongarch            randconfig-r012-20230705   gcc  
loongarch            randconfig-r014-20230705   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                 randconfig-r033-20230705   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze           randconfig-r001-20230705   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                           jazz_defconfig   gcc  
mips                 randconfig-r005-20230705   clang
nios2                               defconfig   gcc  
nios2                randconfig-r021-20230705   gcc  
openrisc             randconfig-r022-20230705   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc                    mvme5100_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r011-20230705   clang
powerpc              randconfig-r025-20230705   clang
powerpc                     taishan_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r042-20230705   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230705   clang
s390                 randconfig-r021-20230705   clang
s390                 randconfig-r044-20230705   clang
sh                               allmodconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r004-20230705   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230705   gcc  
sparc64              randconfig-r012-20230705   gcc  
sparc64              randconfig-r015-20230705   gcc  
sparc64              randconfig-r026-20230705   gcc  
sparc64              randconfig-r034-20230705   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r016-20230705   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230705   gcc  
x86_64       buildonly-randconfig-r002-20230705   gcc  
x86_64       buildonly-randconfig-r003-20230705   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r024-20230705   clang
x86_64               randconfig-x001-20230705   clang
x86_64               randconfig-x002-20230705   clang
x86_64               randconfig-x003-20230705   clang
x86_64               randconfig-x004-20230705   clang
x86_64               randconfig-x005-20230705   clang
x86_64               randconfig-x006-20230705   clang
x86_64               randconfig-x011-20230705   gcc  
x86_64               randconfig-x012-20230705   gcc  
x86_64               randconfig-x013-20230705   gcc  
x86_64               randconfig-x014-20230705   gcc  
x86_64               randconfig-x015-20230705   gcc  
x86_64               randconfig-x016-20230705   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230705   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
