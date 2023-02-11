Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20A1692D6E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 03:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBKCmR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 21:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBKCmQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 21:42:16 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA495D3C7;
        Fri, 10 Feb 2023 18:42:10 -0800 (PST)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1pQfpI-0007Sl-0Q;
        Fri, 10 Feb 2023 21:41:20 -0500
Message-ID: <4cc446385c79fb04e092a038f82cabc059afa4b0.camel@surriel.com>
Subject: Re: [RFC PATCH v2 00/19] mm: process/cgroup ksm support
From:   Rik van Riel <riel@surriel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, mhocko@suse.com,
        david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org
Date:   Fri, 10 Feb 2023 21:41:19 -0500
In-Reply-To: <Y+bR99Ca+7SObeQo@casper.infradead.org>
References: <20230210215023.2740545-1-shr@devkernel.io>
         <Y+bR99Ca+7SObeQo@casper.infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pxTYZqIXVRCPo2CcIUjq"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--=-pxTYZqIXVRCPo2CcIUjq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-02-10 at 23:23 +0000, Matthew Wilcox wrote:
> On Fri, Feb 10, 2023 at 01:50:04PM -0800, Stefan Roesch wrote:
> > So far KSM can only be enabled by calling madvise for memory
> > regions. What is
> > required to enable KSM for more workloads is to enable / disable it
> > at the
> > process / cgroup level.
> >=20
> > Use case:
> > The madvise call is not available in the programming language. An
> > example for
> > this are programs with forked workloads using a garbage collected
> > language without
> > pointers. In such a language madvise cannot be made available.
> >=20
> > In addition the addresses of objects get moved around as they are
> > garbage
> > collected. KSM sharing needs to be enabled "from the outside" for
> > these type of
> > workloads.
>=20
> Don't you have source code to the interpreter for this mysterious
> language?=C2=A0 Usually that would be where we put calls to madvise()

That same interpreter is also used for workloads where
KSM brings no benefit, and we don't want the overhead
of KSM.

It really would be useful to have the ability to enable
this on a per workload basis, for programming languages
that do not support madvise.

--=20
All Rights Reversed.

--=-pxTYZqIXVRCPo2CcIUjq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmPnAE8ACgkQznnekoTE
3oNSMwf/VUbQ5oMfRa3q8Yifk/HxCnGJb4Zh/GnOrSsuzKKgLe6ixGcATJ9FFDRT
OQQLiFarNxE0n42QfsuHCOYUhKPOELqMUHwiRYQN/481qt6kxi0GYtz1OdUOw1tM
clXCSl/sij+M6yOUZ7/0BSyQ4SMPxS6M4Bk9rqmznTqU4CP7g8ifDBEXw7zcfIba
ASGiJAL786tIV1Mk2F3QQRFifggk4OOCkV6k5v+60V/hGfQ3jdijhvLX1eX4cRxf
h+s5mXI8F0y6vV8wu/AyYxyiF9C5IqhucgDQn4evsZUCuryDnq48rROLC04lOpuc
g0Ow2YR6RexaEuZ28tuAYAn4k8zbnQ==
=lVHT
-----END PGP SIGNATURE-----

--=-pxTYZqIXVRCPo2CcIUjq--
