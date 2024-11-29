Return-Path: <linux-kselftest+bounces-22612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828569DC173
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DA7283EDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C18B176ABA;
	Fri, 29 Nov 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ot+cqwyk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CC176228
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Nov 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872410; cv=none; b=nEZK0To40Vbsp91n8WRHxU5nwN3MOw3+bgfcjkX7lr4K1VU32NxfgpfUSGdvRIQMxJxSt4BdSBa3MjRraJEZrOELl8CtEFgAquMD1ug8tXndwvtnBm83b790rq2Z1P/8dPwx2+xIOfxZe5xE0+BZfPLT/BrfXQI+laK95GAKayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872410; c=relaxed/simple;
	bh=MHlRYTDbzpte/oyaFieIs0N72WclEbQwNH1n/UIc3uI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOinklrTZ1Psi7rLVIkCt7S1cRuir1jQdYFf0zQdQVs02pfDs2nKjSmGT30A5GgAiSBK/zhpZK+lLpL7YAyqBI6//0jgOjixdCH2iA4SzJvE6imC6oHA5gbWkr/gomKxpqBSds2jlzaEJlfdyTQFFWEXki7dBn45SfnAuJnBCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ot+cqwyk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21288d3b387so11116425ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Nov 2024 01:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732872408; x=1733477208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/FAcNUtBN6sCO+JgOTDya+HEEM74CaemwD9wkIfazI=;
        b=Ot+cqwykEJ6tpRizYZrjGGudxgT2+5Eo9NfsK6wGtjTq4l3pZjEgiH+0swVKVKO7KH
         AahO+SOxSswK9Xx0WGozHh1RbLODzY9h+3m5IyZN886pl6kavX8mUMHIoSeC+9PjT73I
         8ppzS3t7xPmyJa+T+4cMIeGfQ4nyGxg74WC3XGirIg4oIRWUl0t/748OYTkRuiqbiko4
         tjpImJhzRMXAC6WPAsL7QWLLmA1CxerKDV33Rl46XzxJkVpeEi7NPBVYTuOlgTdR/AEH
         JoGaqsZSFURplxNxIWavekQ2oIEznKXxpgdhOEYHdZDIjHruosiPrN0CWoIphUltiqgl
         2pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732872408; x=1733477208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/FAcNUtBN6sCO+JgOTDya+HEEM74CaemwD9wkIfazI=;
        b=VEUxBXzOi64UHEcVvXD2GemH9i+YXu1xndHu5sSkGq1UU/nsm0HARiBdt2eeIi4hoG
         MNvD2Y99Ljtjb/w0kcNn+o1KAfoJlmIau28wOrj52PPkDEcVpY74sKaUekzCfbdkNFfM
         B4DVa3bLrd68HNhzZ78WqEY6XulMKtPCouN2Kiy2nE94jXz+oewyYTpMnM/gyxkZmAfi
         rtIb/JA6V8G/gSowtCXgYpbFMQ2urO7MZIpPmlJculUggzJOXT++BgWsx/pVADFtDE/+
         FaqfVM0vZ5lWOaXW9hvMQLe9BRi/Tr43f2ZUvqpr1Nlj/ic49QoE5qAIJqx1yXpCc+32
         7Qzw==
X-Forwarded-Encrypted: i=1; AJvYcCXS9Z822hlVIYuliRt6ebkULkwMRsGUSzdm+SwPIuwOz2EWqJOlRjSQBGI3bOiyNI77Rx7fj5W0+Gt8JooVKyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhWFkyd0ByN0HbpXYivCbSJnpv3KjaxqabkOQT816Jr3YKtxb
	Hkxosvw4IpRZA15irz5ajje4Gh04PVOUI5LodTH6CCsY8Yo0aOli99Y0pojItQ==
X-Gm-Gg: ASbGncv78QWXdPlWCiw8ZUY47bd8U+N2246qEEL4xQ7CMay9Vt5W1Caof9Z6V8FQKOs
	ekVvxLNMfqSh+cXgx7EX6pv57Z4z8SzaaTxnwRG2h9GE9xkvRN80Jcp2hIvwFnC7ACwpmf7yvQC
	oGK6azx4iywahrqsAH+DiVWICeFtcyWaN2PxobCcOP1BNIGRHqO6sDYI3MubI2XNuFyuKdb8/tT
	lwprwx9L3LF+wruLLCapD2OmWi7IVccdCu7K3+idkGrST0UXsYOSalUWVTUeh008SBfTlDPle9O
	0A==
X-Google-Smtp-Source: AGHT+IHN+l6NK+tC7x8F9oy13xLI5GVuVEUr9/bO5jZlgYXRjM7dncdGqnj1qr9Z+oTM9kC3RI9r8w==
X-Received: by 2002:a17:902:ecc1:b0:215:4d90:4caf with SMTP id d9443c01a7336-2154d904ddamr4433805ad.14.1732872408394;
        Fri, 29 Nov 2024 01:26:48 -0800 (PST)
Received: from localhost.localdomain ([117.213.97.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521987f17sm26648115ad.211.2024.11.29.01.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:26:48 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	aman1.gupta@samsung.com,
	p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable+noautosel@kernel.org
Subject: [PATCH v2 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
Date: Fri, 29 Nov 2024 14:54:12 +0530
Message-Id: <20241129092415.29437-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
cannot change the type. So mark the those BARs as 64bit BARs and also mark
the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
use them.

Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag
Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index e588fcc54589..f925c4ad4294 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -823,6 +823,10 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.msi_capable = true,
 	.msix_capable = false,
 	.align = SZ_4K,
+	.bar[BAR_0] = { .only_64bit = true, },
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_2] = { .only_64bit = true, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
 };
 
 static const struct pci_epc_features *
-- 
2.25.1


