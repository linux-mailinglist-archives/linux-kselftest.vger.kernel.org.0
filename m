Return-Path: <linux-kselftest+bounces-4910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D900858DD9
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 09:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E39F1F21C7A
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 08:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74981CD1D;
	Sat, 17 Feb 2024 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2CGEbcN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1681CF80;
	Sat, 17 Feb 2024 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708156998; cv=none; b=lzzBmQ6eLPC35+uixlReAr/0CzBLCSdhRaKEx5s7gZS3pKpKwe9YZ28h9XwSqOS89r7FhNnB/wR8R8KZt3abcbeB7nA44AHVnITwSmhQ0HtLkXLZYPdxO08d2y9rwt78Dv1u54QAQGlnTFcASWF1Rt3pTGEhH+YKi8kDEI8PMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708156998; c=relaxed/simple;
	bh=ZVIoqR5nN2OF4iWMCSTma4AkS32ogPTnV+/uROqGKfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiIPO9OPnaiFKsYq726MFOTXv0jejzzZLuVUgvaAFDbhouYhg0CgV1ofhecRpMwdK3u1Zm5fkiFifwOoONADMazvgUOlCJJDouWIXjLUL0gl5PIsfNbuMNg69S/gFyjRY++NklzGdse57ltr/abV99993pFo8xEefyDZjOHlnDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2CGEbcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC65C433C7;
	Sat, 17 Feb 2024 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708156998;
	bh=ZVIoqR5nN2OF4iWMCSTma4AkS32ogPTnV+/uROqGKfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2CGEbcNjlvRL0j/1q3/Krdig/duKX+ZsydLbsNK9cUpE2CqVvZvBfUovP+5KiObs
	 MLIVQtlRrc+LoCMG6m4uaNITyY+Kt+XnjkDsUzAike8i5o9NQseOt8KOPSujLtAqHD
	 1dqc8rZo9mUkOmjpSFk6UYHa0LOpJIbHEs3Ofe7c=
Date: Sat, 17 Feb 2024 09:03:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/31] ntsync: Introduce NTSYNC_IOC_CREATE_SEM.
Message-ID: <2024021707-sloppy-hurt-df0c@gregkh>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214233645.9273-3-zfigura@codeweavers.com>
 <2024021533-thicken-handed-7d2d@gregkh>
 <13452408.uLZWGnKmhe@camazotz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13452408.uLZWGnKmhe@camazotz>

On Thu, Feb 15, 2024 at 01:22:01PM -0600, Elizabeth Figura wrote:
> On Thursday, 15 February 2024 01:28:32 CST Greg Kroah-Hartman wrote:
> > On Wed, Feb 14, 2024 at 05:36:38PM -0600, Elizabeth Figura wrote:
> > > This corresponds to the NT syscall NtCreateSemaphore().
> > > 
> > > Semaphores are one of three types of object to be implemented in this driver,
> > > the others being mutexes and events.
> > > 
> > > An NT semaphore contains a 32-bit counter, and is signaled and can be acquired
> > > when the counter is nonzero. The counter has a maximum value which is specified
> > > at creation time. The initial value of the semaphore is also specified at
> > > creation time. There are no restrictions on the maximum and initial value.
> > > 
> > > Each object is exposed as an file, to which any number of fds may be opened.
> > > When all fds are closed, the object is deleted.
> > > 
> > > Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> > > ---
> > >  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
> > >  drivers/misc/ntsync.c                         | 120 ++++++++++++++++++
> > >  include/uapi/linux/ntsync.h                   |  21 +++
> > >  3 files changed, 143 insertions(+)
> > >  create mode 100644 include/uapi/linux/ntsync.h
> > > 
> > > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > index 457e16f06e04..2f5c6994f042 100644
> > > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > @@ -173,6 +173,8 @@ Code  Seq#    Include File                                           Comments
> > >  'M'   00-0F  drivers/video/fsl-diu-fb.h                              conflict!
> > >  'N'   00-1F  drivers/usb/scanner.h
> > >  'N'   40-7F  drivers/block/nvme.c
> > > +'N'   80-8F  uapi/linux/ntsync.h                                     NT synchronization primitives
> > > +                                                                     <mailto:wine-devel@winehq.org>
> > >  'O'   00-06  mtd/ubi-user.h                                          UBI
> > >  'P'   all    linux/soundcard.h                                       conflict!
> > >  'P'   60-6F  sound/sscape_ioctl.h                                    conflict!
> > > diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> > > index e4969ef90722..3ad86d98b82d 100644
> > > --- a/drivers/misc/ntsync.c
> > > +++ b/drivers/misc/ntsync.c
> > > @@ -5,26 +5,146 @@
> > >   * Copyright (C) 2024 Elizabeth Figura
> > >   */
> > >  
> > > +#include <linux/anon_inodes.h>
> > > +#include <linux/file.h>
> > >  #include <linux/fs.h>
> > >  #include <linux/miscdevice.h>
> > >  #include <linux/module.h>
> > > +#include <linux/slab.h>
> > > +#include <uapi/linux/ntsync.h>
> > >  
> > >  #define NTSYNC_NAME	"ntsync"
> > >  
> > > +enum ntsync_type {
> > > +	NTSYNC_TYPE_SEM,
> > > +};
> > > +
> > > +struct ntsync_obj {
> > > +	enum ntsync_type type;
> > > +
> > > +	union {
> > > +		struct {
> > > +			__u32 count;
> > > +			__u32 max;
> > > +		} sem;
> > > +	} u;
> > > +
> > > +	struct file *file;
> > > +	struct ntsync_device *dev;
> > > +};
> > > +
> > > +struct ntsync_device {
> > > +	struct file *file;
> > > +};
> > 
> > No reference counting is needed for your ntsync_device?  Or are you
> > relying on the reference counting of struct file here?
> > 
> > You pass around pointers to this structure, and save it off into other
> > structures, how do you know it is "safe" to do so?
> 
> Yes, this relies on the reference counting of struct file. The sync
> objects (semaphore etc.) grab a reference when they're created, via
> get_file(), and release it when they're destroyed. This reference is
> taken from within ioctls on the ntsync_device, so the file must be
> valid when we grab a reference. Maybe I'm missing something, though?

If the reference count is driven by struct file, that's fine, and great,
otherwise you end up with two different reference counts and keeping
them in sync is impossible.

But as it wasn't obvious, a comment somewhere here would be helpful for
reviewing and figuring out how this all works in 4 years when someone
has to touch it again.

thanks,

greg k-h

