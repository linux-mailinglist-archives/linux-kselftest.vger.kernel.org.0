Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2A479DD9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbjIMBek (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 21:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjIMBej (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 21:34:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929D10FE;
        Tue, 12 Sep 2023 18:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694568875; x=1726104875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BWOxUPW3HtPNFgEFOHoQhbd+ni/5DnSj2ZCuh3rTtAc=;
  b=gc2/i1+a6Ggyong+Hyi3NBuVgxJoss5mBmJyoxlsxTOHqcqxLK3JD2mU
   zdNdExS27EO+uNynKx9dGD8/peBB1E/YQQ9k8QCLIjqAod3+qrvdUV4SW
   7cxnD6vzBjcnpDtBePMb2wt+sbOf71KF2Lvku4OFEHVPUjBIDvfo60HtE
   xgeG84dvIf0RYnGzD5tdMJIpW1/2Lz2yrbNdvHAOtGAG62F8N3Lf+s0BY
   Kj2+CnC+7cMbHI2tTpdTVEl9AV9nGa8FS3bTzOA0pUkilRjV4wGfFYUBA
   ukaN5PTrx19/KFX4a+3roCuq0vWMo0sshLhUeCW5oBY/C2hTlrsu3R/aL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="375868416"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="375868416"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 18:34:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="867581317"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="867581317"
Received: from lkp-server02.sh.intel.com (HELO 47e905db7d2b) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2023 18:34:29 -0700
Received: from kbuild by 47e905db7d2b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgElv-0000Zb-2H;
        Wed, 13 Sep 2023 01:34:27 +0000
Date:   Wed, 13 Sep 2023 09:34:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Meng Li <li.meng@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
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
Subject: Re: [PATCH V6 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
 the expansion.
Message-ID: <202309130938.dmI2pWUB-lkp@intel.com>
References: <20230908074653.2799055-2-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908074653.2799055-2-li.meng@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Meng,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on tip/x86/core linus/master v6.6-rc1 next-20230912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Meng-Li/x86-Drop-CPU_SUP_INTEL-from-SCHED_MC_PRIO-for-the-expansion/20230908-154939
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230908074653.2799055-2-li.meng%40amd.com
patch subject: [PATCH V6 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for the expansion.
config: i386-buildonly-randconfig-004-20230913 (https://download.01.org/0day-ci/archive/20230913/202309130938.dmI2pWUB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309130938.dmI2pWUB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309130938.dmI2pWUB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cpufreq/amd-pstate.c:41:
>> include/acpi/processor.h:226:9: error: unknown type name 'phys_cpuid_t'
     226 |         phys_cpuid_t phys_id;   /* CPU hardware ID such as APIC ID for x86 */
         |         ^~~~~~~~~~~~
   include/acpi/processor.h:355:1: error: unknown type name 'phys_cpuid_t'
     355 | phys_cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
         | ^~~~~~~~~~~~
   include/acpi/processor.h:356:1: error: unknown type name 'phys_cpuid_t'
     356 | phys_cpuid_t acpi_map_madt_entry(u32 acpi_id);
         | ^~~~~~~~~~~~
   include/acpi/processor.h:357:20: error: unknown type name 'phys_cpuid_t'
     357 | int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id);
         |                    ^~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_acpi_pm_profile_server':
   drivers/cpufreq/amd-pstate.c:1076:17: error: 'acpi_gbl_FADT' undeclared (first use in this function); did you mean 'acpi_table_fadt'?
    1076 |         switch (acpi_gbl_FADT.preferred_profile) {
         |                 ^~~~~~~~~~~~~
         |                 acpi_table_fadt
   drivers/cpufreq/amd-pstate.c:1076:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_acpi_pm_profile_undefined':
   drivers/cpufreq/amd-pstate.c:1087:13: error: 'acpi_gbl_FADT' undeclared (first use in this function); did you mean 'acpi_table_fadt'?
    1087 |         if (acpi_gbl_FADT.preferred_profile == PM_UNSPECIFIED)
         |             ^~~~~~~~~~~~~
         |             acpi_table_fadt

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for X86_AMD_PSTATE
   Depends on [n]: CPU_FREQ [=y] && X86 [=y] && ACPI [=n]
   Selected by [y]:
   - SCHED_MC_PRIO [=y] && SCHED_MC [=y] && CPU_SUP_AMD [=y]
   WARNING: unmet direct dependencies detected for VIDEO_OV7640
   Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
   Selected by [y]:
   - VIDEO_GO7007 [=y] && MEDIA_SUPPORT [=y] && MEDIA_USB_SUPPORT [=y] && MEDIA_ANALOG_TV_SUPPORT [=y] && VIDEO_DEV [=y] && I2C [=y] && SND [=y] && USB [=y] && MEDIA_SUBDRV_AUTOSELECT [=y] && MEDIA_CAMERA_SUPPORT [=y]


vim +/phys_cpuid_t +226 include/acpi/processor.h

^1da177e4c3f41 Linus Torvalds    2005-04-16  222  
^1da177e4c3f41 Linus Torvalds    2005-04-16  223  struct acpi_processor {
^1da177e4c3f41 Linus Torvalds    2005-04-16  224  	acpi_handle handle;
^1da177e4c3f41 Linus Torvalds    2005-04-16  225  	u32 acpi_id;
828aef376d7a12 Catalin Marinas   2015-03-24 @226  	phys_cpuid_t phys_id;	/* CPU hardware ID such as APIC ID for x86 */
af8f3f514d193e Hanjun Guo        2015-01-04  227  	u32 id;		/* CPU logical ID allocated by OS */
^1da177e4c3f41 Linus Torvalds    2005-04-16  228  	u32 pblk;
^1da177e4c3f41 Linus Torvalds    2005-04-16  229  	int performance_platform_limit;
01854e697a77a4 Luming Yu         2007-05-26  230  	int throttling_platform_limit;
ff55a9cebab024 Len Brown         2007-06-02  231  	/* 0 - states 0..n-th state available */
01854e697a77a4 Luming Yu         2007-05-26  232  
^1da177e4c3f41 Linus Torvalds    2005-04-16  233  	struct acpi_processor_flags flags;
^1da177e4c3f41 Linus Torvalds    2005-04-16  234  	struct acpi_processor_power power;
^1da177e4c3f41 Linus Torvalds    2005-04-16  235  	struct acpi_processor_performance *performance;
^1da177e4c3f41 Linus Torvalds    2005-04-16  236  	struct acpi_processor_throttling throttling;
^1da177e4c3f41 Linus Torvalds    2005-04-16  237  	struct acpi_processor_limit limit;
d9460fd227ed2c Zhang Rui         2008-01-17  238  	struct thermal_cooling_device *cdev;
ac212b6980d8d5 Rafael J. Wysocki 2013-05-03  239  	struct device *dev; /* Processor device. */
3000ce3c52f8b8 Rafael J. Wysocki 2019-10-16  240  	struct freq_qos_request perflib_req;
3000ce3c52f8b8 Rafael J. Wysocki 2019-10-16  241  	struct freq_qos_request thermal_req;
^1da177e4c3f41 Linus Torvalds    2005-04-16  242  };
^1da177e4c3f41 Linus Torvalds    2005-04-16  243  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
