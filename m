Return-Path: <linux-kselftest+bounces-41398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C3AB55260
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F9B1C861D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A44D30E0D1;
	Fri, 12 Sep 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Q/dtWIuy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091E30AAC1;
	Fri, 12 Sep 2025 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688825; cv=none; b=ZnvIEGb/X6st6aQtiE78PKNBKZEl/fxdVKkcJ3dRRlf7/h9NBEQMF9nDF1XE49srGLQCG+TssQilt9kmDq6ImxQOub6mB+dd/Oh42CPO74gfhMaMjkFkEyAuyTVVMT0a+PUsQkVrV1jWy15EQ5GfAeNMiAalNavyveQjw26oUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688825; c=relaxed/simple;
	bh=mv5+8WZOjkQKDf9HbKRp2YsJHQReKgMrLjMNsW3e3fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFU2YABYNAWxGVuuaZGMFrHAf4s+5ujAXue0vReYDuQXqN6cH1GUsRD5/088SwXjZ63xuNqMNrYIvM0eBruQ6KnafoEdrMe/OqJwBanjKh1F8Lrf5mF0crubEVfiDGISW2uY0F6PvIPsgZeIbc0yDRgPYfYBkUFP+Qpm5UaG4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Q/dtWIuy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id AC50F2C5;
	Fri, 12 Sep 2025 16:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757688743;
	bh=mv5+8WZOjkQKDf9HbKRp2YsJHQReKgMrLjMNsW3e3fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/dtWIuyzc3BdbYATl9gLGpZ7jCc6xMoyA8Zz92c9AtePzm5guZqIKmKV6Y1w851l
	 DkRjK6t9QVkQ5HqczM/TUb9i0P7ZM8cIP2zyaD4DTp9blwtpIxCYolMecdKZ9pZeZl
	 Apwm7zgwo/9c+epMTRALHii6xyJEWxIjYHaCAtTs=
Date: Fri, 12 Sep 2025 17:53:12 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <20250912145312.GK31682@pendragon.ideasonboard.com>
References: <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
 <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <2025091237-cortex-carnage-5c34@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025091237-cortex-carnage-5c34@gregkh>

On Fri, Sep 12, 2025 at 04:40:27PM +0200, Greg KH wrote:
> On Fri, Sep 12, 2025 at 05:26:46PM +0300, Laurent Pinchart wrote:
> > (CC'ing Dan Williams)
> > 
> > On Fri, Sep 12, 2025 at 04:19:53PM +0200, Greg KH wrote:
> > > On Fri, Sep 12, 2025 at 04:59:16PM +0300, Laurent Pinchart wrote:
> > > > On Fri, Sep 12, 2025 at 03:46:27PM +0200, Bartosz Golaszewski wrote:
> > > > > On Fri, Sep 12, 2025 at 3:39 PM Greg Kroah-Hartman wrote:
> > > > > >
> > > > > > I have no objection moving this to the cdev api, BUT given that 'struct
> > > > > > cdev' is embedded everywhere, I don't think it's going to be a simple
> > > > > > task, but rather have to be done one-driver-at-a-time like the patch in
> > > > > > this series does it.
> > > > > 
> > > > > I don't think cdev is the right place for this as user-space keeping a
> > > > > reference to a file-descriptor whose "backend" disappeared is not the
> > > > > only possible problem. We can easily create a use-case of a USB I2C
> > > > > expander being used by some in-kernel consumer and then unplugged.
> > > > > This has nothing to do with the character device. I believe the
> > > > > sub-system level is the right place for this and every driver
> > > > > subsystem would have to integrate it separately, taking its various
> > > > > quirks into account.
> > > > 
> > > > That's why I mentioned in-kernel users previously. Drivers routinely
> > > > acquire resources provided by other drivers, and having a way to revoke
> > > > those is needed.
> > > > 
> > > > It is a different but related problem compared to userspace racing with
> > > > .remove(). Could we solve both using the same backend concepts ?
> > > > Perhaps, time will tell, and if that works nicely, great. But we still
> > > > have lots of drivers exposing character devices to userspace (usually
> > > > through a subsystem-specific API, drivers that create a cdev manually
> > > > are the minority). That problem is in my opinion more urgent than
> > > > handling the removal of in-kernel resources, because it's more common,
> > > > and is easily triggerable by userspace. The good news is that it should
> > > > also be simpler to solve, we should be able to address the enter/exit
> > > > part entirely in cdev, and limit the changes to drivers in .remove() to
> > > > the strict minimum.
> > > > 
> > > > What I'd like to see is if the proposed implementation of revocable
> > > > resources can be used as a building block to fix the cdev issue. If it
> > > > ca, great, let's solve it then. If it can't, that's still fine, it will
> > > > still be useful for in-kernel resources, even if we need a different
> > > > implementation for cdev.
> > > 
> > > Patch 5/5 in this series does just this for a specific use of a cdev in
> > > the driver.  Is that what you are looking for?
> > 
> > Not quite, I would like to see the enter/exit (aka revocable scope if my
> > understanding is correct) being pushed to char_dev.c, as Dan did in [1].
> > I'm fine having to add an extra function call in the .remove() path of
> > drivers, but I'm not fine with having to mark revocable sections
> > manually in drivers. That part belongs to cdev.
> > 
> > [1] https://lore.kernel.org/r/161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com
> 
> Dan's proposal here is a good start, but the "sleep in cdev_del() until
> the device drains all existing opens" is going to not really work well
> for what we want.

I think you missed the fact that the code doesn't wait for all open file
handles to be closed. It waits for all in-progress syscalls to return
from the driver. That's a big difference.

> So sure, make a new cdev api to use this, that's fine, then we will have
> what, 5 different ways to use a cdev?  :)
> 
> Seriously, that would be good, then we can work to convert things over,
> but I think overall it will look much the same as what patch 5/5 does
> here.  But details matter, I don't really known for sure...

What I don't want to see is drivers using this new API directly to
protect the cdev race. That would be a big step in the wrong direction.
Patch 5/5 needs to move driver code to the cdev level. That shouldn't be
difficult, so I really not see why it can't be done in v4 to see how it
will look like.

> Either way, I think this patch series stands on its own, it doesn't
> require cdev to implement it, drivers can use it to wrap a cdev if they
> want to.

No, drivers should *not* do that manually. That's a recipe for disaster
that we would regret later.

> We have other structures that want to do this type of thing
> today as is proof with the rust implementation for the devm api.

-- 
Regards,

Laurent Pinchart

