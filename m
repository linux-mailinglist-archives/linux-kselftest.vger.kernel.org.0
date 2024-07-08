Return-Path: <linux-kselftest+bounces-13316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813FB92A54F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 17:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002C1B216B3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7D13B588;
	Mon,  8 Jul 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRRSeseX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD281745;
	Mon,  8 Jul 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450840; cv=none; b=sfqZV5fIbJOxmKYhblhZ/zflsubHCBnrU0Vt9kIriPFA6E8wZhOnFcjtLlrnYs0KhU46AwYDD7wHryqsYFCklpxpefDA43f7ItuLDlI1RgtQPWy7cK8CizjS/5v8+m1y52hZkm+03pmTnLMScFQkO3hr5bgLNcnEj+bsalT2Hhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450840; c=relaxed/simple;
	bh=9tWDZ4ouMiehsT9Ap8iEFsMYys+iRi1AtI6U10gq75A=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PgisXtpRaeUfDxXJzEzABWT2vfhUTyQUt8Ux230z31PPJFUBYXZRrmfbud8j2tGHYOkwPkpiphCuHEKhr4WH6GKu5KLH69XZ9lQWJbodTP9DBK5kENNTL1fHEEpx3ArgJD+V/SL86wjbYsevkZCk4mid3xgVRbyu1dgM2ScXWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRRSeseX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0639AC116B1;
	Mon,  8 Jul 2024 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720450840;
	bh=9tWDZ4ouMiehsT9Ap8iEFsMYys+iRi1AtI6U10gq75A=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=SRRSeseX86QpkhoGOvxnidA5zEKA1zYTMbJ9+HDGCgSyN0TMtinPbB/FThsSrLhSL
	 BMSSQLCwIn0oeShZxtPRRltz9DHvXNv0GY5/MbKZ+lugr/ZpTmuEZSoccSDR8GvMJ/
	 C4ewt01hkpw/7t3GaMYtZhj4atsLRRzYErAMkPGmB/J9CVbQcQndP+GGqUOjnYGDK6
	 0EoiDGwMDW23b0vU5tNbieJ2DRuwg2AgWgJMKdnZPTfPbK08RR+qsUsaMQsDMvgraj
	 Z/vPF2m1zhpVRGLE6zTKqFOxb9AUY/tIeq+G1Bcanv8x/Ij4Icif+mMIU0qmrngX2a
	 nXDuH4IOCqURw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Manu Bretelle <chantra@meta.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
In-Reply-To: <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
References: <20240705145009.32340-1-puranjay@kernel.org>
 <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
Date: Mon, 08 Jul 2024 15:00:31 +0000
Message-ID: <mb61pjzhwvshc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 7/5/24 4:50 PM, Puranjay Mohan wrote:
>> fexit_sleep test runs successfully now on the CI so remove it from the
>> deny list.
>
> Do you happen to know which commit fixed it? If yes, might be nice to have it
> documented in the commit message.

Actually, I never saw this test failing on my local setup and yesterday
I tried running it on the CI where it passed as well. So, I assumed that
this would be fixed by some commit. I am not sure which exact commit
might have fixed this.

Manu, Martin

When this was added to the deny list was this failing every time and did
you have some reproducer for this. If there is a reproducer, I can try
fixing it but when ran normally this test never fails for me.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZov/EBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nd39AP9EBMWza1kS6tLoAj30iwUT8Rq62Spe
uPJ3oe/ze53tMQEAw96OjLRvasQ6jnDH9Igoh1iUcLlnsR6LnZ5TvEpO9gQ=
=mXSa
-----END PGP SIGNATURE-----
--=-=-=--

