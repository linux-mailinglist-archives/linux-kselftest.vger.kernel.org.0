Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8E26A78EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCBBic (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCBBia (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:38:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8929E14;
        Wed,  1 Mar 2023 17:38:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E12C61542;
        Thu,  2 Mar 2023 01:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE626C43442;
        Thu,  2 Mar 2023 01:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677721104;
        bh=xlmggg4SwPHgsUHI5EKsdomiaUIjY1b7gCCFhpuQ1f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QX5VMEDWKzXOvBrh3s5n8VNsk9WCy+BA9LU0FftVmXQFxnx9N4tmGdqqJbt4HBNC/
         /Qlpzm4VHNwG1upxQs/3iAv3kEvXMUcNPICy2unmITpgwI27wshbBkaYelU99Og3/X
         p5YKr67RY+XlVu88alwK46oCYJX2sz1t55xB+CborNapRC+fVCStkxZLrs4vbUVQp8
         VkGBUpBi7nyiEcrDtkNgaz+3/+D2JOiC74nqF8N0t5IIQy6bc7yL9zxQMfRoYpZZcU
         f28hGP1XZakglVR91gvvQt0gH03SKVUs98uG1rm/CYB0ImCiuK9S8Hxa9KyjMIIN1F
         k/5ExXHAciHDA==
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
Subject: [PATCH 1/8] dt-bindings: Add linux,kunit binding
Date:   Wed,  1 Mar 2023 17:38:14 -0800
Message-Id: <20230302013822.1808711-2-sboyd@kernel.org>
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

Document the linux,kunit board compatible string. This board is loaded
into the Linux kernel when KUnit is testing devicetree dependent code.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../bindings/kunit/linux,kunit.yaml           | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/kunit/linux,kunit.yaml

diff --git a/Documentation/devicetree/bindings/kunit/linux,kunit.yaml b/Documentation/devicetree/bindings/kunit/linux,kunit.yaml
new file mode 100644
index 000000000000..dfe6da4796e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/kunit/linux,kunit.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kunit/linux,kunit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: KUnit
+
+maintainers:
+  - Brendan Higgins <brendanhiggins@google.com>
+  - David Gow <davidgow@google.com>
+
+description:
+  KUnit board used to unit test the Linux kernel in User Mode Linux (UML).
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    const: linux,kunit
+
+additionalProperties: true
+
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

