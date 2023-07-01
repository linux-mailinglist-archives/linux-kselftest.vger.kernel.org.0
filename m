Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7AD74492D
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jul 2023 15:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGANZM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Jul 2023 09:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGANZL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Jul 2023 09:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D6B3AA7;
        Sat,  1 Jul 2023 06:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B73E60B71;
        Sat,  1 Jul 2023 13:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1536C433C7;
        Sat,  1 Jul 2023 13:25:06 +0000 (UTC)
Date:   Sat, 1 Jul 2023 09:25:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     mhiramat@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com
Subject: Re: [PATCH v3 02/10] eventfs: introducing struct tracefs_inode
Message-ID: <20230701092502.0b167e9c@rorschach.local.home>
In-Reply-To: <1685610013-33478-3-git-send-email-akaher@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <1685610013-33478-3-git-send-email-akaher@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu,  1 Jun 2023 14:30:05 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Introduce tracefs_inode structure, this will help eventfs
> to keep track of inode, flags and pointer to private date.
> 
> Rename function names and remove the static qualifier for
> functions that should be exposed.

We should probably break this patch up into two. Or at least remove the
static functions and make them non static whet they are needed.
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

[..]

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
> +static inline struct tracefs_inode *get_tracefs(const struct inode
> *inode) +{
> +	return container_of(inode, struct tracefs_inode, vfs_inode);
> +}
> +
> +struct dentry *tracefs_start_creating(const char *name, struct
> dentry *parent); +struct dentry *tracefs_end_creating(struct dentry
> *dentry); +struct dentry *tracefs_failed_creating(struct dentry
> *dentry); +struct inode *tracefs_get_inode(struct super_block *sb);
> +
> +#endif /* _TRACEFS_INTERNAL_H */

> +

git complains about the above extra line.

-- Steve
