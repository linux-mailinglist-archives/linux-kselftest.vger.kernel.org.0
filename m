Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC7A42B1CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 03:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbhJMBJ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 21:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234321AbhJMBJ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 21:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634087245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9W5/Nim7UR99mhQj6VlGoOdNyQkVOGVgooJgVby/UVQ=;
        b=DJyaTYAGVUCm+fAZpcxjd0AGXg/mjRP//WCQR/8E2KumLQqPK4MjT3dBD+J/BHeJJLCwdY
        b4wI+iUUOqj79LaEGIb6AjG/rv3HdibCX+heA+gJmpL7wlSD7/LwwWDsgXZruijtlA1npK
        y9JqWZebV81DjsXcUlWsiQlTKQWqJfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-HxK1RB5_PS67AtBc8N0hMg-1; Tue, 12 Oct 2021 21:07:22 -0400
X-MC-Unique: HxK1RB5_PS67AtBc8N0hMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF65169721;
        Wed, 13 Oct 2021 01:07:19 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 145D660D30;
        Wed, 13 Oct 2021 01:07:09 +0000 (UTC)
Date:   Wed, 13 Oct 2021 09:07:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YWYxN875B6rlmAjC@T590>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-10-mcgrof@kernel.org>
 <YVwZwh7qDKfSM59h@T590>
 <YWSr2trabEJflzlj@bombadil.infradead.org>
 <YWTU3kTlJKONyFjZ@T590>
 <YWX7pAn0YMaJeJBA@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWX7pAn0YMaJeJBA@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 12, 2021 at 02:18:28PM -0700, Luis Chamberlain wrote:
> On Tue, Oct 12, 2021 at 08:20:46AM +0800, Ming Lei wrote:
> > On Mon, Oct 11, 2021 at 02:25:46PM -0700, Luis Chamberlain wrote:
> > > On Tue, Oct 05, 2021 at 05:24:18PM +0800, Ming Lei wrote:
> > > > On Mon, Sep 27, 2021 at 09:38:02AM -0700, Luis Chamberlain wrote:
> > > > > When driver sysfs attributes use a lock also used on module removal we
> > > > > can race to deadlock. This happens when for instance a sysfs file on
> > > > > a driver is used, then at the same time we have module removal call
> > > > > trigger. The module removal call code holds a lock, and then the
> > > > > driver's sysfs file entry waits for the same lock. While holding the
> > > > > lock the module removal tries to remove the sysfs entries, but these
> > > > > cannot be removed yet as one is waiting for a lock. This won't complete
> > > > > as the lock is already held. Likewise module removal cannot complete,
> > > > > and so we deadlock.
> > > > > 
> > > > > This can now be easily reproducible with our sysfs selftest as follows:
> > > > > 
> > > > > ./tools/testing/selftests/sysfs/sysfs.sh -t 0027
> > > > > 
> > > > > This uses a local driver lock. Test 0028 can also be used, that uses
> > > > > the rtnl_lock():
> > > > > 
> > > > > ./tools/testing/selftests/sysfs/sysfs.sh -t 0028
> > > > > 
> > > > > To fix this we extend the struct kernfs_node with a module reference
> > > > > and use the try_module_get() after kernfs_get_active() is called. As
> > > > > documented in the prior patch, we now know that once kernfs_get_active()
> > > > > is called the module is implicitly guarded to exist and cannot be removed.
> > > > > This is because the module is the one in charge of removing the same
> > > > > sysfs file it created, and removal of sysfs files on module exit will wait
> > > > > until they don't have any active references. By using a try_module_get()
> > > > > after kernfs_get_active() we yield to let module removal trump calls to
> > > > > process a sysfs operation, while also preventing module removal if a sysfs
> > > > > operation is in already progress. This prevents the deadlock.
> > > > > 
> > > > > This deadlock was first reported with the zram driver, however the live
> > > > 
> > > > Looks not see the lock pattern you mentioned in zram driver, can you
> > > > share the related zram code?
> > > 
> > > I recommend to not look at the zram driver, instead look at the
> > > test_sysfs driver as that abstracts the issue more clearly and uses
> > 
> > Looks test_sysfs isn't in linus tree, where can I find it?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-sysfs-generic-deadlock-fix
> 
> > Also please
> > update your commit log about this wrong info if it can't be applied on
> > zram.
> 
> It does apply to zram, it is just that I have other fixes for zram in
> my pipeline which will change the zram driver further, and so what makes
> more sense is to abstract the issue into a selftest driver to
> demonstrate the issue more clearly.
> 
> To reproduce the deadlock revert the patch in this thread and then run
> either of these two tests as root:
> 
> ./tools/testing/selftests/sysfs/sysfs.sh -w 0027
> ./tools/testing/selftests/sysfs/sysfs.sh -w 0028
> 
> You will need to enable the test_sysfs driver.
> 
> > > two different locks as an example. The point is that if on module
> > > removal *any* lock is used which is *also* used on the sysfs file
> > > created by the module, you can deadlock.
> > > 
> > > > > And this can lead to this condition:
> > > > > 
> > > > > CPU A                              CPU B
> > > > >                                    foo_store()
> > > > > foo_exit()
> > > > >   mutex_lock(&foo)
> > > > >                                    mutex_lock(&foo)
> > > > >    del_gendisk(some_struct->disk);
> > > > >      device_del()
> > > > >        device_remove_groups()
> > > > 
> > > > I guess the deadlock exists if foo_exit() is called anywhere. If yes,
> > > > look the issue may not be related with removing module directly, right?
> > > 
> > > No, the reason this can deadlock is that the module exit routine will
> > > patiently wait for the sysfs / kernfs files to be stop being used,
> > 
> > Can you share the code which waits for the sysfs / kernfs files to be
> > stop being used?
> 
> How about a call trace of the two tasks which deadlock, here is one of
> running test 0027:
> 
> kdevops login: [  363.875459] INFO: task sysfs.sh:1271 blocked for more
> than 120 seconds.
> [  363.878341]       Tainted: G            E
> 5.15.0-rc3-next-20210927+ #83
> [  363.881218] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  363.882255] task:sysfs.sh        state:D stack:    0 pid: 1271 ppid:
> 1 flags:0x00000004
> [  363.882894] Call Trace:
> [  363.883091]  <TASK>
> [  363.883259]  __schedule+0x2fd/0x990
> [  363.883551]  schedule+0x43/0xe0
> [  363.883800]  schedule_preempt_disabled+0x14/0x20
> [  363.884160]  __mutex_lock.constprop.0+0x249/0x470
> [  363.884524]  test_dev_x_store+0xa5/0xc0 [test_sysfs]
> [  363.884915]  kernfs_fop_write_iter+0x177/0x220
> [  363.885257]  new_sync_write+0x11c/0x1b0
> [  363.885556]  vfs_write+0x20d/0x2a0
> [  363.885821]  ksys_write+0x5f/0xe0
> [  363.886081]  do_syscall_64+0x38/0xc0
> [  363.886359]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  363.886748] RIP: 0033:0x7fee00f8bf33
> [  363.887029] RSP: 002b:00007ffd372c5d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  363.887633] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fee00f8bf33
> [  363.888217] RDX: 0000000000000003 RSI: 000055a4d14a0db0 RDI: 0000000000000001
> [  363.888761] RBP: 000055a4d14a0db0 R08: 000000000000000a R09: 0000000000000002
> [  363.889267] R10: 000055a4d1554ac0 R11: 0000000000000246 R12: 0000000000000003
> [  363.889983] R13: 00007fee0105c6a0 R14: 0000000000000003 R15: 00007fee0105c8a0
> [  363.890513]  </TASK>
> [  363.890709] INFO: task modprobe:1276 blocked for more than 120 seconds.
> [  363.891185]       Tainted: G            E 5.15.0-rc3-next-20210927+ #83
> [  363.891781] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.892353] task:modprobe        state:D stack:    0 pid: 1276 ppid: 1 flags:0x00004000
> [  363.892955] Call Trace:
> [  363.893141]  <TASK>
> [  363.893457]  __schedule+0x2fd/0x990
> [  363.893865]  schedule+0x43/0xe0
> [  363.894246]  __kernfs_remove.part.0+0x21e/0x2a0
> [  363.894704]  ? do_wait_intr_irq+0xa0/0xa0
> [  363.895142]  kernfs_remove_by_name_ns+0x50/0x90
> [  363.895632]  remove_files+0x2b/0x60
> [  363.896035]  sysfs_remove_group+0x38/0x80
> [  363.896470]  sysfs_remove_groups+0x29/0x40
> [  363.896912]  device_remove_attrs+0x5b/0x90
> [  363.897352]  device_del+0x183/0x400
> [  363.897758]  unregister_test_dev_sysfs+0x5b/0xaa [test_sysfs]
> [  363.898317]  test_sysfs_exit+0x45/0xfb0 [test_sysfs]
> [  363.898833]  __do_sys_delete_module+0x18d/0x2a0
> [  363.899329]  ? fpregs_assert_state_consistent+0x1e/0x40
> [  363.899868]  ? exit_to_user_mode_prepare+0x3a/0x180
> [  363.900390]  do_syscall_64+0x38/0xc0
> [  363.900810]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  363.901330] RIP: 0033:0x7f21915c57d7
> [  363.901747] RSP: 002b:00007ffd90869fe8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [  363.902442] RAX: ffffffffffffffda RBX: 000055ce676ffc30 RCX: 00007f21915c57d7
> [  363.903104] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055ce676ffc98
> [  363.903782] RBP: 000055ce676ffc30 R08: 0000000000000000 R09: 0000000000000000
> [  363.904462] R10: 00007f2191638ac0 R11: 0000000000000206 R12: 000055ce676ffc98
> [  363.905128] R13: 0000000000000000 R14: 0000000000000000 R15: 000055ce676ffdf0
> [  363.905797]  </TASK>

That doesn't show the deadlock is related with module_exit().

> 
> 
> And gdb:
> 
> (gdb) l *(__kernfs_remove+0x21e)
> 0xffffffff8139288e is in __kernfs_remove (fs/kernfs/dir.c:476).
> 471                     if (atomic_read(&kn->active) != KN_DEACTIVATED_BIAS)
> 472                             lock_contended(&kn->dep_map, _RET_IP_);
> 473             }
> 474
> 475             /* but everyone should wait for draining */
> 476             wait_event(root->deactivate_waitq,
> 477                        atomic_read(&kn->active) == KN_DEACTIVATED_BIAS);
> 478
> 479             if (kernfs_lockdep(kn)) {
> 480                     lock_acquired(&kn->dep_map, _RET_IP_);
> 
> (gdb) l *(kernfs_remove_by_name_ns+0x50)
> 0xffffffff813938d0 is in kernfs_remove_by_name_ns (fs/kernfs/dir.c:1534).
> 1529
> 1530            kn = kernfs_find_ns(parent, name, ns);
> 1531            if (kn)
> 1532                    __kernfs_remove(kn);
> 1533
> 1534            up_write(&kernfs_rwsem);
> 1535
> 1536            if (kn)
> 1537                    return 0;
> 1538            else
> 
> The same happens for test 0028 except instead of a mutex
> lock an rtnl_lock() is used.
> 
> Would this be better for the commit log?
> 
> > And why does it make a difference in case of being
> > called from module_exit()?
> 
> Well because that is where we remove the sysfs files. *If*
> a developer happens to use a lock on a sysfs op but it is
> also used on module exit, this deadlock is bound to happen.

It is clearly one AA deadlock, what I meant was that it isn't related with
module exit cause lock & device_del() isn't always done in module exit, so
I doubt your fix with grabbing module refcnt is good or generic enough.

Except for your cooked test_sys module, how many real drivers do suffer the
problem? What are they? Why can't we fix the exact driver?


Thanks,
Ming

