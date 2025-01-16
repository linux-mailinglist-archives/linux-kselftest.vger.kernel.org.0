Return-Path: <linux-kselftest+bounces-24669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D12DA1407F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 18:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34B9188DB63
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2EF22F387;
	Thu, 16 Jan 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5xD5AU2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B322E40F
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047831; cv=none; b=GdJ+wpcZBu5ALtxBg9nbO/7mJ8WUOmNFBATTKni+5UKzlJ6qxQIV0jjCCbv5qIAAS0d01PuaPrvlyQDWkiIqxKLedftpuOMQ5P29BFqPpSsuDpr+5hA2NCi53CtGwQiiVT43sST8GrhhYhXpMryBtVT6HIzmRPML3ZgElgansXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047831; c=relaxed/simple;
	bh=7hlH5gC1HOmgHEEoKyb8tbS3Jw+S9oGiNenbBy2YmAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEPD8wHsVQCJ14nOvpSydveuHbPxIn9naM91IfGDcnjud8luG0uCgtMJuPRYi1VSBq+i6gEbtZrW63um3oZj26Ktq9gja8WcKgQa5Gxyyw2/f8FKrDuLSWSddlAArr/H1q4VgTQkedbpx5kGXmwdV731ehAtv1Q7AKLPmCeTH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d5xD5AU2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21bc1512a63so23655275ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 09:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737047829; x=1737652629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVUMi15eO0FtMXdL7HPHc6I0L1O00BPDaKk6s1ereu4=;
        b=d5xD5AU2wDGqmKDTciujLmTc+1BAJpB+REQL+M9zz2bCOTGHH1c+78+hm5c8QsEIo0
         hvR0magEdCL7Q8uIbbG5PQZS5VXnyILL5XFdfCZKfwT2rcC/mxKS7NTrV1NU6kz3RJnI
         ATSrA0u/+Mh8zgwWFiCJGGCoCXuUZahCnSgrrUIOqAl7VRCveYaw3SIIBBnHcJeGVRI7
         P2u7dHVOzQR/Hk0nIKV/T0XY0N5Fdjg/s9z/MI0yMFaBwmrNo7Jf1r6tw20rY+hSc/xy
         fVbCrCp4vVxUnAeJ+lBpY82VmKlyKC35sH2H7SChgM2QgEvlAZ2Y7XaeoAwxICZPgORB
         e4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047829; x=1737652629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVUMi15eO0FtMXdL7HPHc6I0L1O00BPDaKk6s1ereu4=;
        b=GZ8C3nNIzdWwYJ0ddVanxczLRfaY4PEg66MQy6DqsOyufFtBSRBhsrH6rn+aJ0mSys
         btuSB4OHu1fnX5JyQLVNNhWnEUByVJbtGNS74T3bPaAP89JeI3BwCJfKtXUnLwDXwuoz
         Kc+SzrvAtHsqJshGPpsaThgs7HgrpEPx3bjbOaf7k7LLeA7iaCQCh8VLWTfbvUQUABSJ
         WXgTJKPFQxBCNZ569IMnpnbz9mwyV7ZSx977oWBKw/pysaz12M3kVOoSeMmTEwffh1/4
         t8X9BBtdcs52wnfdujqmBLvBbCRJNPul2VXkEH3FGZlh8jZk0zmJP+jxw9o9xt34FTbN
         +VGg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Rs/XZg86HkyJRLof+1li1RAI3PkOTjborK4Fq+sE/Tnh/ywrC2fJasPn5/O+lwiZdbeiPzwM6mfe9LvktAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgF1hXeQsXY7Esuos2odKoS5wtWay5gMSTsZprTgPDwqyl9alP
	N6VhMpEcAwyT2jHsrHCYvk3nZqmd9QTc+AwCzkIkXXoyzZZfcAaQyZIhrF2bMw==
X-Gm-Gg: ASbGncvJUwPqySZHY+KQ1rKxxS3KHQHBVbuC+nTxFe5uwtVgKH4nxyCGpY+8G97v7bJ
	6swwdkUUlNKIhbXeu70aBHy1xXE1GaHR2kWeez/r9waB0VmIGTGLX55DNQ85TY46KyQdXlwG9GA
	oWJQNPaJQBY6oQf5fHIGP+/dub3QjIWvY6ItBJMlfzirB4sT25JQszoYZnJgd96L/f6BrWR5AGw
	ARMWu+QKjzn/WsSddpA+hEgjfSbaPEp//9txVv09o3T0WdZtD35+w7hxW9e9mYB8eKEzBoCrnQ9
	uuh1SNpji4EXnMjUyDJhKQ==
X-Google-Smtp-Source: AGHT+IE9XUuyOYdKnVf6z8lGmohKiyHxfdHolZzQ0LfDE00WtTj1mhef0ryAapG3wumjorO9Vo/g6g==
X-Received: by 2002:aa7:888c:0:b0:725:df1a:275 with SMTP id d2e1a72fcca58-72d21ff51e4mr50594286b3a.23.1737047829354;
        Thu, 16 Jan 2025 09:17:09 -0800 (PST)
Received: from localhost.localdomain ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f1846sm275155b3a.15.2025.01.16.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:17:09 -0800 (PST)
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
	cassel@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 1/4] PCI: endpoint: pci-epf-test: Fix the check for DMA MEMCPY test
Date: Thu, 16 Jan 2025 22:46:47 +0530
Message-Id: <20250116171650.33585-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116171650.33585-1-manivannan.sadhasivam@linaro.org>
References: <20250116171650.33585-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if DMA MEMCPY test is requested by the host, and if the endpoint
DMA controller supports DMA_PRIVATE, the test will fail. This is not
correct since there is no check for DMA_MEMCPY capability and the DMA
controller can support both DMA_PRIVATE and DMA_MEMCPY.

So fix the check and also reword the error message.

Reported-by: Niklas Cassel <cassel@kernel.org>
Closes: https://lore.kernel.org/linux-pci/Z3QtEihbiKIGogWA@ryzen
Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ffb534a8e50a..b94e205ae10b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -331,8 +331,8 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
 	void *copy_buf = NULL, *buf;
 
 	if (reg->flags & FLAG_USE_DMA) {
-		if (epf_test->dma_private) {
-			dev_err(dev, "Cannot transfer data using DMA\n");
+		if (!dma_has_cap(DMA_MEMCPY, epf_test->dma_chan_tx->device->cap_mask)) {
+			dev_err(dev, "DMA controller doesn't support MEMCPY\n");
 			ret = -EINVAL;
 			goto set_status;
 		}
-- 
2.25.1


