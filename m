Return-Path: <linux-kselftest+bounces-4901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA0858C97
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 02:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76AE283CF9
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6D420DD9;
	Sat, 17 Feb 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR7K0DPm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204FB20DC8;
	Sat, 17 Feb 2024 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131963; cv=none; b=RE73TTL+6qFg/1fDj7myE63Rrv+tWv9jr9giny4sYddvPJg2UWj8tX7fqhC52aTWcEclOHksiNq+DTbAAosi7Bg2+tyTCQeXl+eloE+NES2iE0Be6VqDxIS1BMMdbdlJmMIQ1SyD8v2ZFvLEPWkOpgaFjHqzGeneMYeMjJLeEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131963; c=relaxed/simple;
	bh=a4ZJdi1g6SmL1slfPXA0Sdc1BiW+RCSDLbBzSuVLxg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amxE400CZoowsYw2zfkccLCxp1YC3F4ttIa8iOZILzt8MUB4b0Id6ZmxwrPwWrUGS3BHawDBfk3NcQDHnCidSL0mMUdRCxnOwpvajLfKrO+jGHmnjphmDOcxcj8K+gEtL+wN8uWVljmTlnMKV7cjqD6rpBaB/M/+oixXJX1J57o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR7K0DPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294E0C43394;
	Sat, 17 Feb 2024 01:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131962;
	bh=a4ZJdi1g6SmL1slfPXA0Sdc1BiW+RCSDLbBzSuVLxg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fR7K0DPmwLwliOjcvLTQMYx/yhvXd+Lt+J20YtU0eJg9BBupTobaTXvHDKz0ElN1w
	 lyN91Teoqb6L2FiUFaTin94ppj2bXx/OQ+5Zh9nlGBCkw98caMK44i80kS9zuogCk7
	 mhCc644572dUf8Iq4dDijMBDhsqAR1qvwJuMq095NWCspfbOK6Sumcdd6hlvus4rY5
	 pJtJzorxKorAn51SisFu2bSBgpRVzJ6rZw7i2j2hIexRCBfO1hTtdhdRp1aExld7zC
	 LS7kGmSBV76MFa+4KC96o2AvD8CCs6u81WWqcJQR/bglZGe4WFTGsxvKciZGKD270o
	 ma7B4X6MmNn+A==
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
Subject: [PATCH v4 6/7] of: unittest: treat missing of_root as error instead of fixing up
Date: Fri, 16 Feb 2024 17:05:55 -0800
Message-ID: <20240217010557.2381548-7-sboyd@kernel.org>
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
index 891752a20a5f..4c67de37bf26 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1744,20 +1744,16 @@ static int __init unittest_data_add(void)
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


