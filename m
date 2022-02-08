Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082614AE1BC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 20:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385683AbiBHTAd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 14:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385702AbiBHTA3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02386C0612C1
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 11:00:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99CFFCE1C16
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 19:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E1C004E1;
        Tue,  8 Feb 2022 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346823;
        bh=qrS1Vlr/4mU9OvdM6IQ4PpO1KsGpMz/etCIFE5XJCqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVnBtXEQlxYHtLZxmvqA5oTtUzHJ4yEDraZ4v4d012OkoofVcc47uaMnwH6yx5GjX
         uJDsXfCowOs23SBSSkPCmNVPSwBF2VtIVIGZnBnLKqR9HcSzrGcv2HCCkVN37ZMULO
         cInvSPyP1+a6U/BAS80UCJsiEMv4EZfIuPlqYMC0BnVQ561jkVebGpdysNJgYVvo2a
         Nxue5p7KtcpIJckPlzsLmGi6EPSqTha6MTJJaAlywaY03r4MtKhgUg6nTSxJPDTUE4
         mCnYIyqmBV6hcNF8vMpecMvlklE+cuhzp05aBZ7TYyIrkAKLob/lnZFnC9Jl3qLHj8
         jvFw6n3fRi9YA==
Date:   Tue, 8 Feb 2022 19:00:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v11 06/40] arm64/sme: Provide ABI documentation for SME
Message-ID: <YgK9v7u+FcBTB1ur@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
 <49da0f58-7a20-e557-54c3-34bd7074f711@linuxfoundation.org>
 <YgKQTLwW+ha5XNx8@sirena.org.uk>
 <YgK4kKrSs6e9seG8@sirena.org.uk>
 <e6d76104-b7f6-1588-d734-1a09c2990299@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aKB5IBghvV+gkZZ7"
Content-Disposition: inline
In-Reply-To: <e6d76104-b7f6-1588-d734-1a09c2990299@linuxfoundation.org>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--aKB5IBghvV+gkZZ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 08, 2022 at 11:48:39AM -0700, Shuah Khan wrote:
> On 2/8/22 11:38 AM, Mark Brown wrote:

> > I can't find any free format plain text files with SPDX in them, even
> > really prominent stuff like README.  The process documentation is silent

> There are about 570+ files under Documentation directory that have SPDX
> including Documentation/index.rst

> Based on a recent doc patch I did, I have seen warns during doc build
> about the missing SPDX.

> Let's add it now so it doesn't need fixing later.

Sure, there are lots of structured files in there like .rst ones which
have SPDX headers but this is just a free format text file so it's not
clear what if any format to use.

--aKB5IBghvV+gkZZ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICvb8ACgkQJNaLcl1U
h9DU1Qf+KAR7JeDHRsKJ/YQVuWJcSDE6c6z2Tjf8ZwPHn682/7koBB6v58r8xLbN
69vnZXlSXj1UmmxwFM6tkXFVhIbUWiweizW6bEJoL1WeBe6EJixIFuO2DjnxW3aA
W0PrLVnZN/gZ6NfsWv69eCm0iz+PNMiXPZNRsiKevMfgg4PFE7D9z+RxcPgvr/A4
1YCQ0iEpzk6DcZfoS1iFvfVWwg8JLyzcEJLMs2jTxh933B2ivGIDqNJ3cuCP2Pg3
jdZB8S+Q2ek2xVgEVvDmeuramzooZYZpVXf74oUv1xE7yk37rP+38xE3Fla4SKIG
GZIUDpV2xEu9zmqt9LFENTQYxy+X/A==
=N8EW
-----END PGP SIGNATURE-----

--aKB5IBghvV+gkZZ7--
