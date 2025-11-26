Return-Path: <linux-kselftest+bounces-46471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98804C88090
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 05:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578BF3A3AE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 04:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD993126DA;
	Wed, 26 Nov 2025 04:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSHAQgiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF53126CA;
	Wed, 26 Nov 2025 04:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764130595; cv=none; b=ubskUhdRUoZxZ6SU06gETDKINRcqeDmewU0ZT54Zvz7R03avVQoniiraExdP2bNccTIJ+t/EHM5Bao5X29FDQBeKY4i/Py3uBkW9pvL4MsG6i1IN4bMehV7Ky+7hu9RFr5lQZYJr+JO4/5iPvQM8UVx0Vi+lsvakwQwZ5TNPnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764130595; c=relaxed/simple;
	bh=tHKJTDPaEVY1RnoAUeQZClBDmfEhZk7dkPVUKHhqsic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc2mEGuZzTaHVBWwMb5Rl8E6kQRqn3WSFnx4bk3EWBSoh+TqQ1OoqyG0n7x8SQWZm75W4A5aTwm7NjpNBis07onyhnAGa5wPLs7El9Db13bglNmtIKrk5jMLWHwNUdYu/ilPSt7G07Z0BOBewrdVyEFJ1try01HNrS/DIKlM+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSHAQgiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03744C19422;
	Wed, 26 Nov 2025 04:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764130594;
	bh=tHKJTDPaEVY1RnoAUeQZClBDmfEhZk7dkPVUKHhqsic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSHAQgiI2H9QWuTYePk5RCkBo+62togpVdnFP+cQnCe56gfweMa0kgBZJr8YeZ5XZ
	 ESKHCYohOSbv4SjP7zj+QfpFekOedZRq1/7/Ca4TPr72rIVggAOW8baF9w/uIIJK+H
	 cg9E/JqaRvJ+KxCQ06pwJwPHH3w9F9T/6uasI0n8MGa6Dqwc6pAvT7GzJa2PHmiy/v
	 3ygjQT0UsYFrnp5z/m7eL2cgvhaT6JzU2YmIRyZKE3sbzLxn03vESMxayJz2vol1+x
	 1OHTNVw3nAVU4/Sj6x18Hy5TZ3jsLumHgxNCHmlyR3kNz0gLIZbHPXUk/dtWkpyEZp
	 fjBfhTLkYLg7w==
Date: Wed, 26 Nov 2025 04:16:29 +0000
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
Subject: Re: [PATCH v6 2/2] platform/chrome: cros_ec_chardev: Consume
 cros_ec_device via revocable
Message-ID: <aSZ_HXjTVbf1HKWr@google.com>
References: <20251106152602.11814-1-tzungbi@kernel.org>
 <20251106152602.11814-3-tzungbi@kernel.org>
 <20251106155951.GC1732817@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106155951.GC1732817@nvidia.com>

On Thu, Nov 06, 2025 at 11:59:51AM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 06, 2025 at 11:26:02PM +0800, Tzung-Bi Shih wrote:
> > @@ -166,7 +181,12 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
> >  	if (!priv)
> >  		return -ENOMEM;
> >  
> > -	priv->ec_dev = ec_dev;
> > +	priv->ec_dev_rev = revocable_alloc(ec_dev->revocable_provider);
> > +	if (!priv->ec_dev_rev) {
> > +		ret = -ENOMEM;
> > +		goto free_priv;
> > +	}
> 
> The lifecyle of ec_dev->ec_dev->revocable_provider memory is
> controlled by dev:
> 
> +       ec_dev->revocable_provider = devm_revocable_provider_alloc(dev, ec_dev);
> 
> Under the lifecycle of some other driver.
> 
> The above only works because misc calls open under the misc_mtx so it
> open has "sync" behavior during misc_unregister, and other rules

My understanding is that the file is available to be opened if and only if
the miscdevice is registered.  Are there any other exceptions or scenarios
I might be unaware of?

> ensure that ec_dev is valid during the full lifecycle of this driver.

To clarify, ec_dev is only required to be valid during the .open() call
itself, not for the entire lifecycle of the driver.  Since ec_dev can
become invalid at any other time, the driver uses ec_dev_rev to ensure
safe access.

> So, I think this cross-driver design an abusive use of the revocable
> idea.
> 
> It should not be allocated by the parent driver, it should be fully
> contained to this driver alone and used only to synchronize the
> fops. This would make it clear that the ec_dev pointer must be valid
  ^^^^
ec_dev_rev serves this purpose, not revocable_provider.

> during the *entire* lifecycle of this driver.
> 
> What you have here by putting the providing in another driver is too
> magic and obfuscates what the actual lifetime rules are while
> providing a giant foot gun for someone to think that just because it
> is marked revocable it is fully safe to touch revocable_provider at
> any time.
> 
> Broadly I think embedding a revocable in the memory that it is trying
> to protect is probably an anti-pattern as you must somehow already
> have a valid pointer to thing to get the revocable in the first place.
> This severely muddies the whole notion of when it can actually be
> revoked nor not.

ec_dev->revocable_provider should only be accessed directly within the
.open(), as ec_dev is guaranteed to be valid there.  For all other cases,
it uses ec_dev_rev and checks the validity with revocable_try_access()
to determine if ec_dev has been revoked.

