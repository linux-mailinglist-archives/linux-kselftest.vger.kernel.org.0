Return-Path: <linux-kselftest+bounces-37778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 367EBB0CBDF
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 22:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658AD7B0610
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 20:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E694C23BF9E;
	Mon, 21 Jul 2025 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmql/4N5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6475238C21;
	Mon, 21 Jul 2025 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130007; cv=none; b=OTpopedD8YcgBdUv8FLaIO3utQymWH+64zcYm7lhD6ubARFf6Q+F8jlreF5Q7Qifv6HfA6PtYmBDnAVvz6g+TCRAQ7PsgYTsXwGxRdVgcTq2D8iDNUUDbg56BOdflL+7T9u57fuf9Di08RZilEUWF/75ZekXwhBwyVOejf7uUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130007; c=relaxed/simple;
	bh=NkElqSwao4iqS7o3LqdWn2vxjTj6xjtIto9GSbXCCUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKOA/bNdylrC0Shhcs8p9x2gV4BaxSOHacl89HHZpOb6zQyAYqq0KHqoCC5EnOP2g4wBM2Mv+uix/jN87lX3mJCBconZK7IsTpxoGt7lNlrvJuIYTcd+uBa4vfNRiWEk484dWymY9ICGKJnLrUs4JRWdRWUcIe9/YofcbmkpjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmql/4N5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AE6C4CEED;
	Mon, 21 Jul 2025 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753130007;
	bh=NkElqSwao4iqS7o3LqdWn2vxjTj6xjtIto9GSbXCCUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rmql/4N57BK1Zo7FOFbT340tlIQIjV7l0g1tU3+GZsZ7Qn5xSbYr0byGj8risLuwa
	 tymrLiMydZlBAfONMHKcV1ngQDThmnKsdGaIs2IxyAhxkynOlXe6kp8J2yVr2uyd2a
	 WphCzcbjl7uhtvlbK6EaB0iNM7R2CUNc9/AMgRcTxQ0USef24eT6fTkSXk8JAgkv88
	 ptxl8AxJTwxxXTMr0VXuj2A+8WiP6oirOywWN5m2UritGQiq9U+wlCASXnJ/OhKRTU
	 ZGPEkSJPK/gBWAdMqGTEvtkazVj2mxbZAfyYflmLFRqn7YISs/gl+s1PdRXVqYaoIo
	 SqzTmopklmEtQ==
Date: Mon, 21 Jul 2025 13:33:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Nimrod Oren <noren@nvidia.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 tariqt@nvidia.com, thoiland@redhat.com
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
Message-ID: <20250721133325.73e2f076@kernel.org>
In-Reply-To: <eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
	<20250719083059.3209169-3-mohsin.bashr@gmail.com>
	<ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
	<20250721084046.5659971c@kernel.org>
	<eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

IOn Mon, 21 Jul 2025 21:34:05 +0300 Gal Pressman wrote:
> > That's a reasonable way to modify the test. But I'm not sure it's
> > something that should be blocking merging the patches.
> > Or for that matter whether it's Mohsin's responsibility to make the
> > test cater to quirks of mlx5,  =20
>=20
> Definitely not a quirk, you cannot assume the headers are in the linear
> part, especially if you're going to put this program as reference in the
> kernel tree.
>=20
> This issue has nothing to do with mlx5, but a buggy XDP program.

We put the tests in the tree to foster collaboration. If you think the
test should be improved please send patches. I don't think the kernel
will allow pulling headers if they are not in the linear section.
But that's your problem to solve.

> > which is not even part of NIPA testing -
> > we have no way of knowing what passes for mlx5, what regresses it etc. =
=20
>=20
> People have been developing XDP code that runs on mlx5 long before NIPA
> even existed =F0=9F=A4=B7=E2=80=8D=E2=99=82=EF=B8=8F..
> And as you know we run these selftests on mlx5 hardware, as evident by
> Nimrod's mail, and others you've seen on the list. You know what regresse=
s.

No, please don't try to dispute facts. It's not integrated, if you go
on a vacation upstream will have no idea what broke in mlx5. Either you
are reporting the results upstream or our guarantees on regressions are
best effort. BTW I don't understand how you can claim that a new test
regresses something. It never passed on mlx5 =3D=3D not a regression.

