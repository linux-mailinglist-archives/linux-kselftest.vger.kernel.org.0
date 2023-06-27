Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC973F330
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 06:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjF0ENC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 00:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjF0ENB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 00:13:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F2410FC;
        Mon, 26 Jun 2023 21:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687839180; x=1719375180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e1b0fi0vY8js4lH2qqnZOIMHiQIDCirQwxuk84EGyQM=;
  b=H7DOV8VfFryKhYQJ0A5/yOhjfxkzDC3QjXJM5nHLf4QahDlICjsi+sfx
   XDKSOwO8i8+mZ5NPbOdjgA0ACiF0lnzuBl+nPnxf3uH8YTGlNX8LvioqU
   V7/+jb5S0vkg83s6Ct3iIAhJXpGcxnv4Q6MOldNDYHYUAJbopW53q4slO
   7b9O/udQtpSuSJX6GdtlL7iDtq80lJJkxtGNULnu8PtGtq0qSoKahhv58
   EjJo6LbR/OzHP0QEVFn1Okkp0pDksEOQCUEg588iiqA2wJWx6JgEpdugM
   Aflq5+Hn6W9xOz8eQ9zJkqieMD3MDGrg60iATNjiZ9zdOY696G7om49fd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341809249"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="341809249"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 21:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="786431884"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="786431884"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2023 21:12:55 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qE04V-000Bhl-0C;
        Tue, 27 Jun 2023 04:12:55 +0000
Date:   Tue, 27 Jun 2023 12:12:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 5/9] cgroup/cpuset: Add cpuset.cpus.exclusive for v2
Message-ID: <202306271214.Vd5UDf4Y-lkp@intel.com>
References: <20230627005529.1564984-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627005529.1564984-6-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Waiman,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230626]
[also build test ERROR on v6.4]
[cannot apply to tj-cgroup/for-next linus/master v6.4 v6.4-rc7 v6.4-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/cgroup-cpuset-Inherit-parent-s-load-balance-state-in-v2/20230627-090025
base:   next-20230626
patch link:    https://lore.kernel.org/r/20230627005529.1564984-6-longman%40redhat.com
patch subject: [PATCH v3 5/9] cgroup/cpuset: Add cpuset.cpus.exclusive for v2
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230627/202306271214.Vd5UDf4Y-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230627/202306271214.Vd5UDf4Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306271214.Vd5UDf4Y-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/cgroup/cpuset.c: In function 'cpu_exclusive_check':
>> kernel/cgroup/cpuset.c:699:15: error: assignment to expression with array type
     699 |         cpus1 = cpumask_empty(cs1->exclusive_cpus)
         |               ^
   kernel/cgroup/cpuset.c:701:15: error: assignment to expression with array type
     701 |         cpus2 = cpumask_empty(cs2->exclusive_cpus)
         |               ^


vim +699 kernel/cgroup/cpuset.c

   689	
   690	/*
   691	 * cpu_exclusive_check() - check if two cpusets are exclusive
   692	 *
   693	 * Return 0 if exclusive, -EINVAL if not
   694	 */
   695	static inline bool cpu_exclusive_check(struct cpuset *cs1, struct cpuset *cs2)
   696	{
   697		cpumask_var_t cpus1, cpus2;
   698	
 > 699		cpus1 = cpumask_empty(cs1->exclusive_cpus)
   700			? cs1->cpus_allowed : cs1->exclusive_cpus;
   701		cpus2 = cpumask_empty(cs2->exclusive_cpus)
   702			? cs2->cpus_allowed : cs2->exclusive_cpus;
   703	
   704		if (cpumask_intersects(cpus1, cpus2))
   705			return -EINVAL;
   706		return 0;
   707	}
   708	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
