Return-Path: <linux-kselftest+bounces-27959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8F6A4AA90
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 12:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCBC16C56D
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F2C1DDA31;
	Sat,  1 Mar 2025 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqcJd/cY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FD1A5B97;
	Sat,  1 Mar 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740827441; cv=none; b=nJ0DAY7Z/b6WE/q8k7mPvc9MWPy/HMJ8M7dfF8/qJrVk61Q5hTQG9F5/fa7eZaho9HY8Cm17MJyKnu5jOnOTGuISuPbTVrYYikPplufwJsw80eEwOt8TJrLIseVUw3984xTEsdK+Tu1FvWRVcDXF2SWcjNnSyfRVom9+/T0/qkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740827441; c=relaxed/simple;
	bh=nNqG0GMewRObnyRAAVI9p6JFUYawaXI8WiP+ukd2A5o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwQutLlUhC5d/bIRepbzwDQYS+4msRVN867eRnRlViBd+OY9aQPmzqR2VSzWatfPnFC12zbhhl6UbREKZWEGndqOcV03jvtHFuLvMDJF8GA9ucjEUq2sNZPsshLXe2qHZ61++XYt3xKWpF6aaXADog1LOtlJ90K82fwhGvj4qL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqcJd/cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E79C4CEDD;
	Sat,  1 Mar 2025 11:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740827439;
	bh=nNqG0GMewRObnyRAAVI9p6JFUYawaXI8WiP+ukd2A5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RqcJd/cYGKltRT9h6KNka1heUSDbeIOA2o7SOUY8yXx1mXGc/buNEIQrzp8usT0R5
	 oIIAoVNh0/DFsFRbxtgmVt5jIleViLUgMrXRnxLJeOPdu0Fhv6ZiVvg6T7/6vJBl6D
	 QxEbxiEZeQC53aFcFH2ROVff6XP2uhKcZDO8GUBU/ndaT3+ZdKFvuOGWcf/+NkyIIM
	 yOr4n7pLdKhjqdyyCBiHm4Pwpm650y90r0D/I6bYgRHAWjMSE7fV7tOKEP39Rb2RnM
	 WyhQnNBNMTsQdpIlcwxbUoMhjZzG440kCGXu7d/ZX6w82326HJnqQ9NbHvq+EG7t9k
	 ZI7SN1pmRobeA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1toKjt-009LKs-1e;
	Sat, 01 Mar 2025 11:10:37 +0000
Date: Sat, 01 Mar 2025 11:10:35 +0000
Message-ID: <86plj1ovkk.wl-maz@kernel.org>
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
Subject: Re: [PATCH v15 02/15] irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()
In-Reply-To: <20250211-ep-msi-v15-2-bcacc1f2b1a9@nxp.com>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
	<20250211-ep-msi-v15-2-bcacc1f2b1a9@nxp.com>
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

On Tue, 11 Feb 2025 19:21:55 +0000,
Frank Li <Frank.Li@nxp.com> wrote:
> 
> Add the flag IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and the API function
> irq_domain_is_msi_immutable() to check if the MSI controller retains an
> immutable address/data pair during irq_set_affinity().
> 
> Ensure compatibility with MSI users like PCIe Endpoint Doorbell, which
> require the address/data pair to remain unchanged after setup. Use this
> function to verify if the MSI controller is immutable.

Why is that a requirement? Why should a driver even care?

	M.

-- 
Without deviation from the norm, progress is not possible.

