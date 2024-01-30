Return-Path: <linux-kselftest+bounces-3717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4098417B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AAA1F241CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDD4339AD;
	Tue, 30 Jan 2024 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQW+DxdZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD72E40E;
	Tue, 30 Jan 2024 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575512; cv=none; b=L+VRFm7UR40tlEOCpWdkS0rT21EaqcnTZbcPO8emlJoxfcuROW7oGhsB9SLWVQrdqm8hsRd9LOddGYY4JzgAnEW5CvHmgkbuthcpPgkRTTeWeq+VBBBYmmOL8B7eRhQEkVMJQjZnvh3SV3dmk1WZ7HmMncV06RoPV0kYTLOajnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575512; c=relaxed/simple;
	bh=hCAh9IJVjneFBmTI7MeY6517yfTJZxfzJ8kdqiP/+uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bbq25jltsK+ePEgsIr4slaqedm01UB1MlNqAA2lSlzdmrFEiuHkD+cGd5Gp5q5XrBGKp0RP1my87FPRzyVoWcTnRmxxeDX7b9SZh41mPSfA4gEpGimp3deyRvvMzmSQ2+gMyIdJwpzA6apcVhEE7DC52mM4nYWvLbTGbCJ3WNlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQW+DxdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88633C43330;
	Tue, 30 Jan 2024 00:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575512;
	bh=hCAh9IJVjneFBmTI7MeY6517yfTJZxfzJ8kdqiP/+uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQW+DxdZHpADTKR91v4ppHkYQ9+QCKgvfLROiSuscRQCVoMwzgo9BkRP9t9Rzty6I
	 hQgE6xH0BVaMuJAnGsZVpUTZS5T1isEPfc+PbG0YFm0ajE8H9pnCAtL1ONUGEa+PdK
	 5vGsUjPO+1tJEBKbpbgo7Ohq85IS/HcI8yqOxCOj1+0L97hmbkEl1sl/DuyrLYgqFG
	 wkegUbFNEMkuAulGBRt+vVre0qdMwKrGUfyksKhK4dqFT8g2VqiwdPUJI+XlGmk7Hb
	 5XSKpvg+ks/MYUMJIGucojwHElxhYMaKL+EopAKboMDnd1KT/SL0wKjY8Jvbr8i8Qv
	 N7QCp2+WUyLJg==
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
Subject: [PATCH v2 2/7] um: Unconditionally call unflatten_device_tree()
Date: Mon, 29 Jan 2024 16:45:01 -0800
Message-ID: <20240130004508.1700335-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130004508.1700335-1-sboyd@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
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


