Return-Path: <linux-kselftest+bounces-36315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CBBAF13DF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7581217CD21
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072802580E4;
	Wed,  2 Jul 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edqp5nXG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD549221F37;
	Wed,  2 Jul 2025 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455841; cv=none; b=HuR18CpupyOkheR9WiJeESJqXUBcBdQjMxSfxBkp3Do1uY6xqHmzwl0H6+RLzVkSbdf7BdpOdUhpcB3KjKra29syuF+wmiccWvgSaTJrhQ/CuA6ZJKaKz/7/geetO9OQwaMBp6neK52lJ+lqVID1BkkGDTMlebATmxLGvzlocWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455841; c=relaxed/simple;
	bh=jS6HsOJudSh3pJt2UZUlf0WLtRDJKg8n2+rVm/g7mQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM5SlAOg2vv8b5ALyfR2uiEtveD6UkNxztUf4Ikcxg526gn1iW0MIWDuKPqpAGuUaIDd7rV2XTEWfAByDlhaYDaxAU6ztobXJdjyIvJab2vMRHgjsugYOauZ5fy0JV0u3QkizWaNYD3S4KYltVwTh0v0+Kdv+i/aaMF6jkR7KPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edqp5nXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658DAC4CEED;
	Wed,  2 Jul 2025 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751455841;
	bh=jS6HsOJudSh3pJt2UZUlf0WLtRDJKg8n2+rVm/g7mQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edqp5nXGm3PK7QHRdw05jl6Dn/i98BFF9vLc5Nd2+sm0ltDQzNlDH6290VOTuy1dE
	 7bWOZnjX7twJklwOY3t4+bsKt66v+Csx2Wod+W3w2WzZlYKUHIWkPFfvz3CUy7VtW8
	 uEnMQSSOBAA/Jh262IihH+jk098VNyleLL/TaAr766MQFATIXVWZKFclJc6tMer8/8
	 fvAFflUU/2b3tWzZ47xsAG/dXBgRk+MeurjCsIaompbAzZVmjooJn4OQDJkIa0nk0o
	 F3Mx6RQ0NGbZajeuFwitVmu/bfkWtkkeRQSWj7H/9PKvKxblCRBLj0s7ltbyKE9EZ/
	 6vEa4TE6c+uDg==
Date: Wed, 2 Jul 2025 17:00:23 +0530
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
Subject: Re: [PATCH v19 03/10] PCI: endpoint: pci-ep-msi: Add MSI
 address/data pair mutable check
Message-ID: <5axgxbtyqbwwncimjiiedvkm3ap7at553vgj72bht4kynke5cd@xfghwfmp6cy7>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-3-77362eaa48fa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-ep-msi-v19-3-77362eaa48fa@nxp.com>

On Mon, Jun 09, 2025 at 12:34:15PM GMT, Frank Li wrote:
> Some MSI controller change address/data pair when irq_set_affinity().
> Current PCI endpoint can't support this type MSI controller. Call
> irq_domain_is_msi_immutable() check if address/data pair immutable.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v18
> - update commit message. remove 'include/linux/msi.h' part.
> 
> change from v14 to v17
> - none
> 
> change from  v13 to v14
> - bring v10 back
> 
> Change from v9 to v10
> - new patch
> ---
>  drivers/pci/endpoint/pci-ep-msi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> index 549b55b864d0e..c0e2d806ee658 100644
> --- a/drivers/pci/endpoint/pci-ep-msi.c
> +++ b/drivers/pci/endpoint/pci-ep-msi.c
> @@ -44,6 +44,14 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
>  
>  	dev_set_msi_domain(dev, dom);
>  
> +	if (!irq_domain_is_msi_parent(dom))
> +		return -EINVAL;

This check is not justified in commit message.

> +
> +	if (!irq_domain_is_msi_immutable(dom)) {
> +		dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
> +		return -EINVAL;

GICv3 ITS is an immutable MSI controller. From the earlier patches, I could see
that you have tested this series with ITS. How did that happen if it errors out
here?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

