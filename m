Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1281378C9B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjH2Qdw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 12:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjH2Qdu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 12:33:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447EC184;
        Tue, 29 Aug 2023 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693326828; x=1724862828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LbBndQ30pApFIdN1pPSoRCOwu6jKcidtzAZxrTxto+I=;
  b=G0mPdmDJyd0ZFftYDC1qtsdyRxiN4gpfjuxiq7XvUYR83T7NilQOG4IC
   mvbpVNehg+xBptDZpExL21wpo+9EDcVc3v4FjchcDyUHg8aaeVDivhmDa
   lrbbMONM+156SM5sy+jMr95Q/+q8kOG2KguvLrkj9solvalS76YYMp1gZ
   JKTKvlHjQNJGt1O/2zSYK1YOLlRl51//a4iVsIQ+n+G6ijDOIq4c5WeT8
   Ab5jpK1v2aWqR1jmPxUCn3W+CYgqCOPvsWbN+qSDyzgbTS/SbVhJGK3pK
   B2o/fWnV6biXXqTnOK5QbG2O3WEsUCwPFwxGYmSBuoYDaUYLZEBsko2zD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461793834"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461793834"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 09:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="741883388"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="741883388"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2023 09:27:56 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qb1ZL-0008u3-28;
        Tue, 29 Aug 2023 16:27:55 +0000
Date:   Wed, 30 Aug 2023 00:27:13 +0800
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
Subject: Re: [PATCH V4 4/7] cpufreq: Add a notification message that the
 highest perf has changed
Message-ID: <202308300057.ASUJQpsV-lkp@intel.com>
References: <20230829064340.1136448-5-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829064340.1136448-5-li.meng@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Meng,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v6.5 next-20230829]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Meng-Li/x86-Drop-CPU_SUP_INTEL-from-SCHED_MC_PRIO-for-the-expansion/20230829-144723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230829064340.1136448-5-li.meng%40amd.com
patch subject: [PATCH V4 4/7] cpufreq: Add a notification message that the highest perf has changed
config: i386-randconfig-r031-20230829 (https://download.01.org/0day-ci/archive/20230830/202308300057.ASUJQpsV-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230830/202308300057.ASUJQpsV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308300057.ASUJQpsV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/processor_driver.c:88:3: error: call to undeclared function 'cpufreq_update_highest_perf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   cpufreq_update_highest_perf(pr->id);
                   ^
   1 error generated.


vim +/cpufreq_update_highest_perf +88 drivers/acpi/processor_driver.c

    53	
    54	static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
    55	{
    56		struct acpi_device *device = data;
    57		struct acpi_processor *pr;
    58		int saved;
    59	
    60		if (device->handle != handle)
    61			return;
    62	
    63		pr = acpi_driver_data(device);
    64		if (!pr)
    65			return;
    66	
    67		switch (event) {
    68		case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
    69			saved = pr->performance_platform_limit;
    70			acpi_processor_ppc_has_changed(pr, 1);
    71			if (saved == pr->performance_platform_limit)
    72				break;
    73			acpi_bus_generate_netlink_event(device->pnp.device_class,
    74							  dev_name(&device->dev), event,
    75							  pr->performance_platform_limit);
    76			break;
    77		case ACPI_PROCESSOR_NOTIFY_POWER:
    78			acpi_processor_power_state_has_changed(pr);
    79			acpi_bus_generate_netlink_event(device->pnp.device_class,
    80							  dev_name(&device->dev), event, 0);
    81			break;
    82		case ACPI_PROCESSOR_NOTIFY_THROTTLING:
    83			acpi_processor_tstate_has_changed(pr);
    84			acpi_bus_generate_netlink_event(device->pnp.device_class,
    85							  dev_name(&device->dev), event, 0);
    86			break;
    87		case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
  > 88			cpufreq_update_highest_perf(pr->id);
    89			acpi_bus_generate_netlink_event(device->pnp.device_class,
    90							  dev_name(&device->dev), event, 0);
    91			break;
    92		default:
    93			acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
    94			break;
    95		}
    96	
    97		return;
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
