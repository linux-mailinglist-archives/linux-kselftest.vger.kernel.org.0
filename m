Return-Path: <linux-kselftest+bounces-27437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE89BA43CCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1A9188C985
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B526D5CA;
	Tue, 25 Feb 2025 11:03:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433ED26BD8E;
	Tue, 25 Feb 2025 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481394; cv=none; b=oCqggOeZQnEeAtpztQ9OZCVe7F0G8BVPkfJvaKGpJrJgZP/C5OVpAj9qQdFcbTd7Seb46HLfYJZwp3Y7cw6oF+QoPlSaEGypy+5qMx2C1UB13uqkJEnIrkafJ6bKfjnw3PSO9y31JfwJyZh0Uwfif3qABJzO4OO8Bl13s5a7fSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481394; c=relaxed/simple;
	bh=uEsiEGHaHke/4tfjo3VLmvcu2GBxaaWlzBt3ZRofxRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiFNF7d3ImIC1F1jPoPJ4pyoi3faBAQDZF/ZClKxFaz2LzzDNe3gP+oWLlQ2Qu3y6pNkAa5dYKUDNDPsr9gzpXkofYUjr/CRSXfCjlRu2cU0IKCHYxEq+WeialYvNzgQpLzCcc2uKR0MmSACMtE7cZ4hx/LSwIGgqTeUXGjyppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Feb 2025 20:03:02 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 64C3920AE2B4;
	Tue, 25 Feb 2025 20:03:02 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 25 Feb 2025 20:03:02 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id D67703730;
	Tue, 25 Feb 2025 20:03:01 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Krzysztof Wilczynski" <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 5/6] misc: pci_endpoint_test: Remove global 'irq_type' and 'no_msi'
Date: Tue, 25 Feb 2025 20:02:51 +0900
Message-Id: <20250225110252.28866-6-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
References: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable "irq_type" preserves the current value of
ioctl(GET_IRQTYPE).

However, all tests that use interrupts first call ioctl(SET_IRQTYPE)
to set test->irq_type, then write the value of test->irq_type into the
register pointed by test_reg_bar, and request the interrupt to the
endpoint. The endpoint function driver, pci-epf-test, refers to the
register, and determine which type of interrupt to raise.

The global variable "irq_type" is never used in the actual test,
so remove the variable and replace it with test->irq_type.

And also for the same reason, the variable "no_msi" can be removed.

Initially, test->irq_type has IRQ_TYPE_UNDEFINED, and the
ioctl(GET_IRQTYPE) before calling ioctl(SET_IRQTYPE) will return an error.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 896392c428de..326e8e467c42 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -96,14 +96,6 @@ static DEFINE_IDA(pci_endpoint_test_ida);
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
 					    miscdev)
 
-static bool no_msi;
-module_param(no_msi, bool, 0444);
-MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
-
-static int irq_type = IRQ_TYPE_MSI;
-module_param(irq_type, int, 0444);
-MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI, 2 - MSI-X)");
-
 enum pci_barno {
 	BAR_0,
 	BAR_1,
@@ -833,7 +825,6 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 		return ret;
 	}
 
-	irq_type = test->irq_type;
 	return 0;
 }
 
@@ -882,7 +873,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 		ret = pci_endpoint_test_set_irq(test, arg);
 		break;
 	case PCITEST_GET_IRQTYPE:
-		ret = irq_type;
+		ret = test->irq_type;
 		break;
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
@@ -939,15 +930,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	test->pdev = pdev;
 	test->irq_type = IRQ_TYPE_UNDEFINED;
 
-	if (no_msi)
-		irq_type = IRQ_TYPE_INTX;
-
 	data = (struct pci_endpoint_test_data *)ent->driver_data;
 	if (data) {
 		test_reg_bar = data->test_reg_bar;
 		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
-		irq_type = data->irq_type;
+		test->irq_type = data->irq_type;
 	}
 
 	init_completion(&test->irq_raised);
@@ -969,7 +957,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	ret = pci_endpoint_test_alloc_irq_vectors(test, irq_type);
+	ret = pci_endpoint_test_alloc_irq_vectors(test, test->irq_type);
 	if (ret)
 		goto err_disable_irq;
 
-- 
2.25.1


