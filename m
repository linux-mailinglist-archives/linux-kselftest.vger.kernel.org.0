Return-Path: <linux-kselftest+bounces-47499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C69BCCB84B9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 09:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C37FA301F5D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 08:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4112D47E1;
	Fri, 12 Dec 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+J2Rgc/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E013C1F8AC8;
	Fri, 12 Dec 2025 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765528372; cv=none; b=EeX/rvrZr9yRxzuzaaIRRQ9kvcLzKupXE93lwhEfkr8oh2WmAM5ur4HGriEMqKzAa2vZdMlV3iDS/DLQHrTaERUyJNszkrpRPcItI2P6zpim9A1KymW4BlM3N+94SYTnvZY1SZSrx3TkaziyCMWykeKZzBari1WtsFcoD00pwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765528372; c=relaxed/simple;
	bh=SjBoF0HIch0XftTYs0vg5B8YNbR6ts9W+wUQ5MqOR1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os/GNW1AxYOp/asdqqADnqG7AKKw2Xb0q9REfxkGkNyozUMfTN5MBYEPUxe78EiKivLjupThPfJwcAs1BDLeS8NRokCg5k/ojMgoRz95sqrc3wwZOnffLgom8+dN0Kg+58MXlmL1zZz2lMOrIdbsGFAmTVKm2cSmbwY5Qij5lek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+J2Rgc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E071C4CEF1;
	Fri, 12 Dec 2025 08:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765528371;
	bh=SjBoF0HIch0XftTYs0vg5B8YNbR6ts9W+wUQ5MqOR1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+J2Rgc/LbZvf9enzhCCutocoEdO4ih1ULjjE2eAAcUZH+pHeV6Np3mbwlV4MVsz8
	 0zKEZrzUl5GcMbip+IsmT5r51TydxMYoSULOj6WNoNiF5USR91y3tZfIP6CVSEhZvj
	 6tpvrANhD1qRFDOm4NV2RfDp74C1i3xUpTXmlabMfpl1EbNqzx2uJAAGp/MvW45TYf
	 OWY/mYAqxd2EcTiksbvz0zVg7qt0jhom/iAEtyjghsOJZleRh0PE4XflVVIpmrQujU
	 G4CHPrgAXn+W6sfTII3S+nCT8dlXz3Y9DbzOnwVHVKTd2ExvkvvtktVc/92O+uAp7t
	 ZjaqPrWAEE8CA==
Date: Fri, 12 Dec 2025 08:32:46 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <aTvTLpFmyVxanvYC@google.com>
References: <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
 <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
 <20251211032306.GO28860@pendragon.ideasonboard.com>
 <aTo-xErTTiJcribR@shikoro>
 <20251211080517.GA28411@pendragon.ideasonboard.com>
 <aTqCqab1pGB9LNZy@shikoro>
 <20251211134306.GC28411@pendragon.ideasonboard.com>
 <aTrZMJ8R6zybFNHR@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTrZMJ8R6zybFNHR@google.com>

On Thu, Dec 11, 2025 at 02:46:08PM +0000, Tzung-Bi Shih wrote:
> On Thu, Dec 11, 2025 at 10:43:06PM +0900, Laurent Pinchart wrote:
> > On Thu, Dec 11, 2025 at 05:36:57PM +0900, Wolfram Sang wrote:
> > > 
> > > > > Isn't there even prototype code from Dan Williams?
> > > > > 
> > > > > "[PATCH 1/3] cdev: Finish the cdev api with queued mode support"
> > > > > 
> > > > > https://lkml.org/lkml/2021/1/20/997
> > > > 
> > > > I mentioned that in my LPC talk in 2022 :-) I think we should merge that
> > > > (or a rebased, possibly improved version of it). I've meant to try
> > > > plumbing that series in V4L2 but couldn't find the time so far.
> > > 
> > > Yes, you mentioned it in 2022 but maybe not everyone in this thread is
> > > right now aware of it ;) The patch above got changes requested. I talked
> > > to Dan very briefly about it at Maintainers Summit 2023 and he was also
> > > open (back then) to pick it up again.
> > 
> > After discussing with Tzung-Bi today after his presentation (thank you
> > Tzung-Bi for your time, it helped me understand the problem you're
> > facing better), I wonder if this series is fixing the issue in the right
> > place.
> 
> Thank you for your time too for providing me some more context.
> 
> > At the core of the problem is a devm_kzalloc() call to allocate
> > driver-specific data. That data structure is then referenced from a
> > cdev, which can dereference is after it gets freed. It seems that
> > reference-counting the data structure instead of using devm_kzalloc()
> > could be a better solution.
> 
> After discussing with you, I recalled this was one of my previous attempts.
> See the series [1] and Greg's feedback [2].
> 
> I want to provide some more context about the cdev level solution.  I failed
> to do so for misc device [3] mainly because all misc devices share a same
> cdev [4].  If one of the misc device drivers "revoke" the cdev, all other
> drivers stop working.
> 
> I'm not saying we shouldn't seek for cdev level solution.  But at least it
> doesn't work for misc device.  Still need some other ways for misc devices.
> 
> [1] https://lore.kernel.org/chrome-platform/20250721044456.2736300-8-tzungbi@kernel.org/
> [2] https://lore.kernel.org/chrome-platform/2025072114-unifier-screen-1594@gregkh/
> [3] https://lore.kernel.org/chrome-platform/aQ1xfHuyg1y8eJQ_@google.com/
> [4] https://elixir.bootlin.com/linux/v6.17/source/drivers/char/misc.c#L299

Continuing the context, the subsystem level solution for misc device without
revocable could be more or less like the following patch.  Observed 2 main
issues of it:

1. Because it tries to synchronize the misc device and open files, it has a
   big lock between them.  misc_deregister() needs to wait for all open files.
   I think this is a common issue shared by "replacing file operations"
   approaches.  All file operations are considered as critical sections.

2. It doesn't stop existing open files.  UAF still happens when the dangling
   FD tries to access the miscdevice (which should have been freed).

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 726516fb0a3b..0ce415da10c2 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -115,6 +116,89 @@ static const struct seq_operations misc_seq_ops = {
 };
 #endif

+static struct miscdevice *find_miscdevice(int minor)
+{
+	struct miscdevice *c;
+
+	list_for_each_entry(c, &misc_list, list)
+		if (c->minor == minor)
+			return c;
+	return NULL;
+}
+
+static __poll_t misc_some_poll(struct file *filp, poll_table *wait)
+{
+	struct miscdevice *c;
+
+	c = find_miscdevice(iminor(filp->f_inode));
+	if (!c)
+		return -ENODEV;
+	if (!c->fops->poll)
+		return 0;
+
+	guard(mutex)(&c->some_lock);
+	if (!c->registered)
+		return -ENODEV;
+	return c->fops->poll(filp, wait);
+}
+
+static const struct file_operations misc_some_fops = {
+	.poll = misc_some_poll,
+	.read = misc_some_read,
+	.unlocked_ioctl = misc_some_ioctl,
+	.release = misc_some_release,
+};

@@ -161,6 +245,7 @@ static int misc_open(struct inode *inode, struct file *file)
 	replace_fops(file, new_fops);
 	if (file->f_op->open)
 		err = file->f_op->open(inode, file);
+	file->f_op = &misc_some_fops;
 fail:
 	mutex_unlock(&misc_mtx);
 	return err;
@@ -262,6 +347,8 @@ int misc_register(struct miscdevice *misc)
 		goto out;
 	}
 
+	mutex_init(&misc->some_lock);
+	misc->registered = true;
 	/*
 	 * Add it to the front, so that later devices can "override"
 	 * earlier defaults
@@ -283,6 +370,9 @@ EXPORT_SYMBOL(misc_register);
 
 void misc_deregister(struct miscdevice *misc)
 {
+	scoped_guard(mutex, &misc->some_lock)
+		misc->registered = false;
+
 	mutex_lock(&misc_mtx);
 	list_del_init(&misc->list);
 	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));

diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 7d0aa718499c..3b42cf273f97 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -92,6 +92,8 @@ struct miscdevice {
 	const struct attribute_group **groups;
 	const char *nodename;
 	umode_t mode;
+	struct mutex some_lock;
+	bool registered;
 };

