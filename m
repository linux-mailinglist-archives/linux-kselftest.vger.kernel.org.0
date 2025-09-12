Return-Path: <linux-kselftest+bounces-41389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7D4B54FF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 15:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C541D61101
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6F514EC62;
	Fri, 12 Sep 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="o2vmvq9B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69682F4A;
	Fri, 12 Sep 2025 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684774; cv=none; b=QL8ZCUZbRAgGslNjyjhITNjrqRkFQ7l18KqcO5wSt0wsiUNadupN5MxOD5i7MuuNvX3qEnOO4mnTNCh7lxAvUJ06iSgi91ux8lbHVDUUjHyLcZwPzrlObiZtkwkE5y4IHwOnUtxLY4R7OmVhqKKf3A+WRWSf8cjdkIFpn6DlVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684774; c=relaxed/simple;
	bh=KUZhuLl+Gs4KnXYvf8nk0Gm29ZFsC3pl6FDSSD5gB98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0C0lgJrC3WQ8jLowhg0cr55DuvRIbhMrcZMNIrFWMb+tE38ZzPe3wBbIg8u8dPb7w0MdMlBpVuG+dbpUdic1sg/niCZLDR+QwZjlfqIoHf/OxrgwilmSaZJ5P3mak6DSILB5GnLizhjXqWN36imPzvnysBa571cHHWNTqIwWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=o2vmvq9B; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 9F13E50A;
	Fri, 12 Sep 2025 15:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757684693;
	bh=KUZhuLl+Gs4KnXYvf8nk0Gm29ZFsC3pl6FDSSD5gB98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2vmvq9B9Sh2jNlTCk30dCk5o8iLos/J2ktMMMv3P/OAfJLmrx40Vs3TI8xxvomd5
	 UKF5xT2g+nCFcwhfGjcZV3wEQUt0hUp/ggeoH/giS4iVYiOOPkjWyoneVXZhgkfxnR
	 gvJ2F3LCs3CVVnuxvAhhYSkduIJbFhxv269XkBE4=
Date: Fri, 12 Sep 2025 16:45:40 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>, brgl@bgdev.pl
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <20250912134540.GE31682@pendragon.ideasonboard.com>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
 <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025091209-curfew-safari-f6e0@gregkh>

On Fri, Sep 12, 2025 at 03:39:45PM +0200, Greg KH wrote:
> On Fri, Sep 12, 2025 at 04:26:56PM +0300, Laurent Pinchart wrote:
> > On Fri, Sep 12, 2025 at 08:49:30PM +0800, Tzung-Bi Shih wrote:
> > > On Fri, Sep 12, 2025 at 11:24:10AM +0200, Bartosz Golaszewski wrote:
> > > > On Fri, 12 Sept 2025 at 11:09, Krzysztof Kozlowski wrote:
> > > > > On 12/09/2025 10:17, Tzung-Bi Shih wrote:
> > > > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > > Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > > >
> > > > > Thanks for the work. Just a note, please start using b4, so above Cc
> > > > > will be propagated to all patches. Folks above received only the cover
> > > > > letter...
> > > 
> > > Thank you for bringing this to my attention.  I wasn't aware of that and
> > > will ensure this is handled correctly in the future.
> > > 
> > > > Thanks to Krzysztof for making me aware of this. Could you please Cc
> > > > my brgl@bgdev.pl address on the next iteration.
> > > 
> > > Sure, will do.
> > > 
> > > > I haven't looked into the details yet but the small size of the first
> > > > patch strikes me as odd. The similar changes I did for GPIO were quite
> > > > big and they were designed just for a single sub-system.
> > > > 
> > > > During the talk you reference, after I suggested a library like this,
> > > > Greg KH can be heard saying: do this for two big subsystems so that
> > > > you're sure it's a generic solution. Here you're only using it in a
> > > > single driver which makes me wonder if we can actually use it to
> > > > improve bigger offenders, like for example I2C, or even replace the
> > > > custom, SRCU-based solution in GPIO we have now. Have you considered
> > > > at least doing a PoC in a wider kernel framework?
> > > 
> > > Yes, I'm happy to take this on.
> > > 
> > > To help me get started, could you please point me to some relevant code
> > > locations?  Also, could you let me know if any specific physical devices
> > > will be needed for testing?
> > 
> > One interesting test would be to move the logic to the cdev layer. The
> > use-after-free problem isn't specific to one type of character device,
> > and so shouldn't require a fix in every driver instantiating a cdev
> > directly (or indirectly). See [1] for a previous attempt to handle this
> > at the V4L2 level and [2] for an attempt to handle it at the cdev level.
> > 
> > In [1], two new functions named video_device_enter() and
> > video_device_exit() flag the beginning and end of protected code
> > sections. The equivalent in [2] is the manual get/put of cdev->qactive,
> > and if I understand things correctly, your series creates a REVOCABLE()
> > macro to do the same. I'm sure we'll bikesheed about names at some
> > point, but for the time being, what I'd like to see if this being done
> > in fs/char_dev.c to cover all entry points from userspace at the cdev
> > level.
> > 
> > We then have video_device_unplug() in [1], which I think is more or less
> > the equivalent of revocable_provider_free(). I don't think we'll be able
> > to hide this completely from drivers, at least not in all cases. We
> > should however design the API to make it easy for drivers, likely with
> > subsystem-specific wrappers.
> > 
> > What I have in mind is roughly the following:
> > 
> > 1. Protect all access to the cdev from userspace with enter/exit calls
> >    that flag if a call is in progress. This can be done with explicit
> >    function calls, or with a scope guard as in your series.
> > 
> > 2. At .remove() time, start by flagging that the device is being
> >    removed. That has to be an explicit call from drivers I believe,
> >    likely using subsystem-specific wrappers to simplify things.
> > 
> > 3. Once the device is marked as being removed, all enter() calls should
> >    fail at the cdev level.
> > 
> > 4. In .remove(), proceed to perform driver-specific operations that will
> >    stop the device and wake up any userspace task blocked on a syscall
> >    protected by enter()/remove(). This isn't needed for
> >    drivers/subsystems that don't provide any blocking API, but is
> >    required otherwise.
> > 
> > 5. Unregister, still in .remove(), the cdev (likely through
> >    subsystem-specific APIs in most cases). This should block until all
> >    protected sections have exited.
> > 
> > 6. The cdev is now unregistered, can't be opened anymore, and any
> >    new syscall on any opened file handle will return an error. The
> >    driver's .remove() function can proceed to free data, there won't be
> >    any UAF caused by userspace.
> > 
> > [1] implemented this fairly naively with flags and spinlocks. An
> > RCU-based implementation is probably more efficient, even if I don't
> > know how performance-sensitive all this is.
> > 
> > Does this align with your design, and do you think you could give a try
> > at pushing revocable resource handling to the cdev level ?
> > 
> > On a separate note, I'm not sure "revocable" is the right name here. I
> > believe a revocable resource API is needed, and well-named, for
> > in-kernel consumers (e.g. drivers consuming a GPIO or clock). For the
> > userspace syscalls racing with .remove(), I don't think we're dealing
> > with "revocable resources". Now, if a "revocable resources" API were to
> > support the in-kernel users, and be usable as a building block to fix
> > the cdev issue, I would have nothing against it, but the "revocable"
> > name should be internal in that case, used in the cdev layer only, and
> > not exposed to drivers (or even subsystem helpers that should wrap cdev
> > functions instead).
> 
> I think the name makes sense as it matches up with how things are
> working (the backend structure is "revoked"), but naming is tough :)
> 
> I have no objection moving this to the cdev api, BUT given that 'struct
> cdev' is embedded everywhere, I don't think it's going to be a simple
> task, but rather have to be done one-driver-at-a-time like the patch in
> this series does it.

For the .remove() code paths, yes, I expect driver changes. We need
subsystem-level helpers that will make those easy and hide the
complexity. For the code paths from userspace into the drivers through
cdev file operations, there should be no driver change required.

> And that's fine, we have "interns" that we can set loose on this type of
> code conversions, I think we just need to wrap the access to the cdev
> with this api, which will take a bit of rewriting in many drivers.
> 
> Anyway, just my thought, if someone else can see how this could drop
> into the core cdev code without any changes needed, that would be great,
> but I don't see it at the moment.  cdev is just too "raw" for that.

-- 
Regards,

Laurent Pinchart

