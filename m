Return-Path: <linux-kselftest+bounces-45055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48832C3E6A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 05:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB2618806C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 04:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CAC289E06;
	Fri,  7 Nov 2025 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJTH0xva"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CB2773DE;
	Fri,  7 Nov 2025 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488705; cv=none; b=Nb64Dew2XioyzwrHQVMBXXOu0q0PgRzIlQyUWxHfuenOD4MC9997LaB4ShQnrAlOXq/Em+qo4uE7HCLXmk+HYqPrm9QAP+YfA593aP+Zg6BofQtOoR/LtSRRFseTiLeDc+fo8aYjQFYtldeQMWx2u8L4HFi/CP7eSzva7pUH9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488705; c=relaxed/simple;
	bh=th2E8+QU+yfvvJ5Gmg7E/hGmAuvFHm0uZFOBD3mOAQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0/MyacUYUwCu0HpliKbQZ0uHOYnkMNYr565lf22wOPZSdq2UGzTtlCh4u5M/lKZXaJflB2Xnf66rz7tBF1M+eLUF31v4RMaJHwimzluRJMTXbJKbznLmHYk7cC22ShwEX2nV563pYn3+aNS82pohBB2+9aa8Z38BD9sWiSGQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJTH0xva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE3FC4CEF5;
	Fri,  7 Nov 2025 04:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762488705;
	bh=th2E8+QU+yfvvJ5Gmg7E/hGmAuvFHm0uZFOBD3mOAQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJTH0xvaAjFduWgMUvyjzqRRTDtuJr9QlxUpra1sv4Re+hAYK/Xz7XBcl2OU/VOit
	 O1bt/7rczePeLP/TB9ttV6CDeNVgu/OSr7zLPKiUX+UU03uGNHDZs/4QBX1cJi7QoT
	 Yl4/EwuV/5pqPjJ5UE3jW2egIi3OfZecbliQXvslvJrwaZLDoHvMm/UkdOAFhS1SPy
	 9agiEZCjEvB5L3GM85j/xvKbJm+JFDgfAJxqRtVzLgJA3GbsALIuNxk4ClrZMK8Tm6
	 GnyVyX50JimD6tIL9ZHT7/+pbKCm2IdQSt4MJBV/dSHs7tuZ9nn21SOu717nSXNp9s
	 825/PoaWf/Kwg==
Date: Fri, 7 Nov 2025 04:11:40 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <aQ1xfHuyg1y8eJQ_@google.com>
References: <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021121536.GG316284@nvidia.com>

On Tue, Oct 21, 2025 at 09:15:36AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 21, 2025 at 04:49:59AM +0000, Tzung-Bi Shih wrote:
> 
> > I didn't get the idea.  With a mutex, how to handle the opening files?
> > 
> > Are they something like: (?)
> > - Maintain a list for opening files in both .open() and .release().
> > - In misc_deregister_sync(), traverse the list, do something (what?), and
> >   wait for the userspace programs close the files.
> 
> You don't need any list, we don't want to close files.
> 
> Something like this, it is very simple. You can replace the rwsem with
> a srcu. srcu gives faster read locking but much slower sync.
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index c2ddb998f3c943..69bbfe9de4f3bb 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -5,6 +5,7 @@
>   *  Copyright (C) 1991, 1992  Linus Torvalds
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/init.h>
>  #include <linux/fs.h>
>  #include <linux/kdev_t.h>
> @@ -343,6 +344,74 @@ void __unregister_chrdev(unsigned int major, unsigned int baseminor,
>  	kfree(cd);
>  }
>  
> +struct cdev_sync_data {
> +	struct rw_semaphore sem;
> +	const struct file_operations *orig_fops;
> +	struct file_operations sync_fops;
> +	bool revoked;
> +};
> +
> +static int cdev_sync_open(struct inode *inode, struct file *filp)
> +{
> +	struct cdev *p = inode->i_cdev;
> +	struct cdev_sync_data *sync = p->sync;
> +	const struct file_operations *fops;
> +	int ret;
> +
> +	scoped_cond_guard(rwsem_read_kill, return -ERESTARTSYS, &sync->sem) {
> +		if (sync->revoked)
> +			return -ENODEV;
> +
> +		fops = fops_get(sync->orig_fops);
> +		if (fops->open) {
> +			ret = filp->f_op->open(inode, filp);
> +			if (ret) {
> +				fops_put(fops);
> +				return ret;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void cdev_sync_release(struct inode *inode, struct file *filp)
> +{
> +	struct cdev *p = inode->i_cdev;
> +	struct cdev_sync_data *sync = p->sync;
> +
> +	/*
> +	 * Release can continue to be called after unregister. The driver must
> +	 * only clean up memory.
> +	 */
> +	 if (sync->orig_fops->release)
> +		 sync->orig_fops->release(inode, filp);
> +	fops_put(sync->orig_fops);
> +}
> +
> +/* Must call before chrdev_open can happen */
> +static int cdev_sync_init(struct cdev *p)
> +{
> +	struct cdev_sync_data *sync;
> +
> +	sync = kzalloc(sizeof(*sync), GFP_KERNEL);
> +	if (!sync)
> +		return -ENOMEM;
> +	sync->sync_fops.owner = THIS_MODULE;
> +	sync->sync_fops.open = cdev_sync_open;
> +	sync->sync_fops.release = cdev_sync_release;
> +	// ..
> +	p->is_sync = true;
> +	p->sync = sync;
> +}
> +
> +static int cdev_sync_revoke(struct cdev *p)
> +{
> +	struct cdev_sync_data *sync = p->sync;
> +
> +	guard(rwsem_write)(&sync->sem);
> +	sync->revoked = true;
> +}
> +
>  static DEFINE_SPINLOCK(cdev_lock);
>  
>  static struct kobject *cdev_get(struct cdev *p)
> @@ -405,7 +474,11 @@ static int chrdev_open(struct inode *inode, struct file *filp)
>  		return ret;
>  
>  	ret = -ENXIO;
> -	fops = fops_get(p->ops);
> +	if (p->is_sync)
> +		fops = fops_get(p->ops);
> +	else
> +		fops = fops_get(&p->sync->sync_fops);
> +
>  	if (!fops)
>  		goto out_cdev_put;
>  
> diff --git a/include/linux/cdev.h b/include/linux/cdev.h
> index 0e8cd6293debba..28f0445011df20 100644
> --- a/include/linux/cdev.h
> +++ b/include/linux/cdev.h
> @@ -11,13 +11,19 @@ struct file_operations;
>  struct inode;
>  struct module;
>  
> +struct cdev_sync_data;
> +
>  struct cdev {
>  	struct kobject kobj;
>  	struct module *owner;
> -	const struct file_operations *ops;
> +	union {
> +		const struct file_operations *ops;
> +		struct cdev_sync_data *sync;
> +	};
>  	struct list_head list;
>  	dev_t dev;
>  	unsigned int count;
> +	bool is_sync;
>  } __randomize_layout;
>  
>  void cdev_init(struct cdev *, const struct file_operations *);
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index f1aaf676a874a1..298c7d4d8abb5e 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -253,6 +253,7 @@ extern void up_write(struct rw_semaphore *sem);
>  DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
>  DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
>  DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T), _RET == 0)
> +DEFINE_GUARD_COND(rwsem_read, _kill, down_read_killable(_T), _RET == 0)
>  
>  DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
>  DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))

Realized the approach doesn't work for the issue I'm looking into.

- All misc devices share the same cdev[1].  If misc_deregister() calls
  cdev_sync_revoke(), the misc stop working due to one of the miscdevice
  deregistered.
- The context (struct cdev_sync_data) should be the same lifecycle with
  the opening file (e.g. struct file).  Otherwise, when accessing the
  context in the fops wrappers, it results an UAF.  For example, the
  sturct cdev is likely freed after cdev_sync_revoke().

[2] is a follow-up series of my original approach.

[1] https://elixir.bootlin.com/linux/v6.17/source/drivers/char/misc.c#L299
[2] https://lore.kernel.org/chrome-platform/20251106152712.11850-1-tzungbi@kernel.org

