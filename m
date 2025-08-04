Return-Path: <linux-kselftest+bounces-38247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90AB1A862
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3B7623A01
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2909728B51A;
	Mon,  4 Aug 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Bc8hkHoH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8D26056A;
	Mon,  4 Aug 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327476; cv=none; b=XrSrdy4x8rKwH+7wYPXSgKUstpTxr45v2/Va8hfCCbMJT0qoJerB9+BAkQ/CgpNWaXV/p6dagnTApKjxgnr9HO+Zsd7O/dBWlBhoZd/b3qRm5nISSQ+1oGSvlBF5+HIUlJ47WDItPI1A4GI25FikfKr+buntCJ+HiiwcM0fZmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327476; c=relaxed/simple;
	bh=YGjDe8g2XeL8OuTZqUT8rSnAIDqJbibYSb2+lgGodSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTukqbwoAK6+WRvVLNpFq0cmFG55qk/8ePS2fsShGcXo+N9bPQMETXPAL/B1mMeZRD87lkzfarI3CqBsUCbWCaWq7OntADI9NFxDfl3EIXjw+x1MpUiswFziuteKn7nK6JveJtElmtnG9xfDns8pSaeMmzRBrHAgBl6dMVzr93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Bc8hkHoH; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574GIavG020246;
	Mon, 4 Aug 2025 19:10:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	w9nB0wEZMjsj5QGB6VntU2EQFGOUf+h0V/Em0LxA/4Q=; b=Bc8hkHoHGEJ0w1Zb
	M5UgA3wLBVW2bDARuMu7OT2iWPAMdqsrKORaplPEd+5qnLPJLCVcpUkejy0Nijim
	4NPnSgUhicKVNJZezZ34zROuWty0q0tTP8/Rpmsxn3u3CvNBjnbSWaRorivsuowe
	IteSGSJfqeX2sm7w/Ia/ofNoruhiYvZTEmhay5mpZJpwvTa4dZEzBgDK8Gvs89jU
	f/BcjfjumuUzJarJjHFoEmRQapfJgiePLfvPVvy2NSxzzaybwrxLMv4LUqOfGWQ/
	wso217l7L9+XVTveZisdDi02t+8fto7YjcJqH8qk6Dx5FGlA3OKJrApMCezJ5M+R
	iYWzPg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4897t8reat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 19:10:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 53BD840052;
	Mon,  4 Aug 2025 19:10:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90D42B7470A;
	Mon,  4 Aug 2025 19:09:36 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 19:09:36 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <kishon@kernel.org>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <shuah@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Christian Bruel
	<christian.bruel@foss.st.com>
Subject: [PATCH 3/3] selftests: pci_endpoint: Skip IRQ test if irq is out of range.
Date: Mon, 4 Aug 2025 19:09:16 +0200
Message-ID: <20250804170916.3212221-4-christian.bruel@foss.st.com>
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

The pcie_endpoint_framework tests the entire MSI(x) range, which generate
false errors on platforms that do not support the whole range.

This patch skips the test in such cases and reports accordingly.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index da0db0e7c969..cd9075444c32 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -121,6 +121,8 @@ TEST_F(pci_ep_basic, MSI_TEST)
 
 	for (i = 1; i <= 32; i++) {
 		pci_ep_ioctl(PCITEST_MSI, i);
+		if (ret == -EINVAL)
+			SKIP(return, "MSI%d is disabled", i);
 		EXPECT_FALSE(ret) TH_LOG("Test failed for MSI%d", i);
 	}
 }
@@ -137,6 +139,8 @@ TEST_F(pci_ep_basic, MSIX_TEST)
 
 	for (i = 1; i <= 2048; i++) {
 		pci_ep_ioctl(PCITEST_MSIX, i);
+		if (ret == -EINVAL)
+			SKIP(return, "MSI-X%d is disabled", i);
 		EXPECT_FALSE(ret) TH_LOG("Test failed for MSI-X%d", i);
 	}
 }
-- 
2.34.1


