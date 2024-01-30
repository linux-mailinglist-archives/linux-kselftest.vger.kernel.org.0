Return-Path: <linux-kselftest+bounces-3715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D258417AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1AC1C21A93
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1BC1E486;
	Tue, 30 Jan 2024 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsVITYj9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C451171D1;
	Tue, 30 Jan 2024 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575511; cv=none; b=NROOeVPQf6TOpCCoPFuij+kPXfWmnba8m6VUShv5KFtl/EXULJKPozczXnJQpg2ao/8bxx2CETbGTC+6oQyeusdqZsLICad8NldRGzaJlDp0uqpV84LRjEnB+iXOrHBB70JwJfwK6D12l5NH4WvwhAz8KB94dhw8737e+nkBERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575511; c=relaxed/simple;
	bh=YC1N2oEpGjCqkxBB/gMBX4M8pPLAjOZSUACvgMPf924=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMif8DwRm6+zyPINEKcXaSyZs1SeM8RsM2jFHfYuvPii4HnBndC/DkLZRyuPBs29lcju5MuYLh1Ljb89GZtvmeFjWvBqL97Ur2RECKZiXdyv7P94XLGv/P5OSyKBR4IgOxWfjQadgjsLBRmd2CgnSDklBb5l+FRT0IKbh8fQWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsVITYj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDE5C433C7;
	Tue, 30 Jan 2024 00:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575510;
	bh=YC1N2oEpGjCqkxBB/gMBX4M8pPLAjOZSUACvgMPf924=;
	h=From:To:Cc:Subject:Date:From;
	b=EsVITYj953c4uFFFHZ/frw0EiUtZbrrMp+OVQxWbuOaE0N+CeP+uTVtvg0d1HkPbE
	 dx1xjZuEYidzlqTiWFRGj+SkA/+U6udg9PcDME4tGk23K49tCxu8OA9a+i/MJUELpx
	 zfgr06iNdTvvKa6poZRHyUzhaW+YgG3/JsUivUtxPgA0NlbZAhvfIincnmBqraRYq+
	 Ym3kNoML2p6zAT5oQeRN8l7wcJqsH6fONUx2p6UMhh+ytFbKacXcsGSL9RW1n+KEnP
	 3q3EOAXhUglqEegusNEH88D8ltv1cC/T02mXvBhkKWFf4BK6DTvW1m58/9L/m3VxHY
	 ryyDMU5hgXARw==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Gow <davidgow@google.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v2 0/7] of: populate of_root node if bootloader doesn't
Date: Mon, 29 Jan 2024 16:44:59 -0800
Message-ID: <20240130004508.1700335-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
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

Changes from Frank's series[1]:
 * Add a DTB loaded kunit test
 * Make of_have_populated_dt() return false if the DTB isn't from the
   bootloader
 * Architecture calls made unconditional so that a root node is always
   made

Changes from v1 (https://lore.kernel.org/r/20240112200750.4062441-1-sboyd@kernel.org):
 * x86 patch included
 * arm64 knocks out initial dtb if acpi is in use
 * keep Kconfig hidden but def_bool enabled otherwise

Frank Rowand (2):
  of: Create of_root if no dtb provided by firmware
  of: unittest: treat missing of_root as error instead of fixing up

Stephen Boyd (5):
  arm64: Unconditionally call unflatten_device_tree()
  um: Unconditionally call unflatten_device_tree()
  x86/of: Unconditionally call unflatten_and_copy_device_tree()
  of: Always unflatten in unflatten_and_copy_device_tree()
  of: Add KUnit test to confirm DTB is loaded

 arch/arm64/kernel/setup.c    |  7 +++--
 arch/um/kernel/dtb.c         | 14 +++++-----
 arch/x86/kernel/devicetree.c | 24 +++++++++--------
 drivers/of/.kunitconfig      |  3 +++
 drivers/of/Kconfig           | 11 +++++++-
 drivers/of/Makefile          |  4 ++-
 drivers/of/empty_root.dts    |  6 +++++
 drivers/of/fdt.c             | 52 +++++++++++++++++++++++++-----------
 drivers/of/of_test.c         | 48 +++++++++++++++++++++++++++++++++
 drivers/of/platform.c        |  3 ---
 drivers/of/unittest.c        | 16 +++--------
 include/linux/of.h           | 25 ++++++++++-------
 12 files changed, 151 insertions(+), 62 deletions(-)
 create mode 100644 drivers/of/.kunitconfig
 create mode 100644 drivers/of/empty_root.dts
 create mode 100644 drivers/of/of_test.c

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Gow <davidgow@google.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>

[1] https://lore.kernel.org/r/20230317053415.2254616-1-frowand.list@gmail.com

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


