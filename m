Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8A7743447
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 07:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjF3FdW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 01:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjF3FdU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 01:33:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE510F8;
        Thu, 29 Jun 2023 22:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688103199; x=1719639199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dsdYNUX+gcDM37G8FPUcCZXTwbW6arF/jZi6JvzXNfw=;
  b=Ekm4oU+VPR4sU3SlUGECJUS7qze0yyqf2qYZYNpSsFr16u/lw5WjsdUG
   2IF9cLJ/BqTGO9KcaogxErdq7AoEaR3dpPZ74zolD/sS4T4fG72+tZ7o1
   dJNJMvlfDRHK8TQpZPu7pGlF65XC9hZySJK819+0IP9D4uX+m7RDwr/WL
   m0WD/QNs6+Md9gf07i5ilNQazMm4FmDEBJQJBJeefViyoufoEImgqcA0z
   pktw6Rps6IRce7JXApoHymu/9y7XdUuD0t6J8t04CKkqqbOlK3Opf84H7
   QOIAe1bQ7NlUQ0qoBKx8xJNoMVj87h4n1feDWH7/4LQ1mp8XbR7rkjTbQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365802562"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="365802562"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 22:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="807633037"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="807633037"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2023 22:33:14 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qF6kr-000EkP-2v;
        Fri, 30 Jun 2023 05:33:13 +0000
Date:   Fri, 30 Jun 2023 13:32:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org
Cc:     oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org,
        asmadeus@codewreck.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/memfd: sysctl: fix
 MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
Message-ID: <202306301351.kkbSegQW-lkp@intel.com>
References: <20230630031721.623955-2-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630031721.623955-2-jeffxu@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/jeffxu-chromium-org/mm-memfd-sysctl-fix-MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED/20230630-111827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230630031721.623955-2-jeffxu%40google.com
patch subject: [PATCH v1 1/2] mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
config: microblaze-randconfig-r003-20230630 (https://download.01.org/0day-ci/archive/20230630/202306301351.kkbSegQW-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306301351.kkbSegQW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306301351.kkbSegQW-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/memfd.c: In function 'sysctl_memfd_noexec':
>> mm/memfd.c:273:22: error: 'MEMFD_NOEXEC_SCOPE_EXEC' undeclared (first use in this function)
     273 |         int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   mm/memfd.c:273:22: note: each undeclared identifier is reported only once for each function it appears in
   mm/memfd.c: In function '__do_sys_memfd_create':
>> mm/memfd.c:311:31: error: 'MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL' undeclared (first use in this function)
     311 |                 if (sysctl == MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/memfd.c:321:43: error: 'MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED' undeclared (first use in this function)
     321 |         if (flags & MFD_EXEC && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/MEMFD_NOEXEC_SCOPE_EXEC +273 mm/memfd.c

   270	
   271	static int sysctl_memfd_noexec(void)
   272	{
 > 273		int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
   274	#ifdef CONFIG_SYSCTL
   275		struct pid_namespace *ns;
   276	
   277		ns = task_active_pid_ns(current);
   278		if (ns)
   279			sysctl = ns->memfd_noexec_scope;
   280	#endif
   281		return sysctl;
   282	}
   283	
   284	SYSCALL_DEFINE2(memfd_create,
   285			const char __user *, uname,
   286			unsigned int, flags)
   287	{
   288		char comm[TASK_COMM_LEN];
   289		unsigned int *file_seals;
   290		struct file *file;
   291		int fd, error;
   292		char *name;
   293		long len;
   294		int sysctl = sysctl_memfd_noexec();
   295	
   296		if (!(flags & MFD_HUGETLB)) {
   297			if (flags & ~(unsigned int)MFD_ALL_FLAGS)
   298				return -EINVAL;
   299		} else {
   300			/* Allow huge page size encoding in flags. */
   301			if (flags & ~(unsigned int)(MFD_ALL_FLAGS |
   302					(MFD_HUGE_MASK << MFD_HUGE_SHIFT)))
   303				return -EINVAL;
   304		}
   305	
   306		/* Invalid if both EXEC and NOEXEC_SEAL are set.*/
   307		if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
   308			return -EINVAL;
   309	
   310		if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
 > 311			if (sysctl == MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)
   312				flags |= MFD_NOEXEC_SEAL;
   313			else
   314				flags |= MFD_EXEC;
   315	
   316			pr_warn_once(
   317				"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
   318				task_pid_nr(current), get_task_comm(comm, current));
   319		}
   320	
 > 321		if (flags & MFD_EXEC && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
