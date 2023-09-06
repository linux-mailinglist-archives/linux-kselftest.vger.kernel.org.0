Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846747945D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 00:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbjIFWCP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 18:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjIFWCP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 18:02:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2979172E;
        Wed,  6 Sep 2023 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694037731; x=1725573731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CTCvrcu7YjmCiO9BUFROPsDi8XJkcyMLi88JXj4GLuA=;
  b=PwSIC50qv/r4HWvoo76afxMww+TwsQTGrSkbKsWluAcAZhZtI+cJkbih
   6KFilPwu1FPAj2qEpeSAulUck1sopFdC0KN25HzMmAzp5aJjnNcrtEVMC
   3ODPT3bKYSFJjVm3U3PGIMELpeuLaVRQnkWKIOzS8QhQuLiRgLhwhJJfm
   tVlyIWNS+neMTnPvsNuDTlz3Jsf8SSUWPlqvFXEsy9QSjayUo/OYXNMQD
   8KcTI1PcKblfkmTPnFhCBRPIA/roIUQd5koeb0XTB0QbTCk77UEdwUA57
   NEQKISTxRPFo2WyvUxbUhtzhQsqgWJ4n2UQNvhIG0uyFjPqAMjIS0Qwwn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357507866"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="357507866"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 15:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="718438522"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="718438522"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2023 15:02:06 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qe0b5-0000cx-33;
        Wed, 06 Sep 2023 22:02:03 +0000
Date:   Thu, 7 Sep 2023 06:01:54 +0800
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
Subject: Re: [PATCH V5 6/7] Documentation: amd-pstate: introduce amd-pstate
 preferred core
Message-ID: <202309070502.YxzVpYTO-lkp@intel.com>
References: <20230905015116.2268926-7-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905015116.2268926-7-li.meng@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Meng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.5 next-20230906]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Meng-Li/x86-Drop-CPU_SUP_INTEL-from-SCHED_MC_PRIO-for-the-expansion/20230906-003754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230905015116.2268926-7-li.meng%40amd.com
patch subject: [PATCH V5 6/7] Documentation: amd-pstate: introduce amd-pstate preferred core
reproduce: (https://download.01.org/0day-ci/archive/20230907/202309070502.YxzVpYTO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070502.YxzVpYTO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/pm/amd-pstate.rst:304: WARNING: Title underline too short.

vim +304 Documentation/admin-guide/pm/amd-pstate.rst

c22760885fd6f7 Huang Rui  2021-12-24  301  
92e6088427c5da Perry Yuan 2023-01-31  302  
3a7b575560efa6 Meng Li    2023-09-05  303  ``amd-pstate`` Driver Operation Modes
92e6088427c5da Perry Yuan 2023-01-31 @304  =================================
92e6088427c5da Perry Yuan 2023-01-31  305  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
