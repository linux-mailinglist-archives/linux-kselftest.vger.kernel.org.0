Return-Path: <linux-kselftest+bounces-13505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE3C92D9C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 22:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C861C21078
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845C4198843;
	Wed, 10 Jul 2024 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhVt+GOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DAD19538B;
	Wed, 10 Jul 2024 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642368; cv=none; b=BSppBAcDUdalnodmT+YkkFrNgT04Fjy1s5f5DIP2NOCjNdBiCcrShYGBcqiO9oHONPgizA+RnjRqnPhTu65iuNwXRmxEZ86yajQnK47Ea9k+cTi8WFcEFigE+q8iU9hMG299Z7e44DSe/lUJq64uRWOV1YnDx8oWgyJ8S8uKkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642368; c=relaxed/simple;
	bh=MaieDaoyrxvy7cXpRNH8iNTTBi8f16Pt3VoIMf3+AD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krMbi21fWGJEoATKRkmvH3XXc9I7EuAFfnJIl57VWIwbQX0tEd/9S5jjGJg0TZ3OEPkWNl3uB7SRwJq+w04sOsf3ROkrIsWRgz19ahl37G+h0i3AoEFAuc9x4SKe/iZBhtrUftjAPLBf15ynjUrVgpbQ6aLcXuCGWCx9714Gpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhVt+GOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03960C32781;
	Wed, 10 Jul 2024 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720642367;
	bh=MaieDaoyrxvy7cXpRNH8iNTTBi8f16Pt3VoIMf3+AD8=;
	h=From:To:Cc:Subject:Date:From;
	b=bhVt+GOZRbYzhbNw12thhS2FGR4B1SIDcrdOVkDmTOfTr1IQ1VzT9/wrocq2FiPJt
	 pNPlLCbL6sduys1sXSFRv30k+jPGqAARz+dGP7lHIGgBKl7LO7B1VOYTTPFg4I5uxw
	 q0cofD9RlUIWgcnHrzGPx9NlFE87OAxV70Dc9F/36YIq6oB9fNYirWoXOoXCKaPmZ0
	 gVB82T4U4ePEeraKprA+6uUn+hKDN+EQ7qJM3JFEtgJCAdt60YH79QLYzsJSLWRROK
	 HSo5vTgupnW0J3Fk9fHhZwyFp1ZA5y2AYTiSkg0g0SG2ymQqgm/AHvfxE0kVrrdtfv
	 Ncy+IhALmzq7Q==
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
Subject: [PATCH v7 0/8] clk: Add kunit tests for fixed rate and parent data
Date: Wed, 10 Jul 2024 13:12:36 -0700
Message-ID: <20240710201246.1802189-1-sboyd@kernel.org>
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

Changes from v6: https://lore.kernel.org/r/20240706045454.215701-1-sboyd@kernel.org
 * Fix kasan error in platform test by fixing the condition to check for
   correct free callback
 * Add module descriptions to new modules

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
 drivers/clk/clk-fixed-rate_test.c             | 380 +++++++++++++++
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
 drivers/of/overlay_test.c                     | 115 +++++
 drivers/of/platform.c                         |   9 +-
 include/kunit/clk.h                           |  28 ++
 include/kunit/of.h                            | 115 +++++
 include/kunit/platform_device.h               |  20 +
 lib/kunit/Makefile                            |   4 +-
 lib/kunit/platform-test.c                     | 224 +++++++++
 lib/kunit/platform.c                          | 302 ++++++++++++
 28 files changed, 2087 insertions(+), 6 deletions(-)
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


