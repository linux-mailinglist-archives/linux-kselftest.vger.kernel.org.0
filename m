Return-Path: <linux-kselftest+bounces-7599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C998A019C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 23:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8061F237AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 21:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77501836CD;
	Wed, 10 Apr 2024 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+GJ0ywW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB5181CFD;
	Wed, 10 Apr 2024 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782865; cv=none; b=W0Zbid/xIpbxyd3tFGSsHtg3Ho7hma8fJlIublxEq+KBSm5Mi+AUqT84BZbyiwRIvE4govrUZo5csYEllEJy5LyhQk/ySxNJaJgH7GiCNnBnG530MjqwFzkFHYhlwh3Fl2g2lZw+iAuam9BCYy3DMxBm+S9F0kcAOARirOnYtcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782865; c=relaxed/simple;
	bh=0mbDdh1VgA0HikjDit6mP3k8bIiQefAVr44m4J85reE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNj30zJKasVALuR6SUaUpZIZVw1aRGysnajMpXS+BKSzHgOOAIG718dSFrJfe/Khv/L2O7jGcZnFNEavHI/xlyWiFC8vMjWArwNPgbE1xeB3EZI/cpzlkmnesK7TZUd3P20Yf3E9tYj5avDtz4j4PMj6Dld8lr4CqkdbRSEkEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+GJ0ywW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2EEC433F1;
	Wed, 10 Apr 2024 21:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782865;
	bh=0mbDdh1VgA0HikjDit6mP3k8bIiQefAVr44m4J85reE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e+GJ0ywWdumna/ZzmdZUmItZZPy9+Qb5dfzVzmby505VF7JHvfE0p9/Pg7GqiST/N
	 q2GgNQi3zta//NkVx3XszQofIrcGLZlqcrd20crUFGYRaTxyHMjurSuYyRBxPeP6bM
	 VkyDkakOxWus1QB+Gqox/ulKLT+CIq/rw40xs29yyJmFqR7fke3LD8R/aKIs+diXR0
	 JZVgCCtzpOhASrdLu8hDKIvwLu0VXyqw/OfcjetUwkJNEfPyaKnpIOV+ICwf1VJvrg
	 ySVxFy+ezHWqtjmB0ZDKRxLYNH7BT4AS9qnmfw6SzrjCejvU7qT6I4OHWxDWhxKdC1
	 A2cqYGZ8Oejag==
Date: Wed, 10 Apr 2024 14:01:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH net-next v2 0/2] mptcp: add last time fields in
 mptcp_info
Message-ID: <20240410140103.37b94193@kernel.org>
In-Reply-To: <b8c14751-37a9-4a3d-b9af-a5c697d34781@kernel.org>
References: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
	<20240410113452.56f156f4@kernel.org>
	<b8c14751-37a9-4a3d-b9af-a5c697d34781@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 21:31:13 +0200 (GMT+02:00) Matthieu Baerts wrote:
> > Hi Mat, is this causing skips in selftests by any chance?
> >
> > # 07 ....chk last_data_sent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [SKIP] Feature probably not s=
upported
> > # 08 ....chk last_data_recv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [SKIP] Feature probably not s=
upported
> > # 09 ....chk last_ack_recv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [SKIP] Feature probably no=
t supported =20
>=20
> Yes it does, I should have added a note about that, sorry: that's because
> SS needs to be patched as well to display the new counters.
>=20
> https://patchwork.kernel.org/project/mptcp/patch/fd9e850f1e00691204f1dfeb=
c63c01c6a4318c10.1711705327.git.geliang@kernel.org/
>=20
> This patch will be sent when the kernel one will be accepted.

I see, applied locally now, thanks!

> Is it an issue? The modification of the selftests can be applied later
> if you prefer.

Not sure. If it doesn't happen super often maybe co-post the iproute2
patch as described:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#co-post=
ing-changes-to-user-space-components
and I'll apply it on the worker machines manually.

> Earlier today, I was looking at changing NIPA not to mark the whole
> selftest as "SKIP" but I saw it was not a bug: a check is there to
> mark everything as skipped if one subtest is marked as skipped
> from what I understood. So I guess we don't want to change that :)

Correct :) It's working as intended :)

> > I'll "hide it" from patchwork for now..
> > --
> > pw-bot: defer =20
>=20
> Thank you! Do you prefer if I resend only patch 1/2 for now?

No need, restored the patches back, let's see if next run is clean.

