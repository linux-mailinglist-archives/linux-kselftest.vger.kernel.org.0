Return-Path: <linux-kselftest+bounces-43515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C6BEE846
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 17:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2313A402E
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD92E5405;
	Sun, 19 Oct 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFkeUTdu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E912A1CF;
	Sun, 19 Oct 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886528; cv=none; b=uF99jg5D6geupWRPhQfxb8KNIaLv3Nz39GF+N0+xdCojUJhSjxwT7ZGSbJYhmdyV8B9jZ4hxqwTRKpHcXyGrFyibaiphNKKvrG1IVlGulLRx9J1oomrk6MOPlb5HahK+TU7MgRUJpSUM9WM0lEGmezASET3wfPFZm7MuXRrI+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886528; c=relaxed/simple;
	bh=kTauBeDoTqIQz3NxrorvMMaU0rVxHo/z/FhTS23ebJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mo39N9XBI4ViA2fYLUGCP4y5+JVKnBORZNcsU3XriyGCdyoGiHd/cmgRl1DhR6SZNvWKJ3wJDcOJzAIjoSDVbFUVd1IG5S5GZY1hYAlVPi4vmbBVlPfbpnzETxP4Fkf72BIwCHjTRCln54udfrGFY9RQ+CHugPzucvgSx4RKI4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFkeUTdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF62CC4CEE7;
	Sun, 19 Oct 2025 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760886528;
	bh=kTauBeDoTqIQz3NxrorvMMaU0rVxHo/z/FhTS23ebJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFkeUTduqPWU0avJTtFPkGsRKVFcPOBcbnbKE+M46qxoyD9O5/qKsMT/NBcOoPpsZ
	 u98CZX0J+sOA2zePt6Gf5g9mCcPYeCgUdEiB6l0SX3Xlc5We+6l1FufO1HG5yqNXzX
	 CHD7nGnDM8h4MxvLaU6zzDlddkQ8UX/jTOruRLMoe/u0QMMGSDS0sBA+4O5RnyIOml
	 8Q2QDHKyblrCGUK75aK24+CYQAK0uNA7KhP/WddiNiX/3dxHW6fRJXqePJzs/9Zmvk
	 EJOOLMM7IQYXatPnGTn8CkEmHMxHp7kKlFZ63os1beAAzYD5Xu3X8rf8lLAX61jNDh
	 yRHMGO8wofQpA==
Date: Sun, 19 Oct 2025 23:08:29 +0800
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
Message-ID: <aPT-7TTgW_Xop99j@tzungbi-laptop>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017162116.GA316284@nvidia.com>

On Fri, Oct 17, 2025 at 01:21:16PM -0300, Jason Gunthorpe wrote:
> On Sat, Oct 18, 2025 at 12:07:58AM +0800, Tzung-Bi Shih wrote:
> > > This is already properly lifetime controlled!
> > > 
> > > It *HAS* to be, and even your patches are assuming it by blindly
> > > reaching into the parent's memory!
> > > 
> > > +	misc->rps[0] = ec->ec_dev->revocable_provider;
> > > 
> > > If the parent driver has been racily unbound at this point the
> > > ec->ec_dev is already a UAF!
> > 
> > Not really, it uses the fact that the caller is from probe().  I think the
> > driver can't be unbound when it is still in probe().
> 
> Right, but that's my point you are already relying on driver binding
> lifetime rules to make your access valid. You should continue to rely
> on that and fix the lack of synchronous remove to fix the bug.

I think what you're looking for is something similar to the following
patches.

- Instead of having a real resource to protect with revocable, use the
  subsystem device itself as a virtual resource.  Revoke the virtual
  resource when unregistering the device from the subsystem.

- Exit earlier if the virtual resource is NULL (i.e. the subsystem device
  has been unregistered) in the file operation wrappers.

By doing so, we don't need to provide a misc_deregister_sync() which could
probably maintain a list of opening files in miscdevice and handle with all
opening files when unregistering.  The device unbound is free to go and
doesn't need to wait for closing or interrupting all opening files.


diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 27078541489f..bc4d249c4d0f 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -173,8 +175,12 @@ static int misc_open(struct inode *inode, struct file *file)
         */
        file->private_data = c;
 
-       err = 0;
        replace_fops(file, new_fops);
+
+       err = fs_revocable_replace(c->rp, file);
+       if (err)
+               goto fail;
+
        if (file->f_op->open)
                err = file->f_op->open(inode, file);
 fail:
@@ -234,6 +240,10 @@ int misc_register(struct miscdevice *misc)
                return -EINVAL;
        }
 
+       misc->rp = revocable_provider_alloc(misc);
+       if (!misc->rp)
+               return -ENOMEM;
+
        INIT_LIST_HEAD(&misc->list);
 
        mutex_lock(&misc_mtx);
@@ -291,6 +291,8 @@ EXPORT_SYMBOL(misc_register);

 void misc_deregister(struct miscdevice *misc)
 {
+       revocable_provider_revoke(misc->rp);
+
        mutex_lock(&misc_mtx);
        list_del_init(&misc->list);
        device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));

diff --git a/fs/fs_revocable.c b/fs/fs_revocable.c
new file mode 100644
...
+struct fs_revocable_replacement {
+       struct revocable *rev;
+       const struct file_operations *orig_fops;
+       struct file_operations fops;
+};
+
+static ssize_t fs_revocable_read(struct file *filp, char __user *buffer,
+                                size_t length, loff_t *offset)
+{
+       void *any;
+       struct fs_revocable_replacement *rr = filp->f_rr;
+
+       REVOCABLE_TRY_ACCESS_WITH(rr->rev, any) {
+               if (!any)
+                       return -ENODEV;
+               return rr->orig_fops->read(filp, buffer, length, offset);
+       }
+}
...
+int fs_revocable_replace(struct revocable_provider *rp, struct file *filp)
+{
+       struct fs_revocable_replacement *rr;
+
+       rr = kzalloc(sizeof(*rr), GFP_KERNEL);
+       if (!rr)
+               return -ENOMEM;
+
+       rr->rev = revocable_alloc(rp);
+       if (!rr->rev)
+               goto free_rr;
+
+       rr->orig_fops = filp->f_op;
+       memcpy(&rr->fops, filp->f_op, sizeof(rr->fops));
+       rr->fops.release = fs_revocable_release;
+
+       if (rr->fops.read)
+               rr->fops.read = fs_revocable_read;
+       if (rr->fops.poll)
+               rr->fops.poll = fs_revocable_poll;
+       if (rr->fops.unlocked_ioctl)
+               rr->fops.unlocked_ioctl = fs_revocable_unlocked_ioctl;
+
+       filp->f_rr = rr;
+       filp->f_op = &rr->fops;
+       return 0;
+free_rr:
+       kfree(rr);
+       return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(fs_revocable_replace);

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a6de8d93838d..163496a5df6c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1066,6 +1066,7 @@ struct file {
                freeptr_t               f_freeptr;
        };
        /* --- cacheline 3 boundary (192 bytes) --- */
+       struct fs_revocable_replacement *f_rr;
 } __randomize_layout
   __attribute__((aligned(4))); /* lest something weird decides that 2 is OK */

diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index aca911687bd5..c98b97f84c07 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -94,6 +94,7 @@ struct miscdevice  {
        const struct attribute_group **groups;
        const char *nodename;
        umode_t mode;
+       struct revocable_provider *rp;
 };

