Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B013A139D81
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 00:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAMXkx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 18:40:53 -0500
Received: from ozlabs.org ([203.11.71.1]:48263 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbgAMXkw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 18:40:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47xVTF6nGWz9sNx;
        Tue, 14 Jan 2020 10:40:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578958850;
        bh=A848NZEiEcaXz060s2a1b3NhnA3pCu9FGX7S09l4sQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJvILkfYlBGvHI4BPNiRy0MTc+GdRHUnn5aPKW7QRixCbHT36vJxHwli81Wzp3tTg
         JMX42zi5+Si5Ra0qc/Fdqf0xzBEec2ACYVbtGXyChUrwrN1ISC4WFl0X+BcQ52V7x8
         t7pNd9b4my7XOYfVZGVIK1snPSEjvDw4amfTop7WMvfPs4DRRYC3+dxVop5+bz3AtW
         eqxXnF23uVxU4CWOoqdOPb8eSOjaYkBrCAdhULu5FrnWVLVvhvY5uGV0phCYr5qnKO
         Jzj4sJ80+HXzw0WiiCbbgJx0sRdRWMKCrBQiK92K3LmRzCNSCtfDY95dwa7BtxXzTW
         7e3dfhOdwcnzA==
Date:   Tue, 14 Jan 2020 10:40:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: linux-next: Tree for Jan 13
 (drivers/base/test/property-entry-test.o)
Message-ID: <20200114104049.5244f612@canb.auug.org.au>
In-Reply-To: <eddaa93c-3bde-a9ed-5ee7-766f3cd51a43@infradead.org>
References: <20200113181457.209ab4a5@canb.auug.org.au>
        <eddaa93c-3bde-a9ed-5ee7-766f3cd51a43@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o_gDCpRQjvTiTFnAR6E4otA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--Sig_/o_gDCpRQjvTiTFnAR6E4otA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Mon, 13 Jan 2020 14:59:54 -0800 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> on i386:
>=20
> WARNING: modpost: missing MODULE_LICENSE() in drivers/base/test/property-=
entry-test.o
> see include/linux/module.h for more information

Sorry, I missed that yesterday.

Caused by commit

  c032ace71c29 ("software node: add basic tests for property entries")

from the pm tree interacting with commit

  9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")

from the kunit-next tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/o_gDCpRQjvTiTFnAR6E4otA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4dAAEACgkQAVBC80lX
0GyOCQf/XF1HpPDPAJkgZkwD5+/qpEus4WuG8BcwMiVelJBZVjXUSyau3hKu3PIN
+mgQM6hVoAfV0BllZpIFyNFMRwpJe8hEVfiFR1BkNO9NutXPhBwZk5+poK9zScMD
CypNpPfA9LuKuhlAviZUtReISVYsAYF9Jl7T+sj6XTmUNdZC6PRlfMyk8TAGXRw6
oJeMfnXYv4xnXsRymo3TMCpT2yDQ6XzH2T2TGXNe/rQKcUkJRbGQGGoCcf7oH/Mx
BhSgNlNiRoqKRsHJU054Is2RtQhHMpNNtxs38H+mezQJdkN7n7k/5tjgvmay0wra
wkIE8gG9LRQVnrQk4xD2bilcJGPypw==
=nphE
-----END PGP SIGNATURE-----

--Sig_/o_gDCpRQjvTiTFnAR6E4otA--
