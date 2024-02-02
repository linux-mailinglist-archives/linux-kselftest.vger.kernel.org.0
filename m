Return-Path: <linux-kselftest+bounces-4041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91BC847A1D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 21:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB5CB289F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2B839E0;
	Fri,  2 Feb 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqr1TVIk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465485929;
	Fri,  2 Feb 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903956; cv=none; b=eRb7AJQOiPgL/JnlJcDNDsfNEdR4t/Uw9hMDQV79yX22a2BrxoYp5TpIfxLKVZ8oXlaEkNeGE3KTQQCc8Gbq4xmkSPn/0+/YHA6kME+aaTIU3QFnFCIC7qIymIR6goR/qhrBd/vIRuE+6TjHr74s5IEqWOzHTnUwXayqKP34Mfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903956; c=relaxed/simple;
	bh=QNmBS0brQeJSjUserQhzHk2Vt2IzcbhX82b9CN/v9CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7/jreHac22fAhfkEtVSnWkp1hNn1GMUX7S7YYIPWGJzlFOD91MZgAZ3tboTw8kFxVhVldPTJWwivsTvOyTxH5mAD6WhAvrHxGXyV3XJZOhD1MlGlMDDXoNttc7t2msE7pIPtOe+AzvNblT3qWHMaSHQ4bH9r/l+XMb7PVZZdIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqr1TVIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB81C43141;
	Fri,  2 Feb 2024 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903955;
	bh=QNmBS0brQeJSjUserQhzHk2Vt2IzcbhX82b9CN/v9CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqr1TVIkELbYe8QcCaThgPp5LfWi4EUBvIMppFR3VVYloXIkVaSj1nLdUvXnARg9u
	 W4AepGXy6uRZGg2L9PFyE7fy9ii7eFqT6dlWogyio4PE7QIoBYNy7tMnDPJ8UfC7hG
	 XFbmaFzRY/46VmL/ZfeffKX1wCpke+epxasSxyVyG3ZE8GhMyOB43ybYp65Se6knYS
	 adbMjrvYBVdu4eZEpmkn75FnBt+KEP63nyZeBhz6u4l5XoVWgDQlttPxbupz2oLhsm
	 s7YXw3hJ2rRF52Uz2vwU3YR5WfwgKeeO2H4/PfvHfC78HwzoSD7g5UczgKO8C9fD6x
	 i93LlSW/kUN1g==
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
Subject: [PATCH v3 6/7] of: unittest: treat missing of_root as error instead of fixing up
Date: Fri,  2 Feb 2024 11:59:07 -0800
Message-ID: <20240202195909.3458162-7-sboyd@kernel.org>
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


