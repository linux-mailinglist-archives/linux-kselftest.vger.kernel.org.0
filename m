Return-Path: <linux-kselftest+bounces-27435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB1A43CFD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E793A868E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD11726BDB1;
	Tue, 25 Feb 2025 11:03:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5B26B95B;
	Tue, 25 Feb 2025 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481393; cv=none; b=puwB6eI62vRu3xiNrN/H42yBg/cWdp1KjpgBftjIhvD5vEJAPOGxPTqR8HV8gpKXm2FLpUkKEsjCqFZQM6HlEjU4yoezldY1Ce3unNWNiPsPHDv0Iwrfi1hTpmiFI+AQY4Evo0m1tW5U/wECxfDRhrz24C2dUWBGiANngKgf+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481393; c=relaxed/simple;
	bh=kuyAoXoEizfJHvbMf6KawxUhc/ebmChaHrOEd1RtrHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oG3rTgWoOYc4uNmZyq4bV/+nmB0jYKtWSvDtSrgXNh7uGFAfPBqr3PLmEFhNoh1tP+07r8sN7v3Av/BIQHJwrMO9FUH5JYJpP3v3vwsbEF4CcGEMY2XExQUogOxnKl+p5et0HxizApLUx3ZnLH9AkC8Ykn2qt3SwSSBrcpb/oD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Feb 2025 20:03:01 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id DC8E820090C2;
	Tue, 25 Feb 2025 20:03:01 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 25 Feb 2025 20:03:01 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 3CBA93730;
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
	stable@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 4/6] misc: pci_endpoint_test: Fix irq_type to convey the correct type
Date: Tue, 25 Feb 2025 20:02:50 +0900
Message-Id: <20250225110252.28866-5-hayashi.kunihiko@socionext.com>
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

There are two variables that indicate the interrupt type to be used
in the next test execution, "irq_type" as global and test->irq_type.

The global is referenced from pci_endpoint_test_get_irq() to preserve
the current type for ioctl(PCITEST_GET_IRQTYPE).

The type set in this function isn't reflected in the global "irq_type",
so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.

As a result, the wrong type is displayed in old "pcitest" as follows:

    # pcitest -i 0
    SET IRQ TYPE TO LEGACY:         OKAY
    # pcitest -I
    GET IRQ TYPE:           MSI

And new "pcitest" in kselftest results in an error as follows:

    #  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
    # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Expected 0 (0) == ret (1)
    # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Can't get Legacy IRQ type

Fix this issue by propagating the current type to the global "irq_type".

Cc: stable@vger.kernel.org
Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index acf3d8dab131..896392c428de 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -833,6 +833,7 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 		return ret;
 	}
 
+	irq_type = test->irq_type;
 	return 0;
 }
 
-- 
2.25.1


