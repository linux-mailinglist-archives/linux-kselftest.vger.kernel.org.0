Return-Path: <linux-kselftest+bounces-49174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D745D33673
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75E0E300BDB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C209F340A47;
	Fri, 16 Jan 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ii24Bfjf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FC3659F5;
	Fri, 16 Jan 2026 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579675; cv=none; b=S6SoPi5GlYwXaM04EhIYUdkR7gbjl8smN8114Uifo6TkVEDy1t326JJEQzieDnBPHTO++D99G//H7i6gTRkoUmWg4V1itRXeYBwSsb5Ydhl0T6CZtciveHtVtZQJwIc0UrhwaHUCj201m0SkEjmHSPG7CoP5ZV6m+DgvZ81fA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579675; c=relaxed/simple;
	bh=iIesWXspKO6nFyAnU3Sr60itWBC7KswTVNpE9lMv+DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL0IzHoqFllz5xVFEILCioFzjlh4gbqG+xesuRlbp0YqUstsmCo30aQBgyDxs0JfpeHlz9O24FYAoIHUDkzkp7Ou7yr0ymyByYhiynOfENnw+RmTs9XcjqIaFauQXDN4vIOsXwYiW+9FEodAvPfgjwxIhr3Jv/SFx1AsPcy6QRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ii24Bfjf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-152.bb.dnainternet.fi [81.175.209.152])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 256A63D7;
	Fri, 16 Jan 2026 17:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1768579642;
	bh=iIesWXspKO6nFyAnU3Sr60itWBC7KswTVNpE9lMv+DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ii24BfjftykyogDCfXdpjyUVwB3Mlh/J500JnEmdNK4grQ9JOl6QJ1RIEypPmPtcp
	 yJ/2wc38TDbknsdKepHxER0AVo7tU7BhyFMwQ+v+8zMI4HwQPEa33SC6+e+9Rw6isU
	 aN7LMTxgs0+k6gHhYQF05zkwquzovNu7gTmF/wZM=
Date: Fri, 16 Jan 2026 18:07:29 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 00/23] gpiolib: Adopt revocable mechanism for UAF
 prevention
Message-ID: <20260116160729.GB14499@pendragon.ideasonboard.com>
References: <20260116081036.352286-1-tzungbi@kernel.org>
 <CAMRc=MdOCvEb81k0whM9dGCE8Hp=tdxZTUuiFeiL3+WsEei9EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdOCvEb81k0whM9dGCE8Hp=tdxZTUuiFeiL3+WsEei9EQ@mail.gmail.com>

On Fri, Jan 16, 2026 at 11:35:00AM +0100, Bartosz Golaszewski wrote:
> On Fri, Jan 16, 2026 at 9:11 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
> >
> > This series transitions the UAF prevention logic within the GPIO core
> > (gpiolib) to use the 'revocable' mechanism.
> >
> > The existing code aims to prevent UAF issues when the underlying GPIO
> > chip is removed.  This series replaces that custom logic with the
> > generic 'revocable' API, which is designed to handle such lifecycle
> > dependencies.  There should be no change in behavior.
> >
> > This series depends on the 'revocable' API, introduced in [1].  Some
> > build bots may report errors due to undefined symbols related to
> > 'revocable' until the dependency is merged.
> >
> 
> Hi Tzung-Bi!
> 
> Thank you for doing this and considering my suggestions from LPC. I
> haven't looked at the code yet but I quickly tested the series with my
> regular test-suites. The good news is: nothing is broken, every test
> works fine. The bad news is: there seems to be a significant impact on
> performance. With the user-space test-suite from libgpiod (for core C
> library - gpiod-test) I'm seeing a consistent 40% impact on
> performance. That's not really acceptable. :( I will try to bisect the
> series later and see which part exactly breaks it.

Also, as discussed during LPC, revocable is not the right mechanism to
handle races between device removal and userspace access through cdev.
It could however be a good tool to handle races between producers and
consumers inside the kernel. I'll try to review this series to see if it
also addresses the latter.

> I can also help you with user-space testing with libgpiod, if you need
> it? Some documentation is available here:
> https://libgpiod.readthedocs.io/en/latest/testing.html
> 
> > [1] https://lore.kernel.org/chrome-platform/20260116080235.350305-1-tzungbi@kernel.org
> >
> > Tzung-Bi Shih (23):
> >   gpiolib: Correct wrong kfree() usage for `kobj->name`
> >   gpiolib: cdev: Fix resource leaks on errors in gpiolib_cdev_register()
> >   gpiolib: Fix resource leaks on errors in gpiochip_add_data_with_key()
> >   gpiolib: Fix resource leaks on errors in lineinfo_changed_notify()
> >   gpiolib: cdev: Correct return code on memory allocation failure
> >
> > => The first 5 patches are fixes.  They aren't directly related to the
> >    replacement, and should be able to apply independently.
> >
> 
> Awesome, I'll make them a priority.
> 
> >   gpiolib: Access `gpio_bus_type` in gpiochip_setup_dev()
> >   gpiolib: Remove redundant check for struct gpio_chip
> >   gpiolib: sysfs: Remove redundant check for struct gpio_chip
> >   gpiolib: Ensure struct gpio_chip for gpiochip_setup_dev()
> >   gpiolib: cdev: Don't check struct gpio_chip in gpio_chrdev_open()
> >
> > => The following 5 patches are refactors.  Makes the subsequent changes
> >    easier or at least clear.
> >
> >   selftests: gpio: Add gpio-cdev-uaf tests
> >
> > => The following patch adds kselftest cases for some classic UAF
> >    scenarios.
> >
> 
> Thanks, these too look like v7.0 material for me. I'll try to review
> these ASAP too.

-- 
Regards,

Laurent Pinchart

