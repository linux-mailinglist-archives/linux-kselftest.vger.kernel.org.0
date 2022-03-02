Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB924CA570
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbiCBNDs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 08:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiCBNDr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 08:03:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2794BB8E
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 05:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 706886197E
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Mar 2022 13:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453D8C004E1;
        Wed,  2 Mar 2022 13:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646226183;
        bh=ibmXcOSmeHL09sRVILi0Er6msdkw98p2iNvq4Z+J6RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUZPBKvf3WuH9rU5+3WcDt2MLzqRo7s8K9YuGgWUUh0gwAdA1HOjR+B7T5Ha6Sb+h
         lYGoTuu0kwBU9TJcgM1vZ9B/Ee4qpLqk1cPlLvHQjOvrBIqgjy8LkQDqNwVqURl1wT
         mCIcBSGA4s/RMbbGQJCF5gwdVxTJND2tr0iI8JRVZgtGLNtC2L5zYEGU62+92Uaz13
         UsdnFPvHKrpuyO0+z6jxSyFHEQMN7/FXTIoe9UErNSz/BneTtzr5oW0RMmhW5+NDep
         FMwAcLsTIJ420VL53bBVokT5GIzQ0vUcnCe5bzT4wHILRJmEVgVivv7RrztPx5ENL/
         SqD3tf0bpPdyg==
Date:   Wed, 2 Mar 2022 13:02:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Qian Cai <quic_qiancai@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Alan Hayward <alan.hayward@arm.com>,
        kvmarm@lists.cs.columbia.edu, Salil Akerkar <Salil.Akerkar@arm.com>
Subject: Re: [PATCH v11 03/40] arm64: cpufeature: Always specify and use a
 field width for capabilities
Message-ID: <Yh9rAZjmmqjCAGZ3@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-4-broonie@kernel.org>
 <Yh6kqaR9FQXg8Q4w@qian>
 <878rts3bpi.wl-maz@kernel.org>
 <Yh9akZaM+qeWPgEz@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7loqhh/QB0lB0Fcr"
Content-Disposition: inline
In-Reply-To: <Yh9akZaM+qeWPgEz@arm.com>
X-Cookie: The sheep died in the wool.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--7loqhh/QB0lB0Fcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 02, 2022 at 11:52:49AM +0000, Catalin Marinas wrote:
> On Wed, Mar 02, 2022 at 10:12:09AM +0000, Marc Zyngier wrote:

> > I don't think that's on purpose, and we should definitely address
> > this. Maybe we should have a warning if we spot an occurrence of
> > .width being 0.

> We should indeed have a check. Alternatively, assume the default to be 4
> and convert all 0s to 4 during boot (less patch churn).

That's got the issue that it becomes very easy to end up defaulting to
a width of 4 in the case where the field is narrower which isn't going
to be easily visible in testing until it encounters a system where it
misfires in a way that breaks things.

--7loqhh/QB0lB0Fcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIfawAACgkQJNaLcl1U
h9CL0Af+LMYSxGux9+H2KZiS3uH6kguND2mecwSS/f7SK6AC7kMkLZcfz/72uoT3
NtscTwK9k8C/lBWsab8WWTEcAhNBUTc+KSeYbnUQmw29oNO30VT3NjkRe6l4xdjW
gmUHWfwDN/hl/DViKzHbswYgVNaUZck5vwUonMuQyAM0PtJYoerOVpcavgd/9u7F
6jI4E7ZeIOS4AX0XUkJpRDZxykF/NsPJvadKvEP60UOrYiJ54vVHSewrqshd6cgA
g2lSQW+XeibnhLFTEsNiIGtpxCdnQBOkA7562cREw9f6BttWsHsJoklRs+c19WiV
7sCyOIXcLXhJIm39SdLzJjHuXKK7fQ==
=vfZs
-----END PGP SIGNATURE-----

--7loqhh/QB0lB0Fcr--
