Return-Path: <linux-kselftest+bounces-8649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA68AD922
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 01:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8341F23580
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A0156243;
	Mon, 22 Apr 2024 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaLYkfPa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1FE156227;
	Mon, 22 Apr 2024 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828257; cv=none; b=bPvg8ayT8GuKb3HBCBD1Xo6eyuD0T1zd1KgXFdIbUkiLEp7cZ7Ln+fDe5WcrpbEhIvvotl0FN42X7RkHl1WkkcTnrVhU64ISPwpjq2WbDuY/8TVqN9+qYKRxgGIwKimGYPVmWhk/etKW6RNIIZ+j1tQRuUVvXdtPGDxJK1f0m6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828257; c=relaxed/simple;
	bh=ZO5XbRoqkj4vulnlMKiEJRQ6DiRvmkJpDOISJAX5cTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JURUih3ZF1ltebeNpxfO1uASnec6D2baOhMp3Wjn0OyBeSfrHb3eFWZI5sn6ro8xuQkH3ZPnpKxzZ0XXVwdg/vw3cxuz1hsDJn4repyob+WIhJ/tvID1E13NPwlnJmMdGi8ZL0LGEVr09elAN2ro3Clfs8WcetkcZIZ4hIpSC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaLYkfPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48749C4AF0A;
	Mon, 22 Apr 2024 23:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713828257;
	bh=ZO5XbRoqkj4vulnlMKiEJRQ6DiRvmkJpDOISJAX5cTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaLYkfPa7tFJo8AdXWnY9vD2AD8xZf+zSs+YSx2mBdgVz+F2o3sUxUVP8NoSF14ka
	 5f9rAEnvERZxr+DgXL+lhklPh+Wtl/VSZ3voqxRmsRKVaBLkmQxKwe/LmuqarV49xp
	 knuDJWxCV4zEOeyNy3vM/8WuPAD23w2zkMvvRFMUqekLopqa39lfTFFeO7Shmx4ETI
	 +8dN/woVpwdrDTk5txMfWhsPxd+Qnys3seqs0TxaIKLl3hLIERcaxPEptQv5+7vxXc
	 GEeVAUREra84/zSg9cNDKI/wCxWkKq/RisEh1bMIPtiV0VpPoILAmIpQKXBxavZTOU
	 svyLsYmBhKn9Q==
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
Subject: [PATCH v4 09/10] dt-bindings: clk: Add KUnit clk_parent_data test
Date: Mon, 22 Apr 2024 16:24:02 -0700
Message-ID: <20240422232404.213174-10-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240422232404.213174-1-sboyd@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe a binding for a device that provides and consumes clks in DT so
that a KUnit test can register clks based on the device node and test
clk_hw_register() with clk_parent_data.

Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../bindings/clock/test,clk-parent-data.yaml  | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/test,clk-parent-data.yaml

diff --git a/Documentation/devicetree/bindings/clock/test,clk-parent-data.yaml b/Documentation/devicetree/bindings/clock/test,clk-parent-data.yaml
new file mode 100644
index 000000000000..a2f927526405
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/test,clk-parent-data.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/test,clk-parent-data.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fake clk provider for clk_parent_data unit tests
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description:
+  A clk provider to test the struct clk_parent_data implementation in the Linux
+  kernel.
+
+properties:
+  compatible:
+    const: test,clk-parent-data
+
+  clocks:
+    items:
+      - description: Fixed parent
+      - description: 50 MHz fixed parent
+
+  clock-names:
+    items:
+      - const: parent_fwname
+      - const: "50"
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+      compatible = "test,clk-parent-data";
+      #clock-cells = <1>;
+      clocks = <&fixed_parent>, <&fixed_50MHz>;
+      clock-names = "parent_fwname", "50";
+    };
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


