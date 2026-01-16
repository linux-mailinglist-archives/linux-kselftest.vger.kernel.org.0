Return-Path: <linux-kselftest+bounces-49172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2CCD3361C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2B1C302036A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B9833D6D5;
	Fri, 16 Jan 2026 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OrhJihAt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992133A03F;
	Fri, 16 Jan 2026 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579490; cv=none; b=THqYkmCvlYCkis+D4a76oLmA2xgc0vJT9g2nFVHMGOWUbko1MoInbnENjuK1MGM48aFwYl0tDBNl8M80w7WPtg4QSbvQFvjmf0n42MKMoGp0qZDm/cJ42/KVotAToF1nyroZHc4keR7cAeksK8R7X7oUJGN7J64PinG7v8A90n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579490; c=relaxed/simple;
	bh=d6fx63Lc9tb5FePd5rV7dwl4JBQ3NTTSjw9eH/lcsl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKmaMjMws24nQzngtCoQ6HbUjQYZDLQvdXjefuPCxSeY7hI0SjXaPm5VdGFrUJakEr1J4z9DBVl1VDjgeN/I3nSEMYamgXaly8Uf2ljv+RlbB2zQfQdPhLw6YKwjXGG5saaoOjIhIVCGhM7/XsrL8DJqEDQJVNfQpjc5XNDTdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OrhJihAt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-152.bb.dnainternet.fi [81.175.209.152])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 438893D7;
	Fri, 16 Jan 2026 17:04:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1768579457;
	bh=d6fx63Lc9tb5FePd5rV7dwl4JBQ3NTTSjw9eH/lcsl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrhJihAtkd/QVayLh2IudJ7/j0ryHqHTIClVRs6aFSilR0jLySPgpImvAXAhKM0Wz
	 4iyWD8xG+ui/o7qdH/tx+lQY/MgWGRTTdLE5jNR2jNVykBAVxyzIyZGdixAtqQtgFi
	 zy7gRAoXWFyofs6RsRyauVYrL2juMzJDkxiZYsHQ=
Date: Fri, 16 Jan 2026 18:04:24 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 1/3] revocable: Revocable resource management
Message-ID: <20260116160424.GA14499@pendragon.ideasonboard.com>
References: <20260116080235.350305-1-tzungbi@kernel.org>
 <20260116080235.350305-2-tzungbi@kernel.org>
 <DFQ45FWO4XHC.2BW7I9LGC76WT@kernel.org>
 <CAMRc=Medaqr5UPimc8o+VTy=9MgU5p8AXjArisQfBNqi7ktSGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Medaqr5UPimc8o+VTy=9MgU5p8AXjArisQfBNqi7ktSGg@mail.gmail.com>

On Fri, Jan 16, 2026 at 04:27:27PM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 16, 2026 at 4:20 PM Danilo Krummrich wrote:
> > On Fri Jan 16, 2026 at 9:02 AM CET, Tzung-Bi Shih wrote:
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index a671e3d4e8be..fd683c62012a 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -22517,6 +22517,13 @@ F:   include/uapi/linux/rseq.h
> > >  F:   kernel/rseq.c
> > >  F:   tools/testing/selftests/rseq/
> > >
> > > +REVOCABLE RESOURCE MANAGEMENT
> > > +M:   Tzung-Bi Shih <tzungbi@kernel.org>
> > > +L:   linux-kernel@vger.kernel.org
> > > +S:   Maintained
> > > +F:   drivers/base/revocable.c
> > > +F:   include/linux/revocable.h
> >
> > NIT: I think we should add this include to the DRIVER CORE entry as well.
> 
> FWIW: I'm not even sure drivers/base/ is the right place for this.
> Except for a few devm_ helpers, nothing here is inherently tied into
> the driver model This could be useful outside of device drivers and I
> would suggest to put it under lib/ with devres factored out into a
> separate source file.

I agree. Based on the discussions we had at LPC, the revocable resource
management API is not the right solution to handle races between device
removal and userspace access. It is however a possibly useful tool for
races between producers and consumers *inside the kernel*. lib/ is a
better location.

-- 
Regards,

Laurent Pinchart

