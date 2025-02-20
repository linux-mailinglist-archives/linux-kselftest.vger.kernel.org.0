Return-Path: <linux-kselftest+bounces-27111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC7A3E605
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 21:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A134172C9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C344E214210;
	Thu, 20 Feb 2025 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jz7UUagN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JaGBK3GN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3F1E9B32;
	Thu, 20 Feb 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084181; cv=none; b=lYE55R/n0KAQF/tA3+SRNDF9RaeGNoSUamqb2jgnUF24SUImh0gRIkXPwjL31yYKp/Vja4YRWmvPUPvhlSPcURK05yER+5dgVegziSbXH3tkZZEJB2mJ28lZl9DsVeQZJyKVklALjZIAoDuR61D+rNvVtQwK68TD5sQwTCE7WkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084181; c=relaxed/simple;
	bh=yyB4raD5FkLDm+6eE9B6NLj9Ve2fAT7IBWp7UlnhxWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FYryC6U4ibQaa/dssCh4xlLpiD4O+0PNJ6UlI21EMjmRRtH8rZN/BNyhOsl8nOfvc9b1EEXlk3d4thRHWw9M43lT5s6L+ARsNG5Q2mMXZ5CtKvhyRVbFTCTpyeBg4NFhBKN6N1+p727HaFKCp8e0zCwh3FT3EJhsxJoSpFfAlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jz7UUagN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JaGBK3GN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740084178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RtHWekfr9PAPqze2jQ7chZG40e+mSXvS0nobf0sErKA=;
	b=Jz7UUagNJTKbH56LgA1I1S2wceAMMcMLhEFTOQqAXc8zhpwat3W7Md4/GbVOSEl7Ja7f6t
	BV49/BFemaZOqEOVn4yRHDyY/W9L1s4vwD20lQDSJmg7pHswUgvc2diuh1ACjW3B3wCCiR
	nb9UU/+ChkaiD0TV7bOceMRn225UlaZst7NAec1BQ85bQBDgRNL+8nc8nkzBgAd2s0Ldh/
	vM/2IuIdN5fmR1Y2kPmAfRRmoQlQGfb7sMGtdDLelpP4Yq5ze2z5X585jfLSk03FJ82HKI
	RNpnzH9P6BEFX1OQE6VgcsfUgcxIC9y+u6chBR8e8pplO9v8gn2uX6V3HXw1dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740084178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RtHWekfr9PAPqze2jQ7chZG40e+mSXvS0nobf0sErKA=;
	b=JaGBK3GNvF9d/Xprp9sb0i3FtrYJ+tMeGHw68qv5QxzNEaV92P6GDoaIuTka6bxo7IX8wm
	7Kwx8ZWXVTO9O3CQ==
To: Frank Li <Frank.li@nxp.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Anup Patel
 <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich
 <dakr@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Shuah
 Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach
 <l.stach@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob
 Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v15 00/15] PCI: EP: Add RC-to-EP doorbell with platform
 MSI controller
In-Reply-To: <Z7eKBsxrmthtElpz@lizhi-Precision-Tower-5810>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
 <Z7eKBsxrmthtElpz@lizhi-Precision-Tower-5810>
Date: Thu, 20 Feb 2025 21:42:57 +0100
Message-ID: <87r03sgxf2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 20 2025 at 15:01, Frank Li wrote:
> On Tue, Feb 11, 2025 at 02:21:53PM -0500, Frank Li wrote:
>
> Thomas Gleixner and Marc Zyngier:
>
> 	Do you have any comments about irq/msi part?

I'm not having objections, but this needs to be acked by Marc as he had
pretty strong opinions on the overall approach.

Thanks,

        tglx

