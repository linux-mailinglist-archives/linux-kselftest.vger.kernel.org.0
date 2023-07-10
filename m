Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0501774D8D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 16:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGJOUY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 10:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjGJOUX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 10:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB9290;
        Mon, 10 Jul 2023 07:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4532B6102D;
        Mon, 10 Jul 2023 14:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23776C433C7;
        Mon, 10 Jul 2023 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688998821;
        bh=OLMdz1DN5xibC7Sk2gaZG3zWRkoxbpH001OB0bLR0ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmzHx8uT7TGM/txBD6jaX1GWoerubuy6fgJwTOmP694+ens0oNsgIh4iK2TRvNOvW
         uM4MqBrd5sCukWd3zrE3vKvQStRY6o9w3dWjfoR8+rPum6TgDHPQXltABa4pICxUcE
         LaBIW/v+zpMtFa10oD4kbBBpNPUZr7UMe8IDfsxjBCfdPSOPaDhh4GCE7sLbO3FEXq
         evgwMbpQIX1SNnQkakwubpWueqTOz7dUx9W57YTzV7qMUMK2iK3oRurKhHb89loiR1
         3Sp1UM1zDMtN5+BZLDsBWZ/aVt4Nrm3Q8HyAjYEJ9d0cJjComBi+nIiI2cQlfxLcGT
         9j+MmPYVXC8CA==
Date:   Mon, 10 Jul 2023 15:20:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 10/11] Documentation: kselftest: "make headers" is a
 prerequisite
Message-ID: <36093b4d-1225-435e-accb-f596ef7a2967@sirena.org.uk>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-11-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SXAURWvz4FkmpKYo"
Content-Disposition: inline
In-Reply-To: <20230606071637.267103-11-jhubbard@nvidia.com>
X-Cookie: "I am, therefore I am."
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--SXAURWvz4FkmpKYo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 12:16:36AM -0700, John Hubbard wrote:
> As per a discussion with Muhammad Usama Anjum [1], the following is how
> one is supposed to build selftests:
>=20
>     make headers && make -C tools/testing/selftests/mm
>=20
> However, that's not yet documented anywhere. So add it to
> Documentation/dev-tools/kselftest.rst .

This is breaking the arm64 selftests, I've sent a revert:

   https://lore.kernel.org/linux-kselftest/20230710-kselftest-fix-arm64-v1-=
1-48e872844f25@kernel.org/T/#u

(logs included in the above patch.)

--SXAURWvz4FkmpKYo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsE58ACgkQJNaLcl1U
h9DW5wf+K3ErUXYG5NoFTwiBKRLqmjlCbqt53gVZU46qFA+tyb9S4K5iyg5Vd+/D
srIjEtIdTXB+t7W7tZOrjVOlfDHIpJmGiG88pqq1MRJfTTlq+MNeKyhyK//8OkN4
a/Ugsgf9v9gXc0DYLltGEj4NPHokXvxyrNRrqewj3OIoLY65qgqKSUgjvbBuORdn
KSM/HoHqfp57n5xTBx7UdCTQ6KTsIbXSeNInDIq1FVC+THvEBgVTXYXa8720fRwy
HLSLdcR7gOFGn6INsEUqOT33Z7UyreQhWtq0j6gfSZg9uqNt1RwXo493Krp6YLOm
GOWBk8OfMij3SoSvAlEDxIt9Fqh9Mg==
=bFPt
-----END PGP SIGNATURE-----

--SXAURWvz4FkmpKYo--
