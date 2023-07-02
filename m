Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D773744E38
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjGBOzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 10:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGBOzb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 10:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60FDC3;
        Sun,  2 Jul 2023 07:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B7B60C22;
        Sun,  2 Jul 2023 14:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCBDC433C8;
        Sun,  2 Jul 2023 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688309728;
        bh=MGjH3l9d9I31OC1IIH78AL+8mPZjBy34In2x4mOWC/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UzalQL3mmbeP0Cql3N5Q++UMTeIadoZDGivx2+WsP1IR0B7PthD8mTSWonndFvMpM
         6+dv3ND11Ldu2TEiWfuqr/CQcyNteiIWC9CIAfAQCXlUDKRsUzZc0D2Y3t1zqtae27
         U/mHFHBTXUGfQzClRxMCVlIDgrUI69YDGsirRoUNllSSXzVxdGbERkb+u7NSRNQLC2
         LiK/R6ILoAMUpicCCQMW5CYVR4NLhY+SQBkfYjAcSRWoDZp7uiMiP0dvHkGL1JOBlg
         UJXz6Rplx3VtphOCiK7x308CY8hNVuDcv/T9bDQomK0FZW7tPXsy4kJJX9z2skR9TP
         sOWZ9clOaPfbA==
Date:   Sun, 2 Jul 2023 23:55:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com
Subject: Re: [PATCH v3 02/10] eventfs: introducing struct tracefs_inode
Message-Id: <20230702235523.c7078c72957d28163cfc1d1e@kernel.org>
In-Reply-To: <1685610013-33478-3-git-send-email-akaher@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <1685610013-33478-3-git-send-email-akaher@vmware.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu,  1 Jun 2023 14:30:05 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Introduce tracefs_inode structure, this will help eventfs
> to keep track of inode, flags and pointer to private date.
> 
> Rename function names and remove the static qualifier for
> functions that should be exposed.

I think the removing static and renaming is OK, but please do not
introduce new 'tracefs_inode' and 'get_tracefs()' which are not used.
I think those should be merged with [3/10].

Thank you,

> 
> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> ---
>  fs/tracefs/inode.c    | 21 +++++++++++----------
>  fs/tracefs/internal.h | 25 +++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 10 deletions(-)
>  create mode 100644 fs/tracefs/internal.h
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 57ac8aa4a..7df1752e8 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -21,6 +21,7 @@
>  #include <linux/parser.h>
>  #include <linux/magic.h>
>  #include <linux/slab.h>
> +#include "internal.h"
>  
>  #define TRACEFS_DEFAULT_MODE	0700
>  
> @@ -127,7 +128,7 @@ static const struct inode_operations tracefs_dir_inode_operations = {
>  	.rmdir		= tracefs_syscall_rmdir,
>  };
>  
> -static struct inode *tracefs_get_inode(struct super_block *sb)
> +struct inode *tracefs_get_inode(struct super_block *sb)
>  {
>  	struct inode *inode = new_inode(sb);
>  	if (inode) {
> @@ -399,7 +400,7 @@ static struct file_system_type trace_fs_type = {
>  };
>  MODULE_ALIAS_FS("tracefs");
>  
> -static struct dentry *start_creating(const char *name, struct dentry *parent)
> +struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
>  {
>  	struct dentry *dentry;
>  	int error;
> @@ -437,7 +438,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
>  	return dentry;
>  }
>  
> -static struct dentry *failed_creating(struct dentry *dentry)
> +struct dentry *tracefs_failed_creating(struct dentry *dentry)
>  {
>  	inode_unlock(d_inode(dentry->d_parent));
>  	dput(dentry);
> @@ -445,7 +446,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
>  	return NULL;
>  }
>  
> -static struct dentry *end_creating(struct dentry *dentry)
> +struct dentry *tracefs_end_creating(struct dentry *dentry)
>  {
>  	inode_unlock(d_inode(dentry->d_parent));
>  	return dentry;
> @@ -490,14 +491,14 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
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
> @@ -506,13 +507,13 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
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
> @@ -520,7 +521,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
>  
>  	inode = tracefs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode))
> -		return failed_creating(dentry);
> +		return tracefs_failed_creating(dentry);
>  
>  	/* Do not set bits for OTH */
>  	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
> @@ -534,7 +535,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
>  	d_instantiate(dentry, inode);
>  	inc_nlink(d_inode(dentry->d_parent));
>  	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
> -	return end_creating(dentry);
> +	return tracefs_end_creating(dentry);
>  }
>  
>  /**
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> new file mode 100644
> index 000000000..6776b4693
> --- /dev/null
> +++ b/fs/tracefs/internal.h
> @@ -0,0 +1,25 @@
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
> +
> -- 
> 2.40.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
