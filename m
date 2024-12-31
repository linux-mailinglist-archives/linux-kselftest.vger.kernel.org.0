Return-Path: <linux-kselftest+bounces-23794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0819FEF8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 14:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A296162326
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Dec 2024 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A419D8BC;
	Tue, 31 Dec 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQOiYo0m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027C19DFAB
	for <linux-kselftest@vger.kernel.org>; Tue, 31 Dec 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735650849; cv=none; b=uRpMaY3fla1v0QNHVgPSiyhpRtJLchMb14RCB7CmQUejGPhk0uQk/CMeZe/k4JPTEXEsmbfvgpGfc6gnq+zh3XK058+O5Jgmrkm8XAqdYEKsAmi+kKhdJCdzb0U+kpLHUUtR1pDYiKuW3p/DUq3VNy2ohXvTuLr6WE4bbpRRgOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735650849; c=relaxed/simple;
	bh=U3HDpSOkIyj5jf5LHiGBdv7xQlti5+az5Yogwm2eR8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTVBf5481c1lKpWfm1Cs6sieXCYk/ODqtGtXCUqlmFQxIt08Wl5JtV32AxP5nbeRG+CSEvIfKPYTzazoMLTU486h3pPhsdcQwq6B0l6d77jzposEPaTQhQv8+jw+ZEYQ7PsS1daT/1WJlaZluQRd2Bdatu/bKhfDb6OcExktm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQOiYo0m; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21631789fcdso100196395ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Dec 2024 05:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735650845; x=1736255645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rcGi5mP1INqcgXesezoYqLasiWddJIAK3AnibkerbU=;
        b=gQOiYo0mGlAJUWYitBjAAndg7eaL2DLgaSjjxd8WZP5FPYVhvKZrY22E6vSO0WcO9H
         8o/cDOs879hVEGLT9BGYlhB/imUSxSq0hEoPJ/UI40Aaw/HckrwOIoZzDwWU6HIPnCK+
         /5bTrjYJE3bSlbjFTn0YF1VcGb16xMbRz4H20oTu90rBhQsIMSHUmXsyhT10T7QoOBhi
         zI7Hqx97zcCHnWgd+Tw5JpbEkAqNmyXcRWvcInbowmxGYqiBIiN+cs4nwLlQQeshl+BU
         6QifgnAulAi9kOmexslJ12eKSm5XdanhTehUMmcc5VUoT9S9NHCDQEpmgo40NQJKBRIa
         XM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735650845; x=1736255645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rcGi5mP1INqcgXesezoYqLasiWddJIAK3AnibkerbU=;
        b=NNsWWdt+3K8PiHpAN/miOnM0cpYJ+Nd1LbElwIF9Zu17oUiqHIhWz+J099u4C++cgX
         rQMcxCQ8DdeGtcnlJhNSWrgnPvhJ+C8LsT7Z4tCu01scDgdvKWgYHat932Aqwvsq5sx1
         PlCRATNUlM+GJVCbzE4dB04yfnWbwWKAynqywtuwQMzJ4zTQ0/dUchk3G+lmsxNsCIfB
         PYgfQG2nSpz7A6z1OftQ1C7tpbl7cOjmt5DwGeDwpZL7z8j+yNqpiDpspDthmMCZyHTs
         ac/YktfOBEcPIe3Maol9F9LWTjeWY1SEl6Pa2i71MAaYqc1BzJwzblpLH5Mz30iPifpj
         hKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFoMayJzDvOxRZpTFq2ZkUloIE7ocfVyDNiIeoExVHha3JHzANv1sUNjI+EqD036oHZWPMYHfHrnY6FiZ4Q/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxILS4N57/dSlcLPEV5D7H4qmbLpkAchwjm9W+6msc3UkfQGEjS
	5a2FuDkRdTzUYBc898lNPyf9Pp++lOIagzZxeBOxecxy9l+4ltXP5aTW5Ow0SQ==
X-Gm-Gg: ASbGncuv4bc8911dXtzQ8R80WOKd+I7YD8b/fCcXtFsfwzWt2oS+D+ye/kaJdC0TyzY
	g9Vrfw3KIUj2rcGDKL480IP8cVDiZbaUSYbyovyJU8UqGOl62htnrgJQ9oTxa361JkwDGLmdPgW
	vUF/c09V4VS6/ZRfg0U0Z7Ir3EOcHNGMwkI2VDQ9ScGYtPUHaiBoXBp95rytmWb0APEDp4mB2PE
	h9/XWvWRMLBHiRhbYDmAv+O+nxTsXhJUIc88++H8v8cVaBM8IeSDShqT2NdT9o+aANd0RhmbBlX
	WrocQNwBhZs=
X-Google-Smtp-Source: AGHT+IEGf9S1NGUPbJuY2+vQG7UeSYriIH5ounufSgRn6Etu3fZUfal1eLIkxsDfxcmUiJvk/0NNKw==
X-Received: by 2002:a05:6a20:8412:b0:1e0:c166:18ba with SMTP id adf61e73a8af0-1e5e1e74cf8mr54825008637.12.1735650844755;
        Tue, 31 Dec 2024 05:14:04 -0800 (PST)
Received: from localhost.localdomain ([117.193.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad6cc885sm20994862b3a.0.2024.12.31.05.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 05:14:04 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v4 1/3] misc: pci_endpoint_test: Fix the return value of IOCTL
Date: Tue, 31 Dec 2024 18:43:39 +0530
Message-Id: <20241231131341.39292-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOCTLs are supposed to return 0 for success and negative error codes for
failure. Currently, this driver is returning 0 for failure and 1 for
success, that's not correct. Hence, fix it!

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Closes: https://lore.kernel.org/all/YvzNg5ROnxEApDgS@kroah.com
Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/misc/pci_endpoint_test.c | 250 +++++++++++++++----------------
 tools/pci/pcitest.c              |  51 +++----
 2 files changed, 148 insertions(+), 153 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 5c99da952b7a..7d3f78b6f854 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -169,43 +169,47 @@ static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
 	test->irq_type = IRQ_TYPE_UNDEFINED;
 }
 
-static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
+static int pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
 						int type)
 {
-	int irq = -1;
+	int irq;
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
-	bool res = true;
 
 	switch (type) {
 	case IRQ_TYPE_INTX:
 		irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
-		if (irq < 0)
+		if (irq < 0) {
 			dev_err(dev, "Failed to get Legacy interrupt\n");
+			return -ENOSPC;
+		}
+
 		break;
 	case IRQ_TYPE_MSI:
 		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
-		if (irq < 0)
+		if (irq < 0) {
 			dev_err(dev, "Failed to get MSI interrupts\n");
+			return -ENOSPC;
+		}
+
 		break;
 	case IRQ_TYPE_MSIX:
 		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
-		if (irq < 0)
+		if (irq < 0) {
 			dev_err(dev, "Failed to get MSI-X interrupts\n");
+			return -ENOSPC;
+		}
+
 		break;
 	default:
 		dev_err(dev, "Invalid IRQ type selected\n");
-	}
-
-	if (irq < 0) {
-		irq = 0;
-		res = false;
+		return -EINVAL;
 	}
 
 	test->irq_type = type;
 	test->num_irqs = irq;
 
-	return res;
+	return 0;
 }
 
 static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
@@ -220,22 +224,22 @@ static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
 	test->num_irqs = 0;
 }
 
-static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
+static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 {
 	int i;
-	int err;
+	int ret;
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
 
 	for (i = 0; i < test->num_irqs; i++) {
-		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
+		ret = devm_request_irq(dev, pci_irq_vector(pdev, i),
 				       pci_endpoint_test_irqhandler,
 				       IRQF_SHARED, test->name, test);
-		if (err)
+		if (ret)
 			goto fail;
 	}
 
-	return true;
+	return 0;
 
 fail:
 	switch (irq_type) {
@@ -255,7 +259,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 		break;
 	}
 
-	return false;
+	return ret;
 }
 
 static const u32 bar_test_pattern[] = {
@@ -280,7 +284,7 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
 	return memcmp(write_buf, read_buf, size);
 }
 
-static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
+static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
 				  enum pci_barno barno)
 {
 	int j, bar_size, buf_size, iters, remain;
@@ -289,7 +293,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	struct pci_dev *pdev = test->pdev;
 
 	if (!test->bar[barno])
-		return false;
+		return -ENOMEM;
 
 	bar_size = pci_resource_len(pdev, barno);
 
@@ -304,25 +308,25 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
 
 	write_buf = kmalloc(buf_size, GFP_KERNEL);
 	if (!write_buf)
-		return false;
+		return -ENOMEM;
 
 	read_buf = kmalloc(buf_size, GFP_KERNEL);
 	if (!read_buf)
-		return false;
+		return -ENOMEM;
 
 	iters = bar_size / buf_size;
 	for (j = 0; j < iters; j++)
 		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
 						 write_buf, read_buf, buf_size))
-			return false;
+			return -EIO;
 
 	remain = bar_size % buf_size;
 	if (remain)
 		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
 						 write_buf, read_buf, remain))
-			return false;
+			return -EIO;
 
-	return true;
+	return 0;
 }
 
 static u32 bar_test_pattern_with_offset(enum pci_barno barno, int offset)
@@ -337,7 +341,7 @@ static u32 bar_test_pattern_with_offset(enum pci_barno barno, int offset)
 	return val;
 }
 
-static bool pci_endpoint_test_bars_write_bar(struct pci_endpoint_test *test,
+static void pci_endpoint_test_bars_write_bar(struct pci_endpoint_test *test,
 					     enum pci_barno barno)
 {
 	struct pci_dev *pdev = test->pdev;
@@ -351,11 +355,9 @@ static bool pci_endpoint_test_bars_write_bar(struct pci_endpoint_test *test,
 	for (j = 0; j < size; j += 4)
 		writel_relaxed(bar_test_pattern_with_offset(barno, j),
 			       test->bar[barno] + j);
-
-	return true;
 }
 
-static bool pci_endpoint_test_bars_read_bar(struct pci_endpoint_test *test,
+static int pci_endpoint_test_bars_read_bar(struct pci_endpoint_test *test,
 					    enum pci_barno barno)
 {
 	struct pci_dev *pdev = test->pdev;
@@ -376,14 +378,14 @@ static bool pci_endpoint_test_bars_read_bar(struct pci_endpoint_test *test,
 			dev_err(dev,
 				"BAR%d incorrect data at offset: %#x, got: %#x expected: %#x\n",
 				barno, j, val, expected);
-			return false;
+			return -EIO;
 		}
 	}
 
-	return true;
+	return 0;
 }
 
-static bool pci_endpoint_test_bars(struct pci_endpoint_test *test)
+static int pci_endpoint_test_bars(struct pci_endpoint_test *test)
 {
 	enum pci_barno bar;
 	bool ret;
@@ -407,10 +409,10 @@ static bool pci_endpoint_test_bars(struct pci_endpoint_test *test)
 		}
 	}
 
-	return true;
+	return 0;
 }
 
-static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
+static int pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
 {
 	u32 val;
 
@@ -422,12 +424,12 @@ static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
-		return false;
+		return -ETIMEDOUT;
 
-	return true;
+	return 0;
 }
 
-static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
+static int pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 				       u16 msi_num, bool msix)
 {
 	u32 val;
@@ -442,9 +444,12 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	val = wait_for_completion_timeout(&test->irq_raised,
 					  msecs_to_jiffies(1000));
 	if (!val)
-		return false;
+		return -ETIMEDOUT;
 
-	return pci_irq_vector(pdev, msi_num - 1) == test->last_irq;
+	if (!(pci_irq_vector(pdev, msi_num - 1) == test->last_irq))
+		return -EIO;
+
+	return 0;
 }
 
 static int pci_endpoint_test_validate_xfer_params(struct device *dev,
@@ -463,11 +468,10 @@ static int pci_endpoint_test_validate_xfer_params(struct device *dev,
 	return 0;
 }
 
-static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
+static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
 	struct pci_endpoint_test_xfer_param param;
-	bool ret = false;
 	void *src_addr;
 	void *dst_addr;
 	u32 flags = 0;
@@ -486,17 +490,17 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	int irq_type = test->irq_type;
 	u32 src_crc32;
 	u32 dst_crc32;
-	int err;
+	int ret;
 
-	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
-	if (err) {
+	ret = copy_from_user(&param, (void __user *)arg, sizeof(param));
+	if (ret) {
 		dev_err(dev, "Failed to get transfer param\n");
-		return false;
+		return -EFAULT;
 	}
 
-	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
-	if (err)
-		return false;
+	ret = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (ret)
+		return ret;
 
 	size = param.size;
 
@@ -506,22 +510,21 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 
 	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
+		return -EINVAL;
 	}
 
 	orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_src_addr) {
 		dev_err(dev, "Failed to allocate source buffer\n");
-		ret = false;
-		goto err;
+		return -ENOMEM;
 	}
 
 	get_random_bytes(orig_src_addr, size + alignment);
 	orig_src_phys_addr = dma_map_single(dev, orig_src_addr,
 					    size + alignment, DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, orig_src_phys_addr)) {
+	ret = dma_mapping_error(dev, orig_src_phys_addr);
+	if (ret) {
 		dev_err(dev, "failed to map source buffer address\n");
-		ret = false;
 		goto err_src_phys_addr;
 	}
 
@@ -545,15 +548,15 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	orig_dst_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_dst_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
-		ret = false;
+		ret = -ENOMEM;
 		goto err_dst_addr;
 	}
 
 	orig_dst_phys_addr = dma_map_single(dev, orig_dst_addr,
 					    size + alignment, DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, orig_dst_phys_addr)) {
+	ret = dma_mapping_error(dev, orig_dst_phys_addr);
+	if (ret) {
 		dev_err(dev, "failed to map destination buffer address\n");
-		ret = false;
 		goto err_dst_phys_addr;
 	}
 
@@ -586,8 +589,8 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 			 DMA_FROM_DEVICE);
 
 	dst_crc32 = crc32_le(~0, dst_addr, size);
-	if (dst_crc32 == src_crc32)
-		ret = true;
+	if (dst_crc32 != src_crc32)
+		ret = -EIO;
 
 err_dst_phys_addr:
 	kfree(orig_dst_addr);
@@ -598,16 +601,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
 
 err_src_phys_addr:
 	kfree(orig_src_addr);
-
-err:
 	return ret;
 }
 
-static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
+static int pci_endpoint_test_write(struct pci_endpoint_test *test,
 				    unsigned long arg)
 {
 	struct pci_endpoint_test_xfer_param param;
-	bool ret = false;
 	u32 flags = 0;
 	bool use_dma;
 	u32 reg;
@@ -622,17 +622,17 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	int irq_type = test->irq_type;
 	size_t size;
 	u32 crc32;
-	int err;
+	int ret;
 
-	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
-	if (err != 0) {
+	ret = copy_from_user(&param, (void __user *)arg, sizeof(param));
+	if (ret) {
 		dev_err(dev, "Failed to get transfer param\n");
-		return false;
+		return -EFAULT;
 	}
 
-	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
-	if (err)
-		return false;
+	ret = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (ret)
+		return ret;
 
 	size = param.size;
 
@@ -642,23 +642,22 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 
 	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
+		return -EINVAL;
 	}
 
 	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate address\n");
-		ret = false;
-		goto err;
+		return -ENOMEM;
 	}
 
 	get_random_bytes(orig_addr, size + alignment);
 
 	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
 					DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, orig_phys_addr)) {
+	ret = dma_mapping_error(dev, orig_phys_addr);
+	if (ret) {
 		dev_err(dev, "failed to map source buffer address\n");
-		ret = false;
 		goto err_phys_addr;
 	}
 
@@ -691,24 +690,21 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 	wait_for_completion(&test->irq_raised);
 
 	reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
-	if (reg & STATUS_READ_SUCCESS)
-		ret = true;
+	if (!(reg & STATUS_READ_SUCCESS))
+		ret = -EIO;
 
 	dma_unmap_single(dev, orig_phys_addr, size + alignment,
 			 DMA_TO_DEVICE);
 
 err_phys_addr:
 	kfree(orig_addr);
-
-err:
 	return ret;
 }
 
-static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
+static int pci_endpoint_test_read(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
 	struct pci_endpoint_test_xfer_param param;
-	bool ret = false;
 	u32 flags = 0;
 	bool use_dma;
 	size_t size;
@@ -722,17 +718,17 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 	size_t alignment = test->alignment;
 	int irq_type = test->irq_type;
 	u32 crc32;
-	int err;
+	int ret;
 
-	err = copy_from_user(&param, (void __user *)arg, sizeof(param));
-	if (err) {
+	ret = copy_from_user(&param, (void __user *)arg, sizeof(param));
+	if (ret) {
 		dev_err(dev, "Failed to get transfer param\n");
-		return false;
+		return -EFAULT;
 	}
 
-	err = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
-	if (err)
-		return false;
+	ret = pci_endpoint_test_validate_xfer_params(dev, &param, alignment);
+	if (ret)
+		return ret;
 
 	size = param.size;
 
@@ -742,21 +738,20 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 
 	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
+		return -EINVAL;
 	}
 
 	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
-		ret = false;
-		goto err;
+		return -ENOMEM;
 	}
 
 	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
 					DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, orig_phys_addr)) {
+	ret = dma_mapping_error(dev, orig_phys_addr);
+	if (ret) {
 		dev_err(dev, "failed to map source buffer address\n");
-		ret = false;
 		goto err_phys_addr;
 	}
 
@@ -788,50 +783,51 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 			 DMA_FROM_DEVICE);
 
 	crc32 = crc32_le(~0, addr, size);
-	if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
-		ret = true;
+	if (crc32 != pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
+		ret = -EIO;
 
 err_phys_addr:
 	kfree(orig_addr);
-err:
 	return ret;
 }
 
-static bool pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
+static int pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
 {
 	pci_endpoint_test_release_irq(test);
 	pci_endpoint_test_free_irq_vectors(test);
-	return true;
+
+	return 0;
 }
 
-static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
+static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 				      int req_irq_type)
 {
 	struct pci_dev *pdev = test->pdev;
 	struct device *dev = &pdev->dev;
+	int ret;
 
 	if (req_irq_type < IRQ_TYPE_INTX || req_irq_type > IRQ_TYPE_MSIX) {
 		dev_err(dev, "Invalid IRQ type option\n");
-		return false;
+		return -EINVAL;
 	}
 
 	if (test->irq_type == req_irq_type)
-		return true;
+		return 0;
 
 	pci_endpoint_test_release_irq(test);
 	pci_endpoint_test_free_irq_vectors(test);
 
-	if (!pci_endpoint_test_alloc_irq_vectors(test, req_irq_type))
-		goto err;
+	ret = pci_endpoint_test_alloc_irq_vectors(test, req_irq_type);
+	if (ret)
+		return ret;
 
-	if (!pci_endpoint_test_request_irq(test))
-		goto err;
-
-	return true;
+	ret = pci_endpoint_test_request_irq(test);
+	if (ret) {
+		pci_endpoint_test_free_irq_vectors(test);
+		return ret;
+	}
 
-err:
-	pci_endpoint_test_free_irq_vectors(test);
-	return false;
+	return 0;
 }
 
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
@@ -913,7 +909,7 @@ static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
 static int pci_endpoint_test_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
-	int err;
+	int ret;
 	int id;
 	char name[24];
 	enum pci_barno bar;
@@ -952,24 +948,23 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 
-	err = pci_enable_device(pdev);
-	if (err) {
+	ret = pci_enable_device(pdev);
+	if (ret) {
 		dev_err(dev, "Cannot enable PCI device\n");
-		return err;
+		return ret;
 	}
 
-	err = pci_request_regions(pdev, DRV_MODULE_NAME);
-	if (err) {
+	ret = pci_request_regions(pdev, DRV_MODULE_NAME);
+	if (ret) {
 		dev_err(dev, "Cannot obtain PCI resources\n");
 		goto err_disable_pdev;
 	}
 
 	pci_set_master(pdev);
 
-	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type)) {
-		err = -EINVAL;
+	ret = pci_endpoint_test_alloc_irq_vectors(test, irq_type);
+	if (ret)
 		goto err_disable_irq;
-	}
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
@@ -984,7 +979,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	test->base = test->bar[test_reg_bar];
 	if (!test->base) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		dev_err(dev, "Cannot perform PCI test without BAR%d\n",
 			test_reg_bar);
 		goto err_iounmap;
@@ -994,7 +989,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	id = ida_alloc(&pci_endpoint_test_ida, GFP_KERNEL);
 	if (id < 0) {
-		err = id;
+		ret = id;
 		dev_err(dev, "Unable to get id\n");
 		goto err_iounmap;
 	}
@@ -1002,14 +997,13 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
 	test->name = kstrdup(name, GFP_KERNEL);
 	if (!test->name) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto err_ida_remove;
 	}
 
-	if (!pci_endpoint_test_request_irq(test)) {
-		err = -EINVAL;
+	ret = pci_endpoint_test_request_irq(test);
+	if (ret)
 		goto err_kfree_test_name;
-	}
 
 	pci_endpoint_test_get_capabilities(test);
 
@@ -1017,14 +1011,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	misc_device->minor = MISC_DYNAMIC_MINOR;
 	misc_device->name = kstrdup(name, GFP_KERNEL);
 	if (!misc_device->name) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto err_release_irq;
 	}
 	misc_device->parent = &pdev->dev;
 	misc_device->fops = &pci_endpoint_test_fops;
 
-	err = misc_register(misc_device);
-	if (err) {
+	ret = misc_register(misc_device);
+	if (ret) {
 		dev_err(dev, "Failed to register device\n");
 		goto err_kfree_name;
 	}
@@ -1056,7 +1050,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 err_disable_pdev:
 	pci_disable_device(pdev);
 
-	return err;
+	return ret;
 }
 
 static void pci_endpoint_test_remove(struct pci_dev *pdev)
diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 08f355083754..b96cc118839b 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -16,7 +16,6 @@
 
 #include <linux/pcitest.h>
 
-static char *result[] = { "NOT OKAY", "OKAY" };
 static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
 
 struct pci_test {
@@ -53,72 +52,74 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_BAR, test->barnum);
 		fprintf(stdout, "BAR%d:\t\t", test->barnum);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "NOT OKAY\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "OKAY\n");
 	}
 
 	if (test->consecutive_bar_test) {
 		ret = ioctl(fd, PCITEST_BARS);
 		fprintf(stdout, "Consecutive BAR test:\t\t");
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "NOT OKAY\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "OKAY\n");
 	}
 
 	if (test->set_irqtype) {
 		ret = ioctl(fd, PCITEST_SET_IRQTYPE, test->irqtype);
 		fprintf(stdout, "SET IRQ TYPE TO %s:\t\t", irq[test->irqtype]);
 		if (ret < 0)
-			fprintf(stdout, "FAILED\n");
+			fprintf(stdout, "NOT OKAY\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "OKAY\n");
 	}
 
 	if (test->get_irqtype) {
 		ret = ioctl(fd, PCITEST_GET_IRQTYPE);
 		fprintf(stdout, "GET IRQ TYPE:\t\t");
-		if (ret < 0)
-			fprintf(stdout, "FAILED\n");
-		else
+		if (ret < 0) {
+			fprintf(stdout, "NOT OKAY\n");
+		} else {
 			fprintf(stdout, "%s\n", irq[ret]);
+			ret = 0;
+		}
 	}
 
 	if (test->clear_irq) {
 		ret = ioctl(fd, PCITEST_CLEAR_IRQ);
 		fprintf(stdout, "CLEAR IRQ:\t\t");
 		if (ret < 0)
-			fprintf(stdout, "FAILED\n");
+			fprintf(stdout, "NOT OKAY\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "OKAY\n");
 	}
 
 	if (test->legacyirq) {
 		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
 		fprintf(stdout, "LEGACY IRQ:\t");
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "NOT OKAY\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "OKAY\n");
 	}
 
 	if (test->msinum > 0 && test->msinum <= 32) {
 		ret = ioctl(fd, PCITEST_MSI, test->msinum);
 		fprintf(stdout, "MSI%u:\t\t", test->msinum);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "NOT OKAY\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "OKAY\n");
 	}
 
 	if (test->msixnum > 0 && test->msixnum <= 2048) {
 		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
 		fprintf(stdout, "MSI-X%u:\t\t", test->msixnum);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "NOT OKAY\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "OKAY\n");
 	}
 
 	if (test->write) {
@@ -128,9 +129,9 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_WRITE, &param);
 		fprintf(stdout, "WRITE (%7lu bytes):\t\t", test->size);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "NOT OKAY\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "OKAY\n");
 	}
 
 	if (test->read) {
@@ -140,9 +141,9 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_READ, &param);
 		fprintf(stdout, "READ (%7lu bytes):\t\t", test->size);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "NOT OKAY\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "OKAY\n");
 	}
 
 	if (test->copy) {
@@ -152,14 +153,14 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_COPY, &param);
 		fprintf(stdout, "COPY (%7lu bytes):\t\t", test->size);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "NOT OKAY\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "OKAY\n");
 	}
 
 	fflush(stdout);
 	close(fd);
-	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
+	return ret;
 }
 
 int main(int argc, char **argv)
-- 
2.25.1


