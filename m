Return-Path: <linux-kselftest+bounces-13893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9CF9352AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 23:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C43281606
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E0B145B21;
	Thu, 18 Jul 2024 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKU9tb3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84889145B18;
	Thu, 18 Jul 2024 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336716; cv=none; b=l1gayMlIrDAxeRrTQyhuhZRkqvA3EuSD8aldWHdqPcLW9OCJ77SOAJmuwC32Ns2rUcNUs0SGYcpDcQgaDJvDF2J6UaxZ+OXfGk9BI69JYVe3q709TgNgMAiZkwETJCREQORy6r5gwvMThe5qU/hHMnvPvOAwhvisa5//YByE77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336716; c=relaxed/simple;
	bh=h2oJwQU0/OEuEguNkW78XbvG5WSjlncX73XA6xoFusY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5KI4e8ZNgLnAG4zjR3y8aCTsZp+U1FpEhD44HNyxYUkFdwxtJFi+ME5Oy5pLWjs3X+HYVZK/pDvylBSKMnO9GWaexVu22F5AIqYZTzEjsIu2P2+XK9x1wMHuLXVxuZVuNlLZGt7c1p59VjENyco/ulOy4t1BAYYnMsH0Pe70v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKU9tb3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2510BC4AF10;
	Thu, 18 Jul 2024 21:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721336716;
	bh=h2oJwQU0/OEuEguNkW78XbvG5WSjlncX73XA6xoFusY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKU9tb3LsEO8gMpunAfGrIh7xJrlGzJhcrb1p2+ePoURYORsAfCicT79iir9fk8qm
	 t9SuPV7XTp+QJXNustkT1nLw6gf6AK8soeFPy6SGlltpKPEX2hYPXPh/rX28Sd3zGV
	 6T1KAn9VwHeevi6JNHkA8Auo9M075XHX2JPbb/irCjppOFfvcMHCPJWlCt+Zs4n2FJ
	 DuuYXdxXU494VlJK3GqkhVisCHJeRY2a78ccVIpajTSv+gmBXn0L6hXZJREmjncrdc
	 d8P3DmFSmycEFtmuGMRE7ZBKGumnjOBDAP1u8braEyAynvCRvvAZLOO+5w0lBLNAIn
	 n3UsEEYgvlaYA==
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
	Maxime Ripard <maxime@cerno.tech>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v8 1/8] of/platform: Allow overlays to create platform devices from the root node
Date: Thu, 18 Jul 2024 14:05:00 -0700
Message-ID: <20240718210513.3801024-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240718210513.3801024-1-sboyd@kernel.org>
References: <20240718210513.3801024-1-sboyd@kernel.org>
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
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[sboyd@kernel.org: Folded in condition fix]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/platform.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 389d4ea6bfc1..86be4dfb9323 100644
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
+		    !of_node_check_flag(parent, OF_POPULATED_BUS))
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


