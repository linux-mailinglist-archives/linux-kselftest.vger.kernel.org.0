Return-Path: <linux-kselftest+bounces-10364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05878C8A3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 18:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450911F24F8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44C413D899;
	Fri, 17 May 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxOWVUlk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740212CDA8;
	Fri, 17 May 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964290; cv=none; b=lBbSvT9CBqi8MuRVXQ+Ah2qDMpl6JPULW49hlA+LPfzlnEy8ioKqVUa32eRaDpkrlB7y20aX+nzobJ/BknK8KKJmGjqKUPblch6ROEuqPaaYfedip6OJBXTsvUNIenk2zJwdEh6AEZ9gNOl/oO52km37qXptLJoYi2BzjgiiV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964290; c=relaxed/simple;
	bh=QgpU1zoyPrzUzveFTEOAv83qjETN+zMW2porc0qvn8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwF7jtigJyFeaGW39uXzcusLvJgB/ILAtUqIIbRTcOlUqZqrngXj8LFvFp0D4is427++r9EmANZE971Va5XFx/MgzFjFzT7/kk3zTlrdLTAU0xzNSInh1DNr6i4PvOGmd5IJSTFdCuULWUBzwP4pv7As5A7GD7bg1hB9WLbt8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxOWVUlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4330C2BD10;
	Fri, 17 May 2024 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715964290;
	bh=QgpU1zoyPrzUzveFTEOAv83qjETN+zMW2porc0qvn8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxOWVUlkeOGUO6nin1HrAxJzDDBkF12l8UCJ/u77wE4lVOQt7hHeEPBvaabU0v/hI
	 Ipa841XmuJndKRJ1cFI2nWuMtLTyl8vxLr4sxizfyRljHV5KT3y1V/JN4GhIJbB2RZ
	 fEkLYIWpf1cvtxUd33HRN+SbD5rPvbn4PpPfHF0x3ZRTSJP6xndv69bXeE4uXG0vJM
	 IOgEICJuvVWtWVm5nLKGzTeZFfTes3KrS7T4rkP9sM/RUDApKMUPM/tpHtyrkCKEy0
	 QbZH7pR8SqHRupdnelhpROsCEWejLnI0PuWt89grFM5rT5fQ0p/SNqme1R32pM3y93
	 zGJFdKHc6uaeQ==
Date: Fri, 17 May 2024 17:44:44 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 07/16] riscv: add ISA extensions validation callback
Message-ID: <20240517-scrunch-palace-2f83aa8cc3ce@spud>
References: <20240517145302.971019-1-cleger@rivosinc.com>
 <20240517145302.971019-8-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/IHxON2BVIcsXV6"
Content-Disposition: inline
In-Reply-To: <20240517145302.971019-8-cleger@rivosinc.com>


--W/IHxON2BVIcsXV6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 04:52:47PM +0200, Cl=E9ment L=E9ger wrote:
> Since a few extensions (Zicbom/Zicboz) already needs validation and
> future ones will need it as well (Zc*) add a validate() callback to
> struct riscv_isa_ext_data. This require to rework the way extensions are
> parsed and split it in two phases. First phase is isa string or isa
> extension list parsing and consists in enabling all the extensions in a
> temporary bitmask (source isa) without any validation. The second step
> "resolves" the final isa bitmap, handling potential missing dependencies.
> The mechanism is quite simple and simply validate each extension
> described in the source bitmap before enabling it in the resolved isa
> bitmap. validate() callbacks can return either 0 for success,
> -EPROBEDEFER if extension needs to be validated again at next loop. A
> previous ISA bitmap is kept to avoid looping multiple times if an
> extension dependencies are never satisfied until we reach a stable
> state. In order to avoid any potential infinite looping, allow looping
> a maximum of the number of extension we handle. Zicboz and Zicbom
> extensions are modified to use this validation mechanism.

I wish we weren't doin' it at all, but since we have to, I think what
you've got here is good.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Do you want me to send some patches for the F/V stuff we discussed
previously?

Cheers,
Conor.

--W/IHxON2BVIcsXV6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkeJfAAKCRB4tDGHoIJi
0kl2APwOQPrdeOk2UeAnU791s9RSGh57l/KFZUV8B/odusv3NQD/Umivns2bYz6q
g4XXrW4VGMdCkveeyrvnkMklbwDTswA=
=bE5t
-----END PGP SIGNATURE-----

--W/IHxON2BVIcsXV6--

