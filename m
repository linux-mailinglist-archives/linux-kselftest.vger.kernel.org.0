Return-Path: <linux-kselftest+bounces-36309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D7AF130B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685823BBE62
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E597266B50;
	Wed,  2 Jul 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bleWrWMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB5266577;
	Wed,  2 Jul 2025 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454069; cv=none; b=PJNtdlHs51ViTzoqTxjs1n9ercJgWh4mB0kWozI3JZ7h6tJuWdqumQeXRcsLw+aOxp57GD1NBm3//A4/N6w31r/h2uE3hAi5WIK5loP0V8Gg/bpwqxzCUfeakpp+ZITJVBM7iZ0nnUAYh8bUd7eia7e+XWdxJouth19SQRIijSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454069; c=relaxed/simple;
	bh=RFTsJI5sebVc6rQB1mNjRTzyqHDuoXH7hmxEz6lfgXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuGMf6St4L4bgwWRltcFF9KnkfeLdq3/Q4QzYn/jP3Zeh/fHq8A6FYElRh8gt6jK9seDUvxDtDsHqXdo1shLa6lk3tuxt18PLxcnQSavkWuyQzENuXKr4O4Voq9QKe+vsgYg6IkUbyvxQHPXUT0JjFJPvPBjEekCEaWyrf7xXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bleWrWMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A8DC4CEF2;
	Wed,  2 Jul 2025 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751454068;
	bh=RFTsJI5sebVc6rQB1mNjRTzyqHDuoXH7hmxEz6lfgXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bleWrWMzJUWkSA4hfhDbCHs3ljC7N8MVMNJn+qU8ltD4F4Wpp2E5i9GV2eJuqXXQf
	 o9XFhIx7lMVcxXWs6nXbPw/E1TysnvVB8PDw++JXHCkVYaHfh+wQddfkJklxomBiZH
	 hnEMzXIyRvcZanBEQa48sgVoVK5KbCHZBfKCdEuuDT+rVhadi9UICoZ/n7HUSDCOwE
	 9T2pVqNtRqh0XvAgXASjtARXZyQqiV5SO40R1yvfqsbQmI2Xxstz0AFylc3I4SbkLM
	 sc7GrtovYQ6IetTadN0jVGlORfoBXlv6qd8nkkeW86JpWdBPhWEdcIoa2OWSX999L8
	 a2otSMg4EnZXw==
Date: Wed, 2 Jul 2025 16:30:48 +0530
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
Subject: Re: [PATCH v19 01/10] PCI: endpoint: Set ID and of_node for function
 driver
Message-ID: <ne5yrjtdevmndqds4uwo2ppq6gay2wuwjouyf33lqr5g3nfkwr@lkwqlwqjqbmx>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-1-77362eaa48fa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-ep-msi-v19-1-77362eaa48fa@nxp.com>

On Mon, Jun 09, 2025 at 12:34:13PM GMT, Frank Li wrote:
> Set device ID as 'vfunc_no << 3 | func_no' and use
> 'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
> device.
> 
> Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
> settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
> functions use the EPC's device node, but they should use the EPF one.
> For multiple function drivers, IOMMU/MSI should be different for each
> function driver.
> 

We don't define OF node for any function, so device_set_of_node_from_dev() also
ends up reusing the EPC node. So how can you make use of it in multi EPF setup?
I don't understand.

> If multiple function devices share the same EPC device, there will be
> no isolation between them. Setting the ID and 'of_node' prepares for
> proper support.
> 

I don't know who you can provide *isolation* by reusing the EPC OF node. It is
same as using the EPC node directly.

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v14 to v16
> - none
> 
> change from v13 to v14
> new patch
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 4 ++++
>  include/linux/pci-epf.h             | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 577a9e490115c..95fb3d7c1d45e 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -120,12 +120,16 @@ int pci_epf_bind(struct pci_epf *epf)
>  		epf_vf->sec_epc_func_no = epf->sec_epc_func_no;
>  		epf_vf->epc = epf->epc;
>  		epf_vf->sec_epc = epf->sec_epc;
> +		epf_vf->dev.id = PCI_EPF_DEVID(epf->func_no, vfunc_no);
> +		device_set_of_node_from_dev(&epf_vf->dev, epc->dev.parent);
>  		ret = epf_vf->driver->ops->bind(epf_vf);
>  		if (ret)
>  			goto ret;
>  		epf_vf->is_bound = true;
>  	}
>  
> +	epf->dev.id = PCI_EPF_DEVID(epf->func_no, 0);
> +	device_set_of_node_from_dev(&epf->dev, epc->dev.parent);
>  	ret = epf->driver->ops->bind(epf);
>  	if (ret)
>  		goto ret;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 749cee0bcf2cc..c0864935c6864 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -216,6 +216,8 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
>  	return dev_get_drvdata(&epf->dev);
>  }
>  
> +#define PCI_EPF_DEVID(func_no, vfunc_no) ((vfunc_no) << 3 | (func_no))
> +
>  struct pci_epf *pci_epf_create(const char *name);
>  void pci_epf_destroy(struct pci_epf *epf);
>  int __pci_epf_register_driver(struct pci_epf_driver *driver,
> 
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

