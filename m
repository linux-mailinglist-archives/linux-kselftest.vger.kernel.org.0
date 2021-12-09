Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AE746F3F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Dec 2021 20:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhLITb7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 14:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLITb7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 14:31:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A27C061746
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 11:28:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D9FA8CE27F2
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 19:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E3AC004DD;
        Thu,  9 Dec 2021 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639078102;
        bh=XDJxsKXSoiTbmMVVRrqvD1Ng5C6CIWMttahzKBLDMRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHQ6qchWy2n2YgeFy5DoZ5Dj+YeUcWoDQIZpY1/nHQSaI5pWoqKGM3hNlxOnjVdVR
         mD3/WeQ89YxLbgDlFHFIeYA6vQA5ve6mJDDYrseQSqAdzpz3aXpJzYtVW25TvN4/2Z
         LWIhn7uX1BBdQ1M+Df+znhlaakn5JWtACA6+VJfJbTq/H707bkuypJi87Oa0m84w77
         jgA2+qBP/difBQ5GBaTFb0smUmybyDCWewdFlpmT1y3PP40mmlTttMWrFM7QqyRL5D
         4tesMvbo0ZhA3Fkoi93UH2Sh2TZud99VvMuMqvRJG2Nfdrqe8C3R8yfmS6ZpIbg1ys
         rK3NylOHYa7ew==
Date:   Thu, 9 Dec 2021 19:28:16 +0000
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
Message-ID: <YbJY0P1KZjSFfwtY@sirena.org.uk>
References: <20211115152835.3212149-1-broonie@kernel.org>
 <20211115152835.3212149-14-broonie@kernel.org>
 <YbJN1ujpDP1RG1Ll@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GGbbXJy03eDuEJ9w"
Content-Disposition: inline
In-Reply-To: <YbJN1ujpDP1RG1Ll@arm.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--GGbbXJy03eDuEJ9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 09, 2021 at 06:41:26PM +0000, Catalin Marinas wrote:
> On Mon, Nov 15, 2021 at 03:28:11PM +0000, Mark Brown wrote:

> > +#define HWCAP2_SME		(1 << 20)
> > +#define HWCAP2_SME_I16I64	(1 << 21)
> > +#define HWCAP2_SME_F64F64	(1 << 22)
> > +#define HWCAP2_SME_I8I32	(1 << 23)
> > +#define HWCAP2_SME_F16F32	(1 << 24)
> > +#define HWCAP2_SME_B16F32	(1 << 25)
> > +#define HWCAP2_SME_F32F32	(1 << 26)
> > +#define HWCAP2_SME_FA64		(1 << 27)

> At this pace we'll need HWCAP3 pretty soon (since we only allocated
> 32-bit in each). I wonder whether we could instead not bother at all and
> just provide user-space emulation for ID_AA64SMFR0_EL1.

I think so if people are willing to go along with just having userspace
check the ID register (IIRC access to it already does the right thing
but I need to confirm).  We'll also need to think about how we handle
any new SVE features, that's got a similar thing going on and is most of
the existing usage of HWCAP2.

> > +	{
> > +		.desc = "FA64",
> > +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > +		.capability = ARM64_SME_FA64,
> > +		.sys_reg = SYS_ID_AA64SMFR0_EL1,
> > +		.sign = FTR_UNSIGNED,
> > +		.field_pos = ID_AA64SMFR0_FA64_SHIFT,
> > +		.min_field_value = ID_AA64SMFR0_FA64,
> > +		.matches = has_feature_flag,
> > +		.cpu_enable = fa64_kernel_enable,
> > +	},

> I'll comment here rather than the patch introducing has_feature_flag():
> an alternative would be to add a .field_width option and in
> feature_matches() use cpuid_feature_extract_field_width() directly. All
> the arm64_ftr_bits entries already have a width, so just generalise it
> for arm64_cpu_capabilities.

Sure, if people are happy with that - it's a more invasive change since
we don't currently set the widths, I wasn't clear if that was a case of
not needing it right now or a design decision.

--GGbbXJy03eDuEJ9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGyWM8ACgkQJNaLcl1U
h9DprAf+I3P42AVkZkoHGputx7rkt78j6cUFk/N4PZxwhxsdOsKI08tnKA/bc7vP
PihZixbo4yTh0Da15N90qlOn+RRdyrX9+p6te2DmW7aMQ4R0hqOPg54/nLZhOQei
8qgGdBF2eOeCYZ6zzk6eEMwY1aLe6jAv2ILiOvOTU9qvKxsfE7TK0QXheSCsAHUH
RYR4UJzsu2baT+VZ+LWo4cgjL1eS6B0YMCkQ76QFixXlYyd/ndmQLvE+4uLpDPVq
waRDVQdIw9UgiDNyAebv3UrhBB0Qy6T36RvcpkAQYbfWIA988/1BZDtaMZgIfBnR
MpLrvRtwNhNuIWu/YWequ0NdJhn2TA==
=+vPe
-----END PGP SIGNATURE-----

--GGbbXJy03eDuEJ9w--
