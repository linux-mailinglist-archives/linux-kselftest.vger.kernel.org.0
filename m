Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254B2753FDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGNQfn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGNQfm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:35:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66917273F;
        Fri, 14 Jul 2023 09:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F27FD61D60;
        Fri, 14 Jul 2023 16:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B6EC433C7;
        Fri, 14 Jul 2023 16:35:38 +0000 (UTC)
Date:   Fri, 14 Jul 2023 12:35:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 05/10] eventfs: Implement eventfs file, directory
 remove function
Message-ID: <20230714123537.3c397d83@gandalf.local.home>
In-Reply-To: <1689248004-8158-6-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-6-git-send-email-akaher@vmware.com>
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

Some more nits:

Subject:

 eventfs: Implement removal of meta data from eventfs


On Thu, 13 Jul 2023 17:03:19 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Adding eventfs_remove(), this function will recursively remove
> dir or file info from eventfs.

 When events are removed from tracefs, the eventfs must be aware of this.
 The eventfs_remove() removes the meta data from eventfs so that it will no
 longer create the files associated with that event.

 When an instance is removed from tracefs, eventfs_remove_events_dir() will
 remove and clean up the entire "events" directory.


> 
> added a recursion check to eventfs_remove_rec() as it is really
> dangerous to have unchecked recursion in the kernel (we do have
> a fixed size stack).

The above doesn't need to be in the change log. It's an update from the
previous version. The eventfs_remove_rec() is added here, so the recursion
check was not.

> 
> have the free use srcu callbacks. After the srcu grace periods
> are done, it adds the eventfs_file onto a llist (lockless link
> list) and wakes up a work queue. Then the work queue does the
> freeing (this needs to be done in task/workqueue context, as
> srcu callbacks are done in softirq context).

If you want to document the above, we can say:

 The helper function eventfs_remove_rec() is used to clean up and free the
 associated data from eventfs for both of the added functions. SRCU is used
 to protect the lists of meta data stored in the eventfs. The eventfs_mutex
 is used to protect the content of the items in the list.

 As lookups may be happening as deletions of events are made, the freeing
 of of dentry/inodes and relative information is done after the SRCU grace
 period has passed. As the callback of SRCU is in a softirq context, a work
 queue is added to perform the cleanups in a task context.

 The struct evenfs_file is given a union of an rcu_head and a llist_node.
 The SRCU callback uses the rcu_head from this structure to insert it into
 the SRCU queue. When the SRCU grace periods are complete, the callback
 will then insert the eventfs_file struct onto a lockless llist using the
 llist_node of the structure. A union is used as this process is just a
 hand off from SRCU to workqueue, and only one field is necessary for this
 to work.

You can also add the above as a comment in the code (and keep it in the
change log as well).

-- Steve


> 
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202305030611.Kas747Ev-lkp@intel.com/
> ---
>  fs/tracefs/event_inode.c | 110 +++++++++++++++++++++++++++++++++++++++
>  include/linux/tracefs.h  |   4 ++
>  2 files changed, 114 insertions(+)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 75dc8953d813..322a77be5a56 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -45,6 +45,7 @@ struct eventfs_file {
>  };
>  
>  static DEFINE_MUTEX(eventfs_mutex);
> +DEFINE_STATIC_SRCU(eventfs_srcu);
>  
>  static const struct file_operations eventfs_file_operations = {
>  };
> @@ -299,3 +300,112 @@ int eventfs_add_file(const char *name, umode_t mode,
>  	mutex_unlock(&eventfs_mutex);
>  	return 0;
>  }
> +
> +static LLIST_HEAD(free_list);
> +
> +static void eventfs_workfn(struct work_struct *work)
> +{
> +	struct eventfs_file *ef, *tmp;
> +	struct llist_node *llnode;
> +
> +	llnode = llist_del_all(&free_list);
> +	llist_for_each_entry_safe(ef, tmp, llnode, llist) {
> +		if (ef->created && ef->dentry)
> +			dput(ef->dentry);
> +		kfree(ef->name);
> +		kfree(ef->ei);
> +		kfree(ef);
> +	}
> +}
> +
> +DECLARE_WORK(eventfs_work, eventfs_workfn);
> +
> +static void free_ef(struct rcu_head *head)
> +{
> +	struct eventfs_file *ef = container_of(head, struct eventfs_file, rcu);
> +
> +	if (!llist_add(&ef->llist, &free_list))
> +		return;
> +
> +	queue_work(system_unbound_wq, &eventfs_work);
> +}
> +
> +
> +
> +/**
> + * eventfs_remove_rec - remove eventfs dir or file from list
> + * @ef: eventfs_file to be removed.
> + *
> + * This function recursively remove eventfs_file which
> + * contains info of file or dir.
> + */
> +static void eventfs_remove_rec(struct eventfs_file *ef, int level)
> +{
> +	struct eventfs_file *ef_child;
> +
> +	if (!ef)
> +		return;
> +	/*
> +	 * Check recursion depth. It should never be greater than 3:
> +	 * 0 - events/
> +	 * 1 - events/group/
> +	 * 2 - events/group/event/
> +	 * 3 - events/group/event/file
> +	 */
> +	if (WARN_ON_ONCE(level > 3))
> +		return;
> +
> +	if (ef->ei) {
> +		/* search for nested folders or files */
> +		list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
> +					 lockdep_is_held(&eventfs_mutex)) {
> +			eventfs_remove_rec(ef_child, level + 1);
> +		}
> +	}
> +
> +	if (ef->created && ef->dentry)
> +		d_invalidate(ef->dentry);
> +
> +	list_del_rcu(&ef->list);
> +	call_srcu(&eventfs_srcu, &ef->rcu, free_ef);
> +}
> +
> +/**
> + * eventfs_remove - remove eventfs dir or file from list
> + * @ef: eventfs_file to be removed.
> + *
> + * This function acquire the eventfs_mutex lock and call eventfs_remove_rec()
> + */
> +void eventfs_remove(struct eventfs_file *ef)
> +{
> +	if (!ef)
> +		return;
> +
> +	mutex_lock(&eventfs_mutex);
> +	eventfs_remove_rec(ef, 0);
> +	mutex_unlock(&eventfs_mutex);
> +}
> +
> +/**
> + * eventfs_remove_events_dir - remove eventfs dir or file from list
> + * @dentry: events's dentry to be removed.
> + *
> + * This function remove events main directory
> + */
> +void eventfs_remove_events_dir(struct dentry *dentry)
> +{
> +	struct tracefs_inode *ti;
> +	struct eventfs_inode *ei;
> +
> +	if (!dentry || !dentry->d_inode)
> +		return;
> +
> +	ti = get_tracefs(dentry->d_inode);
> +	if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
> +		return;
> +
> +	ei = ti->private;
> +	d_invalidate(dentry);
> +	dput(dentry);
> +	kfree(ei);
> +}
> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index a51312ff803c..2c08edd4a739 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -40,6 +40,10 @@ int eventfs_add_top_file(const char *name, umode_t mode,
>  			 struct dentry *parent, void *data,
>  			 const struct file_operations *fops);
>  
> +void eventfs_remove(struct eventfs_file *ef);
> +
> +void eventfs_remove_events_dir(struct dentry *dentry);
> +
>  struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  				   struct dentry *parent, void *data,
>  				   const struct file_operations *fops);

