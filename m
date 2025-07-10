Return-Path: <linux-kselftest+bounces-36959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B30B000B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 13:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9671C85D3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBCF241693;
	Thu, 10 Jul 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwbafXNw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336961A841A;
	Thu, 10 Jul 2025 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752147634; cv=none; b=d62n12+GsyjaoOpyLatAxy9zHxdcfZoVJxOmg6349A4wNs9SFoKBHP2qH9+wiFwvbvdrKmc4XMCwmXZes5Lj1CvD/oTNXH/0301bHpY1v//bBSmJLrKepBQA2tgh17SRrLXlTZ31CJlU6Sj4dqRhZV11IQ7Nmk49lp1XAH4ujtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752147634; c=relaxed/simple;
	bh=1RsuIHRRAuqcGHCQF+P/OS8tKhDFc+7jVpMSz2Nnvvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVUucYLg3frz5TsGRUdQqFgvddySbx3PY2cQaNVRFBs3ZrSmAKI5QTrkf/0bK0cWL16BGQJyBNLZtg6K+z0Niat77NWAcpNdQBONRqijJ5uYFCyTI/gSXumQQCn5TgGtFVa1ejLSftxCjhEUF8VXuihxuRMCZClthmK+5VKeYCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwbafXNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF30BC4CEE3;
	Thu, 10 Jul 2025 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752147633;
	bh=1RsuIHRRAuqcGHCQF+P/OS8tKhDFc+7jVpMSz2Nnvvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwbafXNwxIffsI5cFE+wVdo3GwQzgD9et58i9iA2Vhcrd3NamfBHDIsmyd8vhOn3/
	 OKbc+3lMPdFOQz0+WHd3/rGT0eVDw1o6yAf0POqKsQq3WU78mY3N/3/PLEoIUpeHo5
	 gIgReOW9YRwWW/beO4KmTdcOwixMvtzRsdfdtsu4mocg7q0eniBRLs0VsZAiYvo40A
	 vHoP8yYegdn0seT9UVUMTV8IMTOMwAwmgRcE9vVT9D7v2OV+nW70R2D1OeUX9q2w9N
	 v6ceJ8uA1clmxy+gXhMW2NuYJk48/l8YXAXBSzOFKC7B9per0ONphmupfawihauGOz
	 AJ1j7GFoXCyWA==
Date: Thu, 10 Jul 2025 13:40:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank.Li@nxp.com
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
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v20 0/9] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Message-ID: <aG-mqWtUu9-CD43U@ryzen>
References: <20250709-ep-msi-v20-0-43d56f9bd54a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-ep-msi-v20-0-43d56f9bd54a@nxp.com>

Hello Frank,

I tested v20 of your series, but unfortunately, it still doesn't work.

When enabling the doorbell, the programming of the inbound iATU fails:

## pci_epf_test_enable_doorbell()
## keeps the BAR size, and BAR type of a BAR that has already been configured,
## but changes the address translation for this BAR to redirect to the GIC ITS
## rather than to the memory allocated by pci_epf_alloc_space()
## (does not free the memory allocated by pci_epf_alloc_space())

[   39.347502] pci_epf_test_enable_doorbell: msg hi: 0x0 msg low: 0xfe670040
[   39.348103] pci_epf_test_enable_doorbell: base: 0xfe670000 off: 0x40
[   39.348658] dw_pcie_ep_inbound_atu index: 1 parent_bus_addr: 0xfe670000 bar: 1 size: 0x100000
[   39.349403] dw_pcie_prog_ep_inbound_atu parent_bus_addr: 0xfe670000 pci->region_align: 0x10000 IS_ALIGNED: 1
[   39.350260] dw_pcie_prog_ep_inbound_atu parent_bus_addr: 0xfe670000 size: 0x100000 IS_ALIGNED: 0
[   39.351028] rockchip-dw-pcie a40000000.pcie-ep: Failed to program IB window

## pci_epf_test_disable_doorbell()
## changes the address translation for this BAR to redirect to the memory
## allocated by pci_epf_alloc_space() (which was never freed when enabling the
## doorbell)

[   39.351656] dw_pcie_ep_inbound_atu index: 1 parent_bus_addr: 0xa2e00000 bar: 1 size: 0x100000
[   39.352401] dw_pcie_prog_ep_inbound_atu parent_bus_addr: 0xa2e00000 pci->region_align: 0x10000 IS_ALIGNED: 1
[   39.353257] dw_pcie_prog_ep_inbound_atu parent_bus_addr: 0xa2e00000 size: 0x100000 IS_ALIGNED: 1


The reason why pci_epf_test_enable_doorbell() fails is because of this check:
https://github.com/torvalds/linux/blob/v6.16-rc5/drivers/pci/controller/dwc/pcie-designware.c#L663

If you want to understand why this very important check is there, it is
because the DWC controller requires that the physical address programmed in
the iATU is aligned to the size of the BAR (BAR_MASK+1), see this commit:
https://github.com/torvalds/linux/commit/129f6af747b2


Applying the following patch on top of your v20 series makes things work as
intended and makes the pcie_ep_doorbell.DOORBELL_TEST selftest pass for me:

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index dfdd25cfc003..7d356b0201ae 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -738,9 +738,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	reg->doorbell_bar = cpu_to_le32(bar);
 
 	msg = &epf->db_msg[0].msg;
-	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+	ret = pci_epf_align_inbound_addr(epf, epf->bar[bar].size,
+					((u64)msg->address_hi << 32) | msg->address_lo,
 					&epf_test->db_bar.phys_addr, &offset);
-
 	if (ret)
 		goto err_doorbell;
 
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index c21d8e786eb3..b3d4117182e2 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -478,44 +478,36 @@ struct pci_epf *pci_epf_create(const char *name)
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
 /**
- * pci_epf_align_inbound_addr() - Align the given address based on the BAR
- *				 alignment requirement
+ * pci_epf_align_inbound_addr() - Align the given address based on the BAR size
+ *
  * @epf: the EPF device
+ * @bar_size: the current BAR size
  * @addr: inbound address to be aligned
- * @bar: the BAR number corresponding to the given addr
- * @base: base address matching the @bar alignment requirement.
+ * @base: base address matching the @bar_size alignment requirement.
  * @off: offset to be added to the @base address.
  *
- * Helper function to align input 'addr' to base and offset, which match
- * BAR's alignment requirement.
+ * Helper function to align input 'addr' to base and offset, when dynamically
+ * changing a BAR.
  *
  * The pci_epf_alloc_space() function already accounts for alignment. This is
  * primarily intended for use with other memory regions not allocated by
  * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
  * address for a platform MSI controller.
+ *
+ * Since this function is only used when dynamically changing a BAR (i.e. when
+ * calling set_bar() twice, without ever calling clear_bar(), as calling
+ * clear_bar() would clear the BAR's PCI address assigned by the host), this
+ * function must align to the current BAR size, since we are not clearing the
+ * BAR configuration.
  */
-int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
-			      u64 addr, dma_addr_t *base, size_t *off)
+int pci_epf_align_inbound_addr(struct pci_epf *epf, size_t bar_size, u64 addr,
+			      dma_addr_t *base, size_t *off)
 {
-	const struct pci_epc_features *epc_features;
-	u64 align;
-
-	if (!base || !off)
+	if (!base || !off || !bar_size)
 		return -EINVAL;
 
-	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
-	if (!epc_features) {
-		dev_err(&epf->dev, "epc_features not implemented\n");
-		return -EOPNOTSUPP;
-	}
-
-	align = epc_features->align;
-	align = align ? align : 128;
-	if (epc_features->bar[bar].type == BAR_FIXED)
-		align = max(epc_features->bar[bar].fixed_size, align);
-
-	*base = round_down(addr, align);
-	*off = addr & (align - 1);
+	*base = round_down(addr, bar_size);
+	*off = addr & (bar_size - 1);
 
 	return 0;
 }
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 0ca08f0d05d7..bcc8184325d2 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -242,8 +242,8 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
 
-int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
-			      u64 addr, dma_addr_t *base, size_t *off);
+int pci_epf_align_inbound_addr(struct pci_epf *epf, size_t bar_size, u64 addr,
+			      dma_addr_t *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);




However, the more I think about it, considering that this alignment requirement
is inherent to the DWC controller (other controllers might not have this
requirement), perhaps pci_epf_align_inbound_addr() should not be a function in
pci-epf-core.c, perhaps this function would be better suited to live in
drivers/pci/controller/dwc/pcie-designware-ep.c ?


Kind regards,
Niklas

