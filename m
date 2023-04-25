Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0796EE990
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbjDYVZf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjDYVZd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 17:25:33 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D38816F37
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Apr 2023 14:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3mFOt001pph4ZFjh5op6TvkmvLo9FO+BniOXvTOhuBg=; b=JpjDZJn9y+kLTdtECeKpuznBh1
        78AovN9RPfqnbKTG+sZ2u8uNQWVI1ACtgsGp8IggU8+unWa4njnQEAwb2fxdFNkLIoJz7JlkISvRK
        p3YYRpHKt+zpmhQxAMEA3TYr7aWBJMsa62M26VGTNePQdn7CkZmg1MykJPJi7dR0oBPvhgBG+nmeh
        aNda1ILf5alu40LE625gQWuJ96Aw1pSMKHN3m/T6Z88z/kyaUGUjX4DFQs+VjFyzKmW12So734VGa
        oByyL+quXJeE3qyV54vgjQOT2xR1imopmlVn8mIjnCMfYGs1A+nQZIqqvxJ/4nNOy72AstlwBe+eB
        y/XKWuUQ==;
Received: from celephais.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:3c21:9cff:fe2f:35f] helo=celephais.dreamlands)
        by kadath.azazel.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1prPab-009aLz-I4; Tue, 25 Apr 2023 21:48:41 +0100
Date:   Tue, 25 Apr 2023 21:48:40 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jan Engelhardt <jengelh@inai.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Kai Liu <kai.liu@suse.com>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: netfilter: fix a build error on openSUSE
Message-ID: <20230425204840.GE5944@celephais.dreamlands>
References: <5ee95e93a11a239df8e09d059da25a4eaa5725ba.1646198836.git.geliang.tang@suse.com>
 <8cbf1231-0da5-c8a0-d66b-1488633d9895@linuxfoundation.org>
 <Yh+wulh/nIkFeFmz@salvia>
 <sr67066-o9or-1s32-pp7-s764r386n55q@vanv.qr>
 <ZEgArba2jGAGy0/Z@calendula>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qLqTDRbgXsuHCJND"
Content-Disposition: inline
In-Reply-To: <ZEgArba2jGAGy0/Z@calendula>
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:3c21:9cff:fe2f:35f
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--qLqTDRbgXsuHCJND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2023-04-25, at 18:32:45 +0200, Pablo Neira Ayuso wrote:
> On Tue, Apr 25, 2023 at 11:14:55AM +0200, Jan Engelhardt wrote:
> > On Wednesday ** 2022-03-02 19:00 **, Pablo Neira Ayuso wrote:
> > >On Wed, Mar 02, 2022 at 10:11:11AM -0700, Shuah Khan wrote:
> > >> On 3/1/22 10:29 PM, Geliang Tang wrote:
> > >> > This patch fixed the following build error on openSUSE Leap 15.3:
> > >> >   nf-queue.c:13:10: fatal error: libmnl/libmnl.h: No such file or directory
> > >> >    #include <libmnl/libmnl.h>
> > >> > diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
> > >> > index e4f845dd942b..8136c1fab7ab 100644
> > >> > --- a/tools/testing/selftests/netfilter/Makefile
> > >> > +++ b/tools/testing/selftests/netfilter/Makefile
> > >> > @@ -8,6 +8,7 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
> > >> >   	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
> > >> >   	conntrack_vrf.sh nft_synproxy.sh
> > >> > +CFLAGS += $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr/include/libmnl")
> > >> >   LDLIBS = -lmnl
> > >> >   TEST_GEN_FILES =  nf-queue
> > >>
> > >> Adding Pablo to the thread.
> > >> This looks good to me. I can take this through linux-kselftest tree.
> > >> Or if it is going through netfilter tree:
> > >> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > >
> > >If this does not cause any issue when running tests in any other
> > >distros, then it is fine with me.
> >
> > Since a pkgconfig file exists, it ought to be used. That also means
> > you need the same/similar incantation in LDLIBS, with `pkg-config
> > --libs libmnl`.

I would also avoid hard-coding pkg-config and remove the unnecessary
SUSE-specific default for CFLAGS.

> Patch?

Following shortly.

J.

--qLqTDRbgXsuHCJND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEbB20U2PvQDe9VtUXKYasCr3xBA0FAmRIPKgACgkQKYasCr3x
BA26gRAAlr17yFl82bk3zD6LVCFcVdp5Zm1jQD6JwO03yTL1J6LR135pOqpqBNNp
KzOCa8yd0Ziecq74F6i8G+A9Vl+JnO67KqzSxzy2FN8AUC7TncqjCh4TjinBQ1cB
9XiKnlnqAs2a57/E2WEIAmhH/o10mm43LU6CAUi+o1/4+DyltMyJFRrH9lJvvaS9
oMTE4C1CvTRhZTuhJID/baDPTx9fCdY7xMolVPhNGK+ZVCTwJbtEEcruPHap1knU
nLgKYBBYQw6hzXR+MA935WtPZoqkXTCr/gjlllbAo/w9nZclp8GUL4LYn+wQKGKp
A8Cg+c6Yr6shys+nUTCW74vS5++c4Z5mwrNqSmCNKFZA7oUfgqteIi938aKOG4TV
h2CPs6oNZ5idyjfwu8dUBipO0b9kTaGv556YMiJYYYxbINz1mFia4iT7BL2IHtf7
UVF/n+sp7Ro6Dp2B0x28ysmD0g0+kpwVRS+rMYSAPS0bN+Peit0Me4bgDHy065st
Ah81/qBb5dhsTdKACZQx1eKHImtCztJmhd/pZq5ewUAfqHn7jM8j7A4Z+dyUhmK2
9NK0eow30Rl+W3j57ODoThQpoKJn/kds6wTUGUp5lU75ASv5/STMtVXHB5mdt/pR
X7bAfpD07LGCeUb2YY3xkFjUWMmK44JrAl7oKnJ3uEiPMkh9Awk=
=hQnQ
-----END PGP SIGNATURE-----

--qLqTDRbgXsuHCJND--
