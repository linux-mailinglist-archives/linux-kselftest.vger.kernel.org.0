Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434796BBC4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 19:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjCOSiN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjCOSiI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 14:38:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A643C5BCAB;
        Wed, 15 Mar 2023 11:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEAE3B81ED8;
        Wed, 15 Mar 2023 18:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0908C433AA;
        Wed, 15 Mar 2023 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678905452;
        bh=EFxqrYszB/6SHqjnakwbj0FJzNzPv1cwpyJhojl6Aek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gjb4q8qL5pVxyZgdeADmQBLan83VvAvrl1wHXV+pdjlukbOvYIBq2tEQrNgTc9bQP
         raoRfq+fIn8e5HxOhuzG1BDyLqXrn7yLP7HbdjBJYoYMPaKa51UwMzPMaSv0Jstpgr
         YJ/CmKS9i2EeSsKnK85SlxeqXydiCMKD3jL+8bmtw1e5qfZUZqm0Bzym9OtlmRaUBy
         /nLgEHykisM7I9FCLX2cbns2tEXANpmdzmXnFjwfelFrjBGg6ONwmS76rbljt/qdSs
         RZ6GibJVviF19QWdw6MNyjzccYAZWIwXOMDsn0Kh+Fx8VGgMtHUXTAffYa3ydjAGh6
         D+FCucH8XmKuA==
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
Subject: [PATCH v2 03/11] dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
Date:   Wed, 15 Mar 2023 11:37:20 -0700
Message-Id: <20230315183729.2376178-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315183729.2376178-1-sboyd@kernel.org>
References: <20230315183729.2376178-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the vendor prefix "test" to reserve a vendor prefix for bindings
that are purely for testing device tree code. This allows test code to
write bindings that can be checked by the schema validator.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca4..e50a78ec7344 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1331,6 +1331,8 @@ patternProperties:
     description: Terasic Inc.
   "^tesla,.*":
     description: Tesla, Inc.
+  "^test,.*":
+    description: Reserved for use by tests. For example, KUnit.
   "^tfc,.*":
     description: Three Five Corp
   "^thead,.*":
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

