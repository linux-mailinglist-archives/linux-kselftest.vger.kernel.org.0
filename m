Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11736CB196
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 00:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjC0WWH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 18:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0WWG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 18:22:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F86E1BE2;
        Mon, 27 Mar 2023 15:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30BFEB819A9;
        Mon, 27 Mar 2023 22:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61150C4339B;
        Mon, 27 Mar 2023 22:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679955723;
        bh=bhokcF+DbXFgXVckSN1ln99pGP0gXkWwW2oZ9i5CFas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V00OL3jTV6QgFfjqOE7LoQL7xurcZ/rqpDoo2AY1Xnud9rwhZ9YIEBvLyS3lN4Khj
         d9PK8ZqYdm24hovlXOAVLpGrUeadXINpMU6zeXAM+q2pPwkAo42xoVqcJGU+ow/UXh
         MoMwVE6FwVUeO45ATrcvmxjk9XBcqZm53DrOFeF6EXHQnaJXEZfwS1W1rHwPqdogNx
         OAxKx5WD/+CuQjHAVuIsffRuKBoFDDfRumQckdgkHvzrQsuPyZtgWpoSX2tzmbF9IK
         XUh6X18WmVLuRx4DWu0+OMWdfM1aIwTZ00E62x2EaqYFQ+JwU4AYWP6pbQRfCkUPOC
         kCg8axYyioRtg==
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
Subject: [PATCH v3 04/11] dt-bindings: test: Add KUnit empty node binding
Date:   Mon, 27 Mar 2023 15:21:52 -0700
Message-Id: <20230327222159.3509818-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230327222159.3509818-1-sboyd@kernel.org>
References: <20230327222159.3509818-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Describe a binding for an empty device node used by KUnit tests to
confirm overlays load properly.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../devicetree/bindings/test/test,empty.yaml  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/test/test,empty.yaml

diff --git a/Documentation/devicetree/bindings/test/test,empty.yaml b/Documentation/devicetree/bindings/test/test,empty.yaml
new file mode 100644
index 000000000000..20dc83b15bbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/test/test,empty.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/test/test,empty.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Empty node
+
+maintainers:
+  - David Gow <davidgow@google.com>
+  - Brendan Higgins <brendanhiggins@google.com>
+
+description:
+  An empty node to confirm tests can load device tree overlays.
+
+properties:
+  compatible:
+    const: test,empty
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    kunit-node {
+      compatible = "test,empty";
+    };
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

