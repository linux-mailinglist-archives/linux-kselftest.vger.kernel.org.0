Return-Path: <linux-kselftest+bounces-41440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB97B56214
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 17:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC9C56400C
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECF32EDD64;
	Sat, 13 Sep 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcKXmzhT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773EC2765D9;
	Sat, 13 Sep 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778952; cv=none; b=A2NguPjWTYTail2pEemljr3ccVlUoY6yPw+RM49Ci5DCyzbKWD8EVvpElwY17HiG3ECnTQUagAfpwHp2ZkEtSQVFwNEho8kMTq6NTAhjPi2cUjfsFGfvOmAhmwS2/2N0GkibgEo38BgNABakhtCHWeyr1iE+ZYPDZzTO6LHuGP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778952; c=relaxed/simple;
	bh=8EotSpc3a7iilL0C4StGG7T8TjUZb4j02ECZxhjqBig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATP8p5oMPr2AzGRc5DoCvse3uBMmhzOyXdn6k5MuE1psBhlHMN+PXHqtCAMoDJPUwoQNXxdZt71HWL2A3XC4nVlyzYB5lqoK9EJUqcJf7yxoKwELQBV5jToXf0ofbacJoAw9gaE2lQrkkyW07hHl03CVDxrgvz/d5zhDjQaaxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcKXmzhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D601C4CEEB;
	Sat, 13 Sep 2025 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757778952;
	bh=8EotSpc3a7iilL0C4StGG7T8TjUZb4j02ECZxhjqBig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcKXmzhTsvpV07D5ufJDGqAPkPmWf7cYFthdf5CW1jMkKIo2pVABW/LCRruhanBpT
	 g+ES/ReT0+/dg4uQVw5gtxys3QpazTAzQ8KmURptcUT6wMeXdCbA/1jxZcdtm9G86N
	 RC/bUuuPNnhO1IYow6N6IZz8EyOUCqt3HgrXOtrRUdlP0Ukcyf7DUj1QS059bKuzAG
	 XGyJuFZu3DqYW8NPq+WRhdMH+FM2QzLzSQyQcumIGsw0icV6s9fmjxfYjHOKxuySmY
	 N+rZEY1prqdMaEX8u+hoY61Q9NjR5DXTfhOdhlbNf5SjdrBoERdMyxeDPAJMvvVG0V
	 eqYSlPhOg78mA==
Date: Sat, 13 Sep 2025 23:55:45 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <aMWUAS9jReia0jhy@tzungbi-laptop>
References: <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <2025091237-cortex-carnage-5c34@gregkh>
 <CAMRc=Mf76m51VKktGc2K1uT4eacDqhsroRxG2RgtRyhQrhx0WA@mail.gmail.com>
 <20250912145416.GL31682@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912145416.GL31682@pendragon.ideasonboard.com>

On Fri, Sep 12, 2025 at 05:54:16PM +0300, Laurent Pinchart wrote:
> On Fri, Sep 12, 2025 at 04:44:56PM +0200, Bartosz Golaszewski wrote:
> > On Fri, Sep 12, 2025 at 4:40 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > Dan's proposal here is a good start, but the "sleep in cdev_del() until
> > > the device drains all existing opens" is going to not really work well
> > > for what we want.
> > >
> > > So sure, make a new cdev api to use this, that's fine, then we will have
> > > what, 5 different ways to use a cdev?  :)
> > >
> > > Seriously, that would be good, then we can work to convert things over,
> > > but I think overall it will look much the same as what patch 5/5 does
> > > here.  But details matter, I don't really known for sure...
> > >
> > > Either way, I think this patch series stands on its own, it doesn't
> > > require cdev to implement it, drivers can use it to wrap a cdev if they
> > > want to.  We have other structures that want to do this type of thing
> > > today as is proof with the rust implementation for the devm api.
> > 
> > Yeah, I'm not against this going upstream. If more development is
> > needed for this to be usable in other parts of the kernel, that can be
> > done gradually. Literally no subsystem ever was perfect on day 1.
> 
> To be clear, I'm not against the API being merged for the use cases that
> would benefit from it, but I don't want to see drivers using it to
> protect from the cdev/unregistration race.

Based on the discussion thread, my main takeaways are:

- Current `revocable` is considered a low level API.  We shouldn't (and
  likely can't) stop drivers, like the one in patch 5/5 in the series,
  from using it directly to fix UAFs.

- Subsystems (like cdev) should build on this API to provide an easier
  interface for their drivers to manage revocable resources.

I'll create a PoC based on this.

> > Tzung-Bi: I'm not sure if you did submit anything but I'd love to see
> > this discussed during Linux Plumbers in Tokyo, it's the perfect fit
> > for the kernel summit.

Yes, and I just realized that in addition to the website submission, a
separate email is also required (or at least encouraged).  I've just sent
that email and am hoping it's not too late.

