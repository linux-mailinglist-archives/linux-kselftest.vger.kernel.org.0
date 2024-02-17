Return-Path: <linux-kselftest+bounces-4895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B30858C85
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 02:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616E8283313
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310D31C2AF;
	Sat, 17 Feb 2024 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcUiJwYx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B5F1E888;
	Sat, 17 Feb 2024 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131959; cv=none; b=X3mhtLV9DicOtsCl1qFojyMzRPe+l8IgBmlqEoKc6a4UAEjpx2nwCLrSPSeyvlIOilsEADoo+FZzoCEYU56rw7Y0W2J16yhZdZWszrSx/j64pn3ztdF2gleH599OVMN8JuhS3d1DtJfqDsLgoh0VqIX477T+9raA+6rC3n2m8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131959; c=relaxed/simple;
	bh=XYeu3I7lleinGqco1HjcUCLcHTbSZ73GuzXfX4TQXmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpunLh9qDg9prUu9TcGfqVkZOjPvV/H3VcZiYoslcXO6rupLBDchYsS5kb0yJlkDfkAvD2HK4wxcOr6fIJT+eNlnOET4uolVsDlrJps8F3vWKrYxAenYyCxogPkjUxyQ48b8bakELNBXw5QxkuxnnE3F3M/dPXwiovnZGbnv8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcUiJwYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBD9C433F1;
	Sat, 17 Feb 2024 01:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131958;
	bh=XYeu3I7lleinGqco1HjcUCLcHTbSZ73GuzXfX4TQXmw=;
	h=From:To:Cc:Subject:Date:From;
	b=PcUiJwYxnDE+rKcJSARsAYYXXhQqmiAGSPyBcn7kTAHoHf57qbuk/sAnm/DM0k35g
	 KAkza6Ctke1ZP6ZRs5/oWZxbQc1jDBKLfFGtETphQj5EFJl5Q9RTA6cYsGFN7pOD8i
	 rgX1jH/pHSb9Y8Q07vQncUARwWo4LJBV/ifU7Ibpb4vZquazg8/JtiBQaHIXChTqaP
	 +lr5cjiofJD1UAMz7Ru12iOankJ6GV1XA5neOb2wOgScXFdh1tBdXN+L0FbbYeRNCz
	 eu+0avQ1ADa/7W94e/Oci8lyLQzL6PLOWlW9tvRBnZXBMGqA7u+kkjIpDBfKCP80xK
	 6pu2BIHAFzxNQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/7] of: populate of_root node if bootloader doesn't
Date: Fri, 16 Feb 2024 17:05:49 -0800
Message-ID: <20240217010557.2381548-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arch maintainers, please ack/review patches.

This is a resend of a series from Frank last year[1]. I worked in Rob's
review comments to unconditionally call unflatten_device_tree() and
fixup/audit calls to of_have_populated_dt() so that behavior doesn't
change.

I need this series so I can add DT based tests in the clk framework.
Either I can merge it through the clk tree once everyone is happy, or
Rob can merge it through the DT tree and provide some branch so I can
base clk patches on it.

Changes from v3 (https://lore.kernel.org/r/20240202195909.3458162-1-sboyd@kernel.org):
 * Made OF_UNITTEST depend on OF_EARLY_FLATREE
 * Made OF_EARLY_FLATREE depend on absence of arches that don't call
   unflatten_device_tree()
 * Added of_ prefix to dtb_ prefixed KUnit tests
 * Picked up tags

Changes from v2 (https://lore.kernel.org/r/20240130004508.1700335-1-sboyd@kernel.org):
 * Reorder patches to have OF changes largely first
 * No longer modify initial_boot_params if ACPI=y
 * Put arm64 patch back to v1

Changes from v1 (https://lore.kernel.org/r/20240112200750.4062441-1-sboyd@kernel.org):
 * x86 patch included
 * arm64 knocks out initial dtb if acpi is in use
 * keep Kconfig hidden but def_bool enabled otherwise

Changes from Frank's series[1]:
 * Add a DTB loaded kunit test
 * Make of_have_populated_dt() return false if the DTB isn't from the
   bootloader
 * Architecture calls made unconditional so that a root node is always
   made

Frank Rowand (2):
  of: Create of_root if no dtb provided by firmware
  of: unittest: treat missing of_root as error instead of fixing up

Stephen Boyd (5):
  of: Always unflatten in unflatten_and_copy_device_tree()
  um: Unconditionally call unflatten_device_tree()
  x86/of: Unconditionally call unflatten_and_copy_device_tree()
  arm64: Unconditionally call unflatten_device_tree()
  of: Add KUnit test to confirm DTB is loaded

 arch/arm64/kernel/setup.c    |  3 +-
 arch/um/kernel/dtb.c         | 14 ++++----
 arch/x86/kernel/devicetree.c | 24 +++++++-------
 drivers/of/.kunitconfig      |  3 ++
 drivers/of/Kconfig           | 14 ++++++--
 drivers/of/Makefile          |  4 ++-
 drivers/of/empty_root.dts    |  6 ++++
 drivers/of/fdt.c             | 64 +++++++++++++++++++++++++++---------
 drivers/of/of_test.c         | 57 ++++++++++++++++++++++++++++++++
 drivers/of/platform.c        |  3 --
 drivers/of/unittest.c        | 16 +++------
 include/linux/of.h           | 25 ++++++++------
 12 files changed, 168 insertions(+), 65 deletions(-)
 create mode 100644 drivers/of/.kunitconfig
 create mode 100644 drivers/of/empty_root.dts
 create mode 100644 drivers/of/of_test.c

[1] https://lore.kernel.org/r/20230317053415.2254616-1-frowand.list@gmail.com

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


