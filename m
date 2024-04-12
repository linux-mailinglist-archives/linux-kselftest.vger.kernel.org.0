Return-Path: <linux-kselftest+bounces-7790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380488A2D6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 13:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1E51F21B28
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 11:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A55579A;
	Fri, 12 Apr 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DnUYCztZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88154F8C;
	Fri, 12 Apr 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921352; cv=none; b=tJYq9wIwYbgYACX6r7MSVkggtzaYJoFh8rF6wQfSOwW7rVkef8HVbMwlMpYdVs+8GduChI4pMAGyDfoRYiZ31FnXHQpF25Vk4T5URbJ8qw0WlrAsMsfcORO2oZy06+FiOvf/GPJYzoZNvl8kRCWt341hOTYDSVnguGanpZAr200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921352; c=relaxed/simple;
	bh=iquIxgsQ5Z0mH9RFgypFv0gNEXhHWS+sF3ZCfjbshog=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTb7OCox379Qt076ESy8Lj5uZ+d8E8wk71t/1YA5NMgxvpqn4GqmNYBKSo4aywqzazetuDkCw4Oat87z4GozhRxpmw2m6KASQ8WYimB0Qm2RjU9BOhIFCZZ3f6T5Su74HaXNtP3Hf0ooUyJxIls0yic1LR0rsXMxScZRok6feHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DnUYCztZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712921349; x=1744457349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iquIxgsQ5Z0mH9RFgypFv0gNEXhHWS+sF3ZCfjbshog=;
  b=DnUYCztZc4n08wUpkJ9KzxUEULZvyuBmpGEiRENqw+spcJ2dWC92zDlD
   vDZ/sHLjbSjVXjRpWKzSaEJoO0pfaJ0gk0t2IEbjwOZkhLAZ139Z2zV7G
   M5Ot1ithL9PEMtqrrFA5hCgTK58drIpy5LuZuQnNXXQUzYbdNqPpauXbQ
   KcJxU6ivrWbWC4kce+5dQbQsl44ZpGWvu0Ynk/qNgsGiFPZ3k1SIUOMLB
   LQDggLzfYT5DMGeifUQ4YKaQ67q4vyIi8AKC+JWdqoqjQQBKIgqWpJpOj
   QBEZ0GhphGhkQ62FIi6HAvsLBYYRo8XaV+0lXUA8xEuPDFlzfYzMkpYJX
   w==;
X-CSE-ConnectionGUID: UqSsJJfvSp2/HXPpn3qbvQ==
X-CSE-MsgGUID: gSMNaP1WQzarJHb4JiP76w==
X-IronPort-AV: E=Sophos;i="6.07,195,1708412400"; 
   d="asc'?scan'208";a="22708479"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Apr 2024 04:29:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 04:28:45 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 12 Apr 2024 04:28:41 -0700
Date: Fri, 12 Apr 2024 12:27:50 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Evan Green
	<evan@rivosinc.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?=
	<cleger@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<shuah@kernel.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 10/19] RISC-V: define the elements of the VCSR vector CSR
Message-ID: <20240412-viper-bullish-d57d19805a0c@wendy>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-10-4af9815ec746@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1/ezE870fxXOLLQw"
Content-Disposition: inline
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-10-4af9815ec746@rivosinc.com>

--1/ezE870fxXOLLQw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 09:11:16PM -0700, Charlie Jenkins wrote:
> From: Heiko Stuebner <heiko@sntech.de>
>=20
> The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].
>=20
> Define constants for those to access the elements in a readable way.
>=20
> Acked-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

You need to sign off on this as the submitter Charlie.

--1/ezE870fxXOLLQw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhkatgAKCRB4tDGHoIJi
0qMCAP9WmrMY90YHP5yda7KsglQlByWGisuGhCvnYWypcd/ApAEAs5xulwNb27Gc
2B7pEO73kwar/VMuJdyiGb3RMX/V4Ao=
=n51g
-----END PGP SIGNATURE-----

--1/ezE870fxXOLLQw--

