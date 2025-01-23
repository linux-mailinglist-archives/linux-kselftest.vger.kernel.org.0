Return-Path: <linux-kselftest+bounces-24994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747CA1A3B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9B21882990
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1940720D51C;
	Thu, 23 Jan 2025 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExQ0KCoD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6A1D432F;
	Thu, 23 Jan 2025 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737633719; cv=none; b=G5QRv5j1FItLsH68iAMeKycm8wVRTxr3LQRUiyJW34kvctV3WvM/qjeiBNt63/9iQ7xiPew65oJ1O1wbvBizjuCU5zNj3a9qZcx3J3JgUcFOEGUHmt/TcmWPMfK3X6Ft8IU5FjDRnkxpQRe8V4KDqbXvZUY5M3sK1mUafOWgUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737633719; c=relaxed/simple;
	bh=8fqakwhEliIhTWw+vJJvLaeNsJgd+hbvnPpuAgtm8Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNdi+Ui+3Wv3Vs+q4nC2KY5/o6y+6LzOuFNsjifponZ0AlPMTEJX42uQGcs8HEgHyl1STHYOZXZ1D3gz6C+8pKD24pP6498drHXW9AgO9nESecaT11ATB19RYyBOCDNjwO2C02qXXKqIP2Nq/hRHj6u+PvJgJvqTzujTtWF9deQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExQ0KCoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C375C4CEDF;
	Thu, 23 Jan 2025 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737633718;
	bh=8fqakwhEliIhTWw+vJJvLaeNsJgd+hbvnPpuAgtm8Lg=;
	h=From:To:Cc:Subject:Date:From;
	b=ExQ0KCoDZOmubqrjMK1PBfxSEFLYtM03wAehat4iTHwqawGcLLkJyEvDC0vQoRiED
	 FoVE4ST+0M14aGR+Ob4uq7Y4KvqXkBx5N+waC7bc53b2rD+yOo+GKAJhVfgUJ0WEhA
	 ensqgd1Gln/vCZfmJNuB8CtAjR8ETT6kn6R0jqJSJFwrtkyJHndaWtQ+1tCwDp8i0Y
	 81EHdwGFtNe+hHeqV+OWLEjcv53groUT6sJXWN51xlVv8yZSSGlvzuZTZOYNoQpFvO
	 qVRg4890JmVYUU7bWZwwKsfs4mSWdhkwxiyOwTN2mTPa01/JvlU/ywW8cd8baH+iSl
	 MsIm89IUyxoeA==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com
Cc: linux-pci@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/2] misc: pci_endpoint_test: Give disabled BARs a distinct error code
Date: Thu, 23 Jan 2025 13:01:48 +0100
Message-ID: <20250123120147.3603409-3-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=cassel@kernel.org; h=from:subject; bh=8fqakwhEliIhTWw+vJJvLaeNsJgd+hbvnPpuAgtm8Lg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIn6a9ZVhn4QeLqwTM7PVR/Pj99l7H9aIfnab3mOpvFl ye5ZFpUd5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiKVsZGfYo1PaH2dhWPH30 LTiFYYMixykvE9ZfMY35Xq+kS5ecj2Fk2KgWEK0vr/G3uEHMee+OvQc1/k0q0Ni5Qt2b04ujb1o eFwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The current code returns -ENOMEM if test->bar[barno] is NULL.

There can be two reasons why test->bar[barno] is NULL:
1) The pci_ioremap_bar() call in pci_endpoint_test_probe() failed.
2) The BAR was skipped, because it is disabled by the endpoint.

Many PCI endpoint controller drivers will disable all BARs in their
init function. A disabled BAR will have a size of 0.

A PCI endpoint function driver will be able to enable any BAR that
is not marked as BAR_RESERVED (which means that the BAR should not
be touched by the EPF driver).

Thus, perform check if the size is 0, before checking if
test->bar[barno] is NULL, such that we can return different errors.

This will allow the selftests to return SKIP instead of FAIL for
disabled BARs.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Hello PCI maintainers.
This patch might give a trivial conflict with:
https://lore.kernel.org/linux-pci/20250123095906.3578241-2-cassel@kernel.org/T/#u
because the context lines (lines that haven't been changed)
might be different. If there is a conflict, simply look at
this patch by itself, and resolution should be trivial.

 drivers/misc/pci_endpoint_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d5ac71a49386..b95980b29eb9 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -292,11 +292,13 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
 	void *read_buf __free(kfree) = NULL;
 	struct pci_dev *pdev = test->pdev;
 
+	bar_size = pci_resource_len(pdev, barno);
+	if (!bar_size)
+		return -ENODATA;
+
 	if (!test->bar[barno])
 		return -ENOMEM;
 
-	bar_size = pci_resource_len(pdev, barno);
-
 	if (barno == test->test_reg_bar)
 		bar_size = 0x4;
 
-- 
2.48.1


