Return-Path: <linux-kselftest+bounces-45057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 911ECC3E7C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 06:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 874D94E2FF2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 05:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B4624169F;
	Fri,  7 Nov 2025 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxgTDjie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFE1DA60D;
	Fri,  7 Nov 2025 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492079; cv=none; b=Cqjmvpkunl31X6pU6/5f/EZHqvHO18N4+ncB/iizwn/UuULVubxL8TdbP01XjdDMwMcx4pHWTraqi79u+5AYfQEmGDh2kRtIMF7Y6DNu3IJo+NbAc/uO9S/BoK7oCaeJa2DtA+z6oMP3xT4pOVCbKktEqDt2SsB1Mwa2xlsjFqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492079; c=relaxed/simple;
	bh=Mw1hYzJPmBlRa1P9Q6n6jjczl4NnDGxr14+eAsBq9wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuGMh1q8cvcoc6iCzobsGxVoeogRbr4HczVZlHfNHgfeDVAHG/OVKBKaw95HOWlcV8K97B8P5wsi4K2dSN44YxHrTIAO+BobJhEUwzjZRTj2VwD/wOtkv0cPb1eLCGfA00U3aObkuf5NON7GMPiLdKnOpvHiubHlgTrkjdG66Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxgTDjie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A76C116B1;
	Fri,  7 Nov 2025 05:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762492078;
	bh=Mw1hYzJPmBlRa1P9Q6n6jjczl4NnDGxr14+eAsBq9wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxgTDjie/RD0tJnwGg1tf/oiZCNgCBnM5h+8TF2R20VZ3hytBswUTVHddDufT761w
	 hJGHowtzUpBK+CsH1s7gKs61gH3tsxUouBstyPv8e/j2C8ghVNpTccXaBy9vTNP1RF
	 zfcek9YB//SZQYcb0vIZCHaikcQaaAym4Xfs1R5yS4nsMLZgvDnqWIvPeVXLedVM0C
	 K2thDxvOWwxJrSpJf5FPJoKvp09V5jGFnvm9dNjqh//VdQNjzWY+JDii+D5StyS4Vx
	 u3I2xtUOYnt/kVQU02PwkU2zMtbueP4+8KhPwawkqmqU1gDNv2JvsXiNhEfaQn3XJy
	 RK/Eu5bGz0uPw==
Date: Fri, 7 Nov 2025 05:07:54 +0000
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
Subject: Re: [PATCH v6 1/3] revocable: Add fops replacement
Message-ID: <aQ1-qj0ztQ29h-oc@google.com>
References: <20251106152712.11850-1-tzungbi@kernel.org>
 <20251106152712.11850-2-tzungbi@kernel.org>
 <20251106154715.GB1732817@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106154715.GB1732817@nvidia.com>

On Thu, Nov 06, 2025 at 11:47:15AM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 06, 2025 at 11:27:10PM +0800, Tzung-Bi Shih wrote:
> > +/*
> > + * Recover the private_data to its original one.
> > + */
> > +static struct fops_replacement *_recover_private_data(struct file *filp)
> > +{
> > +	struct fops_replacement *fr = filp->private_data;
> > +
> > +	filp->private_data = fr->orig_private_data;
> > +	return fr;
> > +}
> > +
> > +/*
> > + * Replace the private_data to fops_replacement.
> > + */
> > +static void _replace_private_data(struct fops_replacement *fr)
> > +{
> > +	fr->filp->private_data = fr;
> > +}
> 
> This switching of private_data isn't reasonable, it breaks too much
> stuff. I think I showed a better idea in my sketch.

The approach assumes the filp->private_data should be set once by the
filp->f_op->open() if any.  Is it common that the filp->private_data
be updated in other file operations?

> I still think this is a bad use case of revocable, we don't need to
> obfuscate very simple locks in *core* kernel code like this. I'd rather
> see you propose this series without using it.
> 
> > +static int fs_revocable_release(struct inode *inode, struct file *filp)
> > +{
> > +	struct fops_replacement *fr = _recover_private_data(filp);
> > +	int ret = 0;
> > +	void *any;
> > +
> > +	filp->f_op = fr->orig_fops;
> > +
> > +	if (!fr->orig_fops->release)
> > +		goto leave;
> > +
> > +	REVOCABLE_TRY_ACCESS_SCOPED(fr->rev, any) {
> > +		if (!any) {
> > +			ret = -ENODEV;
> > +			goto leave;
> > +		}
> > +
> > +		ret = fr->orig_fops->release(inode, filp);
> > +	}
> 
> This probably doesn't work out, is likely to make a memory leak.
> It will be hard for the owning driver to free its per-file memory
> without access to release.

Ah, I think this reveals a drawback of the approach.
- Without calling ->release(), some memory may leak.
- With calling ->release(), some UAF may happen. 

