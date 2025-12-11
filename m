Return-Path: <linux-kselftest+bounces-47376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4CDCB49EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 04:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B83300FE31
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 03:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C904B23C8CD;
	Thu, 11 Dec 2025 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BpphSAq6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D722F388;
	Thu, 11 Dec 2025 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765423416; cv=none; b=DdUba6bq4N3pWty14R9Y4XaTy+zV13WtGe+7/wP4NStq261bsW1ELwqaNAlArJYFZxxaStEyI/ZZt1w6gwPxJct7DYdTXb8j+bFTtZyePV9dD6bwmCYM5q+WUTjgGRFzq50nUJLWq/liPD+pCGWsnuxIFmVuYtcCQ24gil+s8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765423416; c=relaxed/simple;
	bh=cxD3Wr/Ig8GN/DsuCXoKzNk347PDwsV4kSz6ulTT+40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3tIqx0/Y0pi36BNUPBWJ+RwjR/q0JxVgnmWMehUzkOjZ5Yd2CXp2G2UUW0vXg0UPl+iqaGdqyYH24lcuxD83PYGBBegSResOtwKj5UyHos5LAn7srEpykUFXyDGmNjPFxMY/Nuh3mSyHLTe7QPXKighGj/GIzqgnzMVHy6cZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BpphSAq6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (fs98a57d9d.tkyc007.ap.nuro.jp [152.165.125.157])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 1E3EE667;
	Thu, 11 Dec 2025 04:23:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1765423404;
	bh=cxD3Wr/Ig8GN/DsuCXoKzNk347PDwsV4kSz6ulTT+40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpphSAq6iftkqPdhbFOdow0SCP+IS+RLblRTJAlpxnkFqE8hFQcEtin7Osvda2fv5
	 6+6qsxI8XkY05NyR6HWqiLQC6XrUmBGyNFiiIPgZnj1EblTci3BWmJfh66fH7D0UDb
	 13LW7K3yqyTLErnME6NyO186FEPcSFKmiMB1yXrw=
Date: Thu, 11 Dec 2025 12:23:06 +0900
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <20251211032306.GO28860@pendragon.ideasonboard.com>
References: <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
 <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025102321-struggle-fraying-52ff@gregkh>

On Thu, Oct 23, 2025 at 05:04:57PM +0200, Greg KH wrote:
> On Thu, Oct 23, 2025 at 11:51:31AM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 23, 2025 at 10:22:01PM +0800, Tzung-Bi Shih wrote:
> > 
> > > I was misunderstanding about the "sync" we were discussing for
> > > misc_deregister_sync().  The "sync", is analogous to synchronize_srcu()
> > > of revocable_provider_revoke() in the revocable version [1], doesn't wait
> > > for closing all opened files.
> > 
> > Yes, and my remark is we don't need to obfuscate simple locks in core
> > kernel code.
> 
> {sigh}
> 
> Yes, that's not the goal here at all.
> 
> I've refrained from jumping in as I think we are thinking of different
> stuff here, probably talking past each other in places.
> 
> The original goal of having "revocable" is still needed, despite you
> feeling that cdev can live without it (I strongly disagree with that,
> and the v4l, gpio, i2c, and other subsystem developers have feelings
> along those lines as backed up by the many talks over the years about
> this.)

Replying late to this thread, I don't think this is right for V4L2. When
it comes to solving the .remove() vs. userspace race, I think the right
solution is at the cdev level. We could also implement it exactly the
same way in the V4L2 core, but that would be a shame as other subsystems
would need to replicate the same. There are existing implementations,
they're easy to use in drivers (if implemented in cdev with the little
amount of required driver-logic implemented in the V4L2 core, it would
be mostly transparent for drivers), easy to wrap your head around (no
obscure lifetime magic), and they work.

Where I believe a revocable infrastructure could be useful is for
solving the .remove() vs. *kernel usage* race, which is something GPIO
likely cares about strongly.

> The use of it in the Rust code already is kind of proof of this, it
> enables driver authors to not have to worry about a ton of real-world
> issues they would have to otherwise.  Which is why I suggested copying
> that pattern into C to help us out here.
> 
> Anyway...
> 
> I've been traveling a ton, and it's not going to let up soon, but I'll
> try to dig into this more later next week, or on the next 12+ hour
> flight that I'll be just after that, to give a more detailed review and
> response, sorry I've not been able to do so yet.

-- 
Regards,

Laurent Pinchart

