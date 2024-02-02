Return-Path: <linux-kselftest+bounces-4038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BF8847A14
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12BB1F234AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9CD81758;
	Fri,  2 Feb 2024 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe5mTlqQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80C81748;
	Fri,  2 Feb 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903954; cv=none; b=gvOiKvW05enLKlRwKrCWOTa8qvIStWvf0bAxtIVmfRj/BlcTcEOeAJX7Fk9X3rUVzwu5uBiwif+mxkUnlBwnuJD0KWxAQ605WE2dMyX+G9/L+o2JkVt8qZ/UUz6LmzQ6xjVika0uMDlUSRrW5v33B2ae3Xe/Ujlc6vt+o7rOFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903954; c=relaxed/simple;
	bh=hCAh9IJVjneFBmTI7MeY6517yfTJZxfzJ8kdqiP/+uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXWUNX0Pji0M6zGmgtyZH3IchbNt84920vL8kMWlbCOapGqHV9ehnA+1EfyHe+ihHUERwcy4u3ZI1mGTlYguLFBxAaPQ+pCUoeP141Qx8WTXuZV9VZt4oYO0jc5OKExfEuDsvf64nvfq2EeJj1MflcWzV/Taaz9OpUr3WCGoKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe5mTlqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA47C43390;
	Fri,  2 Feb 2024 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903953;
	bh=hCAh9IJVjneFBmTI7MeY6517yfTJZxfzJ8kdqiP/+uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oe5mTlqQV4TxhihRvuWjgYd5mxic2ugd/H4tFQBcJ/U405XynzpfABSFHTa+Foabt
	 nGUgMGsnJ7GPKJm90IUmijMHgVU34jyZ32du/2NiMbIrfr+4NzpMSpNF0ofS3N2yK6
	 CFGHkLMXYwt2V3Zl50Q0AcnPcrEYu/FF/JMS8QO6pKTK8VNYZkkksNgTetK25izGPV
	 rl+jjk+FQadEwPmK8WcaQKd6vA5wD9GqrqVe4coMaA6xgtc1xb/8LHDTbsoZVVN+3I
	 p9/nRIR4huLAAKk4VnEmgaiGqJRIIQjY4z/H3bzHkJkNg16kubZMki/t2r5Lqzo8+Y
	 R2crPQ+Zr50rQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 3/7] um: Unconditionally call unflatten_device_tree()
Date: Fri,  2 Feb 2024 11:59:04 -0800
Message-ID: <20240202195909.3458162-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202195909.3458162-1-sboyd@kernel.org>
References: <20240202195909.3458162-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call this function unconditionally so that we can populate an empty DTB
on platforms that don't boot with a command line provided DTB.  There's
no harm in calling unflatten_device_tree() unconditionally. If there
isn't a valid initial_boot_params dtb then unflatten_device_tree()
returns early.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: <linux-um@lists.infradead.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/um/kernel/dtb.c  | 14 +++++++-------
 drivers/of/unittest.c |  4 ----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index 484141b06938..4954188a6a09 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -16,16 +16,16 @@ void uml_dtb_init(void)
 	void *area;
 
 	area = uml_load_file(dtb, &size);
-	if (!area)
-		return;
+	if (area) {
+		if (!early_init_dt_scan(area)) {
+			pr_err("invalid DTB %s\n", dtb);
+			memblock_free(area, size);
+			return;
+		}
 
-	if (!early_init_dt_scan(area)) {
-		pr_err("invalid DTB %s\n", dtb);
-		memblock_free(area, size);
-		return;
+		early_init_fdt_scan_reserved_mem();
 	}
 
-	early_init_fdt_scan_reserved_mem();
 	unflatten_device_tree();
 }
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e9e90e96600e..a8b27dd16ecf 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4075,10 +4075,6 @@ static int __init of_unittest(void)
 	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
 
 	/* adding data for unittest */
-
-	if (IS_ENABLED(CONFIG_UML))
-		unittest_unflatten_overlay_base();
-
 	res = unittest_data_add();
 	if (res)
 		return res;
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


