Return-Path: <linux-kselftest+bounces-3719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F0F8417BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D455C286074
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459BD364C8;
	Tue, 30 Jan 2024 00:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz2zfn9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15742364BA;
	Tue, 30 Jan 2024 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575514; cv=none; b=dKVzWGO/VeyJuEegVdyXfe/CfYoF358obfPho4AAgRQF9wFmYPKTllmvo5jv2OjhT61dA/caIWA8ZxpvfxwGDyS+2QOqAipve0FMUMNNviglCvEvGtnYp5xk1tqO57jSBpCpyENduDVd60Oz9sXThB3b4vYAzCekLjuJDqS30pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575514; c=relaxed/simple;
	bh=1E4tLOV0ALY1Bfj9SzYihrCA2jRIId2N3gEBgK6iS+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShYGM9ShXNFrjPY1MYQF8dpWnMoNBqKWctu8GVe+yZY+QOQZH4FitKjHA6o3f7TaRyWj3UAfkFgkMpFY//wFUR2KUA/D39rH3Q4EIF7djsRRFB2YIotupVKiZQNxRRXh3usm39swDVF1aeGYQyhobk1OR+l6Z6RimASFcmc3uPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz2zfn9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BA9C433A6;
	Tue, 30 Jan 2024 00:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575513;
	bh=1E4tLOV0ALY1Bfj9SzYihrCA2jRIId2N3gEBgK6iS+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iz2zfn9aqvK2c8BkZWCB3BAiuj857Wo7xdv7e2MGsiieVxtEq3tzTJQUvFm9+NaW3
	 PpxGQgfXslXyjDpqx7Cpd+3+ZAsqiGC9De6l1kwIHpC33MneTUcp0h/9TYnUuRaZPa
	 tOIQo6Wjnc9dW1MXMwmUtGjqTyePE19xg4Y9ddsWcSXYierDRxrSujqGPcarNVHik2
	 5RGpnD6SxyNiWWdaVbtmJcXatXlru45w+1Gyy05Y2KfeZvClAbpN0YVOZ+Jv6IOzcZ
	 eeUPiglgbn2Gc/3/k2jKOR6kXFwnoZ7eSy9AEPMgRlbKwt0e6lGMsLAbRd8tX5Ztwf
	 gQGwkNDOAS8iA==
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
Subject: [PATCH v2 4/7] of: Always unflatten in unflatten_and_copy_device_tree()
Date: Mon, 29 Jan 2024 16:45:03 -0800
Message-ID: <20240130004508.1700335-5-sboyd@kernel.org>
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
index bf502ba8da95..b488ad86d456 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1318,6 +1318,21 @@ bool __init early_init_dt_scan(void *params)
 	return true;
 }
 
+static void __init copy_device_tree(void)
+{
+	int size;
+	void *dt;
+
+	size = fdt_totalsize(initial_boot_params);
+	dt = early_init_dt_alloc_memory_arch(size,
+					     roundup_pow_of_two(FDT_V17_SIZE));
+
+	if (dt) {
+		memcpy(dt, initial_boot_params, size);
+		initial_boot_params = dt;
+	}
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
+		copy_device_tree();
 
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


