Return-Path: <linux-kselftest+bounces-41394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9467EB5519E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 16:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536215C12C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37B3148B8;
	Fri, 12 Sep 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="j94keYI5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8F3191BF;
	Fri, 12 Sep 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687236; cv=none; b=nPoU45HObdXD34g4Bz9wb/jCREiNf8QVSr6Qy7021sKDcSwytev0E6d04yV+93E8HJZrZ1PHPo2P6RGFA2Wd/lgIojdOz4y1APxEfE2Y24TOCrWHfYO2Np5nKn4cKb2kRo9uyvUS7veEvf0fKRu+Qt7E4CUJjRd37iac4HFy0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687236; c=relaxed/simple;
	bh=s4x1fq+9gTDWN/WvRg4NU7rlFYdnurWYObuojRZ1FfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1OkDBONVqxI8/B4VRJFTwU3tlEQ5a51UI8Wz6GIZFBwXP49Rg00DqRRvDk/LLUQQxEbak+JTvC9gFv2quuw4PdMp66YyCzCKCFWSNHrI+38ATym7WS1TJ79u4Mpr+k/2OcG3JVPsc0G3t72W8dq8TcX4xPEnmq6/BOwJEtlQ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=j94keYI5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id F270FC7A;
	Fri, 12 Sep 2025 16:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757687157;
	bh=s4x1fq+9gTDWN/WvRg4NU7rlFYdnurWYObuojRZ1FfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j94keYI5n9BkRegb0rDwI1XkRuVaR8acEz7lF/iOzyNGDuAsbPOKq4Pjs27HTHHnk
	 x0hBOcij8mMRK2/2ta23wTwV9fVBF0Xh83U50fADOXrA9JyUo7TN01lUDiMBrqFVmb
	 Yn21J+ZiTKoOrQcK9MbgSz3Jo26gFp0pd53YdP4A=
Date: Fri, 12 Sep 2025 17:26:46 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Tzung-Bi Shih <tzungbi@kernel.org>,
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
Message-ID: <20250912142646.GI31682@pendragon.ideasonboard.com>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
 <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025091220-private-verse-d979@gregkh>

(CC'ing Dan Williams)

On Fri, Sep 12, 2025 at 04:19:53PM +0200, Greg KH wrote:
> On Fri, Sep 12, 2025 at 04:59:16PM +0300, Laurent Pinchart wrote:
> > On Fri, Sep 12, 2025 at 03:46:27PM +0200, Bartosz Golaszewski wrote:
> > > On Fri, Sep 12, 2025 at 3:39 PM Greg Kroah-Hartman wrote:
> > > >
> > > > I have no objection moving this to the cdev api, BUT given that 'struct
> > > > cdev' is embedded everywhere, I don't think it's going to be a simple
> > > > task, but rather have to be done one-driver-at-a-time like the patch in
> > > > this series does it.
> > > 
> > > I don't think cdev is the right place for this as user-space keeping a
> > > reference to a file-descriptor whose "backend" disappeared is not the
> > > only possible problem. We can easily create a use-case of a USB I2C
> > > expander being used by some in-kernel consumer and then unplugged.
> > > This has nothing to do with the character device. I believe the
> > > sub-system level is the right place for this and every driver
> > > subsystem would have to integrate it separately, taking its various
> > > quirks into account.
> > 
> > That's why I mentioned in-kernel users previously. Drivers routinely
> > acquire resources provided by other drivers, and having a way to revoke
> > those is needed.
> > 
> > It is a different but related problem compared to userspace racing with
> > .remove(). Could we solve both using the same backend concepts ?
> > Perhaps, time will tell, and if that works nicely, great. But we still
> > have lots of drivers exposing character devices to userspace (usually
> > through a subsystem-specific API, drivers that create a cdev manually
> > are the minority). That problem is in my opinion more urgent than
> > handling the removal of in-kernel resources, because it's more common,
> > and is easily triggerable by userspace. The good news is that it should
> > also be simpler to solve, we should be able to address the enter/exit
> > part entirely in cdev, and limit the changes to drivers in .remove() to
> > the strict minimum.
> > 
> > What I'd like to see is if the proposed implementation of revocable
> > resources can be used as a building block to fix the cdev issue. If it
> > ca, great, let's solve it then. If it can't, that's still fine, it will
> > still be useful for in-kernel resources, even if we need a different
> > implementation for cdev.
> 
> Patch 5/5 in this series does just this for a specific use of a cdev in
> the driver.  Is that what you are looking for?

Not quite, I would like to see the enter/exit (aka revocable scope if my
understanding is correct) being pushed to char_dev.c, as Dan did in [1].
I'm fine having to add an extra function call in the .remove() path of
drivers, but I'm not fine with having to mark revocable sections
manually in drivers. That part belongs to cdev.

[1] https://lore.kernel.org/r/161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com

-- 
Regards,

Laurent Pinchart

