Return-Path: <linux-kselftest+bounces-41399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB2CB5526C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4F918814CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A8310640;
	Fri, 12 Sep 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Poi03rC9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D11930AAC1;
	Fri, 12 Sep 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688885; cv=none; b=RLlcUc0CzL2keiOQUQp2dSZ5r7VucntC2dYhb+REb2IxX5HvLGZdAYSg6JgFrzzxYzQTPmDmCfaqqE7ovd+gLuxsErd/Rn/uDkxZRtXbH0bKKEpbigR1d8gaxfPzNSu86i/zTXm9f/EMhTNLWz5qHx1WiBsubZnyqsC/rMHNN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688885; c=relaxed/simple;
	bh=ydsp6RhR8/lKm4KttxBfx02lnxjVwj7uaEeFn2snxvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9xSW4lVkwNWGAl9EOsSomrb9fiwGtPKx2ACrsHuHuWmQE3s0PvnB2KxFiDB1sje+LhCTajLa/ir82ALFFD2rwsqxHGJGvuGx8OxrdnwufNYV1TtfLypiD+U3vfEar7hhoLg8djK7eQ2O9WD+/VKcfQs+lt016yhcDUQw3+AEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Poi03rC9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id A449A2C5;
	Fri, 12 Sep 2025 16:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757688806;
	bh=ydsp6RhR8/lKm4KttxBfx02lnxjVwj7uaEeFn2snxvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Poi03rC9VRNs/Iz6xYQCg8nnXadndVy0tLilmzoY5vogefJIKNKbWgFlsq4i3Aifh
	 p3dUrnYAPyHZ+7Zh5ucrTiaLzf53sP4EV2DLZ1PTZgIQ2xA5arRxcLnxKtIO3ltNBu
	 c6lpZjlk1HLfhdoVu1wd82guOTc9vhkX35iUUB5I=
Date: Fri, 12 Sep 2025 17:54:16 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
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
Message-ID: <20250912145416.GL31682@pendragon.ideasonboard.com>
References: <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <2025091237-cortex-carnage-5c34@gregkh>
 <CAMRc=Mf76m51VKktGc2K1uT4eacDqhsroRxG2RgtRyhQrhx0WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf76m51VKktGc2K1uT4eacDqhsroRxG2RgtRyhQrhx0WA@mail.gmail.com>

On Fri, Sep 12, 2025 at 04:44:56PM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 12, 2025 at 4:40 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Dan's proposal here is a good start, but the "sleep in cdev_del() until
> > the device drains all existing opens" is going to not really work well
> > for what we want.
> >
> > So sure, make a new cdev api to use this, that's fine, then we will have
> > what, 5 different ways to use a cdev?  :)
> >
> > Seriously, that would be good, then we can work to convert things over,
> > but I think overall it will look much the same as what patch 5/5 does
> > here.  But details matter, I don't really known for sure...
> >
> > Either way, I think this patch series stands on its own, it doesn't
> > require cdev to implement it, drivers can use it to wrap a cdev if they
> > want to.  We have other structures that want to do this type of thing
> > today as is proof with the rust implementation for the devm api.
> 
> Yeah, I'm not against this going upstream. If more development is
> needed for this to be usable in other parts of the kernel, that can be
> done gradually. Literally no subsystem ever was perfect on day 1.

To be clear, I'm not against the API being merged for the use cases that
would benefit from it, but I don't want to see drivers using it to
protect from the cdev/unregistration race.

> Tzung-Bi: I'm not sure if you did submit anything but I'd love to see
> this discussed during Linux Plumbers in Tokyo, it's the perfect fit
> for the kernel summit.

-- 
Regards,

Laurent Pinchart

