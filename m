Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEC3574C2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbiGNLdD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 07:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiGNLc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 07:32:57 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C2F12AE3
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jul 2022 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=NqgLRbDkvKrqZXgEukqPHi1HqSm/
        5pRJ4jWogOuPtXs=; b=m2HnQ4oEYssWagmMEUhUKw8N6UI14SSxK1b76MfrFTq4
        P7TT6zWP7VDwtqiDuZTpgLij7LehcagV7Y9u77VgCxByZJ7YFdZLc5JlN1tnVXPS
        1w1l95QEbZxblDPsg3sysKDduiqniBWmOgUtQAFZI90vQWr5Sk1Ci3rNkyAcJuk=
Received: (qmail 578553 invoked from network); 14 Jul 2022 13:32:54 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jul 2022 13:32:54 +0200
X-UD-Smtp-Session: l3s3148p1@C3czQ8LjrqggAwDtxwdRAEXXn+yo/Rze
Date:   Thu, 14 Jul 2022 13:32:54 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 8/9] selftests: timers: clocksource-switch: add 'runtime'
 command line parameter
Message-ID: <Ys/+5sdZdQfwlWwh@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com>
 <20220713204623.5443-9-wsa+renesas@sang-engineering.com>
 <23526df7-b77d-4223-71ee-51c456dbc236@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DXoAO6xHabqr8icK"
Content-Disposition: inline
In-Reply-To: <23526df7-b77d-4223-71ee-51c456dbc236@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--DXoAO6xHabqr8icK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >  		default:
> >  			printf("Usage: %s [-s]\n", argv[0]);
> >  			printf("	-s: skip sanity checks\n");
>=20
>    Hm, you probably forgot to update the usage msg?

Yup, thanks!


--DXoAO6xHabqr8icK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmLP/uUACgkQFA3kzBSg
Kbaocg//YV6D4s8raDMrzNSBcJCJ6YOYUMsyzGtyh3rWswhrMWLhENR4ojJI7OJv
/xr6wNhkgBNVDcdKoX7Rc0Q7OtQzpvT/RvUW8IFw+R+x3YNlIgSeW+E67YJuRU9g
D2U+YHNoyNpGItY/QEBOI1GOwzu5GLxlbglnRLQMONeDrHuHzCoU+DW8M07Dvp+l
c+msZ6qgg6w4kjua5YxaMPC+xMcmaXffDMxLeiIclGWKkFdHcuNlIQzXT1xsJQEO
AOF8SLzp4xasT/+m3l0eo9rnADhqgY+YV4aLSxAMS1dSrAn/wqp72kVMbwyh9FiS
xZ9J32F8rl3xgnnA+VmL0aGVpL6hfQINTURwHNFYeJdsBrqxnO2XRpTXfdxaWQlx
UQm/NtoODnF2YbUmDVarjriy+6jeFbcI97VggHEe88L/I+QcxCxnlT7sO6FZQIms
Vt20ybsJz9m5sFzVGXyeT2q5F7CQKOQdAB2jzvH5LB2Rma+OLrIBGACYMqKlAhc2
CGWFrNwr1f/wxHkPFd3TToZrK1g8AMpoIAWn0BiTrPUWc3QqBqmd7+Y3F9D8hi1D
Sc8d8YV1RQOKA8Bz37iqv4dIzNlgGVapKUN4KM+/TDwYXGuI3RsjcYq3QdvpMxr7
dcEp+tEe0bfbbrQHYGLM+vslzprOkY76w2nEa+7eobnZHHGIzNg=
=Zvy7
-----END PGP SIGNATURE-----

--DXoAO6xHabqr8icK--
