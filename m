Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1369562594D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 12:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiKKLZ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 06:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbiKKLZz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 06:25:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9896A657D7
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 03:25:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42E7DB825CB
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 11:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58B4C433C1;
        Fri, 11 Nov 2022 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668165951;
        bh=NSGp+t/cYbqzP9NboubkUof5HSwcO521fzsQ5UgfFKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIOvlAagj4lX2hbiqemYIjpAGUJCUgW3/BUMwuPGn3k/IKHgMk19KR8452XS0awoe
         99c9Zj9wg+EHCyBcFbSg2xGcQhDrtVbeoEleK/OA4vM04sV5SrRsy1EFuDOLefnQ5c
         QKssYwZpZZDfXyFo1EM1eoXbUFzlI0Ym7/4wvtvemZmseRj2dvr70ET8E3vU7TiOMX
         aycqT/0HycvRZBOGb+x1tI7BMDDNRTP3uK5G9HWzJsqxI5Js++0ru99TBEL41PBtRE
         VU3houzy7V5pr5Mc2kbSajnJUmPJTCfwDoO3BVgTjr3jPMTGVGsfbNT2k0RSM06Pk8
         yMlp1o8PwUmyA==
Date:   Fri, 11 Nov 2022 11:25:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luis Machado <luis.machado@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@foss.arm.com>
Subject: Re: [PATCH v2 12/21] arm64/sme: Implement ZT0 ptrace support
Message-ID: <Y24xOvptKkU8XT6X@sirena.org.uk>
References: <20221101143336.254445-1-broonie@kernel.org>
 <20221101143336.254445-13-broonie@kernel.org>
 <5d832654-c196-2c6d-9bb1-61feb2a81fb4@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i0XX0fU2YjPoI6L3"
Content-Disposition: inline
In-Reply-To: <5d832654-c196-2c6d-9bb1-61feb2a81fb4@arm.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--i0XX0fU2YjPoI6L3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 11, 2022 at 10:31:00AM +0000, Luis Machado wrote:
> On 11/1/22 14:33, Mark Brown wrote:

> > Implement support for a new note type NT_ARM64_ZT providing access to

> Should we use NT_AARCH64_ZT instead? This would align with our previous choice of PT_AARCH64_MEMTAG_MTE.

> And we have a precedent with PT_AARCH64_ARCHEXT as well.

> >   #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
> > +#define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */

> I guess the above comment means this would also need to be NT_AARCH64_ZT, but historically we've been using NT_ARM_* even for AARCH64.

> So I suppose this is OK.

Indeed - there's also a lot of NT_ARM_ defines, including all the other
FP defines (NT_ARM_SVE, NT_ARM_SSVE and NT_ARM_ZA) and PAC.  It feels
better to be consistent with at least the other FP stuff.  It's only the
MTE define and the .note.gnu.property stuff that's used AARCH64, and
things like SVE are fairly old.

--i0XX0fU2YjPoI6L3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNuMTkACgkQJNaLcl1U
h9Bz0Af/WeIBFKiLlFw4DpXAPX6dlJDM8MStcPSQXt3Aweuu7QYmLJVoeWqRqUVX
AdrwLR7eA7yM3+ioyddhHjFIfmCAbNKHTqtmsIqzmqqeknZdGNwLUW1zPnjhFMnh
prME9dGRl+HaVH3UuAx5zfiGpbmgSxDyNI+pJmPfIar/737NqVF6ua04N9PpKBqJ
QDydOQqQPD+2TguKT6yYuRtE4lsq8phWpr4O5JLN9m6dMIm/wokb2uyJ/4FH+iKp
sRmoa6Ao9PUhRMKywIcBiIjh7h2Gnel24b8HKGD47fDLpBq1SxJxfMcoj/6/s0gM
afsMI45TN/I1kgmCb57jiTS9Igj00Q==
=dB9d
-----END PGP SIGNATURE-----

--i0XX0fU2YjPoI6L3--
