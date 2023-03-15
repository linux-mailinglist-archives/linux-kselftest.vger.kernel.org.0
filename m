Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942AF6BBC53
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 19:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjCOSiO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjCOSiJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 14:38:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B139BA58;
        Wed, 15 Mar 2023 11:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C529D61E3C;
        Wed, 15 Mar 2023 18:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC07BC433AA;
        Wed, 15 Mar 2023 18:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678905457;
        bh=+IVvkQrzSA4hm1JV3KHEDzwagCuncHGxrIZJFvXhdgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMxDonUQqA6TI49xCL1QMkaCrG3vR/KwE7uNeC5xVmj009k50w8zzmXGT1N3WvosY
         BWxFHsJ/6in114u5xYmtxdPzysDKTwhgQCokBaReGLo57r9cEbv2BIvly9M84EmU3c
         gfTNYOr2t+IxfnjE3DnAsxKRNMLde5hzdyDVuOaMXYw68bqeuf3o+zgk/Qy9IfxQvr
         43/bU1i6g3ROF7IVv/Ao20vGwLBM0jax0pbKfhnoFDxtBqFsLBmTgoGnq1Wl9fXpjr
         cM75aVLWe90GbS2MZI7Fvf8O+oQ0eH1w8Bv1x5Z1wwl6hpzGfBZjC5nxlT83QTo8vb
         NiMPiM85ZR2nw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 10/11] dt-bindings: clk: Add KUnit clk_parent_data test
Date:   Wed, 15 Mar 2023 11:37:27 -0700
Message-Id: <20230315183729.2376178-11-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315183729.2376178-1-sboyd@kernel.org>
References: <20230315183729.2376178-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Describe a binding for a device that provides and consumes clks in DT so
that a KUnit test can register clks based on the device node and test
clk_hw_register() with clk_parent_data.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../clock/test,clk-kunit-parent-data.yaml     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/test,clk-kunit-parent-data.yaml

diff --git a/Documentation/devicetree/bindings/clock/test,clk-kunit-parent-data.yaml b/Documentation/devicetree/bindings/clock/test,clk-kunit-parent-data.yaml
new file mode 100644
index 000000000000..ece47f05c498
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/test,clk-kunit-parent-data.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/test,clk-kunit-parent-data.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: KUnit clk provider for clk_parent_data unit tests
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description: |
+  A clk provider to test the struct clk_parent_data implementation in the Linux
+  kernel.
+
+properties:
+  compatible:
+    const: test,clk-kunit-parent-data
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
+      compatible = "test,clk-kunit-parent-data";
+      #clock-cells = <1>;
+      clocks = <&fixed_parent>, <&fixed_50MHz>;
+      clock-names = "parent_fwname", "50";
+    };
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

