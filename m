Return-Path: <linux-kselftest+bounces-4939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D345785ABB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 20:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1E61F22BD5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3144878D;
	Mon, 19 Feb 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="V2ozuC5w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03004482F8;
	Mon, 19 Feb 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369341; cv=none; b=PtqBMu5l4xmSTktS6BrTblMnYdGz4qt7MBHgWy0/Ceq+paveDYfUh0TCaoQxzyPMbopBYBiKjkly4A94geno2PYGeEEEYwH3s9iXWSNLYyQeOKCpYMwgdTmBB3KTXavFNh/AVlXluQj3rPFTl+qqPVYhJ4CmTEuap37CnEpBafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369341; c=relaxed/simple;
	bh=8uwAxkMAA6MNFUqB6ZfPPfcwy23Ru+f/+1DQ3k3LdEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyRwMPWREqL4gxlb4i2hGeAbdaWjZDPFdWjWWfdQ9tDKn0tWLtYcBpavm3ZB1pyiEmxvvP0qKkCX1lescOryUAfktHOLWsWyBO1SJpZNxd2qzSLHsDgqUT/JCyM1hNiLyNrtvnB4IEei6shRrMJ/X4nCF9rDq2rMGdHpZjmiXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=V2ozuC5w; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=OswHFruBK+/42s5rUgGTBUDrZT8BKSSXWo8vUY+w8EE=; b=V2ozuC5whirZjX5c3zIZcKzXOy
	ochgpA2PZNhXbxdMP7TdNWqORglH4mwKiegmekbtii4Net8AcfYh93PrccpamdE55szcbfIbrTTtV
	Pm0oTIbBwAbQSiwtYlzKW49z/0QKzXYy+UYC0esfGQWx7/TXCaasq1cFhgYTfUCGPG3FK2PREsghX
	Ngeb52VM/5Q/rUnGN7uZemohAFeS2FG4OaLqU7CCIUqfttD6Kf0IlbTlpwVTr+ZGUF2k0ztMTBSev
	hrsOJYIwei+UEu5clcO9CNPbBnunIpm+glQuk8I5Th5gJo9SvB4o0GCzkwDf8UPaw1lm6dOkgN6zo
	L/jb1B4Q==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rc8tz-002yXh-36;
	Mon, 19 Feb 2024 13:02:08 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/31] ntsync: Introduce NTSYNC_IOC_CREATE_SEM.
Date: Mon, 19 Feb 2024 13:02:07 -0600
Message-ID: <3547727.iIbC2pHGDl@camazotz>
In-Reply-To: <2024021707-sloppy-hurt-df0c@gregkh>
References:
 <20240214233645.9273-1-zfigura@codeweavers.com>
 <13452408.uLZWGnKmhe@camazotz> <2024021707-sloppy-hurt-df0c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, 17 February 2024 02:03:15 CST Greg Kroah-Hartman wrote:
> On Thu, Feb 15, 2024 at 01:22:01PM -0600, Elizabeth Figura wrote:
> > On Thursday, 15 February 2024 01:28:32 CST Greg Kroah-Hartman wrote:
> > > On Wed, Feb 14, 2024 at 05:36:38PM -0600, Elizabeth Figura wrote:
> > > > This corresponds to the NT syscall NtCreateSemaphore().
> > > > 
> > > > Semaphores are one of three types of object to be implemented in this driver,
> > > > the others being mutexes and events.
> > > > 
> > > > An NT semaphore contains a 32-bit counter, and is signaled and can be acquired
> > > > when the counter is nonzero. The counter has a maximum value which is specified
> > > > at creation time. The initial value of the semaphore is also specified at
> > > > creation time. There are no restrictions on the maximum and initial value.
> > > > 
> > > > Each object is exposed as an file, to which any number of fds may be opened.
> > > > When all fds are closed, the object is deleted.
> > > > 
> > > > Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> > > > ---
> > > >  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
> > > >  drivers/misc/ntsync.c                         | 120 ++++++++++++++++++
> > > >  include/uapi/linux/ntsync.h                   |  21 +++
> > > >  3 files changed, 143 insertions(+)
> > > >  create mode 100644 include/uapi/linux/ntsync.h
> > > > 
> > > > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > > index 457e16f06e04..2f5c6994f042 100644
> > > > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > > > @@ -173,6 +173,8 @@ Code  Seq#    Include File                                           Comments
> > > >  'M'   00-0F  drivers/video/fsl-diu-fb.h                              conflict!
> > > >  'N'   00-1F  drivers/usb/scanner.h
> > > >  'N'   40-7F  drivers/block/nvme.c
> > > > +'N'   80-8F  uapi/linux/ntsync.h                                     NT synchronization primitives
> > > > +                                                                     <mailto:wine-devel@winehq.org>
> > > >  'O'   00-06  mtd/ubi-user.h                                          UBI
> > > >  'P'   all    linux/soundcard.h                                       conflict!
> > > >  'P'   60-6F  sound/sscape_ioctl.h                                    conflict!
> > > > diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> > > > index e4969ef90722..3ad86d98b82d 100644
> > > > --- a/drivers/misc/ntsync.c
> > > > +++ b/drivers/misc/ntsync.c
> > > > @@ -5,26 +5,146 @@
> > > >   * Copyright (C) 2024 Elizabeth Figura
> > > >   */
> > > >  
> > > > +#include <linux/anon_inodes.h>
> > > > +#include <linux/file.h>
> > > >  #include <linux/fs.h>
> > > >  #include <linux/miscdevice.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/slab.h>
> > > > +#include <uapi/linux/ntsync.h>
> > > >  
> > > >  #define NTSYNC_NAME	"ntsync"
> > > >  
> > > > +enum ntsync_type {
> > > > +	NTSYNC_TYPE_SEM,
> > > > +};
> > > > +
> > > > +struct ntsync_obj {
> > > > +	enum ntsync_type type;
> > > > +
> > > > +	union {
> > > > +		struct {
> > > > +			__u32 count;
> > > > +			__u32 max;
> > > > +		} sem;
> > > > +	} u;
> > > > +
> > > > +	struct file *file;
> > > > +	struct ntsync_device *dev;
> > > > +};
> > > > +
> > > > +struct ntsync_device {
> > > > +	struct file *file;
> > > > +};
> > > 
> > > No reference counting is needed for your ntsync_device?  Or are you
> > > relying on the reference counting of struct file here?
> > > 
> > > You pass around pointers to this structure, and save it off into other
> > > structures, how do you know it is "safe" to do so?
> > 
> > Yes, this relies on the reference counting of struct file. The sync
> > objects (semaphore etc.) grab a reference when they're created, via
> > get_file(), and release it when they're destroyed. This reference is
> > taken from within ioctls on the ntsync_device, so the file must be
> > valid when we grab a reference. Maybe I'm missing something, though?
> 
> If the reference count is driven by struct file, that's fine, and great,
> otherwise you end up with two different reference counts and keeping
> them in sync is impossible.
> 
> But as it wasn't obvious, a comment somewhere here would be helpful for
> reviewing and figuring out how this all works in 4 years when someone
> has to touch it again.

Ah, makes sense. I'll add comments to be clearer about the refcounting
relationships, thanks.

--Zeb



