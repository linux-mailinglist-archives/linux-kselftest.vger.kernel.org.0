Return-Path: <linux-kselftest+bounces-4898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0049B858C8F
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 02:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED409B24E82
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079D5200C7;
	Sat, 17 Feb 2024 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWHPrdK5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2F200AD;
	Sat, 17 Feb 2024 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131960; cv=none; b=hGhvUpypWcAef3fk7Kxsgi+YPWHKRqXjhvSqYMdmq974s1c15ysXi3gR1LZe4Jj7flw5j5OIOlawu3vP2e42ffnR4sJezwg7qHEmlqJ7QXiV9gKgUNIYo4m+rJ2NzLgbmiqqUMu2eajoq32vVxmWUReFq8PNRPq7VQXyI7hTGgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131960; c=relaxed/simple;
	bh=bAiFEbT58TXbP+zf0tFWIGODmRi8LJ7psP4/tHXmMrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oipN2FitzHPpQwjTmbtft5MGZAoxajicanu/Uft9bBX/lzx5JWGNLo7ixPXY9Z+xID/wl+dP/OP6ji/2eXylsTOGydGFQg+97IE5K3O9QeMGKMFASRWt8dFdNzREft5vEa4sPu4DSe7hLPV+N9icjQnCHXIbxEmtXEd+aGJw3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWHPrdK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAC4C32789;
	Sat, 17 Feb 2024 01:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131960;
	bh=bAiFEbT58TXbP+zf0tFWIGODmRi8LJ7psP4/tHXmMrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWHPrdK51ANKmmUE3NqJATrEVu6sf4ZIcdhvGIb1FIOmfGEAlBBUzElIK3HXYvtau
	 HM8OPq8HMxmE9tV8EHUsdjlUrBVacmJLtTFqEgDvSIkYu//JsuZnSiCygfMUAUP5p2
	 WzURYNN7LTNRzRNRTMPM9s9UNIbyHCFzBjQQSta0mjCFfUeA2MLNLYbltHu4sA/nRK
	 xAhmAwqIQ5hcPyyiybY2EYhSeBudz+h/5mDdVenucdfsF+wgwIZur9UXrCkkKGQ4EE
	 8ioWUb7gB4t06y/Xgd2WQLhkZe9z3EacufoevPtfc57OygRYn0npOjK9jtlF4dknIo
	 FNcCYQOdi1FQw==
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
Subject: [PATCH v4 3/7] um: Unconditionally call unflatten_device_tree()
Date: Fri, 16 Feb 2024 17:05:52 -0800
Message-ID: <20240217010557.2381548-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240217010557.2381548-1-sboyd@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
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
index cfd60e35a899..891752a20a5f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4087,10 +4087,6 @@ static int __init of_unittest(void)
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


