Return-Path: <linux-kselftest+bounces-10052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112DD8C2B4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CA01C238BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFBB4F211;
	Fri, 10 May 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2Rz0POx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3090FC0B;
	Fri, 10 May 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374239; cv=none; b=EYuqq/gBhK/I9vE/aQzMFnWGczuhuHJ5aX5eBju251ph3Bm2lUeRNuQjzyoNJYNq2SbS/Doq3yWUUuJN1pqeek7wQDxdNAkG8J/Q16nI2Bycd/l5QluKI/Qaz+KFOFTQsnth8l4mqtwsfPeDrI1Bfd7E8EZ1eaEUq0kKpx+KPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374239; c=relaxed/simple;
	bh=+9uY+3QS/KU4LqGvBa9PuWhKX14BfkblrVKzdImHbHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl7eZNy30el480yxO5o+c2TmjmZXH7FPDDUyJcwCxKmFyabIEMEl3ZLmcE1jrRFC+ONCYCjHT6S14t9MfjJL77k5ecoIeDsxTM1AQAXZ6OvUq5KnxYqD/TPxwtIPs8QEz/aTmTPY+o4IR0/JSN9koVqLDsBm0emssYXPa4dKhzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2Rz0POx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF4BC32781;
	Fri, 10 May 2024 20:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715374239;
	bh=+9uY+3QS/KU4LqGvBa9PuWhKX14BfkblrVKzdImHbHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2Rz0POxy4nvsZ9o7IKxVQPe6AU1Y5raSL2PH5Oq3Rmz9k8KRtPC1aeUKTzmOEOmB
	 n71lEqdV6eRXzZanUG2D7rEuULiSpRFrDJ9IO9Vz10Bl16Bfwfq85+pXyM6rMFmlI4
	 +Lhh0FZaryAI5Zv7h6a3CUH7A/zjs8HOEOz89ULFAlJpiSafjizZPyECELU1b07WSD
	 vywqr+1jWnM0GTV1UaDeTW3gA1enGAqHExtiEYv222nusjRmFleW9jG7We53M7KEdE
	 jPbZtVtERRLHwRgUbNclnBiRcRtw07M2GPeESJZlrhzrvk3zn1KHFhgmw34EUO6mby
	 R7ylxUW7WiWbQ==
Date: Fri, 10 May 2024 21:50:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 06/17] riscv: Add vendor extensions to /proc/cpuinfo
Message-ID: <20240510-childcare-outlook-d18e3cc5ccb3@spud>
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-6-cb7624e65d82@rivosinc.com>
 <20240507-divisive-swoop-c2737a2d9a9f@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BHMvR13gFgTG0XBs"
Content-Disposition: inline
In-Reply-To: <20240507-divisive-swoop-c2737a2d9a9f@spud>


--BHMvR13gFgTG0XBs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 06:03:19PM +0100, Conor Dooley wrote:
> On Fri, May 03, 2024 at 11:18:21AM -0700, Charlie Jenkins wrote:
> > All of the supported vendor extensions that have been listed in
> > riscv_isa_vendor_ext_list can be exported through /proc/cpuinfo.
> >=20
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>=20
> This seems fine, thanks for updating this interface :)
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Hmm, actually the automation on patchwork is complaining a bunch about
the series, but I think that's mostly false positives except for this
patch. The nommu defconfigs are prob the easiest way to reproduce this:
  /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:41:55: error:=
 'struct riscv_isa_vendor_ext_data_list' has no member named 'vendor_bitmap'
  /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:42:60: error:=
 'struct riscv_isa_vendor_ext_data_list' has no member named 'per_hart_vend=
or_bitmap'; did you mean 'per_hart_isa_bitmap'?
  /build/tmp.QPMRM3oUNu/arch/riscv/kernel/vendor_extensions.c:43:60: error:=
 'struct riscv_isa_vendor_ext_data_list' has no member named 'bitmap_size'

Cheers,
Conor.

--BHMvR13gFgTG0XBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj6ImAAKCRB4tDGHoIJi
0v5GAQDz/COSUgwYOrRhiE95HyXWBcrE7N78mp8pUkk9m/hrFgEAxmMo1xhXO2iP
tU7a1ZH2VRD826Ot6whFO6eC88ci1wU=
=8S+4
-----END PGP SIGNATURE-----

--BHMvR13gFgTG0XBs--

