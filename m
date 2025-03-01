Return-Path: <linux-kselftest+bounces-27965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C0A4AADA
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 13:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BF01729CA
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 12:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8351DE2BD;
	Sat,  1 Mar 2025 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpMHOMcT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BCC2E630;
	Sat,  1 Mar 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740830538; cv=none; b=k96zrUo1AOMgBn4HPjFpcDI5FF41LWyF5iIhTjmAXxL6MCFWcuGD8p5xv2hlTWbiNNDeE0TqrxRltH0rwaw0QSWap/NzEoSVd+zZKlCi4myUylnh9+R6lVcfEOxHeN0xYvdIFbscXGz+6/fEm9DrotQto3O8xT4aiBRq9kN2UQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740830538; c=relaxed/simple;
	bh=+AAMJB/7hTU30KZCU4oBLcGkEpeVOQ4Sdqlumm+i4rs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkK8rmIRzxR4BSVtx3e98G5gHFbQLvkKaecArYG6uxHK87utM/VFCfdb6EpR41QBSN3iseUhwYQZMCu6wp2wpSYAmLt+G4dwTdWyxF6os+5LSA2XA0/DEoiwrFCv6xdM2teEur9ZnNBzt3Syv5ybIRECH6jiQokrArkiAIMFfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpMHOMcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998A0C4CEDD;
	Sat,  1 Mar 2025 12:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740830533;
	bh=+AAMJB/7hTU30KZCU4oBLcGkEpeVOQ4Sdqlumm+i4rs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mpMHOMcTcDaKO8h/RY95ri0hmyp0V2BRYqCtoAoZhlW308RiMhWVVrWPqvb2zxTY2
	 NkRJUqvIAazSb/Wad3cMHGvQ/z6YBnZ9ruhVp2GLiaKLa5Gu/8sUz+cft6Tg13pNs4
	 50dWvVx31LiV3qaxNDKXDEjX+nETxREDjJJ6QZzVcMeqTn1DzDLI07fcwABz+MSoLM
	 vH1DaL5LsobXo1P+EEs9TymdimdYFFIs0ZMv8Om58JpIQnW5+cC9L9kA7TQw1+fHwG
	 buxM27vmpfCwvGxjeLUyHQcvyo8H+YiOQpv6UzBPANnkYfD7yRs6+eUwIrJLOirD4b
	 aEdabd4Sen7hQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1toLXn-009LnL-Bp;
	Sat, 01 Mar 2025 12:02:11 +0000
Date: Sat, 01 Mar 2025 12:02:09 +0000
Message-ID: <86ldtpot6m.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Frank Li <Frank.li@nxp.com>
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
Subject: Re: [PATCH v15 00/15] PCI: EP: Add RC-to-EP doorbell with platform MSI controller
In-Reply-To: <Z7eKBsxrmthtElpz@lizhi-Precision-Tower-5810>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
	<Z7eKBsxrmthtElpz@lizhi-Precision-Tower-5810>
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
X-SA-Exim-Rcpt-To: Frank.li@nxp.com, kishon@kernel.org, rafael@kernel.org, tglx@linutronix.de, apatel@ventanamicro.com, gregkh@linuxfoundation.org, dakr@kernel.org, manivannan.sadhasivam@linaro.org, kw@linux.com, bhelgaas@google.com, arnd@arndb.de, shuah@kernel.org, hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org, dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Thu, 20 Feb 2025 20:01:10 +0000,
Frank Li <Frank.li@nxp.com> wrote:
> 
> On Tue, Feb 11, 2025 at 02:21:53PM -0500, Frank Li wrote:
> 
> Thomas Gleixner and Marc Zyngier:
> 
> 	Do you have any comments about irq/msi part?

It certainly looks better and less invasive than the previous
incarnations. Things to fix:

- Documentation: the msi-map property usage is undefined outside of a
  PCIe RC, and the way you describe its use is so vague I read
  anything in it. Please update
  Documentation/devicetree/bindings/pci/pci-msi.txt to reflect the new
  use case.

- This IMMUTABLE thing serves no purpose, because you don't randomly
  plug this end-point block on any MSI controller. They come as part
  of an SoC.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

