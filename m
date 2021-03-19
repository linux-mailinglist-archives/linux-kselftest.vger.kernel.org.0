Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426FC342310
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 18:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCSRNZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 13:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhCSRNA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 13:13:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B09B36191E;
        Fri, 19 Mar 2021 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616173980;
        bh=uDhMMbrq9my6cPt0LQ0nvw3mts2ZTsfmJd5fIsqnNUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQuP/rkNNhpR6bBvaP9CzRE66yWr6NfTvEZRFougZJ8n6q0S0bKXAKZeY+3ltkwnB
         MnzJj7R6BsJmUnW3Fm46Hac8yMqerFdOPkF58lGUqmLYFGrczvRKQg9mNK8sFsURlO
         cG0OovaHjv/Pg97DnWZWca+67FeMrMSz7DsNWcQNBcRMY0uHOyePHnzOsLoD7TU0om
         aL9vbDNCdYpZtBqLWxz00toIasUP7cL684U2PkUgOCb0nyH2WHH0cKgOTLbT95jnoi
         jTSr/eayK6tn3LBphwJUEOjAGH9nz3vJFGApa6+nkJVY99BUH4UKgt9p1X/EvISdxg
         iiBvbWbRfEZRQ==
Date:   Fri, 19 Mar 2021 17:12:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 00/11] kselftest/arm64: mte: Fix feature detection and
 compilation
Message-ID: <20210319171256.GJ5619@sirena.org.uk>
References: <20210319165334.29213-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
Content-Disposition: inline
In-Reply-To: <20210319165334.29213-1-andre.przywara@arm.com>
X-Cookie: No purchase necessary.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 19, 2021 at 04:53:23PM +0000, Andre Przywara wrote:
> When trying to run the arm64 MTE (Memory Tagging Extension) selftests
> on a model with the new FEAT_MTE3 capability, the MTE feature detection
> failed, because it was overzealously checking for one exact feature
> version only (0b0010). Trying to fix that (patch 06/11) led me into the
> rabbit hole of userland tool compilation, which triggered patches

Reviewed-by: Mark Brown <broone@kernel.org>

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBU25cACgkQJNaLcl1U
h9CEdwf3YoRRl30t3x5bn0WGArLP2mi6Ooy91v0UBGn8SFscluaqqoT/iW0j+fo9
XgYlbrtm3Ebom03v+noCm5DxfhoKHv6WY2Zia1esAcx6DR6Jug+A2L0bThyv0F/Q
KwSMs/u8hoonRB3D/TObp1bQBolcrQpxpMq1uuAqLp4Ri25OgEFhpeCs6r1ZLRrh
SGGcQ2/5At6EBSOY1QOD4S9x9HIA9bzwy4x+67913KMMlmG81QXDSg6H1z8QhqgJ
3fwkumsCXNHlWxUNSnekBWMfgXaqiCHj3rr+HnHf98i8r4tpwiZiCb1PhzBoVv/x
6ALw7xjE/RT9etfrnZN2/1krg+TO
=jCOF
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--
