Return-Path: <linux-kselftest+bounces-43894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC4C02689
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462C51AA673F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF212BE7C6;
	Thu, 23 Oct 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouN94J5y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14026E6EB;
	Thu, 23 Oct 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236408; cv=none; b=NVna9HPTEUhn0di7oydQjutxF2u1EH+u8Nguw7+FktU4DTZf/05WWC6sDkvyFQkJtRmQsg5FIM2xiG3GUqVgY7bLE/jMigGTd0N7zH9ozwZoDf2mRIzYYed2CF3AeHQhuEBIfxHMNMd7pmcd/ymOHR6GDza333sqE8LJ7c+t+XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236408; c=relaxed/simple;
	bh=RCMpf5k0vKyOi28zOMikq6SuumaOxpGBZ43eRqkUaFY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PNmzftYuHwWglcpPrsWaC8gSr+GC3+kZ+ZFlCXw4CGacEQPUeqrDjyqlF5T24oy6xAlSs+snLc8uL2qxk9+DFyEPfB8FdVA4IOIIDG8PBdDi5pZm9NSMHPHTUdj1GkUHSSUHVofVp9HnZRT8bZvziAShDzTM3D4yvqzM8W1Cvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouN94J5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2C3C4CEE7;
	Thu, 23 Oct 2025 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761236407;
	bh=RCMpf5k0vKyOi28zOMikq6SuumaOxpGBZ43eRqkUaFY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ouN94J5yzRIPyysjXVyJhG42R/fhm2bqspj7rmd99NQXp9V3XtD/hbhOJLrgLl8yW
	 IwxMxlo2YeGglYuu+DrdZ2h+pEEoPvGwNbFDtXBBjTtDGxPiO1PfZWpXVIGu8IShCH
	 SWHRx1hT7L+vgeNuR5eHouBDX1osHpreSEuirIDoR7IAe0OwS+G/L+nvGDd9wpsgKX
	 Xy/qWmCkh5SATThn3uUwNUd7yocANiTEkiVxTk1E4+EpQjyJMGsnuIubTwlr+vJsLQ
	 y0Vcn1/htl0br68bwokjCIfrhVrxjdYJMnDcyX8AHWA5Zh0cVhGKc1Hp0eMOUpT/gC
	 dVO7b5XG2eQRw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Oct 2025 18:20:02 +0200
Message-Id: <DDPU75QB8MQ6.3HZ5N0GYKQ9QU@kernel.org>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Tzung-Bi Shih"
 <tzungbi@kernel.org>, "Benson Leung" <bleung@chromium.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <shuah@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Dan Williams" <dan.j.williams@intel.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251017134916.GK3901471@nvidia.com>
 <aPJp3hP44n96Rug9@tzungbi-laptop> <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop> <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com> <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop> <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
 <20251023155746.GL262900@nvidia.com>
In-Reply-To: <20251023155746.GL262900@nvidia.com>

On Thu Oct 23, 2025 at 5:57 PM CEST, Jason Gunthorpe wrote:
> IMHO the rust code does it principally because the sync unregister
> life cycle model does not fit naturally into rust.

That's not the case.

In fact, we try to give as much "sync" guarantees as possible. For instance=
,
when a driver registers an IRQ the irq::Registration API enforces that the =
IRQ
is unregistered before the registering device is unbound.

As a consequence, the IRQ callback can provide a &Device<Bound>, which acts=
 as a
"cookie" that proves that for this scope (IRQ callback) the device is guara=
nteed
to be bound.

With this "cookie" we can then directly access device resources (such as I/=
O
memory) that is within a Devres (and hence a Revocable) container directly,
*without* any locking. I.e. we can safely bypass the Revocable and hence it=
s
overhead.

The idea is to utilize this pattern for every applicable scope, e.g. workqu=
eues /
work items, timers, IRQs, substems callbacks, IOCTLs, etc.

Only for scopes where no such guarantee can be given upheld, the caller act=
ually
has to go through the Revocable. And this is good, because it means the cal=
ler
is indeed in a scope where there is no guarantee that the device is not unb=
ound
concurrently.

So, what the Rust code aims at, is to guarantee correctness in either case.=
 But
in order to achieve that without unnecessary overhead, all the other APIs (=
e.g.
IRQ, workqueue, etc.) have to provide specific "sync" APIs playing along th=
e
driver model.

The difference between C and Rust here is mostly that the "safely bypass
Revocable" trick is only possible due to Rust's type system (and hence the
compiler) stopping people from doing it in an unsafe way. In C that's not
possible unfortunately.

