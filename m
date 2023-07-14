Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F1753FF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjGNQri (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjGNQri (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:47:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5236358C;
        Fri, 14 Jul 2023 09:47:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F15661D64;
        Fri, 14 Jul 2023 16:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B39AC433C8;
        Fri, 14 Jul 2023 16:47:34 +0000 (UTC)
Date:   Fri, 14 Jul 2023 12:47:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 06/10] eventfs: Implement functions to create eventfs
 files and directories
Message-ID: <20230714124732.63452948@gandalf.local.home>
In-Reply-To: <1689248004-8158-7-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-7-git-send-email-akaher@vmware.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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


Some more nits.

Subject: eventfs: Implement functions to create files and dirs when accessed

On Thu, 13 Jul 2023 17:03:20 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Adding create_file(), create_dir() to create file, dir
> at runtime when they are accessed.
> 
> These function will be called either from lookup
> of inode_operations or open of file_operations.

Add create_file() and create_dir() functions to create the files and
directories respectively when they are accessed. The functions will be
called from the lookup operation of the inode_operations or from the open
function of file_operations.


> 
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> ---
>  fs/tracefs/event_inode.c | 110 +++++++++++++++++++++++++++++++++++++++
>  fs/tracefs/inode.c       |  47 +++++++++++++++++
>  include/linux/tracefs.h  |   7 +++
>  3 files changed, 164 insertions(+)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 322a77be5a56..34b5d3d8005b 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -46,6 +46,116 @@ struct eventfs_file {
>  
>  static DEFINE_MUTEX(eventfs_mutex);
>  DEFINE_STATIC_SRCU(eventfs_srcu);
> +/**
> + * create_file - create a file in the tracefs filesystem
> + * @name: the name of the file to create.
> + * @mode: the permission that the file should have.
> + * @parent: parent dentry for this file.
> + * @data: something that the caller will want to get to later on.
> + *        The inode.i_private pointer will point to this value on
> + *        the open() call.

Again, should move the extra lines into the description.

> + * @fop: struct file_operations that should be used for this file.
> + *
> + * This is the basic "create a file" function for tracefs.  It allows for a
> + * wide range of flexibility in creating a file.
> + *
> + * This function will return a pointer to a dentry if it succeeds.  This
> + * pointer must be passed to the tracefs_remove() function when the file is
> + * to be removed (no automatic cleanup happens if your module is unloaded,
> + * you are responsible here.)  If an error occurs, %NULL will be returned.
> + *
> + * If tracefs is not enabled in the kernel, the value -%ENODEV will be
> + * returned.
> + */
> +struct dentry *create_file(const char *name, umode_t mode,
> +				  struct dentry *parent, void *data,
> +				  const struct file_operations *fop)
> +{
> +	struct tracefs_inode *ti;
> +	struct dentry *dentry;
> +	struct inode *inode;
> +
> +	if (!(mode & S_IFMT))
> +		mode |= S_IFREG;
> +
> +	if (WARN_ON_ONCE(!S_ISREG(mode)))
> +		return NULL;
> +
> +	dentry = eventfs_start_creating(name, parent);
> +
> +	if (IS_ERR(dentry))
> +		return dentry;
> +
> +	inode = tracefs_get_inode(dentry->d_sb);
> +	if (unlikely(!inode))
> +		return eventfs_failed_creating(dentry);
> +
> +	inode->i_mode = mode;
> +	inode->i_fop = fop;
> +	inode->i_private = data;
> +
> +	ti = get_tracefs(inode);
> +	ti->flags |= TRACEFS_EVENT_INODE;
> +	d_instantiate(dentry, inode);
> +	fsnotify_create(dentry->d_parent->d_inode, dentry);
> +	return eventfs_end_creating(dentry);
> +}
> +
> +/**
> + * create_dir - create a dir in the tracefs filesystem
> + * @name: the name of the file to create.
> + * @mode: the permission that the file should have.
> + * @parent: parent dentry for this file.
> + * @data: something that the caller will want to get to later on.
> + *        The inode.i_private pointer will point to this value on
> + *        the open() call.

Move the extra lines down into the description here too.

> + * @fop: struct file_operations that should be used for this dir.
> + * @iop: struct inode_operations that should be used for this dir.
> + *
> + * This is the basic "create a dir" function for eventfs.  It allows for a
> + * wide range of flexibility in creating a dir.
> + *
> + * This function will return a pointer to a dentry if it succeeds.  This
> + * pointer must be passed to the tracefs_remove() function when the file is
> + * to be removed (no automatic cleanup happens if your module is unloaded,
> + * you are responsible here.)  If an error occurs, %NULL will be returned.
> + *
> + * If tracefs is not enabled in the kernel, the value -%ENODEV will be
> + * returned.
> + */
> +struct dentry *create_dir(const char *name, umode_t mode,
> +				 struct dentry *parent, void *data,
> +				 const struct file_operations *fop,
> +				 const struct inode_operations *iop)
> +{
> +	struct tracefs_inode *ti;
> +	struct dentry *dentry;
> +	struct inode *inode;
> +
> +	WARN_ON(!S_ISDIR(mode));
> +
> +	dentry = eventfs_start_creating(name, parent);
> +	if (IS_ERR(dentry))
> +		return dentry;
> +
> +	inode = tracefs_get_inode(dentry->d_sb);
> +	if (unlikely(!inode))
> +		return eventfs_failed_creating(dentry);
> +
> +	inode->i_mode = mode;
> +	inode->i_op = iop;
> +	inode->i_fop = fop;
> +	inode->i_private = data;
> +
> +	ti = get_tracefs(inode);
> +	ti->flags |= TRACEFS_EVENT_INODE;
> +
> +	inc_nlink(inode);
> +	d_instantiate(dentry, inode);
> +	inc_nlink(dentry->d_parent->d_inode);
> +	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
> +	return eventfs_end_creating(dentry);
> +}
>  
>  static const struct file_operations eventfs_file_operations = {
>  };
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 7ef3a02766f5..7dc692a5fee1 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -451,6 +451,53 @@ struct dentry *tracefs_end_creating(struct dentry *dentry)
>  	return dentry;
>  }
>  

This needs to be documented. What about:

/**
 * eventfs_start_creating - start the process of creating a dentry
 * @name: Name of the file created for the dentry
 * @parent: The parent dentry where this dentry will be created
 *
 * This is a simple helper function for the dynamically created eventfs
 * files. When the directory of the eventfs files are accessed, their
 * dentries are created on the fly. This function is used to start that
 * process.
 */
> +struct dentry *eventfs_start_creating(const char *name, struct dentry
>    *parent) +{
> +	struct dentry *dentry;
> +	int error;
> +
> +	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
> +			      &tracefs_mount_count);
> +	if (error)
> +		return ERR_PTR(error);
> +
> +	/*
> +	 * If the parent is not specified, we create it in the root.
> +	 * We need the root dentry to do this, which is in the super
> +	 * block. A pointer to that is in the struct vfsmount that we
> +	 * have around.
> +	 */
> +	if (!parent)
> +		parent = tracefs_mount->mnt_root;
> +
> +	if (unlikely(IS_DEADDIR(parent->d_inode)))
> +		dentry = ERR_PTR(-ENOENT);
> +	else
> +		dentry = lookup_one_len(name, parent, strlen(name));
> +
> +	if (!IS_ERR(dentry) && dentry->d_inode) {
> +		dput(dentry);
> +		dentry = ERR_PTR(-EEXIST);
> +	}
> +
> +	if (IS_ERR(dentry))
> +		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
> +
> +	return dentry;
> +}
> +

/**
 * eventfs_failed_creating - clean up a failed eventfs dentry creation
 * @dentry: The dentry to clean up
 *
 * If after calling eventfs_start_creating(), a failure is detected, the
 * resources created by eventfs_start_creating() needs to be cleaned up. In
 * that case, this function should be called to perform that clean up.
 */
> +struct dentry *eventfs_failed_creating(struct dentry *dentry)
> +{
> +	dput(dentry);
> +	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
> +	return NULL;
> +}
> +

/**
 * eventfs_end_creating - Finish the process of creating a eventfs dentry
 * @dentry: The dentry that has successfully been created.
 *
 * This function is currently just a place holder to match
 * eventfs_start_creating(). In case any synchronization needs to be added,
 * this function will be used to implement that without having to modify
 * the callers of eventfs_start_creating().
 */
> +struct dentry *eventfs_end_creating(struct dentry *dentry)
> +{
> +	return dentry;
> +}

-- Steve

> +
>  /**
>   * tracefs_create_file - create a file in the tracefs filesystem
>   * @name: a pointer to a string containing the name of the file to
>    create. diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index 2c08edd4a739..47c1b4d21735 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -23,6 +23,13 @@ struct file_operations;
>  
>  struct eventfs_file;
>  
> +struct dentry *eventfs_start_creating(const char *name,
> +				      struct dentry *parent);
> +
> +struct dentry *eventfs_failed_creating(struct dentry *dentry);
> +
> +struct dentry *eventfs_end_creating(struct dentry *dentry);
> +
>  struct dentry *eventfs_create_events_dir(const char *name,
>  					 struct dentry *parent);
>  

