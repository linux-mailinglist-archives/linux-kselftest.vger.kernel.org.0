Return-Path: <linux-kselftest+bounces-32583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5F1AAE3C5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 17:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5B31C01E46
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B228A1E5;
	Wed,  7 May 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bLRmj+zU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VL09x8MT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6D433D9;
	Wed,  7 May 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630205; cv=none; b=C2FtHtTFRjLonM/HaMB85zQNgdIPGPTNVitHc0eAM3UnxK07DiUsJegMlXELX2DW1TPMgIiRYdBv4kjv/T3qlJI4P3VEwJE+V00ysPQpasITtAoQ6VEuQS2+KTBGuCpCiXbzbn6Bl7vyGPrYe62M+uqtM1KgCKm6ODwYB3RzygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630205; c=relaxed/simple;
	bh=BxVNvXmX3G7YqiFJjCXO2/8wx0H+3R188qUBHuj112U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AyvgPe+4Y25fCHYcNw2perFnDaxzQW94tPWAAge1H3EiyJ4N6kTTobVXazcIR4fI9Pqyvb/PJmWUlAWwcHyRrhUc5l4PSqDTc0Eo50t62clX6+1V1bTqyoyxIoRpoVlSBYefPuxyAmX/ESwwD7e26w1QcIKlKRTaHNkPIXd2FtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bLRmj+zU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VL09x8MT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746630201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxVNvXmX3G7YqiFJjCXO2/8wx0H+3R188qUBHuj112U=;
	b=bLRmj+zUZntLyvQFMmKu0xbGmpTv8TCeHzGUjOiqfU3GRjgMHMwROeus+qjM6exXcSf9tA
	odzG/WvwRfHj3mP/2S1UrxTNr6VXnxilsxIrGhcVyXqV2ZQp9ekT95592eZCBquktC+zTw
	KAi3JKfng/myFWcbLCd8JTlV0Yyqz51aegALDoGQoFdoAMXu0N76yVdUsoczP7oRSlP5Kx
	fMKE1DCVcdAQ0ikDmk3JVMfelrFARUnTgybwj9XMZDLB69io6LLTN6vlCTx5Ok30bl1YQi
	Zrg0I+S8jbdJFqUxKNCFH+Wge89qiYqg4oRUBXroorLa5xD/ccgpRSoWQd5+5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746630201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxVNvXmX3G7YqiFJjCXO2/8wx0H+3R188qUBHuj112U=;
	b=VL09x8MT8p3aOzBp9Ybavyc/IFho5MstQvQR/Lq6igZtH/K5HdZHOKFW9+mIyFQ3PVMlEv
	VIMnwVcLpyyIDGBw==
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
Subject: Re: [PATCH v18 08/15] PCI: endpoint: pci-ep-msi: Add MSI
 address/data pair mutable check
In-Reply-To: <20250414-ep-msi-v18-8-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
 <20250414-ep-msi-v18-8-f69b49917464@nxp.com>
Date: Wed, 07 May 2025 17:03:21 +0200
Message-ID: <871pt0mpja.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 14 2025 at 14:31, Frank Li wrote:
> Some MSI controller change address/data pair when irq_set_affinity().
> Current PCI endpoint can't support this type MSI controller. So add flag
> MSI_FLAG_MUTABLE in include/linux/msi.h and check it when allocate
> doorbell.

This changelog has no relation to the patch.

