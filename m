Return-Path: <linux-kselftest+bounces-36326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C1DAF5950
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F21188677A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100AF288C32;
	Wed,  2 Jul 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZgZ3cCs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21F2741A3;
	Wed,  2 Jul 2025 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462862; cv=none; b=rbsXV+AByARK8WIjKRvJAX1w1lbVeUI8Mr4NO6SxsO8rqupY6hju3yDcxFFEEOh5H34m7c+Oc0sKzcPP1px7yRCCrGZ8jHraktkNb0dvPVziLlmM3pf7YNLdrFYCoFHFnL9BLuYgzpaKszrmdGbky51JX2JMVRm05hN5UT2iqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462862; c=relaxed/simple;
	bh=slisvBvEmCIr7Kjcl8tWxBfosNKCVxrrtq3pQ2cJ8Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODmgTuobinylq5VRRUsa294bRWvdpXhNFfXXuMKpk1qd5uJPPMoViVcVZWoAQBub2V9GRaw6gEpyyIHDV3Nr3ljr2HRMEJaO4xKxRiZLgnmQvsxFYDzcW3OpyTzLw4s6irs7R6kzxkPy9zplohlg3AGm2ON+VyY6chcCsxkCqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZgZ3cCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A598C4CEED;
	Wed,  2 Jul 2025 13:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751462862;
	bh=slisvBvEmCIr7Kjcl8tWxBfosNKCVxrrtq3pQ2cJ8Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KZgZ3cCs8WlBsb/oRaNpWq+WQaDmMwVh0+ZxhVgdK2KHRbcyjZIQLgdCt9TtHSLXL
	 hlpbJQ5bmxBZJC/7wc+yPLLcSnkVyI8YRntTKhH727JPauseLBG2j549biE0vFYawm
	 Kp1TYqCD2/VckZNBVIUzMG+cUzoB2lVrw9I4RYagIotsPqMmCKY4B3J7P9T2yBZReY
	 ZripjSJsV75cz6igrXk1+ZLSkyFuXdMr+HhDq0rQsRB3v1PLgmVYgUQPx64LsoRjyo
	 ttBByorZMKPDjlxLNlyfCll1l91abFTnVJBlhDDuvTJDneXpFlMTdIb+RiGedb3bz1
	 vJAer7cDA6kIw==
Date: Wed, 2 Jul 2025 18:57:23 +0530
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
Subject: Re: [PATCH v19 00/10] PCI: EP: Add RC-to-EP doorbell with platform
 MSI controller
Message-ID: <roskp2zsjohrgll464u4jtbulzjid523u3yvgciifwiuoygv5t@7f7cj4wfy2y7>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>

On Mon, Jun 09, 2025 at 12:34:12PM GMT, Frank Li wrote:
> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
> 
> This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
> 
> Original patch only target to vntb driver. But actually it is common
> method.
> 
> This patches add new API to pci-epf-core, so any EP driver can use it.
> 

Frank, thanks for your persistence in pushing this series, really appreciated!
I've left some comments, but no real blocker.

Unfortunately, I don't have access to my endpoint setup right now. So I'll go
ahead with the Tested-by tag from Niklas once my comments are addressed.

- Mani

> Previous v2 discussion here.
> https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/
> 
> Changes in v19:
> - irq part already in v6.16-rc1, only missed pcie/dts part
> - rebase to v6.16-rc1
> - update commit message for patch IMMUTABLE check.
> - Link to v18: https://lore.kernel.org/r/20250414-ep-msi-v18-0-f69b49917464@nxp.com
> 
> Changes in v18:
> - pci-ep.yaml: sort property order, fix maxvalue to 0x7ffff for msi-map-mask and
> iommu-map-mask
> - Link to v17: https://lore.kernel.org/r/20250407-ep-msi-v17-0-633ab45a31d0@nxp.com
> 
> Changes in v17:
> - move document part to pci-ep.yaml
> - Link to v16: https://lore.kernel.org/r/20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com
> 
> Changes in v16:
> - remove arm64: dts: imx95-19x19-evk: Add PCIe1 endpoint function overlay file
> because there are better patches, which under review.
> - Add document for pcie-ep msi-map usage
> - other change to see each patch's change log
> About IMMUTABLE (No change for this part, tglx provide feedback)
> > - This IMMUTABLE thing serves no purpose, because you don't randomly
> >   plug this end-point block on any MSI controller. They come as part
> >   of an SoC.
> 
> "Yes and no. The problem is that the EP implementation is meant to be a
> generic library and while GIC-ITS guarantees immutability of the
> address/data pair after setup, there are architectures (x86, loongson,
> riscv) where the base MSI controller does not and immutability is only
> achieved when interrupt remapping is enabled. The latter can be disabled
> at boot-time and then the EP implementation becomes a lottery across
> affinity changes.
> 
> That was my concern about this library implementation and that's why I
> asked for a mechanism to ensure that the underlying irqdomain provides a
> immutable address/data pair.
> 
> So it does not matter for GIC-ITS, but in the larger picture it matters.
> 
> Thanks,
> 
>         tglx
> "
> 
> So it does not matter for GIC-ITS, but in the larger picture it matters.
> 
> - Link to v15: https://lore.kernel.org/r/20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com
> 
> Changes in v15:
> - rebase to v6.14-rc1
> - fix build issue find by kernel test robot
> - Link to v14: https://lore.kernel.org/r/20250207-ep-msi-v14-0-9671b136f2b8@nxp.com
> 
> Changes in v14:
> Marc Zyngier raised concerns about adding DOMAIN_BUS_DEVICE_PCI_EP_MSI. As
> a result, the approach has been reverted to the v9 method. However, there
> are several improvements:
> 
> MSI now supports msi-map in addition to msi-parent.
>   - The struct device: id is used as the endpoint function (EPF) device
> identity to map to the stream ID (sideband information).
>   - The EPC device tree source (DTS) utilizes msi-map to provide such
> information.
>   - The EPF device's of_node is set to the EPC controller’s node. This
> approach is commonly used for multi-function device (MFD) platform child
> devices, allowing them to inherit properties from the MFD device’s DTS,
> such as reset-cells and gpio-cells. This method is well-suited for the
> current case, as the EPF is inherently created/binded to the EPC and
> should inherit the EPC’s DTS node properties.
> 
> Additionally:
> 
> Since the basic IMX95 LUT support has already been merged into the
> mainline, a DTS and driver increment patch is added to complete the
> solution. The patch is rebased onto the latest linux-next tree and
> aligned with the new pcitest framework.
> 
> - Link to v13: https://lore.kernel.org/r/20241218-ep-msi-v13-0-646e2192dc24@nxp.com
> 
> Changes in v13:
> - Change to use DOMAIN_BUS_PCI_DEVICE_EP_MSI
> - Change request id as  func | vfunc << 3
> - Remove IRQ_DOMAIN_MSI_IMMUTABLE
> 
> Thomas Gleixner:
> 
> I hope capture all your points in review comments. If missed, let me know.
> 
> - Link to v12: https://lore.kernel.org/r/20241211-ep-msi-v12-0-33d4532fa520@nxp.com
> 
> Changes in v12:
> - Change to use IRQ_DOMAIN_MSI_IMMUTABLE and add help function
> irq_domain_msi_is_immuatble().
> - split PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check to 3 patches
> - Link to v11: https://lore.kernel.org/r/20241209-ep-msi-v11-0-7434fa8397bd@nxp.com
> 
> Changes in v11:
> - Change to use MSI_FLAG_MSG_IMMUTABLE
> - Link to v10: https://lore.kernel.org/r/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com
> 
> Changes in v10:
> 
> Thomas Gleixner:
> 	There are big change in pci-ep-msi.c. I am sure if go on the
> corrent path. The key improvement is remove only 1 function devices's
> limitation.
> 
> 	I use new patch for imutable check, which relative additional
> feature compared to base enablement patch.
> 
> - Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
> - Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
> - Remove only support 1 endpoint function limiation.
> - Create one MSI domain for each endpoint function devices.
> - Use "msi-map" in pci ep controler node, instead of of msi-parent. first
> argument is
> 	(func_no << 8 | vfunc_no)
> 
> - Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com
> 
> Changes in v9
> - Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
> - Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
> - Remove API pci_epf_align_inbound_addr_lo_hi
> - Move doorbell_alloc in to doorbell_enable function.
> - Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com
> 
> Changes in v8:
> - update helper function name to pci_epf_align_inbound_addr()
> - Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com
> 
> Changes in v7:
> - Add helper function pci_epf_align_addr();
> - Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com
> 
> Changes in v6:
> - change doorbell_addr to doorbell_offset
> - use round_down()
> - add Niklas's test by tag
> - rebase to pci/endpoint
> - Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com
> 
> Changes in v5:
> - Move request_irq to epf test function driver for more flexiable user case
> - Add fixed size bar handler
> - Some minor improvememtn to see each patches's changelog.
> - Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com
> 
> Changes in v4:
> - Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
> - Use new method to avoid compatible problem.
>   Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
>   pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
> remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
> driver don't support new command, so failure return, not side effect.
>   After test, DOORBELL_DISABLE command send out to recover original map, so
> pcitest bar test can pass as normal.
> - Other detail change see each patches's change log
> - Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com
> 
> Change from v2 to v3
> - Fixed manivannan's comments
> - Move common part to pci-ep-msi.c and pci-ep-msi.h
> - rebase to 6.12-rc1
> - use RevID to distingiush old version
> 
> mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
> echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
> echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
> echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
> echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
> ^^^^^^ to enable platform msi support.
> ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep
> 
> - use new device ID, which identify support doorbell to avoid broken
> compatility.
> 
>     Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
>     keep the same behavior as before.
> 
>            EP side             RC with old driver      RC with new driver
>     PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
>     Other device ID             doorbell disabled*       doorbell disabled*
> 
>     * Behavior remains unchanged.
> 
> Change from v1 to v2
> - Add missed patch for endpont/pci-epf-test.c
> - Move alloc and free to epc driver from epf.
> - Provide general help function for EPC driver to alloc platform msi irq.
> - Fixed manivannan's comments.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (10):
>       PCI: endpoint: Set ID and of_node for function driver
>       PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
>       PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
>       PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
>       PCI: endpoint: pci-epf-test: Add doorbell test support
>       misc: pci_endpoint_test: Add doorbell test case
>       selftests: pci_endpoint: Add doorbell test case
>       pci: imx6: Add helper function imx_pcie_add_lut_by_rid()
>       pci: imx6: Add LUT setting for MSI/IOMMU in Endpoint mode
>       arm64: dts: imx95: Add msi-map for pci-ep device
> 
>  arch/arm64/boot/dts/freescale/imx95.dtsi           |   1 +
>  drivers/misc/pci_endpoint_test.c                   |  82 ++++++++++++
>  drivers/pci/controller/dwc/pci-imx6.c              |  25 ++--
>  drivers/pci/endpoint/Makefile                      |   1 +
>  drivers/pci/endpoint/functions/pci-epf-test.c      | 142 +++++++++++++++++++++
>  drivers/pci/endpoint/pci-ep-msi.c                  |  90 +++++++++++++
>  drivers/pci/endpoint/pci-epf-core.c                |  48 +++++++
>  include/linux/pci-ep-msi.h                         |  28 ++++
>  include/linux/pci-epf.h                            |  21 +++
>  include/uapi/linux/pcitest.h                       |   1 +
>  .../selftests/pci_endpoint/pci_endpoint_test.c     |  28 ++++
>  11 files changed, 459 insertions(+), 8 deletions(-)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20241010-ep-msi-8b4cab33b1be
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

