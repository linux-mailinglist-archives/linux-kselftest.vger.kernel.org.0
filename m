Return-Path: <linux-kselftest+bounces-18044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AC297A787
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 20:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3165B2A015
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ECF15B97D;
	Mon, 16 Sep 2024 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYjquCjV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47F10A18;
	Mon, 16 Sep 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726513025; cv=none; b=Ub4sVzYPflXjWuWdz3q48eWtwKMTlx7/mtz+27O2y1zKlF77GuvR9GApqBDFOAfZny+oWHzF3wffYgkcELGMIkx6hTgm2S2hgb/qPTbwAnmYbsj8bupTBnqKfwqa1HmEJ4j5SLGjgK83q9poMquS/+w/vPHuu2GtZaenWe1NGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726513025; c=relaxed/simple;
	bh=2rOpEhNpvCP5tv41uT2H58Pziu7pmFrgPvj3jAcIgk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUFEHr2fj5n+GbmLdf42RSUgNVAq/45OIH65Uy5GoFQPEusaorwXF3CNUWKep74JZhvco7qLa8+ADvP++PsEiwTFQ8xDE7AihD0mqIgxICDXEMHzyZ3rLokU0IgRpZMcB4SQiKPLF2vcPDdO8cQMgZOJ+Im8G0OWHGq3GykB81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYjquCjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619BFC4CEC4;
	Mon, 16 Sep 2024 18:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726513024;
	bh=2rOpEhNpvCP5tv41uT2H58Pziu7pmFrgPvj3jAcIgk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lYjquCjVo93Cjg6pRa3FlOisSx9MJ0vXCu4xMq2Xjz4aidkOJMUNj+MnONJfY8OLP
	 7aOsfYtBLdwKewXDfHgrowYJe2tuR/BgBKovwDNM7AEMfIx1n/eW0BPKaqfaXCEztm
	 6frSYxvTmE7M70IH/+kpaw4Kc5GrGDjOH8AGqTb+F+vdcO1KAHBsqQcnoGfHBTyMDg
	 lTMiQKecGCgTJGbUi/FX4GXOHoVZ7Cf0Fq6nPUOSd8yhBT+oGBA8h8qT/UAxAA+rxM
	 NTITXtsr6HwaVyrryQY59zZmbjucqRJGzixpHDF0y0Q7EFaB5tZfp4rCnTp7iJCSTO
	 Fm0LLPVS95KnA==
Date: Mon, 16 Sep 2024 19:56:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 14/14] riscv: Add ghostwrite vulnerability
Message-ID: <20240916-profanity-superjet-33a08a8b0b3f@spud>
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com>
 <20240911-xtheadvector-v10-14-8d3930091246@rivosinc.com>
 <20240916-pretext-freehand-20dca1376cd4@spud>
 <Zuh8dLsA50IHXymz@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1W3qJ42zpxTLHb35"
Content-Disposition: inline
In-Reply-To: <Zuh8dLsA50IHXymz@ghost>


--1W3qJ42zpxTLHb35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2024 at 11:44:04AM -0700, Charlie Jenkins wrote:
> I figured that since T-Head didn't feel it was
> valuable to change the archid/implid between cores that Linux shouldn't
> go out of its way to fix the granularity issue.

I mean, when you put it like that, I'm not particularly inclined to
disagree...

--1W3qJ42zpxTLHb35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuh/egAKCRB4tDGHoIJi
0m9ZAP4p4x2mD8mK/6PbASnwkCkRX6uLXgKlb3Og6pl+CuOYXQD+Pot5fkAszZBn
jOtHr1hp7qBYQvOX0qqA+aF3UF/INAc=
=rRd0
-----END PGP SIGNATURE-----

--1W3qJ42zpxTLHb35--

