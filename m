Return-Path: <linux-kselftest+bounces-40949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF2DB49298
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4869F447228
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885AF30BF70;
	Mon,  8 Sep 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3siD1NR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A8228C9D;
	Mon,  8 Sep 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344124; cv=none; b=ZV1S9ilJDunuintSJNsK73z6RWBsj7jsef11ZomQdIvsivppR8MYZg2cTC5lFJh1tWSBWytwZvxDVwT7R7vbastwj5qBm0o243q7DafpKhdhXxpFfGJpUYWv4WSgnt4uEyHL7nWT0CBRVmO0SizMYT+9hJ11lBvufr0oTTWCrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344124; c=relaxed/simple;
	bh=fSYDgjY/SfJ5m+wyFnb04x7E2KP7tNSpQEmJ29X5mVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUKXO/SBkmeDBJRy2SCDRbg283QvqpjxtwHE6frS2KMqmlXd1eveeFp2x7Mfz7KmKnLgfk/N9nGYwWmwLluI0YSlc7AnJ5pc7plxMXHTxxS7CHmzFJ99/Rav9WPSzo8MYJHuVKaEg75byvzfARQx4uHma8VCrXez6MGdbkSREbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3siD1NR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B0FC4CEF1;
	Mon,  8 Sep 2025 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757344123;
	bh=fSYDgjY/SfJ5m+wyFnb04x7E2KP7tNSpQEmJ29X5mVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3siD1NRu8Q/mgEuCb+ckDctl2d4YV2M6tE8FcrBX5TtXeNYUc2DIS0rAANiXVDgE
	 fZtfiAwHsI6EWBFwsNsb4jL7c2o3/2mTSSpbpFvjlH8xfXsKKFcHe8Y1Hxq2+r+MoI
	 sPX0ng/FFYD+A+e9NxsxKGDLKNXtLA+HkCzX/wmhTPDg2N2jWCgSRA6kSTXDdOK5lk
	 2F2q8/PE+cbwUacg4d5PZOTgvP//6gPcwPKWzUWXZhrQ7LXqXesprjawg56gxhDPvJ
	 FyMAgiUZ073U18LOOx5+Y1TmjkW2GV5dpR+zQTaIOlfn+rRaygxcSZLZ+t4tgtGstV
	 7PfrOZVzDGGcA==
Date: Mon, 8 Sep 2025 17:08:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, dlemoal@kernel.org, jdmason@kudzu.us,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v21 0/9] PCI: EP: Add RC-to-EP doorbell with
 platform MSI controller
Message-ID: <aL7xc0aVi-olMAE-@flawful.org>
References: <20250710-ep-msi-v21-0-57683fc7fb25@nxp.com>
 <175311109182.25848.8880954995049551501.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175311109182.25848.8880954995049551501.b4-ty@kernel.org>

On Mon, Jul 21, 2025 at 08:48:11PM +0530, Manivannan Sadhasivam wrote:
> On Thu, 10 Jul 2025 15:13:46 -0400, Frank Li wrote:
> > [...]
> 
> Applied, thanks!
> 
> [3/9] PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
>       commit: b537ffe0eb2ab458f20ec135cc2b565c63a2ea00
> [4/9] PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
>       commit: 1f2ed78e43abb9ac0856a82867f64d472368a832
> [5/9] PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
>       commit: 1c2c5f9855a5cf4617bcda721c22dbd3345f06a1
> [6/9] PCI: endpoint: pci-epf-test: Add doorbell test support
>       commit: 5d4da5f8092e5a77ae371ae1112283b59790ac22
> [7/9] misc: pci_endpoint_test: Add doorbell test case
>       commit: a1a293e709a4ec0fa2e4253993a4b75f581c6cf2
> [8/9] selftests: pci_endpoint: Add doorbell test case
>       commit: b964b4894fcfc72e7496cf52a33cbba39d094c5b


Hello all,

I wanted to test this on rk3588, so I added msi-map to the pcie_ep node.

It works the first time:
# ./pcitest -r pcie_ep_doorbell.DOORBELL_TEST
TAP version 13
1..1
# Starting 1 tests from 1 test cases.
#  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
[   17.996519] offset: 70040
[   17.997904] left: 250 status: 0x240
#            OK  pcie_ep_doorbell.DOORBELL_TEST
ok 1 pcie_ep_doorbell.DOORBELL_TEST
# PASSED: 1 / 1 tests passed.
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Prints on EP side:
[   17.924761] pci_epf_test_enable_doorbell
[   17.926035] doorbell offset: 70040
[   17.927898] pci_epf_test_doorbell_handler
[   17.932816] pci_epf_test_disable_doorbell



However, if I run the exact same test case again:
# ./pcitest -r pcie_ep_doorbell.DOORBELL_TEST
TAP version 13
1..1
# Starting 1 tests from 1 test cases.
RUN           pcie_ep_doorbell.DOORBELL_TEST ...
[   34.672546] offset: 70040
[   35.688190] left: 0 status: 0x0
[   35.688480] pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
# pci_endpoint_test.c:258:DOORBELL_TEST:Expected 0 (0) == ret (-22)
# pci_endpoint_test.c:258:DOORBELL_TEST:Test failed for Doorbell

# DOORBELL_TEST: Test failed
#          FAIL  pcie_ep_doorbell.DOORBELL_TEST
not ok 1 pcie_ep_doorbell.DOORBELL_TEST
# FAILED: 0 / 1 tests passed.

Prints on EP side:
[   34.600717] pci_epf_test_enable_doorbell
[   34.602086] doorbell offset: 70040
[   35.624718] pci_epf_test_disable_doorbell



As you can see the print that I added in pci_epf_test_doorbell_handler()
never comes the second time executing this test case.


Frank, do you see the same problem?


Kind regards,
Niklas

