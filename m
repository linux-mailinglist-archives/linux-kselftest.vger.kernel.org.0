Return-Path: <linux-kselftest+bounces-43444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC21BEBD54
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 23:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A0A189B3FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 21:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB2285C88;
	Fri, 17 Oct 2025 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ui97tMPp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24523184A;
	Fri, 17 Oct 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760737322; cv=none; b=iDRM2MSscX6UZX5SQBp8SjedLVbUNpg92ESBlBN+Tcz9czY0ocP3Iry3gcjjvYNQixK5lZVXlm4JbnrqkwU5g0OKU93gLUE62GrRWiYtNEBGM/bw5atiQcjVTwhTPqKDNl02lJKRCAMaFGYqV7v8BG7up76zPFDZUkyMd5onA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760737322; c=relaxed/simple;
	bh=NLiqceOlHQmsom02gVpkpbYtvUKxr7b4ZoMng8qNyLg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=EhzmpDf0Ek4pQGKWj13sgbB7jRFM6VOkKALeih5T3PaTBU/cN/7dRZVp9pyGLdEY7Rwr6UQvx0BJ9o7v4b64TVwBd/4a1lTtV8rtuhBl8TskykvB5Ph3+3Uh0T7Shne3+ZLyM0gzXyv15ovH1+J1dS0WefPvnknKAMlw41c7nps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ui97tMPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC11C4CEE7;
	Fri, 17 Oct 2025 21:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760737321;
	bh=NLiqceOlHQmsom02gVpkpbYtvUKxr7b4ZoMng8qNyLg=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=Ui97tMPpQpzMT2zJyaSneZDqt7EWGTXci0QQOmYDl+1bF/roKz2+P/3IJ3uaq0KYR
	 WRvAeFREUYF9Y86L02m42uolFqVWFYFQRHTQYCxpUwcozWm9VCaORQKif2+H+958Ut
	 1pFdz2Dk1CspwKzAwO2HDQDIGlAo9hPbdt/mtRU0kAN2qkKeYeV980O5RzKRS2V0Pt
	 c15lwC0EOfqz19uExbgmMmJAE0zUZwIgYtfG0Uds+Kh2XEUDNnjUG04rHTJklAntC2
	 siIpq1e8AbDlDCYinLisEq/ZJGxaT/8GNQ8qxCG41HIKyTA+Vhe9mPoKrocQXlH+L1
	 VkR642d1SbcdA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 23:41:56 +0200
Message-Id: <DDKXACTUJ9IT.3W11J2HE7SLJW@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Cc: "Tzung-Bi Shih" <tzungbi@kernel.org>, "Benson Leung"
 <bleung@chromium.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>, "Bartosz
 Golaszewski" <brgl@bgdev.pl>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Dan Williams" <dan.j.williams@intel.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
 <20251016123149.GA88213@nvidia.com> <aPGryj-V5PQZRtoI@google.com>
 <20251017134916.GK3901471@nvidia.com> <aPJp3hP44n96Rug9@tzungbi-laptop>
 <009c8e5e-02d3-4017-bb84-e3a8f01b9dc9@kernel.org>
 <20251017163738.GB316284@nvidia.com>
 <bee969ed-c050-43a4-961c-07443a45943c@kernel.org>
 <20251017184415.GE316284@nvidia.com>
In-Reply-To: <20251017184415.GE316284@nvidia.com>

On Fri Oct 17, 2025 at 8:44 PM CEST, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 08:19:06PM +0200, Danilo Krummrich wrote:
>> On 10/17/25 6:37 PM, Jason Gunthorpe wrote:
>> > On Fri, Oct 17, 2025 at 06:29:10PM +0200, Danilo Krummrich wrote:
>> >=20
>> >> I'm not sure about MISC device though. Unless there's a good reason,
>> >> I think MISC device should be "fenced" instead.
>> >=20
>> > misc is a very small wrapper around raw fops, and raw fops are
>> > optimized for performance. Adding locking that many important things
>> > like normal files don't need to all fops would not be agreed.
>> >=20
>> > The sketch in this series where we have a core helper to provide a
>> > shim fops that adds on the lock is smart and I think could be an
>> > agreeable way to make a synchronous misc and cdev unregister for
>> > everyone to trivially use.
>>=20
>> Sure, for MISC devices without a parent for instance there are no device
>> resources to access anyways.
>
> There are many situations with misc that can get people into trouble with=
out
> parent:
>
>  misc_deregister(x);
>  timer_shutdown_sync(y);
>  kfree(z);
>
> For example. It is is buggy if the fops touch y or z.
>
> This is why a _sync version is such a nice clean idea because with 5
> letters the above can just be fixed.
>
> Wrapping everything in a revocable would be a huge PITA.

That's a bit of a different problem though. Revocable clearly isn't the
solution. _sync() works, but doesn't account for the actual problem, which =
is
that the file private has at least shared ownership of y and z.

So, it's more of an ownership / lifetime problem. The file private data sho=
uld
either own y and z entirely or a corresponding reference count that is drop=
ped
in fops release().

Device resources are different though, since we can't just hold on to them =
with
a reference count etc.; they're strictly gone once the bus device is unboun=
d,
hence revocable when there is no _sync().

