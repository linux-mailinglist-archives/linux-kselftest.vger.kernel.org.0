Return-Path: <linux-kselftest+bounces-11092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25BF8D75B4
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 15:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729E71F22601
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jun 2024 13:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929F53CF6A;
	Sun,  2 Jun 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JJkBIEqc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1803BBC1;
	Sun,  2 Jun 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717334786; cv=none; b=nuLwqaNP0xuYFafsTVkcQYFWpR+GREdZrJikcfT/8n77h7e2mPt3m8TuezUARL5W1rhriqJ3nQtpksg3nsB01d/qzVTjtfmzrYU3OgU4w1MyUl/9rW/lFtFfnfcccuXawrrIQ3vqPrHxjkzRy/NwwdGoVk9DHD7lq3mAGf0xRjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717334786; c=relaxed/simple;
	bh=iWRwIfh5UR3rNfLHd715boOG38Dp5ZMz8BiZ8y0AUTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gsxpV1/0uKQoFA7/Tw27HOzP6ILN9CXshA4LBFnQ3Fevyiv/CSHloa3hpTgUIbMGUEYBJdxpX8mc3iJKEeLqnFzqVt57jcLeQAT3sq0whBeFZ/UgdFH0XuCzrzr9wFlNFXUuarq1XESkdfgIl5TcXYjlhYRJq2O5tQTKtVMo5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JJkBIEqc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717334777;
	bh=iWRwIfh5UR3rNfLHd715boOG38Dp5ZMz8BiZ8y0AUTY=;
	h=From:To:Cc:Subject:Date:From;
	b=JJkBIEqcpisTcy0xjoakuO+LS/obIe4u0lqhpPICAKbmi+fAV0sfM0/dONY8N3kW4
	 d1hVJb6wd1SO/YmNnix7+ILFP8Cs7WeyQleOGgJtyqtoDRJNg06raGSa8SspEsHNlp
	 BLqU7qvxRT7qcQPUen/yfLup4DVN2O7daMRvctEK29mwIzjuoyyJtNTx738ivjBn8j
	 55XGwsrXo/o8O4po9BpMtJJxoCxe+yLtyAHdCwaGhTxGlDOIkVTro6uPB1Thhj8POw
	 uP2htmce4/b+zt2k7UcMatNv/ioRL1BAqNQ2LesoqBPe+LvdDu/XeDC4YhgDdgskhm
	 iFlufY5NiUscw==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8160B37813DA;
	Sun,  2 Jun 2024 13:25:54 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Kunwu Chan <chentao@kylinos.cn>
Cc: kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: arm64: tags_test: conform test to TAP output
Date: Sun,  2 Jun 2024 18:24:59 +0500
Message-Id: <20240602132502.4186771-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/arm64/tags/tags_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
index 955f87c1170d7..8ae26e496c89c 100644
--- a/tools/testing/selftests/arm64/tags/tags_test.c
+++ b/tools/testing/selftests/arm64/tags/tags_test.c
@@ -17,19 +17,21 @@ int main(void)
 	static int tbi_enabled = 0;
 	unsigned long tag = 0;
 	struct utsname *ptr;
-	int err;
+
+	ksft_print_header();
+	ksft_set_plan(1);
 
 	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
 		tbi_enabled = 1;
 	ptr = (struct utsname *)malloc(sizeof(*ptr));
 	if (!ptr)
-		ksft_exit_fail_msg("Failed to allocate utsname buffer\n");
+		ksft_exit_fail_perror("Failed to allocate utsname buffer");
 
 	if (tbi_enabled)
 		tag = 0x42;
 	ptr = (struct utsname *)SET_TAG(ptr, tag);
-	err = uname(ptr);
+	ksft_test_result(!uname(ptr), "Syscall successful with tagged address\n");
 	free(ptr);
 
-	return err;
+	ksft_finished();
 }
-- 
2.39.2


