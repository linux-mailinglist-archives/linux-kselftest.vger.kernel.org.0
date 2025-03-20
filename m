Return-Path: <linux-kselftest+bounces-29519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19615A6AE68
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 20:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7584A0022
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FF0226CE4;
	Thu, 20 Mar 2025 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SryMWsN/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B120297C;
	Thu, 20 Mar 2025 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498044; cv=none; b=FpTQJWREDZsenyngGIzqdsa1dBCVGjyChHThbvS1Lrl273ZYTxAPeqVej5ff3MWBHzgPL4oZZyS5CxKLDf+jHFNyVaaS3qN+JK9snRIWB34GtYoCDPuXwvYnl3HHuTDn+ilSQW8XAK4QjDu8IwqRRq9O0Xvz6zEts4+1oNpF9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498044; c=relaxed/simple;
	bh=GMKQ+IsWksG+8EFLNZfKP/T07o9pwNrkxZF5rQ7ya3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXUZjftTNvPHbGKjH0iReTFt7yXx/OdQXBQJE7mUcq/FPwE7XSKsOgEaa31UTUnspH6Oehl11/+5pcKNUmdQh2zRG2/CEQ0cRJOEAuv2B9H0xzZLo/+oTOaPuq8HeT19aD4fv+6pAYf2lDw3umfmKlanIM4za/iGq5tRyq6ar2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SryMWsN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04768C4CEDD;
	Thu, 20 Mar 2025 19:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742498043;
	bh=GMKQ+IsWksG+8EFLNZfKP/T07o9pwNrkxZF5rQ7ya3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SryMWsN/ZDyqRfkm+Ild3Ogufm4HIPsfW1YToRbRWN8e0fDnBEUX9M54kQRMbXyIy
	 Hbh/ZHIvepdBZ+aRyLEOtSKoisSwkcimysMyLm2mX6E1HNpSN2D81GLRFre2kBbOh8
	 U6PIX4ftGtZ7fS6x0qOPsieRA+vTNcHW9rMKtBKxPpvbC481kqWasaSoyFUenSZhMa
	 SRaetseswCRcNjN/iGAoIyRePmNYP3ElOs5FWrDeCKUJBH29CgvfLRK5Mn0pdOEwcF
	 eWyBayJJmPqa2dcWuFCyukPFE1ShiNxH61CLGYGVMxH1O2EjMtzvxXGW7OC3hcQuGF
	 22DQb3tzsmRGQ==
Date: Thu, 20 Mar 2025 19:13:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: rf@opensource.cirrus.com, patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, simont@opensource.cirrus.com,
	ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev,
	davidgow@google.com, rmoar@google.com, johannes.berg@intel.com,
	sj@kernel.org
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling
 it
Message-ID: <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
References: <20250319230539.140869-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yj/ZQFCSnYoR7wNF"
Content-Disposition: inline
In-Reply-To: <20250319230539.140869-1-npache@redhat.com>
X-Cookie: Do not fold, spindle or mutilate.


--yj/ZQFCSnYoR7wNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2025 at 05:05:39PM -0600, Nico Pache wrote:
> FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
> depend on if the feature is enabled. Fix this by moving FW_CS_DSP to the
> depends on clause, and set CONFIG_FW_CS_DSP=y in the kunit tooling.

>  config FW_CS_DSP_KUNIT_TEST
>  	tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TESTS
> -	depends on KUNIT && REGMAP
> +	depends on KUNIT && REGMAP && FW_CS_DSP
>  	default KUNIT_ALL_TESTS
> -	select FW_CS_DSP

This makes no sense to me, the select statement is forcing on the code
it's testing which is a library and so is selected by it's users, this
change will just stop the tests being run unless someone does the dance
to enable a driver which relies on the library.  That is something that
seems unlikely to change the outcome of the tests when run from KUnit
which is independent of any hardware.

--yj/ZQFCSnYoR7wNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfcaPUACgkQJNaLcl1U
h9AIRgf/ccGrIBHTcdZaATYWPh0Ma2trtMpDz+zzZLn/Darau6fPQVOZYxw57Jfm
XVQ4la3YkHtK6A2p12YD84pcpE2VzE3GN3xyhjoaBoO+h9cESs4foUWvRLhy1QbU
oQXGUDgFR5Fs8bix/z1cEGbexaE5n1TwruWvrkFJUKbrKcmKXlB8qZQCq7iX/qOU
8qSksIDnzq4YU/c4sWxMw7TdJriDX6h0adQlgDZb+lAZS2XK3Gd4Tsb/bRMK14nA
iRdnQji3tW5WJH2FOTt7hoOMNu2hECfbFDYzHUVhpQM0zJG4plgHi3syp8/AlSSU
cobYnJ2yCJMhMHU+us8jRNV3leRrcg==
=bWLQ
-----END PGP SIGNATURE-----

--yj/ZQFCSnYoR7wNF--

