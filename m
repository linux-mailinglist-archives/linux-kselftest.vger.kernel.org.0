Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C0B6A78FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCBBip (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjCBBin (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:38:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062E138032;
        Wed,  1 Mar 2023 17:38:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E59561547;
        Thu,  2 Mar 2023 01:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F3AC4339E;
        Thu,  2 Mar 2023 01:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677721107;
        bh=82/H9NmKlkCam/MX1SwZss+jj5L2cQaZPxt44VOdqIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClHeefyhLi2pHzIqItEz1Cg9pvG7jsw+TRCffg92mo+4as42h7NjVcqQ7aGpMUsMJ
         H4i3LOWqFKT3uUz0G8xcvn34yv/fG8Q8X4Jm4hthRYmdwASJfkhEcMcF2+8jzwmW+T
         j2XDFHyDgnakpgulnJIayrJWFvwZJCVrGjPlqgmvpmoJsb1GKMUEX7LDE+Ny6H5nst
         gskRJ11qaHSG5Z3sizLM8C3Kwb4VR8BkrZH6tCHZnEeXL5rSAFKHvfIpmrKL7b5oQj
         97PatdddLBVHL7TbM8MwEh1CtRC4G9PEbcdywmhmgpd8lk4MOBpZp6MPhXHZr0CeKy
         X2IjycdnIH8yQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 5/8] dt-bindings: kunit: Add fixed rate clk consumer test
Date:   Wed,  1 Mar 2023 17:38:18 -0800
Message-Id: <20230302013822.1808711-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
References: <20230302013822.1808711-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../kunit/linux,clk-kunit-fixed-rate.yaml     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/kunit/linux,clk-kunit-fixed-rate.yaml

diff --git a/Documentation/devicetree/bindings/kunit/linux,clk-kunit-fixed-rate.yaml b/Documentation/devicetree/bindings/kunit/linux,clk-kunit-fixed-rate.yaml
new file mode 100644
index 000000000000..2d46eb7a6273
--- /dev/null
+++ b/Documentation/devicetree/bindings/kunit/linux,clk-kunit-fixed-rate.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kunit/linux,clk-kunit-fixed-rate.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: KUnit clk fixed rate test clk consumer
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description: |
+  A clk consumer of a fixed rate clk used to test the fixed rate clk
+  implementation in the Linux kernel.
+
+properties:
+  compatible:
+    const: linux,clk-kunit-fixed-rate
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
+      compatible = "linux,clk-kunit-fixed-rate";
+      clocks = <&fixed_clk>;
+    };
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

