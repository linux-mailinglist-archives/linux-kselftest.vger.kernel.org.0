Return-Path: <linux-kselftest+bounces-6869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7718916DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 11:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87792885C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB154BFD;
	Fri, 29 Mar 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JNdgM0t4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73F1E52F;
	Fri, 29 Mar 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708341; cv=none; b=HfOw7qAi6w46yPixCLXVlkrQFZ07fGrSV0I3Pddi3Ke6/6ma2myxtg1899NOkOD8IKYoOs8QVwRBM1rcClceWpkfPdJiRcNsx1xO3qNJy///dESTmESXSsKO+WiLfK4YTXFzw2msILkBOcTDnarUGvVF7VBUxKrDruncAADvLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708341; c=relaxed/simple;
	bh=iJRVYl2TkqJgkeeArpXXpoPMdu4mwFR/AAzovQ2QJdk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq1JVeExlFlRHWRu/dMbnCB5xMEhpT59AjXa6cUY1I+nBNLLGXZsYpcbQl2eKbxIS8HpY6m14jO1XuXqKryvO06eZ2YrF0xqn8NCjOZXrhuorRmqLq9gCbwR16wqwPKFk20B75JCS4MKFagR3LcvwUPNq3uzgaDGPlMcN1gEEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JNdgM0t4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711708339; x=1743244339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iJRVYl2TkqJgkeeArpXXpoPMdu4mwFR/AAzovQ2QJdk=;
  b=JNdgM0t4DhfGDJF/S4hODV4utVfr2jQKYX4JhyW0d4VyZ5WgX3JJwxFy
   G2EuPdg61wJV9buFyiXlZNK0YV20lbRCGimdwUNjqM93UjGml1f16gxC3
   TfkU8v5317jUkrq/6NN3h3urx5uyMc6YB8UIKs2F84ahPr+Q3URK0a2Dk
   xmzZPMJut+ENyrBjiOqvkaNSyofpQ+MNxq4g1hHaNHFm3TVP6jBuOC3WM
   ZV4TMBV9kFOyvH6Z7G4qvM7E4vUzP9/XnS3lA6PgKRWLK3LNvZ17eM1uI
   fKF8cLr0F+BuZeURQcr8YfAwMox9cNPiD67M45yCtNmFNktO7U79npaNB
   A==;
X-CSE-ConnectionGUID: GFew/kMnS6C07Mq7X0KFUQ==
X-CSE-MsgGUID: tzrsQPFdTKSvpMZ+9j+6Lw==
X-IronPort-AV: E=Sophos;i="6.07,164,1708412400"; 
   d="asc'?scan'208";a="185901778"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2024 03:32:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 03:32:02 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 03:31:58 -0700
Date: Fri, 29 Mar 2024 10:31:10 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Max Hsu <max.hsu@sifive.com>
CC: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@ucw.cz>, Anup Patel <anup@brainfault.org>, Atish Patra
	<atishp@atishpatra.org>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC 02/11] dt-bindings: riscv: Add Sdtrig optional CSRs
 existence on DT
Message-ID: <20240329-affidavit-anatomist-1118a12c3e60@wendy>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
 <20240329-dev-maxh-lin-452-6-9-v1-2-1534f93b94a7@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qvN9g2Kofm3vp+Ez"
Content-Disposition: inline
In-Reply-To: <20240329-dev-maxh-lin-452-6-9-v1-2-1534f93b94a7@sifive.com>

--qvN9g2Kofm3vp+Ez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 05:26:18PM +0800, Max Hsu wrote:
> The mcontext/hcontext/scontext CSRs are optional in the Sdtrig extension,
> to prevent RW operations to the missing CSRs, which will cause
> illegal instructions.
>=20
> As a solution, we have proposed the dt format for these CSRs.

As I mentioned in your other patch, I amn't sure what the actual value
is in being told about "sdtrig" itself if so many of the CSRs are
optional. I think we should define pseudo extensions that represent
usable subsets that are allowed by riscv,isa-extensions, such as
those you describe here: sdtrig + mcontext, sdtrig + scontext and
sdtrig + hcontext. Probably also for strig + mscontext. What
additional value does having a debug child node give us that makes
it worth having over something like the above?

Thanks,
Conor.

>=20
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index d87dd50f1a4b..c713a48c5025 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -137,6 +137,24 @@ properties:
>        DMIPS/MHz, relative to highest capacity-dmips-mhz
>        in the system.
> =20
> +  debug:
> +    type: object
> +    properties:
> +      compatible:
> +        const: riscv,debug-v1.0.0
> +      trigger-module:
> +        type: object
> +        description: |
> +          An indication set of optional CSR existence from
> +          riscv-debug-spec Sdtrig extension
> +        properties:
> +          mcontext-present:
> +            type: boolean
> +          hcontext-present:
> +            type: boolean
> +          scontext-present:
> +            type: boolean
> +
>  anyOf:
>    - required:
>        - riscv,isa
>=20
> --=20
> 2.43.2
>=20

--qvN9g2Kofm3vp+Ez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgaYbgAKCRB4tDGHoIJi
0lR6APsFCJD2xF6mivD5+737cpFwlpgCAnMllMxOmWsck2HUJgD9EN3UFh3/VEM/
G9adYYLQT0pjKI5lJOtelWT/0qhIsg4=
=evUa
-----END PGP SIGNATURE-----

--qvN9g2Kofm3vp+Ez--

