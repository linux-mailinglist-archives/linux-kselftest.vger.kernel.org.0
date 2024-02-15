Return-Path: <linux-kselftest+bounces-4811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C782C856D91
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 20:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AC71F21A33
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F2139593;
	Thu, 15 Feb 2024 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="q0+Dxvfm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5B136983;
	Thu, 15 Feb 2024 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024927; cv=none; b=OXGvTUfhQaMNqF0L+OL0TsSwIz54defgyaTdIMCqWD77olLb+k3NhBhnanK7eOkdvrA4AdrPD5HwaEyyVxchrZYpMBR6uIeQXfduCNCOG1c4lZKyrzRXGuLg/USFZ45d0X0lExmn+bfCYBlbduLxb2aArEpBGY5djbut2waifxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024927; c=relaxed/simple;
	bh=CBp2D/DDv0XKJPrPwReIWJc4I2Sf+kTEZIl+XqHMYHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjRDASE0u6hKCr8WLQNMJhTe20q9VGiDT3W4fXxAQQBzfkQVDQyiygDDml2Ms+I4jn3n+ArGTBQTBHX3aCgzXXYXDtwNU0Nni3z+D96QqSZhusVyzpTuXlLYn4h4oX0bHwIuNRKbdsUkIwEz5GQ4pMWmMwz+A7PQkU/UX+wm4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=q0+Dxvfm; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=EswZ6wqtyT9+dG9fdNUkq4Y5N/Agv4gLkmDHefAesOQ=; b=q0+Dxvfmb/LkUUTBEx+LmnSfZl
	dddyNRKg/YAdOo8KtDqpogC2VAAub11Sl2cVL4bkrzFNrTxTGl9KUI5FBgczT1N+FEphfrECMwNuB
	zMKY1abXbiveB7kA05ZsApLo8gVfq3e4NV1bdWp0vKvk0LRDmD/cIPpmeaodSt9B7MX2aNyBVlkki
	CrQxHEySb1e1PAPaP6AC+ZhTxLPlaFU6XebhIuvyrWhYGHJncO92/sMD9p3e+eE96+HWvxzCPgqUf
	xqKpITGLAv/nT55SjaNTgxVJgIZ7aBWjZm/+k3Du+qB0Zm1orSxXCGEzWbkCo62BueuHIXhwezyUe
	q0Izqh/Q==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rahJ4-00HKoO-0e;
	Thu, 15 Feb 2024 13:22:02 -0600
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
Date: Thu, 15 Feb 2024 13:22:01 -0600
Message-ID: <13452408.uLZWGnKmhe@camazotz>
In-Reply-To: <2024021533-thicken-handed-7d2d@gregkh>
References:
 <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214233645.9273-3-zfigura@codeweavers.com>
 <2024021533-thicken-handed-7d2d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 15 February 2024 01:28:32 CST Greg Kroah-Hartman wrote:
> On Wed, Feb 14, 2024 at 05:36:38PM -0600, Elizabeth Figura wrote:
> > This corresponds to the NT syscall NtCreateSemaphore().
> > 
> > Semaphores are one of three types of object to be implemented in this driver,
> > the others being mutexes and events.
> > 
> > An NT semaphore contains a 32-bit counter, and is signaled and can be acquired
> > when the counter is nonzero. The counter has a maximum value which is specified
> > at creation time. The initial value of the semaphore is also specified at
> > creation time. There are no restrictions on the maximum and initial value.
> > 
> > Each object is exposed as an file, to which any number of fds may be opened.
> > When all fds are closed, the object is deleted.
> > 
> > Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> > ---
> >  .../userspace-api/ioctl/ioctl-number.rst      |   2 +
> >  drivers/misc/ntsync.c                         | 120 ++++++++++++++++++
> >  include/uapi/linux/ntsync.h                   |  21 +++
> >  3 files changed, 143 insertions(+)
> >  create mode 100644 include/uapi/linux/ntsync.h
> > 
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index 457e16f06e04..2f5c6994f042 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -173,6 +173,8 @@ Code  Seq#    Include File                                           Comments
> >  'M'   00-0F  drivers/video/fsl-diu-fb.h                              conflict!
> >  'N'   00-1F  drivers/usb/scanner.h
> >  'N'   40-7F  drivers/block/nvme.c
> > +'N'   80-8F  uapi/linux/ntsync.h                                     NT synchronization primitives
> > +                                                                     <mailto:wine-devel@winehq.org>
> >  'O'   00-06  mtd/ubi-user.h                                          UBI
> >  'P'   all    linux/soundcard.h                                       conflict!
> >  'P'   60-6F  sound/sscape_ioctl.h                                    conflict!
> > diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> > index e4969ef90722..3ad86d98b82d 100644
> > --- a/drivers/misc/ntsync.c
> > +++ b/drivers/misc/ntsync.c
> > @@ -5,26 +5,146 @@
> >   * Copyright (C) 2024 Elizabeth Figura
> >   */
> >  
> > +#include <linux/anon_inodes.h>
> > +#include <linux/file.h>
> >  #include <linux/fs.h>
> >  #include <linux/miscdevice.h>
> >  #include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <uapi/linux/ntsync.h>
> >  
> >  #define NTSYNC_NAME	"ntsync"
> >  
> > +enum ntsync_type {
> > +	NTSYNC_TYPE_SEM,
> > +};
> > +
> > +struct ntsync_obj {
> > +	enum ntsync_type type;
> > +
> > +	union {
> > +		struct {
> > +			__u32 count;
> > +			__u32 max;
> > +		} sem;
> > +	} u;
> > +
> > +	struct file *file;
> > +	struct ntsync_device *dev;
> > +};
> > +
> > +struct ntsync_device {
> > +	struct file *file;
> > +};
> 
> No reference counting is needed for your ntsync_device?  Or are you
> relying on the reference counting of struct file here?
> 
> You pass around pointers to this structure, and save it off into other
> structures, how do you know it is "safe" to do so?

Yes, this relies on the reference counting of struct file. The sync
objects (semaphore etc.) grab a reference when they're created, via
get_file(), and release it when they're destroyed. This reference is
taken from within ioctls on the ntsync_device, so the file must be
valid when we grab a reference. Maybe I'm missing something, though?



