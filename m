Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C61753E80
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 17:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjGNPLU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 11:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbjGNPLU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 11:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F5B2735;
        Fri, 14 Jul 2023 08:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CEAC61D43;
        Fri, 14 Jul 2023 15:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07830C433C7;
        Fri, 14 Jul 2023 15:11:15 +0000 (UTC)
Date:   Fri, 14 Jul 2023 11:11:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 02/10] tracefs: Rename some tracefs function
Message-ID: <20230714111113.1584f2fb@gandalf.local.home>
In-Reply-To: <1689248004-8158-3-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-3-git-send-email-akaher@vmware.com>
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


Some nits.

First, the subject should be:

 tracefs: Rename and export some tracefs functions

Yes, we should export them here too, even though they are not used yet.

On Thu, 13 Jul 2023 17:03:16 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Renaming following functions as these would require by eventfs
> as well:

I would have this state:

Export a few tracefs functions that will be needed by the eventfs dynamic
file system. Rename them to start with "tracefs_" to keep with the name
space.

> 
> start_creating -> tracefs_start_creating
> failed_creating -> tracefs_failed_creating
> end_creating -> tracefs_end_creating
> 
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> ---
>  fs/tracefs/inode.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 57ac8aa4a724..b0348efc0238 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -399,7 +399,7 @@ static struct file_system_type trace_fs_type = {
>  };
>  MODULE_ALIAS_FS("tracefs");
>  
> -static struct dentry *start_creating(const char *name, struct dentry *parent)
> +static struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)

Remove the static, and create the fs/tracefs/internal.h file in this patch.

-- Steve


>  {
>  	struct dentry *dentry;
>  	int error;
> @@ -437,7 +437,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
>  	return dentry;
>  }
>  
> -static struct dentry *failed_creating(struct dentry *dentry)
> +static struct dentry *tracefs_failed_creating(struct dentry *dentry)
>  {
>  	inode_unlock(d_inode(dentry->d_parent));
>  	dput(dentry);
> @@ -445,7 +445,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
>  	return NULL;
>  }
>  
> -static struct dentry *end_creating(struct dentry *dentry)
> +static struct dentry *tracefs_end_creating(struct dentry *dentry)
>  {
>  	inode_unlock(d_inode(dentry->d_parent));
>  	return dentry;
> @@ -490,14 +490,14 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  	if (!(mode & S_IFMT))
>  		mode |= S_IFREG;
>  	BUG_ON(!S_ISREG(mode));
> -	dentry = start_creating(name, parent);
> +	dentry = tracefs_start_creating(name, parent);
>  
>  	if (IS_ERR(dentry))
>  		return NULL;
>  
>  	inode = tracefs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode))
> -		return failed_creating(dentry);
> +		return tracefs_failed_creating(dentry);
>  
>  	inode->i_mode = mode;
>  	inode->i_fop = fops ? fops : &tracefs_file_operations;
> @@ -506,13 +506,13 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
>  	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
>  	d_instantiate(dentry, inode);
>  	fsnotify_create(d_inode(dentry->d_parent), dentry);
> -	return end_creating(dentry);
> +	return tracefs_end_creating(dentry);
>  }
>  
>  static struct dentry *__create_dir(const char *name, struct dentry *parent,
>  				   const struct inode_operations *ops)
>  {
> -	struct dentry *dentry = start_creating(name, parent);
> +	struct dentry *dentry = tracefs_start_creating(name, parent);
>  	struct inode *inode;
>  
>  	if (IS_ERR(dentry))
> @@ -520,7 +520,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
>  
>  	inode = tracefs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode))
> -		return failed_creating(dentry);
> +		return tracefs_failed_creating(dentry);
>  
>  	/* Do not set bits for OTH */
>  	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
> @@ -534,7 +534,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
>  	d_instantiate(dentry, inode);
>  	inc_nlink(d_inode(dentry->d_parent));
>  	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
> -	return end_creating(dentry);
> +	return tracefs_end_creating(dentry);
>  }
>  
>  /**

