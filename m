Return-Path: <linux-kselftest+bounces-49181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB0D339EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 18:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B634E30141E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDDB34A79D;
	Fri, 16 Jan 2026 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLJJjvkm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9D346A05;
	Fri, 16 Jan 2026 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582827; cv=none; b=hsKynySaMMYbJA1ce1/3BGtYCp0BlOMNxB6pMpRCbjtoV/eiEdogo8tdozkK6sYlskkd4j4J+t8/OE5UMGQLoS/nhZHRyc5NlO6XIr/FIRQebtnKLLifxhmjfeZ9ENdUYHqiikF8bGdHIvUbtdPo+BziNOum0lIzLc2b92Y/glw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582827; c=relaxed/simple;
	bh=cUHbTcgJAxojCEY9JsqBn/5z9xu/8gBW2Ewuq94yzRc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UL5xZFujS8AxOipe15OCghG20AtOY2qKaZODlcWBchttGhOcMM/krUTZRTL2b/lpJxIKhzLiXgxViGq+IsI1cyeaMRL896Np55vaFOEr6mvWEcAx4rOg2rLetKxMDWUPkjdlEz8rn4c2CkIvZE7AFVOhE6C4ZuhiRx4L5MRKFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLJJjvkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F28C116C6;
	Fri, 16 Jan 2026 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768582826;
	bh=cUHbTcgJAxojCEY9JsqBn/5z9xu/8gBW2Ewuq94yzRc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=BLJJjvkmyFiYeAoUVSL86BZTMVcvt0LEYJkO6n1iG6LKfSjl8MD3ULm/XVl1aPUiC
	 VWV23G607BrODNRFDyIM+tjPWPPtV6lgGNDIL+AcKWAga/9Ft2PUhCJCIyNUGxSUHh
	 vb5ZlHwlfPsUTNiwC5wY4KMEyW5yNf5+MZl+80q22gw4/PKOVWwTJw6kB3XnZJwh8S
	 m7cD43GvLH54Yg0KF5sXulfuiRGZUDv5aJtHhmDfLkL0ayzNznKZILZWI/qabkMX8w
	 u9l8bZ4I6k3qyxl53BwvUE20n+enN/l+R+l2y5LrcQqtEHeboypfvZb+lPjndXBw0J
	 c2+9Wd6bHHtNw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 18:00:21 +0100
Message-Id: <DFQ6ABRP8U2W.GZP8XMBPDO8Q@kernel.org>
Subject: Re: [PATCH v7 0/3] drivers/base: Introduce revocable
Cc: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Tzung-Bi Shih"
 <tzungbi@kernel.org>, "Benson Leung" <bleung@chromium.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>, "Linus
 Walleij" <linusw@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <shuah@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Dan Williams" <dan.j.williams@intel.com>,
 <linux-gpio@vger.kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260116080235.350305-1-tzungbi@kernel.org>
 <2026011607-canister-catalyst-9fdd@gregkh>
 <20260116160454.GN30544@pendragon.ideasonboard.com>
 <DFQ5D44A0348.PZJIGPL972N@kernel.org> <20260116165242.GO961588@nvidia.com>
In-Reply-To: <20260116165242.GO961588@nvidia.com>

On Fri Jan 16, 2026 at 5:52 PM CET, Jason Gunthorpe wrote:
> The C code doesn't really work like that, it works on sync teardown
> flows. If you want to write correct C code you need to think about all
> the concurrency the driver has and ensure that removal undoes it

Again, it depends: Sometimes a synchronized teardown is not possible. Iff a
synchronized teardown is not possible by design, this is where revocable is
useful instead.

However, a synchronized teardown should of course always be preferred.

And just to clarify, since you said "the C code": The Rust code follows exa=
ctly
the the same principle, prefer synchronized teardown whenever possible.

(The only difference with Rust is that we can always guard device resources=
 and
iff synchronized teardown is ensured through the type system the guard beco=
mes
zero-cost for accesses.)

