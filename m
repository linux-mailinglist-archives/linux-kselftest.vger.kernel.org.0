Return-Path: <linux-kselftest+bounces-4232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FBC84CAD8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 13:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1841F25F8B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 12:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A0776054;
	Wed,  7 Feb 2024 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P4yKmyca"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79F59B70
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310137; cv=none; b=QSOJlt8nk5tbDBiElsSOvmdWxEzvxksSU4+LDeHk7nBISxOZJVxN9hDkuUSTSilIh8HujuD011nGmJ4/NU71VWmeimtK0gP9f1TGG5ggQ2+loqAaufwktapvFD6ulhfZFQ5xkj9Ov++Pm9brY+TA3roXhW+6rRPPVnHWfnoA/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310137; c=relaxed/simple;
	bh=OaTkpSwkJtYSB2Om1MTKXb8JfGsNiNtkpwL+RnuTIk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/Kwp0Ft73WBZL6o8oHTAI9FCYXNh1GBbK/cJgbyqZcyEmckGX0PWfjs6Bi89DUew13AAxqoXB7T1Hn6pu18CY0YW1oR6Rd0X7EQAiDiCeRDnrrokoM/8Vq/BnyDknGgjQ9w9vyCrmufd9rhvpQUwJVSvmgw/sAah0QLKk9rCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P4yKmyca; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3be61772d9aso264001b6e.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 04:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707310133; x=1707914933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43snYnfqhVNhhL/nY5EeRoRcppA5AMWu4YFrgtB90kI=;
        b=P4yKmycaZ+jwU4yDekKVtIdbh0L1VGL+BnDPNT/7uLps6MuoGGNuyO9XTFfrQo4N7u
         mK92rgxZgzNNPTh2Lav6VTJvqlbGSsjfPR/HKhFi7Ikmtd0qjia8Xno91cPLRPD+ZSFl
         l2qksesPF7V0JhAAtMw2UIZh8QBh+MpMZfUB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707310133; x=1707914933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43snYnfqhVNhhL/nY5EeRoRcppA5AMWu4YFrgtB90kI=;
        b=vCTqTSAmz5MMbyG7eZldQAUnK8NeWWoRHl6p92dd3aj9HrMOPbEDD9MSHR20Y9aRqt
         WZnm5tUC+XVVj8lVkH80fFS1RGo/OYEmagu+bXUPHQ2jndppy3t0ekoDuFx/lHF2MtJe
         svEhBKP7E4ia/gx/MsXwFf4TEfZcDLt2h4nP+Yb4yB5fmz+Fh5ybVqBIjJYSOrdK6pGO
         osoKY9nEa8ZmOufUXpeIFVU+e7z/t0r3s1PSk4xXC1caRSOUkTL1OEWQX4+nQu7vsVMq
         9JI69jREt4YAQm3ZqBseni8VRss5Tj0Tqg5+hkPElLyIw1j0akvhuX2t9MtqIo2XbWor
         HTmA==
X-Gm-Message-State: AOJu0Yzj8LE/LItLtwkw4E19oKDRh4TKqDNCRDrXeCZeAjQC1s3SZyUQ
	ie3uzWX7sUn8APb6+++6VbFkih5D8Ck4quw9kx9WMwKHtOVINRguA+1mpYWMzQ==
X-Google-Smtp-Source: AGHT+IGjgsoBVI+OT+9EEoM5ssALa71vGXB1TOK1+PBn3bRGe/Vy0iMA0tZlcGHQWBbHkQy614d4tQ==
X-Received: by 2002:a05:6358:89b:b0:176:493f:ad4d with SMTP id m27-20020a056358089b00b00176493fad4dmr2964223rwj.10.1707310132678;
        Wed, 07 Feb 2024 04:48:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWnl/OamO9Gb4PkP5VVfXqRCgq8bk2tV4Z+PuAlmKw4nqortLf/8nOzMay8K7uswxnMTdUif54u+rZEBrfreivonfDoG/DqTi6meciLe+6nZZ4MHt1djOJXL2n2Cd+yWQKkWdRklePzF6exOMoeMCL+77OEyXYYN5og2bnmdSVs/MoBIa0GkFxh/1NoXSpf8JFDYIj7VWq319qZJ973jjn1VplCzZRLevYmLvHzt6MRFB6t2BUfIzIdBRO9vCLmKviDzFCVImN3IflyGWPDjXm1T7ssNY7NEGweBWv3c3p7zRHtVwR5A804vD0yFgAEyKqUO8gyZe54TcC/lMFRC0lKbM1CjjV94J+ThPK+FFbKHpI+pTl4DI=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bx42-20020a056a02052a00b005c6e8fa9f24sm1291189pgb.49.2024.02.07.04.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:48:51 -0800 (PST)
Date: Wed, 7 Feb 2024 04:48:51 -0800
From: Kees Cook <keescook@chromium.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: tony.luck@intel.com, gpiccoli@igalia.com, shuah@kernel.org,
	corbet@lwn.net, xlpang@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Xingrui Yi <yixingrui@linux.alibaba.com>
Subject: Re: [PATCH 1/3] pstore: add multi-backend support
Message-ID: <202402070359.1FC38D60C@keescook>
References: <20240207021921.206425-1-xiangzao@linux.alibaba.com>
 <20240207021921.206425-2-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207021921.206425-2-xiangzao@linux.alibaba.com>

On Wed, Feb 07, 2024 at 10:19:19AM +0800, Yuanhe Shu wrote:
> Currently, pstore supports only one backend open at a time.
> Specifically, due to the global variable "psinfo", pstore only accepts
> the first registered backend. If a new backend wants to register later,
> pstore will simply reject it and return an error. This design forced us
> to close existing backend in order to use the new ones.
> 
> To enable pstore to support multiple backends, "psinfo" is replaced by
> "psinfo_list", a list that holds multiple "psinfo". If multiple backends
> are registered with the same frontend, the frontend is reused.
> 
> User can specify multiple backends that are allowed to be registered by
> module parameter "pstore.backend=" separated by commas or "all" to
> enable all available backends. If no pstore.backend was specified,
> pstore would accept the first registered backend which is the same as
> before.
> 
> Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> ---
>  fs/pstore/ftrace.c     |  31 +++++-
>  fs/pstore/inode.c      |  19 ++--
>  fs/pstore/internal.h   |   4 +-
>  fs/pstore/platform.c   | 225 ++++++++++++++++++++++++++++-------------
>  fs/pstore/pmsg.c       |  24 ++++-
>  include/linux/pstore.h |  29 ++++++
>  6 files changed, 250 insertions(+), 82 deletions(-)
> 
> diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
> index 776cae20af4e..49b9c8532dab 100644
> --- a/fs/pstore/ftrace.c
> +++ b/fs/pstore/ftrace.c
> @@ -23,10 +23,11 @@
>  /* This doesn't need to be atomic: speed is chosen over correctness here. */
>  static u64 pstore_ftrace_stamp;
>  
> -static void notrace pstore_ftrace_call(unsigned long ip,
> +static void notrace pstore_do_ftrace(unsigned long ip,
>  				       unsigned long parent_ip,
>  				       struct ftrace_ops *op,
> -				       struct ftrace_regs *fregs)
> +				       struct ftrace_regs *fregs,
> +				       struct pstore_info *psinfo)
>  {
>  	int bit;
>  	unsigned long flags;
> @@ -57,6 +58,20 @@ static void notrace pstore_ftrace_call(unsigned long ip,
>  	ftrace_test_recursion_unlock(bit);
>  }
>  
> +static void notrace pstore_ftrace_call(unsigned long ip,
> +				       unsigned long parent_ip,
> +				       struct ftrace_ops *op,
> +				       struct ftrace_regs *fregs)
> +{
> +	struct pstore_info_list *entry;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, &psback->list_entry, list)
> +		if (entry->psi->flags & PSTORE_FLAGS_FTRACE)
> +			pstore_do_ftrace(ip, parent_ip, op, fregs, entry->psi);
> +	rcu_read_unlock();

Just to make sure I understand the purpose of the RCU here is to deal
with having a backend get unregistered while something is walking this
list? And to do so without holding the global psback_lock?

> +}
> +
>  static struct ftrace_ops pstore_ftrace_ops __read_mostly = {
>  	.func	= pstore_ftrace_call,
>  };
> @@ -131,8 +146,16 @@ MODULE_PARM_DESC(record_ftrace,
>  
>  void pstore_register_ftrace(void)
>  {
> -	if (!psinfo->write)
> -		return;
> +	struct pstore_info_list *entry;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, &psback->list_entry, list)
> +		if (entry->psi->flags & PSTORE_FLAGS_FTRACE)
> +			if (!entry->psi->write) {
> +				rcu_read_unlock();
> +				return;
> +			}
> +	rcu_read_unlock();
>  
>  	pstore_ftrace_dir = debugfs_create_dir("pstore", NULL);
>  
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index d0d9bfdad30c..bee71c7da995 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -285,7 +285,7 @@ static const struct super_operations pstore_ops = {
>  	.show_options	= pstore_show_options,
>  };
>  
> -static struct dentry *psinfo_lock_root(void)
> +static struct dentry *psinfo_lock_root(struct pstore_info *psinfo)
>  {
>  	struct dentry *root;
>  
> @@ -309,7 +309,7 @@ int pstore_put_backend_records(struct pstore_info *psi)
>  	struct dentry *root;
>  	int rc = 0;
>  
> -	root = psinfo_lock_root();
> +	root = psinfo_lock_root(psi);
>  	if (!root)
>  		return 0;
>  
> @@ -398,21 +398,22 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>   * when we are re-scanning the backing store looking to add new
>   * error records.
>   */
> -void pstore_get_records(int quiet)
> +void pstore_get_records(struct pstore_info *psi, int quiet)
>  {
>  	struct dentry *root;
>  
> -	root = psinfo_lock_root();
> +	root = psinfo_lock_root(psi);
>  	if (!root)
>  		return;
>  
> -	pstore_get_backend_records(psinfo, root, quiet);
> +	pstore_get_backend_records(psi, root, quiet);
>  	inode_unlock(d_inode(root));
>  }
>  
>  static int pstore_fill_super(struct super_block *sb, void *data, int silent)
>  {
>  	struct inode *inode;
> +	struct pstore_info_list *entry;
>  
>  	sb->s_maxbytes		= MAX_LFS_FILESIZE;
>  	sb->s_blocksize		= PAGE_SIZE;
> @@ -437,7 +438,13 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
>  	scoped_guard(mutex, &pstore_sb_lock)
>  		pstore_sb = sb;
>  
> -	pstore_get_records(0);
> +	if (!psback)
> +		return 0;
> +
> +	mutex_lock(&psback_lock);
> +	list_for_each_entry(entry, &psback->list_entry, list)
> +		pstore_get_records(entry->psi, 0);
> +	mutex_unlock(&psback_lock);
>  
>  	return 0;
>  }
> diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
> index 801d6c0b170c..4b1c7ba27052 100644
> --- a/fs/pstore/internal.h
> +++ b/fs/pstore/internal.h
> @@ -33,10 +33,10 @@ static inline void pstore_register_pmsg(void) {}
>  static inline void pstore_unregister_pmsg(void) {}
>  #endif
>  
> -extern struct pstore_info *psinfo;
> +extern struct pstore_backends *psback;
>  
>  extern void	pstore_set_kmsg_bytes(int);
> -extern void	pstore_get_records(int);
> +extern void	pstore_get_records(struct pstore_info *psi, int quiet);
>  extern void	pstore_get_backend_records(struct pstore_info *psi,
>  					   struct dentry *root, int quiet);
>  extern int	pstore_put_backend_records(struct pstore_info *psi);
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 03425928d2fb..432a41852a07 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -62,12 +62,12 @@ static void pstore_dowork(struct work_struct *);
>  static DECLARE_WORK(pstore_work, pstore_dowork);
>  
>  /*
> - * psinfo_lock protects "psinfo" during calls to
> + * psback_lock protects "psback" during calls to
>   * pstore_register(), pstore_unregister(), and
>   * the filesystem mount/unmount routines.
>   */
> -static DEFINE_MUTEX(psinfo_lock);
> -struct pstore_info *psinfo;
> +DEFINE_MUTEX(psback_lock);
> +struct pstore_backends *psback;
>  
>  static char *backend;
>  module_param(backend, charp, 0444);
> @@ -104,7 +104,7 @@ static void *compress_workspace;
>   */
>  #define DMESG_COMP_PERCENT	60
>  
> -static char *big_oops_buf;
> +static char *big_oops_buf[PSTORE_BACKEND_NUM];

I think big_oops_buf should live in the pstore_info_list struct, then
no indexes are needed to be tracked.

>  static size_t max_compressed_size;
>  
>  void pstore_set_kmsg_bytes(int bytes)
> @@ -201,7 +201,7 @@ static int pstore_compress(const void *in, void *out,
>  	return zstream.total_out;
>  }
>  
> -static void allocate_buf_for_compression(void)
> +static void allocate_buf_for_compression(struct pstore_info *psinfo, int pos)
>  {
>  	size_t compressed_size;
>  	char *buf;
> @@ -241,21 +241,21 @@ static void allocate_buf_for_compression(void)
>  	}
>  
>  	/* A non-NULL big_oops_buf indicates compression is available. */
> -	big_oops_buf = buf;
> +	big_oops_buf[pos] = buf;

e.g.:	entry->big_oops_buf = buf;

>  	max_compressed_size = compressed_size;

And should this be included as well, or are we just constantly setting
this to the same value?

>  
>  	pr_info("Using crash dump compression: %s\n", compress);
>  }
>  
> -static void free_buf_for_compression(void)
> +static void free_buf_for_compression(int pos)

Instead of "pos" this would take the ps_info.

>  {
>  	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && compress_workspace) {
>  		vfree(compress_workspace);
>  		compress_workspace = NULL;
>  	}
>  
> -	kvfree(big_oops_buf);
> -	big_oops_buf = NULL;
> +	kvfree(big_oops_buf[pos]);
> +	big_oops_buf[pos] = NULL;
>  	max_compressed_size = 0;
>  }
>  
> @@ -274,8 +274,9 @@ void pstore_record_init(struct pstore_record *record,
>   * callback from kmsg_dump. Save as much as we can (up to kmsg_bytes) from the
>   * end of the buffer.
>   */
> -static void pstore_dump(struct kmsg_dumper *dumper,
> -			enum kmsg_dump_reason reason)
> +static void pstore_do_dump(struct kmsg_dumper *dumper,
> +			enum kmsg_dump_reason reason,
> +			struct pstore_info *psinfo, int pos)
>  {
>  	struct kmsg_dump_iter iter;
>  	unsigned long	total = 0;
> @@ -315,7 +316,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>  		record.part = part;
>  		record.buf = psinfo->buf;
>  
> -		dst = big_oops_buf ?: psinfo->buf;
> +		dst = big_oops_buf[pos] ?: psinfo->buf;
>  		dst_size = max_compressed_size ?: psinfo->bufsize;
>  
>  		/* Write dump header. */
> @@ -328,7 +329,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>  					  dst_size, &dump_size))
>  			break;
>  
> -		if (big_oops_buf) {
> +		if (big_oops_buf[pos]) {
>  			zipped_len = pstore_compress(dst, psinfo->buf,
>  						header_size + dump_size,
>  						psinfo->bufsize);
> @@ -372,6 +373,19 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>  	}
>  }
>  
> +static void pstore_dump(struct kmsg_dumper *dumper,
> +			enum kmsg_dump_reason reason)
> +{
> +	struct pstore_info_list *entry;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, &psback->list_entry, list)
> +		if (entry->psi->flags & PSTORE_FLAGS_DMESG)
> +			pstore_do_dump(dumper, reason,
> +				       entry->psi, entry->index);

Then no need for index here.

> +	rcu_read_unlock();
> +}
> +
>  static struct kmsg_dumper pstore_dumper = {
>  	.dump = pstore_dump,
>  };
> @@ -390,13 +404,11 @@ static void pstore_unregister_kmsg(void)
>  }
>  
>  #ifdef CONFIG_PSTORE_CONSOLE
> -static void pstore_console_write(struct console *con, const char *s, unsigned c)
> +static void pstore_console_do_write(struct console *con, const char *s,
> +				    unsigned c, struct pstore_info *psinfo)
>  {
>  	struct pstore_record record;
>  
> -	if (!c)
> -		return;
> -
>  	pstore_record_init(&record, psinfo);
>  	record.type = PSTORE_TYPE_CONSOLE;
>  
> @@ -405,6 +417,21 @@ static void pstore_console_write(struct console *con, const char *s, unsigned c)
>  	psinfo->write(&record);
>  }
>  
> +static void pstore_console_write(struct console *con, const char *s,
> +				 unsigned int c)
> +{
> +	struct pstore_info_list *entry;
> +
> +	if (!c)
> +		return;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, &psback->list_entry, list)
> +		if (entry->psi->flags & PSTORE_FLAGS_CONSOLE)
> +			pstore_console_do_write(con, s, c, entry->psi);
> +	rcu_read_unlock();
> +}
> +
>  static struct console pstore_console = {
>  	.write	= pstore_console_write,
>  	.index	= -1,
> @@ -413,7 +440,7 @@ static struct console pstore_console = {
>  static void pstore_register_console(void)
>  {
>  	/* Show which backend is going to get console writes. */
> -	strscpy(pstore_console.name, psinfo->name,
> +	strscpy(pstore_console.name, "pstore console",
>  		sizeof(pstore_console.name));

A nice-to-have for this might be to include all the backend names
included, but that is probably overkill, so this is fine.

>  	/*
>  	 * Always initialize flags here since prior unregister_console()
> @@ -464,12 +491,15 @@ static int pstore_write_user_compat(struct pstore_record *record,
>   */
>  int pstore_register(struct pstore_info *psi)
>  {
> +	struct pstore_info_list *entry;
> +	struct pstore_info_list *newpsi;
>  	char *new_backend;
>  
> -	if (backend && strcmp(backend, psi->name)) {
> -		pr_warn("backend '%s' already in use: ignoring '%s'\n",
> -			backend, psi->name);
> -		return -EBUSY;
> +	/* backend has to be enabled for going on registering */
> +	if (backend && !strstr(backend, psi->name) &&

I think I'd like a helper to do the "is this name in the list?", as that
would be more robust. e.g. if we ever had a "ram" backend and a "cram"
backend, and someone used "backend=cram", suddenly both "cram" and "ram"
match in the code above.

> +	    strcmp(backend, "all")) {

style preference, can you make this strcmp be:

	    strcmp(backend, "all") != 0

it seems redundant, but it helps readers remember that "strcmp() == 0"
is "matches".


> +		pr_warn("backend '%s' not enabled\n", psi->name);

nit, I think a more clear error might be something like:

	"backend '%s' ignored: not present in pstore.backend=...\n"

which gives people a little hint about what's wrong.

> +		return -EINVAL;
>  	}
>  
>  	/* Sanity check flags. */
> @@ -486,79 +516,118 @@ int pstore_register(struct pstore_info *psi)
>  		return -EINVAL;
>  	}
>  
> -	new_backend = kstrdup(psi->name, GFP_KERNEL);
> -	if (!new_backend)
> -		return -ENOMEM;
> -
> -	mutex_lock(&psinfo_lock);
> -	if (psinfo) {
> -		pr_warn("backend '%s' already loaded: ignoring '%s'\n",
> -			psinfo->name, psi->name);
> -		mutex_unlock(&psinfo_lock);
> -		kfree(new_backend);
> -		return -EBUSY;
> +	mutex_lock(&psback_lock);
> +
> +	/*
> +	 * If no backend specified, first come first served to
> +	 * maintain backward compatibility
> +	 */
> +	if (!backend) {
> +		pr_warn("no backend enabled, registering backend '%s'\n",
> +			psi->name);

I'd move this to after the if below, so you can't get this message if it
were going to just immediately fail. And a nit on language. I think this
would be more clear:

	"pstore.backend=... not specified; registering first available: '%s'\n"

> +		new_backend = kstrdup(psi->name, GFP_KERNEL);
> +		if (!new_backend) {
> +			mutex_unlock(&psback_lock);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	if (psback) {
> +		if (psback->flag == PSTORE_LIST_FULL) {
> +			pr_warn("backend registration space is used up: "
> +				"ignoring '%s'\n", psi->name);
> +			mutex_unlock(&psback_lock);
> +			return -EBUSY;
> +		}

All of this flag/index stuff can go away with big_oops_buf moved.

> +		list_for_each_entry(entry, &psback->list_entry, list) {
> +			if (strcmp(entry->psi->name, psi->name) == 0) {
> +				pr_warn("backend '%s' already loaded\n",
> +					psi->name);

	"backend '%s' already loaded; not loading it again\n"

> +				mutex_unlock(&psback_lock);
> +				return -EPERM;
> +			}
> +		}
> +	} else {
> +		psback = kzalloc(sizeof(*psback), GFP_KERNEL);
> +		INIT_LIST_HEAD(&psback->list_entry);
>  	}
>  
>  	if (!psi->write_user)
>  		psi->write_user = pstore_write_user_compat;
> -	psinfo = psi;
> -	mutex_init(&psinfo->read_mutex);
> -	spin_lock_init(&psinfo->buf_lock);
> +	newpsi = kzalloc(sizeof(*newpsi), GFP_KERNEL);
> +	newpsi->psi = psi;
> +	newpsi->index = ffz(psback->flag);
> +	psback->flag |= (1 << newpsi->index);
> +
> +	mutex_init(&psi->read_mutex);
> +	spin_lock_init(&psi->buf_lock);
> +
> +	if (psi->flags & PSTORE_FLAGS_DMESG &&
> +	    !psback->front_cnt[PSTORE_TYPE_DMESG])
> +		allocate_buf_for_compression(psi, newpsi->index);

Can't we just ignore the front_cnt? The only reason to have
big_oops_buf is if the backend supports PSTORE_FLAGS_DMESG, yes?

>  
> -	if (psi->flags & PSTORE_FLAGS_DMESG)
> -		allocate_buf_for_compression();
> +	pstore_get_records(psi, 0);
>  
> -	pstore_get_records(0);
> +	list_add_rcu(&newpsi->list, &psback->list_entry);
>  
> -	if (psi->flags & PSTORE_FLAGS_DMESG) {
> -		pstore_dumper.max_reason = psinfo->max_reason;
> +	if (psi->flags & PSTORE_FLAGS_DMESG &&
> +	    !psback->front_cnt[PSTORE_TYPE_DMESG]++) {
> +		pstore_dumper.max_reason = psi->max_reason;
>  		pstore_register_kmsg();
>  	}

Hmm... does this mean we need multiple pstore_dump instances? (i.e. like
big_oops_buf) The backend configures the max_reason, so we'll need to
register multiple kmsg handlers to have different max_reasons. Right now
this just means "last registered backend wins" which would be
surprising.

Let's add a pstore_dumper instance to pstore_info_list, along with
big_oops_buf. All of these globals are really per-backend instances now.

> -	if (psi->flags & PSTORE_FLAGS_CONSOLE)
> +	if (psi->flags & PSTORE_FLAGS_CONSOLE
> +	    && !psback->front_cnt[PSTORE_TYPE_CONSOLE]++)
>  		pstore_register_console();
> -	if (psi->flags & PSTORE_FLAGS_FTRACE)
> +	if (psi->flags & PSTORE_FLAGS_FTRACE &&
> +	    !psback->front_cnt[PSTORE_TYPE_FTRACE]++)
>  		pstore_register_ftrace();
> -	if (psi->flags & PSTORE_FLAGS_PMSG)
> +	if (psi->flags & PSTORE_FLAGS_PMSG &&
> +	    !psback->front_cnt[PSTORE_TYPE_PMSG]++)
>  		pstore_register_pmsg();
>  
>  	/* Start watching for new records, if desired. */
>  	pstore_timer_kick();
>  
>  	/*
> -	 * Update the module parameter backend, so it is visible
> +	 * When module parameter backend is not specified,
> +	 * update the module parameter backend, so it is visible
>  	 * through /sys/module/pstore/parameters/backend
>  	 */
> -	backend = new_backend;
> +	if (!backend)
> +		backend = new_backend;
>  
>  	pr_info("Registered %s as persistent store backend\n", psi->name);
>  
> -	mutex_unlock(&psinfo_lock);
> +	mutex_unlock(&psback_lock);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pstore_register);
>  
>  void pstore_unregister(struct pstore_info *psi)
>  {
> +	struct pstore_info_list *entry;
>  	/* It's okay to unregister nothing. */
>  	if (!psi)
>  		return;
>  
> -	mutex_lock(&psinfo_lock);
> -
> -	/* Only one backend can be registered at a time. */
> -	if (WARN_ON(psi != psinfo)) {
> -		mutex_unlock(&psinfo_lock);
> +	/* Can not unregister an unenabled backend*/
> +	if (WARN_ON(!strstr(backend, psi->name) && strcmp(backend, "all")))
>  		return;
> -	}
> +
> +	mutex_lock(&psback_lock);
>  
>  	/* Unregister all callbacks. */
> -	if (psi->flags & PSTORE_FLAGS_PMSG)
> +	if (psi->flags & PSTORE_FLAGS_PMSG &&
> +	    !--psback->front_cnt[PSTORE_TYPE_PMSG])
>  		pstore_unregister_pmsg();
> -	if (psi->flags & PSTORE_FLAGS_FTRACE)
> +	if (psi->flags & PSTORE_FLAGS_FTRACE &&
> +	    !--psback->front_cnt[PSTORE_TYPE_FTRACE])
>  		pstore_unregister_ftrace();
> -	if (psi->flags & PSTORE_FLAGS_CONSOLE)
> +	if (psi->flags & PSTORE_FLAGS_CONSOLE &&
> +	    !--psback->front_cnt[PSTORE_TYPE_CONSOLE])
>  		pstore_unregister_console();
> -	if (psi->flags & PSTORE_FLAGS_DMESG)
> +	if (psi->flags & PSTORE_FLAGS_DMESG &&
> +	    !--psback->front_cnt[PSTORE_TYPE_DMESG])
>  		pstore_unregister_kmsg();
>  
>  	/* Stop timer and make sure all work has finished. */
> @@ -568,19 +637,30 @@ void pstore_unregister(struct pstore_info *psi)
>  	/* Remove all backend records from filesystem tree. */
>  	pstore_put_backend_records(psi);
>  
> -	free_buf_for_compression();
> +	list_for_each_entry(entry, &psback->list_entry, list) {

Since you're using list_del below, doesn't this above need to use the
_safe version of the list walker?

> +		if (entry->psi == psi) {
> +			list_del_rcu(&entry->list);
> +			psback->flag ^= 1 << entry->index;
> +			synchronize_rcu();

Do we want the synchronize here? I think it might be better to do the
list removal first, and then outside of the psback_lock we can do it and
finalize the cleanup.

> +			free_buf_for_compression(entry->index);
> +			kfree(entry);
> +			break;
> +		}
> +	}
>  
> -	psinfo = NULL;
> -	kfree(backend);
> -	backend = NULL;
> +	if (psback->flag == PSOTRE_LIST_EMPTY) {
> +		kfree(psback);
> +		psback = NULL;
> +	}
>  
>  	pr_info("Unregistered %s as persistent store backend\n", psi->name);

As this might help with debugging, can you move this pr_info to near the
top of the function (and say "Unregistering '%s' ...") so any weird
problems reported to dmesg will show up _after_ this report of intent.
:)

> -	mutex_unlock(&psinfo_lock);
> +	mutex_unlock(&psback_lock);
>  }
>  EXPORT_SYMBOL_GPL(pstore_unregister);
>  
>  static void decompress_record(struct pstore_record *record,
> -			      struct z_stream_s *zstream)
> +			      struct z_stream_s *zstream,
> +			      struct pstore_info *psinfo)
>  {
>  	int ret;
>  	int unzipped_len;
> @@ -697,7 +777,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
>  			break;
>  		}
>  
> -		decompress_record(record, &zstream);
> +		decompress_record(record, &zstream, psi);
>  		rc = pstore_mkfile(root, record);
>  		if (rc) {
>  			/* pstore_mkfile() did not take record, so free it. */
> @@ -729,7 +809,12 @@ void pstore_get_backend_records(struct pstore_info *psi,
>  
>  static void pstore_dowork(struct work_struct *work)
>  {
> -	pstore_get_records(1);
> +	struct pstore_info_list *entry;
> +
> +	mutex_lock(&psback_lock);
> +	list_for_each_entry(entry, &psback->list_entry, list)
> +		pstore_get_records(entry->psi, 1);
> +	mutex_unlock(&psback_lock);
>  }
>  
>  static void pstore_timefunc(struct timer_list *unused)
> @@ -745,11 +830,15 @@ static void pstore_timefunc(struct timer_list *unused)
>  static int __init pstore_init(void)
>  {
>  	int ret;
> +	struct pstore_info_list *entry;
>  
>  	ret = pstore_init_fs();
> -	if (ret)
> -		free_buf_for_compression();
> -
> +	if (ret) {
> +		mutex_lock(&psback_lock);
> +		list_for_each_entry(entry, &psback->list_entry, list)
> +			free_buf_for_compression(entry->index);
> +		mutex_unlock(&psback_lock);

At init, we'll have no list, yes?

> +	}
>  	return ret;
>  }
>  late_initcall(pstore_init);
> diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
> index 55f139afa327..9d5b8602e273 100644
> --- a/fs/pstore/pmsg.c
> +++ b/fs/pstore/pmsg.c
> @@ -11,8 +11,9 @@
>  
>  static DEFINE_MUTEX(pmsg_lock);
>  
> -static ssize_t write_pmsg(struct file *file, const char __user *buf,
> -			  size_t count, loff_t *ppos)
> +static ssize_t do_write_pmsg(struct file *file, const char __user *buf,
> +			     size_t count, loff_t *ppos,
> +			     struct pstore_info *psinfo)
>  {
>  	struct pstore_record record;
>  	int ret;
> @@ -34,6 +35,25 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
>  	return ret ? ret : count;
>  }
>  
> +static ssize_t write_pmsg(struct file *file, const char __user *buf,
> +			  size_t count, loff_t *ppos)
> +{
> +	int ret, _ret;
> +	struct pstore_info_list *entry;
> +
> +	mutex_lock(&psback_lock);
> +	list_for_each_entry(entry, &psback->list_entry, list) {
> +		if (entry->psi->flags & PSTORE_FLAGS_PMSG) {
> +			_ret = do_write_pmsg(file, buf, count,
> +					     ppos, entry->psi);
> +			ret = ret > _ret ? ret : _ret;

I'm not sure this "ret" handling is correct. What's your goal with it?

I think we need to report either the max seen _ret, or the first
negative return value.

(This reminds me of LSM stacking.)

so:

	ssize_t err = 0;
	ssize_t written = 0;
	ssize_t ret;

	for each {
		ret = do_write_pmsg();
		if (!err && ret < 0)
			err = ret;
		written = max(ret, written);
	}
	...
	return err ? err : written;

So we'll return an error if we hit one, otherwise the longest scan of
written bytes.

This does run the risk of breaking backends that will split up writes,
but I don't think that's a problem in reality yet.

For example, if "count" was 100, and a backend wrote 10, pstore_write()
will return 10, and userspace will turn around and try to write the next
90 bytes. If we want to support it, we'll need to do the retry within
the above code, but I think that's overkill currently. Maybe just leave
a comment about it for now.

> +		}
> +	}
> +	mutex_unlock(&psback_lock);
> +
> +	return ret;
> +}
> +
>  static const struct file_operations pmsg_fops = {
>  	.owner		= THIS_MODULE,
>  	.llseek		= noop_llseek,
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index 638507a3c8ff..0d2be20c8929 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -201,6 +201,35 @@ struct pstore_info {
>  	int		(*erase)(struct pstore_record *record);
>  };
>  
> +/* Supported multibackends */
> +#define PSTORE_MAX_BACKEND_LENGTH 100
> +#define PSTORE_BACKEND_NUM 16
> +
> +#define PSTORE_LIST_FULL (BIT(PSTORE_BACKEND_NUM) - 1)
> +#define PSOTRE_LIST_EMPTY 0
> +
> +extern struct mutex psback_lock;
> +
> +struct pstore_info_list {
> +	struct pstore_info *psi;
> +	struct list_head list;
> +	int index;
> +};
> +
> +/**
> + * struct pstore_backends - management of pstore backends
> + * @list_entry:	entry of pstore backend driver information list
> + * @front_cnt:	count of each enabled frontend
> + * @flag:	bitmap of enabled pstore backend
> + *
> + */
> +
> +struct pstore_backends {
> +	struct list_head list_entry;
> +	int front_cnt[PSTORE_TYPE_MAX];
> +	u16 flag;
> +};

I think all of this can just live in pstore_info_list, yes?

> +
>  /* Supported frontends */
>  #define PSTORE_FLAGS_DMESG	BIT(0)
>  #define PSTORE_FLAGS_CONSOLE	BIT(1)
> -- 
> 2.39.3
> 

This is continuing to look good! Thanks for the work. :)

-- 
Kees Cook

