Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F14785B13
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjHWOts (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjHWOts (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 10:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B7E6C
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 07:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DAE46637E
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 14:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0CCC433C8;
        Wed, 23 Aug 2023 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692802183;
        bh=GoUQbJGBLBYXeeP8dapyXhG8puuAkUhYl1LYxuISEoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4eOWS9RlM/h/M+amgq2bIijWHzGhkJdw3WgI+hqFHbxpr7lsWYW0yLZGu26m92LP
         qt6pIn2s5Qj3lma3IAtpLcP9OLtSbE8UG53jC5pcTWDKzfq+AVUf8kJR7su1AqzGic
         l/ZJpWyRMTd6/3+4bt724fQ4Fq3nRxOtihgFp10yqiym4VPO0sD22skVLuOE7FN2Qt
         4xx8OW6gjC0TGVTjR1S3M3F+IAqRSuMCfaBvpLS0y3fZdPPkx4LaawMyJuyuMnuoJX
         2oCWgqGLTwvasVTDH8BoZei+zI2F+ENAeGneUEDNTppEGhoWQu8zge9MC9tj0OCfJE
         a2JBxn7p+lkxQ==
Date:   Wed, 23 Aug 2023 16:49:37 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kselftest@vger.kernel.org
Subject: Re: Repo for tests which fail currently?
Message-ID: <ZOYcgT2Jnw8GLLjm@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kselftest@vger.kernel.org
References: <ZOXxSA1UKBkU/ou4@ninjato>
 <b60da0cb-6606-ef37-8fd3-6a222cda736f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PBPGGAT23kSm/Naq"
Content-Disposition: inline
In-Reply-To: <b60da0cb-6606-ef37-8fd3-6a222cda736f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--PBPGGAT23kSm/Naq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joe,

thanks for your reply!

> Anyway maybe your question is less about mechanics (could you invert the
> result, i.e. failure is success?) and more about where to collect such
> tests?

It is the latter, exactly. A failure is a failure and should be marked
red. But where do we put tests which we know will fail and currently no
one is working on fixing the issues? I wouldn't mind setting up a repo
for this but let me elaborate more in the reply to Greg.

Regards,

   Wolfram


--PBPGGAT23kSm/Naq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmTmHH0ACgkQFA3kzBSg
KbbUew/8Dpg7qTky0JiDw3cKGl9fSVB9ObbaXymvW3bpyssGUk/L4NffiiUvenzJ
vq8TGyRJg5wJ6D15JNO6Emdtx+MDCUuHsuSXBxTfHx1IcIMK8oSiOdM6vW+UpV7t
5/AooQbFcrnuYjXhqxxMZ1DqqrQdyG820XX8oQcos0QGD+1YsKjnFQG6wNJr/fPy
nV0XQLEXh3exDZDvonIxja6onE5KDYMDhE2Sh9FPVfdtUmZ8e5dmp0IWPo9nIicl
gEU4lfYpjIbExMpLzRpv9YjWxSAMdLA0Bd37jAsrHVumV8uHmt7G++zatgs+8TKM
Q/rFV35mrpCevVKnfaz0cj3Zn9X7+X5+KxaRBCxp0Ec3/cxr6w8DPekjNJ9PA37f
TdfDPFiqCccev3SrPqCBcGufZYPrw7nSmeFDhwyEOivKkycft/r7HkrB0pS7621i
wx0ueMrsBs3Zj1bbPHqemSjSNpyUnWxYnbyYgAW0KaUNeOtXEfkFUnvKRdQdlE6h
vjdVW7QuccTJPX29/ZvKTdf4fkGm3IVrFXpEtLLurCORl4xnoDuRFyXQkpaYwgpG
TgutVY3sD77+MisZQQ7L5RjVTFvRV2jrBqrIl6TtDrOcktoXidbVgE/UYprjB23f
cX7qwsFik+F+/MzO6zO7OHHYO3iZskiZyJwimhYjStMgQUsGWP8=
=czhx
-----END PGP SIGNATURE-----

--PBPGGAT23kSm/Naq--
