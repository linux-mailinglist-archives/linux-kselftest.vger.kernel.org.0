Return-Path: <linux-kselftest+bounces-45208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96576C45141
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 07:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BA984E3173
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 06:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9289F2773E3;
	Mon, 10 Nov 2025 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPDbT+y7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272B156F20;
	Mon, 10 Nov 2025 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756102; cv=none; b=PklsV1y74mhY5+ZI1V12zp2At0PQ5h6Wnf/ohNle78Y9P0XY2JpOw2j3S4hycptmV67yHNULX6Y2fEx+ZT6Xs7S64eJ9TZmrSjePCoVe2N97N7TuAoQgiPDVt+/YblPkqxEX/IjFwwK+LbQSMXpf99oH0hckYBUjSnIC6QCez/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756102; c=relaxed/simple;
	bh=ddIMMg0/UoErbMTX78JXcS4JAj9BwMzwkiTUhO7Nqns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuWJIfytjmJMJuvRi8mcrTXYgHwX+AQz9cmb0TnJL1nL1SxT2AaCS7KG71agRPl6dKsS9i6SywmGJ2QW75e2BjpPKlA7WCt0nwp9V+75AZwlDtEE0D0FFOCTQPHNiqg2YBMg3Ni7r98kIFAAGcZ2LTxdqenxVZaCta4unifiEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPDbT+y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D8DC116B1;
	Mon, 10 Nov 2025 06:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762756101;
	bh=ddIMMg0/UoErbMTX78JXcS4JAj9BwMzwkiTUhO7Nqns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPDbT+y7SDARIULk5EY9QOatLDtZNrpJ0nyknHBBTjv5z+mwJKFnycRJ1vBNgBDtl
	 ZzYYo6RNkpWQcNIlZr6LU+maAns6QpKykxbBXRJm9rA/XX7pLDkz7p7b0cbwKlNGvz
	 1CH9nRFaIRQ93E0pzoMo2lFGTGZXSlHtRGSE0nY/g4InX86/4chH9kCNjiVF1k5vXC
	 WQC/2+TyMIOmG/Qxl4C9N8rq3EU520uOgaftw0MHKQ0cB4ZwjVfmic0VkGp3IVhrXi
	 BMTjemiDqgWffTd1p3587iB0ZXaKY0i8K+IBYhjYwUUxLd7a5Vuo6NQe+n1eDjg+/O
	 iXWNfME8V8yOw==
Date: Mon, 10 Nov 2025 06:28:17 +0000
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
Message-ID: <aRGGARe6ExyGpaRh@google.com>
References: <20251106152712.11850-1-tzungbi@kernel.org>
 <20251106152712.11850-2-tzungbi@kernel.org>
 <20251106154715.GB1732817@nvidia.com>
 <aQ1-qj0ztQ29h-oc@google.com>
 <20251107141509.GK1732817@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107141509.GK1732817@nvidia.com>

On Fri, Nov 07, 2025 at 10:15:09AM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 07, 2025 at 05:07:54AM +0000, Tzung-Bi Shih wrote:
> > On Thu, Nov 06, 2025 at 11:47:15AM -0400, Jason Gunthorpe wrote:
> > > On Thu, Nov 06, 2025 at 11:27:10PM +0800, Tzung-Bi Shih wrote:
> > > > +/*
> > > > + * Recover the private_data to its original one.
> > > > + */
> > > > +static struct fops_replacement *_recover_private_data(struct file *filp)
> > > > +{
> > > > +	struct fops_replacement *fr = filp->private_data;
> > > > +
> > > > +	filp->private_data = fr->orig_private_data;
> > > > +	return fr;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Replace the private_data to fops_replacement.
> > > > + */
> > > > +static void _replace_private_data(struct fops_replacement *fr)
> > > > +{
> > > > +	fr->filp->private_data = fr;
> > > > +}
> > > 
> > > This switching of private_data isn't reasonable, it breaks too much
> > > stuff. I think I showed a better idea in my sketch.
> > 
> > The approach assumes the filp->private_data should be set once by the
> > filp->f_op->open() if any.  Is it common that the filp->private_data
> > be updated in other file operations?
> 
> You can set it once during open, but you can't change it around every
> fops callback. This stuff is all concurrent.

Ah, yes, I see.

> > > This probably doesn't work out, is likely to make a memory leak.
> > > It will be hard for the owning driver to free its per-file memory
> > > without access to release.
> > 
> > Ah, I think this reveals a drawback of the approach.
> > - Without calling ->release(), some memory may leak.
> > - With calling ->release(), some UAF may happen. 
> 
> It just means the user of this needs to understand there are
> limitations on what release can do. Usually release just frees memory,
> that is fine.
> 
> I think it would be strange for a release to touch revocable data,
> that might suggest some larger problem.

I think it'd be inevitable for accessing some devm memory in ->release(),
e.g. [1].

[1] https://elixir.bootlin.com/linux/v6.17/source/drivers/platform/chrome/cros_ec_chardev.c#L260

