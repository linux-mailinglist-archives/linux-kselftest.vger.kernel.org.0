Return-Path: <linux-kselftest+bounces-30608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C8DA860CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 16:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3EE169635
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF83C1F4606;
	Fri, 11 Apr 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjGetJCr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38627450;
	Fri, 11 Apr 2025 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382322; cv=none; b=LtT6tlmqLKkchc985Xie3Z+qwRYR/8A6qNmRbN9eF+UchKpKr+gk60VyW8FtMCG3kgjidUUj82uE6/gGe2WATVC0RgacxizCAtrodZx3PgJmjuJpp2xplyyP2P+9Y5kwlUAM5opnCBRnhpCn+F2mfJz9QKdU0BrrW+ZRVHrZZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382322; c=relaxed/simple;
	bh=jAJlS5q852euhAe6wyd7vFRnrkERexMZBYRdv4EcB0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iatTQY90hLEUv07ZZm6S3J3RYCI5RXovC3R4EzRLmbRbjyjeAvl5efPtCnv0GI69x5pRgLHLKtmgzeWoGrJBElOytojFOpWdfKK+v2UVBaTDCDV9VihHU9bOVkZ6inyU4xqBoX+0jvSpKeb9rKEw83JHsUqTHRZaYOkxCZ59prQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjGetJCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44D2C4CEE2;
	Fri, 11 Apr 2025 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744382322;
	bh=jAJlS5q852euhAe6wyd7vFRnrkERexMZBYRdv4EcB0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjGetJCrr/sz6vp/t4NriLyM4AZgVjR1JD0g+XkmUyXoFZHKgEQliaAbU+YsF+ybt
	 +kcTXDIuo8zlyiy4PyXingdVCLrv8uCQeiFIl3dFvjH+WekfZBZ5Y9GOnietOAzshD
	 ibwGTqV9WUMxsRnO87Bluy1qqlXXaaqUVGpHo2pBETy7CeTs5nGg0pR4oDuKtygLL5
	 7Yhtwk7+l+yWYExiqmDbhGimC/igkoymfZdjapsjUQ6fv6tclOCWQ2Q637Z2M1a7TQ
	 ZHuRrtXWYaNoVkzT0Y57jM/Hz+Q0LiBDEaJJ5g/dcC0w5u0Oy8FWg3Cd9UnVF5wh0R
	 ljhES93+qM6oA==
Date: Fri, 11 Apr 2025 09:38:40 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v17 04/15] dt-bindings: PCI: pci-ep: Add support for
 iommu-map and msi-map
Message-ID: <20250411143840.GA3153754-robh@kernel.org>
References: <20250407-ep-msi-v17-0-633ab45a31d0@nxp.com>
 <20250407-ep-msi-v17-4-633ab45a31d0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-ep-msi-v17-4-633ab45a31d0@nxp.com>

On Mon, Apr 07, 2025 at 03:50:54PM -0400, Frank Li wrote:
> Document the use of (msi|iommu)-map for PCI Endpoint (EP) controllers,
> which can use MSI as a doorbell mechanism. Each EP controller can support
> up to 8 physical functions and 65,536 virtual functions.
> 
> Define how to construct device IDs using function bits [2:0] and virtual
> function index bits [31:3], enabling (msi|iommu)-map to associate each
> child device with a specific (msi|iommu)-specifier.
> 
> The EP cannot rely on PCI Requester ID (RID) because the RID is determined
> by the PCI topology of the host system. Since the EP may be connected to
> different PCI hosts, the RID can vary between systems and is therefore not
> a reliable identifier.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v16 to v17
> - new patch
> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml | 67 +++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> index f75000e3093db..a1a5b9b8ef859 100644
> --- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> @@ -53,6 +53,73 @@ properties:
>        must be unique.
>      $ref: /schemas/types.yaml#/definitions/uint32
>  
> +  msi-map:

Not that the rest of the file is alphabetized, but put i before m.

> +    description: |
> +      Maps a Device ID to an MSI and associated MSI specifier data.
> +
> +      A PCI Endpoint (EP) can use MSI as a doorbell function. This is achieved by
> +      mapping the MSI controller's address into PCI BAR<n>. The PCI Root Complex
> +      can write to this BAR<n>, triggering the EP to generate IRQ. This notifies
> +      the EP-side driver of an event, eliminating the need for the driver to
> +      continuously poll for status changes.
> +
> +      However, the EP cannot rely on Requester ID (RID) because the RID is
> +      determined by the PCI topology of the host system. Since the EP may be
> +      connected to different PCI hosts, the RID can vary between systems and is
> +      therefore not a reliable identifier.
> +
> +      Each EP can support up to 8 physical functions and up to 65,536 virtual
> +      functions. To uniquely identify each child device, a device ID is defined
> +      as
> +         - Bits [2:0] for the function number (func)
> +         - Bits [18:3] for the virtual function index (vfunc)
> +
> +      The resulting device ID is computed as:
> +
> +        (func & 0x7) | (vfunc << 3)
> +
> +      The property is an arbitrary number of tuples of
> +      (device-id-base, msi, msi-base,length).
> +
> +      Any Device ID id in the interval [id-base, id-base + length) is
> +      associated with the listed MSI, with the MSI specifier
> +      (id - id-base + msi-base).
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      items:
> +        - description: The Device ID base matched by the entry
> +          maximum: 0x7ffff
> +        - description: phandle to msi-controller node
> +        - description: (optional) The msi-specifier produced for the first
> +            Device ID matched by the entry. Currently, msi-specifier is 0 or
> +            1 cells.
> +        - description: The length of consecutive Device IDs following the
> +            Device ID base
> +          maximum: 0x80000
> +
> +  msi-map-mask:
> +    description: A mask to be applied to each Device ID prior to being
> +      mapped to an msi-specifier per the msi-map property.
> +    $ref: /schemas/types.yaml#/definitions/uint32

maximum: 0x7ffff ?

> +
> +  iommu-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      items:
> +        - description: Device ID (see msi-map) base
> +          maximum: 0x7ffff
> +        - description: phandle to IOMMU
> +        - description: IOMMU specifier base (currently always 1 cell)
> +        - description: Number of Device IDs
> +          maximum: 0x80000
> +
> +  iommu-map-mask:
> +    description:
> +      A mask to be applied to each Device ID prior to being mapped to an
> +      IOMMU specifier per the iommu-map property.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 0xffff

0x7ffff ?

> +
>  required:
>    - compatible
>  
> 
> -- 
> 2.34.1
> 

