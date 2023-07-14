Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F13753F36
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjGNPoS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjGNPoR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 11:44:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95B30F8;
        Fri, 14 Jul 2023 08:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45ABA61D55;
        Fri, 14 Jul 2023 15:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207EDC433C8;
        Fri, 14 Jul 2023 15:44:13 +0000 (UTC)
Date:   Fri, 14 Jul 2023 11:44:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 03/10] eventfs: Implement eventfs dir creation
 functions
Message-ID: <20230714114410.353ff8b7@gandalf.local.home>
In-Reply-To: <1689248004-8158-4-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-4-git-send-email-akaher@vmware.com>
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


Some more nits.

On Thu, 13 Jul 2023 17:03:17 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Adding eventfs_file structure which will hold properties of file or dir.

Add eventfs_file structure which will hold the properties of the eventfs
files and directories.

> 
> Adding following functions to add dir in eventfs:

Add following functions to create the directories in eventfs:

> 
> eventfs_create_events_dir() will directly create events dir within
> tracing folder.

eventfs_create_events_dir() will create the top level "events" directory
within the tracefs file system.

> 
> eventfs_add_subsystem_dir() adds the information of subsystem_dir
> to eventfs, and dynamically creates subsystem_dir directories when
> they are accessed.

eventfs_add_subsystem_dir() creates an eventfs_file descriptor with the
given name of the subsystem.

> 
> eventfs_add_dir() adds the information of the dir, within a
> subsystem_dir, to eventfs and dynamically creates these directories
> when they are accessed.

eventfs_add_dir() creates an eventfs_file descriptor with the given name of
the directory and attached to a eventfs_file of a subsystem.

> 
> Adding tracefs_inode structure, this will help eventfs to keep track
> of inode, flags and pointer to private date.

Add tracefs_inode structure to hold the inodes, flags and pointers to
private data used by eventfs.

> 
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
> ---
>  fs/tracefs/Makefile      |   1 +
>  fs/tracefs/event_inode.c | 217 +++++++++++++++++++++++++++++++++++++++
>  fs/tracefs/inode.c       |   8 +-
>  fs/tracefs/internal.h    |  25 +++++
>  include/linux/tracefs.h  |  11 ++
>  5 files changed, 258 insertions(+), 4 deletions(-)
>  create mode 100644 fs/tracefs/event_inode.c
>  create mode 100644 fs/tracefs/internal.h
> 
> diff --git a/fs/tracefs/Makefile b/fs/tracefs/Makefile
> index 7c35a282b484..73c56da8e284 100644
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
> index 000000000000..4e7a8eccaa0b
> --- /dev/null
> +++ b/fs/tracefs/event_inode.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  event_inode.c - part of tracefs, a pseudo file system for activating tracing
> + *
> + *  Copyright (C) 2020-22 VMware Inc, author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> + *  Copyright (C) 2020-22 VMware Inc, author: Ajay Kaher <akaher@vmware.com>
> + *
> + *  eventfs is used to show trace events with one set of dentries

 eventfs is used to dynamically create inodes and dentries based on the
 meta data provided by the tracing system.


> + *
> + *  eventfs stores meta-data of files/dirs and skip to create object of
> + *  inodes/dentries. As and when requires, eventfs will create the
> + *  inodes/dentries for only required files/directories. Also eventfs
> + *  would delete the inodes/dentries once no more requires but preserve
> + *  the meta data.

 eventfs stores the meta-data of files/dirs and holds off on creating
 inodes/dentries of the files. When accessed, the eventfs will create the
 inodes/dentries in a just-in-time (JIT) manner. The eventfs will clean up
 and delete the inodes/dentries when they are no longer referenced.


> + */
> +#include <linux/fsnotify.h>
> +#include <linux/fs.h>
> +#include <linux/namei.h>
> +#include <linux/workqueue.h>
> +#include <linux/security.h>
> +#include <linux/tracefs.h>
> +#include <linux/kref.h>
> +#include <linux/delay.h>
> +#include "internal.h"
> +
> +struct eventfs_inode {
> +	struct list_head	e_top_files;
> +};
> +

We probably want to document the below structure, and only add 
fields as they are added by the patches.

> +struct eventfs_file {
> +	const char			*name;
> +	struct dentry			*d_parent;
> +	struct dentry			*dentry;

dentry is never assigned, although at the end in eventfs_add_dir() we have:

	ef->d_parent = ef_parent->dentry;

Both the above assignment and entry in the structure should be removed from
this patch. It makes it easier to review. Because that assignment is
meaningless. When the above line is added in later patches, it should have
meaning.

When breaking up patches, you don't just want to cut and paste in blocks of
functions. You want to build the functionality, so the added code makes
sense.

> +	struct list_head		list;
> +	struct eventfs_inode		*ei;
> +	const struct file_operations	*fop;
> +	const struct inode_operations	*iop;

> +	union {
> +		struct rcu_head		rcu;
> +		struct llist_node	llist;  /* For freeing after RCU */
> +	};

The above union should be added when the clean up code is added.

> +	void				*data;
> +	umode_t				mode;

> +	bool				created;

The "created" field should be added when its use case is added.

> +};
> +
> +static DEFINE_MUTEX(eventfs_mutex);
> +
> +static const struct file_operations eventfs_file_operations = {
> +};
> +
> +static const struct inode_operations eventfs_root_dir_inode_operations = {
> +};
> +
> +/**
> + * eventfs_prepare_ef - helper function to prepare eventfs_file
> + * @name: the name of the file/directory to create.
> + * @mode: the permission that the file should have.
> + * @fop: struct file_operations that should be used for this file/directory.
> + * @iop: struct inode_operations that should be used for this file/directory.
> + * @data: something that the caller will want to get to later on. The
> + *        inode.i_private pointer will point to this value on the open() call.
> + *
> + * This function allocates and fills the eventfs_file structure.
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
> +	return ef;
> +}
> +
> +/**
> + * eventfs_create_events_dir - create the trace event structure
> + * @name: the name of the directory to create.
> + * @parent: parent dentry for this file.  This should be a directory dentry
> + *          if set.  If this parameter is NULL, then the directory will be
> + *          created in the root of the tracefs filesystem.
> + *
> + * This function creates the top of the trace event directory.
> + */
> +struct dentry *eventfs_create_events_dir(const char *name,
> +					 struct dentry *parent)
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
> +	INIT_LIST_HEAD(&ei->e_top_files);
> +
> +	ti = get_tracefs(inode);
> +	ti->flags |= TRACEFS_EVENT_INODE;
> +	ti->private = ei;
> +
> +	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> +	inode->i_op = &eventfs_root_dir_inode_operations;
> +	inode->i_fop = &eventfs_file_operations;
> +
> +	/* directory inodes start off with i_nlink == 2 (for "." entry) */
> +	inc_nlink(inode);
> +	d_instantiate(dentry, inode);
> +	inc_nlink(dentry->d_parent->d_inode);
> +	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
> +	return tracefs_end_creating(dentry);
> +}
> +
> +/**
> + * eventfs_add_subsystem_dir - add eventfs subsystem_dir to list to create later
> + * @name: the name of the file to create.
> + * @parent: parent dentry for this dir.
> + *
> + * This function adds eventfs subsystem dir to list.
> + * And all these dirs are created on the fly when they are looked up,
> + * and the dentry and inodes will be removed when they are done.
> + */
> +struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
> +					       struct dentry *parent)
> +{
> +	struct tracefs_inode *ti_parent;
> +	struct eventfs_inode *ei_parent;
> +	struct eventfs_file *ef;
> +
> +	if (!parent)
> +		return ERR_PTR(-EINVAL);
> +
> +	ti_parent = get_tracefs(parent->d_inode);
> +	ei_parent = ti_parent->private;
> +
> +	ef = eventfs_prepare_ef(name,
> +		S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
> +		&eventfs_file_operations,
> +		&eventfs_root_dir_inode_operations, NULL);
> +
> +	if (IS_ERR(ef))
> +		return ef;
> +
> +	mutex_lock(&eventfs_mutex);
> +	list_add_tail(&ef->list, &ei_parent->e_top_files);
> +	ef->d_parent = parent;
> +	mutex_unlock(&eventfs_mutex);
> +	return ef;
> +}
> +
> +/**
> + * eventfs_add_dir - add eventfs dir to list to create later
> + * @name: the name of the file to create.
> + * @ef_parent: parent eventfs_file for this dir.
> + *
> + * This function adds eventfs dir to list.
> + * And all these dirs are created on the fly when they are looked up,
> + * and the dentry and inodes will be removed when they are done.
> + */
> +struct eventfs_file *eventfs_add_dir(const char *name,
> +				     struct eventfs_file *ef_parent)
> +{
> +	struct eventfs_file *ef;
> +
> +	if (!ef_parent)
> +		return ERR_PTR(-EINVAL);
> +
> +	ef = eventfs_prepare_ef(name,
> +		S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
> +		&eventfs_file_operations,
> +		&eventfs_root_dir_inode_operations, NULL);
> +
> +	if (IS_ERR(ef))
> +		return ef;
> +
> +	mutex_lock(&eventfs_mutex);
> +	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);

> +	ef->d_parent = ef_parent->dentry;

As mentioned above. Let's not add the above assignment yet, as the
ef_parent->dentry will not be anything but NULL here.

-- Steve


> +	mutex_unlock(&eventfs_mutex);
> +	return ef;
> +}
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index b0348efc0238..7ef3a02766f5 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -127,7 +127,7 @@ static const struct inode_operations tracefs_dir_inode_operations = {
>  	.rmdir		= tracefs_syscall_rmdir,
>  };
>  
> -static struct inode *tracefs_get_inode(struct super_block *sb)
> +struct inode *tracefs_get_inode(struct super_block *sb)
>  {
>  	struct inode *inode = new_inode(sb);
>  	if (inode) {
> @@ -399,7 +399,7 @@ static struct file_system_type trace_fs_type = {
>  };
>  MODULE_ALIAS_FS("tracefs");
>  
> -static struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
> +struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
>  {
>  	struct dentry *dentry;
>  	int error;
> @@ -437,7 +437,7 @@ static struct dentry *tracefs_start_creating(const char *name, struct dentry *pa
>  	return dentry;
>  }
>  
> -static struct dentry *tracefs_failed_creating(struct dentry *dentry)
> +struct dentry *tracefs_failed_creating(struct dentry *dentry)
>  {
>  	inode_unlock(d_inode(dentry->d_parent));
>  	dput(dentry);
> @@ -445,7 +445,7 @@ static struct dentry *tracefs_failed_creating(struct dentry *dentry)
>  	return NULL;
>  }
>  
> -static struct dentry *tracefs_end_creating(struct dentry *dentry)
> +struct dentry *tracefs_end_creating(struct dentry *dentry)
>  {
>  	inode_unlock(d_inode(dentry->d_parent));
>  	return dentry;
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> new file mode 100644
> index 000000000000..c443a0c32a8c
> --- /dev/null
> +++ b/fs/tracefs/internal.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TRACEFS_INTERNAL_H
> +#define _TRACEFS_INTERNAL_H
> +
> +enum {
> +	TRACEFS_EVENT_INODE     = BIT(1),
> +};
> +
> +struct tracefs_inode {
> +	unsigned long           flags;
> +	void                    *private;
> +	struct inode            vfs_inode;
> +};
> +
> +static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
> +{
> +	return container_of(inode, struct tracefs_inode, vfs_inode);
> +}
> +
> +struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
> +struct dentry *tracefs_end_creating(struct dentry *dentry);
> +struct dentry *tracefs_failed_creating(struct dentry *dentry);
> +struct inode *tracefs_get_inode(struct super_block *sb);
> +
> +#endif /* _TRACEFS_INTERNAL_H */
> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index 99912445974c..432e5e6f7901 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -21,6 +21,17 @@ struct file_operations;
>  
>  #ifdef CONFIG_TRACING
>  
> +struct eventfs_file;
> +
> +struct dentry *eventfs_create_events_dir(const char *name,
> +					 struct dentry *parent);
> +
> +struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
> +					       struct dentry *parent);
> +
> +struct eventfs_file *eventfs_add_dir(const char *name,
> +				     struct eventfs_file *ef_parent);
> +
>  struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  				   struct dentry *parent, void *data,
>  				   const struct file_operations *fops);

