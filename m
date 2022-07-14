Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4D574C26
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiGNLci (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238857AbiGNLci (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 07:32:38 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B239A1B7B8
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=QF7MlNUqjT2UfEW9YfPAvRYW4tsr
        xdKIhmgnJ6AkEkI=; b=HKqMpM1AKn0Tjl/qDOcLHPQOUidWaHe+loZMDcxOQeX+
        Wh39vQfXsMS7VYRoizVYeD//Y4Ncuxn466bnL7pCYxwA1uwDqAOhGwg4uonMMxfC
        MvNh5oed9JluTbYfh3oYmIE6CO08IIjnp8xVWiecPo5vroo9zhhTVCZ4BP/0eeM=
Received: (qmail 578448 invoked from network); 14 Jul 2022 13:32:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jul 2022 13:32:33 +0200
X-UD-Smtp-Session: l3s3148p1@QgjvQcLjvKQgAwDtxwdRAEXXn+yo/Rze
Date:   Thu, 14 Jul 2022 13:32:32 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     John Stultz <jstultz@google.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 0/9] selftests: timers: fixes and improvements
Message-ID: <Ys/+0CVwtTpBNfws@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        John Stultz <jstultz@google.com>, linux-renesas-soc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
 <CANDhNCp3KhGjXSrS4xmqrdPJfxStZOOn+FQxJEEoiXZ39CxDpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="en0QinxNUHwiuF7U"
Content-Disposition: inline
In-Reply-To: <CANDhNCp3KhGjXSrS4xmqrdPJfxStZOOn+FQxJEEoiXZ39CxDpg@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--en0QinxNUHwiuF7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey John,

> Acked-by: John Stultz <jstultz@google.com>
>=20
> Thanks so much for submitting these.

Glad you like this series. I will wait some more to see if there are
further review comments. But surely, I will add the missing parameter to
the help output and add your tags to v2.

Thank you for doing these tools :)

   Wolfram


--en0QinxNUHwiuF7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmLP/tAACgkQFA3kzBSg
KbZgqBAAl9r+En2Z/stzjSCSrZw83Tb7y+Kjgj2SlsEp37lxn5mIS1nAQa0N+yvL
3S5zkE1Hj9yJagC7eIcDEv/oFX8zf3SJIAfJQ4NkfDO5ZhRUsiOyUhm81ywgbBCB
xF4t5upcE7iJ7oeaxqaMEW26eQJOz7bRNec1SzX/jz3mZazfua+PD4ShhyTAaXzn
xNJn7C3um2ySdmOS8wiLrFLVKqm7LIXmQy9eYzNnbfVf27n8/kM17co7xvYjeARG
JxBGfhuMBBcayAVeTr2PlTtWzbSkaZkz1S+38KAeQDsJaPJbi8DcHxfBfnPgE88N
1OabM1TUhN7qohy7VaAooWBL7JJt92aQkB5c0Os2ftHoCmmSELXEgQZz5clnsMD5
+OWzNxOgCX1YNb6aVufraIUxtJhql1HveE84Q014uAUYob+HnY39bGFyruqc7EK2
QCXCrqjzV0wJjxjxZ8b4Gpo6nIrei9PgxU6TFy1pDvJ6HJypQz2YnbJ5Tx5IXuc3
c1EIjYfQlODtryWANoqhvyaUQZy4L1Is7UM5iuVXsYhzL/DazqItoBl5dQf5+pmu
n7h3lNVKThnYUJdXzEujtuMITFTfWW1Y/cyLhthdTnhiBbmFlKktc/9nOf3ykMD6
1xF7ilgQYOGnyk3VD36Ov7ZtPtYXh2eTyezgquP9+EMsMmYSS7I=
=ZXu/
-----END PGP SIGNATURE-----

--en0QinxNUHwiuF7U--
