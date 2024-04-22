Return-Path: <linux-kselftest+bounces-8640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821358AD901
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 01:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD5F1F23580
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493B6446B6;
	Mon, 22 Apr 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8yAgiDA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6E2942F;
	Mon, 22 Apr 2024 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828247; cv=none; b=NMHf8CJfgTCfa/UuC5GieYg4u5uR5wVfiPLjYOMCkST/xy/FhdQiRawTgzdSMn3M22A7r/zW/naYx9Etzm9OuaetkMy4ZzItJA/nVu2sbpyC+zoPU/qT/f07ZX3is3H+V5oFgTvP8qQVWGkxqiMDNiI+WVqbqUglM9h4fXPwxzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828247; c=relaxed/simple;
	bh=v3XW2cYQ79gqDMbF1UVESANI0NiQDi505TJ8KLujo5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mulC7ptUOK1PmkPxdYk00nUKMamoFbWqdYfOUsu1UNATzmsZyYqVtN4n0BYY/rh4nSU31E4oSxq5Shzg9MyDXP3fvhRslmJ7rtQcbc1oCpZwUSBcYTzJaco7Z/9tZ7Vr93PEBu0zRtpT8RpvRvPZLY1jVsQtd3TzTtbek9282w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8yAgiDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B6DC113CC;
	Mon, 22 Apr 2024 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713828246;
	bh=v3XW2cYQ79gqDMbF1UVESANI0NiQDi505TJ8KLujo5k=;
	h=From:To:Cc:Subject:Date:From;
	b=s8yAgiDABYJJ5Q6dUW0bQqyeiS8he+8GKi6+qSH2CUjwIshTMK2Pmweg6oyFqcvce
	 fVdaffWRShYGJ8PlgFk6UIM0a/ie3FY+avPhCyXknhkizTBzYmS5oRAhifjXIU9Bj+
	 3yXDzzPDC6LWdVFOYJZu0hFT3i++tZF7ZxJxtV5FUSOUPdgWpTFmtU/Tqol6EZF+K2
	 ZtqURe1IlXFEDkPbwts/B7hBcH09GXRFg3IDbs4sG+Rjns3fMnvf0BUERcRsl4FcCv
	 /FxhJEqvCwwDxYbI3yzO2R7Ln2N9AlRiVGL5xMah5oMP2YeUmzixTqQjeLRTfZy1nT
	 X6Kgf1sBnttMA==
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
Subject: [PATCH v4 00/10] clk: Add kunit tests for fixed rate and parent data
Date: Mon, 22 Apr 2024 16:23:53 -0700
Message-ID: <20240422232404.213174-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
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

Changes from v3 (https://lore.kernel.org/r/20230327222159.3509818-1-sboyd@kernel.org):
 * No longer depend on Frank's series[1] because it was merged upstream[2]
 * Use kunit_add_action_or_reset() to shorten code
 * Skip tests properly when CONFIG_OF_OVERLAY isn't set

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

[1] https://lore.kernel.org/r/20230317053415.2254616-1-frowand.list@gmail.com
[2] https://lore.kernel.org/r/20240308195737.GA1174908-robh@kernel.org

Stephen Boyd (10):
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
 Documentation/dev-tools/kunit/api/index.rst   |  21 +
 Documentation/dev-tools/kunit/api/of.rst      |  13 +
 .../dev-tools/kunit/api/platformdevice.rst    |  10 +
 .../bindings/clock/test,clk-parent-data.yaml  |  47 ++
 .../bindings/test/test,clk-fixed-rate.yaml    |  35 ++
 .../devicetree/bindings/test/test,empty.yaml  |  30 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/base/test/Makefile                    |   3 +
 drivers/base/test/platform_kunit-test.c       | 140 ++++++
 drivers/base/test/platform_kunit.c            | 174 +++++++
 drivers/clk/.kunitconfig                      |   2 +
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   9 +-
 drivers/clk/clk-fixed-rate_test.c             | 377 +++++++++++++++
 drivers/clk/clk-fixed-rate_test.h             |   8 +
 drivers/clk/clk_kunit.c                       | 198 ++++++++
 drivers/clk/clk_parent_data_test.h            |  10 +
 drivers/clk/clk_test.c                        | 451 +++++++++++++++++-
 drivers/clk/kunit_clk_fixed_rate_test.dtso    |  19 +
 drivers/clk/kunit_clk_parent_data_test.dtso   |  28 ++
 drivers/of/.kunitconfig                       |   1 +
 drivers/of/Kconfig                            |  10 +
 drivers/of/Makefile                           |   2 +
 drivers/of/kunit_overlay_test.dtso            |   9 +
 drivers/of/of_kunit.c                         |  99 ++++
 drivers/of/overlay_test.c                     | 115 +++++
 include/kunit/clk.h                           |  28 ++
 include/kunit/of.h                            |  94 ++++
 include/kunit/platform_device.h               |  15 +
 30 files changed, 1967 insertions(+), 2 deletions(-)
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
 create mode 100644 drivers/of/kunit_overlay_test.dtso
 create mode 100644 drivers/of/of_kunit.c
 create mode 100644 drivers/of/overlay_test.c
 create mode 100644 include/kunit/clk.h
 create mode 100644 include/kunit/of.h
 create mode 100644 include/kunit/platform_device.h


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


