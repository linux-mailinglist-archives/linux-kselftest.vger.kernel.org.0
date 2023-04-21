Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62336EB25F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjDUTnc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjDUTnb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 15:43:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB4198B;
        Fri, 21 Apr 2023 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682106210; x=1713642210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j/aCznEbmzY6CPJfpDgAnembGflLWzYVe2uqfonw5qE=;
  b=bBu9kFSG4MUTd41ZNewf4Bunotdt1cJe7TqkiHht4O3SWolQsfKdSn0r
   V0+4Vcl3rJBWbpeh+vorSkopT2JNMlYgQy399Fo0hlDAJWV3bMf+sDX5j
   7k/XGVtOXhulcUEYXwutfAVHJqDZcT7t/W4YaK5Waq83Vry9doFzTVlV3
   zTmZPbxXy/MmfFc9kbrmEJPq1Cqb+oLCRw3rvA+OlvyngRq96UUp5BkuR
   qDA6SCsdZUXjIaU7BBJua2OdDXfAZzYqxiIX78+kLb+u2zqzDVfQEwz0k
   wzTsB29Mt7OypmLj1Ikzo3soUC2TszL2nEz5az1T0kC62r+sZi+cMkHrJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348861991"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348861991"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 12:43:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="866795075"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="866795075"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2023 12:43:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppwfB-000gla-0k;
        Fri, 21 Apr 2023 19:43:21 +0000
Date:   Sat, 22 Apr 2023 03:43:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vipin Sharma <vipinsh@google.com>, maz@kernel.org,
        oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de,
        anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, pbonzini@redhat.com,
        dmatlack@google.com, ricarkol@google.com
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH 7/9] KVM: mmu: Move mmu lock/unlock to arch code for
 clear dirty log
Message-ID: <202304220315.bpwbgH5n-lkp@intel.com>
References: <20230421165305.804301-8-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421165305.804301-8-vipinsh@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Vipin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 95b9779c1758f03cf494e8550d6249a40089ed1c]

url:    https://github.com/intel-lab-lkp/linux/commits/Vipin-Sharma/KVM-selftests-Allow-dirty_log_perf_test-to-clear-dirty-memory-in-chunks/20230422-005708
base:   95b9779c1758f03cf494e8550d6249a40089ed1c
patch link:    https://lore.kernel.org/r/20230421165305.804301-8-vipinsh%40google.com
patch subject: [PATCH 7/9] KVM: mmu: Move mmu lock/unlock to arch code for clear dirty log
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20230422/202304220315.bpwbgH5n-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e7505b53d53e3bb5e7f1c43233ef3644673edb75
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vipin-Sharma/KVM-selftests-Allow-dirty_log_perf_test-to-clear-dirty-memory-in-chunks/20230422-005708
        git checkout e7505b53d53e3bb5e7f1c43233ef3644673edb75
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kvm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304220315.bpwbgH5n-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/riscv/kvm/mmu.c: In function 'kvm_arch_mmu_enable_log_dirty_pt_masked':
>> arch/riscv/kvm/mmu.c:399:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     399 |         phys_addr_t base_gfn = slot->base_gfn + gfn_offset;
         |         ^~~~~~~~~~~


vim +399 arch/riscv/kvm/mmu.c

c9d57373fc87a3 Anup Patel   2022-07-29  392  
9d05c1fee83757 Anup Patel   2021-09-27  393  void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
9d05c1fee83757 Anup Patel   2021-09-27  394  					     struct kvm_memory_slot *slot,
9d05c1fee83757 Anup Patel   2021-09-27  395  					     gfn_t gfn_offset,
9d05c1fee83757 Anup Patel   2021-09-27  396  					     unsigned long mask)
9d05c1fee83757 Anup Patel   2021-09-27  397  {
e7505b53d53e3b Vipin Sharma 2023-04-21  398  	spin_lock(&kvm->mmu_lock);
9d05c1fee83757 Anup Patel   2021-09-27 @399  	phys_addr_t base_gfn = slot->base_gfn + gfn_offset;
9d05c1fee83757 Anup Patel   2021-09-27  400  	phys_addr_t start = (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
9d05c1fee83757 Anup Patel   2021-09-27  401  	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
9d05c1fee83757 Anup Patel   2021-09-27  402  
26708234eb12e7 Anup Patel   2022-05-09  403  	gstage_wp_range(kvm, start, end);
e7505b53d53e3b Vipin Sharma 2023-04-21  404  	spin_unlock(&kvm->mmu_lock);
9d05c1fee83757 Anup Patel   2021-09-27  405  }
99cdc6c18c2d81 Anup Patel   2021-09-27  406  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
