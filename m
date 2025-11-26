Return-Path: <linux-kselftest+bounces-46544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155A4C8B9B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1403B8CC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61BB341AC0;
	Wed, 26 Nov 2025 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAi+4Ix+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B0340273
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185777; cv=none; b=IAGffwsbR6RDJUVGbwi1o4LJz7vtjo7n81oTsntBslUgb7247z7vJB0LfriVuYIdBpKatmqKc8q9yhwx1BBV+a3CTn3Eu5MqQuB9NkxItFmQL2IrO+0Wchgh6Sax9yKhtswvSBXbBt8bK+xPaC6fpO2mge9I0L7rFi3aQjoeYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185777; c=relaxed/simple;
	bh=EmkP5+D+rlUjnYw1IRRpUkFiaMI5Frjr+rChuQWESLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LeJpKwFCVGZkd4yMpdN85N4C4IasDBBkqWJkU63T3PuK5CPGx/6C7fTaMjduh6fEIGz5RzRetJHxok5HuMVfNHtoHgu+cflNUrcmw6yXskrugaNtEHS4vv0Gj+9LLyIT5xh/pTuC01HMs9VbID7kLbkwOG4zZIXPlYUVqcDSFbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lAi+4Ix+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b90740249dso127698b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185774; x=1764790574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGzKyE17LTIjiDUTLc5iTgG4+2QVa3flPC17N65tMUo=;
        b=lAi+4Ix+i0j3r5ZqNhhkRCSsBdCQEMwWx0MgSC43hZbzTprTUERh2Wqbrtdv4CYSkt
         CPg+qK76fxzeRDOhUGun2hcVOEXNj1mucnDfpK3ie3AzdZc41h57o3RPGegP4aJ/ZG5I
         Jj+myTWz764PfBr44PpsE7UQAZq1ym9j6A8JTHDk2x9ZLEGsX+TYD5m8V5aPz6Z5XNnM
         IwTu5X+WZizro4uMw7g67d1L4TwL1DevQ4V5JUESMuvrQShMlQmymLETmUSuQOXxbl31
         I8z6+CwUYAZdQrqb9CcT+fPZDbp81NdJubmh44JC9pqPTkhjPmbpPLOR9ETS+m+Z+vXe
         M/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185774; x=1764790574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGzKyE17LTIjiDUTLc5iTgG4+2QVa3flPC17N65tMUo=;
        b=s/pZzfTpf0x+skW+fb0gCi0efNkiTUFoxXy3IvqUaM6gS1Q3mbIQqa9nU8KRoFEQOk
         dzYtryLH0zT7X9PvbgDhy+xdhBsa1hHFWajFh3fLGm8rK9MCf76cEcy0w7qwUWaPS1kw
         umNwD0MzRuXc8qcsUPP40jOK9ZPs8z7tYPCWbv4cK1QEl2UPP2zgYjkaf9VAe6MEoLrI
         orpX3dl03464YyEAYs6dmEU+GOD8rDmSdRjvbWf2Htnpqgnok3Or+k8srIBQNfZBCrAN
         PeJ4EUouTALNSGCE+5dCp2adJ+hd6+trjUBlFfRe32ci3bu2LKRwW0zQj3uhmlNiJiQA
         pCNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXflM9J5VQr4oq21kYwsWpGSeQMtxP24F1rJ9Zs2k7arB5IbyshEbPDZ0hD7Yxo01Dgsoj9d3vpsvPzR+85PDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTO+vttPp2ANKSKfPr/QnXkWxoZSQUM02I5r40WLSSwC7Yecf
	c3BI+myzUlxUYMkv+fTKJklxhq+X9VwyNN/NAmjSfxnwouZZT+5VeXNcEAVxtMNrJyCdEfW2Zea
	iwVmPKyQU8p8LjQ==
X-Google-Smtp-Source: AGHT+IHGeSb0yVqfD3cs07aFTfYmCZ7mgD11B0dXTDhgzXpsQtWff0tzFWVLtBWXSh4eYpi5VvZWhIYsSuOdcA==
X-Received: from pfus11.prod.google.com ([2002:a05:6a00:8cb:b0:7bf:76b4:31f8])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23d5:b0:7ad:9e8a:1f72 with SMTP id d2e1a72fcca58-7c58c7a7601mr24343739b3a.14.1764185774060;
 Wed, 26 Nov 2025 11:36:14 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:49 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-3-dmatlack@google.com>
Subject: [PATCH 02/21] PCI: Add API to track PCI devices preserved across Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Add an API to enable the PCI subsystem to track all devices that are
preserved across a Live Update, including both incoming devices (passed
from the previous kernel) and outgoing devices (passed to the next
kernel).

Use PCI segment number and BDF to keep track of devices across Live
Update. This means the kernel must keep both identifiers constant across
a Live Update for any preserved device. VFs are not supported for now,
since that requires preserving SR-IOV state on the device to ensure the
same number of VFs appear after kexec and with the same BDFs.

Drivers that preserve devices across Live Update can now register their
struct liveupdate_file_handler with the PCI subsystem so that the PCI
subsystem can allocate and manage File-Lifecycle-Bound (FLB) global data
to track the list of incoming and outgoing preserved devices.

  pci_liveupdate_register_fh(driver_fh)
  pci_liveupdate_unregister_fh(driver_fh)

Drivers can notify the PCI subsystem whenever a device is preserved and
unpreserved with the following APIs:

  pci_liveupdate_outgoing_preserve(pci_dev)
  pci_liveupdate_outgoing_unpreserve(pci_dev)

After a Live Update, the PCI subsystem can fetch its FLB global data
from the previous kernel from the Live Update Orchestrator (LUO) to
determine which devices are preserved. This API is also made available
for drivers to use to check if a device was preserved before userspace
retrieves the file for it.

  pci_liveupdate_incoming_is_preserved(pci_dev)

Once a driver has finished restoring an incoming preserved device, it
can notify the PCI subsystem with the following call:

  pci_liveupdate_incoming_finish(pci_dev)

This will be used in subsequent commits by the vfio-pci driver to
preserve VFIO devices across Live Update.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/Makefile        |   1 +
 drivers/pci/liveupdate.c    | 248 ++++++++++++++++++++++++++++++++++++
 include/linux/kho/abi/pci.h |  53 ++++++++
 include/linux/pci.h         |  38 ++++++
 4 files changed, 340 insertions(+)
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 include/linux/kho/abi/pci.h

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..0cb43e10e71d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= pci-sysfs.o slot.o
 obj-$(CONFIG_ACPI)		+= pci-acpi.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
+obj-$(CONFIG_LIVEUPDATE)	+= liveupdate.o
 endif
 
 obj-$(CONFIG_OF)		+= of.o
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
new file mode 100644
index 000000000000..f9bb97f3bada
--- /dev/null
+++ b/drivers/pci/liveupdate.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * David Matlack <dmatlack@google.com>
+ */
+
+#include <linux/bsearch.h>
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/pci.h>
+#include <linux/liveupdate.h>
+#include <linux/mutex.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+#include <linux/sort.h>
+
+static DEFINE_MUTEX(pci_flb_outgoing_lock);
+static DEFINE_MUTEX(pci_flb_incoming_lock);
+
+static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
+{
+	struct pci_dev *dev = NULL;
+	struct folio *folio;
+	unsigned int order;
+	int nr_devices = 0;
+	int ret;
+
+	/*
+	 * Calculate the maximum number of devices based on what's present
+	 * on the system currently (including VFs) to size the folio holding
+	 * struct pci_ser. This is not perfect given devices could be
+	 * hotplugged, but it's also unlikely that all devices in the system are
+	 * going to be preserved anyway.
+	 */
+	for_each_pci_dev(dev) {
+		if (dev->is_virtfn)
+			continue;
+
+		nr_devices += 1 + pci_sriov_get_totalvfs(dev);
+	}
+
+	order = get_order(offsetof(struct pci_ser, devices[nr_devices + 1]));
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
+	if (!folio)
+		return -ENOMEM;
+
+	ret = kho_preserve_folio(folio);
+	if (ret) {
+		folio_put(folio);
+		return ret;
+	}
+
+	args->obj = folio_address(folio);
+	args->data = virt_to_phys(args->obj);
+
+	return 0;
+}
+
+static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
+{
+	struct pci_ser *ser = args->obj;
+	struct folio *folio = virt_to_folio(ser);
+
+	WARN_ON_ONCE(ser->nr_devices);
+	kho_unpreserve_folio(folio);
+	folio_put(folio);
+}
+
+static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
+{
+	struct folio *folio;
+
+	folio = kho_restore_folio(args->data);
+	if (!folio)
+		panic("Unable to restore preserved FLB data from KHO (0x%llx)\n", args->data);
+
+	args->obj = folio_address(folio);
+	return 0;
+}
+
+static void pci_flb_finish(struct liveupdate_flb_op_args *args)
+{
+	struct pci_ser *ser = args->obj;
+
+	/*
+	 * Sanity check that all devices have been finished via
+	 * pci_liveupdate_incoming_finish().
+	 */
+	WARN_ON_ONCE(ser->nr_devices);
+	folio_put(virt_to_folio(ser));
+}
+
+static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
+	.preserve = pci_flb_preserve,
+	.unpreserve = pci_flb_unpreserve,
+	.retrieve = pci_flb_retrieve,
+	.finish = pci_flb_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_flb pci_liveupdate_flb = {
+	.ops = &pci_liveupdate_flb_ops,
+	.compatible = PCI_LUO_FLB_COMPATIBLE,
+};
+
+#define INIT_PCI_DEV_SER(_dev) {		\
+	.domain = pci_domain_nr((_dev)->bus),	\
+	.bdf = pci_dev_id(_dev),		\
+}
+
+static int pci_dev_ser_cmp(const void *__a, const void *__b)
+{
+	const struct pci_dev_ser *a = __a, *b = __b;
+
+	return cmp_int(a->domain << 16 | a->bdf, b->domain << 16 | b->bdf);
+}
+
+static struct pci_dev_ser *pci_ser_find(struct pci_ser *ser, struct pci_dev *dev)
+{
+	const struct pci_dev_ser key = INIT_PCI_DEV_SER(dev);
+
+	return bsearch(&key, ser->devices, ser->nr_devices,
+		       sizeof(key), pci_dev_ser_cmp);
+}
+
+static int pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+	int i;
+
+	dev_ser = pci_ser_find(ser, dev);
+	if (!dev_ser)
+		return -ENOENT;
+
+	for (i = dev_ser - ser->devices; i < ser->nr_devices - 1; i++)
+		ser->devices[i] = ser->devices[i + 1];
+
+	ser->nr_devices--;
+	return 0;
+}
+
+static int max_nr_devices(struct pci_ser *ser)
+{
+	u64 size;
+
+	size = folio_size(virt_to_folio(ser));
+	size -= offsetof(struct pci_ser, devices);
+
+	return size / sizeof(struct pci_dev_ser);
+}
+
+int pci_liveupdate_outgoing_preserve(struct pci_dev *dev)
+{
+	struct pci_dev_ser new = INIT_PCI_DEV_SER(dev);
+	struct pci_ser *ser;
+	int i, ret;
+
+	/* VFs are not supported yet due to BDF instability across kexec */
+	if (dev->is_virtfn)
+		return -EINVAL;
+
+	guard(mutex)(&pci_flb_outgoing_lock);
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
+	if (ret)
+		return ret;
+
+	if (ser->nr_devices == max_nr_devices(ser))
+		return -E2BIG;
+
+	for (i = ser->nr_devices; i > 0; i--) {
+		struct pci_dev_ser *prev = &ser->devices[i - 1];
+		int cmp = pci_dev_ser_cmp(&new, prev);
+
+		/* This device is already preserved. */
+		if (cmp == 0)
+			return 0;
+
+		if (cmp > 0)
+			break;
+
+		ser->devices[i] = *prev;
+	}
+
+	ser->devices[i] = new;
+	ser->nr_devices++;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_outgoing_preserve);
+
+void pci_liveupdate_outgoing_unpreserve(struct pci_dev *dev)
+{
+	struct pci_ser *ser;
+	int ret;
+
+	guard(mutex)(&pci_flb_outgoing_lock);
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
+	if (WARN_ON_ONCE(ret))
+		return;
+
+	WARN_ON_ONCE(pci_ser_delete(ser, dev));
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_outgoing_unpreserve);
+
+bool pci_liveupdate_incoming_is_preserved(struct pci_dev *dev)
+{
+	struct pci_ser *ser;
+	int ret;
+
+	guard(mutex)(&pci_flb_incoming_lock);
+
+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&ser);
+	if (ret)
+		return false;
+
+	return pci_ser_find(ser, dev);
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_incoming_is_preserved);
+
+void pci_liveupdate_incoming_finish(struct pci_dev *dev)
+{
+	struct pci_ser *ser;
+	int ret;
+
+	guard(mutex)(&pci_flb_incoming_lock);
+
+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&ser);
+	if (WARN_ON_ONCE(ret))
+		return;
+
+	WARN_ON_ONCE(pci_ser_delete(ser, dev));
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_incoming_finish);
+
+int pci_liveupdate_register_fh(struct liveupdate_file_handler *fh)
+{
+	return liveupdate_register_flb(fh, &pci_liveupdate_flb);
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_register_fh);
+
+int pci_liveupdate_unregister_fh(struct liveupdate_file_handler *fh)
+{
+	return liveupdate_unregister_flb(fh, &pci_liveupdate_flb);
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unregister_fh);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
new file mode 100644
index 000000000000..53744b6f191a
--- /dev/null
+++ b/include/linux/kho/abi/pci.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * David Matlack <dmatlack@google.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_PCI_H
+#define _LINUX_KHO_ABI_PCI_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/**
+ * DOC: PCI File-Lifecycle Bound (FLB) Live Update ABI
+ *
+ * This header defines the ABI for preserving core PCI state across kexec using
+ * Live Update File-Lifecycle Bound (FLB) data.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
+ */
+
+#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
+
+/**
+ * struct pci_dev_ser - Serialized state about a single PCI device.
+ *
+ * @domain: The device's PCI domain number (segment).
+ * @bdf: The device's PCI bus, device, and function number.
+ */
+struct pci_dev_ser {
+	u16 domain;
+	u16 bdf;
+} __packed;
+
+/**
+ * struct pci_ser - PCI Subsystem Live Update State
+ *
+ * This struct tracks state about all devices that are being preserved across
+ * a Live Update for the next kernel.
+ *
+ * @nr_devices: The number of devices that were preserved.
+ * @devices: Flexible array of pci_dev_ser structs for each device. Guaranteed
+ *           to be sorted ascending by domain and bdf.
+ */
+struct pci_ser {
+	u64 nr_devices;
+	struct pci_dev_ser devices[];
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..6a3c2d7e5b82 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -40,6 +40,7 @@
 #include <linux/resource_ext.h>
 #include <linux/msi_api.h>
 #include <uapi/linux/pci.h>
+#include <linux/liveupdate.h>
 
 #include <linux/pci_ids.h>
 
@@ -2795,4 +2796,41 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 	WARN_ONCE(condition, "%s %s: " fmt, \
 		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
 
+#ifdef CONFIG_LIVEUPDATE
+int pci_liveupdate_outgoing_preserve(struct pci_dev *dev);
+void pci_liveupdate_outgoing_unpreserve(struct pci_dev *dev);
+bool pci_liveupdate_incoming_is_preserved(struct pci_dev *dev);
+void pci_liveupdate_incoming_finish(struct pci_dev *dev);
+int pci_liveupdate_register_fh(struct liveupdate_file_handler *fh);
+int pci_liveupdate_unregister_fh(struct liveupdate_file_handler *fh);
+#else /* !CONFIG_LIVEUPDATE */
+static inline int pci_liveupdate_outgoing_preserve(struct pci_dev *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void pci_liveupdate_outgoing_unpreserve(struct pci_dev *dev)
+{
+}
+
+static inline bool pci_liveupdate_incoming_is_preserved(struct pci_dev *dev)
+{
+	return false;
+}
+
+static inline void pci_liveupdate_incoming_finish(struct pci_dev *dev)
+{
+}
+
+static inline int pci_liveupdate_register_fh(struct liveupdate_file_handler *fh)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pci_liveupdate_unregister_fh(struct liveupdate_file_handler *fh)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* !CONFIG_LIVEUPDATE */
+
 #endif /* LINUX_PCI_H */
-- 
2.52.0.487.g5c8c507ade-goog


