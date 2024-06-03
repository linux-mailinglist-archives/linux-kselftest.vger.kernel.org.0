Return-Path: <linux-kselftest+bounces-11146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7801E8FA5C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFFB1F22C7E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0E013E02A;
	Mon,  3 Jun 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkoWgQOy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C013DDD8;
	Mon,  3 Jun 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454303; cv=none; b=PR0pVz8EjN94EWE/1ia3ixZdNJ4kdgiM59MnmcV9h9Q0PXygC6T+VFXsS9Xs/PVZ8+BKFH6gALit90BeinVCZMOtEdIOcvT76E/WoUrPJOqZraHvgzqvyoUWdc6Fd0xGaTfzZbzSg7EMFJ62k7kVHzUckO4wYFlKeGPxXp7XLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454303; c=relaxed/simple;
	bh=FMyDSBkfp9i2ZWHdkwWdj6QlMQ4rdVZH1vXQ8vyRfOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXbABe+lrPEv/3z+D/uOrBYrTRMKkT3B7sGct4s+OdImdOX7jjsm7hGLDLqDE5CGuDEfwDO/sqQ6o28b665jM/UuECDrWxuYWh382AcG8JoCF6B7yEf0s2qw3/vWIswfh0OGg1DX6mPNg9+PW1RbFQYv0X4Cf1Vkd3X8s8aAlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkoWgQOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACCAC4AF18;
	Mon,  3 Jun 2024 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454303;
	bh=FMyDSBkfp9i2ZWHdkwWdj6QlMQ4rdVZH1vXQ8vyRfOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MkoWgQOyTgsZo1XVfVUEvnhCB4rks0sjiX/UHnThimrx+m57GY51lrs5z1kH4Lcbz
	 Bb6E8NQJpiZubmzczjM1j4TXPki67YILXpFQPzjvIKkqZ6u6155i0OnEX4AgXQ2QI+
	 bi/8YfxRrm8ptaocb2WrYI4z2zBat0sLYqtyElZmvH0EK3Kogl0rIEuW9MP9a2N6nO
	 keEavmEr7d9cRPxER90Yma47kJuBSvvs9ZHjrpduOkwp1zEh/pvzj6GHp1CwNlJtDi
	 0Dyn7QLpYq5dou57qaO3T6qNq8VS45KeIaBmOe5Jv3Sq+1pRo+hDKnbiWLR+3Kg48X
	 PzTTMnxAZ3R7A==
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
Subject: [PATCH v5 10/11] dt-bindings: clk: Add clk_parent_data test
Date: Mon,  3 Jun 2024 15:38:07 -0700
Message-ID: <20240603223811.3815762-11-sboyd@kernel.org>
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

Describe a binding for a device that provides and consumes clks in DT so
that a KUnit test can register clks based on the device node and test
clk_hw_register() with struct clk_parent_data.

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


