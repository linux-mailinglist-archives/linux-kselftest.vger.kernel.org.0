Return-Path: <linux-kselftest+bounces-38246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CFEB1A861
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 19:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05FD18A0853
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 17:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3B28B3F9;
	Mon,  4 Aug 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4iTugo/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F682853EA;
	Mon,  4 Aug 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327475; cv=none; b=NrgczLIKx785RVRpCXf0pa/LUOo/FAxJHnalAiENUGsmETqjzst+WsBA3TRgxvMPbiDj5GMErzjw0sPqArYmEWO7XblrDPXE0KkHY/kXunNvAOmTYgk6MA7t9lGAeG7uqnulg+BVcgzM9+peGDzLSTWtb4dRHCJUR1SIC76DhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327475; c=relaxed/simple;
	bh=CX4MRQzSLCpObdmO0Ri+x1gMm0Gh5g+Vz+U+OFPO/UI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFJf3BAm57ceMtNOSMLY69klC5IDXQfg4S9mIoagrgqIfmUK0q3lXo5ebLtAFRxn7/9Lxm6Iadj51LYC9f+r7ogDGoA+VHwto7BQWJ56JE+7FswhW54LqCCVQkq9xbqU1B1CVl2kS/z5BBEVKA58ADBC5LT1pTqCk7NoNZSMjXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4iTugo/b; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574GahS1002647;
	Mon, 4 Aug 2025 19:10:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	vq3y/jUui0k3fPwqXOmQKZ/g5tWzod1LVKLPMlunJBI=; b=4iTugo/b9LBjHp+B
	mtIB018K2CtdkFdVmTMae/ZCctdumcx/KP1WCq30jwe6dS7ZJSQ+k/ILcTd1uKi/
	rbaFZPpRI11iv9Dy7Ygw0wuYJfh6VCQM3DVo4zyE720aXYBsLv0914HVEvwPFswe
	F3fEO3GNSt6E1jFMqfv9ZpNYdnfIKlPZ3/BfShiyge1j7rc7x0XHs3BCBU3HkG4m
	9MerW6GYudVu25CBtoAAIvMcTy0BBFi9y91FcmX4oUXZh+Wwqjqd8O/QLgorYmjO
	tXaY20SpyAU9EPoc8y5LQblUdNUcq7ReQOgVfkrxekh+HL0Uzipuh6IMHe0qo6yM
	nGcysw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 489wmnwt6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 19:10:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ADEE040047;
	Mon,  4 Aug 2025 19:10:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 33489B74700;
	Mon,  4 Aug 2025 19:09:35 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 19:09:34 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <kishon@kernel.org>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <shuah@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Christian Bruel
	<christian.bruel@foss.st.com>
Subject: [PATCH 2/3] misc: pci_endpoint_test: Cleanup extra 0 initialization
Date: Mon, 4 Aug 2025 19:09:15 +0200
Message-ID: <20250804170916.3212221-3-christian.bruel@foss.st.com>
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

NIT, memory is already set to 0 by devm_kzalloc.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/misc/pci_endpoint_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 54f66ece25cd..fbdffe7bb739 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1020,8 +1020,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	if (!test)
 		return -ENOMEM;
 
-	test->test_reg_bar = 0;
-	test->alignment = 0;
 	test->pdev = pdev;
 	test->irq_type = PCITEST_IRQ_TYPE_UNDEFINED;
 
-- 
2.34.1


