Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A914D3C7B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 23:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiCIWB3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 17:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiCIWB2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 17:01:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5E649C93
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 14:00:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 294CA61B50
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 22:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB8BC340EE;
        Wed,  9 Mar 2022 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646863228;
        bh=rYHKjAVXwMlDeDIO8VYvj0f4A+ZZbV25BEt2ni6dXO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lcm9kAu1GCKMB8E/r7nbWpefk8wViLLJJJOhS0i3CoLUI8+wZbWkLiEhZk1AlV5XH
         NrTOMyrTknv6l0Me6HVYGU+TBEY7VebNlmduL0V0NuBgQOBUFtOH0UiMYc+omMYqId
         GEb+br+DbkV8f3tWEmvtIHdc+gfbTyX9kUOVMR6gvAJoWwEHkyG6jyUWs6CPneMspr
         58slyd8wFacY8QP4kUnm9s5kuiuO4m7kINL8Z9Dcx8+bJX5I6y6jUHQwKzWJEYXINj
         ObDfY1Tk1a2rFI/frbON3A3Nw1d5TGeHe2+z258QofxATKyzYaKf7FFTqe9lyIK8jb
         ubN8Eo9XC2sUA==
Date:   Wed, 9 Mar 2022 22:00:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/3] kselftest/arm64: Remove assumption that tasks
 start FPSIMD only
Message-ID: <Yikjd4s/05G9UFe0@sirena.org.uk>
References: <20220309115918.22469-1-broonie@kernel.org>
 <20220309115918.22469-3-broonie@kernel.org>
 <5f892a90-6870-001b-d265-885f49a738ce@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yjQwSUxe3/Q4PRFt"
Content-Disposition: inline
In-Reply-To: <5f892a90-6870-001b-d265-885f49a738ce@linuxfoundation.org>
X-Cookie: You will inherit millions of dollars.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--yjQwSUxe3/Q4PRFt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 09, 2022 at 02:36:26PM -0700, Shuah Khan wrote:
> On 3/9/22 4:59 AM, Mark Brown wrote:

> > Currently the sve-ptrace test for setting and reading FPSIMD data assumes
> > that the child will start off in FPSIMD only mode and that it can use this
> > to read some FPSIMD mode SVE ptrace data, skipping the test if it can't.

> > -#define FPSIMD_TESTS 3
> > +#define FPSIMD_TESTS 2

> Looks like there is one less test now?

Yes, the initial read which we assumed would return FPSIMD data was
being reported as a distinct test.

--yjQwSUxe3/Q4PRFt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIpI3YACgkQJNaLcl1U
h9AyZAf+O8Ql9HLb++q/vJcbZV3qEt8GudXQTmR0hfzaXdom9kdbhlO+5fatHLmv
HDMPOA4gKp4TUumMJEbd9sUMLbHd6ZdlFaw5ErxcRfr3CNDMrNxPezYjVntoTvo9
9gOF3xQkJmTlEyDj1sdiRbw1ftUJteT7OCHQPvWQfErXT6t04UxSKWQI95IdFiSX
KIldIe+hVg0f1hAx6+HjCo4pb+AxlQoh7dRmUb7PsLf2oCILIBJ788cYLsoIkuMx
InlA0BaZ39ZQ32r4lnrXttYYC61eq73jyMKxbpWTrbBeRaRT8p8n+Yhk+gX8Z2qT
cvbVlXHNJ4VozE3bhusJkQI3kLD2LA==
=P4Xn
-----END PGP SIGNATURE-----

--yjQwSUxe3/Q4PRFt--
