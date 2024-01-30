Return-Path: <linux-kselftest+bounces-3721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8C88417C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E66EB228DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F3D36B17;
	Tue, 30 Jan 2024 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAvRw3fA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CE36B02;
	Tue, 30 Jan 2024 00:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575515; cv=none; b=CmdTnOzxV4UL9ifg2zEv6f92Nn554VgpRdi9ZlhPugrGca61PaRoit63GPHHHP6UnqrchI+hc5YwdlTZOLHNFLydxcyqqX3OlHCjFdgRmzArWx5ya5lDSAUcYLJvs3vB/9RC55Hsfn0q8RDbnbMXs9y5xBoJfwQ4XEtWlyBcYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575515; c=relaxed/simple;
	bh=QNmBS0brQeJSjUserQhzHk2Vt2IzcbhX82b9CN/v9CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emrrLAf/68NPd7ZuNnZCeNsWAVZcKU56fWYqXCutdKLNZ3tDHzSbTKRTTvkutd5EPhbPb9PanyKJ9+LLWbckQxX4UjFMu5xh7PXnmIacZV+ydkzVEAGvL/Oog9Wuw2oUzF/IeZdw8PFHJZzzP/rz6Cmk5vo/Q1SThHfZ0ZeHH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAvRw3fA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C548C43399;
	Tue, 30 Jan 2024 00:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575514;
	bh=QNmBS0brQeJSjUserQhzHk2Vt2IzcbhX82b9CN/v9CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAvRw3fAoNWjiVmINtzMu5LYHOPzthZ41RXtSehMcsOa5hH/n47mQJbwPX2YmtRQH
	 bzWW1cBevhWm3guAvl0N4bT/8Is877dtInpWAtotrWqzYO0DdFYikRUBbXY+71z0iT
	 /pv5C9PH8rC3AmSPrzXXEB7xIE4NlYtlu0suj1aSB3RA3o39qzMCUBpl27IdEdtupr
	 jVCILCD5y8v/gEjL2xzgqAcFMBCJySfXA1Gwxafe26t3L/H+BORWJN4ONXYV3gI5gH
	 CVpyf+GvJfjjAqShbWztM2Npaan26dTC/XaAATjqVlON4splpFImESEFk1h1AOMSWI
	 +kqrvevHV7aEg==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 6/7] of: unittest: treat missing of_root as error instead of fixing up
Date: Mon, 29 Jan 2024 16:45:05 -0800
Message-ID: <20240130004508.1700335-7-sboyd@kernel.org>
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

From: Frank Rowand <frowand.list@gmail.com>

unflatten_device_tree() now ensures that the 'of_root' node is populated
with the root of a default empty devicetree. Remove the unittest code
that created 'of_root' if it was missing. Verify that 'of_root' is valid
before attempting to attach the testcase-data subtree. Remove the
unittest code that unflattens the unittest overlay base if architecture
is UML because that is always done now.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
Link: https://lore.kernel.org/r/20230317053415.2254616-3-frowand.list@gmail.com
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/unittest.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index a8b27dd16ecf..742d919e8ab4 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1732,20 +1732,16 @@ static int __init unittest_data_add(void)
 		return -EINVAL;
 	}
 
+	/* attach the sub-tree to live tree */
 	if (!of_root) {
-		of_root = unittest_data_node;
-		for_each_of_allnodes(np)
-			__of_attach_node_sysfs(np);
-		of_aliases = of_find_node_by_path("/aliases");
-		of_chosen = of_find_node_by_path("/chosen");
-		of_overlay_mutex_unlock();
-		return 0;
+		pr_warn("%s: no live tree to attach sub-tree\n", __func__);
+		kfree(unittest_data);
+		return -ENODEV;
 	}
 
 	EXPECT_BEGIN(KERN_INFO,
 		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
 
-	/* attach the sub-tree to live tree */
 	np = unittest_data_node->child;
 	while (np) {
 		struct device_node *next = np->sibling;
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


