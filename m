Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26D659837D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 14:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244458AbiHRMwl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244650AbiHRMwj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 08:52:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924CAB2870
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 05:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FEDEB82166
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 12:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EE2C433D7;
        Thu, 18 Aug 2022 12:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660827156;
        bh=RwH8S9SDmFCmwGSo3Je6Tinq2K+YrZSsdjrVe5CJT/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PK54oje4qtPTtqf4IG/Nl54nZH9E9SUNUmtudt3ZgxUk6ZAJXVy35rXsNinYU2ulx
         k4RMRRL8ug6lEA0ur55rUFelx5oWU6PE8+rcm8J34l7i/1Lvqxze19229e7jThPWwD
         uGkolZ83g+1a0RJkiFzbrusU+6FGEHhZA4AnoUsoaZCqAJ/9eTv1FfU3lbNIwJewsj
         wTjxSMvp/1DId8P5pbEOzb+I+KE2bBhYTpqbG36BJeF9CClEoXZ/W7puaSxewNGh5z
         ZHW/3LUBUsdnUXFaJ5AVXzdEFtQq2bNkWiai42vZAOaL0HAQadlgqF6zyqgUMPeO7U
         5Dhu6/dWzi8rA==
Date:   Thu, 18 Aug 2022 13:52:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Luis Machado <luis.machado@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64/ptrace: Document extension of NT_ARM_TLS to
 cover TPIDR2_EL0
Message-ID: <Yv42D690DE6uLYT1@sirena.org.uk>
References: <20220815133034.231718-1-broonie@kernel.org>
 <20220815133034.231718-3-broonie@kernel.org>
 <4cf1c8d9-4aa8-dc1c-a568-69d86b706a60@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RMT/Ns3+MdHQ0cED"
Content-Disposition: inline
In-Reply-To: <4cf1c8d9-4aa8-dc1c-a568-69d86b706a60@arm.com>
X-Cookie: Logic is the chastity belt of the mind!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--RMT/Ns3+MdHQ0cED
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 18, 2022 at 10:17:11AM +0100, Luis Machado wrote:
> On 8/15/22 14:30, Mark Brown wrote:

> > +* The NT_ARM_TLS note will be extended to two registers, the second register
> > +  will contain TPIDR2_EL0 on systems that support SME and will be read as
> > +  zero with writes ignored otherwise.

> I wonder if we should document a bit more about the use of TPIDR2, its states, values and
> block format when TPIDR2 points to valid ZA state.

> Would that make sense?

That seems somewhat out of scope for the kernel, it's doesn't have any
idea about the use of TPIDR2 and I'm not sure we want to give anyone the
impression that it might try to do anything clever with it.  From the
perspective of the kernel ABI this is simply another TPIDR that needs to
be context switched, I have heard some suggestions that the kernel
should try to do a spill to the TPIDR2 block allocated in user memory
directly but that feels like it's getting a bit more hairy than we want
and problematic for anyone doing off piste with regard to ABI.

Also note that the spec for TPIDR2 didn't get merged into the PCS yet so
it's not quite finalised.

--RMT/Ns3+MdHQ0cED
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL+Ng4ACgkQJNaLcl1U
h9A8awf8CPXR0u2kz8uVPL9Cjww9E8QzK/nP+nNHQ467l1r0SiGRn8EaucZTyLlb
l4GK1wi1taBj+gp/zBP0FkgWDypgnq6F05IMW5Lwf+Q7En73zt/yIs4fG98UeHv+
DZsy4purNigpS52b/n6fhkm5bBjGF6w7YhpemksaLrZALbCnlrms2Vv9FGDlejDo
3fe8yn8EAPbihqiQehRAXZSeHu0blSBeHS5zfj1Ur2RjZ8hw65hTrDeCcGOElqN+
sGZeJpHpkknzDcWNSswUAsqS77lXSSqiqe+tLFknuBYc+NEkS8hT588ys1aO30CI
bVnPFDhhfeAf2usmRQFbeKoGUccrUg==
=29dR
-----END PGP SIGNATURE-----

--RMT/Ns3+MdHQ0cED--
