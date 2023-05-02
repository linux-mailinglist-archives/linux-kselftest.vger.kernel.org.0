Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FB26F47F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjEBQHZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBQHY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 12:07:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FBD1997;
        Tue,  2 May 2023 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683043643; x=1714579643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I2QZzh9qzfdA9J2tzysHsjo8wxyPgdS/fULekpS2MxY=;
  b=SaDX/cbyrYqWsQWRUqNL/jikPr4MQnNnmit81WvwgMmjTVpHVy6IRemF
   grJ+s9eonlk3/XjqoZ8hPngiX63BU6SLPj0mU11MsGrzRTBR689MOaWyF
   mocVWAVRRt9qmrRL0qlSN+nqt6z2FOXAG+IFMhS2O76Z7PEZoLJBbX0W8
   EC41utJMdM5zmfPBFyLH6erU0i7OxQzUPjxPZyokg14K3F+ETRru3a+/Z
   Yp65CuW1DUdBo+xX/FXm9M8cyWGbsRlpMv1lmdtkZ8nU8XCO9qChtp5hh
   RYs3kMEpq5dRs2C/tZtFglplrzn0Y89ZxtJkpgXNpGtPKmiT4xqhKoq6Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="337563677"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="337563677"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 09:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="696238977"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="696238977"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2023 09:04:30 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptsUP-000196-0O;
        Tue, 02 May 2023 16:04:29 +0000
Date:   Wed, 3 May 2023 00:04:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Kaher <akaher@vmware.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, shuah@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH v2 4/9] eventfs: adding eventfs file, directory remove
 function
Message-ID: <202305022354.fzV9RKTT-lkp@intel.com>
References: <1683026600-13485-5-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683026600-13485-5-git-send-email-akaher@vmware.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ajay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-introducing-struct-tracefs_inode/20230502-192949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/1683026600-13485-5-git-send-email-akaher%40vmware.com
patch subject: [PATCH v2 4/9] eventfs: adding eventfs file, directory remove function
config: i386-randconfig-a011-20230501 (https://download.01.org/0day-ci/archive/20230502/202305022354.fzV9RKTT-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9a36b39da0c3fbfe15a3c3a0ed71b52013bac292
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kaher/eventfs-introducing-struct-tracefs_inode/20230502-192949
        git checkout 9a36b39da0c3fbfe15a3c3a0ed71b52013bac292
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/tracefs/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305022354.fzV9RKTT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/tracefs/event_inode.c:379:6: warning: no previous prototype for function 'eventfs_remove_rec' [-Wmissing-prototypes]
   void eventfs_remove_rec(struct eventfs_file *ef)
        ^
   fs/tracefs/event_inode.c:379:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void eventfs_remove_rec(struct eventfs_file *ef)
   ^
   static 
   fs/tracefs/event_inode.c:31:29: warning: unused function 'eventfs_dentry_to_rwsem' [-Wunused-function]
   static struct rw_semaphore *eventfs_dentry_to_rwsem(struct dentry *dentry)
                               ^
   fs/tracefs/event_inode.c:47:13: warning: unused function 'eventfs_down_read' [-Wunused-function]
   static void eventfs_down_read(struct rw_semaphore *eventfs_rwsem)
               ^
   fs/tracefs/event_inode.c:58:13: warning: unused function 'eventfs_up_read' [-Wunused-function]
   static void eventfs_up_read(struct rw_semaphore *eventfs_rwsem)
               ^
   4 warnings generated.


vim +/eventfs_remove_rec +379 fs/tracefs/event_inode.c

   371	
   372	/**
   373	 * eventfs_remove_rec - remove eventfs dir or file from list
   374	 * @ef: a pointer to eventfs_file to be removed.
   375	 *
   376	 * This function recursively remove eventfs_file which
   377	 * contains info of file or dir.
   378	 */
 > 379	void eventfs_remove_rec(struct eventfs_file *ef)
   380	{
   381		struct eventfs_file *ef_child, *n;
   382	
   383		if (!ef)
   384			return;
   385	
   386		if (ef->ei) {
   387			/* search for nested folders or files */
   388			list_for_each_entry_safe(ef_child, n, &ef->ei->e_top_files, list) {
   389				eventfs_remove_rec(ef_child);
   390			}
   391			kfree(ef->ei);
   392		}
   393	
   394		if (ef->created && ef->dentry) {
   395			d_invalidate(ef->dentry);
   396			dput(ef->dentry);
   397		}
   398		list_del(&ef->list);
   399		kfree(ef->name);
   400		kfree(ef);
   401	}
   402	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
