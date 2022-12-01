Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6675163F920
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 21:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiLAU36 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 15:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLAU35 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 15:29:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA675A1C23
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 12:29:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55D5FB81F50
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 20:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FA4C433C1;
        Thu,  1 Dec 2022 20:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669926592;
        bh=Od0AD5DBVzEiXrFV85VI5bd5miG2W796RKeGwL2sr/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOEws95xl5zLJaZb6aIAVA2mfdtDGM4Ib/f7wD/4DO0SiseRZQQSJ4nKQbO3N1+2c
         Vwjzm/beXXkoikLJdNN6szSogF7JSYX5pmJOhMUzWQGXZ55okTJrHT046XiaU63zn0
         21wEl9j4NLXYdHF7DsPzob28jBCqcSl6mlsluvztvS3zgUPTElAcIk/jDHVPqVQnUy
         ZrFTPSAWlmjNbJSkaUjIl50DHSBTQ1y74Kz6mw77+pusQFvQwo+PofYZCZnagrODxl
         TgU0yWG2yA1xlHhlho58lQiHEoYs1lKF/uZf1Ob+LxoZizVB5fjPx2oc24xxqxTgxa
         J5NAit4zKf8Lw==
Date:   Thu, 1 Dec 2022 20:29:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Shuah Khan <shuah@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/6] kselftest/alsa: pcm-test improvements
Message-ID: <Y4kOvNi5I8/GK1yU@sirena.org.uk>
References: <20221130000608.519574-1-broonie@kernel.org>
 <a55212fc-a676-2335-b861-94ba8d10f207@perex.cz>
 <87359zlz9t.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YYXR5ynsa7QqFwTf"
Content-Disposition: inline
In-Reply-To: <87359zlz9t.wl-tiwai@suse.de>
X-Cookie: Leveraging always beats prototyping.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--YYXR5ynsa7QqFwTf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2022 at 08:06:22PM +0100, Takashi Iwai wrote:
> On Thu, 01 Dec 2022 18:42:22 +0100,
> Jaroslav Kysela wrote:
> >=20
> > Let me know, if I can stack your changes on top, or perhaps, you may
> > be willing to adapt them.
>=20
> As Mark has already sent a v2 series, I applied his v2 at first.
> Could you rebase and resubmit on top of my for-next branch?

Oh, this is getting a little confusing - I'd just picked Jaroslav's
patch into my tree and was in the middle redoing my ideas on top of his
code!  I might have something more later this evening...  I think we can
converge here, let me continue taking a look.

--YYXR5ynsa7QqFwTf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOJDrsACgkQJNaLcl1U
h9C/WAf8CLgm6NcrQknYcMIw1V3IqwqHTcxlDhTiq4NYafIjUOMXWaNSJVtPgu1V
TbroqPWv5McRKkXzB87ZKcwX6ITGMpDHbUjKqIBgt9Q9TrJF77GVYomDGPoQpHuz
btGf+zLCPowAeW6X2PUeRkP43VFOvDNbnzePJULqc4YJCt4+0dNwy32y+gRQeu+1
feYBc/B8GnmdzqKDZkFqtZfZN530GBDWJBAALk9E4OCrxGd/U4ZAk8Xk5rb+a5SM
4nUx3ypoUWVA6QXvVTMmytD956ic5bYtbX/FqRpYs+Wmc9RBe6O40TAdhvMuw4D2
z6UttiUWsHorXMYSBUhQvBCQX9kQYQ==
=3940
-----END PGP SIGNATURE-----

--YYXR5ynsa7QqFwTf--
