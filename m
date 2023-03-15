Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C16BBC47
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 19:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjCOSiF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjCOSiE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 14:38:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A15D2E80E;
        Wed, 15 Mar 2023 11:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D14CCB81EDA;
        Wed, 15 Mar 2023 18:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD527C433EF;
        Wed, 15 Mar 2023 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678905450;
        bh=AaKpurosJ1j97dxYAc0JwEaFhzjTwEBlY/xn7R5ple0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZRfAotrkR/tcowvtJczP0tt4ZyNvI9Q7qPl22XQVlrb0T0eO4vGZYe284aIicnyMo
         5ePPKPmzHEFsm+AxThe7+NPa1fJp5lB2yRgUjYmRbK65Y4BBvydY59q7p40lIcraAN
         26fX3poxwZ3gOpzcGv9EETJ4+oReIJtE31QVtJrAhGAEdjt2nbzu61BQKn8STLlb60
         G3mtJuDo/6/Uhig0ZT907tygl+F7VNr3Vs0Qp+a5dOkQ1ibauHm+SnN6lgQM0pTmlX
         3CAM5IeeBzt06fBt4wVh1yqnAK58hESUHztnQl8XnMTc67oufVlnoBYeUeAzaLMedS
         C7f30Q7teiC6Q==
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
Subject: [PATCH v2 00/11] clk: Add kunit tests for fixed rate and parent data
Date:   Wed, 15 Mar 2023 11:37:17 -0700
Message-Id: <20230315183729.2376178-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
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

Changes from v1 (https://lore.kernel.org/r/20230302013822.1808711-1-sboyd@kernel.org):
 * Don't depend on UML, use unittest data approach to attach nodes
 * Introduce overlay loading API for KUnit
 * Move platform_device KUnit code to drivers/base/test
 * Use #define macros for constants shared between unit tests and
   overlays
 * Settle on "test" as a vendor prefix
 * Make KUnit wrappers have "_kunit" postfix

Stephen Boyd (11):
  of: Load KUnit DTB from of_core_init()
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

 .../clock/test,clk-kunit-parent-data.yaml     |  47 ++
 .../kunit/test,clk-kunit-fixed-rate.yaml      |  35 ++
 .../bindings/test/test,kunit-empty.yaml       |  30 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/base/test/Makefile                    |   3 +
 drivers/base/test/platform_kunit-test.c       | 108 +++++
 drivers/base/test/platform_kunit.c            | 186 +++++++
 drivers/clk/.kunitconfig                      |   3 +
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   9 +-
 drivers/clk/clk-fixed-rate_test.c             | 299 ++++++++++++
 drivers/clk/clk-fixed-rate_test.h             |   8 +
 drivers/clk/clk_kunit.c                       | 219 +++++++++
 drivers/clk/clk_parent_data_test.h            |  10 +
 drivers/clk/clk_test.c                        | 459 +++++++++++++++++-
 drivers/clk/kunit_clk_fixed_rate_test.dtso    |  19 +
 drivers/clk/kunit_clk_parent_data_test.dtso   |  28 ++
 drivers/of/.kunitconfig                       |   5 +
 drivers/of/Kconfig                            |  23 +
 drivers/of/Makefile                           |   7 +
 drivers/of/base.c                             | 182 +++++++
 drivers/of/kunit.dtso                         |  10 +
 drivers/of/kunit_overlay_test.dtso            |   9 +
 drivers/of/of_kunit.c                         | 123 +++++
 drivers/of/of_private.h                       |   6 +
 drivers/of/of_test.c                          |  43 ++
 drivers/of/overlay_test.c                     | 107 ++++
 drivers/of/unittest.c                         | 101 +---
 include/kunit/clk.h                           |  28 ++
 include/kunit/of.h                            |  90 ++++
 include/kunit/platform_device.h               |  15 +
 31 files changed, 2119 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/test,clk-kunit-parent-data.yaml
 create mode 100644 Documentation/devicetree/bindings/kunit/test,clk-kunit-fixed-rate.yaml
 create mode 100644 Documentation/devicetree/bindings/test/test,kunit-empty.yaml
 create mode 100644 drivers/base/test/platform_kunit-test.c
 create mode 100644 drivers/base/test/platform_kunit.c
 create mode 100644 drivers/clk/clk-fixed-rate_test.c
 create mode 100644 drivers/clk/clk-fixed-rate_test.h
 create mode 100644 drivers/clk/clk_kunit.c
 create mode 100644 drivers/clk/clk_parent_data_test.h
 create mode 100644 drivers/clk/kunit_clk_fixed_rate_test.dtso
 create mode 100644 drivers/clk/kunit_clk_parent_data_test.dtso
 create mode 100644 drivers/of/.kunitconfig
 create mode 100644 drivers/of/kunit.dtso
 create mode 100644 drivers/of/kunit_overlay_test.dtso
 create mode 100644 drivers/of/of_kunit.c
 create mode 100644 drivers/of/of_test.c
 create mode 100644 drivers/of/overlay_test.c
 create mode 100644 include/kunit/clk.h
 create mode 100644 include/kunit/of.h
 create mode 100644 include/kunit/platform_device.h


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

