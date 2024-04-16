Return-Path: <linux-kselftest+bounces-8180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C68A6FFE
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9B61C208C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73E91311B5;
	Tue, 16 Apr 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujZk1EHT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF2130E55;
	Tue, 16 Apr 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281974; cv=none; b=QSfYZxlvMgPb/wsB1RMlclQZYB/uJ+cyBy3KUHQhLdOG79VdOeowFVmvydHL1rEjmAjRSDAGs5R5VDg4DB6SN9RY7bb6ou5NWxq5KFGFyLHl4UjZ2xQZgjX6e4JHNQMHcZsgAfajfZbkV/gmdpZ4zxEcE8iDqJXHsC08qukHx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281974; c=relaxed/simple;
	bh=KJDi6z6/U9cziW9yQDAhSzhquj/YiV34HJLdtVilEJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNzEuQpRIu3+1ujur7fgx9uPVMVnxEBu2Fmg+ZsaRlk3g/q9L/9NdEoXZJLWrcB611UYOeS95S1KqzQKC3DjV9HCoo5FypvspxbyyxBAkn1SGc80YEiqzhBbvnRLo7qvn3p/TwE8P+gnvCD6T+Bjei4R5Xj/WVKxzzBXFkmzjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujZk1EHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4CAC2BD10;
	Tue, 16 Apr 2024 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713281974;
	bh=KJDi6z6/U9cziW9yQDAhSzhquj/YiV34HJLdtVilEJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujZk1EHTMYG6e3LIKsVhqs298UOQP1HsHzdkcfICrpHwZ3YUadJ4RC2OobgfiPNHI
	 lAtOcI+YXVprYmBTkU2ebh69W4CDs8tLl+aB19+l8f7FcutfSctw0Aa6boskTtBI+D
	 AWFlkLNLrnMUx2/zFkx8yQ/J+g9wO6I5/R6lR+a0vv2CHU7SZWJSu9Xkxk5xEeQbXx
	 37RokpQuCiFj6tviL8/Ae8K84VyLdbTd2ubOoeeJ5Pmw0VdDAPXE/RJDHPB8NigPsR
	 aL1UjrRjQT6wIjr9mDMEuT0mlNfdfCKuFi14iFBvH8AGKKx3s1z0luTqJLt7Mdembq
	 IJwgP4grIJdvA==
Date: Tue, 16 Apr 2024 16:39:27 +0100
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
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 00/17] riscv: Support vendor extensions and
 xtheadvector
Message-ID: <20240416-hurry-garbage-c5b43241dbe0@spud>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MtdbaA8z8FH3b/rB"
Content-Disposition: inline
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>


--MtdbaA8z8FH3b/rB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2024 at 09:11:57PM -0700, Charlie Jenkins wrote:

> Changes in v2:
> - Added commit hash to xtheadvector
> - Simplified riscv,isa vector removal fix to not mess with the DT
>   riscv,vendorid
> - Moved riscv,vendorid parsing into a different patch and cache the
>   value to be used by alternative patching
> - Reduce riscv,vendorid missing severity to "info"
> - Separate vendor extension list to vendor files
> - xtheadvector no longer puts v in the elf_hwcap

> - Only patch vendor extension if all harts are associated with the same
>   vendor. This is the best chance the kernel has for working properly if
>   there are multiple vendors.

I don't agree with this lack of trust in what firmware is telling us.

I'm not really gonna review this v2 until discussion has finished in v1
about some things, I fundamentally disagree with handling the same
extension differently for different CPU vendors and I don't wanna
fracture that conversation further.

> - Split hwprobe vendor keys out into vendor file
> - Add attribution for Heiko's patches
> - Link to v1: https://lore.kernel.org/r/20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com

--MtdbaA8z8FH3b/rB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6brwAKCRB4tDGHoIJi
0mfRAQDv3w5+C9suCRRRiwfjjVWoUxMRKczJo1O3djhERhZohQEA3PKM7ixcBZ/+
gCDOCf12p1w6L8bmXsvYZ36xQsLl6g0=
=ZdJE
-----END PGP SIGNATURE-----

--MtdbaA8z8FH3b/rB--

