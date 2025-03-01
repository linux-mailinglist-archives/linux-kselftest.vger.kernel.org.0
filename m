Return-Path: <linux-kselftest+bounces-27974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F948A4AD3C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 19:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1045E1895CBE
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 18:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3B1E572A;
	Sat,  1 Mar 2025 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wpczwOyW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bOD5z77+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC31E49F;
	Sat,  1 Mar 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740852586; cv=none; b=MLsI8lHCsfOeuXNM2xgcmWl8uK7idwCD0KEqxgcn1H/737z8/ABiSeZztGMvg1q2RFQKooOw2vhWUbBEfIupVQud/YiWPjR0bEe37ACNNwgIsHJLq/HbHvoLxIk2tuTiwyL1lWFQzQwftFZBuo5pLQ0y/nmYjJ/Sgy/aGGWy7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740852586; c=relaxed/simple;
	bh=/1KRbZDrax+HBk2kFcZNxdQJ+mrMRQTrz435zMXn/NY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sx8iOO+QjI2/rOWunInFbVLHmiLfLUrpT0TSPippTwL1LSvDRlgDP+fzv687Zu6qlBMw3upFbv2DJ1SUAnbTphi90fYKGrH81ia8OSyaJAgP3QoF6CWooQHGZUyQzjQdfbbe82/Z+UwRF7Bm9bVXUNlStmuWMA7lnFuBvrAHMQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wpczwOyW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bOD5z77+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740852577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aAluflwF8uxqGPtsL2kQpy/Mt+z1OejY+ngR/xlVwA=;
	b=wpczwOyWMsIC5xL2dzr/GEWVo681ybJMAa+f0e7K8fW51ZCfsUYSjDzvjIhWIvq2ud7yW+
	9VbEDuNAYHIvhW7Xe4XhLYvHHR/YuPwqoL2uKsN58NaK3dLwf/3or9U9jMJBD5r7KJj3dL
	WozYGrEoI0Q0QucZF5/RohIu1r5+xRbrpV3Oh8RocPpEVrsn+PjYpQmY4TW98MS0v9NwGs
	cOPceCK9wps63cE0Ah0F2Dw3hGQ+hT4dxWRdeOBj2IF7lE7lvWCEf3CM8GnKCu9C7ifbbB
	ycoHiW6RLyj+I6mnW4e4PsfoxEsh8Xru4haSb334UuKdXhW03TjurxMEgkEChg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740852577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aAluflwF8uxqGPtsL2kQpy/Mt+z1OejY+ngR/xlVwA=;
	b=bOD5z77+FsiaBwISDB+ppOhZwXZLsW93CjTdva9DyZjaS2IgUkbkM357Wb/3WsV+YQlN8Y
	mMHtAgK+F3jkw3Aw==
To: Marc Zyngier <maz@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Anup Patel <apatel@ventanamicro.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich
 <dakr@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Shuah
 Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach
 <l.stach@pengutronix.de>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v15 00/15] PCI: EP: Add RC-to-EP doorbell with platform
 MSI controller
In-Reply-To: <86ldtpot6m.wl-maz@kernel.org>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
 <Z7eKBsxrmthtElpz@lizhi-Precision-Tower-5810>
 <86ldtpot6m.wl-maz@kernel.org>
Date: Sat, 01 Mar 2025 19:09:35 +0100
Message-ID: <87senwd3mo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 01 2025 at 12:02, Marc Zyngier wrote:
> - This IMMUTABLE thing serves no purpose, because you don't randomly
>   plug this end-point block on any MSI controller. They come as part
>   of an SoC.

Yes and no. The problem is that the EP implementation is meant to be a
generic library and while GIC-ITS guarantees immutability of the
address/data pair after setup, there are architectures (x86, loongson,
riscv) where the base MSI controller does not and immutability is only
achieved when interrupt remapping is enabled. The latter can be disabled
at boot-time and then the EP implementation becomes a lottery across
affinity changes.

That was my concern about this library implementation and that's why I
asked for a mechanism to ensure that the underlying irqdomain provides a
immutable address/data pair.

So it does not matter for GIC-ITS, but in the larger picture it matters.

Thanks,

        tglx

