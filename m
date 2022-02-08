Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7674ADFA3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 18:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbiBHR2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 12:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352331AbiBHR2H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 12:28:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF6BC061579
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 09:28:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34436B81C9A
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 17:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BABC004E1;
        Tue,  8 Feb 2022 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644341283;
        bh=7M78n2BSeNntKAqSjER5zwyE9f1sv8EH5+w1mbaj1iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMEYLluKyfi9s/rlUd1EMng/q2lXe2UFdyG0sIWAjFnBs8rTKalB/U3N1P1zRwL5Y
         VruEK7BthjSGMnzmRj5WVyBx5S2t2dw57lFDHMt3NcZ+Y+Vw5xW5iiUazWx3WnZ4JC
         2Bctbc9ObaXbCoH+26iwm+RA0F4F8ePiNqFITnPcTIdXJOkY1GKNylegYbOrCZRl/x
         SdNChP335kkTVVOhfve0qX07LJafF/mVJSnmbR6srER1ENuoTwr09AXpK8O3K+XMAm
         7zJ6dIyeVG48mOZT8qdnbouIh1GtRKkaUj/E2+hVLNDZXaMfkvSmWvUlPFP87GTSNe
         IygPTNraLyqaQ==
Date:   Tue, 8 Feb 2022 17:27:57 +0000
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
Subject: Re: [PATCH v11 37/40] kselftest/arm64: signal: Add SME signal
 handling tests
Message-ID: <YgKoHQYJUugKuVpA@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-38-broonie@kernel.org>
 <07428054-99b5-1bc7-ca7f-938d7c2198f0@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BMjsxloECH/PlBMs"
Content-Disposition: inline
In-Reply-To: <07428054-99b5-1bc7-ca7f-938d7c2198f0@linuxfoundation.org>
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


--BMjsxloECH/PlBMs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 07, 2022 at 06:08:06PM -0700, Shuah Khan wrote:
> On 2/7/22 8:21 AM, Mark Brown wrote:

> > +static int sme_regs(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < nvls; i++) {
> > +		/*
> > +		 * TODO: the signal test helpers can't currently cope
> > +		 * with signal frames bigger than struct sigcontext,
> > +		 * skip VLs that will trigger that.
> > +		 */
> > +		if (vls[i] > 64)
> > +			continue;

> Count the skipped VLs and print counts - helps see how many are
> skipped.

I'll print a message when we skip an individual VL for this reason.
Note that it is hardware dependent what vector lengths exist in a system
and that it is expected that many possible vector lengths will be
skipped - the enumeration algorithm means that we don't explicitly step
through most vector lengths but rather have the enumeration done for us.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--BMjsxloECH/PlBMs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICqBwACgkQJNaLcl1U
h9AUlAf+IM5Fo2PWtTTieplDrXQsJPA6dNg4eg+Q7C74WKURE4LlXnTPeU19LiN5
v4NAL96nBsSu9Y6QfNBbxU0ebTyL7fCPlbXJTlZKqFd5aTBZRLcHXGQL70Cj+OlT
trKqYnzlwYyag7gFp3O+ptXl63pejSw+xe0GrSG47HsulTwCEOg6BdjsTAK/KIme
10ZAaxK0Zky+mulGwZrd8DVuu8ZccaYzL98z72b7ZapfEC3R0b3EnHqp7mAfUw6k
eAAl9OR+WV0ZzklgyAJjBw6HWWckzoPD2fl7H55JHxKzWPZFK8Yn3LjZo1TINerG
qStj1dko+Iw36iXGVEwjMbVeBkyxCA==
=X9it
-----END PGP SIGNATURE-----

--BMjsxloECH/PlBMs--
