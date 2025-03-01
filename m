Return-Path: <linux-kselftest+bounces-27964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC62A4AACC
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 12:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008D61899435
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2E1DE885;
	Sat,  1 Mar 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUgeLJyJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624C1DE2D8;
	Sat,  1 Mar 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829494; cv=none; b=GftTOswTJQyiNa4qTdgQ1M+5KbXL8EUVwNWHE7htdk2D1sqAwACXsFgG5H5aIpUxUljoBDQYADGzDNK5UWit+DqyeGsVy3OnZf3uRMOVyEuNtByYFDPuu1HdkcC5o3BKi4miNvHzUimq0GxUOHqbYFRlvUNvU983DtDZBGRdo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829494; c=relaxed/simple;
	bh=bDBsRUkAcZO02Q5u156/Y9EgZnHcH5+wGnYr5yxlUMU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ob6TnopTmYY1f57to+M24uDNEhVXDuWLR7lxu2xJoYbjbeeUOpVwMpL5ojzeChxX9JeSj664j2szkL3x0M/EFnQqDP8Dq71KkTqDuv+7pSHeS9enhhFtUyCz3HrluvxF0kCCb4jib6Ibe/K4Y35nDmH9txYrMpaNEqhJF8IwjpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUgeLJyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54273C4CEDD;
	Sat,  1 Mar 2025 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740829493;
	bh=bDBsRUkAcZO02Q5u156/Y9EgZnHcH5+wGnYr5yxlUMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NUgeLJyJUL439NXL4ufMy1ioW0tAbo0T0VAbBijQxH6qFMe9Hdycj0x5Do5Ihra/a
	 lVW/ZgjOZqFjB8vJOtr4FEvujsIkMMFhWrvIcXfOwBbW1zIZv6xFTdkIttZCvTbIcz
	 tvFWeLbGRt9RoW8heZ8vsJ34B7M9ZztwVn7oRocCmXI6GSWCceEMcw35C/CrugcwUf
	 IksoF9wjBBHOLPsoZCruczrLaXunZSM0y2/RAQqw2VzimDskW5i1VPeLnWmw2bs3MZ
	 t0FuTYVTxewXwlB3B55tnd6tiM4Y3PsbqpUQsY5+bcnlPhQrhxEy2Ca/Ot+R9iNJmP
	 G0h+OXk3yk64Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1toLH1-009Leu-3R;
	Sat, 01 Mar 2025 11:44:51 +0000
Date: Sat, 01 Mar 2025 11:44:50 +0000
Message-ID: <86mse5otzh.wl-maz@kernel.org>
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
Subject: Re: [PATCH v15 07/15] PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
In-Reply-To: <20250211-ep-msi-v15-7-bcacc1f2b1a9@nxp.com>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
	<20250211-ep-msi-v15-7-bcacc1f2b1a9@nxp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: Frank.Li@nxp.com, kishon@kernel.org, rafael@kernel.org, tglx@linutronix.de, apatel@ventanamicro.com, gregkh@linuxfoundation.org, dakr@kernel.org, manivannan.sadhasivam@linaro.org, kw@linux.com, bhelgaas@google.com, arnd@arndb.de, shuah@kernel.org, hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org, dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 11 Feb 2025 19:22:00 +0000,
Frank Li <Frank.Li@nxp.com> wrote:
> 
> Some MSI controller change address/data pair when irq_set_affinity().
> Current PCI endpoint can't support this type MSI controller. So add flag
> MSI_FLAG_MUTABLE in include/linux/msi.h and check it when allocate
> doorbell.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v14 to v15
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
> +
> +	if (!irq_domain_is_msi_immutable(dom)) {
> +		dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
> +		return -EINVAL;
> +	}
> +
>  	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
>  	if (!msg)
>  		return -ENOMEM;
> 

I really don't think this brings much to the table. These systems are
not built by picking up random bits that can be put together by hand.
They are integrated in an SoC, and I can't imagine that the MSI
controller is picked randomly.

So my conclusion is that this is either *designed* to work, or it
doesn't exist, and that this code is just dead code.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

