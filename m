Return-Path: <linux-kselftest+bounces-49175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 644EFD336E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1768D30204A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E2B3933ED;
	Fri, 16 Jan 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmIKgcBK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511AA34321C;
	Fri, 16 Jan 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580224; cv=none; b=elgQdBsO9iHVJMiuBthgSwF958wH1GUFn5FDeFdapDFbPllsCoJ5flQMdOr2ug0QKKJr13mE+HImnOpok4mGYGpYoSARdf+qtrlWHBvtfcKTpkQ6Hp/HhefU0waZjL0WrPRY5xcg/qaW3TdFsmRGF8b2Y8cPNNfIu5fhm88I65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580224; c=relaxed/simple;
	bh=9/IqOIuR0wghb2xxUwKZ7bfAHoBpGQx/s+4r5yZUbbI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=aMLm3u3BVnVEME/93Ihz6AU0CA9WZjEAGFunGmEdK+bfrixlR3CYii/BsFa5EBB1kcGtAeKz1cym02umtQHowa5TSwG+0hQ3oLt8PnnBWZlJMCXnwOdEaMhg0kYly4cl503lgDZ15RcQAVPDfyb0t17cIZmOzuvvlE/F9oGcdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmIKgcBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D560C116C6;
	Fri, 16 Jan 2026 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768580224;
	bh=9/IqOIuR0wghb2xxUwKZ7bfAHoBpGQx/s+4r5yZUbbI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pmIKgcBKAyDD6MdFI1gj8GRB3viZ0Ya+nb3ts1XDtHnRLF6tCoqBH0vUi5wrLAdPu
	 kSRkDlnewoLaryaZavvMvLmJOjKJmv299m/gFMtcCOSsyvHBmNeCp/pRuMa9BnOcXZ
	 U08sARGv9YLOccNvC6+uKIpJgQtRO/JZUYiKsVoUdVO64TcnYBvGS9/eYtL6RNA6TC
	 8sLfX6d5nNVt31o8XoJ22JAfQiOY5axPKQB+Ljmn6t0/Ca+/zZjhJRAfMNTUFpPJ2m
	 1m4qmCWcaa0k+cXLRVela5J2FOH6kc+5NxF2VuqJ4J/1l5DTLBzGZPykH5KidTtO+k
	 2w2z4jDVLNMWg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 17:16:58 +0100
Message-Id: <DFQ5D44A0348.PZJIGPL972N@kernel.org>
Subject: Re: [PATCH v7 0/3] drivers/base: Introduce revocable
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Tzung-Bi Shih"
 <tzungbi@kernel.org>, "Benson Leung" <bleung@chromium.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>, "Linus
 Walleij" <linusw@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <shuah@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Dan Williams" <dan.j.williams@intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, <linux-gpio@vger.kernel.org>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260116080235.350305-1-tzungbi@kernel.org>
 <2026011607-canister-catalyst-9fdd@gregkh>
 <20260116160454.GN30544@pendragon.ideasonboard.com>
In-Reply-To: <20260116160454.GN30544@pendragon.ideasonboard.com>

On Fri Jan 16, 2026 at 5:04 PM CET, Laurent Pinchart wrote:
> The revocable mechanism isn't the right solution for races between device
> removal and userspace access.

I think you have to differenciate, as it depends on the resource:

If the resource is a device resource (e.g. MMIO resource regions) that must=
 not
be held by the driver after its bound device has been unbound, you have to
revoke the resource from the driver, i.e. you can't just fix it with a refe=
rence
count.

Effectively, that's what devres does, it releases the resource when the dev=
ice
is unbound. Revocable takes care of avoiding a UAF of a subsequent access.

We subsystems that invented subsystem specific implementations for a revoca=
ble
mechanism for exactly those cases.

For instance, there is drm_dev_enter() drm_dev_exit() and drm_dev_unplug() =
which
ultimately does the same things as DRM specific implementation.

If the resource is not a device resource, then revocable is clearly not the
correct solution however.

