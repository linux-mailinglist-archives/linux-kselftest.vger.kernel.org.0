Return-Path: <linux-kselftest+bounces-19360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA48D997167
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781651F296BD
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187E1E0DD4;
	Wed,  9 Oct 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLqwNoVN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309F1E04B5;
	Wed,  9 Oct 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490901; cv=none; b=QCE7nOwPUg0meTbS4nOJpzBdKNh2kLvRJJ4+E2El/D6h2jQb7LIaZAY56flXTcIQG/+CPU+ZAjT/BJ9LvpJow0bDmDhpMBoWx6IiWq+I+eQEJq8X6+5Q0uF9iowCxUvz0qcuqfuZNTU+0k75/7kZiDXbNSzeXNeMddP8+Ao5aLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490901; c=relaxed/simple;
	bh=G8QnFXEwN9p8AEXQN6J3L68kS1BkNHs26s8ufdLC5vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5BO97ZZzHkDFYhVIP9wUKuhA6xMTI18OSDfoBFmquEDSVvFFliN4J2CNpMHSOMdjzy5YpAqC3rvakruRBKPYjkgVbQEQQTiWGZNs5zIxgRtClmRWXEddM9fXdBCQM8M+WJeyNmCmft8oxbcb2dOr4f07v+GZPbTdQmSEaJIyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLqwNoVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516A4C4CEC3;
	Wed,  9 Oct 2024 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728490900;
	bh=G8QnFXEwN9p8AEXQN6J3L68kS1BkNHs26s8ufdLC5vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLqwNoVNYkmN9GMvy2D/6dIedLXX6m7noGHpLKCw+UMctZnY5iF/edxLaOgpSfkWF
	 8+D1bPF7CYXe3Qv0I40u4D0qMUcil6W3OrMg7oh/P+Nu8/fOFYjctnXfS6pS/73+f6
	 V56iFAJ7TZSH3vAKNKADZVzgcQ4d00FH7H4pYeoLIIPsUZ5IsE7V2VgloFESs0C2WK
	 nuF/LyGRWn7UYab0ptbNxjiltS8OWVPLdg0hC4ePNhYu1TJHCWzxisIXQmz0fqJIlQ
	 gX2m6BFPFfhWRSgXxj0JJpQNA6CSp0V93B0y6dvmJ4ar7JAsyi1Vp2Y6+72VETQ3lo
	 Um+MH28C88BWg==
Date: Wed, 9 Oct 2024 17:21:37 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v3] selftests: sched_ext: Add sched_ext as proper
 selftest target
Message-ID: <ZwatkYOsp7m40yR7@finisterre.sirena.org.uk>
References: <20241008153519.1270862-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yz8x4PDVpg37np1h"
Content-Disposition: inline
In-Reply-To: <20241008153519.1270862-1-bjorn@kernel.org>
X-Cookie: Editing is a rewording activity.


--yz8x4PDVpg37np1h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 05:35:18PM +0200, Bj=F6rn T=F6pel wrote:

> The sched_ext selftests is missing proper cross-compilation support, a
> proper target entry, and out-of-tree build support.

Tested-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>

There's still the thing with picking up the host kernel if there's not a
binary built, but that's a generic thing with all the BPF based stuff
that should be addressed separately.

--yz8x4PDVpg37np1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGrZAACgkQJNaLcl1U
h9Br6Af/Srr3jmfSdOS51x6LjbX5ESOwqIIU5SRAp9ldg1rfeBkDnXovLXLY8elP
VYftR7nol6ENaZ4Te9tHALpoI5S/Ifxn21a5l7vVWBnruaVlCARWleHsXop5RjxL
KivYy9oheVr2o4ChUguU/oGvlb+AUVT0P7AEQIjYc5zRb8Usxw/hxWX/JMcnOkaZ
R+nDXA53+WJXLTkbWs2oCkon208kIQvjePSrn2Zck+quoDdwgK3jO/vAVfzLKrG1
ohi/oXSbB2AgqPORrNMXVzJ94/JeNjrNrgYajyo2MB6tDQ+aAp63hogJFRQyEDg2
prXC5VLJ1FIDFfm3KzgOWy64lNueYw==
=GLMz
-----END PGP SIGNATURE-----

--yz8x4PDVpg37np1h--

