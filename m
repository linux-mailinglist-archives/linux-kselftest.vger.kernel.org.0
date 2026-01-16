Return-Path: <linux-kselftest+bounces-49173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8885BD3362E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E180F3070D6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD433AD98;
	Fri, 16 Jan 2026 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NFWzxkVw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3B78F26;
	Fri, 16 Jan 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579518; cv=none; b=kSVzNvz57TJVzh/mkXYR3TB6DqSpciDnU8CZrNdmiXxIUe3SPG0Gmq21zAJX2vmjC4oJGdSqCV600OC27JLyrdGs6qMbOYL8Ng2rIj49px4lwTsFlEjwKDBgO5PMMblF1dKCsXCi934wEeH0RTRgACempZ57DBQkyUsOjtU+/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579518; c=relaxed/simple;
	bh=9cIHticzt2GFyQKYbSO6P8Ywq9Bvf0zwzfAEYiZllRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3+iPn3Y+siA9yuBlY5+hH3JzkD1plhkJ61y/8pwOBhetVvN4hGIJrYUFpAn8i0o+klUoSAPCp7odJkdGp+9pqMp6LBJNEFKgp4PSyLELWpcm/sy1eVceo9Y9/z4OJo0oIjnTKvRlehirGFD8xL4YegIxVMHOfWUIj02HEP727Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NFWzxkVw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-152.bb.dnainternet.fi [81.175.209.152])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 7FF654B3;
	Fri, 16 Jan 2026 17:04:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1768579487;
	bh=9cIHticzt2GFyQKYbSO6P8Ywq9Bvf0zwzfAEYiZllRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFWzxkVw2rxdGRe5AWZLVeNP36YXK+f52kv2yRJIgUm248ipoBt2tFWyJHVx+zbS8
	 hcgH9abKquZItSj9xLzDtQ8BUcbozHmxOQcRooqZKhyQGAx47yTBkgysgweNrVMx9e
	 dIyQ3/RmAJfdW96pUnbR7pobQUDkn3jkkMtLmUUY=
Date: Fri, 16 Jan 2026 18:04:54 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 0/3] drivers/base: Introduce revocable
Message-ID: <20260116160454.GN30544@pendragon.ideasonboard.com>
References: <20260116080235.350305-1-tzungbi@kernel.org>
 <2026011607-canister-catalyst-9fdd@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026011607-canister-catalyst-9fdd@gregkh>

On Fri, Jan 16, 2026 at 04:17:29PM +0100, Greg KH wrote:
> On Fri, Jan 16, 2026 at 08:02:32AM +0000, Tzung-Bi Shih wrote:
> > The series is separated from [1] to show the independency and compare
> > potential use cases easier.  This is the revocable core part.  Use cases
> > are in other series.
> > 
> > The 1st patch introduces the revocable which is an implementation of ideas
> > from the talk [2].
> > 
> > The 2nd and 3rd patches add test cases for revocable in Kunit and selftest.
> > 
> > [1] https://lore.kernel.org/chrome-platform/20251016054204.1523139-1-tzungbi@kernel.org
> > [2] https://lpc.events/event/17/contributions/1627/
> > 
> > v7:
> > - Rebase onto next-20260115.
> 
> Thanks for sticking with this, I've queued this up in the driver-core
> testing branch for now, thanks!

I'd like to see this being successfully used before we merge it. There's
now one patch series for the GPIO subsystem, which I think is a very
good test case. Bartosz is already reviewing it, and there's a
performance issue that needs to be investigated and addressed.

As discussed during LPC, the UAF issue in the CrOS EC that this series
was initially supposed to fix is best solved with reference counting and
refactoring of the CrOS EC driver framework. The revocable mechanism
isn't the right solution for races between device removal and userspace
access.

-- 
Regards,

Laurent Pinchart

