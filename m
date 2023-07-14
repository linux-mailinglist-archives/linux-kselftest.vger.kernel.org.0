Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3DC7543B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 22:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbjGNU1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 16:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjGNU1U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 16:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EADE1995;
        Fri, 14 Jul 2023 13:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D48C61DF0;
        Fri, 14 Jul 2023 20:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE78AC433C7;
        Fri, 14 Jul 2023 20:27:16 +0000 (UTC)
Date:   Fri, 14 Jul 2023 16:27:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org, chinglinyu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, amakhalov@vmware.com,
        er.ajay.kaher@gmail.com, srivatsa@csail.mit.edu, tkundu@vmware.com,
        vsirnapalli@vmware.com
Subject: Re: [PATCH v4 08/10] eventfs: Implement tracefs_inode_cache
Message-ID: <20230714162714.2f33e884@gandalf.local.home>
In-Reply-To: <1689248004-8158-9-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
        <1689248004-8158-9-git-send-email-akaher@vmware.com>
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


I wonder if this should be patch 2?

On Thu, 13 Jul 2023 17:03:22 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Creating tracefs_inode_cache which is a cache of tracefs_inode.

Create a kmem cache of tracefs_inodes. To be more efficient, as there are
lots of tracefs inodes, create its own cache. This also allows to see how
many tracefs inodes have been created.

> Adding helping functions:

Add helper functions:

> tracefs_alloc_inode()
> tracefs_free_inode()
> 

-- Steve

> Signed-off-by: Ajay Kaher <akaher@vmware.com>
> Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Tested-by: Ching-lin Yu <chinglinyu@google.com>
> ---
>  fs/tracefs/inode.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 7dc692a5fee1..76820d3e97eb 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -21,13 +21,33 @@
>  #include <linux/parser.h>
>  #include <linux/magic.h>
>  #include <linux/slab.h>
> +#include "internal.h"
>  
>  #define TRACEFS_DEFAULT_MODE	0700
> +static struct kmem_cache *tracefs_inode_cachep __ro_after_init;
>  
>  static struct vfsmount *tracefs_mount;
>  static int tracefs_mount_count;
>  static bool tracefs_registered;
>  
> +static struct inode *tracefs_alloc_inode(struct super_block *sb)
> +{
> +	struct tracefs_inode *ti;
> +
> +	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
> +	if (!ti)
> +		return NULL;
> +
> +	ti->flags = 0;
> +
> +	return &ti->vfs_inode;
> +}
> +
> +static void tracefs_free_inode(struct inode *inode)
> +{
> +	kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
> +}
> +
>  static ssize_t default_read_file(struct file *file, char __user *buf,
>  				 size_t count, loff_t *ppos)
>  {
> @@ -346,6 +366,9 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
>  }
>  
>  static const struct super_operations tracefs_super_operations = {
> +	.alloc_inode    = tracefs_alloc_inode,
> +	.free_inode     = tracefs_free_inode,
> +	.drop_inode     = generic_delete_inode,
>  	.statfs		= simple_statfs,
>  	.remount_fs	= tracefs_remount,
>  	.show_options	= tracefs_show_options,
> @@ -675,10 +698,26 @@ bool tracefs_initialized(void)
>  	return tracefs_registered;
>  }
>  
> +static void init_once(void *foo)
> +{
> +	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
> +
> +	inode_init_once(&ti->vfs_inode);
> +}
> +
>  static int __init tracefs_init(void)
>  {
>  	int retval;
>  
> +	tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
> +						 sizeof(struct tracefs_inode),
> +						 0, (SLAB_RECLAIM_ACCOUNT|
> +						     SLAB_MEM_SPREAD|
> +						     SLAB_ACCOUNT),
> +						 init_once);
> +	if (!tracefs_inode_cachep)
> +		return -ENOMEM;
> +
>  	retval = sysfs_create_mount_point(kernel_kobj, "tracing");
>  	if (retval)
>  		return -EINVAL;

