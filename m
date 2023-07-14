Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613C9754537
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 00:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjGNW6a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGNW63 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 18:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7BB35A4;
        Fri, 14 Jul 2023 15:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EC9C61E07;
        Fri, 14 Jul 2023 22:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E7EC433C7;
        Fri, 14 Jul 2023 22:58:26 +0000 (UTC)
Date:   Fri, 14 Jul 2023 18:58:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 00/10] tracing: introducing eventfs
Message-ID: <20230714185824.62556254@gandalf.local.home>
In-Reply-To: <1689248004-8158-1-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 13 Jul 2023 17:03:14 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Events Tracing infrastructure contains lot of files, directories
> (internally in terms of inodes, dentries). And ends up by consuming
> memory in MBs. We can have multiple events of Events Tracing, which
> further requires more memory.
> 
> Instead of creating inodes/dentries, eventfs could keep meta-data and
> skip the creation of inodes/dentries. As and when require, eventfs will
> create the inodes/dentries only for required files/directories.
> Also eventfs would delete the inodes/dentries once no more requires
> but preserve the meta data.
> 
> Tracing events took ~9MB, with this approach it took ~4.5MB
> for ~10K files/dir.

I think we are very close to getting this in for the next merge window. I
ran several tests and so far it's holding up!

I made a bunch of nits for this series, but nothing major. Mostly fixing up
change logs and comments, as well as some naming conventions and
reorganizing the series a little bit.

Anyway, I'm hoping that v5 will be ready to go into linux-next.

Thanks a lot Ajay for working on this!

-- Steve


> 
> v3:
> Patch 3,4,5,7,9:
>          removed all the eventfs_rwsem code and replaced it with an srcu
>          lock for the readers, and a mutex to synchronize the writers of
>          the list.
> 
> Patch 2: moved 'tracefs_inode' and 'get_tracefs()' to v4 03/10
> 
> Patch 3: moved the struct eventfs_file and eventfs_inode into event_inode.c
>          as it really should not be exposed to all users.
> 
> Patch 5: added a recursion check to eventfs_remove_rec() as it is really
>          dangerous to have unchecked recursion in the kernel (we do have
>          a fixed size stack).
> 
>          have the free use srcu callbacks. After the srcu grace periods
>          are done, it adds the eventfs_file onto a llist (lockless link
>          list) and wakes up a work queue. Then the work queue does the
>          freeing (this needs to be done in task/workqueue context, as
>          srcu callbacks are done in softirq context).
> 
> Patch 6: renamed:
>          eventfs_create_file() -> create_file()
>          eventfs_create_dir() -> create_dir()
> 
> v2:
> Patch 01: new patch:'Require all trace events to have a TRACE_SYSTEM'
> Patch 02: moved from v1 1/9
> Patch 03: moved from v1 2/9
>           As suggested by Zheng Yejian, introduced eventfs_prepare_ef()
>           helper function to add files or directories to eventfs
>           fix WARNING reported by kernel test robot in v1 8/9
> Patch 04: moved from v1 3/9
>           used eventfs_prepare_ef() to add files
>           fix WARNING reported by kernel test robot in v1 8/9
> Patch 05: moved from v1 4/9
>           fix compiling warning reported by kernel test robot in v1 4/9
> Patch 06: moved from v1 5/9
> Patch 07: moved from v1 6/9
> Patch 08: moved from v1 7/9
> Patch 09: moved from v1 8/9
>           rebased because of v3 01/10
> Patch 10: moved from v1 9/9
> 
> v1:
> Patch 1: add header file
> Patch 2: resolved kernel test robot issues
>          protecting eventfs lists using nested eventfs_rwsem
> Patch 3: protecting eventfs lists using nested eventfs_rwsem
> Patch 4: improve events cleanup code to fix crashes
> Patch 5: resolved kernel test robot issues
>          removed d_instantiate_anon() calls
> Patch 6: resolved kernel test robot issues
>          fix kprobe test in eventfs_root_lookup()
>          protecting eventfs lists using nested eventfs_rwsem
> Patch 7: remove header file
> Patch 8: pass eventfs_rwsem as argument to eventfs functions
>          called eventfs_remove_events_dir() instead of tracefs_remove()
>          from event_trace_del_tracer()
> Patch 9: new patch to fix kprobe test case
> 
> Ajay Kaher (9):
>   tracefs: Rename some tracefs function
>   eventfs: Implement eventfs dir creation functions
>   eventfs: Implement eventfs file add functions
>   eventfs: Implement eventfs file, directory remove function
>   eventfs: Implement functions to create eventfs files and directories
>   eventfs: Implement eventfs lookup, read, open functions
>   eventfs: Implement tracefs_inode_cache
>   eventfs: Move tracing/events to eventfs
>   test: ftrace: Fix kprobe test for eventfs
> 
> Steven Rostedt (Google) (1):
>   tracing: Require all trace events to have a TRACE_SYSTEM
> 
>  fs/tracefs/Makefile                           |   1 +
>  fs/tracefs/event_inode.c                      | 711 ++++++++++++++++++
>  fs/tracefs/inode.c                            | 124 ++-
>  fs/tracefs/internal.h                         |  25 +
>  include/linux/trace_events.h                  |   1 +
>  include/linux/tracefs.h                       |  32 +
>  kernel/trace/trace.h                          |   2 +-
>  kernel/trace/trace_events.c                   |  78 +-
>  .../ftrace/test.d/kprobe/kprobe_args_char.tc  |   4 +-
>  .../test.d/kprobe/kprobe_args_string.tc       |   4 +-
>  10 files changed, 930 insertions(+), 52 deletions(-)
>  create mode 100644 fs/tracefs/event_inode.c
>  create mode 100644 fs/tracefs/internal.h
> 

