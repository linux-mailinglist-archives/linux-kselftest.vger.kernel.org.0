Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CFC7543A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 22:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbjGNUSA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 16:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjGNUSA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 16:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213930F4;
        Fri, 14 Jul 2023 13:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC4761DEE;
        Fri, 14 Jul 2023 20:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7FDC433C8;
        Fri, 14 Jul 2023 20:17:56 +0000 (UTC)
Date:   Fri, 14 Jul 2023 16:17:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 07/10] eventfs: Implement eventfs lookup, read, open
 functions
Message-ID: <20230714161754.23fbcd72@gandalf.local.home>
In-Reply-To: <1689248004-8158-8-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-8-git-send-email-akaher@vmware.com>
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

On Thu, 13 Jul 2023 17:03:21 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Adding following inode_operations, file_operations and helper functions to
> eventfs:

 Add the inode_operations, file_operations, and helper functions to eventfs:

> dcache_dir_open_wrapper()
> eventfs_root_lookup()
> eventfs_release()
> eventfs_set_ef_status_free()
> eventfs_post_create_dir()
> 
> inode_operations, file_operations will be called from vfs.

The inode_operations and file_operations functions will be called from the
VFS layer.

> 
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> ---
>  fs/tracefs/event_inode.c | 194 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/tracefs.h  |   2 +
>  2 files changed, 194 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 34b5d3d8005b..7167340ac29e 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -67,7 +67,7 @@ DEFINE_STATIC_SRCU(eventfs_srcu);
>   * If tracefs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
>   */


> -struct dentry *create_file(const char *name, umode_t mode,
> +static struct dentry *create_file(const char *name, umode_t mode,
>  				  struct dentry *parent, void *data,
>  				  const struct file_operations *fop)
>  {
> @@ -123,7 +123,7 @@ struct dentry *create_file(const char *name, umode_t
> mode,
>   * If tracefs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
>   */
> -struct dentry *create_dir(const char *name, umode_t mode,
> +static struct dentry *create_dir(const char *name, umode_t mode,
>  				 struct dentry *parent, void *data,
>  				 const struct file_operations *fop,
>  				 const struct inode_operations *iop)

Please fold these changes into the patches that added these functions. They
should have been created as static functions.

If you are worried about the warnings that they caused by being static and
not used, perhaps these patches should be reordered, and we add this patch
first, with those functions as stubs.

That is, build the VFS functions first with just place holders for the
internals, and then fill in the internals. That would actually make more
sense in reviewing the code.

> @@ -157,10 +157,200 @@ struct dentry *create_dir(const char *name,
> umode_t mode, return eventfs_end_creating(dentry);
>  }
>  
> +/**
> + * eventfs_set_ef_status_free - set the ef->status to free
> + * @dentry: dentry who's status to be freed
> + *
> + * eventfs_set_ef_status_free will be called if no more
> + * reference remains

 "references remain"

> + */
> +void eventfs_set_ef_status_free(struct dentry *dentry)
> +{
> +	struct tracefs_inode *ti_parent;
> +	struct eventfs_file *ef;
> +
> +	ti_parent = get_tracefs(dentry->d_parent->d_inode);
> +	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
> +		return;
> +
> +	ef = dentry->d_fsdata;
> +	if (!ef)
> +		return;
> +	ef->created = false;
> +	ef->dentry = NULL;
> +}
> +
> +/**
> + * eventfs_post_create_dir - post create dir routine
> + * @ef: eventfs_file of recently created dir
> + *
> + * Files with-in eventfs dir should know dentry of parent dir

 * Map the meta-data of files within an eventfs dir to their parent dentry.

> + */
> +static void eventfs_post_create_dir(struct eventfs_file *ef)
> +{
> +	struct eventfs_file *ef_child;
> +	struct tracefs_inode *ti;
> +
> +	/* srcu lock already held */
> +	/* fill parent-child relation */
> +	list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
> +				 srcu_read_lock_held(&eventfs_srcu)) {
> +		ef_child->d_parent = ef->dentry;
> +	}
> +
> +	ti = get_tracefs(ef->dentry->d_inode);
> +	ti->private = ef->ei;
> +}
> +
> +/**
> + * eventfs_root_lookup - lookup routine to create file/dir
> + * @dir: directory in which lookup to be done

  "in which a lookup is being done"

> + * @dentry: file/dir dentry
> + * @flags:

  ?

 "unused" or "to pass as flags parameter to simple lookup"?

> + *
> + * Used to create dynamic file/dir with-in @dir, search with-in ei
> + * list, if @dentry found go ahead and create the file/dir

"within" is a real word ;-)

 * Used to create a dynamic file/dir within @dir. Use the eventfs_inode
 * list of meta data to find the information needed to create the file/dir.

> + */
> +
> +static struct dentry *eventfs_root_lookup(struct inode *dir,
> +					  struct dentry *dentry,
> +					  unsigned int flags)
> +{
> +	struct tracefs_inode *ti;
> +	struct eventfs_inode *ei;
> +	struct eventfs_file *ef;
> +	struct dentry *ret = NULL;
> +	int idx;
> +
> +	ti = get_tracefs(dir);
> +	if (!(ti->flags & TRACEFS_EVENT_INODE))
> +		return NULL;
> +
> +	ei = ti->private;
> +	idx = srcu_read_lock(&eventfs_srcu);
> +	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
> +				 srcu_read_lock_held(&eventfs_srcu)) {
> +		if (strcmp(ef->name, dentry->d_name.name))
> +			continue;
> +		ret = simple_lookup(dir, dentry, flags);
> +		if (ef->created)
> +			continue;
> +		mutex_lock(&eventfs_mutex);
> +		ef->created = true;
> +		if (ef->ei)
> +			ef->dentry = create_dir(ef->name, ef->mode, ef->d_parent,
> +						ef->data, ef->fop, ef->iop);
> +		else
> +			ef->dentry = create_file(ef->name, ef->mode, ef->d_parent,
> +						 ef->data, ef->fop);
> +
> +		if (IS_ERR_OR_NULL(ef->dentry)) {
> +			ef->created = false;
> +			mutex_unlock(&eventfs_mutex);
> +		} else {
> +			if (ef->ei)
> +				eventfs_post_create_dir(ef);
> +			ef->dentry->d_fsdata = ef;
> +			mutex_unlock(&eventfs_mutex);
> +			dput(ef->dentry);
> +		}
> +		break;
> +	}
> +	srcu_read_unlock(&eventfs_srcu, idx);
> +	return ret;
> +}
> +
> +/**
> + * eventfs_release - called to release eventfs file/dir
> + * @inode: inode to be released
> + * @file: file to be released (not used)
> + */
> +static int eventfs_release(struct inode *inode, struct file *file)
> +{
> +	struct tracefs_inode *ti;
> +	struct eventfs_inode *ei;
> +	struct eventfs_file *ef;
> +	int idx;
> +
> +	ti = get_tracefs(inode);
> +	if (!(ti->flags & TRACEFS_EVENT_INODE))
> +		return -EINVAL;
> +
> +	ei = ti->private;
> +	idx = srcu_read_lock(&eventfs_srcu);
> +	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
> +				 srcu_read_lock_held(&eventfs_srcu)) {
> +		if (ef->created)
> +			dput(ef->dentry);
> +	}
> +	srcu_read_unlock(&eventfs_srcu, idx);
> +	return dcache_dir_close(inode, file);
> +}
> +
> +/**
> + * dcache_dir_open_wrapper - eventfs open wrapper
> + * @inode: not used
> + * @file: dir to be opened (to create it's child)

  "its child"

> + *
> + * Used to dynamic create file/dir with-in @file, all the
> + * file/dir will be created. If already created then reference
> + * will be increased

 * Used to dynamically create the file/dir within @file. @file is really a
 * directory and all the files/dirs of the children within @file will be
 * created. If any of the files/dirs have already been created, their
 * reference count will be incremented.


> + */
> +static int dcache_dir_open_wrapper(struct inode *inode, struct file
> *file) +{
> +	struct tracefs_inode *ti;
> +	struct eventfs_inode *ei;
> +	struct eventfs_file *ef;
> +	struct dentry *dentry = file_dentry(file);
> +	struct inode *f_inode = file_inode(file);
> +	int idx;
> +
> +	ti = get_tracefs(f_inode);
> +	if (!(ti->flags & TRACEFS_EVENT_INODE))
> +		return -EINVAL;
> +
> +	ei = ti->private;
> +	idx = srcu_read_lock(&eventfs_srcu);
> +	list_for_each_entry_rcu(ef, &ei->e_top_files, list) {
> +		if (ef->created) {
> +			dget(ef->dentry);
> +			continue;
> +		}
> +		mutex_lock(&eventfs_mutex);
> +		ef->created = true;
> +
> +		inode_lock(dentry->d_inode);
> +		if (ef->ei)
> +			ef->dentry = create_dir(ef->name, ef->mode, dentry,
> +						ef->data, ef->fop, ef->iop);
> +		else
> +			ef->dentry = create_file(ef->name, ef->mode, dentry,
> +						 ef->data, ef->fop);
> +		inode_unlock(dentry->d_inode);
> +
> +		if (IS_ERR_OR_NULL(ef->dentry)) {
> +			ef->created = false;
> +		} else {
> +			if (ef->ei)
> +				eventfs_post_create_dir(ef);
> +			ef->dentry->d_fsdata = ef;
> +		}
> +		mutex_unlock(&eventfs_mutex);
> +	}
> +	srcu_read_unlock(&eventfs_srcu, idx);
> +	return dcache_dir_open(inode, file);
> +}
> +
>  static const struct file_operations eventfs_file_operations = {
> +	.open           = dcache_dir_open_wrapper,
> +	.read		= generic_read_dir,
> +	.iterate_shared	= dcache_readdir,
> +	.llseek		= generic_file_llseek,
> +	.release        = eventfs_release,
>  };
>  
>  static const struct inode_operations eventfs_root_dir_inode_operations =
> {
> +	.lookup		= eventfs_root_lookup,
>  };
>  
>  /**
> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index 47c1b4d21735..4d30b0cafc5f 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -51,6 +51,8 @@ void eventfs_remove(struct eventfs_file *ef);
>  
>  void eventfs_remove_events_dir(struct dentry *dentry);
>  
> +void eventfs_set_ef_status_free(struct dentry *dentry);

Shouldn't this be internal to the tracefs code, and not something exposed
to users of tracefs?

> +
>  struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  				   struct dentry *parent, void *data,
>  				   const struct file_operations *fops);

-- Steve
