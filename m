Return-Path: <linux-kselftest+bounces-41307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C331B54746
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFBEB4E2BFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24592DC335;
	Fri, 12 Sep 2025 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gNutyQue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60992DA767;
	Fri, 12 Sep 2025 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668837; cv=none; b=p8APtMlxtUUX/yuT1KnPlpJ7nbB6ArbbpAcfwBHuUGO39M8FquYA71uI2oD1ty/3tpmQuc/5cyCavWRHyHoou02aJzKTGc02yQ6uib9K9zg75GZ11pDF6aFiyyzK8RfsKHla+oKcMkfzh+YU2Ih5KyAB8nGL7V81n+jOulluxQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668837; c=relaxed/simple;
	bh=/JBv9g/ms0yohE1VAUeM82qVVVJ8bxxHWCzB9dcxlBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBVtiANuW3PWM+v03re6GBkP+ePuxnMdcomKv8i7XB+F9UTyZwtYQMJBCF0HVGJu4TGMu89AyIbXjys0BndiFmfVZ460qWz4rg/vi6vMldw/60jy3HbsQzHP2YNGzx6JhaynhVs/B2AnZiRSCiniotohQ2L9aYmH/5pff0YVZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gNutyQue; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id D20BF316;
	Fri, 12 Sep 2025 11:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757668751;
	bh=/JBv9g/ms0yohE1VAUeM82qVVVJ8bxxHWCzB9dcxlBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNutyQuemxqbWsIBz45xg51ZkZ8GFlGv69YP4FBeMEraRdCMeOIiZrmZ7yacQ0Qm3
	 Sstyhs34olXMD0BSmFURfYLxSaIMVwbwG6Yl29vyM48OyQJpop7bYSczlJ1oo3IxF9
	 3UFSr3AEWKGYpkS9yJO5+ATlYDz3B9DA2VSzc9LE=
Date: Fri, 12 Sep 2025 12:20:00 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Message-ID: <20250912092000.GA31682@pendragon.ideasonboard.com>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <2025091224-blaming-untapped-6883@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025091224-blaming-untapped-6883@gregkh>

On Fri, Sep 12, 2025 at 10:30:45AM +0200, Greg KH wrote:
> On Fri, Sep 12, 2025 at 08:17:12AM +0000, Tzung-Bi Shih wrote:
> > This is a follow-up series of [1].  It tries to fix a possible UAF in the
> > fops of cros_ec_chardev after the underlying protocol device has gone by
> > using revocable.
> > 
> > The 1st patch introduces the revocable which is an implementation of ideas
> > from the talk [2].
> > 
> > The 2nd and 3rd patches add test cases for revocable in Kunit and selftest.
> > 
> > The 4th patch converts existing protocol devices to resource providers
> > of cros_ec_device.
> > 
> > The 5th patch converts cros_ec_chardev to a resource consumer of
> > cros_ec_device to fix the UAF.
> > 
> > [1] https://lore.kernel.org/chrome-platform/20250721044456.2736300-6-tzungbi@kernel.org/
> > [2] https://lpc.events/event/17/contributions/1627/
> > 
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> This is, frankly, wonderful work.  Thanks so much for doing this, it's
> what many of us have been wanting to see for a very long time but none
> of us got around to actually doing it.
> 
> And it has tests!  And documentation!  Couldn't ask for more.
> 
> We can bikeshed about the REVOCABLE() macro name, but frankly, you wrote
> it, you get to pick it :)
> 
> Laurent, Bartosz, Wolfram, any objection to this series?  I think this
> addresses the issues that all of you have been raising for years with
> our access of pointers that have different lifecycles from other
> structures (i.e. struct cdev from struct device).

I'll check this either later today or over the weekend.

> Also, Danilo, if you get the chance, can you give this a review as well?
> At first glance it looks good to me, but as you wrote the Rust
> implementation of this feature, a second pair of eyes would be great to
> have if you have the time.

-- 
Regards,

Laurent Pinchart

