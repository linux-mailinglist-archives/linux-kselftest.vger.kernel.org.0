Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C568F759821
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 16:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGSOYS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjGSOYM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 10:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E222126;
        Wed, 19 Jul 2023 07:23:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A249F6163F;
        Wed, 19 Jul 2023 14:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF2CC433C8;
        Wed, 19 Jul 2023 14:23:12 +0000 (UTC)
Date:   Wed, 19 Jul 2023 10:23:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>, Nadav Amit <namit@vmware.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 00/10] tracing: introducing eventfs
Message-ID: <20230719102310.552d3356@gandalf.local.home>
In-Reply-To: <2CD72098-08E2-4CAA-B74D-D8C44D318117@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <20230714185824.62556254@gandalf.local.home>
        <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
        <20230718094005.32516161@gandalf.local.home>
        <2CD72098-08E2-4CAA-B74D-D8C44D318117@vmware.com>
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

On Wed, 19 Jul 2023 10:25:28 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> - Is it also reproducible on v3?
> - Is it manually reproducible or reproducible using any specific script?
> 
> Let me know if I can help.

Just tried it against v3, and it gave me the splat that I originally had
and starting to fix, which now gives me another splat. I'll spend a couple
more days on it and start sharing code and seeing if we can work together
on this.

Here's the reproducer (of both v3 splat and the bug I'm hitting now).

 ~# echo 'p:sock_getattr 0xffffffff9b55cef0 sk=%di' > /sys/kernel/tracing/kprobe_events
 ~# ls /sys/kernel/debug/tracing/events/kprobes/sock_getattr/
 ~# echo '-:sock_getattr 0xffffffff9b55cef0 sk=%di' > /sys/kernel/tracing/kprobe_events

v3 gives me (and my updates too)

======================================================
 WARNING: possible circular locking dependency detected
 6.5.0-rc1-test+ #576 Not tainted
 ------------------------------------------------------
 trace-cmd/840 is trying to acquire lock:
 ffff8881007e5de0 (&sb->s_type->i_mutex_key#5){++++}-{3:3}, at: dcache_dir_open_wrapper+0xc1/0x1b0
 
 but task is already holding lock:
 ffff888103ad7e70 (eventfs_rwsem/1){.+.+}-{3:3}, at: dcache_dir_open_wrapper+0x6f/0x1b0
 
 which lock already depends on the new lock.

 
 the existing dependency chain (in reverse order) is:
 
 -> #1 (eventfs_rwsem/1){.+.+}-{3:3}:
        down_read_nested+0x41/0x180
        eventfs_root_lookup+0x42/0x120
        __lookup_slow+0xff/0x1b0
        walk_component+0xdb/0x150
        path_lookupat+0x67/0x1a0
        filename_lookup+0xe4/0x1f0
        vfs_statx+0x9e/0x180
        vfs_fstatat+0x51/0x70
        __do_sys_newfstatat+0x3f/0x80
        do_syscall_64+0x3a/0xc0
        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 
 -> #0 (&sb->s_type->i_mutex_key#5){++++}-{3:3}:
        __lock_acquire+0x165d/0x2390
        lock_acquire+0xd4/0x2d0
        down_write+0x3b/0xd0
        dcache_dir_open_wrapper+0xc1/0x1b0
        do_dentry_open+0x20c/0x510
        path_openat+0x7ad/0xc60
        do_filp_open+0xaf/0x160
        do_sys_openat2+0xab/0xe0
        __x64_sys_openat+0x6a/0xa0
        do_syscall_64+0x3a/0xc0
        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 
 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   rlock(eventfs_rwsem/1);
                                lock(&sb->s_type->i_mutex_key#5);
                                lock(eventfs_rwsem/1);
   lock(&sb->s_type->i_mutex_key#5);
 
  *** DEADLOCK ***

 1 lock held by trace-cmd/840:
  #0: ffff888103ad7e70 (eventfs_rwsem/1){.+.+}-{3:3}, at: dcache_dir_open_wrapper+0x6f/0x1b0
 
 stack backtrace:
 CPU: 7 PID: 840 Comm: trace-cmd Not tainted 6.5.0-rc1-test+ #576
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x57/0x90
  check_noncircular+0x14b/0x160
  __lock_acquire+0x165d/0x2390
  lock_acquire+0xd4/0x2d0
  ? dcache_dir_open_wrapper+0xc1/0x1b0
  down_write+0x3b/0xd0
  ? dcache_dir_open_wrapper+0xc1/0x1b0
  dcache_dir_open_wrapper+0xc1/0x1b0
  ? __pfx_dcache_dir_open_wrapper+0x10/0x10
  do_dentry_open+0x20c/0x510
  path_openat+0x7ad/0xc60
  do_filp_open+0xaf/0x160
  do_sys_openat2+0xab/0xe0
  __x64_sys_openat+0x6a/0xa0
  do_syscall_64+0x3a/0xc0
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 RIP: 0033:0x7f1743267e41
 Code: 44 24 18 31 c0 41 83 e2 40 75 3e 89 f0 25 00 00 41 00 3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 3f 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
 RSP: 002b:00007ffec10ff5d0 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1743267e41
 RDX: 0000000000090800 RSI: 00007ffec10ffdb0 RDI: 00000000ffffff9c
 RBP: 00007ffec10ffda0 R08: 00007ffec11003e0 R09: 0000000000000040
 R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffec11003e0
 R13: 0000000000000040 R14: 0000000000000000 R15: 00007ffec110034b
  </TASK>


I moved the code around a bit, and it appears that kprobes is getting
dput() more than once.

I moved the d_invalidate() and dput() into the workqueue function, and on
kprobes going away, d_invalidate() frees it, and dput() is now corrupted.

Still investigating. The VFS layer is a magic box that needs the right
wizard hat to deal with, but I unfortunately am waiting on back order to
retrieve that specific hat :-p

-- Steve
