Return-Path: <linux-kselftest+bounces-42073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D09B92154
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 17:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DBD7AB74C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D624B302148;
	Mon, 22 Sep 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3xad9+w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CD48CFC;
	Mon, 22 Sep 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556548; cv=none; b=cFEzSc5lY63IFeUIO1F2ZExz/y6DatoNijRYS1ciP/rAh9Haz/3j8KUdr3YW4ZWw65wBhIodtqycME6/cywAZ7DVDrxBjRR2avmDgeVKjbk2/nDwI1m9BXWVWQKpmKFhtZgd6pMVvsNNpThq8msEkwLqBdn+aiD4ZsuL5uTA2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556548; c=relaxed/simple;
	bh=JerfD2CXPVA7ixQHD/FykyLShgV2ysRS6+rq+iXw0b0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=BS3lrX8Kdn0DRY9AqGghiWJvYIiiaKLg/9XEsHWYxWOH4S6T50dD60cFr2a/xYaS2JRNfnHJljgpTkY/IvXg+Qxv7WdPU0kVx5184V4zeoYVwBv2DdlVLmNCr/dL8gZAPLr7ebLxlpfVcXRxBkU8zmXrWrSh9BylJQXchMBqOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3xad9+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1169C4CEF7;
	Mon, 22 Sep 2025 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758556548;
	bh=JerfD2CXPVA7ixQHD/FykyLShgV2ysRS6+rq+iXw0b0=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=U3xad9+w+MyWVhDs7wO3wNQSfBrhZXe+knEgo75Xu6QLh/n55u9BCsAAD84eX8omB
	 jECPqkDsYESZFK43L5f6icNH5/yLmfNXNx7KcBTZzb9PsufGlwGbq1YXzVEijiAP2t
	 G+rpPLlIyvJQhVLL3ebbsklHDQjiQ9IKYMAZfHnMusb5pU9C3e8b5KAavl46zIaLYw
	 HndNh02DAcQofAMtJbxV1uMzOB2NUymD1IGwE9FB1ataO2opx7QUngqf9pSvkuYDj8
	 DD2qMImsfx/88HKGWjv9Os6ThN5BaLe86gQ03hrJM10QfwP9GLT3xZY/QbCAbo0KRs
	 2+ft8vb1FHvbw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Sep 2025 17:55:43 +0200
Message-Id: <DCZG9N3QIRNP.1HUDPVL61FZVR@kernel.org>
Cc: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Bartosz Golaszewski"
 <brgl@bgdev.pl>, "Tzung-Bi Shih" <tzungbi@kernel.org>, "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Benson Leung" <bleung@chromium.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <shuah@kernel.org>, "Dawid Niedzwiecki" <dawidn@google.com>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Dan Williams"
 <dan.j.williams@intel.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via
 revocable
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <2033c6cd-4112-4c8a-a9ef-2ab34f3504b8@kernel.org>
 <CACMJSeuKH+WKOXLNU92dMssqhK02xG3z=cT0VeXYM+ZGuPCB9g@mail.gmail.com>
 <aMQW2jUFlx7Iu9U5@tzungbi-laptop>
 <20250912132656.GC31682@pendragon.ideasonboard.com>
 <2025091209-curfew-safari-f6e0@gregkh>
 <CAMRc=MfdoB50o=3Q2p94o+f7S2Bzr=TAtWWQcDrC5Wf3Q5nqAA@mail.gmail.com>
 <20250912135916.GF31682@pendragon.ideasonboard.com>
 <2025091220-private-verse-d979@gregkh>
 <20250912142646.GI31682@pendragon.ideasonboard.com>
 <20250922151040.GA2546062@nvidia.com>
In-Reply-To: <20250922151040.GA2546062@nvidia.com>

On Mon Sep 22, 2025 at 5:10 PM CEST, Jason Gunthorpe wrote:
> As was said later in this thread, it would be a real shame to see
> people implement revocable in drivers instead of rely on subsystems to
> have sane unregistration semantics where the subsystem guarentees that
> no driver callbacks are running after unregister. You never need
> driver revocable in a world like that.

I fully agree with that, in C there is indeed no value of a revocable type =
when
subsystems can guarantee "sane unregistration semantics".

I say "in C" because in C there is no way to get a proof by the compiler th=
at
we're in a scope (e.g. through the subsystem guarentee) where the device is
guaranteed to be bound (which we can in Rust).

So, effectively, we're not getting any value out of the revocable in C in s=
uch a
case: In the best case, we're just bypassing the revocable by accessing the
pointer unchecked (regardless whether that's valid or not); in the worst ca=
se
we're introducing a useless SRCU read side critical section.

(In Rust the compiler will stop us from accessing the pointer unchecked if =
we're
not in a scope where unchecked access is valid.)

So, I think in C revocable should be restricted to use-cases where scopes a=
re
unbound by design. DRM device callbacks are an example for that and it's th=
e
reason why things like drm_dev_{enter,exit}() and drm_dev_unplug() exist. I=
n the
end, those are exactly the same as revocable implemented in a slightly diff=
erent
way.

- Danilo

