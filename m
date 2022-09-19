Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD01E5BCC0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 14:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiISMnS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 08:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiISMnQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 08:43:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FAB286D8
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 05:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC12861469
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 12:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583ABC433D7;
        Mon, 19 Sep 2022 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663591391;
        bh=xubF7UIf4sms6tUtciPbXSVKcx2KG1MnBipEbzARGPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Poe3RsUSi+6ateCqLBtsh1o5im8WS/+n37eEhTRa7wewqoaZeUCM8aqtBP0nA+XKw
         0Nl+7xLMl7JHLRGdQ2n/tB1Giy+6AdvrFumpUKjI676piWMATvZncChuBYiJ14hYSa
         iQtR7GcM0c3pV1r+3pPc+dMjY+M6/hiFkmspUaI8kmMSUSuuBOYwsuvUnkKVQmM7oc
         a/2xKH6F0BGSCC/AuT+QsOJQPrT5otdKAAVre7lBRDjV3EI6ND1mB04qQANF6rk+a8
         5j/wUENzm1V/bTrCzDMRaPIWnYaw6LSsCgVz72TVGI9hgbW93u9P5PwkUPEXoL401s
         mC5eKvrFXQNPA==
Date:   Mon, 19 Sep 2022 13:43:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/4] arm64/ptrace: Support access to TPIDR2_EL0
Message-ID: <Yyhj2kEtJcSSngd2@sirena.org.uk>
References: <20220829154921.837871-1-broonie@kernel.org>
 <20220829154921.837871-4-broonie@kernel.org>
 <YyRlm/koy30sze9Z@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w4DP0KkHF9ha/i1B"
Content-Disposition: inline
In-Reply-To: <YyRlm/koy30sze9Z@arm.com>
X-Cookie: A mind is a wonderful thing to waste.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--w4DP0KkHF9ha/i1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 16, 2022 at 01:01:31PM +0100, Catalin Marinas wrote:
> On Mon, Aug 29, 2022 at 04:49:20PM +0100, Mark Brown wrote:
> > @@ -1392,7 +1407,7 @@ static const struct user_regset aarch64_regsets[] = {
> >  	},
> >  	[REGSET_TLS] = {
> >  		.core_note_type = NT_ARM_TLS,
> > -		.n = 1,
> > +		.n = 2,
> >  		.size = sizeof(void *),
> >  		.align = sizeof(void *),
> >  		.regset_get = tls_get,

> Does this change confuse user-space? I presume an updated gdb would
> check the iov.len to figure out whether a new register is available but
> would existing debuggers complain of the new size of this regset?

gdb seems happy as far as I can see, it is possible something would be
reusing the read_iov for repeated TLS read calls in a context where it
was only pointing at a single u64 but I'm not sure how realistic that
is given the idiom.  I did do a search on sources.debian.net and didn't
turn up anything that'd have problems.

If using this as an extensiblility mechanism is a concern we need to
bear that in mind elsewhere, and for this it's either a case of
providing another single register regset or trying to do a generic
sysreg read/get (though that'd be another regset that's not idiomatic
for the regset API).

--w4DP0KkHF9ha/i1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMoY9YACgkQJNaLcl1U
h9Aupgf/cAjeZR6wVXQRVOBiUmkfNme1ZX7mxZuW6+M85ld4h3coorYONQm6qwe4
f9vU9hiY4Sg8XYLrM+WFaMaEP7kerPhCziiN7vedH8/CfQFyGN4uoAObGsqQFusq
i8ylTdNsHD1bWZOf/G8HF4dEkboEY4VzcEHRm7NSTxwJPjUsk2iDWCQTxGXsrWUT
Lfca1ypJEIHitpNwPhCR2LWKSuUjUvtGdn8ISExkF30eE7hlXqE5Hznd2QYlV53g
4HINRLND1C8Slf/lT5Rwg11iwVfRD4fJQeSaecwf0B7toNfwpUPbK2UKFdt82Kjh
LnnaG4QlOMkJxxqVbJ3XrZpccd832g==
=9ndx
-----END PGP SIGNATURE-----

--w4DP0KkHF9ha/i1B--
