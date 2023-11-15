Return-Path: <linux-kselftest+bounces-176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D817ECB09
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 20:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEF32814BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 19:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D1F3BB31;
	Wed, 15 Nov 2023 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbfEmrrA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A20FA;
	Wed, 15 Nov 2023 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700075610; x=1731611610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gXRiJ5Lucq8DXuhZwt0/bXTGhj/qXhHAst2jYHjGW3k=;
  b=YbfEmrrAfGMLTsgprIdwWiI2ugx0JoYfIPr1JgWXdUhKRyKbO8QkSP9q
   saLPWZwQflOYtFp2VbBohWfau5BvHJdAVfNH+HyFJQtMm++cdNXSX85WL
   6RonKup+8Z5KI1fo4V3ar2F8UuZLjEWlI1XzdtpPrWbJyv3D5eV+j/I2y
   KGEaANB3Jlg5d8A6gq9r2kZHw9h4UBnKx+JVqlrKxmjg6fBb8qiHB1fHm
   cDbA+QySSmfrU79qhdnrTWfQOhyIBqc0vvvxbrrXvwxuCdX2ZqWyd/EJS
   RYcZlJl43HBTmgHL7JESO/PM9uJqIUuooOJYV6KmYMaFggfXQB19FChXU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="370288071"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="370288071"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:13:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="741519658"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="741519658"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2023 11:13:25 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3LKF-0000jt-01;
	Wed, 15 Nov 2023 19:13:23 +0000
Date: Thu, 16 Nov 2023 03:12:40 +0800
From: kernel test robot <lkp@intel.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Peter Hunt <pehunt@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 1/5] workqueue: Make workqueue_set_unbound_cpumask()
 static
Message-ID: <202311160353.FAdfQwO3-lkp@intel.com>
References: <20231115170359.163299-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115170359.163299-2-longman@redhat.com>

Hi Waiman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v6.7-rc1]
[cannot apply to tj-cgroup/for-next tj-wq/for-next next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/workqueue-Make-workqueue_set_unbound_cpumask-static/20231116-010940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20231115170359.163299-2-longman%40redhat.com
patch subject: [PATCH v3 1/5] workqueue: Make workqueue_set_unbound_cpumask() static
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20231116/202311160353.FAdfQwO3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160353.FAdfQwO3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160353.FAdfQwO3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/workqueue.c:4421:13: warning: 'apply_wqattrs_unlock' defined but not used [-Wunused-function]
    4421 | static void apply_wqattrs_unlock(void)
         |             ^~~~~~~~~~~~~~~~~~~~
>> kernel/workqueue.c:4414:13: warning: 'apply_wqattrs_lock' defined but not used [-Wunused-function]
    4414 | static void apply_wqattrs_lock(void)
         |             ^~~~~~~~~~~~~~~~~~


vim +/apply_wqattrs_unlock +4421 kernel/workqueue.c

8864b4e59f7945 Tejun Heo                 2013-03-12  4413  
a0111cf6710bd1 Lai Jiangshan             2015-05-19 @4414  static void apply_wqattrs_lock(void)
a0111cf6710bd1 Lai Jiangshan             2015-05-19  4415  {
a0111cf6710bd1 Lai Jiangshan             2015-05-19  4416  	/* CPUs should stay stable across pwq creations and installations */
ffd8bea81fbb5a Sebastian Andrzej Siewior 2021-08-03  4417  	cpus_read_lock();
a0111cf6710bd1 Lai Jiangshan             2015-05-19  4418  	mutex_lock(&wq_pool_mutex);
a0111cf6710bd1 Lai Jiangshan             2015-05-19  4419  }
a0111cf6710bd1 Lai Jiangshan             2015-05-19  4420  
a0111cf6710bd1 Lai Jiangshan             2015-05-19 @4421  static void apply_wqattrs_unlock(void)
a0111cf6710bd1 Lai Jiangshan             2015-05-19  4422  {
a0111cf6710bd1 Lai Jiangshan             2015-05-19  4423  	mutex_unlock(&wq_pool_mutex);
ffd8bea81fbb5a Sebastian Andrzej Siewior 2021-08-03  4424  	cpus_read_unlock();
a0111cf6710bd1 Lai Jiangshan             2015-05-19  4425  }
a0111cf6710bd1 Lai Jiangshan             2015-05-19  4426  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

