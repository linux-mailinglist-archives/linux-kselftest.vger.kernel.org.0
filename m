Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0800470231
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 14:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhLJODL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 09:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhLJODL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 09:03:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BF0C061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 05:59:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B5ECCE2AD2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 13:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCC8C00446;
        Fri, 10 Dec 2021 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639144772;
        bh=3IiC6gTmzS9un9E9shZZcV3BXG07xritOZdkI9ovUoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rl5LW8uXeU+rio/2EfYZFbe2IebYTm9+bYLXhtWabPM41nMRrNHnGZIlOxG2VDMIA
         rjJWbvmIMUWlneThDKTZHzlxOpQvC+OP9q5B1s4Itlh4MHog6fP/K5iaVrzRnOdMLB
         oy8WjhL9HsAAzlXMx3o0+UmbQMK/vQJvssmj1tnc1/S4xrRZIUxn7CI7lX9tv2ojLq
         XeOlnMDCVvUZujIODm2EczKiC1GJ1O7fqkAZNgGSgFnhwfRjwrL12YQFDMSdN3nGaH
         9GY5Nb1i3KnRj9ADyQNtjH/gevqc2nNUvYbLEyyUj7F3yifrOKDRBDDIZKPI+gsg9y
         xQg+A5TcCAOQg==
Date:   Fri, 10 Dec 2021 13:59:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 13/37] arm64/sme: Basic enumeration support
Message-ID: <YbNdP85r7wu2bQpb@sirena.org.uk>
References: <20211115152835.3212149-1-broonie@kernel.org>
 <20211115152835.3212149-14-broonie@kernel.org>
 <YbJN1ujpDP1RG1Ll@arm.com>
 <YbJY0P1KZjSFfwtY@sirena.org.uk>
 <YbMuzjU/MSTwBDLY@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZqIdPc6Fdn3ZgGn8"
Content-Disposition: inline
In-Reply-To: <YbMuzjU/MSTwBDLY@arm.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--ZqIdPc6Fdn3ZgGn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 10:41:18AM +0000, Catalin Marinas wrote:
> On Thu, Dec 09, 2021 at 07:28:16PM +0000, Mark Brown wrote:

> > > > +#define HWCAP2_SME_B16F32	(1 << 25)
> > > > +#define HWCAP2_SME_F32F32	(1 << 26)
> > > > +#define HWCAP2_SME_FA64		(1 << 27)
> >=20
> > > At this pace we'll need HWCAP3 pretty soon (since we only allocated
> > > 32-bit in each). I wonder whether we could instead not bother at all =
and
> > > just provide user-space emulation for ID_AA64SMFR0_EL1.

> > I think so if people are willing to go along with just having userspace
> > check the ID register (IIRC access to it already does the right thing
> > but I need to confirm).  We'll also need to think about how we handle
> > any new SVE features, that's got a similar thing going on and is most of
> > the existing usage of HWCAP2.

> It would be good to get feedback from the libc people. IIRC the ifunc
> resolver relies currently on the HWCAP bits. Could this be adapted to
> use the MRS instruction? We'd still keep the main HWCAP2_SME but without
> the finer-grained bits.

> The other option is to start going into the upper 32-bit of the
> elf_hwcap. We tried to avoid this some time back when we were still
> having doubts about merging ILP32.

I'll leave things as they are just now to give more time for feedback.

> > > I'll comment here rather than the patch introducing has_feature_flag(=
):
> > > an alternative would be to add a .field_width option and in
> > > feature_matches() use cpuid_feature_extract_field_width() directly. A=
ll

> > Sure, if people are happy with that - it's a more invasive change since
> > we don't currently set the widths, I wasn't clear if that was a case of
> > not needing it right now or a design decision.

> We didn't have a field_width since they were all 4 bits until SVE. If
> you don't want to touch all the entries in the array, we can say that a
> 0 value (i.e. not explicitly initialised) means default 4 and update it
> during init_cpu_features().

It's annoying to have to update everything but it feels more idiomatic
and less likely to cause surprises later on.

--ZqIdPc6Fdn3ZgGn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzXT4ACgkQJNaLcl1U
h9CKhgf/bIRqrmEvRVYRdOJ71WQVNrlpq0nYB5RDVmw34CPswXyaZ+e85JVYlPF9
aSTLKS3l2H0U9BL8MQIKrGiZiUs/hZEDaff9KUbmjKlNXtftt+OTXwEP/ptuP99R
SF6BQt2cdRDzTISmpFJrxJthD1ZwMlgh7T36m0CzO1dgQ0B+5R4oj5I1BXsXr84H
KBxKkrPCA8FICLkTNGs5nuAog5JXCnRg+lIswURpADi1J0NK7RVScQvKE2MnCk1X
9sV0/NfYoaRkA3lDKs3w5LddVUFitH2O6U8orRRTVqg7fXc3FQcBCV/R9aKYuQT5
+I+BtBKMMPVBuQ045vIWpaWIDS9Jog==
=3br8
-----END PGP SIGNATURE-----

--ZqIdPc6Fdn3ZgGn8--
