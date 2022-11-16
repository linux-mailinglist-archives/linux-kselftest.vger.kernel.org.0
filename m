Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834D462C12E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 15:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiKPOmP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 09:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiKPOmE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 09:42:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F693F05A;
        Wed, 16 Nov 2022 06:42:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F57961D94;
        Wed, 16 Nov 2022 14:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9E8C433C1;
        Wed, 16 Nov 2022 14:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668609722;
        bh=lckJV3myNE/M/+AoXSQVsJhxmoy51aieZjb0GpOhuiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JpLJUlG3L55lqEmxr/ON6OFL0v3u/BY5CSPeJ0+ZB5uEHDTke5edbsmu3RVg+Vr2w
         xm94C9/gTTv3vsrcrLtoDy+23ua3FEMN01MuNiv/oIZoZ+vJ5yrQ9S51g2blgruZAk
         Vl1voX3WyluyQgbtUWPTuBo8BOrqnOYwDg+ZMDX8N3pASIdOVqZycoMh7nTckXPiYl
         ysnDg2b1hPCCswYevZx35nlcyk+dPx4W6IwgGKBuWkTuomx0VL/+yIZsNPD1hkWpKG
         aWoyVDwTOeXqjrPUCzJs2d7qHxgP82mOvbEjnOUkhasgpSU99iY98XPb0Y9/boQYtT
         91uyFGEQxRFfw==
Date:   Wed, 16 Nov 2022 14:41:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: selftests: arm64: sve-ptrace # TIMEOUT 45 seconds
Message-ID: <Y3T2ts+7I8g62hOM@sirena.org.uk>
References: <CA+G9fYu8grBstgXDsC_g5tmEg0nVwaQ+p0d6vD+mN7UsTvMCSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bGEcD6Gx1CBrCGx+"
Content-Disposition: inline
In-Reply-To: <CA+G9fYu8grBstgXDsC_g5tmEg0nVwaQ+p0d6vD+mN7UsTvMCSQ@mail.gmail.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--bGEcD6Gx1CBrCGx+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 05:25:37PM +0530, Naresh Kamboju wrote:
> While doing selftests: arm64 tests validations following test failed
> due to shorter
> timeout value.
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> not ok 28 selftests: arm64: sve-ptrace # TIMEOUT 45 seconds
> not ok 35 selftests: arm64: check_gcr_el1_cswitch # TIMEOUT 45 seconds
> not ok 40 selftests: arm64: check_user_mem # TIMEOUT 45 seconds

> and
> https://lkft.validation.linaro.org/scheduler/job/5847406

This appears to be the default timeout hard coded into the
kselftest runner, though that limit appears to be configurable.
Given that this report is for an emulated run on qemu rather than
a physical system I'd suggest you should be configuring a larger
limit, there does appear to be some support for that.

I do note that your system appears to be unusually slow even for
an emulated one, when I run sve-ptrace in qemu on my laptop I'm
seeing it taking about 10s which is vastly faster than 45s.

--bGEcD6Gx1CBrCGx+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN09rYACgkQJNaLcl1U
h9AaNgf+Ls7sZ+OSIBRrmT9RrrhCfAXcmMlbJ58fqfLju+UDvU8V3Dm6PUTThung
DahcdFgUD9MnSitri1qemCLUcgEJNMZDRx7Ew4zZr2WExuRg74xppGVFm1rQVi9a
d8x/qQZ7FZ/JjSWB690tnrTNfY7CnSXA4esIYeRA3IgsAaB/c49N48N/sbpmojJ6
gnfaMFVFvJUM7h8IRvGe5ADvlxIrLMI5ucP12PLCsGciLSn3buiX8FjgSZY6DzeR
shj4NK3ndwmoc/7ZDkNt201FLm4VBjAh0Sj+tn7GHUY6MbAyNs0il5LZtZfo/ygL
giV0KehyOcYGCnlcF1zzVt12nw8UxA==
=OFyz
-----END PGP SIGNATURE-----

--bGEcD6Gx1CBrCGx+--
