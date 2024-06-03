Return-Path: <linux-kselftest+bounces-11137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4308FA5A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD461F22779
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1713CF8D;
	Mon,  3 Jun 2024 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5hA0ee+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776D13CAB8;
	Mon,  3 Jun 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454294; cv=none; b=e/NlyGyEaUsT913TocEphdSHY6BbMebogPHNGb18cryFrE/Dgp74+RuSzzTzlBV0nuaMkB7dObDb9F2HfPbcUsKvGFnOQqGab4QpirMDUrBnt2wbLfpzAmmTxeGs12ZSBQgp3wmSCREFd3GKngHCyCIVnRMSBiYnd3nufIiJL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454294; c=relaxed/simple;
	bh=B0v2xIJko44NFxcAkJF3hOkV1yBox9EJRkSOKT1AxsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sByDFt1Vyccr18iiiEcualjRQVYJSCwj5o68/VUo9ZQBd3lQtpk04EFzqPAvpCE+p/ZzU/J+FPDmXMzKS1BQFqC+tlOb0OI1BElwZL758Acqn+BzQL5bVLkRTa8MIDW5PNu0X8pO6y7rejOUgqBLi96hqsgAsM5litXFqLEIcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5hA0ee+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4A7C4AF0A;
	Mon,  3 Jun 2024 22:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454293;
	bh=B0v2xIJko44NFxcAkJF3hOkV1yBox9EJRkSOKT1AxsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5hA0ee+3x+T1lL31FP9be1PVlkBcFeiA95+Pr9JAIM+lWR5phAqWag/ONX7JBDs6
	 RwUulF2tQGpSd7i+fnSYWcqrVllQJBqkBnqIeC6xWUc3gwaBCjKUie2y12dBiS4jbc
	 iG8y+MXcsvOeIYSOuvAnnswch3P2cCBGrp4J9+zuGXW4n0huG81V+529xkpHl2XriH
	 AtZAh3sXG3F0X1TEGVsYeFQV/Ns2N/EY+FEdC4DtytuvRR595e86aGJ7cOYwkyy5e1
	 5LCOu6E9NL+O5cVJoCXkZ3Q+XUUwDlbBmFudvPFcO8eqmmX5RG3LqqOpLhBsuoWjEq
	 PJjvkMCo97P+g==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v5 01/11] of/platform: Allow overlays to create platform devices from the root node
Date: Mon,  3 Jun 2024 15:37:58 -0700
Message-ID: <20240603223811.3815762-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240603223811.3815762-1-sboyd@kernel.org>
References: <20240603223811.3815762-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'd like to apply overlays to the root node in KUnit so we can test
platform devices created as children of the root node.

On some architectures (powerpc), the root node isn't marked with
OF_POPULATED_BUS. If an overlay tries to modify the root node on these
platforms it will fail, while on other platforms, such as ARM, it will
succeed. This is because the root node is marked with OF_POPULATED_BUS
by of_platform_default_populate_init() calling
of_platform_default_populate() with NULL as the first argument.

Loosen the requirement here so that platform devices can be created for
nodes created as children of the root node via DT overlays even if the
platform bus wasn't populated for the root node.

Cc: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/platform.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 389d4ea6bfc1..bda6da866cc8 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -732,11 +732,14 @@ static int of_platform_notify(struct notifier_block *nb,
 	struct of_reconfig_data *rd = arg;
 	struct platform_device *pdev_parent, *pdev;
 	bool children_left;
+	struct device_node *parent;
 
 	switch (of_reconfig_get_state_change(action, rd)) {
 	case OF_RECONFIG_CHANGE_ADD:
-		/* verify that the parent is a bus */
-		if (!of_node_check_flag(rd->dn->parent, OF_POPULATED_BUS))
+		parent = rd->dn->parent;
+		/* verify that the parent is a bus (or the root node) */
+		if (!of_node_is_root(parent) &&
+		    of_node_check_flag(parent, OF_POPULATED_BUS))
 			return NOTIFY_OK;	/* not for us */
 
 		/* already populated? (driver using of_populate manually) */
@@ -749,7 +752,7 @@ static int of_platform_notify(struct notifier_block *nb,
 		 */
 		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
 		/* pdev_parent may be NULL when no bus platform device */
-		pdev_parent = of_find_device_by_node(rd->dn->parent);
+		pdev_parent = of_find_device_by_node(parent);
 		pdev = of_platform_device_create(rd->dn, NULL,
 				pdev_parent ? &pdev_parent->dev : NULL);
 		platform_device_put(pdev_parent);
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


