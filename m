Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177BF750D34
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjGLPzQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 11:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGLPzM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 11:55:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9610A2;
        Wed, 12 Jul 2023 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689177311; x=1720713311;
  h=date:from:to:cc:subject:message-id;
  bh=aeg5HCRgPYDSE0YNO6fC7Ggphbri8o6L/nfZbG5eYwY=;
  b=ChlPUDv7rYDu/obaUP2jZIQ7e0hh7pK/Z0wbKIUdzvmdiUT7JP00AQ6C
   yObecEx41IPmjrx9tOGLAAJPrwAXxRsrauDF/fzd42TxeAy77GuINs2L7
   D+2RrokF8Clqujep6/dotjSn/qnaGfbJXRATVPwyDYHvPltcyN55lH1R6
   fjcA6bIntsJB5o04Wi6JCojXz3Gqz7jGsR7Ul9G5Hpd0GWVFD4S6eaUBO
   TQde/+yCNdfgkoV/1dkB1j5l0AcFF6UPfHvjj35fYRmFP8Ecdb7wMnhdM
   hcA/ebGYSgCx0v6Uvunr2ux9lFgZ63TqltmbDPdcffLx9AlBtZjtODxo6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428664142"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="428664142"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="698908470"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="698908470"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2023 08:54:58 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJcB7-0005nL-2z;
        Wed, 12 Jul 2023 15:54:57 +0000
Date:   Wed, 12 Jul 2023 23:54:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        bpf@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 40b055fe7f276cf2c1da47316c52f2ff9255a68a
Message-ID: <202307122332.FSootrdK-lkp@intel.com>
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
branch HEAD: 40b055fe7f276cf2c1da47316c52f2ff9255a68a  Add linux-next specific files for 20230712

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306122223.HHER4zOo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306210212.N0BipYQd-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/parisc/kernel/pdt.c:67:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
kernel/bpf/verifier.c:3959:12: warning: stack frame size (2064) exceeds limit (2048) in '__mark_chain_precision' [-Wframe-larger-than]
lib/kunit/executor_test.c:138:4: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
lib/kunit/test.c:775:38: warning: cast from 'void (*)(const void *)' to 'kunit_action_t *' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:98 mlx5_devcom_register_device() error: uninitialized symbol 'tmp_dev'.
kernel/trace/trace_functions_graph.c:1012 print_graph_return() warn: bitwise AND condition is false here
kernel/trace/trace_functions_graph.c:726 print_graph_entry_leaf() warn: bitwise AND condition is false here
net/wireless/scan.c:373 cfg80211_gen_new_ie() warn: potential spectre issue 'sub->data' [r]
net/wireless/scan.c:397 cfg80211_gen_new_ie() warn: possible spectre second half.  'ext_id'
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- microblaze-randconfig-m041-20230710
|   |-- drivers-net-ethernet-mellanox-mlx5-core-lib-devcom.c-mlx5_devcom_register_device()-error:uninitialized-symbol-tmp_dev-.
|   |-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:possible-spectre-second-half.-ext_id
|   `-- net-wireless-scan.c-cfg80211_gen_new_ie()-warn:potential-spectre-issue-sub-data-r
|-- mips-randconfig-m031-20230710
|   |-- kernel-trace-trace_functions_graph.c-print_graph_entry_leaf()-warn:bitwise-AND-condition-is-false-here
|   `-- kernel-trace-trace_functions_graph.c-print_graph_return()-warn:bitwise-AND-condition-is-false-here
|-- parisc-randconfig-r082-20230710
|   `-- arch-parisc-kernel-pdt.c:warning:no-previous-prototype-for-arch_report_meminfo
`-- sh-allmodconfig
    `-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
clang_recent_errors
|-- hexagon-randconfig-r013-20230712
|   |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|   `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
|-- riscv-randconfig-r023-20230712
|   `-- kernel-bpf-verifier.c:warning:stack-frame-size-()-exceeds-limit-()-in-__mark_chain_precision
`-- s390-randconfig-r044-20230712
    |-- lib-kunit-executor_test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type
    `-- lib-kunit-test.c:warning:cast-from-void-(-)(const-void-)-to-kunit_action_t-(aka-void-(-)(void-)-)-converts-to-incompatible-function-type

elapsed time: 798m

configs tested: 123
configs skipped: 8

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230712   gcc  
alpha                randconfig-r015-20230712   gcc  
alpha                randconfig-r025-20230712   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r043-20230712   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                  randconfig-r046-20230712   gcc  
arm                             rpc_defconfig   gcc  
arm                       spear13xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r034-20230712   gcc  
hexagon              randconfig-r013-20230712   clang
hexagon              randconfig-r035-20230712   clang
hexagon              randconfig-r041-20230712   clang
hexagon              randconfig-r045-20230712   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230712   gcc  
i386         buildonly-randconfig-r005-20230712   gcc  
i386         buildonly-randconfig-r006-20230712   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230712   gcc  
i386                 randconfig-i002-20230712   gcc  
i386                 randconfig-i003-20230712   gcc  
i386                 randconfig-i004-20230712   gcc  
i386                 randconfig-i005-20230712   gcc  
i386                 randconfig-i006-20230712   gcc  
i386                 randconfig-i011-20230712   clang
i386                 randconfig-i012-20230712   clang
i386                 randconfig-i013-20230712   clang
i386                 randconfig-i014-20230712   clang
i386                 randconfig-i015-20230712   clang
i386                 randconfig-i016-20230712   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r021-20230712   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r031-20230712   clang
mips                 randconfig-r032-20230712   clang
nios2                            alldefconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230712   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r036-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230712   clang
riscv                randconfig-r042-20230712   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230712   clang
sh                               allmodconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                   randconfig-r033-20230712   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64              randconfig-r011-20230712   gcc  
sparc64              randconfig-r014-20230712   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r012-20230712   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230712   gcc  
x86_64       buildonly-randconfig-r002-20230712   gcc  
x86_64       buildonly-randconfig-r003-20230712   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r026-20230712   clang
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230712   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r006-20230712   gcc  
xtensa               randconfig-r016-20230712   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
