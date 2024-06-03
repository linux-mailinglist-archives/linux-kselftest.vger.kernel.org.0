Return-Path: <linux-kselftest+bounces-11136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB98FA5A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C351C23CCA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561C913CA89;
	Mon,  3 Jun 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/sksQQu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381E136994;
	Mon,  3 Jun 2024 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454293; cv=none; b=KOquCgY9zcorISIEmKn9qm/NK6EEL9DNNIQABc5dhIiOjyEDH8EW0zMeeOA10TUzJP/tjgMwNUEXIeEfpjnuJleFs0zViHQnGAWNMnEdys119mjtucYmuBurhhJF4cgnigm1Vftuefhk6WGeJydVQpwyTwoN1aoMIGv2mK8FQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454293; c=relaxed/simple;
	bh=/LtFO6+a1nrgEoqGTrd435Gle++FVw+AHeRmey44ncQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ld0ltskNHaWxdFAQUC8Frt5tiO5Xy5n9eA7Bs0kJl/QSHwRw7Xpnj0E/0Zu0p6mTNR/XTPmmLx04LbclQA5o4lJ/xgQnNOj1gtJ9664hwCwf7JfnY5PCEC+m3dh2EW745al6c5vPxN1FNx9+lQhXh+OMy2F75tVufkXLnb4rli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/sksQQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4166C2BD10;
	Mon,  3 Jun 2024 22:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454292;
	bh=/LtFO6+a1nrgEoqGTrd435Gle++FVw+AHeRmey44ncQ=;
	h=From:To:Cc:Subject:Date:From;
	b=n/sksQQuIqdMPpOGkQzRWIoEwYxT8mGsJ/knUauZOAiYDcOLLXLQbrNGxwu17MkCu
	 1R2DmKjFDY+mkw+d7ME//mUR5ApmKsKvQnHGT+atMXmoyz9wXTvZf3VznwnlACyo3S
	 DQq8A6bHbRyN/P5Y58118fpG6DhVE071AWZZBxAQe2jIul31K5I9F/WDtyCcoxv4C3
	 x+C8EjS+RsORJj8p8T6BHAyQOUXCkqHFX1eaCNyQXpHULQEQaSZXe3qzAodH64Ufdl
	 fr0pNIgUSDjQPtExzSwhSQNxoPgV3wRCTlLxYe4NCzpx2ZWF7Tu1HHzZvTLvdIDaQG
	 ZhmfkC99djehw==
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
Subject: [PATCH v5 00/11] clk: Add kunit tests for fixed rate and parent data
Date: Mon,  3 Jun 2024 15:37:57 -0700
Message-ID: <20240603223811.3815762-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds unit tests for the clk fixed rate basic type and
the clk registration functions that use struct clk_parent_data. To get
there, we add support for loading device tree overlays onto the live DTB
along with probing platform drivers to bind to device nodes in the
overlays. With this series, we're able to exercise some of the code in
the common clk framework that uses devicetree lookups to find parents
and the fixed rate clk code that scans device tree directly and creates
clks. Please review.

I Cced everyone to all the patches so they get the full context. I'm
hoping I can take the whole pile through the clk tree as they all build
upon each other. Or the DT part can be merged through the DT tree to
reduce the dependencies.

Changes from v4: https://lore.kernel.org/r/20240422232404.213174-1-sboyd@kernel.org
 * Picked up reviewed-by tags
 * Check for non-NULL device pointers before calling put_device()
 * Fix CFI issues with kunit actions
 * Introduce platform_device_prepare_wait_for_probe() helper to wait for
   a platform device to probe
 * Move platform code to lib/kunit and rename functions to have kunit
   prefix
 * Fix issue with platform wrappers messing up reference counting
   because they used kunit actions
 * New patch to populate overlay devices on root node for powerpc
 * Make fixed-rate binding generic single clk consumer binding

Changes from v3: https://lore.kernel.org/r/20230327222159.3509818-1-sboyd@kernel.org
 * No longer depend on Frank's series[1] because it was merged upstream[2]
 * Use kunit_add_action_or_reset() to shorten code
 * Skip tests properly when CONFIG_OF_OVERLAY isn't set

Changes from v2: https://lore.kernel.org/r/20230315183729.2376178-1-sboyd@kernel.org
 * Overlays don't depend on __symbols__ node
 * Depend on Frank's always create root node if CONFIG_OF series[1]
 * Added kernel-doc to KUnit API doc
 * Fixed some kernel-doc on functions
 * More test cases for fixed rate clk

Changes from v1: https://lore.kernel.org/r/20230302013822.1808711-1-sboyd@kernel.org
 * Don't depend on UML, use unittest data approach to attach nodes
 * Introduce overlay loading API for KUnit
 * Move platform_device KUnit code to drivers/base/test
 * Use #define macros for constants shared between unit tests and
   overlays
 * Settle on "test" as a vendor prefix
 * Make KUnit wrappers have "_kunit" postfix

[1] https://lore.kernel.org/r/20230317053415.2254616-1-frowand.list@gmail.com
[2] https://lore.kernel.org/r/20240308195737.GA1174908-robh@kernel.org

Stephen Boyd (11):
  of/platform: Allow overlays to create platform devices from the root
    node
  of: Add test managed wrappers for of_overlay_apply()/of_node_put()
  dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
  dt-bindings: test: Add KUnit empty node binding
  of: Add a KUnit test for overlays and test managed APIs
  platform: Add test managed platform_device/driver APIs
  dt-bindings: test: Add single clk consumer
  clk: Add test managed clk provider/consumer APIs
  clk: Add KUnit tests for clk fixed rate basic type
  dt-bindings: clk: Add clk_parent_data test
  clk: Add KUnit tests for clks registered with struct clk_parent_data

 Documentation/dev-tools/kunit/api/clk.rst     |  10 +
 Documentation/dev-tools/kunit/api/index.rst   |  21 +
 Documentation/dev-tools/kunit/api/of.rst      |  13 +
 .../dev-tools/kunit/api/platformdevice.rst    |  10 +
 .../bindings/clock/test,clk-parent-data.yaml  |  47 ++
 .../devicetree/bindings/test/test,empty.yaml  |  30 ++
 .../test/test,single-clk-consumer.yaml        |  34 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/clk/.kunitconfig                      |   2 +
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   9 +-
 drivers/clk/clk-fixed-rate_test.c             | 379 +++++++++++++++
 drivers/clk/clk-fixed-rate_test.h             |   8 +
 drivers/clk/clk_kunit_helpers.c               | 204 ++++++++
 drivers/clk/clk_parent_data_test.h            |  10 +
 drivers/clk/clk_test.c                        | 451 +++++++++++++++++-
 drivers/clk/kunit_clk_fixed_rate_test.dtso    |  19 +
 drivers/clk/kunit_clk_parent_data_test.dtso   |  28 ++
 drivers/of/.kunitconfig                       |   1 +
 drivers/of/Kconfig                            |  10 +
 drivers/of/Makefile                           |   2 +
 drivers/of/kunit_overlay_test.dtso            |   9 +
 drivers/of/of_kunit_helpers.c                 |  74 +++
 drivers/of/overlay_test.c                     | 116 +++++
 drivers/of/platform.c                         |   9 +-
 include/kunit/clk.h                           |  28 ++
 include/kunit/of.h                            | 115 +++++
 include/kunit/platform_device.h               |  20 +
 lib/kunit/Makefile                            |   4 +-
 lib/kunit/platform-test.c                     | 223 +++++++++
 lib/kunit/platform.c                          | 302 ++++++++++++
 31 files changed, 2193 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/api/clk.rst
 create mode 100644 Documentation/dev-tools/kunit/api/of.rst
 create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
 create mode 100644 Documentation/devicetree/bindings/clock/test,clk-parent-data.yaml
 create mode 100644 Documentation/devicetree/bindings/test/test,empty.yaml
 create mode 100644 Documentation/devicetree/bindings/test/test,single-clk-consumer.yaml
 create mode 100644 drivers/clk/clk-fixed-rate_test.c
 create mode 100644 drivers/clk/clk-fixed-rate_test.h
 create mode 100644 drivers/clk/clk_kunit_helpers.c
 create mode 100644 drivers/clk/clk_parent_data_test.h
 create mode 100644 drivers/clk/kunit_clk_fixed_rate_test.dtso
 create mode 100644 drivers/clk/kunit_clk_parent_data_test.dtso
 create mode 100644 drivers/of/kunit_overlay_test.dtso
 create mode 100644 drivers/of/of_kunit_helpers.c
 create mode 100644 drivers/of/overlay_test.c
 create mode 100644 include/kunit/clk.h
 create mode 100644 include/kunit/of.h
 create mode 100644 include/kunit/platform_device.h
 create mode 100644 lib/kunit/platform-test.c
 create mode 100644 lib/kunit/platform.c


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


