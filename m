Return-Path: <linux-kselftest+bounces-4039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A9847A18
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 21:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD301C22E63
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1B83A01;
	Fri,  2 Feb 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS3LgOUj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF78839F5;
	Fri,  2 Feb 2024 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903955; cv=none; b=Gc7PwZiu3rmjRuZoG9e9CBM0TawHibkCWelNLh1NBmClqPXp5wGmb73xx1K3arZCRolgr1J3zpM7xXd3Adi3oNcEfVXch8p9srfmCcM7RwxRvpkBK6UTRVsmTh4KWIcn40tWFEGtTsdpwuT45OfpG5KZq2f2fuPQhWT2mOocddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903955; c=relaxed/simple;
	bh=7MNLMqC60PFypfikGUyizgcmoz6K4dXFYuG0uw1c2t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHcRtcN9gENRAxh2zy02hjmQMvDCuPQa/PqHPMrruPqt1aJKLCl9iELanC2REGNIsDuoDzZbYR4FlJG46+xUrniVHbcYeqy/nZ2tylqFkz+XeYRu/nKJoJvxOxmBDoSCc2Q5vT09Sb3x8BQpWkFt9dFEmnm9hzH/7CFN35hLlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS3LgOUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0DDC43399;
	Fri,  2 Feb 2024 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903954;
	bh=7MNLMqC60PFypfikGUyizgcmoz6K4dXFYuG0uw1c2t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jS3LgOUje0AaKkELyp5yo7o5rXijBOH/s1SqcpneNP1bmifPs+GO78P9aJ4YubATC
	 8sKniHp9zGS1eDFh8lXedC38t2er4z9+fcgEtzZ+Cfa/CiwuSxbYvk9XGQ/faguy/b
	 HzYgwsTF7FeWgJsUPKxKL3ZTRrW5jMd3ZYR+JCgciTsP3A0ktn9GMKrB+0xiJF1mJN
	 1KEkX2f0kRgxfTpsBQlCJ5USqFnwAUaVfGm3HXryx7e+RTuFgXu/Ff8NqhQVoXyj+L
	 aR6bimdFvj35OMLhKthnfc8oRpd1WjEefi61aEyghyRTtvCCi3tZrb8vgBrqcp8ejY
	 Dyrq2kwDoiwpw==
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
Subject: [PATCH v3 4/7] x86/of: Unconditionally call unflatten_and_copy_device_tree()
Date: Fri,  2 Feb 2024 11:59:05 -0800
Message-ID: <20240202195909.3458162-5-sboyd@kernel.org>
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
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
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


