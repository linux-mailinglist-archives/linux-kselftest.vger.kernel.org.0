Return-Path: <linux-kselftest+bounces-27436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F4A43CCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFD7188E867
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517026D5C3;
	Tue, 25 Feb 2025 11:03:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475EF26BD90;
	Tue, 25 Feb 2025 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481394; cv=none; b=tm9CMiJxFHJL5ltftwui+Ej8qGJXeucvbL/6nU0/kS33dwML8MwvMxZZTYeVmQtIVAfvxDqckR5/9c4EjZvEszVXMi+pnNBBG3n2jsKcQnj0kvs0NiA4Pup90j9RVYlF5zLJm0LhJepVH367kXBtUnZR9UfTKuwEKSzHdlEZDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481394; c=relaxed/simple;
	bh=6iSypD6wLS9nPcxoTvkQ3A8LRGjbcu+KLJKPW1wXo+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cn70VtwhP357iHd6PwVWnvHq4sBM6qLwYZNiDVaGEIsLBe99mqwexcmCbuAAARf+DCAyrNZQ7vDoqijF7oAlvWNNAwtxzX8kfqp+GKRpZP3T14w8n/rkxfZdgN9nr2+t7AeMBy48TQBtF/0t5HLrte6bhWrsu+U975pghWfLrSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Feb 2025 20:03:02 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id E028020090C2;
	Tue, 25 Feb 2025 20:03:02 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 25 Feb 2025 20:03:02 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 8F77E3730;
	Tue, 25 Feb 2025 20:03:02 +0900 (JST)
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
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 6/6] misc: pci_endpoint_test: Do not use managed irq functions
Date: Tue, 25 Feb 2025 20:02:52 +0900
Message-Id: <20250225110252.28866-7-hayashi.kunihiko@socionext.com>
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

The pci_endpoint_test_request_irq() and pci_endpoint_test_release_irq()
are called repeatedly by the users through pci_endpoint_test_set_irq().
So using the managed version of IRQ functions within these functions
has no effect.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 326e8e467c42..7a14114488a0 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -208,10 +208,9 @@ static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
 {
 	int i;
 	struct pci_dev *pdev = test->pdev;
-	struct device *dev = &pdev->dev;
 
 	for (i = 0; i < test->num_irqs; i++)
-		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
+		free_irq(pci_irq_vector(pdev, i), test);
 
 	test->num_irqs = 0;
 }
@@ -224,9 +223,9 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 	struct device *dev = &pdev->dev;
 
 	for (i = 0; i < test->num_irqs; i++) {
-		ret = devm_request_irq(dev, pci_irq_vector(pdev, i),
-				       pci_endpoint_test_irqhandler,
-				       IRQF_SHARED, test->name, test);
+		ret = request_irq(pci_irq_vector(pdev, i),
+				  pci_endpoint_test_irqhandler, IRQF_SHARED,
+				  test->name, test);
 		if (ret)
 			goto fail;
 	}
-- 
2.25.1


