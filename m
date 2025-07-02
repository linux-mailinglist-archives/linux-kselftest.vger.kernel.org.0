Return-Path: <linux-kselftest+bounces-36317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1533EAF15B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 14:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279A21C21EB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9825F79A;
	Wed,  2 Jul 2025 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQIOuCNM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44E1E487;
	Wed,  2 Jul 2025 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459497; cv=none; b=HzC1YWoVKuQX58Ek303/twf6hS3wWguYKR6lndw/vtdGQjqQONMK5qXfSeEP2wbfD9Lcu1RdMauulx4Ps/6zzAe+1PQ2kh9dpU5iqD5PxsjL6OQNeg601zB5St11+VNGNJ2SqegvageS9Uhp/0szEUACEqoWcy2R/ctics6Sl1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459497; c=relaxed/simple;
	bh=HyLomZoUIsBZI28vt4NzRZMuAo9iSJ1mkcus3zmJ/uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EggvUCg+KTQmLANeH4Px+lj+sbk9GMj2UzgZ5CYgxi77/lA4d9I/07rjKzSl+u0zAYmjIMZNFodJXC0esL5XmVNht+uyASLehNnFbIWeFMmIGuOg/aYgUgR/IojQ96WXABQYNO7xS8GmBH8NunfaO5k2n+jmK07CIp3KUYDaisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQIOuCNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0877C4CEED;
	Wed,  2 Jul 2025 12:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751459497;
	bh=HyLomZoUIsBZI28vt4NzRZMuAo9iSJ1mkcus3zmJ/uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQIOuCNMICguAzeBgxu+HHL77MCyaObg/26HSEUCrXWPkUd23kVGSO+krBqrgQDjE
	 mqpEtRaeIZTNVpMnC7ZSpNLLvoKTfdwSnMAVI6e+ddliSNa4hjOxsmEmAimZUFx9Lt
	 XjHN+M2S7/rCFQ+9QG1fl2Akq4wqY2suSIJr9x3bxPv3Ge3YAhOIvKQpq+YvdJ8Alr
	 5FGix2e4Cql3/KPuymrOlR3aEWS3ik5beTXLqXMe1PPIjuw+DmAbw+2FLOWnRdAHhd
	 Pr6Dw818Pd5W32CmctWaoz/Q8YfP+nMAAw9KII2KckiGPrFrt1HPC9IXKuGhBg7o4+
	 RUy6Keg7shOYA==
Date: Wed, 2 Jul 2025 18:01:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v19 04/10] PCI: endpoint: Add
 pci_epf_align_inbound_addr() helper for address alignment
Message-ID: <n6wdkexskwjd7k5zwaaqeb36zdsxzcshsm7f5czv44rmocswex@pzbpehep2teu>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-4-77362eaa48fa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-ep-msi-v19-4-77362eaa48fa@nxp.com>

On Mon, Jun 09, 2025 at 12:34:16PM GMT, Frank Li wrote:
> Introduce the helper function pci_epf_align_inbound_addr() to adjust
> addresses according to PCI BAR alignment requirements, converting addresses
> into base and offset values.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v15 to v16
> - none
> 
> Change from v14 to v15
> - change out address type to dma_addr_t to fix below build issue
> 
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202502082311.G1hWGggF-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/endpoint/functions/pci-epf-test.c: In function 'pci_epf_test_enable_doorbell':
> >> drivers/pci/endpoint/functions/pci-epf-test.c:726:42: error: passing argument 4 of 'pci_epf_align_inbound_addr' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      726 |                                          &epf_test->db_bar.phys_addr, &offset);
>          |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                                          |
>          |                                          dma_addr_t * {aka unsigned int *}
>    In file included from include/linux/pci-epc.h:12,
> 
> Change form v9 to v14
> - none
> 
> change from v8 to v9
> - pci_epf_align_inbound_addr(), base and off must be not NULL
> - rm pci_epf_align_inbound_addr_lo_hi()
> 
> change from v7 to v8
> - change name to pci_epf_align_inbound_addr()
> - update comment said only need for memory, which not allocated by
> pci_epf_alloc_space().
> 
> change from v6 to v7
> - new patch
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-epf.h             |  3 +++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 95fb3d7c1d45e..33e14a6b1549a 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -481,6 +481,50 @@ struct pci_epf *pci_epf_create(const char *name)
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_create);
>  
> +/**
> + * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
> + *			  alignment requirement

'Align the given address based on the BAR alignment requirement'

> + * @epf: the EPF device
> + * @addr: the address of the memory

'inbound address to be aligned'

> + * @bar: the BAR number corresponding to map addr

s/map addr/the given addr

> + * @base: return base address, which match BAR's alignment requirement.

'base address matching the @bar alignment requirement'

> + * @off: return offset.

'offset to be added to the @base address'

> + *
> + * Helper function to convert input 'addr' to base and offset, which match

s/convert/align

> + * BAR's alignment requirement.
> + *
> + * The pci_epf_alloc_space() function already accounts for alignment. This is
> + * primarily intended for use with other memory regions not allocated by
> + * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
> + * address for a platform MSI controller.
> + */
> +int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
> +			       u64 addr, dma_addr_t *base, size_t *off)
> +{
> +	const struct pci_epc_features *epc_features;
> +	u64 align;
> +
> +	if (!base || !off)
> +		return -EINVAL;
> +
> +	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
> +	if (!epc_features) {
> +		dev_err(&epf->dev, "epc_features not implemented\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	align = epc_features->align;
> +	align = align ? align : 128;

From where this 128 byte alignment comes from?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

