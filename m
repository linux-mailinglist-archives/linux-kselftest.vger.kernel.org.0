Return-Path: <linux-kselftest+bounces-27963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6D7A4AAAD
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 12:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0C0172854
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B001DE3D7;
	Sat,  1 Mar 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4YkjQGX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACD81CEAC3;
	Sat,  1 Mar 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829039; cv=none; b=uIc28j42mnQRbpP+dFuiz33I8XDGH23/RtBVz0mlZjJJQU2UqwHWxKbLZmizkw6zoLj5JB5+B/tY5rlE9cWMp/8jWEbFLYxWqzeEleh1Ldp3Y9LdRi4x9vZ5+4BHzK+VjeHuxboZQIsdDVjiOKtUvU1FHE36uHe/3LdFoE2mrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829039; c=relaxed/simple;
	bh=dT1M1OX+ylPajgi5Td8FsnYT9PqPEbMJ8aqpho8rjqg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5tTayQWvl83Lm1moGzPOHS2jJdhwG7tlpGZfFyj6C10wa32ATpFNK94YzLJWQQC1tnj1rVZbFOKJKS4tRxwAZ+Q7XTP/qGqO147id7Jhp8TGLgW21nyVnvhiaVcnjfQ9M4nf3EUnlAcfG40vJZdl6olJXuT5OGrGQzJjROVlNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4YkjQGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65B4C4CEDD;
	Sat,  1 Mar 2025 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740829038;
	bh=dT1M1OX+ylPajgi5Td8FsnYT9PqPEbMJ8aqpho8rjqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C4YkjQGX6x6uoqD6Yp0dQzTZmmjynM5ZIjQO1YdQc/B25rqm+rh5x1Bvsl3Dj58HK
	 YScw9Ja1tcJ+UlVcN96f3Jy3ZvCLC1oGKJxQcwbyNt5yXICRQyar9NwH56rNV0topG
	 jrVpGwESZOOLk5ipIfxlDX5vS8c+mUKwL0v88GwfqX20dXbetBND2cLR2SEdaQhU4k
	 IITTb+dvnaHe598YW8cwOLVdH9RtR9jrl1Il7lpAqzLA/77pRVd8khTcG878nI227d
	 QMiaFy+Li24BsLTa+GTXdBejTqgQ+27pLw8Y1XEw33fAy0FBukYnULAwheiuenQiU9
	 unJQ/MU58slxQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1toL9f-009LZ4-9D;
	Sat, 01 Mar 2025 11:37:15 +0000
Date: Sat, 01 Mar 2025 11:37:14 +0000
Message-ID: <86o6ylouc5.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,	"Rafael J. Wysocki"
 <rafael@kernel.org>,	Thomas Gleixner <tglx@linutronix.de>,	Anup Patel
 <apatel@ventanamicro.com>,	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,	Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,	Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kw@linux.com>,	Bjorn Helgaas <bhelgaas@google.com>,	Arnd Bergmann
 <arnd@arndb.de>,	Shuah Khan <shuah@kernel.org>,	Richard Zhu
 <hongxing.zhu@nxp.com>,	Lucas Stach <l.stach@pengutronix.de>,	Lorenzo
 Pieralisi <lpieralisi@kernel.org>,	Rob Herring <robh@kernel.org>,	Shawn Guo
 <shawnguo@kernel.org>,	Sascha Hauer <s.hauer@pengutronix.de>,	Pengutronix
 Kernel Team <kernel@pengutronix.de>,	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,	Conor Dooley
 <conor+dt@kernel.org>,	Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org,	jdmason@kudzu.us,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org,	imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v15 04/15] irqchip/gic-v3-its: Add support for device tree msi-map and msi-mask
In-Reply-To: <20250211-ep-msi-v15-4-bcacc1f2b1a9@nxp.com>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
	<20250211-ep-msi-v15-4-bcacc1f2b1a9@nxp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: Frank.Li@nxp.com, kishon@kernel.org, rafael@kernel.org, tglx@linutronix.de, apatel@ventanamicro.com, gregkh@linuxfoundation.org, dakr@kernel.org, manivannan.sadhasivam@linaro.org, kw@linux.com, bhelgaas@google.com, arnd@arndb.de, shuah@kernel.org, hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org, dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 11 Feb 2025 19:21:57 +0000,
Frank Li <Frank.Li@nxp.com> wrote:
>=20
> Some platform devices create child devices dynamically and require the
> parent device's msi-map to map device IDs to actual sideband information.
>=20
> A typical use case is using ITS as a PCIe Endpoint Controller(EPC)'s
> doorbell function, where PCI hosts send TLP memory writes to the EP
> controller. The EP controller converts these writes to AXI transactions
> and appends platform-specific sideband information.  See below figure.
>=20
>                =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90
>                =E2=94=82                                =E2=94=82
>                =E2=94=82     PCI Endpoint Controller    =E2=94=82
>                =E2=94=82                                =E2=94=82
>                =E2=94=82  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90     =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90 =E2=94=82
>     PCI Bus    =E2=94=82  =E2=94=82     =E2=94=82   =E2=94=82     =E2=94=
=82     =E2=94=82     =E2=94=82 =E2=94=82
>     =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=96=BA =E2=94=82  =E2=94=82Func1=E2=94=82   =E2=94=82Func2=
=E2=94=82 ... =E2=94=82Func =E2=94=82 =E2=94=82
>     TLP Memory =E2=94=82  =E2=94=82     =E2=94=82   =E2=94=82     =E2=94=
=82     =E2=94=82<n>  =E2=94=82 =E2=94=82
>     Write Push =E2=94=82  =E2=94=82     =E2=94=82   =E2=94=82     =E2=94=
=82     =E2=94=82     =E2=94=82 =E2=94=82
>     DoorBell   =E2=94=82  =E2=94=94=E2=94=80=E2=94=AC=E2=94=80=E2=94=AC=
=E2=94=80=E2=94=98   =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=
=E2=94=98     =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=98 =E2=94=82
>                =E2=94=82    =E2=94=82 =E2=94=82        =E2=94=82         =
  =E2=94=82    =E2=94=82
>                =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=
=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98
>         sideband    =E2=94=82 =E2=94=82 Address=E2=94=82           =E2=94=
=82
>         information =E2=96=BC =E2=96=BC /Data  =E2=96=BC           =E2=96=
=BC
>                    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90
>                    =E2=94=82    MSI Controller      =E2=94=82
>                    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98
>

Please stop using these figures in commit messages. I don't think they
help, and they are not in consistent with the way the commit messages
are managed.

> EPC's DTS will provide such information by msi-map and msi-mask. A
> simplified dts as
>=20
> pcie-ep@10000000 {
> 	...
> 	msi-map =3D <0 &its 0xc 8>;
>                           ^^^ 0xc is implement defined sideband informati=
on,
> 			      which append to AXI write transaction.
> 	           ^ 0 is function index.

What does this sideband field represent? How is the ITS driver
supposed to use that data? Is it the full devid as presented to the
ITS? Something combined with the "function index"? Is the "function
index" a full RID, as defined in the documentation?

Also, msi-map is so far reserved to a PCIe RC, not this sort of wonky
contraption. This needs to be documented.

>=20
> 	msi-mask =3D <0x7>
> }
>=20
> Check msi-map if msi-parent missed to keep compatility with existed syste=
m.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v14 to v15
> - none
>=20
> change from v13 to v14
> new patch
> ---
>  drivers/irqchip/irq-gic-v3-its-msi-parent.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchi=
p/irq-gic-v3-its-msi-parent.c
> index e150365fbe892..6c7389bb84a4a 100644
> --- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> +++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> @@ -118,6 +118,14 @@ static int of_pmsi_get_dev_id(struct irq_domain *dom=
ain, struct device *dev,
>  		index++;
>  	} while (!ret);
> =20
> +	if (ret) {
> +		struct device_node *np =3D NULL;
> +
> +		ret =3D of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &n=
p, dev_id);
> +		if (np)
> +			of_node_put(np);
> +	}
> +
>  	return ret;
>  }
> =20
>=20

Thanks,

	M.

--=20
Without deviation from the norm, progress is not possible.

