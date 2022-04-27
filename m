Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDBD51251F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 00:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiD0WQp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 18:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiD0WQm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 18:16:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8303483000
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 15:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1257A61E2B
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 22:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44740C385A7;
        Wed, 27 Apr 2022 22:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651097608;
        bh=hVI7V6tAgi1A90bdp9aCrTZJAYccb/n9NxF5+xjLUts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nbah56KvoPPS/tybp1pv9Rg4dqKVf6B9xBDOxibS/qOtqQKLnOGQNU9VSofJ6NO0D
         C4kZUal7Kvxt61U7EROjPEM/MkxWYkrH8plTAHYzDmh1vzGRDqbpfkyBzidS3dp16H
         QfKAENUQGnygJ+fbhgDIaxO4xSlKQARbtEuaQ2XAUY+fv9OS1hXU1lLpF7B9rPxSNZ
         wWEIejxtfnns7LPd6v0LSre5wJ8sRx0J+S5pkCeZANPsRYgXI4m07FLxBMScVXUWzy
         1a4nrpPr++YYQYkjZBDn9TmY1iAnBl2+5yJffc70S08PAMcW3DZaQHtwofGHn2NOrJ
         5OQJc1Z+p3dKw==
Date:   Wed, 27 Apr 2022 23:13:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Alan Hayward <alan.hayward@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>
Subject: Re: [PATCH v14 00/39] arm64/sme: Initial support for the Scalable
 Matrix Extension
Message-ID: <YmnAAScScNWQhx2U@sirena.org.uk>
References: <20220419112247.711548-1-broonie@kernel.org>
 <20220427170858.GA2009@qian>
 <Yml599vM948wXt6g@sirena.org.uk>
 <20220427210800.GB2047@qian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s56lCtxHwIKgHoFx"
Content-Disposition: inline
In-Reply-To: <20220427210800.GB2047@qian>
X-Cookie: Buckle up!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--s56lCtxHwIKgHoFx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2022 at 05:08:00PM -0400, Qian Cai wrote:
> On Wed, Apr 27, 2022 at 06:14:31PM +0100, Mark Brown wrote:

> > Can you try with=20

> >    https://lore.kernel.org/r/20220427130828.162615-1-broonie@kernel.org

> > please?

> Yes, it works fine so far.

Great, thanks for checking.  Catalin applied it now so hopefully -next
will be sorted in the next day or so.

--s56lCtxHwIKgHoFx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJpwAEACgkQJNaLcl1U
h9C8ZAf/UQ3640lBx7Z1uHTUWnJ6PVc4sUJpBlwJS4OlkdIzeptcNuhZt7GMNYfT
kXpFO2AiFKIlUMLG80jeWXmYgOjt6XD0AnxZT4ogK0ttLrVZVvchItlm6MDA8MFc
u/MYet5MiWEAOMbr/FpVNLCnq6og3e5E57SPzpyJOOvSblxOA8gKDkukTT/A9VrY
E+3CQ3l1vELiCkhnMnLIMml/j3zfCm62sI09ePshhrwkY4mJHEq5ZDYzHo26EefY
e93/X7J6ZUpo97s4dNVFuUGu7VyAmfRTMHRCETQ/e7cyrU73WYRBiN+YLP4Jzd63
zYiv7sMi9rj3ywSH7lhAeeJYuO7tPA==
=gjuG
-----END PGP SIGNATURE-----

--s56lCtxHwIKgHoFx--
