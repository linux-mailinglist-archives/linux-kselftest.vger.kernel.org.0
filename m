Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A57A1B463C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDVN3T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 09:29:19 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:60828 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgDVN3S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 09:29:18 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 496h9S70qgzKmbT;
        Wed, 22 Apr 2020 15:29:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id dV--dvDXFOxA; Wed, 22 Apr 2020 15:29:13 +0200 (CEST)
Date:   Wed, 22 Apr 2020 23:29:06 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Liu Yiding <yidingx.liu@intel.com>
Cc:     linux-kselftest@vger.kernel.org
Subject: Re: selftests/openat2: subtests "openat2 with valid how.mode and
 O_TMPFILE" failed
Message-ID: <20200422132906.hbb7v57vxry46x6n@yavin.dot.cyphar.com>
References: <8c04b687-db6c-3cb0-a559-1b44883eecaa@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7rofl3x6m6jn6ulf"
Content-Disposition: inline
In-Reply-To: <8c04b687-db6c-3cb0-a559-1b44883eecaa@intel.com>
X-Rspamd-Queue-Id: A9BE617EF
X-Rspamd-Score: -7.26 / 15.00 / 15.00
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--7rofl3x6m6jn6ulf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-22, Liu Yiding <yidingx.liu@intel.com> wrote:
> # openat2 unexpectedly returned # -95 (Operation not supported)
> not ok 106 openat2 with valid how.mode and O_TMPFILE succeeds

I believe some filesystems don't support O_TMPFILE, hence -EOPNOTSUPP.
Try using a different filesystem.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--7rofl3x6m6jn6ulf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXqBGnwAKCRCdlLljIbnQ
EuHwAQDr5lbpTsHvsxxTtlq15R8ykjhXK5MNg0zXD0oMi1AYRAEA2f8QN5y541/z
PO8A0JooLkWQwhxInn43c0orVbGSlwA=
=1yOC
-----END PGP SIGNATURE-----

--7rofl3x6m6jn6ulf--
