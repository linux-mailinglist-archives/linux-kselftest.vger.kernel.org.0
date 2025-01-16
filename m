Return-Path: <linux-kselftest+bounces-24647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF29EA13B29
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 14:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21884165F5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2C922ACDF;
	Thu, 16 Jan 2025 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHgIXJ+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584F22ACD3
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035484; cv=none; b=TL9636/zFVgA51jPyMNtLJDyUUcnAODF6pg0sdsbwjaYVmRsujztoC7ME7sffm1Yjr3aT+4rvBjTLa8JByRko60q0+vd21liXs1CNL1S6e/BAX9scTnz6Vc8pY2PH0wSDAXm6q+Q5KkFzATgTFf9tSzAhZOzoAKE7aRedQIddH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035484; c=relaxed/simple;
	bh=4uuXXMls8114LWh45Vhuuj5GpluyhflqvtpAwRLCiZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rj72G++12vhfmZ6NLZkBt1iFNdZwarzjooUlJAIq46QjzsdQFguuj8U0e/g8Omh5VRIaEXiZatm893/DHe87z8HbFVyMTupIPghy3mm/Q3RpXS9HlPP/JHXgbRmcCtw44yZ838n4CHeztUtu6yRxORg0RCExxaXn75Ht+RhCmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tHgIXJ+R; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so1305207a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737035483; x=1737640283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuraTNV/U058me9OXCx94wz8W+2D2JAwEjqocWrvvU4=;
        b=tHgIXJ+RhgWyKWeULH9vC47wnwv+66RYejsTNU2TQYn6YulkcMg4FRaHz1ALBidFz6
         8AVSJBLHxe5oamim63jjGTHcfHcVCKyTSpwzjPJkKpDOEMnsHQ2Kle1Xy5Zqush55fjH
         j6mkm2vvGlOfJGT72ur9oVm4iyNNfd2SgFhoLBHQ63c5tGtI90Iptv4jgeHCMlPtIRqB
         qu98fKnvu5W3uZhRVUeS/Gyt/o7zIF15cbC0YvTGyC/gfMlLum/6bzMO0BtaeLCKkaoJ
         EIbBTolFLLba30SenWzfHYQ4DIWv1HCDeQ+WjjGUytO8sRHLw/c1EA8u/X0C9iWXn4cQ
         /X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737035483; x=1737640283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuraTNV/U058me9OXCx94wz8W+2D2JAwEjqocWrvvU4=;
        b=tbgyo9+OG3jp6WPpeNi/3UwpghckGd6NNchESNti21w+Vs3S0rpHirKfDJq4wc0hhB
         hekqB7zytx1/7tcfeaHk8OXOqsSUboFn9YdgfpWwTjaWWX2SnQRbG/xdasDdeZBSq43l
         cra6iicq3vJ99Xlm0DCYe609Y0uWyvr5bN2EmsnOfZB+XrEFNr6Q6xqsgKKqwHyhbdOC
         j5ySIi9b8ADUYPCN7nt/OAT4VVHzAY/+qQ173afxumGb3QNDQlgcOoVG0VmpPB69F1hN
         TfbnI4aF+jfHBmNMzFlTWg9q74nyzFsCcF9qAmD0YUKy6oF/TX1j3v8V2GaEzFfx7cXL
         DWVA==
X-Forwarded-Encrypted: i=1; AJvYcCX5aRFF3cyeENRc8zjlQOiIdduVlPGJ2RNSeS6fAkRTcTdNMOTJo6UnHsxOBQSSJ+oG97vSCCEm2xG2/8N5Zuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnG0HnssX/Zo/WCBB0dcG+Yvbny4vvWtDp5HxCFMRP17Mgsni
	pbW/c/l/t+4dv/w6i+YHXZhQDGH8bV1TQNohKE4w4oCSUZ4roCBoiEx03bovLQ==
X-Gm-Gg: ASbGncu5QAPeBhjmIbbhP6BjXpBzWXN04zUhD/P5pOgLdLU5PBzkegvTylyecOt6fk3
	g4q7Bq6V35r5UB+dgPUI+KCC/2HZIDcYUWAjC1MhmA8fV3O67wbHpRqQH7RH3pHpqldWzZvoYNh
	hcPFTUJGoyCOm7nIulxrzMGNd/aacp2mPrm7qNXNSuDyRmyP4r0iTSSOZnNsBvoSvDtrZ0zzb1D
	kfouvhq8zyn9GadMds+zoPdi4gb5Bdrf9136cn0J1OsI6NpOeHJr92o1rsosrGvcgNpVveD1DLd
	mh4hlY6d
X-Google-Smtp-Source: AGHT+IHmaGQZNbO8JtgXuwbUObwC7YFWTkj6AMiRO/klNtQ/UWZdvAYSXN4Noy4pr3wn0/p+IsYVIQ==
X-Received: by 2002:a17:90b:520e:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-2f548f4ea90mr45589561a91.27.1737035482828;
        Thu, 16 Jan 2025 05:51:22 -0800 (PST)
Received: from localhost.localdomain ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cba9csm3341229a91.24.2025.01.16.05.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:51:22 -0800 (PST)
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
Subject: [PATCH v5 1/4] PCI: endpoint: pci-epf-test: Fix the check for DMA MEMCPY test
Date: Thu, 16 Jan 2025 19:21:03 +0530
Message-Id: <20250116135106.19143-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
References: <20250116135106.19143-1-manivannan.sadhasivam@linaro.org>
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


