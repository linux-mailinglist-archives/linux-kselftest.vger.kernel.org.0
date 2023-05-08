Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B896FA360
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 May 2023 11:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjEHJcd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 05:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEHJcT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 05:32:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE82269E;
        Mon,  8 May 2023 02:32:11 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QFGHk3MWHzpWB4;
        Mon,  8 May 2023 17:30:58 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 17:32:09 +0800
Message-ID: <ba8b6072-42b6-4275-83fd-5497654d77db@huawei.com>
Date:   Mon, 8 May 2023 17:32:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/9] eventfs: adding eventfs dir add functions
Content-Language: en-US
To:     Ajay Kaher <akaher@vmware.com>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <chinglinyu@google.com>,
        <namit@vmware.com>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <amakhalov@vmware.com>,
        <vsirnapalli@vmware.com>, <tkundu@vmware.com>,
        <er.ajay.kaher@gmail.com>
References: <1683026600-13485-1-git-send-email-akaher@vmware.com>
 <1683026600-13485-3-git-send-email-akaher@vmware.com>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <1683026600-13485-3-git-send-email-akaher@vmware.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/5/2 19:23, Ajay Kaher wrote:
> Adding eventfs_file structure which will hold properties of file or dir.
> 
> Adding following functions to add dir in eventfs:
> 
> eventfs_create_events_dir() will directly create events dir with-in
> tracing folder.
> 
> eventfs_add_subsystem_dir() will adds the info of subsystem_dir to
> eventfs and dynamically create subsystem_dir as and when requires.
> 
> eventfs_add_dir() will add the info of dir (which is with-in
> subsystem_dir) to eventfs and dynamically create these dir as
> and when requires.
> 
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> ---
>   fs/tracefs/Makefile      |   1 +
>   fs/tracefs/event_inode.c | 252 +++++++++++++++++++++++++++++++++++++++
>   include/linux/tracefs.h  |  29 +++++
>   kernel/trace/trace.h     |   1 +
>   4 files changed, 283 insertions(+)
>   create mode 100644 fs/tracefs/event_inode.c
> 
> diff --git a/fs/tracefs/Makefile b/fs/tracefs/Makefile
> index 7c35a282b..73c56da8e 100644
> --- a/fs/tracefs/Makefile
> +++ b/fs/tracefs/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   tracefs-objs	:= inode.o
> +tracefs-objs	+= event_inode.o
>   
>   obj-$(CONFIG_TRACING)	+= tracefs.o
>   
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> new file mode 100644
> index 000000000..82caba7e9
> --- /dev/null
> +++ b/fs/tracefs/event_inode.c
> @@ -0,0 +1,252 @@
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
> + * helper function to perform read lock, skip locking if caller task already
> + * own the lock. read lock requires for lookup(), release() and these also
> + * called with-in open(), remove() which already hold the read/write lock.
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
> + * eventfs_create_events_dir - create the trace event structure
> + * @name: a pointer to a string containing the name of the directory to
> + *        create.
> + * @parent: a pointer to the parent dentry for this file.  This should be a
> + *          directory dentry if set.  If this parameter is NULL, then the
> + *          directory will be created in the root of the tracefs filesystem.
> + * @eventfs_rwsem: a pointer to rw_semaphore
> + *
> + * This function creates the top of the trace event directory.
> + */
> +struct dentry *eventfs_create_events_dir(const char *name,
> +					 struct dentry *parent,
> +					 struct rw_semaphore *eventfs_rwsem)
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
> +
> +/**
> + * eventfs_add_subsystem_dir - add eventfs subsystem_dir to list to create later
> + * @name: a pointer to a string containing the name of the file to create.
> + * @parent: a pointer to the parent dentry for this dir.
> + * @eventfs_rwsem: a pointer to rw_semaphore
> + *
> + * This function adds eventfs subsystem dir to list.
> + * And all these dirs are created on the fly when they are looked up,
> + * and the dentry and inodes will be removed when they are done.
> + */
> +struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
> +					       struct dentry *parent,
> +					       struct rw_semaphore *eventfs_rwsem)
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
> +	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
> +	if (!ef)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
> +	if (!ef->ei) {
> +		kfree(ef);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	INIT_LIST_HEAD(&ef->ei->e_top_files);
> +
> +	ef->name = kstrdup(name, GFP_KERNEL);
> +	if (!ef->name) {
> +		kfree(ef->ei);
> +		kfree(ef);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	ef->mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> +	ef->iop = &eventfs_root_dir_inode_operations;
> +	ef->fop =  &eventfs_file_operations;
> +	ef->dentry = NULL;
> +	ef->created = false;
> +	ef->d_parent = parent;
> +	ef->data = eventfs_rwsem;
> +
> +	eventfs_down_write(eventfs_rwsem);
> +	list_add_tail(&ef->list, &ei_parent->e_top_files);
> +	eventfs_up_write(eventfs_rwsem);
> +	return ef;
> +}
> +
> +/**
> + * eventfs_add_dir - add eventfs dir to list to create later
> + * @name: a pointer to a string containing the name of the file to create.
> + * @ef_parent: a pointer to the parent eventfs_file for this dir.
> + * @eventfs_rwsem: a pointer to rw_semaphore
> + *
> + * This function adds eventfs dir to list.
> + * And all these dirs are created on the fly when they are looked up,
> + * and the dentry and inodes will be removed when they are done.
> + */
> +struct eventfs_file *eventfs_add_dir(const char *name,
> +				     struct eventfs_file *ef_parent,
> +				     struct rw_semaphore *eventfs_rwsem)
> +{
> +	struct eventfs_file *ef;
> +
> +	if (!ef_parent)
> +		return ERR_PTR(-EINVAL);
> +
> +	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
> +	if (!ef)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
> +	if (!ef->ei) {
> +		kfree(ef);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	INIT_LIST_HEAD(&ef->ei->e_top_files);
> +
> +	ef->name = kstrdup(name, GFP_KERNEL);
> +	if (!ef->name) {
> +		kfree(ef->ei);
> +		kfree(ef);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	ef->mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> +	ef->iop = &eventfs_root_dir_inode_operations;
> +	ef->fop =  &eventfs_file_operations;
> +	ef->created = false;
> +	ef->dentry = NULL;
> +	ef->d_parent = NULL;
> +	ef->data = eventfs_rwsem;
> +
> +	eventfs_down_write(eventfs_rwsem);
> +	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
> +	eventfs_up_write(eventfs_rwsem);
> +	return ef;
> +}

Hi,
eventfs_add_subsystem_dir() and eventfs_add_dir() are almost the same,
how about extract a common help function to simplify them, like:

+static struct eventfs_file *__eventfs_add_dir(const char *name,
+                                             struct dentry *d_parent,
+                                             struct eventfs_inode 
*ei_parent,
+                                             struct rw_semaphore 
*eventfs_rwsem)
+{
+       struct eventfs_file *ef;
+
+       ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+       if (!ef)
+               return ERR_PTR(-ENOMEM);
+
+       ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
+       if (!ef->ei) {
+               kfree(ef);
+               return ERR_PTR(-ENOMEM);
+       }
+
+       INIT_LIST_HEAD(&ef->ei->e_top_files);
+
+       ef->name = kstrdup(name, GFP_KERNEL);
+       if (!ef->name) {
+               kfree(ef->ei);
+               kfree(ef);
+               return ERR_PTR(-ENOMEM);
+       }
+
+       ef->mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+       ef->iop = &eventfs_root_dir_inode_operations;
+       ef->fop = &eventfs_file_operations;
+       ef->dentry = NULL;
+       ef->created = false;
+       ef->d_parent = d_parent;
+       ef->data = eventfs_rwsem;
+
+       eventfs_down_write(eventfs_rwsem);
+       list_add_tail(&ef->list, &ei_parent->e_top_files);
+       eventfs_up_write(eventfs_rwsem);
+       return ef;
+}
+
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
+                                              struct dentry *parent,
+                                              struct rw_semaphore 
*eventfs_rwsem)
+{
+       struct tracefs_inode *ti_parent;
+       struct eventfs_inode *ei_parent;
+
+       if (!parent)
+               return ERR_PTR(-EINVAL);
+       ti_parent = get_tracefs(parent->d_inode);
+       ei_parent = ti_parent->private;
+       return __eventfs_add_dir(name, parent, ei_parent, eventfs_rwsem);
+}
+
+struct eventfs_file *eventfs_add_dir(const char *name,
+                                    struct eventfs_file *ef_parent,
+                                    struct rw_semaphore *eventfs_rwsem)
+{
+       if (!ef_parent)
+               return ERR_PTR(-EINVAL);
+       return __eventfs_add_dir(name, NULL, ef_parent->ei, eventfs_rwsem);
+}

--

Best regards,
Zheng Yejian

> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index 999124459..aeca6761f 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -21,6 +21,35 @@ struct file_operations;
>   
>   #ifdef CONFIG_TRACING
>   
> +struct eventfs_inode {
> +	struct list_head		e_top_files;
> +};
> +
> +struct eventfs_file {
> +	const char                      *name;
> +	struct dentry                   *d_parent;
> +	struct dentry                   *dentry;
> +	struct list_head                list;
> +	struct eventfs_inode            *ei;
> +	const struct file_operations    *fop;
> +	const struct inode_operations   *iop;
> +	void                            *data;
> +	umode_t                         mode;
> +	bool                            created;
> +};
> +
> +struct dentry *eventfs_create_events_dir(const char *name,
> +					 struct dentry *parent,
> +					 struct rw_semaphore *eventfs_rwsem);
> +
> +struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
> +					       struct dentry *parent,
> +					       struct rw_semaphore *eventfs_rwsem);
> +
> +struct eventfs_file *eventfs_add_dir(const char *name,
> +				     struct eventfs_file *ef_parent,
> +				     struct rw_semaphore *eventfs_rwsem);
> +
>   struct dentry *tracefs_create_file(const char *name, umode_t mode,
>   				   struct dentry *parent, void *data,
>   				   const struct file_operations *fops);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 616e1aa1c..3726725c8 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -359,6 +359,7 @@ struct trace_array {
>   	struct dentry		*options;
>   	struct dentry		*percpu_dir;
>   	struct dentry		*event_dir;
> +	struct rw_semaphore     eventfs_rwsem;
>   	struct trace_options	*topts;
>   	struct list_head	systems;
>   	struct list_head	events;

