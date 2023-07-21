Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B81275C795
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjGUNVM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 09:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGUNVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 09:21:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D286E270A;
        Fri, 21 Jul 2023 06:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED4260C71;
        Fri, 21 Jul 2023 13:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515F5C433C8;
        Fri, 21 Jul 2023 13:19:49 +0000 (UTC)
Date:   Fri, 21 Jul 2023 09:19:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        Nadav Amit <namit@vmware.com>, oe-lkp@lists.linux.dev,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v4 00/10] tracing: introducing eventfs
Message-ID: <20230721091947.0df9fd73@gandalf.local.home>
In-Reply-To: <20230721084839.4a97a595@gandalf.local.home>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
 <20230714185824.62556254@gandalf.local.home>
 <883F9774-3E76-4346-9988-2788FAF0D55E@vmware.com>
 <20230718094005.32516161@gandalf.local.home>
 <2CD72098-08E2-4CAA-B74D-D8C44D318117@vmware.com>
 <20230719102310.552d3356@gandalf.local.home>
 <899D0823-A1B2-4A6F-A5BA-0D707F41C3D4@vmware.com>
 <20230719144046.746af82e@gandalf.local.home>
 <20230721084839.4a97a595@gandalf.local.home>
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


[ Resending because claws-mail is messing with the Cc again. It doesn't like quotes :-p ]

On Fri, 21 Jul 2023 08:48:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 4db048250cdb..2718de1533e6 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -36,16 +36,36 @@ struct eventfs_file {
>  	const struct file_operations	*fop;
>  	const struct inode_operations	*iop;
>  	union {
> +		struct list_head	del_list;
>  		struct rcu_head		rcu;
> -		struct llist_node	llist;  /* For freeing after RCU */
> +		unsigned long		is_freed; /* Freed if one of the above is set */

I changed the freeing around. The dentries are freed before returning from
eventfs_remove_dir().

I also added a "is_freed" field that is part of the union and is set if
list elements have content. Note, since the union was criticized before, I
will state the entire purpose of doing this patch set is to save memory.
This structure will be used for every event file. What's the point of
getting rid of dentries if we are replacing it with something just as big?
Anyway, struct dentry does the exact same thing!

>  	};
>  	void				*data;
>  	umode_t				mode;
> -	bool				created;
> +	unsigned int			flags;

Bah, I forgot to remove flags (one iteration replaced the created with
flags to set both created and freed). I removed the freed with the above
"is_freed" and noticed that created is set if and only if ef->dentry is
set. So instead of using the created boolean, just test ef->dentry.

The flags isn't used and can be removed. I just forgot to do so.

>  };
>  
>  static DEFINE_MUTEX(eventfs_mutex);
>  DEFINE_STATIC_SRCU(eventfs_srcu);
> +
> +static struct dentry *eventfs_root_lookup(struct inode *dir,
> +					  struct dentry *dentry,
> +					  unsigned int flags);
> +static int dcache_dir_open_wrapper(struct inode *inode, struct file *file);
> +static int eventfs_release(struct inode *inode, struct file *file);
> +
> +static const struct inode_operations eventfs_root_dir_inode_operations = {
> +	.lookup		= eventfs_root_lookup,
> +};
> +
> +static const struct file_operations eventfs_file_operations = {
> +	.open           = dcache_dir_open_wrapper,
> +	.read		= generic_read_dir,
> +	.iterate_shared	= dcache_readdir,
> +	.llseek		= generic_file_llseek,
> +	.release        = eventfs_release,
> +};
> +

In preparing for getting rid of eventfs_file, I noticed that all
directories are set to the above ops. In create_dir() instead of passing in
ef->*ops, just use these directly. This does help with future work.

>  /**
>   * create_file - create a file in the tracefs filesystem
>   * @name: the name of the file to create.
> @@ -123,17 +143,12 @@ static struct dentry *create_file(const char *name, umode_t mode,
>   * If tracefs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
>   */
> -static struct dentry *create_dir(const char *name, umode_t mode,
> -				 struct dentry *parent, void *data,
> -				 const struct file_operations *fop,
> -				 const struct inode_operations *iop)
> +static struct dentry *create_dir(const char *name, struct dentry *parent, void *data)
>  {

As stated, the directories always used the same *op values, so I just hard
coded it.

>  	struct tracefs_inode *ti;
>  	struct dentry *dentry;
>  	struct inode *inode;
>  
> -	WARN_ON(!S_ISDIR(mode));
> -
>  	dentry = eventfs_start_creating(name, parent);
>  	if (IS_ERR(dentry))
>  		return dentry;
> @@ -142,9 +157,9 @@ static struct dentry *create_dir(const char *name, umode_t mode,
>  	if (unlikely(!inode))
>  		return eventfs_failed_creating(dentry);
>  
> -	inode->i_mode = mode;
> -	inode->i_op = iop;
> -	inode->i_fop = fop;
> +	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> +	inode->i_op = &eventfs_root_dir_inode_operations;
> +	inode->i_fop = &eventfs_file_operations;
>  	inode->i_private = data;
>  
>  	ti = get_tracefs(inode);
> @@ -169,15 +184,27 @@ void eventfs_set_ef_status_free(struct dentry *dentry)
>  	struct tracefs_inode *ti_parent;
>  	struct eventfs_file *ef;
>  
> +	mutex_lock(&eventfs_mutex);

To synchronize with the removals, I needed to add locking here.

>  	ti_parent = get_tracefs(dentry->d_parent->d_inode);
>  	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
> -		return;
> +		goto out;
>  
>  	ef = dentry->d_fsdata;
>  	if (!ef)
> -		return;
> -	ef->created = false;
> +		goto out;
> +	/*
> +	 * If ef was freed, then the LSB bit is set for d_fsdata.
> +	 * But this should not happen, as it should still have a
> +	 * ref count that prevents it. Warn in case it does.
> +	 */
> +	if (WARN_ON_ONCE((unsigned long)ef & 1))
> +		goto out;

During the remove, a dget() is done to keep the dentry from freeing. To
make sure that it doesn't get freed, I added this test.

> +
> +	dentry->d_fsdata = NULL;
> +
>  	ef->dentry = NULL;
> + out:
> +	mutex_unlock(&eventfs_mutex);
>  }
>  
>  /**
> @@ -202,6 +229,79 @@ static void eventfs_post_create_dir(struct eventfs_file *ef)
>  	ti->private = ef->ei;
>  }
>  
> +static struct dentry *
> +create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
> +{

Because both the lookup and the dir_open_wrapper did basically the same
thing, I created a helper function so that I didn't have to update both
locations.

> +	bool invalidate = false;
> +	struct dentry *dentry;
> +
> +	mutex_lock(&eventfs_mutex);
> +	if (ef->is_freed) {
> +		mutex_unlock(&eventfs_mutex);
> +		return NULL;
> +	}

Ignore if the ef is on its way to be freed.

> +	if (ef->dentry) {
> +		dentry = ef->dentry;

If the ef already has a dentry (created) then use it.

> +		/* On dir open, up the ref count */
> +		if (!lookup)
> +			dget(dentry);
> +		mutex_unlock(&eventfs_mutex);
> +		return dentry;
> +	}
> +	mutex_unlock(&eventfs_mutex);
> +
> +	if (!lookup)
> +		inode_lock(parent->d_inode);
> +
> +	if (ef->ei)
> +		dentry = create_dir(ef->name, parent, ef->data);
> +	else
> +		dentry = create_file(ef->name, ef->mode, parent,
> +				     ef->data, ef->fop);
> +
> +	if (!lookup)
> +		inode_unlock(parent->d_inode);
> +
> +	mutex_lock(&eventfs_mutex);
> +	if (IS_ERR_OR_NULL(dentry)) {

With the lock dropped, the dentry could have been created causing it to
fail. Check if the ef->dentry exists, and if so, use it instead.

Note, if the ef is freed, it should not have a dentry.

> +		/* If the ef was already updated get it */
> +		dentry = ef->dentry;
> +		if (dentry && !lookup)
> +			dget(dentry);
> +		mutex_unlock(&eventfs_mutex);
> +		return dentry;
> +	}
> +
> +	if (!ef->dentry && !ef->is_freed) {

With the lock dropped, the dentry could have been filled too. If so, drop
the created dentry and use the one owned by the ef->dentry.

> +		ef->dentry = dentry;
> +		if (ef->ei)
> +			eventfs_post_create_dir(ef);
> +		dentry->d_fsdata = ef;
> +	} else {
> +		/* A race here, should try again (unless freed) */
> +		invalidate = true;

I had a WARN_ON() once here. Probably could add a:

		WARN_ON_ONCE(!ef->is_freed);

> +	}
> +	mutex_unlock(&eventfs_mutex);
> +	if (invalidate)
> +		d_invalidate(dentry);
> +
> +	if (lookup || invalidate)
> +		dput(dentry);
> +
> +	return invalidate ? NULL : dentry;
> +}
> +
> +static bool match_event_file(struct eventfs_file *ef, const char *name)
> +{

A bit of a paranoid helper function. I wanted to make sure to synchronize
with the removals.

> +	bool ret;
> +
> +	mutex_lock(&eventfs_mutex);
> +	ret = !ef->is_freed && strcmp(ef->name, name) == 0;
> +	mutex_unlock(&eventfs_mutex);
> +
> +	return ret;
> +}
> +
>  /**
>   * eventfs_root_lookup - lookup routine to create file/dir
>   * @dir: directory in which lookup to be done
> @@ -211,7 +311,6 @@ static void eventfs_post_create_dir(struct eventfs_file *ef)
>   * Used to create dynamic file/dir with-in @dir, search with-in ei
>   * list, if @dentry found go ahead and create the file/dir
>   */
> -
>  static struct dentry *eventfs_root_lookup(struct inode *dir,
>  					  struct dentry *dentry,
>  					  unsigned int flags)
> @@ -230,30 +329,10 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  	idx = srcu_read_lock(&eventfs_srcu);
>  	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
>  				 srcu_read_lock_held(&eventfs_srcu)) {
> -		if (strcmp(ef->name, dentry->d_name.name))
> +		if (!match_event_file(ef, dentry->d_name.name))
>  			continue;
>  		ret = simple_lookup(dir, dentry, flags);
> -		if (ef->created)
> -			continue;
> -		mutex_lock(&eventfs_mutex);
> -		ef->created = true;
> -		if (ef->ei)
> -			ef->dentry = create_dir(ef->name, ef->mode, ef->d_parent,
> -						ef->data, ef->fop, ef->iop);
> -		else
> -			ef->dentry = create_file(ef->name, ef->mode, ef->d_parent,
> -						 ef->data, ef->fop);
> -
> -		if (IS_ERR_OR_NULL(ef->dentry)) {
> -			ef->created = false;
> -			mutex_unlock(&eventfs_mutex);
> -		} else {
> -			if (ef->ei)
> -				eventfs_post_create_dir(ef);
> -			ef->dentry->d_fsdata = ef;
> -			mutex_unlock(&eventfs_mutex);
> -			dput(ef->dentry);
> -		}
> +		create_dentry(ef, ef->d_parent, true);
>  		break;
>  	}
>  	srcu_read_unlock(&eventfs_srcu, idx);
> @@ -270,6 +349,7 @@ static int eventfs_release(struct inode *inode, struct file *file)
>  	struct tracefs_inode *ti;
>  	struct eventfs_inode *ei;
>  	struct eventfs_file *ef;
> +	struct dentry *dentry;
>  	int idx;
>  
>  	ti = get_tracefs(inode);
> @@ -280,8 +360,11 @@ static int eventfs_release(struct inode *inode, struct file *file)
>  	idx = srcu_read_lock(&eventfs_srcu);
>  	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
>  				 srcu_read_lock_held(&eventfs_srcu)) {
> -		if (ef->created)
> -			dput(ef->dentry);
> +		mutex_lock(&eventfs_mutex);
> +		dentry = ef->dentry;
> +		mutex_unlock(&eventfs_mutex);
> +		if (dentry)
> +			dput(dentry);
>  	}
>  	srcu_read_unlock(&eventfs_srcu, idx);
>  	return dcache_dir_close(inode, file);
> @@ -312,47 +395,12 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
>  	ei = ti->private;
>  	idx = srcu_read_lock(&eventfs_srcu);
>  	list_for_each_entry_rcu(ef, &ei->e_top_files, list) {
> -		if (ef->created) {
> -			dget(ef->dentry);
> -			continue;
> -		}
> -		mutex_lock(&eventfs_mutex);
> -		ef->created = true;
> -
> -		inode_lock(dentry->d_inode);
> -		if (ef->ei)
> -			ef->dentry = create_dir(ef->name, ef->mode, dentry,
> -						ef->data, ef->fop, ef->iop);
> -		else
> -			ef->dentry = create_file(ef->name, ef->mode, dentry,
> -						 ef->data, ef->fop);
> -		inode_unlock(dentry->d_inode);
> -
> -		if (IS_ERR_OR_NULL(ef->dentry)) {
> -			ef->created = false;
> -		} else {
> -			if (ef->ei)
> -				eventfs_post_create_dir(ef);
> -			ef->dentry->d_fsdata = ef;
> -		}
> -		mutex_unlock(&eventfs_mutex);
> +		create_dentry(ef, dentry, false);
>  	}
>  	srcu_read_unlock(&eventfs_srcu, idx);
>  	return dcache_dir_open(inode, file);
>  }
>  
> -static const struct file_operations eventfs_file_operations = {
> -	.open           = dcache_dir_open_wrapper,
> -	.read		= generic_read_dir,
> -	.iterate_shared	= dcache_readdir,
> -	.llseek		= generic_file_llseek,
> -	.release        = eventfs_release,
> -};
> -
> -static const struct inode_operations eventfs_root_dir_inode_operations = {
> -	.lookup		= eventfs_root_lookup,
> -};
> -
>  /**
>   * eventfs_prepare_ef - helper function to prepare eventfs_file
>   * @name: the name of the file/directory to create.
> @@ -470,11 +518,7 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
>  	ti_parent = get_tracefs(parent->d_inode);
>  	ei_parent = ti_parent->private;
>  
> -	ef = eventfs_prepare_ef(name,
> -		S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
> -		&eventfs_file_operations,
> -		&eventfs_root_dir_inode_operations, NULL);
> -
> +	ef = eventfs_prepare_ef(name, S_IFDIR, NULL, NULL, NULL);

For directories, just use the hard coded values.

>  	if (IS_ERR(ef))
>  		return ef;
>  
> @@ -502,11 +546,7 @@ struct eventfs_file *eventfs_add_dir(const char *name,
>  	if (!ef_parent)
>  		return ERR_PTR(-EINVAL);
>  
> -	ef = eventfs_prepare_ef(name,
> -		S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
> -		&eventfs_file_operations,
> -		&eventfs_root_dir_inode_operations, NULL);
> -
> +	ef = eventfs_prepare_ef(name, S_IFDIR, NULL, NULL, NULL);

ditto.

>  	if (IS_ERR(ef))
>  		return ef;
>  
> @@ -601,37 +641,15 @@ int eventfs_add_file(const char *name, umode_t mode,
>  	return 0;
>  }
>  
> -static LLIST_HEAD(free_list);
> -
> -static void eventfs_workfn(struct work_struct *work)
> -{
> -	struct eventfs_file *ef, *tmp;
> -	struct llist_node *llnode;
> -
> -	llnode = llist_del_all(&free_list);
> -	llist_for_each_entry_safe(ef, tmp, llnode, llist) {
> -		if (ef->created && ef->dentry)
> -			dput(ef->dentry);
> -		kfree(ef->name);
> -		kfree(ef->ei);
> -		kfree(ef);
> -	}
> -}
> -
> -DECLARE_WORK(eventfs_work, eventfs_workfn);
> -
>  static void free_ef(struct rcu_head *head)
>  {
>  	struct eventfs_file *ef = container_of(head, struct eventfs_file, rcu);
>  
> -	if (!llist_add(&ef->llist, &free_list))
> -		return;
> -
> -	queue_work(system_unbound_wq, &eventfs_work);
> +	kfree(ef->name);
> +	kfree(ef->ei);
> +	kfree(ef);

Since I did not do the dput() or d_invalidate() here I don't need call this
from task context. This simplifies the process.

>  }
>  
> -
> -
>  /**
>   * eventfs_remove_rec - remove eventfs dir or file from list
>   * @ef: eventfs_file to be removed.
> @@ -639,7 +657,7 @@ static void free_ef(struct rcu_head *head)
>   * This function recursively remove eventfs_file which
>   * contains info of file or dir.
>   */
> -static void eventfs_remove_rec(struct eventfs_file *ef, int level)
> +static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head, int level)
>  {
>  	struct eventfs_file *ef_child;
>  
> @@ -659,15 +677,12 @@ static void eventfs_remove_rec(struct eventfs_file *ef, int level)
>  		/* search for nested folders or files */
>  		list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
>  					 lockdep_is_held(&eventfs_mutex)) {
> -			eventfs_remove_rec(ef_child, level + 1);
> +			eventfs_remove_rec(ef_child, head, level + 1);
>  		}
>  	}
>  
> -	if (ef->created && ef->dentry)
> -		d_invalidate(ef->dentry);
> -
>  	list_del_rcu(&ef->list);
> -	call_srcu(&eventfs_srcu, &ef->rcu, free_ef);
> +	list_add_tail(&ef->del_list, head);

Hold off on freeing the ef. Add it to a link list to do so later.

>  }
>  
>  /**
> @@ -678,12 +693,62 @@ static void eventfs_remove_rec(struct eventfs_file *ef, int level)
>   */
>  void eventfs_remove(struct eventfs_file *ef)
>  {
> +	struct eventfs_file *tmp;
> +	LIST_HEAD(ef_del_list);
> +	struct dentry *dentry_list = NULL;
> +	struct dentry *dentry;
> +
>  	if (!ef)
>  		return;
>  
>  	mutex_lock(&eventfs_mutex);
> -	eventfs_remove_rec(ef, 0);
> +	eventfs_remove_rec(ef, &ef_del_list, 0);

The above returns back with ef_del_list holding all the ef's to be freed.

I probably could have just passed the dentry_list down instead, but I
wanted the below complexity done in a non recursive function.

> +
> +	list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
> +		if (ef->dentry) {
> +			unsigned long ptr = (unsigned long)dentry_list;
> +
> +			/* Keep the dentry from being freed yet */
> +			dget(ef->dentry);
> +
> +			/*
> +			 * Paranoid: The dget() above should prevent the dentry
> +			 * from being freed and calling eventfs_set_ef_status_free().
> +			 * But just in case, set the link list LSB pointer to 1
> +			 * and have eventfs_set_ef_status_free() check that to
> +			 * make sure that if it does happen, it will not think
> +			 * the d_fsdata is an event_file.
> +			 *
> +			 * For this to work, no event_file should be allocated
> +			 * on a odd space, as the ef should always be allocated
> +			 * to be at least word aligned. Check for that too.
> +			 */
> +			WARN_ON_ONCE(ptr & 1);
> +
> +			ef->dentry->d_fsdata = (void *)(ptr | 1);

Set the d_fsdata to be a link list. The comment above needs to say to say
struct eventfs_file and struct dentry should be word aligned. Anyway, while
the eventfs_mutex is held, set all the dentries belonging to eventfs_files
to the dentry_list and clear the ef->dentry.


> +			dentry_list = ef->dentry;
> +			ef->dentry = NULL;
> +		}
> +		call_srcu(&eventfs_srcu, &ef->rcu, free_ef);
> +	}
>  	mutex_unlock(&eventfs_mutex);
> +
> +	while (dentry_list) {
> +		unsigned long ptr;
> +
> +		dentry = dentry_list;
> +		ptr = (unsigned long)dentry->d_fsdata & ~1UL;
> +		dentry_list = (struct dentry *)ptr;
> +		dentry->d_fsdata = NULL;

With the mutex released, it is safe to free the dentries here. This also
must be done before returning from this function, as when I had it done in
the workqueue, it was failing some tests that would remove a dynamic event
and still see that the directory was still around!

> +		d_invalidate(dentry);
> +		mutex_lock(&eventfs_mutex);
> +		/* dentry should now have at least a single reference */
> +		WARN_ONCE((int)d_count(dentry) < 1,
> +			  "dentry %px less than one reference (%d) after invalidate\n",

I did update the above to:

		WARN_ONCE((int)d_count(dentry) < 1,
			  "dentry %px (%s) less than one reference (%d) after invalidate\n",
			  dentry, dentry->d_name.name, d_count(dentry));

To include the name of the dentry (my current work is triggering this still).

> +			  dentry, d_count(dentry));
> +		mutex_unlock(&eventfs_mutex);
> +		dput(dentry);
> +	}
>  }
>  
>  /**
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index c443a0c32a8c..1b880b5cd29d 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -22,4 +22,6 @@ struct dentry *tracefs_end_creating(struct dentry *dentry);
>  struct dentry *tracefs_failed_creating(struct dentry *dentry);
>  struct inode *tracefs_get_inode(struct super_block *sb);
>  
> +void eventfs_set_ef_status_free(struct dentry *dentry);
> +
>  #endif /* _TRACEFS_INTERNAL_H */
> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index 4d30b0cafc5f..47c1b4d21735 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -51,8 +51,6 @@ void eventfs_remove(struct eventfs_file *ef);
>  
>  void eventfs_remove_events_dir(struct dentry *dentry);
>  
> -void eventfs_set_ef_status_free(struct dentry *dentry);
> -

Oh, and eventfs_set_ef_status_free() should not be exported to outside the
tracefs system.

-- Steve


>  struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  				   struct dentry *parent, void *data,
>  				   const struct file_operations *fops);

