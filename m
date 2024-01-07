Return-Path: <linux-kselftest+bounces-2695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073B8264C3
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 16:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0969FB20CB3
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42495134C9;
	Sun,  7 Jan 2024 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZiQypsc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DA13AC6;
	Sun,  7 Jan 2024 15:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C58C433C8;
	Sun,  7 Jan 2024 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704641663;
	bh=sFw60PdVDruYh3S3hlkgiqi3PvoPeNW2lTLWwKghN0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZiQypscx2inRH2ASxARoMkW/YpQxakcUFOu0dsTtMKHrBHHh7Kdnb+X7gOEkmOXo
	 QBlEXdckm4nR2Ge0NLw4o4HXWvsZXCVIenyDznlqx0cadEpfPQSjCehAgYc2sllCNF
	 722nchHoZZPdcSZ4s8c1Hd4cBxIxiORez1HpimbTyl/xcIqtDyv4q44lPjSTfX4Evc
	 ucCV3G6JIM7ol+ymvMAIidVOGfD+/t7gTdQ2vmF/AOpUXMiYzWg5LIdqL7wvBWyC/X
	 yfsTckMJVgrm+oYMFSiNZmXQCKRrs3zLbtA3WaY1qekZX4sQ6M+Kg5Ln8+nKqln1xW
	 00LxtanT8jq/w==
Date: Sun, 7 Jan 2024 15:34:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 1/4] kselftest: alsa: fix the number of parameters to
 ksft_exit_fail_msg()
Message-ID: <ZZrEfCJ/2pptNsqo@finisterre.sirena.org.uk>
References: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
 <20240107151218.933806-2-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sNs2Lki5keb8EoDK"
Content-Disposition: inline
In-Reply-To: <20240107151218.933806-2-mirsad.todorovac@alu.unizg.hr>
X-Cookie: You might have mail.


--sNs2Lki5keb8EoDK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 07, 2024 at 04:12:16PM +0100, Mirsad Todorovac wrote:
> Fix the number of arguments to error reporting function in the test program
> as reported  in the GCC 13.2.0 warning:

Acked-by: Mark Brown <broonie@kernel.org>

--sNs2Lki5keb8EoDK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWaxHsACgkQJNaLcl1U
h9AEEgf+L4llKQKs2uFTAjw0utVQ+EK9DPQTLncA5+YXhAoZJME8vBccjsV2ogl8
OqQlFb/i2So28OUEebT8tliQW5XIyNroDcRo5DRsLZHTAmHfAB2mchfd+Fain/K6
3f2hHdmihrh0mkzOrNE5I5SqXo3prPFb0O09AQd8GcTixK+2/5QQLGjUOCYLzo5x
5pViJbkOEUnpYR5O6OL09HUNC+zx0Rk4lC+YIe8Ok5iFe8w20JdmBbCGeDZ3vUbW
USKcRKVcy+Abif7ttBGqSt3mGSY6ArfnHaxghsOCreWirUABhnm47F/9L9IkGDCc
h16SuSyVsSoOBsJdKfI8mryRHI4rqQ==
=UOkp
-----END PGP SIGNATURE-----

--sNs2Lki5keb8EoDK--

