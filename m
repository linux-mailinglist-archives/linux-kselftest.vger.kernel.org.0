Return-Path: <linux-kselftest+bounces-25243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D4A1DB1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 18:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373BE18838DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752B18952C;
	Mon, 27 Jan 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWyylYiz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB1157493;
	Mon, 27 Jan 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998295; cv=none; b=BGvNFL0bGNz0TdjOPdxwTe7C1Nh8JHfbbTt8yGoCSmeYGn13asefeuvy8/fp1DnQNoPjv2I7AkVZLTJrwk0sTXyUgym8P4OD6yPEg5HtECbkkdthztSXmvUz8OzNgGUfJ9LS0afH68i++WfDA0O0Kx+iSPxLF15yHgJTW6GKVdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998295; c=relaxed/simple;
	bh=WXIoF8kFaZqzhjJoVbCZJGk0IK+gZfCdqRxlUDEEYic=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=DAC1jx9AaBPPS9PL0jMPMiR+OsyFOC9PtZxJjm1p8eF0lEQBqLRMkfh42nRe1x7yCejOFesVjgvueC+hntPmSFKbTLy0twTLcfXFNPRMNKfXi9+pB+f3m/wD3KFXxeFsjpMCRKoyxwSHhV8sd5VyKolVrceucxE4r7ia2BBUrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWyylYiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C748C4CED2;
	Mon, 27 Jan 2025 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737998294;
	bh=WXIoF8kFaZqzhjJoVbCZJGk0IK+gZfCdqRxlUDEEYic=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hWyylYizOG4z8/rBPu/Oyb9Ddjseay59h4E3DuQWy9HaEqssoggTKcuqoZoWO91/s
	 tO66rmI6gBlT3N+T2INqMjxR61uqHWxWrMTxT6uHuU8Slf6SoNo8mprUoiIYkDvAkX
	 2jwwLER8xY6qIVubiGd+RRPGDPrOLcGP4EmxoAXHsYfkJwc9wiFfraRqbB8syNoWyO
	 od5VGn8B2V/gRCXccug4zlyO/Z+mp1MOOYzbMp9KIknDEpa8UkVoZ2Sts2rndAKrYe
	 M9t8in+sA21dlINYcTzzPoYyBQg5f8ElOP4jTRB2MXGNhU4mfelz/NcjhjyyAjgzIx
	 W/y0lEEqgQqpA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jan 2025 19:18:09 +0200
Message-Id: <D7D0Z3L6SBSF.1MSDA2G2MV3QZ@kernel.org>
Subject: Re: [PATCH v4] selftests: tpm2: create a dedicated .gitignore
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Khaled Elnaggar" <khaledelnaggarlinux@gmail.com>, <shuah@kernel.org>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>
Cc: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20250126142250.839019-1-khaledelnaggarlinux@gmail.com>
 <20250126195147.902608-1-khaledelnaggarlinux@gmail.com>
In-Reply-To: <20250126195147.902608-1-khaledelnaggarlinux@gmail.com>

On Sun Jan 26, 2025 at 9:51 PM EET, Khaled Elnaggar wrote:
> The tpm2 selftests produce two logs: SpaceTest.log and
> AsyncTest.log. Only SpaceTest.log was listed in selftests/.gitignore,
> while AsyncTest.log remained untracked.
>
> This change creates a dedicated .gitignore in the tpm2/ directory to
> manage these entries, keeping tpm2-specific patterns isolated from
> parent .gitignore.
>
> Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
> ---
> Oh no, I realized there was a mistake in v3. I wrote tpm2/*.log in the
> tpm2/.gitignore file, which is unnecessary since tpm2/.gitignore is
> already scoped to the tpm2 directory.
> All entries are automatically relative to the tpm2 directory.
>
> I=E2=80=99ve fixed it by removing the redundant tpm2/ prefix from the ent=
ries
> in tpm2/.gitignore.
>
> Apologies for not catching this earlier, I tested it after submitting
> the patch because I was confident v2 was correct, but the issue was
> introduced in v3.
>
> Thanks,
> Khaled
>
> Changes:
> v4: Correct the mistake in v3
> v3: Improve commit message (and introduce a mistake)
> v2: Created a dedicated .gitignore
> v1: https://lore.kernel.org/linux-kselftest/20250116085929.313677-1-eng.k=
haled.elnaggar@gmail.com
> ---
>  tools/testing/selftests/.gitignore      | 1 -
>  tools/testing/selftests/tpm2/.gitignore | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/tpm2/.gitignore
>
> diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests=
/.gitignore
> index cb24124ac5b9..674aaa02e396 100644
> --- a/tools/testing/selftests/.gitignore
> +++ b/tools/testing/selftests/.gitignore
> @@ -4,7 +4,6 @@ gpiogpio-hammer
>  gpioinclude/
>  gpiolsgpio
>  kselftest_install/
> -tpm2/SpaceTest.log
>
>  # Python bytecode and cache
>  __pycache__/
> diff --git a/tools/testing/selftests/tpm2/.gitignore b/tools/testing/self=
tests/tpm2/.gitignore
> new file mode 100644
> index 000000000000..910bbdbb336a
> --- /dev/null
> +++ b/tools/testing/selftests/tpm2/.gitignore
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +AsyncTest.log
> +SpaceTest.log
> +
> --
> 2.45.2

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

