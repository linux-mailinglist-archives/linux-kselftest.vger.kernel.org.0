Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7362D74497B
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jul 2023 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGANyr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Jul 2023 09:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjGANyc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Jul 2023 09:54:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F05F3C11;
        Sat,  1 Jul 2023 06:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8883C60B71;
        Sat,  1 Jul 2023 13:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A66C433C7;
        Sat,  1 Jul 2023 13:54:23 +0000 (UTC)
Date:   Sat, 1 Jul 2023 09:54:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     mhiramat@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com
Subject: Re: [PATCH v3 03/10] eventfs: adding eventfs dir add functions
Message-ID: <20230701095417.3de5baab@rorschach.local.home>
In-Reply-To: <1685610013-33478-4-git-send-email-akaher@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <1685610013-33478-4-git-send-email-akaher@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


FYI, all subjects should start with a capital letter:

 "eventfs: Implement eventfs dir creation functions"

On Thu,  1 Jun 2023 14:30:06 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Adding eventfs_file structure which will hold properties of file or dir.
> 
> Adding following functions to add dir in eventfs:
> 
> eventfs_create_events_dir() directly creates events dir with-in

			"within" is a proper word.

> tracing folder.
> 
> eventfs_add_subsystem_dir() adds the information of subsystem_dir to
> eventfs and dynamically creates subsystem_dir as and when requires.

  "as and when requires" does not make sense.

> 
> eventfs_add_dir() adds the information of dir (which is with-in

   "within"

> subsystem_dir) to eventfs and dynamically creates these dir as
> and when requires.

I'm guessing you want to say:

	eventfs_add_dir() adds the information of the dir, within a
	subsystem_dir, to eventfs and dynamically creates these
	directories when they are accessed.

> 
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
> ---
>  fs/tracefs/Makefile      |   1 +
>  fs/tracefs/event_inode.c | 272 +++++++++++++++++++++++++++++++++++++++
>  include/linux/tracefs.h  |  29 +++++
>  kernel/trace/trace.h     |   1 +
>  4 files changed, 303 insertions(+)
>  create mode 100644 fs/tracefs/event_inode.c
> 
> diff --git a/fs/tracefs/Makefile b/fs/tracefs/Makefile
> index 7c35a282b..73c56da8e 100644
> --- a/fs/tracefs/Makefile
> +++ b/fs/tracefs/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  tracefs-objs	:= inode.o
> +tracefs-objs	+= event_inode.o
>  
>  obj-$(CONFIG_TRACING)	+= tracefs.o
>  
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> new file mode 100644
> index 000000000..a48ce23c0
> --- /dev/null
> +++ b/fs/tracefs/event_inode.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  event_inode.c - part of tracefs, a pseudo file system for activating tracing
> + *
> + *  Copyright (C) 2020-22 VMware Inc, author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> + *  Copyright (C) 2020-22 VMware Inc, author: Ajay Kaher <akaher@vmware.com>
> + *
> + *  eventfs is used to show trace events with one set of dentries
> + *
> + *  eventfs stores meta-data of files/dirs and skip to create object of
> + *  inodes/dentries. As and when requires, eventfs will create the
> + *  inodes/dentries for only required files/directories. Also eventfs
> + *  would delete the inodes/dentries once no more requires but preserve
> + *  the meta data.
> + */
> +#include <linux/fsnotify.h>
> +#include <linux/fs.h>
> +#include <linux/namei.h>
> +#include <linux/security.h>
> +#include <linux/tracefs.h>
> +#include <linux/kref.h>
> +#include <linux/delay.h>
> +#include "internal.h"
> +
> +/**
> + * eventfs_dentry_to_rwsem - Return corresponding eventfs_rwsem
> + * @dentry: a pointer to dentry
> + *
> + * helper function to return crossponding eventfs_rwsem for given dentry
> + */
> +static struct rw_semaphore *eventfs_dentry_to_rwsem(struct dentry *dentry)
> +{
> +	if (S_ISDIR(dentry->d_inode->i_mode))
> +		return (struct rw_semaphore *)dentry->d_inode->i_private;
> +	else
> +		return (struct rw_semaphore *)dentry->d_parent->d_inode->i_private;
> +}
> +
> +/**
> + * eventfs_down_read - acquire read lock function
> + * @eventfs_rwsem: a pointer to rw_semaphore
> + *
> + * helper function to perform read lock. Nested locking requires because
> + * lookup(), release() requires read lock, these could be called directly
> + * or from open(), remove() which already hold the read/write lock.
> + */
> +static void eventfs_down_read(struct rw_semaphore *eventfs_rwsem)
> +{
> +	down_read_nested(eventfs_rwsem, SINGLE_DEPTH_NESTING);
> +}
> +
> +/**
> + * eventfs_up_read - release read lock function
> + * @eventfs_rwsem: a pointer to rw_semaphore
> + *
> + * helper function to release eventfs_rwsem lock if locked
> + */
> +static void eventfs_up_read(struct rw_semaphore *eventfs_rwsem)
> +{
> +	up_read(eventfs_rwsem);
> +}
> +
> +/**
> + * eventfs_down_write - acquire write lock function
> + * @eventfs_rwsem: a pointer to rw_semaphore
> + *
> + * helper function to perform write lock on eventfs_rwsem
> + */
> +static void eventfs_down_write(struct rw_semaphore *eventfs_rwsem)
> +{
> +	while (!down_write_trylock(eventfs_rwsem))
> +		msleep(10);

What's this loop for? Something like that needs a very good explanation
in a comment. Loops like these are usually a sign of a workaround for a
bug in the design, or worse, simply hides an existing bug.

> +}
> +
> +/**
> + * eventfs_up_write - release write lock function
> + * @eventfs_rwsem: a pointer to rw_semaphore
> + *
> + * helper function to perform write lock on eventfs_rwsem
> + */
> +static void eventfs_up_write(struct rw_semaphore *eventfs_rwsem)
> +{
> +	up_write(eventfs_rwsem);
> +}
> +
> +static const struct file_operations eventfs_file_operations = {
> +};
> +
> +static const struct inode_operations eventfs_root_dir_inode_operations = {
> +};
> +
> +/**
> + * eventfs_prepare_ef - helper function to prepare eventfs_file
> + * @name: a pointer to a string containing the name of the file/directory
> + *        to create.
> + * @mode: the permission that the file should have.
> + * @fop: a pointer to a struct file_operations that should be used for
> + *        this file/directory.
> + * @iop: a pointer to a struct inode_operations that should be used for
> + *        this file/directory.
> + * @data: a pointer to something that the caller will want to get to later
> + *        on.  The inode.i_private pointer will point to this value on
> + *        the open() call.
> + *
> + * This function allocate the fill eventfs_file structure.

   "allocates and fills the" ?

> + */
> +static struct eventfs_file *eventfs_prepare_ef(const char *name, umode_t mode,
> +					const struct file_operations *fop,
> +					const struct inode_operations *iop,
> +					void *data)
> +{
> +	struct eventfs_file *ef;
> +
> +	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
> +	if (!ef)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ef->name = kstrdup(name, GFP_KERNEL);
> +	if (!ef->name) {
> +		kfree(ef);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	if (S_ISDIR(mode)) {
> +		ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
> +		if (!ef->ei) {
> +			kfree(ef->name);
> +			kfree(ef);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +		INIT_LIST_HEAD(&ef->ei->e_top_files);
> +	} else {
> +		ef->ei = NULL;
> +	}
> +
> +	ef->iop = iop;
> +	ef->fop = fop;
> +	ef->mode = mode;
> +	ef->data = data;
> +	ef->dentry = NULL;
> +	ef->d_parent = NULL;
> +	ef->created = false;

No need for the initialization to NULL or even the false, as the
kzalloc() already did that.

> +	return ef;
> +}
> +
> +/**
> + * eventfs_create_events_dir - create the trace event structure
> + * @name: a pointer to a string containing the name of the directory to
> + *        create.

You don't need to add "a pointer" we can see it's a pointer. Just say:

 * @name: The name of the directory to create

Adding more makes it confusing to read.

> + * @parent: a pointer to the parent dentry for this file.  This should be a
> + *          directory dentry if set.  If this parameter is NULL, then the
> + *          directory will be created in the root of the tracefs filesystem.
> + * @eventfs_rwsem: a pointer to rw_semaphore

Same with all the descriptions.


> + *
> + * This function creates the top of the trace event directory.
> + */
> +struct dentry *eventfs_create_events_dir(const char *name,
> +					 struct dentry *parent,
> +					 struct rw_semaphore *eventfs_rwsem)

OK, I'm going to have to really look at this. Passing in a lock to the
API is just broken. We need to find a way to solve this another way.

I'm about to board a plane to JFK shortly, I'm hoping to play with this
while flying back.

-- Steve


> +{
> +	struct dentry *dentry = tracefs_start_creating(name, parent);
> +	struct eventfs_inode *ei;
> +	struct tracefs_inode *ti;
> +	struct inode *inode;
> +
> +	if (IS_ERR(dentry))
> +		return dentry;
> +
> +	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
> +	if (!ei)
> +		return ERR_PTR(-ENOMEM);
> +	inode = tracefs_get_inode(dentry->d_sb);
> +	if (unlikely(!inode)) {
> +		kfree(ei);
> +		tracefs_failed_creating(dentry);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	init_rwsem(eventfs_rwsem);
> +	INIT_LIST_HEAD(&ei->e_top_files);
> +
> +	ti = get_tracefs(inode);
> +	ti->flags |= TRACEFS_EVENT_INODE;
> +	ti->private = ei;
> +
> +	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> +	inode->i_op = &eventfs_root_dir_inode_operations;
> +	inode->i_fop = &eventfs_file_operations;
> +	inode->i_private = eventfs_rwsem;
> +
> +	/* directory inodes start off with i_nlink == 2 (for "." entry) */
> +	inc_nlink(inode);
> +	d_instantiate(dentry, inode);
> +	inc_nlink(dentry->d_parent->d_inode);
> +	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
> +	return tracefs_end_creating(dentry);
> +}
