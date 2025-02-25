Return-Path: <linux-kselftest+bounces-27432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC60EA43CE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49697AEBF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDC526B08B;
	Tue, 25 Feb 2025 11:03:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3628E26A1D4;
	Tue, 25 Feb 2025 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481389; cv=none; b=cDAOEBpIaSCWXdfSlAFZjqSyfGCRbAo07G6yfVY5Vh3t9twv8OC4maVYPLvBUy0FPGC/hjzOun0hKC7+wPwXjVUdWppQ+JYdSrX7nhqWHFTIS7A7LoheIz7l2jRMtJsEFWOUuVniNYSXXE7FFGgw0njc9eDjRoSQJDJjxPopUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481389; c=relaxed/simple;
	bh=81HekBlltROYLbXSzgM2XV3V117S8dyh/PGFNZP3s28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hw98CN/av5DNfDf4dCIWPJKfP6k8BXgfGuah5Vr3LN17/2Ok3NCnJcANMz6s8eEYczjo1LGMCBa8yCO2FPw5KUbEyQrZILNtNeEpKgPxeRBHuWLKu3hYw7224pYaRQG6j8/OzeDL8ZXmK/tmXyL1kXUp8tD35vIVhw3EKsMfI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Feb 2025 20:02:59 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 6DB0420AE2B4;
	Tue, 25 Feb 2025 20:02:59 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 25 Feb 2025 20:02:59 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 25AA83730;
	Tue, 25 Feb 2025 20:02:59 +0900 (JST)
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
Subject: [PATCH v4 1/6] selftests: pci_endpoint: Add GET_IRQTYPE checks to each interrupt test
Date: Tue, 25 Feb 2025 20:02:47 +0900
Message-Id: <20250225110252.28866-2-hayashi.kunihiko@socionext.com>
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

Add GET_IRQTYPE API checks to each interrupt test.
And change pci_ep_ioctl() to get the appropriate return value from
ioctl().

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../selftests/pci_endpoint/pci_endpoint_test.c        | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index 576c590b277b..d05e107d0698 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -25,7 +25,7 @@
 #define pci_ep_ioctl(cmd, arg)			\
 ({						\
 	ret = ioctl(self->fd, cmd, arg);	\
-	ret = ret < 0 ? -errno : 0;		\
+	ret = ret < 0 ? -errno : ret;		\
 })
 
 static const char *test_device = "/dev/pci-endpoint-test.0";
@@ -102,6 +102,9 @@ TEST_F(pci_ep_basic, LEGACY_IRQ_TEST)
 	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 0);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set Legacy IRQ type");
 
+	pci_ep_ioctl(PCITEST_GET_IRQTYPE, 0);
+	ASSERT_EQ(0, ret) TH_LOG("Can't get Legacy IRQ type");
+
 	pci_ep_ioctl(PCITEST_LEGACY_IRQ, 0);
 	EXPECT_FALSE(ret) TH_LOG("Test failed for Legacy IRQ");
 }
@@ -113,6 +116,9 @@ TEST_F(pci_ep_basic, MSI_TEST)
 	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI IRQ type");
 
+	pci_ep_ioctl(PCITEST_GET_IRQTYPE, 0);
+	ASSERT_EQ(1, ret) TH_LOG("Can't get MSI IRQ type");
+
 	for (i = 1; i <= 32; i++) {
 		pci_ep_ioctl(PCITEST_MSI, i);
 		EXPECT_FALSE(ret) TH_LOG("Test failed for MSI%d", i);
@@ -126,6 +132,9 @@ TEST_F(pci_ep_basic, MSIX_TEST)
 	pci_ep_ioctl(PCITEST_SET_IRQTYPE, 2);
 	ASSERT_EQ(0, ret) TH_LOG("Can't set MSI-X IRQ type");
 
+	pci_ep_ioctl(PCITEST_GET_IRQTYPE, 0);
+	ASSERT_EQ(2, ret) TH_LOG("Can't get MSI-X IRQ type");
+
 	for (i = 1; i <= 2048; i++) {
 		pci_ep_ioctl(PCITEST_MSIX, i);
 		EXPECT_FALSE(ret) TH_LOG("Test failed for MSI-X%d", i);
-- 
2.25.1


