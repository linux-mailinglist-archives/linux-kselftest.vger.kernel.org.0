Return-Path: <linux-kselftest+bounces-9161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A88B81EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 23:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26511F24C83
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C192C1BED66;
	Tue, 30 Apr 2024 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6jz1MBb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2D50287;
	Tue, 30 Apr 2024 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512729; cv=none; b=IAway03HYEIelUf9cUZEJjJpZj4xMU2zBD6FFoqYAT0pCzTEYp+IhzYitAZaKpvhIXGJjv4gcds9AmLT3XWO/wz+1vvrQ5xXEnY05GibnAyqliC4P2O/DsypM+dNG7dUwMHtPHl+XhJFEAq8ml/AuGK8+slKau2eyE4pftUpIlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512729; c=relaxed/simple;
	bh=0XERCxExItXvCPVmz8dhoEKm4od93+XH9ZJUKA96nVo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Gl1iIab6fwdi8cuL2MuTq+s/UOJlfw9eRoaneJrICLEsr1WjojkCLRSh6Sr9fp6PdG9IY+u4P36jDD5lxV3VwdIQYVFJHssSFHZNJZbY3lo1Sj8vM+jPU9TGkAPityaDr9TnQwm4UHbFYh3Z1DO/bYyk03DUj0TL42RcWLsccqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6jz1MBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C3AC2BBFC;
	Tue, 30 Apr 2024 21:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714512729;
	bh=0XERCxExItXvCPVmz8dhoEKm4od93+XH9ZJUKA96nVo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=a6jz1MBbBTG6dEOQBfUsybX5JwqSqqyFhDkzQBjD8f8tNWPu/slUJBXK+Gp/9TBrN
	 KWoXkNEHxbnFBfsqrww5JC8m6Gc/IibVzICdzpAwq/3x1Lm3Pad8TYxT66/vqjP2eW
	 ErgUlnk4ifCetqKSqFjHdnNF6TrfRGUV1jlvsoJLIfo9Hak6sRekWAktleNjXt962f
	 Jx06e3h+aMmGFo53Vc0RkR8rg41c+r13Gh3nmo4/UD1bEC8EFXluqvPncvF4SY0hMr
	 nHxiqufOOLfk2sBDSFfSmqrSaIsiDsh18e6Em/5S7ClgJOqXcFuOkQUElwDVHog/0Y
	 ybWFNi85j15NQ==
Message-ID: <9f4323025c9d25313ecf26327848fc62.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <128dc42a50bfe166993205108a5b23cd.sboyd@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-6-sboyd@kernel.org> <128dc42a50bfe166993205108a5b23cd.sboyd@kernel.org>
Subject: Re: [PATCH v4 05/10] platform: Add test managed platform_device/driver APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Tue, 30 Apr 2024 14:32:06 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-04-24 11:11:21)
> Quoting Stephen Boyd (2024-04-22 16:23:58)
> > diff --git a/drivers/base/test/platform_kunit.c b/drivers/base/test/pla=
tform_kunit.c
[...]
> > +
> > +       /*
> > +        * Wait for the driver to probe (or at least flush out of the d=
eferred
> > +        * workqueue)
> > +        */
> > +       wait_for_device_probe();
>=20
> Should this be removed? I was thinking that this isn't a pure wrapper
> around platform_driver_register() because it has this wait call.  Maybe
> it's better to have some other kunit API that can wait for a specific
> device to probe and timeout if it doesn't happen in that amount of time.
> That API would use the bus notifiers and look for
> BUS_NOTIFY_BOUND_DRIVER. Or maybe that function could setup a completion
> that the test can wait on.

I have an implementation that does this that I'll send.

