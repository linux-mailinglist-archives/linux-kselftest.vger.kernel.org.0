Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6256CB18D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 00:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjC0WWE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 18:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0WWD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 18:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545E819AB;
        Mon, 27 Mar 2023 15:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2EB161515;
        Mon, 27 Mar 2023 22:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EA5C433D2;
        Mon, 27 Mar 2023 22:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679955721;
        bh=eKuJITkoxqhZCZOC1IuQzXCvD8LrADrZd8fL1T4iFng=;
        h=From:To:Cc:Subject:Date:From;
        b=NIyZrCk80QtRzROOaNAhNosmAmA3W3l1Z/dpiP2TrP48iz/L06X4ZByXtXeDP0M9v
         1Q1pukhLTGU1eNRDo6UXUSmhqo29bLrn+Dzlw2d5CcrwsqTLEGeGYlMqOgdgCVahFf
         gvrdMQDmwR9p1KMUosgqAx5ROY7qvRHlCLFH36I6GRoOzJoWOnA0duGqLJKKZWVx/Q
         RQFf51PFdHQ6Rl00FKb8o2tBmRmhg1U4LzrP+BtdAlCL+z04PlPd7gI2upBcV82VbF
         r8pQN2vWlxXtxlxuFsTxtRXtf8EEtIpXQLmTjyKStvcCsU7vcbvS8t2g4Ewg6Ow1LE
         dwphmNKuTjOmg==
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
Subject: [PATCH v3 00/11] clk: Add kunit tests for fixed rate and parent data
Date:   Mon, 27 Mar 2023 15:21:48 -0700
Message-Id: <20230327222159.3509818-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
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

This patch series adds unit tests for the clk fixed rate basic type and
the clk registration functions that use struct clk_parent_data. To get
there, we add support for loading device tree overlays onto the live DTB
along with probing platform drivers to bind to device nodes in the
overlays. With this series, we're able to exercise some of the code in
the common clk framework that uses devicetree lookups to find parents
and the fixed rate clk code that scans device tree directly and creates
clks. Please review.

I Cced everyone to all the patches so they get the full context. I'm
hoping I can take the whole pile through the clk tree as they almost all
depend on each other.

Changes from v2 (https://lore.kernel.org/r/20230315183729.2376178-1-sboyd@kernel.org):
 * Overlays don't depend on __symbols__ node
 * Depend on Frank's always create root node if CONFIG_OF series[1]
 * Added kernel-doc to KUnit API doc
 * Fixed some kernel-doc on functions
 * More test cases for fixed rate clk

Changes from v1 (https://lore.kernel.org/r/20230302013822.1808711-1-sboyd@kernel.org):
 * Don't depend on UML, use unittest data approach to attach nodes
 * Introduce overlay loading API for KUnit
 * Move platform_device KUnit code to drivers/base/test
 * Use #define macros for constants shared between unit tests and
   overlays
 * Settle on "test" as a vendor prefix
 * Make KUnit wrappers have "_kunit" postfix

Stephen Boyd (11):
  of: Add KUnit test to confirm DTB is loaded
  of: Add test managed wrappers for of_overlay_apply()/of_node_put()
  dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
  dt-bindings: test: Add KUnit empty node binding
  of: Add a KUnit test for overlays and test managed APIs
  platform: Add test managed platform_device/driver APIs
  dt-bindings: kunit: Add fixed rate clk consumer test
  clk: Add test managed clk provider/consumer APIs
  clk: Add KUnit tests for clk fixed rate basic type
  dt-bindings: clk: Add KUnit clk_parent_data test
  clk: Add KUnit tests for clks registered with struct clk_parent_data

 Documentation/dev-tools/kunit/api/clk.rst     |  10 +
 Documentation/dev-tools/kunit/api/index.rst   |  22 +
 Documentation/dev-tools/kunit/api/of.rst      |  13 +
 .../dev-tools/kunit/api/platformdevice.rst    |  10 +
 .../bindings/clock/test,clk-parent-data.yaml  |  47 ++
 .../bindings/test/test,clk-fixed-rate.yaml    |  35 ++
 .../devicetree/bindings/test/test,empty.yaml  |  30 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/base/test/Makefile                    |   3 +
 drivers/base/test/platform_kunit-test.c       | 140 ++++++
 drivers/base/test/platform_kunit.c            | 215 ++++++++
 drivers/clk/.kunitconfig                      |   3 +
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   9 +-
 drivers/clk/clk-fixed-rate_test.c             | 374 ++++++++++++++
 drivers/clk/clk-fixed-rate_test.h             |   8 +
 drivers/clk/clk_kunit.c                       | 224 +++++++++
 drivers/clk/clk_parent_data_test.h            |  10 +
 drivers/clk/clk_test.c                        | 459 +++++++++++++++++-
 drivers/clk/kunit_clk_fixed_rate_test.dtso    |  19 +
 drivers/clk/kunit_clk_parent_data_test.dtso   |  28 ++
 drivers/of/.kunitconfig                       |   5 +
 drivers/of/Kconfig                            |  19 +
 drivers/of/Makefile                           |   4 +
 drivers/of/kunit_overlay_test.dtso            |   9 +
 drivers/of/of_kunit.c                         | 125 +++++
 drivers/of/of_test.c                          |  34 ++
 drivers/of/overlay_test.c                     | 110 +++++
 include/kunit/clk.h                           |  28 ++
 include/kunit/of.h                            |  94 ++++
 include/kunit/platform_device.h               |  15 +
 31 files changed, 2109 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/api/clk.rst
 create mode 100644 Documentation/dev-tools/kunit/api/of.rst
 create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
 create mode 100644 Documentation/devicetree/bindings/clock/test,clk-parent-data.yaml
 create mode 100644 Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml
 create mode 100644 Documentation/devicetree/bindings/test/test,empty.yaml
 create mode 100644 drivers/base/test/platform_kunit-test.c
 create mode 100644 drivers/base/test/platform_kunit.c
 create mode 100644 drivers/clk/clk-fixed-rate_test.c
 create mode 100644 drivers/clk/clk-fixed-rate_test.h
 create mode 100644 drivers/clk/clk_kunit.c
 create mode 100644 drivers/clk/clk_parent_data_test.h
 create mode 100644 drivers/clk/kunit_clk_fixed_rate_test.dtso
 create mode 100644 drivers/clk/kunit_clk_parent_data_test.dtso
 create mode 100644 drivers/of/.kunitconfig
 create mode 100644 drivers/of/kunit_overlay_test.dtso
 create mode 100644 drivers/of/of_kunit.c
 create mode 100644 drivers/of/of_test.c
 create mode 100644 drivers/of/overlay_test.c
 create mode 100644 include/kunit/clk.h
 create mode 100644 include/kunit/of.h
 create mode 100644 include/kunit/platform_device.h

[1] https://lore.kernel.org/r/20230317053415.2254616-1-frowand.list@gmail.com

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
prerequisite-patch-id: 33517b96dd0768ab9c265f5721629786354ee320
prerequisite-patch-id: 909221815eeca0a2b0cdd385c76f57e185fb9e33
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

