Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0009B74F22B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 16:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjGKOZa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjGKOY5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 10:24:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E208A1713;
        Tue, 11 Jul 2023 07:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2461C614E2;
        Tue, 11 Jul 2023 14:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EC0C433C7;
        Tue, 11 Jul 2023 14:24:05 +0000 (UTC)
Date:   Tue, 11 Jul 2023 10:24:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 03/10] eventfs: adding eventfs dir add functions
Message-ID: <20230711102403.3e65d1ec@gandalf.local.home>
In-Reply-To: <285B9992-4DFB-4343-BD64-DAE9CCEFEE6B@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <1685610013-33478-4-git-send-email-akaher@vmware.com>
        <20230701095417.3de5baab@rorschach.local.home>
        <ECB0097D-A323-4CFC-9C9E-D4DA2AA6E662@vmware.com>
        <20230703110857.2d051af5@rorschach.local.home>
        <84CA259A-8A99-471C-B44C-08D289972F43@vmware.com>
        <20230703155226.1ab27bc1@gandalf.local.home>
        <20230709215447.536defa6@rorschach.local.home>
        <285B9992-4DFB-4343-BD64-DAE9CCEFEE6B@vmware.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 10 Jul 2023 18:53:53 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> Something was broken in your mail (I guess cc list) and couldn’t reach to lkml or
> ignored by lkml. I just wanted to track the auto test results from linux-kselftest.

Below is the report from the tree I pushed. I guess I forgot to remove an
"idx" variable, and it also caught the unused functions you mentioned.

-- Steve


tree:   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace trace/rfc/eventfs
head:   1dc48374bb8ad8aec6d7244267f9b36e0512d3bb
commit: 1dc48374bb8ad8aec6d7244267f9b36e0512d3bb [28/28] tracefs: Add RCU and global mutex for eventfs
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230711/202307111415.tc8g7M63-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230711/202307111415.tc8g7M63-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307111415.tc8g7M63-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/tracefs/event_inode.c: In function 'eventfs_post_create_dir':
>> fs/tracefs/event_inode.c:236:13: warning: unused variable 'idx' [-Wunused-variable]  
     236 |         int idx;
         |             ^~~
   fs/tracefs/event_inode.c: At top level:
   fs/tracefs/event_inode.c:184:23: warning: 'eventfs_create_dir' defined but not used [-Wunused-function]
     184 | static struct dentry *eventfs_create_dir(const char *name, umode_t mode,
         |                       ^~~~~~~~~~~~~~~~~~
   fs/tracefs/event_inode.c:108:23: warning: 'eventfs_create_file' defined but not used [-Wunused-function]
     108 | static struct dentry *eventfs_create_file(const char *name, umode_t mode,
         |                       ^~~~~~~~~~~~~~~~~~~


vim +/idx +236 fs/tracefs/event_inode.c

   225	
   226	/**
   227	 * eventfs_post_create_dir - post create dir routine
   228	 * @ef: eventfs_file of recently created dir
   229	 *
   230	 * Files with-in eventfs dir should know dentry of parent dir
   231	 */
   232	static void eventfs_post_create_dir(struct eventfs_file *ef)
   233	{
   234		struct eventfs_file *ef_child;
   235		struct tracefs_inode *ti;
 > 236		int idx;  
   237	
   238		/* srcu lock already held */
   239		/* fill parent-child relation */
   240		list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
   241					 srcu_read_lock_held(&eventfs_srcu)) {
   242			ef_child->d_parent = ef->dentry;
   243		}
   244	
   245		ti = get_tracefs(ef->dentry->d_inode);
   246		ti->private = ef->ei;
   247	}
   248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

-- Steve
