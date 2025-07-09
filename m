Return-Path: <linux-kselftest+bounces-36883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B3EAFF38D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 23:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944D14E0111
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0884C23FC41;
	Wed,  9 Jul 2025 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvnGNcYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E87235BE8;
	Wed,  9 Jul 2025 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094970; cv=none; b=e2hx7WIOMoDHjkQFxb+L3uI7ziTlBiFYxhpuZKLTI4NFvpO2eTYYuX4oDWTN9okC9ymLFyVXXRIx1v3M1KV7mcayq5wp86pTH6doSdYKpBDatx7OrpwMScne7iRZLt9+eaV3fBgXjfCc9jbcEKMJZ8JxW9Un6mqa/lwzbQsl5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094970; c=relaxed/simple;
	bh=FbFfJ0O8Cxn9ky/KBPJJ3vCgtFRuln3RMTTcy+zzSU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vjfg636M12oCGPy/yzi7PRsg5wCswq/X/aDPRYWE0djmvgotuWW55q/eDP3xjEjyBWK5Ew7XTenMVNRAOXPprU/80a1P0uhsRiysE8sk5vySWvlTKpbPYrQw0I6CpYTYLY2LReV+aRoowcvhUff/jENw817HqfOi63Yp9CEGmyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvnGNcYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A81EC116C6;
	Wed,  9 Jul 2025 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752094970;
	bh=FbFfJ0O8Cxn9ky/KBPJJ3vCgtFRuln3RMTTcy+zzSU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NvnGNcYSWDaqpFvNml1vX1/4XPeIPc2Ig+oe/uADOI8ihfiMKXPzOLmsHPLOqye4i
	 bKZURk7FBbTzadkWdTI4yViDXs6Xr4XA8R6auks3RFZPe1KZTTjAXy7yQ+EOpT5xUg
	 H7pFDTtIhkfaaph4V7JQbe5FybyIGfcZB954kfIWYEyKRfEYNWaRfbvCnKS7dvkVI+
	 7vJY6JGLMY+Dwnme4QmDD8xhzaFBbVKDn7eeCSWVU8QjLtdBdgExRTK0l6RIOqdlTA
	 Ho6489x0hA/KHna+mWQUg3eWJ7s14LffRi/XcCavGyddgfXJGBn+vRAFOdJdGvoZPu
	 qm8SadTOctjMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A39CC83F09;
	Wed,  9 Jul 2025 21:02:50 +0000 (UTC)
From: Frank Li via B4 Relay <devnull+Frank.Li.nxp.com@kernel.org>
Date: Wed, 09 Jul 2025 17:02:15 -0400
Subject: [PATCH v20 3/9] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-ep-msi-v20-3-43d56f9bd54a@nxp.com>
References: <20250709-ep-msi-v20-0-43d56f9bd54a@nxp.com>
In-Reply-To: <20250709-ep-msi-v20-0-43d56f9bd54a@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752094968; l=9861;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DjOBYFEm2LaVAMsRUL0bGftXbmddhhW5FmKcXkwYvPg=;
 b=l4SJvXC8xiUo3wpRHE4CqEjAVgd9s/Ay8Fhkjvoy8IxQqPWRc//3MGJgEW6sVrMvurRG5iFH0
 e1XGQu2sa0QBFVEWhoPQLWdwCv+V8J0CQ4Lu7NeLknV5mYRQyUm+87x
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-Endpoint-Received: by B4 Relay for Frank.Li@nxp.com/20240130 with
 auth_id=121
X-Original-From: Frank Li <Frank.Li@nxp.com>
Reply-To: Frank.Li@nxp.com

From: Frank Li <Frank.Li@nxp.com>

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v20
- remove Niklas Cassel test-by tag
- rollback to use epc and only support one epf to void touch epf's of_node
- add new config PCI_ENDPOINT_MSI_DOORBELL
- error code change to ENODATA
- don't overwrite return value of platform_device_msi_init_and_alloc_irqs()
- remove comment @name in struct pci_epf_doorbell_msg
- Add #include <linux/export.h> to fix kbuild warning

Change from v15 to v16
- fix rebase conflict

Change from v14 to v15
- check CONFIG_GENERIC_MSI

Fix below build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082204.6PRR3cfG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_alloc_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:53:15: error: implicit declaration of function 'platform_device_msi_init_and_alloc_irqs' [-Werror=implicit-function-declaration]
      53 |         ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082242.pOq1hB1d-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_alloc_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:49:14: error: implicit declaration of function 'irq_domain_is_msi_immutable'; did you mean 'irq_domain_is_msi_device'? [-Werror=implicit-function-declaration]
      49 |         if (!irq_domain_is_msi_immutable(dom)) {

Change from v13 to v14
- basic roll back to v9
- use device:id as msi-map input, its will handle it
- use existed platform_device_msi_init_and_alloc_irqs()
- pass down epf->dev point, because epf->dev of-node will be the same as
epc's parent.

Change from v12 to v13
- Use DOMAIN_BUS_DEVICE_PCI_EP_MSI

Change from v10 to v12
- none

Change from v9 to v10
- Create msi domain for each function device.
- Remove only function support limiation. My hardware only support one
function, so not test more than one case.
- use "msi-map" descript msi information

  msi-map = <func_no << 8  | vfunc_no, &its, start_stream_id,  size>;

Chagne from v8 to v9
- sort header file
- use pci_epc_get(dev_name(msi_desc_to_dev(desc)));
- check epf number at pci_epf_alloc_doorbell
- Add comments for miss msi-parent case

change from v5 to v8
-none

Change from v4 to v5
- Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
driver, so ep function driver can register differece call back function for
difference doorbell events and set irq affinity to differece CPU core.
- Improve error message when MSI allocate failure.

Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/Kconfig      |  8 ++++
 drivers/pci/endpoint/Makefile     |  1 +
 drivers/pci/endpoint/pci-ep-msi.c | 90 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        | 28 ++++++++++++
 include/linux/pci-epf.h           | 15 +++++++
 5 files changed, 142 insertions(+)

diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index 1c5d82eb57d440fb18c788921fc27096b75b061e..72f82ae98f94556ec5cd734e4525b363879aa340 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -28,6 +28,14 @@ config PCI_ENDPOINT_CONFIGFS
 	   configure the endpoint function and used to bind the
 	   function with an endpoint controller.
 
+config PCI_ENDPOINT_MSI_DOORBELL
+	bool "PCI Endpoint MSI Doorbell Support"
+	depends on PCI_ENDPOINT && GENERIC_MSI_IRQ
+	help
+	  This enables the EP's MSI interrupt controller to function as a
+	  doorbell. The RC can then notify the EP by writing data to dedicated
+	  BAR, which the EP maps to the controller's message address.
+
 source "drivers/pci/endpoint/functions/Kconfig"
 
 endmenu
diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06be6ecd210e8d834610021a22470..b4869d52053aade87298289b29b3beb547001bfa 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
 					   pci-epc-mem.o functions/
+obj-$(CONFIG_PCI_ENDPOINT_MSI_DOORBELL)	+= pci-ep-msi.o
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000000000000000000000000000000..de610c16f68986eb0a5f4a0f23bd0136aa169f97
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2025 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+#include <linux/slab.h>
+
+static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epc *epc;
+	struct pci_epf *epf;
+
+	epc = pci_epc_get(dev_name(msi_desc_to_dev(desc)));
+	if (!epc)
+		return;
+
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+
+	pci_epc_put(epc);
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct irq_domain *dom;
+	void *msg;
+	int ret;
+	int i;
+
+	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
+		dev_err(dev, "MSI doorbell only support one endpoint function\n");
+		return -EINVAL;
+	}
+
+	dom = of_msi_map_get_device_domain(epc->dev.parent, 0, DOMAIN_BUS_PLATFORM_MSI);
+	if (!dom) {
+		dev_err(dev, "Can't find MSI domain for parent device\n");
+		return -ENODEV;
+	}
+
+	dev_set_msi_domain(epc->dev.parent, dom);
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = platform_device_msi_init_and_alloc_irqs(epc->dev.parent, num_db,
+						      pci_epf_write_msi_msg);
+	if (ret) {
+		dev_err(dev, "Failed to allocate MSI\n");
+		kfree(msg);
+		return ret;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
+
+	kfree(epf->db_msg);
+	epf->db_msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000000000000000000000000000000..7c5db90f96204559b4be0c8805565f210461ac75
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+struct pci_epf;
+
+#ifdef CONFIG_PCI_ENDPOINT_MSI_DOORBELL
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+#else
+static inline int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums)
+{
+	return -ENODATA;
+}
+
+static inline void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+}
+#endif /* CONFIG_GENERIC_MSI_IRQ */
+
+#endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 749cee0bcf2cc0600ad3be1582b0c497c5a21bed..a3b1a1d90d18356e8cda966c7004c3be93962a0d 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -128,6 +129,16 @@ struct pci_epf_bar {
 	int		flags;
 };
 
+/**
+ * struct pci_epf_doorbell_msg - represents doorbell message
+ * @msi_msg: MSI message
+ * @virq: irq number of this doorbell MSI message
+ */
+struct pci_epf_doorbell_msg {
+	struct msi_msg msg;
+	int virq;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -155,6 +166,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -185,6 +198,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1



