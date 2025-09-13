Return-Path: <linux-kselftest+bounces-41443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03017B56233
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 18:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C141B27493
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94A2EFD8C;
	Sat, 13 Sep 2025 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D9cVwgnS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5AB1DD0D4;
	Sat, 13 Sep 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757780083; cv=none; b=Vt4Sh0Rt7a/i5mfBniKItrPoxdUydajXc3alYwJUb7I/tyFvW88BEysiAIiA7HRAkw71qUiCPWP5Uott4z6jVfRJQit8wCWVRDKeCMKNHZMivuEz7KvxQR5KyiSLXpNnntawM2dpC+9X3hXvSvzPHwzTDtPxu8cZqF8cfYOFjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757780083; c=relaxed/simple;
	bh=yw6hVo2eumofbhBuwHy6ZPCV+Gf7iwqnwjcPthzTDPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKbiO8B3d+GeL213ERzSFRzzM5V0IOK5qV26xJRjedDZ+2xfZ21srFhCByzgk1ClSxMqPyq/qO0na5HV/kt0GvvnOrl8BsHPrTnHRiYKgKBcLrCJ3a6Apj7FiGTwxhzWvdENM/LlQOkl0ZaoSxd/TiUK2bGEu5CIR7k3HOivKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=D9cVwgnS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id D12ADA8F;
	Sat, 13 Sep 2025 18:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757780003;
	bh=yw6hVo2eumofbhBuwHy6ZPCV+Gf7iwqnwjcPthzTDPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9cVwgnSOgqYAY+przSs7V6zlxUfj+RAGi3ett/ajOdBmXGOHAsdaxiUJCiWg7LUX
	 T/8CseTkZbTgcskguptd0giRI+Tk5NIL+oazAew1w5WxUi43iEaPKuPVNapETyddr6
	 o1QZHMpievQHUwkdS/blHl2AzjVKelWB5BBrUh2U=
Date: Sat, 13 Sep 2025 19:14:13 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20250913161413.GD4842@pendragon.ideasonboard.com>
References: <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <2025091237-cortex-carnage-5c34@gregkh>
 <CAMRc=Mf76m51VKktGc2K1uT4eacDqhsroRxG2RgtRyhQrhx0WA@mail.gmail.com>
 <20250912145416.GL31682@pendragon.ideasonboard.com>
 <aMWUAS9jReia0jhy@tzungbi-laptop>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMWUAS9jReia0jhy@tzungbi-laptop>

On Sat, Sep 13, 2025 at 11:55:45PM +0800, Tzung-Bi Shih wrote:
> On Fri, Sep 12, 2025 at 05:54:16PM +0300, Laurent Pinchart wrote:
> > On Fri, Sep 12, 2025 at 04:44:56PM +0200, Bartosz Golaszewski wrote:
> > > On Fri, Sep 12, 2025 at 4:40 PM Greg Kroah-Hartman wrote:
> > > >
> > > > Dan's proposal here is a good start, but the "sleep in cdev_del() until
> > > > the device drains all existing opens" is going to not really work well
> > > > for what we want.
> > > >
> > > > So sure, make a new cdev api to use this, that's fine, then we will have
> > > > what, 5 different ways to use a cdev?  :)
> > > >
> > > > Seriously, that would be good, then we can work to convert things over,
> > > > but I think overall it will look much the same as what patch 5/5 does
> > > > here.  But details matter, I don't really known for sure...
> > > >
> > > > Either way, I think this patch series stands on its own, it doesn't
> > > > require cdev to implement it, drivers can use it to wrap a cdev if they
> > > > want to.  We have other structures that want to do this type of thing
> > > > today as is proof with the rust implementation for the devm api.
> > > 
> > > Yeah, I'm not against this going upstream. If more development is
> > > needed for this to be usable in other parts of the kernel, that can be
> > > done gradually. Literally no subsystem ever was perfect on day 1.
> > 
> > To be clear, I'm not against the API being merged for the use cases that
> > would benefit from it, but I don't want to see drivers using it to
> > protect from the cdev/unregistration race.
> 
> Based on the discussion thread, my main takeaways are:
> 
> - Current `revocable` is considered a low level API.  We shouldn't (and
>   likely can't) stop drivers, like the one in patch 5/5 in the series,
>   from using it directly to fix UAFs.

Why shouldn't we ? We have enough precedents where driver authors rushed
to adopt brand new APIs without understand the implications.
devm_kzalloc() is a prime example of a small new API that very quickly
got misused everywhere. If we had taken the time to clearly explain when
it should be used and when it should *not* be used, we wouldn't be
plagued by as many device removal race conditions today. Let's not
repeat the same mistake, I'd like this new API to make things better,
not worse.

> - Subsystems (like cdev) should build on this API to provide an easier
>   interface for their drivers to manage revocable resources.
> 
> I'll create a PoC based on this.

I'm looking forward to that. Please let me know if there's anything you
would like to discuss. I didn't dive deep in technical details in this
thread, and I don't expect anyone to guess what I have in mind if I
failed to express it :-) I'm very confident the cdev race condition can
be fixed in a neat way, so let's do that.

> > > Tzung-Bi: I'm not sure if you did submit anything but I'd love to see
> > > this discussed during Linux Plumbers in Tokyo, it's the perfect fit
> > > for the kernel summit.
> 
> Yes, and I just realized that in addition to the website submission, a
> separate email is also required (or at least encouraged).  I've just sent
> that email and am hoping it's not too late.

-- 
Regards,

Laurent Pinchart

