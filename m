Return-Path: <linux-kselftest+bounces-4036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA5847A0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4C01F26627
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 19:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECA68063E;
	Fri,  2 Feb 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lolArgXV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA415E5D1;
	Fri,  2 Feb 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903952; cv=none; b=pYwMq01Q80au2/KoeutfK0LycXDn+c0TiZ3rY/P88CI3IYa+bnWN9C4zXqa9Zjmr3K0J8ldEPPfSbMWoXaz3TAwSFwnQ/y+w7hKMrN/Wha9vFUT0xAQAyzjY7q6CkhYSewPyhxkZhIKyS1NwL5JwXtkg8VHEPcQmU5Z6ogvx1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903952; c=relaxed/simple;
	bh=Qt8ricOYsTKcXJqQzKSKsHiM2MHdHGBlaBkQ7xeVb1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFOrt6ZLOtlz7b9cZr4PxSmRlWLuusczuTSLAdkEh/bjKl4QTFmQH3G42rUq/sJWg/lH267HByjLqptev8tf2q58mmbZVEyPdOYqORfN2Ls+AjowZNcaeibRHaD4kcls7DvEEGi+J/Qy09qWYEyMM1uXdAbLutWgxUO3QHE2dRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lolArgXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BC6C433A6;
	Fri,  2 Feb 2024 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903952;
	bh=Qt8ricOYsTKcXJqQzKSKsHiM2MHdHGBlaBkQ7xeVb1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lolArgXVyTaONkcJ5g+Q0I74VOq82JrEMP+bi1sJfx15lGiKzZRLSxhR7HPZQO9o+
	 Vk7IRVNvNklfw0NMszumwTcFm9jgJBwhoUs6umQ55RBhjMrFu52cy4n/gJ4BbpE2HX
	 lIg2PWCeBkrRkSrM123IFh1gZLL78hdg113f6j5P9rjYmbPOyEBq9F+7wne+BJLnAP
	 8ntDegcw+g3r3b7BJaeyLoqw7DvIKZXgU+luSg2rfc6tqGJZNT2rjuMRYmox0btctH
	 Bx9iZO9QAEpH+NXjlocxZnEWB2f7RqplqHjGB7yVg/0KTomqx4izsjaFh3vB/qkVbN
	 8btpvM4BTB31w==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v3 1/7] of: Always unflatten in unflatten_and_copy_device_tree()
Date: Fri,  2 Feb 2024 11:59:02 -0800
Message-ID: <20240202195909.3458162-2-sboyd@kernel.org>
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

We want to populate an empty DT whenever CONFIG_OF is enabled so that
overlays can be applied and the DT unit tests can be run. Make
unflatten_and_copy_device_tree() stop printing a warning if the
'initial_boot_params' pointer is NULL. Instead, simply copy the dtb if
there is one and then unflatten it. If there isn't a DT to copy, then
the call to unflatten_device_tree() is largely a no-op, so nothing
really changes here.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/fdt.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..dfeba8b8ce94 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1318,6 +1318,21 @@ bool __init early_init_dt_scan(void *params)
 	return true;
 }
 
+static void *__init copy_device_tree(void *fdt)
+{
+	int size;
+	void *dt;
+
+	size = fdt_totalsize(fdt);
+	dt = early_init_dt_alloc_memory_arch(size,
+					     roundup_pow_of_two(FDT_V17_SIZE));
+
+	if (dt)
+		memcpy(dt, fdt, size);
+
+	return dt;
+}
+
 /**
  * unflatten_device_tree - create tree of device_nodes from flat blob
  *
@@ -1350,22 +1365,9 @@ void __init unflatten_device_tree(void)
  */
 void __init unflatten_and_copy_device_tree(void)
 {
-	int size;
-	void *dt;
+	if (initial_boot_params)
+		initial_boot_params = copy_device_tree(initial_boot_params);
 
-	if (!initial_boot_params) {
-		pr_warn("No valid device tree found, continuing without\n");
-		return;
-	}
-
-	size = fdt_totalsize(initial_boot_params);
-	dt = early_init_dt_alloc_memory_arch(size,
-					     roundup_pow_of_two(FDT_V17_SIZE));
-
-	if (dt) {
-		memcpy(dt, initial_boot_params, size);
-		initial_boot_params = dt;
-	}
 	unflatten_device_tree();
 }
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


