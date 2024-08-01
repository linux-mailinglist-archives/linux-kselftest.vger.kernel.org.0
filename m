Return-Path: <linux-kselftest+bounces-14686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD07194547D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 00:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696C22840B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 22:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0669814AD32;
	Thu,  1 Aug 2024 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzbEJp8X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60414C5A3;
	Thu,  1 Aug 2024 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722551011; cv=none; b=j0W64tKYDsUwM44ag++407LppQOWwJ68Kyxu2dF0p7mhXirm/ZAEEgi+N3F9CnjalixKZ5Oth6QltYrLkU845yuisS2X3nF+Kai31KKdKZjK5c8UzRdQF8rDRzX4lyGaPWjg7328V9R6wcN+WySYtZkVSvszTtny7MCxmN7UdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722551011; c=relaxed/simple;
	bh=9lhcZ+Mg0UsWcEQls/neRcetHzKfFUUKCzmmMQTu4oI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=griiSXX3SHjDnxpE3qzTGNd4MQCFIFHTmy+IznhlwblVSY5q36+MMgnuty4xSgfiKlIlTLbrYC3u+q3IYwMvJLRVoRRh0WR4zw7Tw5k3ZTeT2SyEfNpvmRrakn+dFQRBJhazvmQiSoARWZDacK8XBBAJVn+E8DbrzHm0efx4Z9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzbEJp8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD7AC32786;
	Thu,  1 Aug 2024 22:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722551010;
	bh=9lhcZ+Mg0UsWcEQls/neRcetHzKfFUUKCzmmMQTu4oI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=NzbEJp8XsM6b5gxeCANjYD0NG7kEBefsLbK+bU7MUBDkkbPUabtEsbKrQ8MXkdN65
	 r0vcg9wO+rKvRjVtgrqt0Ja0HhC4XYgwaOAUaq4dVTpuC6My7kM/u7/zlXkW+mbjRK
	 WWQ/dgZKqZ8X3ck0GUmEmAOUWShnV301OXc4WdJ3uy52X5gx5EbhPQ46J7QxkcBx1U
	 O8KuUsu3LKbTWNgIYv97+cDA8ZrITiDhEmtaLGWUDxRvPR1THJbnFauwVNgtOtK1KX
	 BFhlAk4Pc2HFwUJdM9pHQBjxu47TiNfI8+XiGdcSS3go+yAEL7G4Ono982xhmKA0j0
	 a2W7ZLWq4xF/A==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Aug 2024 01:23:27 +0300
Message-Id: <D34XDC7E4AQM.1H8PBFSF9VKPM@kernel.org>
To: "Muhammad Usama Anjum" <usama.anjum@collabora.com>, "Shuah Khan"
 <shuah@kernel.org>
Cc: <kernel@collabora.com>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: tpm2: redirect python unittest logs to
 stdout
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240710081539.1741132-1-usama.anjum@collabora.com>
 <47ea7423-3aae-4bb3-a41f-1fcb5c07e74b@collabora.com>
In-Reply-To: <47ea7423-3aae-4bb3-a41f-1fcb5c07e74b@collabora.com>

On Wed Jul 31, 2024 at 4:42 PM EEST, Muhammad Usama Anjum wrote:
> Reminder
>
> On 7/10/24 1:15 PM, Muhammad Usama Anjum wrote:
> > The python unittest module writes all its output to stderr, even when
> > the run is clean. Redirect its output logs to stdout.
> >=20
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> >  tools/testing/selftests/tpm2/test_async.sh | 2 +-
> >  tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
> >  tools/testing/selftests/tpm2/test_space.sh | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/tpm2/test_async.sh b/tools/testing=
/selftests/tpm2/test_async.sh
> > index 43bf5bd772fd4..cf5a9c826097b 100755
> > --- a/tools/testing/selftests/tpm2/test_async.sh
> > +++ b/tools/testing/selftests/tpm2/test_async.sh
> > @@ -7,4 +7,4 @@ ksft_skip=3D4
> >  [ -e /dev/tpm0 ] || exit $ksft_skip
> >  [ -e /dev/tpmrm0 ] || exit $ksft_skip
> > =20
> > -python3 -m unittest -v tpm2_tests.AsyncTest
> > +python3 -m unittest -v tpm2_tests.AsyncTest 2>&1
> > diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing=
/selftests/tpm2/test_smoke.sh
> > index 58af963e5b55a..20fa70f970a9a 100755
> > --- a/tools/testing/selftests/tpm2/test_smoke.sh
> > +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> > @@ -6,4 +6,4 @@ ksft_skip=3D4
> > =20
> >  [ -e /dev/tpm0 ] || exit $ksft_skip
> > =20
> > -python3 -m unittest -v tpm2_tests.SmokeTest
> > +python3 -m unittest -v tpm2_tests.SmokeTest 2>&1
> > diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing=
/selftests/tpm2/test_space.sh
> > index 04c47b13fe8ac..93894cbc89a80 100755
> > --- a/tools/testing/selftests/tpm2/test_space.sh
> > +++ b/tools/testing/selftests/tpm2/test_space.sh
> > @@ -6,4 +6,4 @@ ksft_skip=3D4
> > =20
> >  [ -e /dev/tpmrm0 ] || exit $ksft_skip
> > =20
> > -python3 -m unittest -v tpm2_tests.SpaceTest
> > +python3 -m unittest -v tpm2_tests.SpaceTest 2>&1

I was on holiday for four weeks so thus the latency. And also
mbsync failed on me for sometime:

https://social.kernel.org/notice/AkX1oAnWFMXja3uN84

Anyway, agreeing with the code changes but I think this
categorizes as a bug so please add the fixes tag and send
v2.

BR, Jarkko

