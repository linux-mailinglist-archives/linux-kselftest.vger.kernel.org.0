Return-Path: <linux-kselftest+bounces-6668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730A888CEE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 21:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715031C64EC7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 20:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E51D13D607;
	Tue, 26 Mar 2024 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFuEjSNg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27213D240;
	Tue, 26 Mar 2024 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484867; cv=none; b=IcuvYxteOiQC5LGSAlzIExgRH2kffOGAWHMEzQhcon1VB1KSwnn/GrSynD26zN6IIAouGlwNgeE8Kl5NsnUDSA1J62vM7VTysPbe44Qtj63uoqtNH2N2rwkFffgzSOVvJbeuI2y/8GRwCJRYiLdpOnlhNSdZecjgFTmrNhNz/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484867; c=relaxed/simple;
	bh=eLoxHyYLX+aidvGPzKNlk6hebaeYMJHgMTIiAXr3Tl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flzt2o17RQLawixIwCkGMJjTeg7+x8ugNd2Da9YQLw2k/1Q+ZfB8oyDODLNExxTw22yvZ7vMsv0WsxMNbD4FnkMtrWbnSYJyMrtHqRTCuU5rSiXCgxJNrtiajhLR8kbKCKjUEg6nQnnakSZTG6rcqdP1GSvLY2gfTdY3gqCjqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFuEjSNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46514C433F1;
	Tue, 26 Mar 2024 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711484867;
	bh=eLoxHyYLX+aidvGPzKNlk6hebaeYMJHgMTIiAXr3Tl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFuEjSNg7ri6vMiLa2+e58xgkZpsC86VoPZNSCA/jttK151RaIifSgB5pRap50OfN
	 V+rrF+Gkutmb7CIEdGDqhag/R2fG/7sSIYNobC3a80p32LP+B0SZX0JoTxqVydtmLJ
	 2z8ADutnVnfi8HFrwNpymH7u6NE7WHOxLy+3DgsmOALNPK5S03oY3rYCLeewwZOkvw
	 27xWjubQZQFWzB2yu8EzN7Z+F3r7mDHvqZCmESKj1QyPx+IGFB96qQL66gTF15Mv2W
	 gcZutmXBCN8cc0Ro1stN1R+Wa9NQp4gnZsVZOo+3tWFwY6vLirT71KSlQZ4hDgoN8+
	 wD578hQjbrxgg==
Date: Tue, 26 Mar 2024 20:27:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] kselftest/clone3: Make test names for set_tid test
 stable
Message-ID: <ce20762a-9ab4-49d4-adc5-e8eb5e5ac848@sirena.org.uk>
References: <20240325-kselftest-clone3-set-tid-v3-1-6fdd91506e53@kernel.org>
 <0cee99af-f058-47a0-9119-94cc9a37e88b@linuxfoundation.org>
 <91f2e916-2f90-4970-9448-09f821597083@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ut39Lk+c8K15v8h"
Content-Disposition: inline
In-Reply-To: <91f2e916-2f90-4970-9448-09f821597083@linuxfoundation.org>
X-Cookie: Equal bytes for women.


--4ut39Lk+c8K15v8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 02:20:08PM -0600, Shuah Khan wrote:

> I am seeing the following compile warnings. Please fix and send patch
> on top pf linux-kselftest fixes.

Which toolchain and architecture are you using?  These compile cleanly
for me.

--4ut39Lk+c8K15v8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDL74ACgkQJNaLcl1U
h9D6Mgf+JZZG8Dq3POOJGeXgLDvM2wZNLqNX5v6SV8EXDMI3d8YNrLnqNKQFOE33
jMYJy4cDZwjoAURPFGG7rneUqaBLFwsWk4ZCo+uqK/ksPSiIHQmKa7+6+eXRylg9
7wcm5KdVfBfYldUK/0HPoLfSd8JdlIcqgXNHsg03bRCLKaGNuJ/SN4qFhYzCRH/H
UeK51aZ109d70NAgDif/6HzCPUZznl/tcijqeQHTa3dHtF5NV2whZFm+HitmdANl
qEyVwvjxEv18rkZOBd90+OZkSBqYR5u8G0IhFj+8kYcDMV0iPP7/qZuyoL4JzTo0
xmlmsU10PdurmQeuG33HpuiTFkAi2A==
=LZy2
-----END PGP SIGNATURE-----

--4ut39Lk+c8K15v8h--

