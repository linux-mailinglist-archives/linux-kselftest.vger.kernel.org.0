Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8A49B386
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 13:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiAYMNv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 07:13:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58728 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444194AbiAYMKo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 07:10:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3AC261147
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 12:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1743FC340E0;
        Tue, 25 Jan 2022 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643112635;
        bh=sFg/+U854evqBj7SymFtSzOukK5/ylDdAyC4Ajtv1Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoIFIZjGdycI02z5vlSS7jd6GZPA2U7gNxY6w8PFRVRbbFoZ378iaQbjHuH6+DHMM
         xtW88bSmai1VVg6YLlrx1uFCATucVq989h/gpId1NkXZ9JX6wxKm16ZDM4Gp+Ndh4r
         vu/4KTpEKDIpkCWh0owUJ2Z78q0YwOMjXb94x/vLbdsAJO/KSC0l2Txns2jYZIbh7i
         a8sbOrM8nc6fZu6JXrOWRcfk5RdT7BbmOvt60fPvIIYhgycd7M7L3UHaQnHxL6trfY
         hnvJEVzV0Cee8kTSXV9Uihjq1htiR5YOYmU8LK8S/F3tY8P2GEvzKnFDGnrpNwWzLz
         y6vRxSGUvNryg==
Date:   Tue, 25 Jan 2022 12:10:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v8 01/38] arm64: cpufeature: Always specify and use a
 field width for capabilities
Message-ID: <Ye/otP4coRNRxS5P@sirena.org.uk>
References: <20220125001114.193425-1-broonie@kernel.org>
 <20220125001114.193425-2-broonie@kernel.org>
 <edc0a8a0-5439-ff34-3de0-89ae0a4e60f4@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XS5KfZPoqAQVB4C2"
Content-Disposition: inline
In-Reply-To: <edc0a8a0-5439-ff34-3de0-89ae0a4e60f4@arm.com>
X-Cookie: The second best policy is dishonesty.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--XS5KfZPoqAQVB4C2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 25, 2022 at 10:57:47AM +0000, Suzuki K Poulose wrote:
> On 25/01/2022 00:10, Mark Brown wrote:

> > +	int val = cpuid_feature_extract_field_width(reg, entry->field_pos,
> > +						    entry->field_width,
> > +						    entry->sign);

> Could we do something like :

> + int val = cpuid_feature_extract_field_width(reg, 		entry->field_pos,
> 		entry->field_width ? : 4,
> 		..
> 		);

> and leave the existing structures as they are ?

Obviously we *could* (ideally without the ternery operator) but having
the implicit default like that makes me nervous that it's too easy to
just forget to fill it in and get the wrong default.

> And that could avoid these changes too. We could add :

> #define HWCAP_CPUID_MATCH_WIDTH(...)

> when/if we need one, which sets the width.

I'd originally had a completely separate set of definitions for single
bit fields but Catlain wanted to get everything in one.  I'm not sure I
see a huge advantage in sharing the match function and not also sharing
the macro TBH.

--XS5KfZPoqAQVB4C2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHv6LQACgkQJNaLcl1U
h9BmCAf+OOGqr40J+iVV3HqoKIEq1uCYDDSkIElqZkeLGdKgbG70Z9c65SRPpb3n
WgHwZRgAt4j99AtorLwbLUSHx/KFVG12+72Iwr5j6iexT4NW/64DPRJgUIbzXItk
tVXRVOcBS6geqopHOvKny9vYbEcuU/RsibVkMQYTytUo9S76Bwh/AuxxoN3EqZn0
Bjk9O2bqPnU8Wfy4usdFRBO8B8FhCCPlgzSr4/lCKIAp2ZlEYo7zzlNP+y5x3Y7W
CwVHXSgCWwTOcWT5isvt/d9NRU/yp6woiVq4x1ly59mUrWNklyjUb3rNBP7v1Qyh
sa0teR+x43Dw6/Ym9mL6L5+57HtAUg==
=yrcl
-----END PGP SIGNATURE-----

--XS5KfZPoqAQVB4C2--
