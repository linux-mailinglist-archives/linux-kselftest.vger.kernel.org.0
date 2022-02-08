Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BADB4ADD96
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 16:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382071AbiBHPvt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 10:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382192AbiBHPvl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 10:51:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC775C03CA48
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 07:51:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81644B81BD0
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 15:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99237C004E1;
        Tue,  8 Feb 2022 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644335482;
        bh=DSOFycgVws+h7T5ENa5P5jIRcXzog0itQ+h++u6TjH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dogQ23AhWv2Y0LrO2Cl35x8z6FXBbSq4wthKej4k6KB7wax5fJe2keAcarhYKQqBw
         IzQGNcJ21is1nsHelHv+A4A0j0tf3x6JaT500m7vR8LTG6sL6qFDIq2J/INSWalb52
         ESa/zzjlXbxUc+qMOOuhozOslqZZ0mI2M3nJ3ROBhICoO+SJkKmddzf+7MFvBSKh+f
         JenKAQLSokwnNtRC2qCz2o2nkY8yap5crdOWwJWYrRdNfjWA5O2MTQ+MBMSNkRyyMx
         9zwoOLeiK8G3RXorwgnpaR/BTptr4MCIHfGj9soANbcYtH+MntBxxXuJ8TOG1fc65p
         qqH7DuzIKu13w==
Date:   Tue, 8 Feb 2022 15:51:13 +0000
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
Subject: Re: [PATCH v11 31/40] kselftest/arm64: sme: Add SME support to vlset
Message-ID: <YgKRcQaZ4QUh6pIH@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-32-broonie@kernel.org>
 <fc0d4407-8124-2040-41f5-5de091de588f@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LIHuwwmGP+ni8Amn"
Content-Disposition: inline
In-Reply-To: <fc0d4407-8124-2040-41f5-5de091de588f@linuxfoundation.org>
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


--LIHuwwmGP+ni8Amn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 07, 2022 at 05:15:39PM -0700, Shuah Khan wrote:
> On 2/7/22 8:21 AM, Mark Brown wrote:
> > The Scalable Matrix Extenions (SME) introduces additional register state
> > with configurable vector lengths, similar to SVE but configured separately.
> > Extend vlset to support configuring this state with a --sme or -s command
> > line option.

> It would be useful to add a -g command to get the current value.
> -g would just do PR_SVE_GET_VL and print the value perhaps?

We already have the rdvl helper programs which can be used to read the
actual vector length from a shell command.  I'm not sure there's a
particular use case for adding something to to this program, and I'm not
sure the complexity is worth it especially given that we've got both the
actual and to be inherited vector lengths to be considered in the UI.
This program exists to allow you to configure vector lengths for the
stress tests without having to write UI code in assembler.

--LIHuwwmGP+ni8Amn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICkXAACgkQJNaLcl1U
h9Anuwf/WxDpOe84TNruqv39PFD5VFS/cb4p8TQEQxT1+nkW22u+hCuxurJNpVX2
ZL5O0o0z+SJU2W/tCGZWZpAh2jQ7L2nqzBFtCh3m4Cc6DhmEDl6sFEpCP4wjAI0f
RWSmKXv+tLqJslbxR+w4CMgQJWzlIEjit5uB3cq5htTg9uIA2NkT6lB2JbxG/qBj
XycZmOCPB8Ld6nOSGEyyIhilUTlDBlGyyCLtFXyYyFs6WnXPqTJTCVOGimwYLW5V
Q06Mxdi/6bUe4rjvy8rP2tgknMggTa316VnuG2okcWtyjouDTzk/BwAj+KLD4NLB
zccWP1a30jM7JLQV0e+dkvOZesvlRA==
=5yEu
-----END PGP SIGNATURE-----

--LIHuwwmGP+ni8Amn--
