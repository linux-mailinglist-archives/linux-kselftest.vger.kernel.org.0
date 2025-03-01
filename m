Return-Path: <linux-kselftest+bounces-27966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF0DA4AAE4
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 13:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E058D1896612
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7B1DEFD9;
	Sat,  1 Mar 2025 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhPy5+fO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19DF1D5AB6;
	Sat,  1 Mar 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740831472; cv=none; b=Qka4uR4zs19JsvggL7Q9J/hwKU6ARAdO9cMwPbdBhQWFRWl3KRiSV4s/2putT8acmLzMoMx9u8rmojSb/dv4Hiaq14DytLuaDkBtkK63OX78G1M2Qn/WqIR7vP4OjJQLnmECidtV+lheqVcc1xpDr4YzX++F0LMoocnLsasLrKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740831472; c=relaxed/simple;
	bh=A8PdxtCizk6PgunyHAGQsWVRlwM9EY3+12Tc6z3znSM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggn1lM/jdaS9lNuDoirpGjWhtzSpVaufRfb/sPUPDhLFgkXvtFy3AvdyXfjsC2GSEnKmb1wueCE2DxEn5uOvI2hQHozLELVOgCB2O4DI+jQN4/zhDsjaEse7cTru5kiKz2+8BYG7AjMVBlOSBgRL0H89xrVG99G8RxxnLinuI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhPy5+fO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D36C4CEDD;
	Sat,  1 Mar 2025 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740831471;
	bh=A8PdxtCizk6PgunyHAGQsWVRlwM9EY3+12Tc6z3znSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhPy5+fOugQVe9poY7fQwjki9+P9S5nAFF7/0COxLPJun7AgwHNF1TsOHcKCUswYj
	 UKVBh311X/Qk27ZtNHK3Tehk193k3QgTaCn5jQ3M2X6JXObmTolINnm2sYP/28HImG
	 +oX+sz5e+NfyVqK0jK8c2+4f5uPYOx9Hxn6uVdx7NyV2eSQirUq8oOgrPLE8rL/vwS
	 /O+CaBOIXSBZA05VOfTXyj9iNLyad0/43WHOcEBCWq4PGn/nCLeYnV7yoAz54teeWE
	 /RUxG/sphEsuVn3x0lOlKMXtIZVJ0h3FR1Un1qjr0MrofAosyShEgeeQVTRkFG0SGi
	 VphvI9rWcvJbw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1toLmu-009Ltj-1q;
	Sat, 01 Mar 2025 12:17:48 +0000
Date: Sat, 01 Mar 2025 12:17:47 +0000
Message-ID: <86jz99osgk.wl-maz@kernel.org>
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
Subject: Re: [PATCH v15 01/15] platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
In-Reply-To: <20250211-ep-msi-v15-1-bcacc1f2b1a9@nxp.com>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
	<20250211-ep-msi-v15-1-bcacc1f2b1a9@nxp.com>
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

On Tue, 11 Feb 2025 19:21:54 +0000,
Frank Li <Frank.Li@nxp.com> wrote:
> 
> The follow steps trigger kernel dump warning and
> platform_device_msi_init_and_alloc_irqs() return false.
> 
> 1: platform_device_msi_init_and_alloc_irqs();
> 2: platform_device_msi_free_irqs_all();
> 3: platform_device_msi_init_and_alloc_irqs();
> 
> [   76.713677] WARNING: CPU: 3 PID: 134 at kernel/irq/msi.c:1028 msi_create_device_irq_domain+0x1bc/0x22c
> [   76.723010] Modules linked in:
> [   76.726082] CPU: 3 UID: 0 PID: 134 Comm: kworker/3:1H Not tainted 6.13.0-rc1-00015-gd60b98003b43-dirty #57
> [   76.735741] Hardware name: NXP i.MX95 19X19 board (DT)
> [   76.740883] Workqueue: kpcitest pci_epf_test_cmd_handler
> [   76.746212] pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   76.753172] pc : msi_create_device_irq_domain+0x1bc/0x22c
> [   76.758586] lr : msi_create_device_irq_domain+0x104/0x22c
> [   76.763988] sp : ffff800083f43be0
> [   76.767313] x29: ffff800083f43be0 x28: 0000000000000000 x27: ffff8000827a7000
> [   76.774466] x26: ffff00008085f400 x25: ffff00008000b180 x24: ffff000080fc6410
> [   76.781624] x23: ffff000085704cc0 x22: ffff8000811c8828 x21: ffff000085704cc0
> [   76.788774] x20: ffff000082814000 x19: 0000000000000000 x18: ffffffffffffffff
> [   76.795933] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   76.803083] x14: 0000000000000000 x13: 0000000f00000000 x12: 0000000000000000
> [   76.810233] x11: 0000000000000000 x10: 000000000000002d x9 : ffff800083f43ba0
> [   76.817383] x8 : 00000000ffffffff x7 : 0000000000000019 x6 : ffff0000857e443a
> [   76.824533] x5 : 0000000000000000 x4 : ffffffffffffffff x3 : ffff000085704ce8
> [   76.831683] x2 : ffff000080835640 x1 : 0000000000000213 x0 : ffff0000877189c0
> [   76.838840] Call trace:
> [   76.841287]  msi_create_device_irq_domain+0x1bc/0x22c (P)
> [   76.846701]  msi_create_device_irq_domain+0x104/0x22c (L)
> [   76.852118]  platform_device_msi_init_and_alloc_irqs+0x6c/0xb8
> 
> Do below two things in platform_device_msi_init_and_alloc_irqs().
> - msi_create_device_irq_domain()
> - msi_domain_alloc_irqs_range()
> 
> But only call msi_domain_free_irqs_all() in
> platform_device_msi_free_irqs_all(), which missed call
> msi_remove_device_irq_domain(). This cause above kernel dump when call
> platform_device_msi_init_and_alloc_irqs() again.

I don't think this commit message makes much sense, and doesn't
explain the essential problem, which is the lack of symmetry. I'd
suggest something like:

"platform_device_msi_init_and_alloc_irqs() performs two tasks:
allocating the MSI domain for a platform device, and allocate a number
of MSIs in that domain.

platform_device_msi_free_irqs_all() only frees the MSIs, and leaves
the MSI domain alive.

Given that platform_device_msi_init_and_alloc_irqs() is the sole tool
a platform device has to allocate platform MSIs, it would make sense
for platform_device_msi_free_irqs_all() to teardown the MSI domain at
the same time as the MSIs.

This also avoids warnings and unexpected behaviours when a driver
repeatedly allocates and frees MSIs."

With that:

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.

