Return-Path: <linux-kselftest+bounces-41391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1667B55028
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F971D629F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604130EF70;
	Fri, 12 Sep 2025 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UrU+X9FD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF642701C0;
	Fri, 12 Sep 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685586; cv=none; b=FtdppgfRZFecGM7antFyCctnAo+TdGnMFvve4qjQ3ahW3SZvczEJITId8usJZ8K5Hf89pkRRIXYd1e2e8WgHSXGBuD31NcR2inFe9lURqU14odd129z6Pyo49u5ZYcR5M7WsNdxxGMhd+qTac1fs+zRNF/hFOwSKBVl4ouSe520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685586; c=relaxed/simple;
	bh=G9RU8pqf54/5vuMI1yPvLacDTNLbF1FmLEXp604XgK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq0FlFR+Hc9hZQryY7g33E22PDKqCDmWWpP91igtNkcyQo2gjTZgh2iOpEOkzh42RkTPd4AaO45wpFkgzYMvPoC9fwmx4JwV19cehiXKm7D0MaBT8Gsgh9rGlhupU8oTNPTq8BrVAzgXkLCxUC0IGzL2ht+QvkU8/mZRlHhDErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UrU+X9FD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 9DC00ED;
	Fri, 12 Sep 2025 15:58:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757685506;
	bh=G9RU8pqf54/5vuMI1yPvLacDTNLbF1FmLEXp604XgK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrU+X9FDxorhe2X9h9OaavknEOicBw5R9Rv4QwWyrhDhdWRLUUvAnZXLTOTMhqbVS
	 r+NRpgAfMnRIYfBcrfQHQKpLuH9QUEMMlFdquGQiNEJhJ5svleibyGEELqQBJzjccu
	 NuHPGSqcs1ffOGzoRDhwR8LcRgGhCeR05jMD0V5o=
Date: Fri, 12 Sep 2025 16:59:16 +0300
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <20250912135916.GF31682@pendragon.ideasonboard.com>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
 <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>

On Fri, Sep 12, 2025 at 03:46:27PM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 12, 2025 at 3:39 PM Greg Kroah-Hartman wrote:
> >
> > I have no objection moving this to the cdev api, BUT given that 'struct
> > cdev' is embedded everywhere, I don't think it's going to be a simple
> > task, but rather have to be done one-driver-at-a-time like the patch in
> > this series does it.
> 
> I don't think cdev is the right place for this as user-space keeping a
> reference to a file-descriptor whose "backend" disappeared is not the
> only possible problem. We can easily create a use-case of a USB I2C
> expander being used by some in-kernel consumer and then unplugged.
> This has nothing to do with the character device. I believe the
> sub-system level is the right place for this and every driver
> subsystem would have to integrate it separately, taking its various
> quirks into account.

That's why I mentioned in-kernel users previously. Drivers routinely
acquire resources provided by other drivers, and having a way to revoke
those is needed.

It is a different but related problem compared to userspace racing with
.remove(). Could we solve both using the same backend concepts ?
Perhaps, time will tell, and if that works nicely, great. But we still
have lots of drivers exposing character devices to userspace (usually
through a subsystem-specific API, drivers that create a cdev manually
are the minority). That problem is in my opinion more urgent than
handling the removal of in-kernel resources, because it's more common,
and is easily triggerable by userspace. The good news is that it should
also be simpler to solve, we should be able to address the enter/exit
part entirely in cdev, and limit the changes to drivers in .remove() to
the strict minimum.

What I'd like to see is if the proposed implementation of revocable
resources can be used as a building block to fix the cdev issue. If it
ca, great, let's solve it then. If it can't, that's still fine, it will
still be useful for in-kernel resources, even if we need a different
implementation for cdev.

-- 
Regards,

Laurent Pinchart

