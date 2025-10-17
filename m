Return-Path: <linux-kselftest+bounces-43357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B3ABE61D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 04:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35B4587CFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 02:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91D8245012;
	Fri, 17 Oct 2025 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxWtfhNi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84798190685;
	Fri, 17 Oct 2025 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760668623; cv=none; b=ZOPoo5OFAPXfigDFfZbgjO5Dep16cQjRJ6xeroP93otYvWzWaKo0bqjPVsJpTBpo78Fj7GVfrguMI2pxdW34YNeWUNjdrJlF25l82lgqmDwR0UdDHtO9ufk+P5oRiXoFKeC7c1QtS+RmY7tvn1riopQ+xnjgdw/L125mlAspmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760668623; c=relaxed/simple;
	bh=DATUY9p99XVeI0BI2gcQESXfSCBuCovi+BbE4ynEqb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuGLfwcHDOq5mqBsbAzYhJ0xuCBhINEw3HAvx1yuJ04IB4Xa9xUGA62mP3TCO1IHmJQa3+cpJBzTnucosPoRv0gx19WuN/Rfvz0lsbrxK55rQG48e1XtaMLN9LwDYiHfG8dXQ2yL549jR6Jr53ULxkTx+BmSE2bl/XAwiBpLh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxWtfhNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1622C4CEF1;
	Fri, 17 Oct 2025 02:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760668623;
	bh=DATUY9p99XVeI0BI2gcQESXfSCBuCovi+BbE4ynEqb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxWtfhNi+5ciVzN2YbW2D4GkE7V6QpVMIZrrA7xbZKea77mapv5SI67iL/K8JrqIo
	 G5Rl1FnSEMTpnr5DW64y5XUagqZbckOsL36cQajuNNRGlemencwA/kfXrAyFHN1pLv
	 p23EyhIbaZ0G84Lj6BEelGGC+4CcVXmktOQL2d9DYHYN0yLh+eqhFww2oAu6Q2hHC3
	 iQdpwBSNOJLJawjaOGJT3QFKWfD4tK6CvRBetS1x2RR4/5Plwxs5vmsJ2NmxT/Slp1
	 5qpVnl0gNvNgQItGMQcfKVDhSKpS3Lj0lPMUnvaXbIS+w72HuzCyfsXqW6pkGe80zI
	 ZV8czjKVP+jQA==
Date: Fri, 17 Oct 2025 02:36:58 +0000
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
Message-ID: <aPGryj-V5PQZRtoI@google.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016123149.GA88213@nvidia.com>

On Thu, Oct 16, 2025 at 09:31:49AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 16, 2025 at 05:42:02AM +0000, Tzung-Bi Shih wrote:
> > Introduce fs_revocable_replace() to simplify the use of the revocable
> > API with file_operations.
> > 
> > The function, should be called from a driver's ->open(), replaces the
> > fops with a wrapper that automatically handles the `try_access` and
> > `withdraw_access`.
> > 
> > When the file is closed, the wrapper's ->release() restores the original
> > fops and cleanups.  This centralizes the revocable logic, making drivers
> > cleaner and easier to maintain.
> > 
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > ---
> > PoC patch.
> > 
> > Known issues:
> > - All file operations call revocable_try_access() for guaranteeing the
> >   resource even if the resource may be unused in the fops.
> 
> Why is this so complicated??
> 
> You already added a per-flip struct:
> 
> > +struct fs_revocable_replacement {
> > +	const struct fs_revocable_operations *frops;
> > +	const struct file_operations *orig_fops;
> > +	struct file_operations fops;
> > +	struct revocable **revs;
> > +	size_t num_revs;
> > +};
> 
> Why does it need so much junk in it?
> 
> struct fs_revocable_replacement {
>    struct srcu_struct srcu;
>    bool *alive;
> };
> 
> That's it. When the caller sets this up it provides a bool * pointer
> from it's own private struct that is kept krefcounted to life cycle of
> the struct file.
> 
> Then the ops wrapers are a simple thing - generate them with a macro:
> 
> srcu_read_lock(&f_rr->srcu);
> if (*f_rr_>alive) 
>    ret = f_rr->orig_fops->XX(...)
> else
>    ret = -ENODEV;
> srcu_read_unlock(&f_rr->srcu);
> return ret;
> 
> No need for all this revokable maze to do somethinig so simple.

Imagining the following example:

/* res1 and res2 are provided by hot-pluggable devices. */
struct filp_priv {
    void *res1;
    void *res2;
};

/* In .open() fops */
priv = kzalloc(sizeof(struct filp_priv), ...);
priv->res1 = ...;
priv->res2 = ...;
filp->private_data = priv;

/* In .read() fops */
priv = filp->private_data;
priv->res1    // could result UAF if the device has gone
priv->res2    // could result UAF if the device has gone


How does the bool * work for the example?

