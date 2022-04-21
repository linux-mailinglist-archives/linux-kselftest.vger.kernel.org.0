Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BE509FC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 14:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352702AbiDUMmw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 08:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382296AbiDUMmv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 08:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469C3BF47
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 05:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D768661BCE
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 12:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0BAC385A5;
        Thu, 21 Apr 2022 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650544800;
        bh=o11R5hwjSfUkooG6aTnJOb4+mrujki8srLF/y/Ayj5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYJkQkKwoTyGa0ulPg1rE265+urp7kMJQvj9//k4VdiHqGOUDT83PQM/6vihrqhZf
         SehnMN18VT2D2JqWpMaenqmwkYqNdJV7DpUFN7RXsgqoNbXi/GL86GN9aQ5DlCBaVu
         vLW8OKLXmMi8gbbJu1rrtSCiIlRMknpmBSkq5c0qV4SAdHuGeQxmu19REDBUw86l3m
         Upntzd4ub0sAYiKDn2lKkSReoqY8s0WrG4b71Ptl78lghUphpXFgVJ+5fd7iUOMDLM
         2zIpVe9u9izJyNDTAIQ7Zy3/1l6fch60A9Yl1ipwTPgZxBgI9bVrTc3jgqyCf3WesD
         wSz1RQ0xicC2w==
Date:   Thu, 21 Apr 2022 13:39:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: alsa: Start validating control names
Message-ID: <YmFQm8xtgjMurBB0@sirena.org.uk>
References: <20220420203320.3035329-1-broonie@kernel.org>
 <s5h8rryx4c6.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x95ZG5vdA0TpYUkG"
Content-Disposition: inline
In-Reply-To: <s5h8rryx4c6.wl-tiwai@suse.de>
X-Cookie: Two percent of zero is almost nothing.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--x95ZG5vdA0TpYUkG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 21, 2022 at 09:50:33AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > +		if (!strend(ctl->name, "Switch")) {
> > +			ksft_print_msg("%d.%d %s is a writeable boolean but not a Switch\n",
> > +				       ctl->card->card, ctl->elem, ctl->name);
> > +			name_ok = false;

> I'm afraid that this would hit too many when applying to the existing
> code; although the control name should be indeed with Switch suffix,
> we tend to allow without suffix for casual non-standard elements.

It wasn't looking too bad in my survey of cards I had to hand - the
writable check is there because of jacks, which does make sense since
you can't actually switch them.  Some of that is due to ASoC handling
this in the core though.

> But having the check would help for avoiding such a mistake for the
> future code, so it's fine to add this strict check, IMO.

Yeah, that's more the target here.

--x95ZG5vdA0TpYUkG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJhUJoACgkQJNaLcl1U
h9DhIQf+N389H3wgNXpD0bo1p+p0J6C/m3tiBfLE8K/+AMDSkJPsDEwmPzHlMHeN
gjCBVTb4m0bm1zikekh4e/zDNApl2zNCxKQGHM4kdRqKLBIkWqcwcnBVTV9Z33H3
1QDpFA//vZ9F8dQUCaoL/zVnnc+YijWS8bzvYHo4H1uVkBxHGzDPedVDf2NXklsN
Ga6WA7TxumkWMavyT0o2364P/XBNDq40XQhEn+Wo0UFN4JRpwNjKvPnn3FyqVyNe
aJ0EKmIL1SE1xesFyaurKJrNRPxl6e4V7ozcPMN//RAl3wMSp498ISf05D6oLk4S
2iEEiJv8kSpUHdHlOZ2z/3C8LENdlw==
=/U6j
-----END PGP SIGNATURE-----

--x95ZG5vdA0TpYUkG--
