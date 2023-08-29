Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944EA78C808
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjH2Owf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 10:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjH2Owc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 10:52:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE4A98;
        Tue, 29 Aug 2023 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320749; x=1724856749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FylhOCBxnWrtavNBNeHVWqufiBk07ThM8X7Znf1QkXc=;
  b=JylN52bCueV2zyyuKPGFW8ipJzYP3PQB+7dZJa8kQdiYwTeMknRYbq1L
   TXWVPUSebg2tEZWO9rZBLP1m8nLTWUse1xv/KXDnX8/VcUbAZGbOvp2os
   KWBVOLHCAD4Bv9Sp/htpR6rRIoZtJKG8m451FAHIbAWrmsK/QYXHq5QC4
   BWf3IMN2kXmlQmZsZ+3I03yOjTxFZcYCUcxgTkeaZb9u9+racOnf6eD3d
   Ap6jTm8SAqw3pcjqNHTYtb8LOOas0rhUu2odJvOK1R/6SgHkMeegJRCY6
   axVBu4z3+0EwaDLie43SmHMknVHQ8YWShOXCxOdufG+a2d3IhEckGJP/2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406380415"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406380415"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="985369271"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="985369271"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2023 07:52:24 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qb04t-0008pB-3A;
        Tue, 29 Aug 2023 14:52:23 +0000
Date:   Tue, 29 Aug 2023 22:52:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-acpi@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Meng Li <li.meng@amd.com>
Subject: Re: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred
 Core Supporting.
Message-ID: <202308292233.XhcXfvSm-lkp@intel.com>
References: <20230829064340.1136448-4-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829064340.1136448-4-li.meng@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Meng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.5 next-20230829]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Meng-Li/x86-Drop-CPU_SUP_INTEL-from-SCHED_MC_PRIO-for-the-expansion/20230829-144723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230829064340.1136448-4-li.meng%40amd.com
patch subject: [PATCH V4 3/7] cpufreq: amd-pstate: Enable AMD Pstate Preferred Core Supporting.
config: x86_64-randconfig-r005-20230829 (https://download.01.org/0day-ci/archive/20230829/202308292233.XhcXfvSm-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230829/202308292233.XhcXfvSm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308292233.XhcXfvSm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:692: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Get the highest performance register value.


vim +692 drivers/cpufreq/amd-pstate.c

   690	
   691	/**
 > 692	 * Get the highest performance register value.
   693	 * @cpu: CPU from which to get highest performance.
   694	 * @highest_perf: Return address.
   695	 *
   696	 * Return: 0 for success, -EIO otherwise.
   697	 */
   698	static int amd_pstate_get_highest_perf(int cpu, u64 *highest_perf)
   699	{
   700	       int ret;
   701	
   702	       if (boot_cpu_has(X86_FEATURE_CPPC)) {
   703	               u64 cap1;
   704	
   705	               ret = rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
   706	               if (ret)
   707	                       return ret;
   708	               WRITE_ONCE(*highest_perf, AMD_CPPC_HIGHEST_PERF(cap1));
   709	       } else {
   710	               ret = cppc_get_highest_perf(cpu, highest_perf);
   711	       }
   712	
   713	       return (ret);
   714	}
   715	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
