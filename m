Return-Path: <linux-kselftest+bounces-42081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74322B929EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 20:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3105B3A7CF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5616C31A07B;
	Mon, 22 Sep 2025 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2WB09Mj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE552EAB64;
	Mon, 22 Sep 2025 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566546; cv=none; b=hn1cTduJ9yNO9MEtK0iBhtTa5YVSb5Vldzen5XDNZp9hIJXRV9zWprAewkC20TNDahUW6HpoSs/PKU1mw/ad3uLtDg/u9gE3/Dd5k6NIJPmz3qhOjp2LQWsSo1Cb0KM2/eW6HOBPsALWRqTJRbJn8L+5ej9eFHZU95rwZyD9Agw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566546; c=relaxed/simple;
	bh=LFi7dYKBKTvG2oV8Z6wbJ4mWYQQ6Q/9z03yXwShvB/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQHCcd5yz4LVJ/vB6UEOuS6YkMpgOGEUDEpRjHMt5wMnhIVDdNbW+R0iZlJIKr3xRRdxJghVdyhZcX/rCcV7DJ/aeWrBBENnXjTgNQW/4i+d/qhP8oxYhJeZr/7iQpy2McmPIEPu3iDgkfGW47LXrZJYTy7Nqr+qE71ancWPqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2WB09Mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67398C4CEF5;
	Mon, 22 Sep 2025 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758566545;
	bh=LFi7dYKBKTvG2oV8Z6wbJ4mWYQQ6Q/9z03yXwShvB/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2WB09MjOIeFjuZ0pkhw8IJQYG/kYamJPVfzRCDirUOKv3JM/v7fetjZrDHw+/9Ee
	 hylyP4D2I/qFtNuT36XjZPf0bBPwX+qu1JyNT3u1eXjGcAngp5jPlka/Oz0qLmG1FX
	 hiejDNRyA9CuThNk6MXI3Tr6hTglDlf2Jg7+4Sn8=
Date: Mon, 22 Sep 2025 20:42:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <2025092228-pope-barge-0aa3@gregkh>
References: <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <20250922151040.GA2546062@nvidia.com>
 <DCZG9N3QIRNP.1HUDPVL61FZVR@kernel.org>
 <20250922174010.GC1391379@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922174010.GC1391379@nvidia.com>

On Mon, Sep 22, 2025 at 02:40:10PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 22, 2025 at 05:55:43PM +0200, Danilo Krummrich wrote:
> > I fully agree with that, in C there is indeed no value of a revocable type when
> > subsystems can guarantee "sane unregistration semantics".
> 
> Indeed, I agree with your message. If I look at the ec_cros presented
> here, there is no reason for any revocable. In fact it already seems
> like an abuse of the idea.
> 
> The cros_ec.c spawns a MFD with a platform_device of "cros-ec-chardev"
> that is alreay properly lifetime controlled - the platform is already
> removed during the remove of the cros_ec.c.
> 
> So, there is no need for a revocable that spans two drivers like this!

It's a very common pattern, you have a struct device, and a userspace
access, and need to "split" them apart, as you say below.  This logic
here handles that pattern.

See the many talks about this in the past at Plumbers and other
conferences, this isn't a new thing, and it isn't quite as simple as I
think you are making it out to be to solve.

> The bug is that cros_ec_chardev.c doesn't implement itself correctly
> and doesn't have a well designed remove() for something that creates a
> char dev. This issue should be entirely handled within
> cros_ec_chardev.c and not leak out to other files.
> 
> 1) Using a miscdevice means loosing out on any refcount managed
> memory. When using a file you need some per-device memory that lives
> for as long as all files are open. So don't use miscdev, the better
> pattern is:
> 
> struct chardev_data {
> 	struct device dev;
> 	struct cdev cdev;

Woah, no, that is totally wrong.

> Now you get to have a struct device linked refcount and a free
> function. The file can savely hold onto a chardev_data for its
> lifetime.

You have 2 different reference counts for the same structure.  A bug
that should never be done (yes, it's done a lot in the kernel, it's
wrong.)

And really, let's not abuse cdev anymore than it currently is please.
There's a reason that miscdevice returns just a pointer.  Right now cdev
can be used in 3-4 different ways, let's not come up with another way to
abuse that api :)

> 2) Add locking so the file can exist after the driver is removed:
> 
> struct chardev_data {
> [..]
> 	struct rw_semaphore sem;
> 	struct cros_ec_dev *ec_dev;
> };
> 
> Refcount the chardev_data::dev in the file operations open/release,
> refer to it via the private_data.
> 
> 3) At the start of every fop take the sem and check the ec_dev:
> 
> ACQUIRE(rwsem_read, ecdev_sem)(&data->sem);
> if (ACQUIRE_ERR(ecdev_sem) || !data->ec_dev)
>    return -ENODEV;
> 
> 4) After unregistering the cdev, but before destroying the device take
> the write side of the rwsem and NULL ec_dev.
> 
> 5) Purge all the devm usage from cros_ec_chardev, the only allocation
> is refcounted instead.
> 
> Simple. No need for any synchronize_srcu() for such a simple
> non-performance oriented driver.

There is no performance issue here, but there is lifetime rule logic
here that I really really do not want to have to "open code" for every
user.  revokable gives this to us in a simple way that we can "know" is
being used correctly.

And again, you can't have a single structure with two reference counts,
that's not allowed :)

> Yes, this can be made better, there is a bit too much boilerplate, but
> revocable is not the way for cros_ec.

I strongly disagree, sorry.

greg k-h

