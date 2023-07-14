Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB27753FCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbjGNQXU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjGNQXT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:23:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169532724;
        Fri, 14 Jul 2023 09:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B6261D66;
        Fri, 14 Jul 2023 16:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F259C433C9;
        Fri, 14 Jul 2023 16:23:15 +0000 (UTC)
Date:   Fri, 14 Jul 2023 12:23:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 04/10] eventfs: Implement eventfs file add functions
Message-ID: <20230714122313.486990ea@gandalf.local.home>
In-Reply-To: <1689248004-8158-5-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-5-git-send-email-akaher@vmware.com>
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


More nits.

On Thu, 13 Jul 2023 17:03:18 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Adding following function to eventfs to add files:

Add the following functions to add files to evenfs:

> 
> eventfs_add_top_file() adds the info of top file to
> eventfs and dynamically create these files when they
> are accessed.

I wonder if we should rename this, because I didn't really know what "top"
meant. Perhaps:

 eventfs_add_events_file() to add the data needed to create a specific file
 located at the top level events directory. The dentry/inode will be
 created when the events directory is scanned.

> 
> eventfs_add_file() adds the info of nested files
> to eventfs and dynamically create these files when
> they are accessed.

 eventfs_add_file() to add the data needed for files within the directories
 below the top level events directory. The dentry/inode of the file will be
 created when the directory that the file is in is scanned.

> 
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
> ---
>  fs/tracefs/event_inode.c | 84 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/tracefs.h  |  8 ++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 4e7a8eccaa0b..75dc8953d813 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -215,3 +215,87 @@ struct eventfs_file *eventfs_add_dir(const char *name,
>  	mutex_unlock(&eventfs_mutex);
>  	return ef;
>  }
> +
> +/**
> + * eventfs_add_top_file - add event top file to list to create later

I'm still thinking we should rename this to eventfs_add_events_file() to
match the "eventfs_create_events_dir()".

 eventfs_add_events_file - add the data needed to create file in events dir


> + * @name: the name of the file to create.
> + * @mode: the permission that the file should have.
> + * @parent: parent dentry for this file.
> + * @data: something that the caller will want to get to later on. The
> + *        inode.i_private pointer will point to this value on the open() call.

Note, for kerneldoc, it's best to have the above be one line, and then add
anything else below it.
 * @data: something that the caller will want to get to later on.

> + * @fop: struct file_operations that should be used for this file.
> + *
> + * This function adds top files of event dir to list.
> + * And all these files are created on the fly when they are looked up,
> + * and the dentry and inodes will be removed when they are done.

 * This function is used to add the information needed to create a
 * dentry/inode within the top level events directory. The file created
 * will have the @mode permissions. The @data will be used to fill the
 * inode.i_private when the open() call is done. The dentry and inodes are
 * all created when they are referenced, and removed when they are no
 * longer referenced.


> + */
> +int eventfs_add_top_file(const char *name, umode_t mode,
> +			 struct dentry *parent, void *data,
> +			 const struct file_operations *fop)
> +{
> +	struct tracefs_inode *ti;
> +	struct eventfs_inode *ei;
> +	struct eventfs_file *ef;
> +
> +	if (!parent)
> +		return -EINVAL;
> +
> +	if (!(mode & S_IFMT))
> +		mode |= S_IFREG;
> +
> +	if (!parent->d_inode)
> +		return -EINVAL;
> +
> +	ti = get_tracefs(parent->d_inode);
> +	if (!(ti->flags & TRACEFS_EVENT_INODE))
> +		return -EINVAL;
> +
> +	ei = ti->private;
> +	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
> +
> +	if (IS_ERR(ef))
> +		return -ENOMEM;
> +
> +	mutex_lock(&eventfs_mutex);
> +	list_add_tail(&ef->list, &ei->e_top_files);
> +	ef->d_parent = parent;
> +	mutex_unlock(&eventfs_mutex);
> +	return 0;
> +}
> +
> +/**
> + * eventfs_add_file - add eventfs file to list to create later

Same idea here.

 eventfs_add_file - add the data needed to create a file for later reference

> + * @name: the name of the file to create.
> + * @mode: the permission that the file should have.
> + * @ef_parent: parent eventfs_file for this file.
> + * @data: something that the caller will want to get to later on. The
> + *        inode.i_private pointer will point to this value on the open() call.

And same note about the line.

> + * @fop: struct file_operations that should be used for this file.
> + *
> + * This function adds top files of event dir to list.

Seems you have a cut and paste error here.

> + * And all these files are created on the fly when they are looked up,
> + * and the dentry and inodes will be removed when they are done.

 * This function is used to add the information needed to create a
 * file within a subdirectory of the events directory. The file created
 * will have the @mode permissions. The @data will be used to fill the
 * inode.i_private when the open() call is done. The dentry and inodes are
 * all created when they are referenced, and removed when they are no
 * longer referenced.

-- Steve

> + */
> +int eventfs_add_file(const char *name, umode_t mode,
> +		     struct eventfs_file *ef_parent,
> +		     void *data,
> +		     const struct file_operations *fop)
> +{
> +	struct eventfs_file *ef;
> +
> +	if (!ef_parent)
> +		return -EINVAL;
> +
> +	if (!(mode & S_IFMT))
> +		mode |= S_IFREG;
> +
> +	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
> +	if (IS_ERR(ef))
> +		return -ENOMEM;
> +
> +	mutex_lock(&eventfs_mutex);
> +	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
> +	ef->d_parent = ef_parent->dentry;
> +	mutex_unlock(&eventfs_mutex);
> +	return 0;
> +}
> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index 432e5e6f7901..a51312ff803c 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -32,6 +32,14 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
>  struct eventfs_file *eventfs_add_dir(const char *name,
>  				     struct eventfs_file *ef_parent);
>  
> +int eventfs_add_file(const char *name, umode_t mode,
> +		     struct eventfs_file *ef_parent, void *data,
> +		     const struct file_operations *fops);
> +
> +int eventfs_add_top_file(const char *name, umode_t mode,
> +			 struct dentry *parent, void *data,
> +			 const struct file_operations *fops);
> +
>  struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  				   struct dentry *parent, void *data,
>  				   const struct file_operations *fops);

