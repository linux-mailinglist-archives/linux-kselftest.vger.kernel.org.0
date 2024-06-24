Return-Path: <linux-kselftest+bounces-12553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4719191477C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 12:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F193F2868D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150AE1369AE;
	Mon, 24 Jun 2024 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RR0c0+ac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036B3BBF2;
	Mon, 24 Jun 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224960; cv=none; b=NlL/Au6AuJgXN72diZi27wB5tMLWgbCAE0lif43PQgLvIwt2GFYw267Kvn5pS3wBS6SQ5WN9cQCtJTVFfQNgan6J3Oaxubb2EVXxfNe72bxA7Jw2GkZ98rnXDESZ0HbuLw+R+ZUFtZkgeTiCdIj/+8C+bzE0MNNsWAZnENUbvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224960; c=relaxed/simple;
	bh=wNeAG9yIK0CZl4N/ZkvXzvReYFJ5z22Ul9DecMcs2k4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iULAN8kUD0YoJ0cMj2EC6sbh1n5MRCjme3y6EKWdmFkCVVTh90HlsL5zQFsQV0eSEUmtlaevMxx54l1mfjsfjPpaRI/Rq9lHbZbTEPQxBD+ZSPG/D/w5mi+GyOn823bSqPoviG2NJUCaNzOMz2QQXpl57aiCt6JHc1nKdaIZArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RR0c0+ac; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719224959; x=1750760959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wNeAG9yIK0CZl4N/ZkvXzvReYFJ5z22Ul9DecMcs2k4=;
  b=RR0c0+ac84k6ftIqr5qrbitbQnOjleuaqa2scbLpUQq0PpKEy7I+6XRv
   JdVbNjr+LQP/lwMSQDDe2I+ODVmrYadb7TOvGVPep+0sdgvQ++pzN9jgm
   sTxcxQw4AO7TCe76/j5CHYGnFjMxiBW0kZVYq7JNc4GSJyO1jh/ool5qZ
   XB9xybuo0g9Q5gBgCg7NJR3L/S49kI6GuZy+AHo+rDv57QdJVXpX4t8cm
   /xoV4duUxrN7fCbL3b53TtwmzKHE8oTftzPu/TJU0IhwRBEvLdoZuSwF4
   KGrpSRspt2y5+poUEC6EAwxG62yCiCgNwSx+DEY5wJUkhZVSfyRod3V95
   Q==;
X-CSE-ConnectionGUID: waFIp9S2RTGCYk7TOATuyQ==
X-CSE-MsgGUID: TZMuc6vpTuuD6P8hbW5QIA==
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="asc'?scan'208";a="28414746"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2024 03:29:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 24 Jun 2024 03:28:59 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 24 Jun 2024 03:28:56 -0700
Date: Mon, 24 Jun 2024 11:28:41 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Anup Patel
	<anup@brainfault.org>, Shuah Khan <shuah@kernel.org>, Atish Patra
	<atishp@atishpatra.org>, <linux-doc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <kvm@vger.kernel.org>,
	<kvm-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v7 08/16] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
Message-ID: <20240624-remission-dominoes-9f22be5ba999@wendy>
References: <20240619113529.676940-1-cleger@rivosinc.com>
 <20240619113529.676940-9-cleger@rivosinc.com>
 <20240623-cornbread-preteen-4ec287aa165c@spud>
 <c59a8897-34a1-4dc3-b68b-35dddf55c937@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="022xOD13U5wpppzg"
Content-Disposition: inline
In-Reply-To: <c59a8897-34a1-4dc3-b68b-35dddf55c937@rivosinc.com>

--022xOD13U5wpppzg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:24:51AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 23/06/2024 17:42, Conor Dooley wrote:
> > On Wed, Jun 19, 2024 at 01:35:18PM +0200, Cl=E9ment L=E9ger wrote:
> >> The Zc* standard extension for code reduction introduces new extension=
s.
> >> This patch adds support for Zca, Zcf, Zcd and Zcb. Zce, Zcmt and Zcmp
> >> are left out of this patch since they are targeting microcontrollers/
> >> embedded CPUs instead of application processors.
> >>
> >> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>
> >> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >>  arch/riscv/include/asm/hwcap.h |  4 +++
> >>  arch/riscv/kernel/cpufeature.c | 55 +++++++++++++++++++++++++++++++++-
> >>  2 files changed, 58 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/h=
wcap.h
> >> index 18859277843a..b12ae3f2141c 100644
> >> --- a/arch/riscv/include/asm/hwcap.h
> >> +++ b/arch/riscv/include/asm/hwcap.h
> >> @@ -87,6 +87,10 @@
> >>  #define RISCV_ISA_EXT_ZVE64F		78
> >>  #define RISCV_ISA_EXT_ZVE64D		79
> >>  #define RISCV_ISA_EXT_ZIMOP		80
> >> +#define RISCV_ISA_EXT_ZCA		81
> >> +#define RISCV_ISA_EXT_ZCB		82
> >> +#define RISCV_ISA_EXT_ZCD		83
> >> +#define RISCV_ISA_EXT_ZCF		84
> >> =20
> >>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> >> =20
> >> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufea=
ture.c
> >> index a3af976f36c9..aa631fe49b7c 100644
> >> --- a/arch/riscv/kernel/cpufeature.c
> >> +++ b/arch/riscv/kernel/cpufeature.c
> >> @@ -111,6 +111,9 @@ static int riscv_ext_zicboz_validate(const struct =
riscv_isa_ext_data *data,
> >> =20
> >>  #define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _=
id, NULL, 0, NULL)
> >> =20
> >> +#define __RISCV_ISA_EXT_DATA_VALIDATE(_name, _id, _validate) \
> >> +			_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, _validate)
> >> +
> >>  /* Used to declare pure "lasso" extension (Zk for instance) */
> >>  #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> >>  	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
> >> @@ -122,6 +125,37 @@ static int riscv_ext_zicboz_validate(const struct=
 riscv_isa_ext_data *data,
> >>  #define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _val=
idate) \
> >>  	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _v=
alidate)
> >> =20
> >> +static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *dat=
a,
> >=20
> > It's super minor, but my OCD doesn't like this being called "depends"
> > when the others are all called "validate".
>=20
> Ok, let's make a deal. You review patch 14/16 and I'll make the machine
> part of you happy and call this function validate ;)

I generally avoid the hwprobe patches intentionally :) I'm not even
expecting a respin for this tbh, I'd like to just get it in so that I
can do things on top of it.

--022xOD13U5wpppzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnlKWAAKCRB4tDGHoIJi
0qTZAQDW6NkBEEY0BpVBm4oazaou8r5axQXRsRokUPZuDY/Q/wEA7XbMZLRFekMt
ZYMxRfkbyf9XPgmg2W/WvyHnahDlhA4=
=Ozsy
-----END PGP SIGNATURE-----

--022xOD13U5wpppzg--

