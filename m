Return-Path: <linux-kselftest+bounces-24995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8ACA1A3BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C65716A0A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D6D20E307;
	Thu, 23 Jan 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJGmWo8r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24820D51C;
	Thu, 23 Jan 2025 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737633723; cv=none; b=BooLRig+Vw0laTxIZe8vjUoausGlkwZ1Z0FPMMaeJzYKu8JoTvw/XQ8ZR3LOZqPoALCpHSTRay7ALiQL7TjRA0qBQEooe2GjTPjjf6f17Bw0rHfPctkD4sp3yFgu0buxGHQ/psL4omfA4QopioURUO0hP6Zd979b+zqY1GXpwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737633723; c=relaxed/simple;
	bh=SJfDFslsBozN9KlVdyTBzI9flaqI0LLi8HWs05pUThE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT+kISV4qSRro+bxNOfbeUgDrkCUBvRD67rIuoVU/firA8k/rRhkFCWkjDHATsuYSABQaV1uEFz3MQ88/ysjySBR3BEhXGBq5EQ2ngHHORF+dQcwWRPmJDUs8cBiIFW3wBCHefTs6PllIE97ze1j+rHbB53PretmJSzyctE3vPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJGmWo8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0408BC4CEDF;
	Thu, 23 Jan 2025 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737633722;
	bh=SJfDFslsBozN9KlVdyTBzI9flaqI0LLi8HWs05pUThE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJGmWo8rm5HV5aPCe2ZqxonDa1EiYFE2nf5xJXRlSYyjb9ASstAmR7m8jprTNw73g
	 nRCppKb9/r0OYqiug+SP1x+56/XTZtG2QfEyQrEVKkP69HZycXtrTBwLjm/zNLauiT
	 F5kUuKZj3w/v79yddMWyvSGlrQLOuAjq2RQlr0ombRiLzdjpJaqqkO9vtf5t586amK
	 yeH5uJTjkQd/0yHjvHrdwlHzkqeghFA6iDiyGAWygS1JjGaup+qd6qcyGXSqHxz2Wt
	 1fPKSZXOM9e7nQqoWvfQLp4mMlWekUy+mBruCVIecW3k4bJ+IfreUYKlEPneDxu3An
	 8A32RsTS/3eqA==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com
Cc: linux-pci@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/2] selftests: pci_endpoint: Skip disabled BARs
Date: Thu, 23 Jan 2025 13:01:49 +0100
Message-ID: <20250123120147.3603409-4-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123120147.3603409-3-cassel@kernel.org>
References: <20250123120147.3603409-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=cassel@kernel.org; h=from:subject; bh=SJfDFslsBozN9KlVdyTBzI9flaqI0LLi8HWs05pUThE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIn6W9oifA7ohJVL66rNJNR5uddG8YOk3dXOhRfarTb6 80+fXNHRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZS9IOR4e8xnuiDAsz/VYTL p817EbZuvtmGg9E1t7mMz02s01mbe4WRYT/f/hWqHV7Zq54vWqG0Kuc07/1SE34fI5spbZ1XCk2 6+QA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Currently BARs that have been disabled by the endpoint controller driver
will result in a test FAIL.

Returning FAIL for a BAR that is disabled seems overly pessimistic.

There are EPC that disables one or more BARs intentionally.

One reason for this is that there are certain EPCs that are hardwired to
expose internal PCIe controller registers over a certain BAR, so the EPC
driver disables such a BAR, such that the host will not overwrite random
registers during testing.

Such a BAR will be disabled by the EPC driver's init function, and the
BAR will be marked as BAR_RESERVED, such that it will be unavailable to
endpoint function drivers.

Let's return FAIL only for BARs that are actually enabled and failed the
test, and let's return skip for BARs that are not even enabled.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index c267b822c108..576c590b277b 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -65,6 +65,8 @@ TEST_F(pci_ep_bar, BAR_TEST)
 	int ret;
 
 	pci_ep_ioctl(PCITEST_BAR, variant->barno);
+	if (ret == -ENODATA)
+		SKIP(return, "BAR is disabled");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 
-- 
2.48.1


