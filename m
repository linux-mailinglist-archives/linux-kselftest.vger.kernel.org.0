Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBDC4D6897
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 19:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiCKSoJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 13:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCKSoJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 13:44:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3271FA229
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 10:43:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AB8661ECA
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 18:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C86FC340E9;
        Fri, 11 Mar 2022 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647024184;
        bh=RrVVysxT2emlyWxm/g1Qt6qpkNRxKkUnB1UtTlEBZDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0hx8kaQOvPo5d+JsID8DCUcRVYA/9JKlWUTHoBde4H5v1q075qdsyCzzqxNWI9K6
         Uipf6JGi2OaK696PkyT15/gNPYEc2ka3zdPQXuxlsgPsgdZ6FTq2QpFTFbbyln/jqg
         gLjfMUDNwHSuDnoqIETI4CG0Eq+fngWjrel1N+vYwJACTw96c9D93J9EDfvDnMSHB+
         bwWKB+pFMbkFxLzztwVrBASUK+GUuuObfWH5orW1KuQfgOVtrkJrIxb0Sq1Fjl6WKd
         jVswPChCJQnoob9dOVcAvSAvcRMXwEZZ3qhXFwrkZ/T87uadesCom/b6a/0bMBzpTw
         gSFDCxmTM15bQ==
Date:   Fri, 11 Mar 2022 18:42:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Luis Machado <Luis.Machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant KumarDwivedi <Basant.KumarDwivedi@arm.com>,
        James Morse <James.Morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Subject: Re: [PATCH v12 06/40] arm64/sme: Provide ABI documentation for SME
Message-ID: <YiuYMcR8zk73eBLo@sirena.org.uk>
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-7-broonie@kernel.org>
 <20220311172051.GA257833@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P5FpQBAMTKNjQe4J"
Content-Disposition: inline
In-Reply-To: <20220311172051.GA257833@arm.com>
X-Cookie: A fool and his money are soon popular.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--P5FpQBAMTKNjQe4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 11, 2022 at 05:21:21PM +0000, Szabolcs Nagy wrote:
> The 02/25/2022 16:58, Mark Brown wrote:

> i would s/SVE vector/streaming mode SVE vector/

Done.

> > +* On creation fork() or clone() the newly created process will have PSTATE.SM
> > +  and PSTATE.ZA cleared.

> is there a reason why fork() clears ZA?

> i think this is a minor issue, but the usual expectation is that
> on thread creation thread local state is reset in the child, but
> in a forked child the state is the same as in the parent (where
> ZA is preserved according to the first rule).

It was partly consistency with SM and the SVE state (though that is also
covered by just being in a system call unlike ZA) and partly concerns
about what happens if the fork() happens in library code which isn't SME
aware - it would end up carrying around a copy of ZA with associated
power and performance impacts if it doesn't exec().  Overall it seemed
like there would to be less potential for unpleasant surprises if we
consistently discard the data.

That's not a *super* strongly held opinion though, we could switch to
preserving whenever we preserve TPIDR2.

--P5FpQBAMTKNjQe4J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrmDEACgkQJNaLcl1U
h9CtVgf/emgab4posEBW5QNnCwbr98z+484BhiatXjbXYG6tH0E7iQUHCY53CcUB
6JHVU8laUrdAOY8Uya/zJp0U0ImMViJSoOuOlmXRQbJwarTl8N41LEYcGRA1fN1G
PH9dIgTiIH7450skNgveMIyowlOYNRTbx5VorbMMjpI2W1KVNXiIkv5ceZeuJCB5
Vt8tpy5w0fZIBf7E3MvvuX/dCRmLIt9HYjm89c8R2khh08EOTybNnCW1N6qVha/4
uryFjdSIVmtHtY8JdOuYtoPVjSBeQSNETHTVEJBEAw9TtEy5CegR637koRZcX9dk
dmCp0qt6sIrDte8ZT3efTMlXQTUQYQ==
=Yz0U
-----END PGP SIGNATURE-----

--P5FpQBAMTKNjQe4J--
