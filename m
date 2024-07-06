Return-Path: <linux-kselftest+bounces-13266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB12A9290CB
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 06:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561B61F2262A
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 04:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290BA17C7F;
	Sat,  6 Jul 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0v1leLU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7094179BD;
	Sat,  6 Jul 2024 04:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241698; cv=none; b=naiZnivPhGhVbh/xbosccrPDXUrYGVxDBHZmpr2bnDQFqf6gKRNwDTVnoyEq0fXfJMsIeN5732on8gPDewOBHG6I2wZNooMgoa/WSJV+B7W7s6m5UqAPSpZqSnCacLdLtlBX0mlRX78z9pOI7NeptYMM9yZP8pLw1fsWueY2mTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241698; c=relaxed/simple;
	bh=mbvqYPnjN0sDSYQIJsVwrvYeH1A/tqHM51IP0m7w1W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dht/sPMbW2wMD0mXHWRoGH0ST8hZ2XOLadUoFr1kXMDzeNWAI11HN1Xx/SeTTrUI5xQ0LnHbiJvQP6pyzK2bn85FyEhnV7YsxLTjVBDIryhzZ18aVQIBnz9LOpTVn7SHM/GGY0kXmDMSMXXyAgTs4n3aB52PkSDspJlkhf/CwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0v1leLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737E5C4AF0A;
	Sat,  6 Jul 2024 04:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720241697;
	bh=mbvqYPnjN0sDSYQIJsVwrvYeH1A/tqHM51IP0m7w1W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0v1leLUst/yB+vL+fTBV3hNPKK0sNEeksDI1wwH/5DFeyPFfl/LibgTAjRdWAoci
	 d2d/9FeHXkTRTqJ3Ow+8E/v5H+iLeHJ0Cmak0Q/6iJsVCWRM4bfNKnCTzXlPrepLGQ
	 J6SMr2BZyw4KcdycA1n6/eTamlLOkAjpvDX9hEq1rtB7OSbF4jRwFB9bYTKgHY4dxW
	 CI6j50yedQKexubvJmjaEvzvKaJhdPt735deZzT2ulEIWx3wCq3PFO0nYwywE0+9M0
	 g1KX9x+btHLJWU+UuXjXA5K2PZjHIxlORCpbqrM7J0/QKElA2AzRT7gp1J3o/vhBii
	 M2l3pi69+HeHw==
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
Subject: [PATCH v6 1/8] of/platform: Allow overlays to create platform devices from the root node
Date: Fri,  5 Jul 2024 21:54:46 -0700
Message-ID: <20240706045454.215701-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240706045454.215701-1-sboyd@kernel.org>
References: <20240706045454.215701-1-sboyd@kernel.org>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


