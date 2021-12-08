Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04DC46DD72
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 22:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbhLHVM0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 16:12:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35712 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhLHVM0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 16:12:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7900CE2392
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 21:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C36C00446;
        Wed,  8 Dec 2021 21:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638997731;
        bh=Nhr8a+1T083m2arRQNZR7McftHPXBYN3WlT9Z9eaZmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1PBDOjaUDP3E0h1I76hKmsAi6s1tKbxYbnLs91sbHMcp9JxE1FOs2u1xLkW0Peh7
         XKInZosNW2DMNAQ3gzp8EaeICvmj9+qdwp4d/+pC2P+ZMA36O9gdho1pBbOFX/8KlA
         AwgxKoAVjxxAp2z6/kRSiJTlOlIVOmfzZy4HtOOVMl/tXmloz8I4LRMrlu+ZfIDU59
         hqnUVNQ9XUO0pVZPyvdHTkSo/MLohc6EoJ3cG4K+Oh1YGnhPajC8LXDt9ONyML01WL
         OM3W7JmxF7sgYAACg+U3aiA4CKn/ZSTJuc23eAHViF8RwcqjEZyr+9umpYbU2A95x+
         XJGJ/THUjaNnA==
Date:   Wed, 8 Dec 2021 21:08:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.de>, Shuah Khan <shuah@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest: alsa: Use private alsa-lib configuration in
 mixer test
Message-ID: <YbEe3tz95ObwMxoL@sirena.org.uk>
References: <20211208095209.1772296-1-perex@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R7r1l1UNUadmy4Co"
Content-Disposition: inline
In-Reply-To: <20211208095209.1772296-1-perex@perex.cz>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--R7r1l1UNUadmy4Co
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 10:52:09AM +0100, Jaroslav Kysela wrote:

> +#if !defined(SND_LIB_VER) || SND_LIB_VERSION < SND_LIB_VER(1, 2, 6)

This barfs if the local definition is used since the preprocessor will
try to evaluate SND_LIB_VER even if the macro is not defined and the
left hand side of the || is true:

mixer-test.c:66:60: error: missing binary operator before token "("
   66 | #if !defined(SND_LIB_VER) || (SND_LIB_VERSION < SND_LIB_VER(1, 2, 6))
      |                                                            ^

SND_LIB_VER was only added in v1.2.5 so currently used distros run into
this.  I've restructured to:

	#ifdef SND_LIB_VER
	#if SND_LIB_VERSION >= SND_LIB_VER(1, 2, 6)
	#define LIB_HAS_LOAD_STRING
	#endif
	#endif

	#ifndef LIB_HAS_LOAD_STRING

which is a bit ugly but splits the use of SND_LIB_VER into a separate if
statement which causes the preprocessor to do the right thing.

--R7r1l1UNUadmy4Co
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGxHt0ACgkQJNaLcl1U
h9AgsAf+J2ovDjD3qesqpI2me9WifDmIlXWGCrVAcfX9prKCdWbEkrzh89T0/JEC
eMAjUtpx3AtYI9OCW67mP+tIDp/z6qpTCcth2XhV2kxAJvs28T+nuVHEs0Wrd6h/
coPN7n99tQ93CGTfYJSSyRIkG564muLVZCZXUv7KKmlNfWyYzGYO2b5o/+pyQ/Eu
bAVMYxDKKjz/newUBzRKCLxckzyBavSYEomuCuYzi6zLpGyGbT07Tq/jO3qhwiw4
kqt6VeXa/jiIjqPtPBRy+jZqpoHP9E/vOBrkD45nifrZZ8KT5XqVdGxT9BzMEcwv
X/uSB1ldcbY5JfStDr2+v7AIEGGndA==
=JMHp
-----END PGP SIGNATURE-----

--R7r1l1UNUadmy4Co--
