Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A975AD0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 13:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGTLfJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 07:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjGTLfI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 07:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CC2E43
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 04:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BC1661A44
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 11:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A46CC433C7;
        Thu, 20 Jul 2023 11:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689852906;
        bh=nCa/1RnSN1PvAEqgZ6aBg7wOWjtKMWsXJd5ab65Fd4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLPZcIE4fJNecqV+OQQNcp2ow6XvQ5cQlpBsSlRjZkeYbBvtgEwpC97S7QEGt18ev
         PK9Du22sqZc9dKNubjxc1N3h6mSKTvpMAD2dLbmPhLuZd178fH+nYturxidi3gIddF
         KYiGTB6z16jRf5/Fs4fLTWTemNsC9cfEbrO0GFfNfOAk8+/5jJUgp10CR4yIiGyG4o
         NX4GJIA9+e4XDK261EUf8wIwsu3Wxx2xX4NaQhni1ePoNiTG4t4Y27vESsRO7SIxwM
         TEDfffhxTXO7sL2ptOwI2pIF3x31y/z6BtG6cA02tM4WFVMbc/yGTbbxaDM3p3cL2e
         J+ZjBZcI5yGYg==
Date:   Thu, 20 Jul 2023 12:35:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kselftest/arm64: Exit streaming mode after collecting
 signal context
Message-ID: <037425cc-bf17-4dfd-8bdc-c1c10b153ebb@sirena.org.uk>
References: <20230712-arm64-signal-memcpy-fix-v2-1-494f7025caf6@kernel.org>
 <20230720103113.GA11034@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aTvBd9Kod+7PIAg3"
Content-Disposition: inline
In-Reply-To: <20230720103113.GA11034@willie-the-truck>
X-Cookie: Ginger snap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--aTvBd9Kod+7PIAg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 11:31:13AM +0100, Will Deacon wrote:
> On Wed, Jul 12, 2023 at 12:02:30PM +0100, Mark Brown wrote:

> > +	/*
> > +	 * This is a memset() but we don't want the compiler to
> > +	 * optimise it into either instructions or a library call
> > +	 * which might be incompatible with streaming mode.
> > +	 */
> > +	for (i = 0; i < td->live_sz; i++) {
> > +		asm volatile("nop"
> > +			     : "+m" (*dest_uc)
> > +			     :
> > +			     : "memory");

> I don't think it's save to use "+m" here, since the compiler can assume
> that the address is used exactly once in the asm. If a post-indexed
> addressing mode is generated, then you can end up with register corruption.

> Stepping back, why not use either barrier() or OPTIMIZER_HIDE_VAR()
> instead?

That should work.  I was mostly just open coding OPTIMIZER_HIDE_VAR()
and noticed that memory constraints were a thing.

> The most robust fix would be to write all of the streaming mode code in
> asm, but I can appreciate that's a tonne of work for a testcase.

It's probably more proportionate to add a dependency on toolchain
support for SME, but that'd mean we hardly ever run the tests.

--aTvBd9Kod+7PIAg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5G+UACgkQJNaLcl1U
h9AozAf+OH5Eqn23Qm+63ObiLCOwb5H7h5wUqULh0kqX1taHNghmkpmsygGx4+At
8pix9qb7n5Bsdf3L1AUVx7CQVC51tdK5wAvDHSp0SzHH6a0wZUQwVn+4dvoMEsHq
Q9GcbWrnsiel90Qqm3Pm2YaLNFo8pTIaK5GIqxcgT9n7pOQzRAcc3ixUnJE5Xy25
f5bwnT6MdzT5TXsT2nZ+wEx0TgfzS9Vg7qrTDhbOBlC+G3XJIwF2VPZkMO8JxBQ7
UsLPZ2Uj91aIXkTAcWKt8ZXlX7fnFJJUR5ffUTTYOsUPDGGqCt4kcC1CF9o5iang
R01HmQW1d3sWP7emrRY5/9DsVM2xuw==
=ys6l
-----END PGP SIGNATURE-----

--aTvBd9Kod+7PIAg3--
