Return-Path: <linux-kselftest+bounces-38248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA6B1A863
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 19:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A50A18A121F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62028B7C9;
	Mon,  4 Aug 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fnCZgdl7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFFB286D4C;
	Mon,  4 Aug 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327476; cv=none; b=SC/4OwWvwY+QhhDXdhCN2S/RkyAV05HgMUgKT6ybcZiZtCmINpuag1Hc1/ZVc1WkK4n3q2kHGcaNmMKjEl7u4T6GeLvrNx4zpxcdUhhULHXfBE2nxrG7xFDHER8NXOdN1U1OVss72jBQIXE7I+SVxtr/goACsw6UR9VMsERqkSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327476; c=relaxed/simple;
	bh=uYW9z2WNCyHjIzdfSxpI3ii9BXoUNa5A54xjWIWkxN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYJn+raJ4WW2KBdhua38fUHabg7Q9doGnfeJnY81tEnXnknlYyvIFDyvf0TdATMthu5UEKt3vhqOCiwTtOxxxnQgUVyjy0Te6dK2pbNFhjijMfFj1OEe8DDJNBbuOWujSbDxa3wN6wF+J6MYx5aI5PhvRqwihFbaEm5SffiN6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fnCZgdl7; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574GZRkY001319;
	Mon, 4 Aug 2025 19:10:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	9uKKmqbVZuwnVZLU/O1ek2FINN8x4otsdSb1ip8igdU=; b=fnCZgdl7b7e6o4rH
	9pp1xsSjjja6Osmo0xSE0KMhKOSYeXs2pu3+wXvXQdBoXoE7O9iT85kN8y2PjW+o
	qBqQn6LwKAySbc16lJD/sdNSyivLaH/DezwxarkJI/teM/NRIXkxDo1ij4Nv8ZzL
	BwOXgq59/r5xQ+oj+ISNf4iPNh0sZ9AciadyV56jiFLp/z5yC+5bXdBbVlRTJeyo
	0PzeDUQAgOfVwbO0eePJrL6np1rkE/CK+Qxl7W8wr8S2eKWKqiIauXwTQn1SzMbU
	ChKeAyu8jHNEJ96gCkbve12KbU0HiymFZoPo+CBFb/qDiqxmhK/KUT2c5p9GKjNs
	oarmKA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 489wmnwt6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 19:10:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B3B5D4004C;
	Mon,  4 Aug 2025 19:10:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BDA30B74702;
	Mon,  4 Aug 2025 19:09:33 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 19:09:33 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <kishon@kernel.org>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <shuah@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Christian Bruel
	<christian.bruel@foss.st.com>
Subject: [PATCH 1/3] misc: pci_endpoint_test: Skip IRQ tests if irq is out of range
Date: Mon, 4 Aug 2025 19:09:14 +0200
Message-ID: <20250804170916.3212221-2-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804170916.3212221-1-christian.bruel@foss.st.com>
References: <20250804170916.3212221-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_07,2025-08-04_01,2025-03-28_01

The pci_endpoint_test tests the 32-bit MSI range. However, the device might
not have all vectors configured. For example, if msi_interrupts is 8 in the
ep function space or if the MSI Multiple Message Capable value is
configured as 4 (maximum 16 vectors).
In this case, do not attempt to run the test to avoid timeouts and directly
return the error value.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/misc/pci_endpoint_test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 1c156a3f845e..54f66ece25cd 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -436,7 +436,11 @@ static int pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 {
 	struct pci_dev *pdev = test->pdev;
 	u32 val;
-	int ret;
+	int irq;
+
+	irq = pci_irq_vector(pdev, msi_num - 1);
+	if (irq < 0)
+		return irq;
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
 				 msix ? PCITEST_IRQ_TYPE_MSIX :
@@ -450,11 +454,7 @@ static int pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
 	if (!val)
 		return -ETIMEDOUT;
 
-	ret = pci_irq_vector(pdev, msi_num - 1);
-	if (ret < 0)
-		return ret;
-
-	if (ret != test->last_irq)
+	if (irq != test->last_irq)
 		return -EIO;
 
 	return 0;
-- 
2.34.1


