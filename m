Return-Path: <linux-kselftest+bounces-27431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB09A43CEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B173ABBE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F926A0E7;
	Tue, 25 Feb 2025 11:03:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D526A1CA;
	Tue, 25 Feb 2025 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481388; cv=none; b=Uo6n4w/onvcamK/lrx9c1Ts68uL/P790nX42PadbQFrix5RvZxAgvUIY2ruq8z5BrSC6Ij9yHWQbfaB/1JLTw6fFY5aWS6y+FrV9Cut1aKbTZ+CPLg60QD+1Ybq22pKF+QZlfwBtLOHSidy6bCCxw/NNgoaPUJsMf1rpiE+EVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481388; c=relaxed/simple;
	bh=ZWRiocwTl2a4SS1MupgBeefn3dHTl1OQMnmvBzw2czI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EBnLB2I5UHRzS8AlckY+9xCfE4aLBurjOv2CgMbWm1dBgnKZi0Vfgq+OljzUh5Pf+kiw/OL3UmoWxlK60K6go2c3218ZV9dqhiAiZHmn3s459V849bm1KwprIJWQXghEbhIUJw9Tp40Oyu+RTMdsPMS3ZvteJmWFNe9Jpo98/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Feb 2025 20:02:58 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id D91C920AE2B4;
	Tue, 25 Feb 2025 20:02:58 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Tue, 25 Feb 2025 20:02:58 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 46338C3C1E;
	Tue, 25 Feb 2025 20:02:58 +0900 (JST)
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
Subject: [PATCH v4 0/6] Fix some issues related to an interrupt type in pci_endpoint_test
Date: Tue, 25 Feb 2025 20:02:46 +0900
Message-Id: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series solves some issues about global "irq_type" that is used for
indicating the current type for users.

In addition, avoid an unexpected warning that occur due to interrupts
remaining after displaying an error caused by devm_request_irq().

Patch 1 includes adding GET_IRQTYPE test (check for failure).
Patch 2-4 include fixes for stable kernels that have global "irq_type".
Patch 5-6 include improvements for the latest.

Changes since v3:
- Add GET_IRQTYPE check to pci_endpoint test in selftests
- Add the reason why global variables aren't necessary (patch 5/6)
- Add Reviewed-by: lines (patch {2, 4, 6}/6)

Changes since v2:
- Rebase to v6.14-rc1
- Update message to clarify, and add result of call trace (patch 1/5)
- Add Reviewed-by: lines (patch 2/5)
- Add new patch to remove global "irq_type" variable (patch 4/5)
- Add new patch to replace "devm" version of IRQ functions (patch 5/5)

Changes since v1:
- Divide original patch into two
- Add an error message example
- Add "pcitest" display example
- Add a patch to fix an interrupt remaining issue

Kunihiko Hayashi (6):
  selftests: pci_endpoint: Add GET_IRQTYPE checks to each interrupt test
  misc: pci_endpoint_test: Avoid issue of interrupts remaining after
    request_irq error
  misc: pci_endpoint_test: Fix displaying irq_type after request_irq
    error
  misc: pci_endpoint_test: Fix irq_type to convey the correct type
  misc: pci_endpoint_test: Remove global 'irq_type' and 'no_msi'
  misc: pci_endpoint_test: Do not use managed irq functions

 drivers/misc/pci_endpoint_test.c              | 31 +++++++------------
 .../pci_endpoint/pci_endpoint_test.c          | 11 ++++++-
 2 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.25.1


