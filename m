Return-Path: <linux-kselftest+bounces-37067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6308B0151D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 09:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C403B9396
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 07:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48536205AA1;
	Fri, 11 Jul 2025 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0+Xv5Xl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C4202C5C;
	Fri, 11 Jul 2025 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219939; cv=none; b=quE+InjpjzwrWQ1Umgr9lq5BKgNoBkfzFjFlYMAAV9uaT9yO3rg6vyczbmXqfP61I6qRKpRjHLtblo8n1lUyqZSPEK5LSOL7gZsrTiOm+y5rSvo/k56BKXHRUiJNrQVrx7XKad/bxgfwSELB6X7n7kXkkhTkVRxbAwo4kHOdaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219939; c=relaxed/simple;
	bh=gpOEXh/tkkdMvtKnEFy+UBpnu0hmbuwIrGzuHPvq4sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSjBr5NJmQV+2bY4yXFON7AKLez36ZOlTqAVmQ3z53vPuip8QFkqMnvHnCrhm5STTOEDVVGoqobQhLm74FxbwYhO5pOHCWYqXQNxcodQH1wDHYBHZPQlxSNCGNzFsTrWrVhooGg8DAClON/11xWuuKZH8Rc9bzqwd9iIKgjPCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0+Xv5Xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA952C4CEED;
	Fri, 11 Jul 2025 07:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752219937;
	bh=gpOEXh/tkkdMvtKnEFy+UBpnu0hmbuwIrGzuHPvq4sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0+Xv5Xl46ARoxRuBAaUWmx+tLBkwAcZ3S4k9GUD4qOrdj9uB9Md+LgH7ZcksYDR6
	 mStpaawxXo5K02FGAwzNYZ4ns3h3V0u9IQFDN6ozeim1zg1ZjdZDe98sLyeZdlOXhh
	 EL7aFlqhUBNTmJiWUAgbkmQ72rVKbJpZNL5kr2IreoSBqMgkZBv+/h0iBotkztuIpu
	 VhYXsUzT29yMClmmATnBEDwdp9bBfRbSl7mt6t7a57ZnuwPShB8+SDAIL0rPruh3TU
	 IL6sltjrYxDFiU+o6o1GDCNaLYfRSyB9iBjQzZeD0kTTIPsaJyT9CJNj7FARpbjQFl
	 DS/dzbEISNUsA==
Date: Fri, 11 Jul 2025 09:45:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank.Li@nxp.com
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v21 0/9] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Message-ID: <aHDBGDFnYZF_2luF@ryzen>
References: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>

On Thu, Jul 10, 2025 at 03:13:46PM -0400, Frank Li via B4 Relay wrote:
> Frank Li (9):
>       PCI: imx6: Add helper function imx_pcie_add_lut_by_rid()
>       PCI: imx6: Add LUT configuration for MSI/IOMMU in Endpoint mode
>       PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
>       PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
>       PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
>       PCI: endpoint: pci-epf-test: Add doorbell test support
>       misc: pci_endpoint_test: Add doorbell test case
>       selftests: pci_endpoint: Add doorbell test case
>       arm64: dts: imx95: Add msi-map for pci-ep device
> 
>  Documentation/PCI/endpoint/pci-test-howto.rst      |  14 +++
>  arch/arm64/boot/dts/freescale/imx95.dtsi           |   1 +
>  drivers/misc/pci_endpoint_test.c                   |  85 ++++++++++++-
>  drivers/pci/controller/dwc/pci-imx6.c              |  25 ++--
>  drivers/pci/endpoint/Kconfig                       |   8 ++
>  drivers/pci/endpoint/Makefile                      |   1 +
>  drivers/pci/endpoint/functions/pci-epf-test.c      | 136 +++++++++++++++++++++
>  drivers/pci/endpoint/pci-ep-msi.c                  |  98 +++++++++++++++
>  drivers/pci/endpoint/pci-epf-core.c                |  36 ++++++
>  include/linux/pci-ep-msi.h                         |  28 +++++
>  include/linux/pci-epf.h                            |  18 +++
>  include/uapi/linux/pcitest.h                       |   1 +
>  .../selftests/pci_endpoint/pci_endpoint_test.c     |  28 +++++
>  13 files changed, 470 insertions(+), 9 deletions(-)
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20241010-ep-msi-8b4cab33b1be
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
> 
> 

Tested on rock5b (which uses the rk3588 SoC), by adding the same msi-map to
the pcie3x4_ep DT node as (what already exists in) the pcie3x4 (RC) DT node:

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
index 90414486e466..c0121aea791d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi
@@ -389,6 +389,7 @@ pcie3x4_ep: pcie-ep@fe150000 {
                interrupt-names = "sys", "pmc", "msg", "legacy", "err",
                                  "dma0", "dma1", "dma2", "dma3";
                max-link-speed = <3>;
+               msi-map = <0x0000 &its1 0x0000 0x1000>;
                num-lanes = <4>;
                phys = <&pcie30phy>;
                phy-names = "pcie-phy";


The new selftest passes:
#  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
#            OK  pcie_ep_doorbell.DOORBELL_TEST
ok 17 pcie_ep_doorbell.DOORBELL_TEST


Thus:
Tested-by: Niklas Cassel <cassel@kernel.org>

