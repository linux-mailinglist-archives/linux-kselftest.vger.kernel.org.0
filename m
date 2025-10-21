Return-Path: <linux-kselftest+bounces-43643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EA0BF49A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 06:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5903A93F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 04:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187620966B;
	Tue, 21 Oct 2025 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ure6nvZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C28460;
	Tue, 21 Oct 2025 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761022207; cv=none; b=R90RsHnPsEKwnefi8LVtx8ItjC8znu26fNLKle8VutVB694zaSwygAaFSD9V4NLgbOzNJJlML0GfDgKW3+w0lAn6agpQEXXxzhc2+eKH6k5CtWNKd/kty+pLCTbodUJXbxbTO3aSj1tYFuya/lzeJW8jv/no/L7MuQA1LIerCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761022207; c=relaxed/simple;
	bh=QGD45ga5zWdLTFV/K5GdIbJuErXC7zGRF80m5HoRfcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJe9cmAT4p7VUjIE7ViFBqTPMbU9qjrdEte4H0luB6lZAJQ53lEtHt6LaLIHFPWEEiv9mioekCjvqstlMJWVj6bFoNHcpMCUW7vJPg9BZ5AENnFqs7SxlrO1+m7LmN660tueOUTlwP95RO5XglNe+bO/bA1VWpaFZtLVGSMpU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ure6nvZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4AEC4CEF1;
	Tue, 21 Oct 2025 04:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761022204;
	bh=QGD45ga5zWdLTFV/K5GdIbJuErXC7zGRF80m5HoRfcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ure6nvZCgjKTFB34N3cCy9GcbSh3diCqfJgHQ7EbhyZgKv2YKLD+/hBwu00yHGWLE
	 /9fiGpYQRNIqGeViWBuNEwXa/E0h60bRIpP2TOdADQd/jVbqXfMDNqMEVz4RZEOD6T
	 Ct6tXaXL2hG+5Sa9WeVD7GGZpQF4/mv3gjwEZxv7jTmNegreiYvX6667D48Jlcx603
	 +OZuVIn5gCntw56FXnA/G6lwHOGF/kf71T+NkVVNIOrgE7nxg+6/1tsGBRbQ1BcLX0
	 /qG27Sn5sP1JuSC7rk4ccOZdMcCrPX1aQnO6wrZ7Tnca2u1TBGLx4EuflYd03RU7WH
	 UMJE3H6PwFbEA==
Date: Tue, 21 Oct 2025 04:49:59 +0000
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
Message-ID: <aPcQ99MZse5zmv3o@google.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com>
 <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020115734.GH316284@nvidia.com>

On Mon, Oct 20, 2025 at 08:57:34AM -0300, Jason Gunthorpe wrote:
> On Sun, Oct 19, 2025 at 11:08:29PM +0800, Tzung-Bi Shih wrote:
> > On Fri, Oct 17, 2025 at 01:21:16PM -0300, Jason Gunthorpe wrote:
> > > On Sat, Oct 18, 2025 at 12:07:58AM +0800, Tzung-Bi Shih wrote:
> > > > > This is already properly lifetime controlled!
> > > > > 
> > > > > It *HAS* to be, and even your patches are assuming it by blindly
> > > > > reaching into the parent's memory!
> > > > > 
> > > > > +	misc->rps[0] = ec->ec_dev->revocable_provider;
> > > > > 
> > > > > If the parent driver has been racily unbound at this point the
> > > > > ec->ec_dev is already a UAF!
> > > > 
> > > > Not really, it uses the fact that the caller is from probe().  I think the
> > > > driver can't be unbound when it is still in probe().
> > > 
> > > Right, but that's my point you are already relying on driver binding
> > > lifetime rules to make your access valid. You should continue to rely
> > > on that and fix the lack of synchronous remove to fix the bug.
> > 
> > I think what you're looking for is something similar to the following
> > patches.
> > 
> > - Instead of having a real resource to protect with revocable, use the
> >   subsystem device itself as a virtual resource.  Revoke the virtual
> >   resource when unregistering the device from the subsystem.
> > 
> > - Exit earlier if the virtual resource is NULL (i.e. the subsystem device
> >   has been unregistered) in the file operation wrappers.
> 
> Sure
>  
> > By doing so, we don't need to provide a misc_deregister_sync() which could
> > probably maintain a list of opening files in miscdevice and handle with all
> > opening files when unregistering.  
> 
> I don't think we want to change the default behavior of
> misc_deregister.. Maybe if it was a mutex not srcu it would be OK, but
> srcu you are looking at delaying driver removal by seconds
> potentially.
> 
> > @@ -234,6 +240,10 @@ int misc_register(struct miscdevice *misc)
> >                 return -EINVAL;
> >         }
> >  
> > +       misc->rp = revocable_provider_alloc(misc);
> > +       if (!misc->rp)
> > +               return -ENOMEM;
> 
> Just get rid of all this revocable stuff, all this needs is a scru or
> a mutex, none of this obfuscation around a simple lock is helpful in
> core kernel code.

I didn't get the idea.  With a mutex, how to handle the opening files?

Are they something like: (?)
- Maintain a list for opening files in both .open() and .release().
- In misc_deregister_sync(), traverse the list, do something (what?), and
  wait for the userspace programs close the files.

> > @@ -1066,6 +1066,7 @@ struct file {
> >                 freeptr_t               f_freeptr;
> >         };
> >         /* --- cacheline 3 boundary (192 bytes) --- */
> > +       struct fs_revocable_replacement *f_rr;
> >  } __randomize_layout
> 
> The thing that will likely attract objections is this. It is probably
> a good idea to try to remove it.
> 
> For simple misc users the inode->i_cdev will always be valid and you
> can reach the struct misc_dev/cdev from there in all the calls.
> 
> More complex cdev users replace the inode so that wouldn't work
> universally but it is good enough to get started at least.

The context is meant to be the same lifecycle with file opens/releases but
not the miscdevice.  I think the mutex vs. revocable stuff is the more
fundamental issue, we can focus on that first.

