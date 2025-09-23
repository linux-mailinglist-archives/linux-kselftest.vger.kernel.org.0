Return-Path: <linux-kselftest+bounces-42138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2379AB94F4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 10:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E33C1898913
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8F131A041;
	Tue, 23 Sep 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8dFHt+U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75F3164C4;
	Tue, 23 Sep 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615624; cv=none; b=egBdADyRt8n1lEC+mcLSeFGea7gZaKBYJ1vqBo1gZTGrmZrL4hJcYntbn+IG7kxrEh93NAyWt4ZbgWsGk15ff82YI/6Dxn9kKdS8MeDXM80C3pWrbASQUwt+4x+N1l64Zvq5YZud9cBwgN4BZt2/3Gyc5+OaTLtnQD7LYkfQIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615624; c=relaxed/simple;
	bh=GJQLbdD9uiqaym9ws9AWWa5KXszOefHwRk8dn5Sgb0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tv5r+9IT9PDk4WDkIb1fuP6CGJUPeU2yekZrNBFYCVmvjMh0sfcXZtlhElQf0xkqcfpd0UWzsMUuIpzE1pOQnNF3Pq93qy1vB1xyIZUnhp7WCZWsU4KCYi04qTmBNdnntbp5Ky7Sj8VyDmHImkqDKhp2CM5UwLz4ahwjCJsXqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8dFHt+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FAAC4CEF5;
	Tue, 23 Sep 2025 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758615623;
	bh=GJQLbdD9uiqaym9ws9AWWa5KXszOefHwRk8dn5Sgb0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8dFHt+UbQroc9VfCdjYzVge53FGK1JqRZ5PUcmMcwCyx71mt72VBgD4OueJBfkYN
	 OhOz8W9kpjr65c2pUzOXpmZciIWflj7rA/LPdp4hn38Lf2qn80Vx+NKHbrp+6GOW7m
	 Iqh+yOhkwWvdmawUAivKs2I+Y213Q3+8Ekt9pK3VbCq7k73FZ2fBVftV2bVlmDRUjy
	 aWqfI47bNYM4aiABQUanEPQEOHhgi6PmZm42H1+l2rZOs7SjWaZ1l4B2Vc5j7GK5yf
	 YPt33cTf42JX9rts1R0cRHQb6OyTjmyKYRIGghAu2f0u5kOyazcfOupy5eO+Omu0KB
	 VB7+fLCaEPFow==
Date: Tue, 23 Sep 2025 08:20:18 +0000
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
Message-ID: <aNJYQs2MVjVujEEu@google.com>
References: <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <2025091237-cortex-carnage-5c34@gregkh>
 <CAMRc=Mf76m51VKktGc2K1uT4eacDqhsroRxG2RgtRyhQrhx0WA@mail.gmail.com>
 <20250912145416.GL31682@pendragon.ideasonboard.com>
 <aMWUAS9jReia0jhy@tzungbi-laptop>
 <20250913161413.GD4842@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913161413.GD4842@pendragon.ideasonboard.com>

On Sat, Sep 13, 2025 at 07:14:13PM +0300, Laurent Pinchart wrote:
> On Sat, Sep 13, 2025 at 11:55:45PM +0800, Tzung-Bi Shih wrote:
> > - Subsystems (like cdev) should build on this API to provide an easier
> >   interface for their drivers to manage revocable resources.
> > 
> > I'll create a PoC based on this.
> 
> I'm looking forward to that. Please let me know if there's anything you
> would like to discuss. I didn't dive deep in technical details in this
> thread, and I don't expect anyone to guess what I have in mind if I
> failed to express it :-) I'm very confident the cdev race condition can
> be fixed in a neat way, so let's do that.

Even though I think this isn't what you are looking for originally, please
take a look on the PoC attempt (5th - 7th patches) in [1].  Unlike [2], the
PoC allows fops to be exuected and defers to the driver to decide what to do
if the resource is unavailable.

[1] https://lore.kernel.org/chrome-platform/20250923075302.591026-1-tzungbi@kernel.org
[2] https://lore.kernel.org/all/161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com/

