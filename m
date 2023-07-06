Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C1F74A0A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 17:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjGFPPi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 11:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGFPPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 11:15:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36302F0;
        Thu,  6 Jul 2023 08:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688656532; x=1720192532;
  h=date:from:to:cc:subject:message-id;
  bh=Lq8HmpsTAzrcaJpCIW19syiVgsp4So4fWlXO7NqQ3f8=;
  b=ehv7UxFb2PsYqtiC3HI2OTdEgdG/MEbt5sdL/fttKytCYyrSNjHrTyQl
   jXRXSOGRn8Fo07/wuG/RRSVPcOlXpMJJjahRkTFOq9ydjV/tCXgvfR9Qh
   QYbB37XEQvGgIzr8zyTCEorTz18OarMiwA5P9FynheVbh0pLcopD2wF6t
   MCQerrWvCAw58sGzBM+2I82yuW+oiWtdhM5EDav2gF3Jsz6i0nOVNCWn2
   Y5vqlnR9sGF8OTd2Is1CPjJWtDpsJb7cEEvfuQA2AuSaMH8Qz+FIyYm/8
   IadFVddDQuxNo7pC3qQyur8ylBuTUgrguVH3R+keIwZC9kzFQAULwxcXT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="366206673"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="366206673"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 08:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="713616991"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="713616991"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2023 08:15:28 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHQhb-0001Oi-1p;
        Thu, 06 Jul 2023 15:15:27 +0000
Date:   Thu, 06 Jul 2023 23:15:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 c36ac601a98fb148147640bae219108ee81566f8
Message-ID: <202307062302.t8Lb7o3O-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: c36ac601a98fb148147640bae219108ee81566f8  Add linux-next specific files for 20230706

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306122223.HHER4zOo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307050034.tAJSN9qy-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/parisc/kernel/pdt.c:67:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
arch/riscv/kernel/crash_core.c:14:64: error: 'VMEMMAP_START' undeclared (first use in this function)
arch/riscv/kernel/crash_core.c:15:62: error: 'VMEMMAP_END' undeclared (first use in this function); did you mean 'MEMREMAP_ENC'?
arch/riscv/kernel/crash_core.c:8:27: error: 'VA_BITS' undeclared (first use in this function)
lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
lib/kunit/test.c:775:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:98 mlx5_devcom_register_device() error: uninitialized symbol 'tmp_dev'.
kernel/trace/trace_functions_graph.c:1012 print_graph_return() warn: bitwise AND condition is false here
kernel/trace/trace_functions_graph.c:726 print_graph_entry_leaf() warn: bitwise AND condition is false here
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20230705
|   |-- kernel-trace-trace_functions_graph.c-print_graph_entry_leaf()-warn:bitwise-AND-condition-is-false-here
|   `-- kernel-trace-trace_functions_graph.c-print_graph_return()-warn:bitwise-AND-condition-is-false-here
|-- parisc-randconfig-r003-20230706
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- parisc-randconfig-r081-20230703
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
|-- riscv-randconfig-r042-20230706
|   |-- arch-riscv-kernel-crash_core.c:error:VA_BITS-undeclared-(first-use-in-this-function)
|   |-- arch-riscv-kernel-crash_core.c:error:VMEMMAP_END-undeclared-(first-use-in-this-function)
|   `-- arch-riscv-kernel-crash_core.c:error:VMEMMAP_START-undeclared-(first-use-in-this-function)
|-- s390-randconfig-m041-20230705
|   `-- drivers-net-ethernet-mellanox-mlx5-core-lib-devcom.c-mlx5_devcom_register_device()-error:uninitialized-symbol-tmp_dev-.
`-- sh-allmodconfig
    `-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
clang_recent_errors
|-- arm64-randconfig-r004-20230706
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- hexagon-randconfig-r041-20230706
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
`-- powerpc-allyesconfig
    `-- clang:error:unsupported-option-fsanitize-thread-for-target-powerpc-unknown-linux-gnu

elapsed time: 735m

configs tested: 144
configs skipped: 8

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230706   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230706   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                      jornada720_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                            mps2_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r046-20230706   clang
arm                         s5pv210_defconfig   clang
arm                        spear3xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230706   clang
arm64                randconfig-r024-20230706   gcc  
csky                                defconfig   gcc  
hexagon                          alldefconfig   clang
hexagon              randconfig-r041-20230706   clang
hexagon              randconfig-r045-20230706   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230706   clang
i386         buildonly-randconfig-r005-20230706   clang
i386         buildonly-randconfig-r006-20230706   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230706   clang
i386                 randconfig-i002-20230706   clang
i386                 randconfig-i003-20230706   clang
i386                 randconfig-i004-20230706   clang
i386                 randconfig-i005-20230706   clang
i386                 randconfig-i006-20230706   clang
i386                 randconfig-i011-20230706   gcc  
i386                 randconfig-i012-20230706   gcc  
i386                 randconfig-i013-20230706   gcc  
i386                 randconfig-i014-20230706   gcc  
i386                 randconfig-i015-20230706   gcc  
i386                 randconfig-i016-20230706   gcc  
i386                 randconfig-r035-20230706   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230706   gcc  
loongarch            randconfig-r025-20230706   gcc  
loongarch            randconfig-r031-20230706   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze           randconfig-r005-20230706   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r015-20230706   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230706   gcc  
parisc               randconfig-r005-20230706   gcc  
parisc               randconfig-r032-20230705   gcc  
parisc               randconfig-r036-20230706   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r013-20230706   gcc  
powerpc              randconfig-r036-20230705   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                      walnut_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230706   clang
riscv                randconfig-r021-20230706   gcc  
riscv                randconfig-r023-20230706   gcc  
riscv                randconfig-r042-20230706   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r031-20230705   gcc  
s390                 randconfig-r044-20230706   gcc  
sh                               allmodconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230706   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64              randconfig-r002-20230706   gcc  
sparc64              randconfig-r035-20230705   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230706   clang
um                   randconfig-r034-20230706   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230706   clang
x86_64       buildonly-randconfig-r002-20230706   clang
x86_64       buildonly-randconfig-r003-20230706   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r026-20230706   gcc  
x86_64               randconfig-r033-20230706   clang
x86_64               randconfig-x001-20230706   gcc  
x86_64               randconfig-x002-20230706   gcc  
x86_64               randconfig-x003-20230706   gcc  
x86_64               randconfig-x004-20230706   gcc  
x86_64               randconfig-x005-20230706   gcc  
x86_64               randconfig-x006-20230706   gcc  
x86_64               randconfig-x011-20230706   clang
x86_64               randconfig-x012-20230706   clang
x86_64               randconfig-x013-20230706   clang
x86_64               randconfig-x014-20230706   clang
x86_64               randconfig-x015-20230706   clang
x86_64               randconfig-x016-20230706   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa               randconfig-r002-20230706   gcc  
xtensa               randconfig-r004-20230706   gcc  
xtensa               randconfig-r022-20230706   gcc  
xtensa               randconfig-r034-20230705   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
