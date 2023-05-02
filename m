Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65A6F4560
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 15:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjEBNo2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 09:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjEBNoQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 09:44:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB17A84;
        Tue,  2 May 2023 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683035027; x=1714571027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P63kc43UhIKv9Q4LXJ5JiMCSLZz5VKwB49mJBEQrQ3w=;
  b=Q2il9T4xSpwpfFAQzxyqS+jPY3bqnRC3PHOjShZagGNR4ZLAXV65GIbC
   1t/4nuGqmZ2Eqd/xyrXgd0NkWG7zAlk1EW9knQHMxqbK+26dnDiqma86q
   JdbXDz/qLCzcJEpE126bGP08Dh1Bo8L/Ms6wUZFbd2ZYAMkMQf97HDg+o
   0OKzbIW9Dh7hR90QZ1DmzWxKH1Ky9EQlF50p4rTjnuOBxJGW4Zw6+roSh
   ubpy979pvdHsQVWADkzBlOpJBmHWMBHXX0/LYHKJSu79Hh2JzIsFIaS/p
   7VOCa0ItEVakNr1/mVQu0ntXPa2HL08oz3Hgx9U94wbyRh9QFxWYf/lsJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="413842516"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="413842516"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 06:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="696183092"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="696183092"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2023 06:41:26 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptqFx-000153-16;
        Tue, 02 May 2023 13:41:25 +0000
Date:   Tue, 2 May 2023 21:40:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Kaher <akaher@vmware.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, shuah@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
Message-ID: <202305022138.cJMVU9RM-lkp@intel.com>
References: <1683026600-13485-9-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683026600-13485-9-git-send-email-akaher@vmware.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ajay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master]
[cannot apply to rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-introducing-struct-tracefs_inode/20230502-192949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/1683026600-13485-9-git-send-email-akaher%40vmware.com
patch subject: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230502/202305022138.cJMVU9RM-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2fe2002efb23a715f5eb7a58891ff85f4e37b084
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kaher/eventfs-introducing-struct-tracefs_inode/20230502-192949
        git checkout 2fe2002efb23a715f5eb7a58891ff85f4e37b084
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305022138.cJMVU9RM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_events.c: In function 'event_create_dir':
>> kernel/trace/trace_events.c:2424:24: warning: variable 'd_events' set but not used [-Wunused-but-set-variable]
    2424 |         struct dentry *d_events;
         |                        ^~~~~~~~


vim +/d_events +2424 kernel/trace/trace_events.c

ac343da7bc9048 Masami Hiramatsu         2020-09-10  2417  
1473e4417c79f1 Steven Rostedt           2009-02-24  2418  static int
7f1d2f8210195c Steven Rostedt (Red Hat  2015-05-05  2419) event_create_dir(struct dentry *parent, struct trace_event_file *file)
1473e4417c79f1 Steven Rostedt           2009-02-24  2420  {
2425bcb9240f8c Steven Rostedt (Red Hat  2015-05-05  2421) 	struct trace_event_call *call = file->event_call;
ae63b31e4d0e2e Steven Rostedt           2012-05-03  2422  	struct trace_array *tr = file->tr;
2fe2002efb23a7 Ajay Kaher               2023-05-02  2423  	struct eventfs_file *ef_subsystem = NULL;
ae63b31e4d0e2e Steven Rostedt           2012-05-03 @2424  	struct dentry *d_events;
de7b2973903c6c Mathieu Desnoyers        2014-04-08  2425  	const char *name;
fd99498989f3b3 Steven Rostedt           2009-02-28  2426  	int ret;
1473e4417c79f1 Steven Rostedt           2009-02-24  2427  
6ecc2d1ca39177 Steven Rostedt           2009-02-27  2428  	/*
6ecc2d1ca39177 Steven Rostedt           2009-02-27  2429  	 * If the trace point header did not define TRACE_SYSTEM
6ecc2d1ca39177 Steven Rostedt           2009-02-27  2430  	 * then the system would be called "TRACE_SYSTEM".
6ecc2d1ca39177 Steven Rostedt           2009-02-27  2431  	 */
ae63b31e4d0e2e Steven Rostedt           2012-05-03  2432  	if (strcmp(call->class->system, TRACE_SYSTEM) != 0) {
2fe2002efb23a7 Ajay Kaher               2023-05-02  2433  		ef_subsystem = event_subsystem_dir(tr, call->class->system, file, parent);
2fe2002efb23a7 Ajay Kaher               2023-05-02  2434  		if (!ef_subsystem)
ae63b31e4d0e2e Steven Rostedt           2012-05-03  2435  			return -ENOMEM;
ae63b31e4d0e2e Steven Rostedt           2012-05-03  2436  	} else
ae63b31e4d0e2e Steven Rostedt           2012-05-03  2437  		d_events = parent;
6ecc2d1ca39177 Steven Rostedt           2009-02-27  2438  
687fcc4aee4567 Steven Rostedt (Red Hat  2015-05-13  2439) 	name = trace_event_name(call);
2fe2002efb23a7 Ajay Kaher               2023-05-02  2440  	file->ef = eventfs_add_dir(name, ef_subsystem, &tr->eventfs_rwsem);
2fe2002efb23a7 Ajay Kaher               2023-05-02  2441  	if (IS_ERR(file->ef)) {
8434dc9340cd2e Steven Rostedt (Red Hat  2015-01-20  2442) 		pr_warn("Could not create tracefs '%s' directory\n", name);
1473e4417c79f1 Steven Rostedt           2009-02-24  2443  		return -1;
1473e4417c79f1 Steven Rostedt           2009-02-24  2444  	}
1473e4417c79f1 Steven Rostedt           2009-02-24  2445  
9b63776fa3ca96 Steven Rostedt           2012-05-10  2446  	if (call->class->reg && !(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
2fe2002efb23a7 Ajay Kaher               2023-05-02  2447  		eventfs_add_file("enable", TRACE_MODE_WRITE, file->ef, file,
620a30e97febc8 Oleg Nesterov            2013-07-31  2448  				  &ftrace_enable_fops);
1473e4417c79f1 Steven Rostedt           2009-02-24  2449  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
