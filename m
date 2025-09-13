Return-Path: <linux-kselftest+bounces-41444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5DB56237
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 18:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC686A072D7
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501BE1E1DEC;
	Sat, 13 Sep 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wNMSHU64"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C11DF759;
	Sat, 13 Sep 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757780268; cv=none; b=pHldtz0OIiIP3vs0Dl9bGqOsC+kpa1unrJMjCs7VgpSh6nXL6d3C4W42HWevQjrekKqAfJ6mmv3XWwOaJoYS8WFFTfPSE7w83s5+vVzhx+qCGHkssBiSEmTRQveI4Kzpd2CbeAdAtlcyRowQkHAXaSAmbOZ8/Rbb+Wbot8a296Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757780268; c=relaxed/simple;
	bh=zlxQWlkD1ONTYqI34/X3jQ4cO7pVTeDGFdZZ5vZv0no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zaydm5n4bWH+e/rr4NajhFoCrIbXQBL/WkIJIdtDKRSNIXQTPxV58WRsM0NRZKtglIX3PRw1xPBPukyw5G2gsoEbv4vhT901usAMVRFx3WkJoh9nuUNNKbL/ShMp3Y4xIKPtDYgUxJg+7tNsZZq1gmWmjn76hC/d48sTxacsUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wNMSHU64; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 39A44A8F;
	Sat, 13 Sep 2025 18:16:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757780187;
	bh=zlxQWlkD1ONTYqI34/X3jQ4cO7pVTeDGFdZZ5vZv0no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wNMSHU64CpeuCvvCv5wDHMMqvq8YnZtlhBlNDH7umSdVM03pjKJNkLiEmGmKbXR0f
	 hozTd4PfMVTC/NZ3VHtRdX/IlVKIyJYhOc5bf1V1Q0amA6V1gQeFKIb0bRnzW5Tx1c
	 5fLgSOxIQniI8v9oHeQCem2VmNM3pICUx+SRyhVs=
Date: Sat, 13 Sep 2025 19:17:17 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <20250913161717.GE4842@pendragon.ideasonboard.com>
References: <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <2025091237-cortex-carnage-5c34@gregkh>
 <CAMRc=Mf76m51VKktGc2K1uT4eacDqhsroRxG2RgtRyhQrhx0WA@mail.gmail.com>
 <20250912145416.GL31682@pendragon.ideasonboard.com>
 <1dc06657-e136-45c2-8012-9199194bfc9b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dc06657-e136-45c2-8012-9199194bfc9b@kernel.org>

On Fri, Sep 12, 2025 at 06:22:48PM +0200, Danilo Krummrich wrote:
> On 9/12/25 4:54 PM, Laurent Pinchart wrote:
> > On Fri, Sep 12, 2025 at 04:44:56PM +0200, Bartosz Golaszewski wrote:
> >> On Fri, Sep 12, 2025 at 4:40 PM Greg Kroah-Hartman wrote:
> >>> Either way, I think this patch series stands on its own, it doesn't
> >>> require cdev to implement it, drivers can use it to wrap a cdev if they
> >>> want to.  We have other structures that want to do this type of thing
> >>> today as is proof with the rust implementation for the devm api.
> >>
> >> Yeah, I'm not against this going upstream. If more development is
> >> needed for this to be usable in other parts of the kernel, that can be
> >> done gradually. Literally no subsystem ever was perfect on day 1.
> > 
> > To be clear, I'm not against the API being merged for the use cases that
> > would benefit from it, but I don't want to see drivers using it to
> > protect from the cdev/unregistration race.
> 
> I mean, revocable is really a synchronization primitive in the end that
> "revokes" access to some resource in a race free way.
> 
> So, technically, it probably belongs into lib/.
> 
> I think the reason it ended up in drivers/base/ is that one common use case is
> to revoke a device resource from a driver when the device is unbound from this
> driver; or in other words devres is an obvious user.
> 
> So, I think that any other API (cdev, devres, etc.) should  be built on top of it.

No issue with that. I'm sure there are people who have better knowledge
than me when it comes to implementing the low-level primitive in the
most efficient way. What I have lots of experience with is the impact of
API design on drivers, and the API misuse (including through cargo-cult
programming) this can generate. Let's design the API towards drivers
correctly.

> This is also what we do in Rust, Revocable is just a common synchronization
> primitive and the (only) user it has is currently Devres building on top of it.

-- 
Regards,

Laurent Pinchart

