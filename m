Return-Path: <linux-kselftest+bounces-39991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA6DB37176
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8BAA4E21F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4A52E7F21;
	Tue, 26 Aug 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVayjwHO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFDB3AC22;
	Tue, 26 Aug 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229999; cv=none; b=l52Cpg9P9kz9zH2VF9bkv/kJO4jTiJNS28X/rtC/LzNmNZ7X6WFh6G52NCq5b3mL0AcU4ZaWXWsFknDXDIAmYSTemxG1cg28x923kHrD5R6ZfGP9+YMk+akBLn4Y34VPZARCXZupzvolwc0j5pvuORTO76eHKN3TVWVix2GKL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229999; c=relaxed/simple;
	bh=pzp/1YNnhuAlM0ZR7J+bD9wVkHtRAHZ81g8KyslciX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itzkpa2XWr8e1XfEbbCWnEHklY6p+9POmgnO4i7Qu75wEGtP2pM4EAk241lsFsPvsySM+A5RoUQ9xC4v3t7iuYfzs1BeelrY2sQZ9QWquorKDY0cqskcaR5IQfGqJEtRFn9MJ/Wl6wjvwmw3AvTXoX1z8npYsNNowFpwAxdwzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVayjwHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E39C4CEF1;
	Tue, 26 Aug 2025 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756229998;
	bh=pzp/1YNnhuAlM0ZR7J+bD9wVkHtRAHZ81g8KyslciX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVayjwHOdmvCCqW1IgjHYAkllOmujNCCDJN+m9bTiqzrSNKwbUgxbJPjkeCvFBdgz
	 uJd0vvcMUKyL6f1yVQ7AZzQaAOiIKk5dfvT1gbNmDkOItxlhY+AP4Mj0R3g4yf6rhI
	 qp3nRtAFsNjzYYNm+cKh0Ws//QEIPSQTm8kmOyV1VAdGlSZ6XBT9+i0xS0Wk8ziqVO
	 flKAevQ8L6TuYQKe7uo/TPfMb+sVisM7OYJaEASvuLdFFhf3bfzKBhdcUnM21TQQgo
	 vEQ9t1YhCNESddF40c2WfgaRFh11wI17LaNlnb+vqSiC1Ecre6t/AsgQ9aOL3ugzw2
	 THiaBvyaAShSA==
Date: Tue, 26 Aug 2025 18:39:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anup@brainfault.org, pbonzini@redhat.com,
	shuah@kernel.org, cyan.yang@sifive.com, cleger@rivosinc.com,
	charlie@rivosinc.com, cuiyunhui@bytedance.com,
	samuel.holland@sifive.com, namcao@linutronix.de, jesse@rivosinc.com,
	inochiama@gmail.com, yongxuan.wang@sifive.com,
	ajones@ventanamicro.com, parri.andrea@gmail.com,
	mikisabate@gmail.com, yikming2222@gmail.com,
	thomas.weissschuh@linutronix.de, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: riscv: add Zilsd and Zclsd extension
 descriptions
Message-ID: <20250826-clothes-vowel-1f0963fc42ff@spud>
References: <20250826162939.1494021-1-pincheng.plct@isrc.iscas.ac.cn>
 <20250826162939.1494021-2-pincheng.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="27ZJqi86mMpq/eWJ"
Content-Disposition: inline
In-Reply-To: <20250826162939.1494021-2-pincheng.plct@isrc.iscas.ac.cn>


--27ZJqi86mMpq/eWJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:29:35AM +0800, Pincheng Wang wrote:
> Add descriptions for the Zilsd (Load/Store pair instructions) and
> Zclsd (Compressed Load/Store pair instructions) ISA extensions
> which were ratified in commit f88abf1 ("Integrating load/store
> pair for RV32 with the main manual") of the riscv-isa-manual.
>=20
> Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--27ZJqi86mMpq/eWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaK3xZgAKCRB4tDGHoIJi
0mOhAP9F45h1Fcetvk8xlRYVErmo8gP1m35XC/DSjzThbs9vFgD+IpewfSzYBb4f
A1hymZOEsi3/p/jDLggWKB/ISwmfYQg=
=xIh1
-----END PGP SIGNATURE-----

--27ZJqi86mMpq/eWJ--

