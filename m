Return-Path: <linux-kselftest+bounces-13265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523969290C8
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 06:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AE62836F2
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 04:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064381757E;
	Sat,  6 Jul 2024 04:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3lhWV0y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81C1BC41;
	Sat,  6 Jul 2024 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241696; cv=none; b=CuNBh6OFYg7gjshnpChFJ/it7pxKBDRnvbt0MFVFSjjRrFuKKP+H8uErN/lfNneUi5jsDXsxPNX4KzDW0/6c6ubEw9v47bxplfQ0NXMjlspanXx5nM2mcTws4LFv0ADrsXvfBqxkT0/KoaWH55IYZULIYEpvH3xEqP1XdNn0N28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241696; c=relaxed/simple;
	bh=8vksGDq15/DNxHKtUvp7xV+9TldcuzeVPL/jcUozy3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5wSfKHcFvHgA4oFfTUybCpMzIBGMMF8RJYiDH1ADw1vm5xVZ7kjGZIONXWFwhM+m2Ibec8zefdRO0C/+07VmevuZ8MUFSNshu2nR7Tfe4gqpCaEBD/yP4gGDvxI45QO7cvwqI0+FS//z4fQDehylkcHoOUGgbWPpZMuEGknGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3lhWV0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F90C2BD10;
	Sat,  6 Jul 2024 04:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720241696;
	bh=8vksGDq15/DNxHKtUvp7xV+9TldcuzeVPL/jcUozy3A=;
	h=From:To:Cc:Subject:Date:From;
	b=S3lhWV0y+tjs9ydq01PYIdr4TDuHD+DYMG8rfCOIZxyyrGyOxSkunL6iKSRQ8zWNM
	 9SUnpYbnyKmuUZcZejKEIMMmeuQjB3oGdtvlKPodihnQhYlJJ+UAO2/XXqx91wg8nI
	 D/4weedgYGjcJsNWaZxKhnJf2khN6YcFG6bL+7C3076rSDf6ZLt3KVqz23VaVVwnAF
	 DmcRpLO/yPGRKb+ara+msjfYZhVixqt9+caNHKYgSnszKpx9AderZG3OqkUPAz8Oa1
	 uSxzfP2Jy71sV6uO1CeMKxHIk+tOrtv2pcRIc9sC+kMRTw2sE2fwjcfy5u/6cIGrt6
	 rehVcTfwbJAaA==
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
Subject: [PATCH v6 0/8] clk: Add kunit tests for fixed rate and parent data
Date: Fri,  5 Jul 2024 21:54:45 -0700
Message-ID: <20240706045454.215701-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
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

Changes from v5: https://lore.kernel.org/r/20240603223811.3815762-1-sboyd@kernel.org
 * Pick up reviewed-by tags
 * Drop test vendor prefix bindings as dtschema allows anything now
 * Use of_node_put_kunit() more to plug some reference leaks
 * Select DTC config to avoid compile fails because of missing dtc
 * Don't skip for OF_OVERLAY in overlay tests because they depend on it

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

Stephen Boyd (8):
  of/platform: Allow overlays to create platform devices from the root
    node
  of: Add test managed wrappers for of_overlay_apply()/of_node_put()
  dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
  of: Add a KUnit test for overlays and test managed APIs
  platform: Add test managed platform_device/driver APIs
  clk: Add test managed clk provider/consumer APIs
  clk: Add KUnit tests for clk fixed rate basic type
  clk: Add KUnit tests for clks registered with struct clk_parent_data

 Documentation/dev-tools/kunit/api/clk.rst     |  10 +
 Documentation/dev-tools/kunit/api/index.rst   |  21 +
 Documentation/dev-tools/kunit/api/of.rst      |  13 +
 .../dev-tools/kunit/api/platformdevice.rst    |  10 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/clk/.kunitconfig                      |   2 +
 drivers/clk/Kconfig                           |  11 +
 drivers/clk/Makefile                          |   9 +-
 drivers/clk/clk-fixed-rate_test.c             | 379 +++++++++++++++
 drivers/clk/clk-fixed-rate_test.h             |   8 +
 drivers/clk/clk_kunit_helpers.c               | 204 ++++++++
 drivers/clk/clk_parent_data_test.h            |  10 +
 drivers/clk/clk_test.c                        | 453 +++++++++++++++++-
 drivers/clk/kunit_clk_fixed_rate_test.dtso    |  19 +
 drivers/clk/kunit_clk_parent_data_test.dtso   |  28 ++
 drivers/of/.kunitconfig                       |   1 +
 drivers/of/Kconfig                            |  10 +
 drivers/of/Makefile                           |   2 +
 drivers/of/kunit_overlay_test.dtso            |   9 +
 drivers/of/of_kunit_helpers.c                 |  74 +++
 drivers/of/overlay_test.c                     | 114 +++++
 drivers/of/platform.c                         |   9 +-
 include/kunit/clk.h                           |  28 ++
 include/kunit/of.h                            | 115 +++++
 include/kunit/platform_device.h               |  20 +
 lib/kunit/Makefile                            |   4 +-
 lib/kunit/platform-test.c                     | 223 +++++++++
 lib/kunit/platform.c                          | 302 ++++++++++++
 28 files changed, 2084 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/api/clk.rst
 create mode 100644 Documentation/dev-tools/kunit/api/of.rst
 create mode 100644 Documentation/dev-tools/kunit/api/platformdevice.rst
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


