Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E5770CED
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 03:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjHEBQH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 21:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHEBQH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 21:16:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B0A4EDD;
        Fri,  4 Aug 2023 18:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691198165; x=1722734165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q3XhvvGdKBVZnVvP2LX4y2B9m4C8AB1TqtQq1pF44lM=;
  b=V505W0fTQn6Wn7sU+lVuJ6Nl4mm/YTSxip+JBdYRWMZXE+4W01F8Jusu
   dovfi6D/QQttpM2si12Z+jjbb18EtcTE4uZk7ITY4a9XTjpnYuf71enR8
   cPamNgghDXkNVvOE+jXk+c/80nn2w4kqHXiEfqFlrw/6pL4c1lz4X9xTU
   SRSqq5Js59/rXd43ed4hkeMwqGgJi0VpjG4RANL++NPE4YLWOYT0aMGF8
   jQ8kPj2mapIxjgtMYj6LBDSkEBZqqPKqvIhmmPVfvyvd3dgvyNZ+gKKnU
   ALsoCG2ev4E+OXR/oHBHrSLVNT9ZKeF8bPKBjg3CoaRjWLCETiNhm6XRr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="456657874"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="456657874"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 18:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="680162338"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="680162338"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2023 18:16:03 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS5ti-0003EZ-0x;
        Sat, 05 Aug 2023 01:16:02 +0000
Date:   Sat, 5 Aug 2023 09:15:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zheng Yejian <zhengyejian1@huawei.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, vnagarnaik@google.com, shuah@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Fix cpu buffers unavailable due to
 'record_disabled' messed
Message-ID: <202308050731.PQutr3r0-lkp@intel.com>
References: <20230804124549.2562977-2-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804124549.2562977-2-zhengyejian1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on rostedt-trace/for-next v6.5-rc4 next-20230804]
[cannot apply to rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Yejian/tracing-Fix-cpu-buffers-unavailable-due-to-record_disabled-messed/20230804-204751
base:   linus/master
patch link:    https://lore.kernel.org/r/20230804124549.2562977-2-zhengyejian1%40huawei.com
patch subject: [PATCH 1/2] tracing: Fix cpu buffers unavailable due to 'record_disabled' messed
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230805/202308050731.PQutr3r0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308050731.PQutr3r0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308050731.PQutr3r0-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'tracing_set_cpumask':
>> kernel/trace/trace.c:5280:60: error: 'struct trace_array' has no member named 'max_buffer'; did you mean 'array_buffer'?
    5280 |                         ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
         |                                                            ^~~~~~~~~~
         |                                                            array_buffer
   kernel/trace/trace.c:5286:59: error: 'struct trace_array' has no member named 'max_buffer'; did you mean 'array_buffer'?
    5286 |                         ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
         |                                                           ^~~~~~~~~~
         |                                                           array_buffer


vim +5280 kernel/trace/trace.c

  5260	
  5261	int tracing_set_cpumask(struct trace_array *tr,
  5262				cpumask_var_t tracing_cpumask_new)
  5263	{
  5264		int cpu;
  5265	
  5266		if (!tr)
  5267			return -EINVAL;
  5268	
  5269		local_irq_disable();
  5270		arch_spin_lock(&tr->max_lock);
  5271		for_each_tracing_cpu(cpu) {
  5272			/*
  5273			 * Increase/decrease the disabled counter if we are
  5274			 * about to flip a bit in the cpumask:
  5275			 */
  5276			if (cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
  5277					!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
  5278				atomic_inc(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
  5279				ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
> 5280				ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
  5281			}
  5282			if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
  5283					cpumask_test_cpu(cpu, tracing_cpumask_new)) {
  5284				atomic_dec(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
  5285				ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
  5286				ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
  5287			}
  5288		}
  5289		arch_spin_unlock(&tr->max_lock);
  5290		local_irq_enable();
  5291	
  5292		cpumask_copy(tr->tracing_cpumask, tracing_cpumask_new);
  5293	
  5294		return 0;
  5295	}
  5296	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
