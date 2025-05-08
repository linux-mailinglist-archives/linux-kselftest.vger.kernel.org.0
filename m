Return-Path: <linux-kselftest+bounces-32666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9D1AB0165
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 19:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EAE4E86E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A4286D7D;
	Thu,  8 May 2025 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IsQL30ON";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H9CLw99f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D283286D59;
	Thu,  8 May 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725197; cv=none; b=hCCXaN8huHZe7j1jzlexVtMZozqHlzrOGExp5vyvnzqDXZnh6cDhbp1trrDmGZ2Lsu+UrmTMr09gGn97fmrAtDD5RMuMbkqKYDBsK9RODmIQE1MncE689z+iIangmwRlBqJsJYQCtF00aryxYcker/EADfEXCo24cVgg5Sse6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725197; c=relaxed/simple;
	bh=/lMonJP9624v17JznT8vU6RUH3y++91soly0vGOyNrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HP0s/MENMN2oM+NOeoPNwwWoCDeEnRLCrX3gNwZeWxvJnaUa8ZUIEmd6BdWHns1o/pEgjWqowrAjt2tbKBs/V4LWvQd4e9igMIHkycj5JNqJ+XZXP9XZ0gNPSJ7NFdw9/cxKeTL7X26HiE0F+hLF1Fj3ESbzuvXVvh8qMugLT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IsQL30ON; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H9CLw99f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746725192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hTbyL4rDqJd0LCAW+KvoiiMK8wPz1NsF8UcJJ8cPhiw=;
	b=IsQL30ONrI4jH8NVOxem46kLDCMzP/Nm59W11WHMUP8KJlzwrFVIEHrxLI3VEWTLPUeH8Y
	7XOJpnHiBRo/pb4bhe2U4Mpp+M+mJODfTGP9oz9U0HzUgvvphMZt3MK0I33CvXIDScyri/
	ElClzkI1fJpAvrE3LiRiB/hmMDZM2pdMTfhEOmcNJRV3MKiEu06cyWI8dUvMiUVdnePZra
	BRfX9LIVEdizlZoEkFEIb0JIz2bbCy/2UAB1ibYG8keWY3Dp5dIjuVv0w6Jm3T0SF3PJ+M
	lo/W7BklVcGLQjCFreaswevbzJgusPpmB2aTsBXhKZd2kGQNc9dkLdEiN7/0Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746725192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hTbyL4rDqJd0LCAW+KvoiiMK8wPz1NsF8UcJJ8cPhiw=;
	b=H9CLw99fBJ7LF0HxwGGI1SpmPdzd7KGDyNshq8EBwNjUWLVEH9JYnBjbnl2w0aefJsI9yq
	Of9gn2t7UEx8NSCA==
To: Frank Li <Frank.Li@nxp.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Anup Patel
 <apatel@ventanamicro.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan
 <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach
 <l.stach@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob
 Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org, Frank Li
 <Frank.Li@nxp.com>
Subject: Re: [PATCH v18 00/15] PCI: EP: Add RC-to-EP doorbell with platform
 MSI controller
In-Reply-To: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
Date: Thu, 08 May 2025 19:26:31 +0200
Message-ID: <87y0v7ko8o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 14 2025 at 14:30, Frank Li wrote:
> This patches add new API to pci-epf-core, so any EP driver can use it.
>       platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
>       irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()
>       irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
>       dt-bindings: PCI: pci-ep: Add support for iommu-map and msi-map
>       irqchip/gic-v3-its: Add support for device tree msi-map and msi-mask

I applied the interrupt related changes in the tip tree. They are on a
seperate rc1 based branch and contain no other changes so that they can
be pulled into the PCI tree as prerequisite for the actual endpoint
changes. This can be pulled from the following tag:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-platform-msi-05-08-25

Thanks,

        tglx

