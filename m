Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937DE7856F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjHWLpS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 07:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjHWLpS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 07:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA15AE4E
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 04:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 423FA61841
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 11:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C16C433C8
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791115;
        bh=/PWrmoI9AeCTaGlBrvOJOVUbnjMBHUaBrRLNiCkRafo=;
        h=Date:From:To:Subject:From;
        b=IMvC0xrFjETvtkok67S9UOXV7qi7qOMVDdBJbjKg/F4TliNCqDSVmtO/7Aji04S/k
         5XmQ9xUdAIqSAo5Yd/96ygePxJuRNInNUKL+T2i00l/eFkMJ8CRQIUnfIR5qqNrEjY
         E+TcAPp9tZZc8D57bs/FK1TOAl7z3XDrrWgmW+n7Neu6P2Xrp1jcvI8N/MGoWjmYlQ
         BpeXX5rJ16PTT7aovBQ7o+u1fazg+mf69JW9LJ4Xd62BfANHSC85ONXGHH7BQhZ/z8
         LotG5xhZxom6Q9DhLhHrQNFCCxWwpadNRQ2toFrnKjamrcZX+FLA2l87FMaHQCfP/2
         kXlS5SXtowaaA==
Date:   Wed, 23 Aug 2023 13:45:12 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kselftest@vger.kernel.org
Subject: Repo for tests which fail currently?
Message-ID: <ZOXxSA1UKBkU/ou4@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        linux-kselftest@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="td1mnywqSgGnrha7"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--td1mnywqSgGnrha7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

for my talk at EOSS23 about object life-time issues[1], I created a
loose set of tests checking some longstanding problems in the Linux
Kernel. I would like to improve these tests. Now, I wonder where I could
contribute them to because their scope seems different to me. They are
not for regression testing because I don't have a fix for most of them.
Some fixes mean rewriting private data allocations for a whole subsystem
and drivers. The tests are rather meant for documenting known problems
and checking if someone started working on it. But it seems that
kselftest (and LTP also?) only accept tests which do not fail by
default. The question is now, is there another test collection project I
could contribute these tests to? I'd be very happy for pointers, I
started looking around but to no avail...

Thanks and happy hacking,

   Wolfram

[1] https://www.youtube.com/watch?v=HCiJL7djGw8

--td1mnywqSgGnrha7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmTl8UQACgkQFA3kzBSg
Kbb8Ig/5AfdyBJi9963Ym6hiecYznQhIrtWCY6mAaLmbCVtheLGI9u+nnv/O45zn
cENXYZSUz3RcNBtomU6Hvb5fM5IqDoINeEUiZbr57FFPYwd80WomGHgpouV91eJq
G/qLp1u7/8Dvko0NYpPoPfQyqbbrQ489MuOCBjaqD1E6W8NhPpJC7mvw3VLsPZUq
/XqRPM6bOwNutnD4IFYloPd+PZHGpveSmdYOvYld/Haho0l2aovhSDP/foI7y6OF
pocHQ7Gg4Bybp3WrKfkThV06+OTKFu7362Pz0ww6Pz1kX4m2IL7+KE6wKFoKB0Xg
y7uWfgFlZKR+zM2+EpOBod05J9G1ffGB7u0Pt8UmMS8O7NHdCzEbRO+IVPl6oorH
RaTYXEIKNsA1fgU009n47LRHmuUFD5lyDS70LYWvB/C2In+3YXm4S2J2HFQ7ET1z
MhU0x1MHZ+wX4VDX0aSd5Y8pW5XG13qmogJbEGuj1FRGHagWwDH+bjUcy4XORSn3
h1stRJZF8Oqfev4gCTYJYyCrbpZy4UiEtV9lJ4tcG3yYftfI0RpCVYIOTJu1DSD3
G+m9kjMrmnw7YP/7fwOijTfmWINrefOl3p5OCCqzqIic9fTXFcpVNT9aFjZFhxzc
bITbqWj5rKHVAeNc0bcRfQ/6Somy68w1XhzAVhs3SzZy9d5k/O4=
=HBD4
-----END PGP SIGNATURE-----

--td1mnywqSgGnrha7--
