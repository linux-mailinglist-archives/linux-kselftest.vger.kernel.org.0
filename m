Return-Path: <linux-kselftest+bounces-43390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD06BEA962
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07E265836D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765062550CC;
	Fri, 17 Oct 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5w/i+f9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FAC251795;
	Fri, 17 Oct 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717284; cv=none; b=H7/VwMU+lQlNhZFjNjKkYTfO/aYPvt5MailT3bCtN60V5bGPX+KJ1yMmvHLRhRXvTfsFyG9yOAnuT2piaX+C4Ts0ZGtDEAQbnXFTM1FtO/wfx5viHqYZP0pNUtUapSXSVlXViTCNOFcP18FrGyZY90lipp8lXZMh4d2OD+qYbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717284; c=relaxed/simple;
	bh=HqjY6m4D2rtLDZQzYhepgOuofMmASG3H7EfDU2kJMB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqdorGffqbZYXX9CQEIO6KeupSzgy0Ud2eNodOncklAPuqeRxkpLlmtDf3rd/fQyrvEVOG5Zii7C5gsRuOlmSrSTAvD3vzdJ19aOw3C17JbG+3TOX3ZmMsRRio710pZd/6bCXR4x/TIr1H8geRQqDgwGJYn1NgVk8FGe8JxSRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5w/i+f9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2852C4CEE7;
	Fri, 17 Oct 2025 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760717283;
	bh=HqjY6m4D2rtLDZQzYhepgOuofMmASG3H7EfDU2kJMB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5w/i+f9TZp7C+F8S8KSixlOYUFd6GgOHtP7QKqP24S2FV1WdkmTi7cqVVCjbcj7h
	 NgIjEGH4azEXnCHiH3N/BXph4TBu+en56bkX86o71rWjYqSggMTtX+eSMFfKgmVRgY
	 7oe/3t1bxPW0/ut7mJcOa9bkTMylXpIuCuzv0hk7KS/ukI68um0W8mAeMWegEgCAWF
	 hh204sIm0qnVOVkpyyFLgY50C4LDXnFt2XigIaaXGCC4rlhEZm/zfWV9vsfJclLaHJ
	 x6tpoASNLn3MEEn2kJeoQy83ZoNE/QVuKOTFJVH3ukTZPoefZVeEcpj9kTrMVaVyf5
	 uaUMYUFD0D9pw==
Date: Sat, 18 Oct 2025 00:07:58 +0800
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
Message-ID: <aPJp3hP44n96Rug9@tzungbi-laptop>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017134916.GK3901471@nvidia.com>

On Fri, Oct 17, 2025 at 10:49:16AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 02:36:58AM +0000, Tzung-Bi Shih wrote:
> > Imagining the following example:
> > 
> > /* res1 and res2 are provided by hot-pluggable devices. */
> > struct filp_priv {
> >     void *res1;
> >     void *res2;
> > };
> > 
> > /* In .open() fops */
> > priv = kzalloc(sizeof(struct filp_priv), ...);
> > priv->res1 = ...;
> > priv->res2 = ...;
> > filp->private_data = priv;
> > 
> > /* In .read() fops */
> > priv = filp->private_data;
> > priv->res1    // could result UAF if the device has gone
> > priv->res2    // could result UAF if the device has gone
> > 
> > 
> > How does the bool * work for the example?
> 
> You are thinking about it completely wrong, you are trying to keep the
> driver running conccurrently after it's remove returns - but that
> isn't how Linux drivers are designed.
> 
> We have a whole family of synchronous fencing APIs that drivers call
> in their remove() callback to shut down their concurrency. Think of
> things like free_irq(), cancel_work_sync(), timer_shutdown_sync(),
> sysfs_remove_files(). All of these guarentee the concurrent callbacks
> are fenced before returning.
> 
> The only issue with cros_ec is this:
> 
> static void cros_ec_chardev_remove(struct platform_device *pdev)
> {
>         struct miscdevice *misc = dev_get_drvdata(&pdev->dev);
> 
>         misc_deregister(misc);
> }
> 
> It doesn't fence the cdevs! Misc is a hard API to use because it
> doesn't have a misc_deregister_sync() variation!
> 
> Dan/Laurent's point and proposal was that mis_deregister() does not
> work like this! It is an anomaly that driver authors typically over
> look.
> 
> So the proposal was to add some way to get a:
>   misc_deregister_sync()
> 
> What gives the fence. Under your proposal it would lock the SRCU and
> change the bool. After it returns no cdev related threads are running
> in fops touching res1/res2. I think your proposal to replace the fops
> and that related machinery is smart and has a chance to succeed.
> 
> From this perspective your example is malformed. Resources should not
> become revoked concurrently *while a driver is bound*. The driver
> should be unbound, call misc_deregister_sync()/etc, and return from
> remove() guaranteeing it no longer touches any resources.

Imagining:
- Driver X provides the res1.
- Driver Y provides the res2.
- Driver Z provides the chardev /dev/zzz.  The file operations use res1
  and res2.
- A userspace program opened /dev/zzz.

In the approach, what is .remove() of driver X supposed to do when driver X
is unbinding (e.g. due to device unplug)?

If it ends up call misc_deregister_sync(), should the synchronous function
wait for the userspace program to close the FD?


The design behind revocable: the driver X waits via synchronize_srcu(), and
then it is free to go.  The subsequent accesses to res1 will get NULL, and
should fail gracefully.

> For this specific cros_ec driver it's "res" is this:
> 
>         struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>         struct cros_ec_platform *ec_platform = dev_get_platdata(ec->dev);

In fact, no, the "res" we are concerning is struct cros_ec_device, e.g. [1].
(I knew the naming cros_ec_device vs. cros_ec_dev is somehow easy to confuse.)

[1] https://elixir.bootlin.com/linux/v6.17/source/drivers/platform/chrome/cros_ec_spi.c#L752

> This is already properly lifetime controlled!
> 
> It *HAS* to be, and even your patches are assuming it by blindly
> reaching into the parent's memory!
> 
> +	misc->rps[0] = ec->ec_dev->revocable_provider;
> 
> If the parent driver has been racily unbound at this point the
> ec->ec_dev is already a UAF!

Not really, it uses the fact that the caller is from probe().  I think the
driver can't be unbound when it is still in probe().
(Probe protocol device -> register the MFD device ->
 add cros-ec-chardev device and probe.)

> For cros it is safe because the cros_ec driver is a child of a MFD and
> the MFD logic ensures that the children are unbound as part of
> destroying the parent. So 'ec' is guarenteed valid from probe() to
> remove() return.
> 
> IHMO auto-revoke is a terrible idea, if you go down that path then why
> is misc special? You need to auto-revoke irqs, timers, work queues,
> etc too? That's a mess.

To be clear, I'm using misc as an example which is also the real crash we
observed.  If the file operations use other resources provided by a
hot-pluggable device, it'd need to use revocable APIs to prevent the UAFs.

