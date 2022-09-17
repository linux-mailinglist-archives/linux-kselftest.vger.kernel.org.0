Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC535BB8FB
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Sep 2022 17:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIQPLJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Sep 2022 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIQPLI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Sep 2022 11:11:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882772B183;
        Sat, 17 Sep 2022 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663427465; x=1694963465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mg1mTmFu6agjQhhpCPwzyOWFWXDgCK6dpsoGBgS6IfY=;
  b=YnAeC6BczgHEH+8ooHC96Ln+qcEZ2zN0G5RWycV9d3cZLYOmk34wJtX1
   mf4GH4qL77P2piQNydgEnffNAm/3253WMStPhNK0KlsvxgEzEriamfZ74
   yrNIe4sAobCha/uWGnfIcwlzzdan5LeEa/UcIgnxYZa8Zbq1wNHUtVinV
   stPsoo9p5p7j3n1iN+gWVIHtted9KPPRLEq3WUisVWKzu/5vVS15q1ltD
   lUAatXI19QYZFi8JryfpHmE0yATn2i9pX14UTiq41D9nJU1bg7YlQ4Rk3
   aD6mpREJQbngAszLtRtFgwQqY0wkXoMaJy8MOdyzXhUApwMGHa4Z27n5Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="296749028"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="296749028"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 08:11:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="707071147"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2022 08:11:00 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZZTA-0000Qb-0C;
        Sat, 17 Sep 2022 15:11:00 +0000
Date:   Sat, 17 Sep 2022 23:10:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     kbuild-all@lists.01.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, catalin.marinas@arm.com,
        linux-kselftest@vger.kernel.org, bgardon@google.com,
        shuah@kernel.org, corbet@lwn.net, maz@kernel.org,
        drjones@redhat.com, will@kernel.org, zhenyzha@redhat.com,
        dmatlack@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        peterx@redhat.com, oliver.upton@linux.dev, shan.gavin@gmail.com
Subject: Re: [PATCH v2 2/5] KVM: arm64: Enable ring-based dirty memory
 tracking
Message-ID: <202209180726.FLL69aKA-lkp@intel.com>
References: <20220916045135.154505-3-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916045135.154505-3-gshan@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Gavin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvm/queue]
[also build test WARNING on kvmarm/next linus/master v6.0-rc5 next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gavin-Shan/KVM-arm64-Enable-ring-based-dirty-memory-tracking/20220916-125417
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220918/202209180726.FLL69aKA-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a1a4cd8f6a5e8927f800baff7d965870a1b7d7ba
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gavin-Shan/KVM-arm64-Enable-ring-based-dirty-memory-tracking/20220916-125417
        git checkout a1a4cd8f6a5e8927f800baff7d965870a1b7d7ba
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kvm/../../../virt/kvm/dirty_ring.c:14:12: warning: no previous prototype for 'kvm_cpu_dirty_log_size' [-Wmissing-prototypes]
      14 | int __weak kvm_cpu_dirty_log_size(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~


vim +/kvm_cpu_dirty_log_size +14 arch/arm64/kvm/../../../virt/kvm/dirty_ring.c

fb04a1eddb1a65 Peter Xu 2020-09-30  13  
fb04a1eddb1a65 Peter Xu 2020-09-30 @14  int __weak kvm_cpu_dirty_log_size(void)
fb04a1eddb1a65 Peter Xu 2020-09-30  15  {
fb04a1eddb1a65 Peter Xu 2020-09-30  16  	return 0;
fb04a1eddb1a65 Peter Xu 2020-09-30  17  }
fb04a1eddb1a65 Peter Xu 2020-09-30  18  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
