Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB036CB19F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 00:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjC0WWQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 18:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjC0WWH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 18:22:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E6C3A82;
        Mon, 27 Mar 2023 15:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61CE56153A;
        Mon, 27 Mar 2023 22:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561C4C433D2;
        Mon, 27 Mar 2023 22:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679955725;
        bh=RvlyhYbptvBg73D2OHECbEteP6t+nqh7GcOpf9v1aEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTkAg0rxKzfKqWsxy/FOCMxmUQg3ulNMN7su2LSfBwnIWJH+cY+IuBsNdb48eKH+l
         klaU/1veZvXiRMRmE8Wo2gbKiR08CX0mwFF+xGTdTH/2R7z6Nwex+/fQLrp6x1mBck
         mllrbD5qEcHyiol48C94pNBlNwrvEV5PdsUo+ffPxQWH/7aTZyg6meW3ur4grkxVMD
         TUiW+jZCQWc/E1/KjsusQ/mmmlckkZYge9uAY1zVDnNStZKgOebs6KL8GNOsimVfEj
         NO4Vv9NhUBdneNnCZ2wYMxGxn1qleA9zlERC0S0dNKwdTrSoVRw6TzTdvmhDqXiAok
         BbWvzTPU2+fLQ==
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
Subject: [PATCH v3 07/11] dt-bindings: kunit: Add fixed rate clk consumer test
Date:   Mon, 27 Mar 2023 15:21:55 -0700
Message-Id: <20230327222159.3509818-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230327222159.3509818-1-sboyd@kernel.org>
References: <20230327222159.3509818-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Describe a binding for a device that consumes a fixed rate clk in DT so
that a KUnit test can get the clk registered by of_fixed_clk_setup() and
test that it is setup properly.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../bindings/test/test,clk-fixed-rate.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml

diff --git a/Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml b/Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml
new file mode 100644
index 000000000000..b9f58cba944c
--- /dev/null
+++ b/Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/test/test,clk-fixed-rate.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: KUnit clk fixed rate test clk consumer
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description:
+  A clk consumer of a fixed rate clk used to test the fixed rate clk
+  implementation.
+
+properties:
+  compatible:
+    const: test,clk-fixed-rate
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-consumer {
+      compatible = "test,clk-fixed-rate";
+      clocks = <&fixed_clk>;
+    };
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

