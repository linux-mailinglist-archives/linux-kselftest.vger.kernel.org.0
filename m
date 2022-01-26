Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF8949CE1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiAZPYQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:24:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47030 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbiAZPYQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:24:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A692618B4
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082DFC340E3;
        Wed, 26 Jan 2022 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643210655;
        bh=a9fGZLyR6UIMHjhj3fwTDtIy/5FmZ3+TtczWHOoCjN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfLDOYjuN743LLtaoX9Qr8mxEnozFrFTlQhFTTalAzArQrARdZ97G0f0ZipCfbf6q
         YaUusTvYWMke/whoKaLkm0I30jPshTmJFZ6ncjrtbCbyZV2nfUi8cuolY9oNALqLaq
         DgEAwDKO3afwilZ1fZdS0hEjcMtNAUNxJpPh9TGn++1uCUFcYFxYJUcX0Q5kZW1WS6
         atP38oN+90AHAXRukeSDb0aiXo3B+1k1JKOoqYE+X9TFSYdoYsZWqGQjHsEbSWrext
         GbyOpBb+il9zlj/+GoE5zaTNv3ZfX3bEZ+jvsUXidLRQYfULOsdtJLh395CAMtFdIb
         NgOisSDVKMORg==
Date:   Wed, 26 Jan 2022 15:24:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v9 40/40] squqsh traps
Message-ID: <YfFnmC5vekv06d3K@sirena.org.uk>
References: <20220126151120.3811248-1-broonie@kernel.org>
 <20220126151120.3811248-41-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XXERhi+4WkANTGAx"
Content-Disposition: inline
In-Reply-To: <20220126151120.3811248-41-broonie@kernel.org>
X-Cookie: Use only in a well-ventilated area.
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--XXERhi+4WkANTGAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 26, 2022 at 03:11:20PM +0000, Mark Brown wrote:
> ---
>  arch/arm64/kvm/fpsimd.c          | 22 ++++++++++------------
>  arch/arm64/kvm/hyp/nvhe/switch.c | 20 ++++++++++----------
>  arch/arm64/kvm/hyp/vhe/switch.c  |  4 ++--
>  3 files changed, 22 insertions(+), 24 deletions(-)

Ugh, sorry - looks like I didn't finish my rebase.  Will resend.

--XXERhi+4WkANTGAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxZ5cACgkQJNaLcl1U
h9DP7gf/biXfHH4ssvVCSo4MY7iDJVG06yJclefMZnDT4ExfXt05ibBeLYLfn/AD
uLVNjo9VzbP5SiT2ibZlPgN/kp6IIzIxyfjdMWh4tUXUcSz14ls5cJ9uIchL+kX3
9GC/PCvWP4Wqi2VBKa+XmS753OzmDiO10zo6Ayd8B4jEOR0OsMy5lBQtP0vgXLSx
c4Kvl/eaU0PmfH+4Syvkh0eUJorE4rYnAX9AxNTNx8HixxHstmlCar2rQ+FJMULg
WW0wbUAfptm18jEz3fHT3TmeKfKYvHKaelcQ21b+1mysGxdiQZm8IEM6FwNUD98t
pKGGVXTtereZqpkVzqEElcMS6sOqJg==
=t+YB
-----END PGP SIGNATURE-----

--XXERhi+4WkANTGAx--
