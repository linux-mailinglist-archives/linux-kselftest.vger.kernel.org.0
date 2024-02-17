Return-Path: <linux-kselftest+bounces-4899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B44858C91
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 02:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A231F21F16
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0536208BE;
	Sat, 17 Feb 2024 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLeOAuh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE0C2032C;
	Sat, 17 Feb 2024 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131961; cv=none; b=mvrC1NehippbRrF7VFHsY/a/fyhWPCC3SZUo6SdshYr0rBqMYrF2bwHL7iLFWoETjZRnZkIbegDD1QMdIv38O17udZRhI4sDVR7uky43FdAtGAcMuWuZ9nLfwgo3tK91o7GQLxyBF/aRS8KPB4pT2omKshqsa02aI1K4RlA8wCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131961; c=relaxed/simple;
	bh=cR6lBuTsNe2p1GQlv5k9m41XDe+JPSu/qcoX4YFfeKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIef8BijBt+j81klcq42PA4IhK1boAlOiAXb1kwVFvtnORPO9KCj01mMVHFSUGvnaS6xJKfW2gq0MX7hQeMgfp3zCtz18NzQoTFqvQtPV07yLr3YxbfV8pQyCFie1QNRLK/afpK/IgFVSbYpc0Wt/L5b+PghWUOw8GnGk6ibWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLeOAuh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C5C433C7;
	Sat, 17 Feb 2024 01:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131961;
	bh=cR6lBuTsNe2p1GQlv5k9m41XDe+JPSu/qcoX4YFfeKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLeOAuh9JcnWjMkP28AX6Wosr7CaT8IJDTe++OAPlHmV45oUdqI2baYVKvuONQLRM
	 REHahxweGolZgJoq4cIcJM609d280RUEZ6QOylnu7b84K0JrmRW4grtFnLrDKr7DHm
	 od2AR/PNbdj2WdEHoiw6v8AipspdwQHYwREzjurg2ModO/udqB4MN4PvqStRsntvhO
	 wln6USBTGOZIWd5lhk/LBgFW7h/6nkbg9ak53wpgvk1GtkpGxA34gf8jlkqNrtppj+
	 JGioc/KE+Kekqcl6YX6Z2urk1MRDsmJJzTSr56lOvTWTsRk1loY1rrmLedb/9jx56h
	 wnp6VBWh8/MAQ==
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v4 4/7] x86/of: Unconditionally call unflatten_and_copy_device_tree()
Date: Fri, 16 Feb 2024 17:05:53 -0800
Message-ID: <20240217010557.2381548-5-sboyd@kernel.org>
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
on platforms that don't boot with a firmware provided or builtin DTB.
There's no harm in calling unflatten_device_tree() unconditionally here.
If there isn't a non-NULL 'initial_boot_params' pointer then
unflatten_device_tree() returns early.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/x86/kernel/devicetree.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index afd09924094e..650752d112a6 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -283,22 +283,24 @@ void __init x86_flattree_get_config(void)
 	u32 size, map_len;
 	void *dt;
 
-	if (!initial_dtb)
-		return;
+	if (initial_dtb) {
+		map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
 
-	map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
+		dt = early_memremap(initial_dtb, map_len);
+		size = fdt_totalsize(dt);
+		if (map_len < size) {
+			early_memunmap(dt, map_len);
+			dt = early_memremap(initial_dtb, size);
+			map_len = size;
+		}
 
-	dt = early_memremap(initial_dtb, map_len);
-	size = fdt_totalsize(dt);
-	if (map_len < size) {
-		early_memunmap(dt, map_len);
-		dt = early_memremap(initial_dtb, size);
-		map_len = size;
+		early_init_dt_verify(dt);
 	}
 
-	early_init_dt_verify(dt);
 	unflatten_and_copy_device_tree();
-	early_memunmap(dt, map_len);
+
+	if (initial_dtb)
+		early_memunmap(dt, map_len);
 }
 #endif
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


