Return-Path: <linux-kselftest+bounces-4035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C8B847A0C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960331C24AC4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 19:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424668062B;
	Fri,  2 Feb 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2QLYzmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130AE80605;
	Fri,  2 Feb 2024 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903952; cv=none; b=YmeN40CYbqt0GyfkRoZbCWi+Npia1yHZMNQSuieNrg/R6i2advHBhxv0y70Z08iKArtdps4edU2yYwduQU+HO+6Jh0Nj4yqznyreC+3II1XrO28/3PiJ9hjOR8V3TnRlHTE11KqXrg1Ye1nQmRA+5vpXS8WBwq96IglIOmp7Faw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903952; c=relaxed/simple;
	bh=fWj3GhXqevF1vJtluLE30ASb6yuFLCaIkc/D6dzeitk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojyvozBB1Bk9VMGHA8sMaCQPs4Q3GZIgbU/HSaVjFt2UTD+nfK81KkOyfu+vHX1n1PHRfPxsNewCge8tOq8RV2ksGNKA7PWLBPoX+Ful+oGObr6ATcLFoGYkRIve+5hK815Q14dYGL15Za1ChUhwe0HPIYfSz5Us/almve4uMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2QLYzmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80D3C433C7;
	Fri,  2 Feb 2024 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903951;
	bh=fWj3GhXqevF1vJtluLE30ASb6yuFLCaIkc/D6dzeitk=;
	h=From:To:Cc:Subject:Date:From;
	b=R2QLYzmYFMMjI7P1p5u5HXdEmCJTdD+rg7Ivrmi/4Sa4+InZYD1qQ2lmGiA8MnwGw
	 jp7kUgzY6ezHkErO7zYoaCSiNCg6jqoXuqUUK14R5DlnJo/nQ57GfqYnmbX66lWgvE
	 rXZEly8xcwh/bXQe7IWRZ0u95hoMGFA7Y9Qkj92EwdHGkNVyZSmVxih4qAevuyAGD6
	 QNn33JJNy5UbmY5q6+1kakAUD5RnLvzfXQLl4TbqA0AV/sMxfDbi6m+DXYOtPSx9yB
	 DR7GmkkiSeYiQCFokKasKaCo9KDV5t+ezY+YynZG0ieOENsJ4zGdm5iXxwvypSU7A6
	 mZUQv6RHuDEZA==
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
Subject: [PATCH v3 0/7] of: populate of_root node if bootloader doesn't
Date: Fri,  2 Feb 2024 11:59:01 -0800
Message-ID: <20240202195909.3458162-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
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

Changes from v2 (https://lore.kernel.org/r/20240130004508.1700335-1-sboyd@kernel.org):
 * Reorder patches to have OF changes largely first
 * No longer modify initial_boot_params if ACPI=y
 * Put arm64 patch back to v1

Changes from v1 (https://lore.kernel.org/r/20240112200750.4062441-1-sboyd@kernel.org):
 * x86 patch included
 * arm64 knocks out initial dtb if acpi is in use
 * keep Kconfig hidden but def_bool enabled otherwise

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
 drivers/of/Kconfig           | 11 ++++++-
 drivers/of/Makefile          |  4 ++-
 drivers/of/empty_root.dts    |  6 ++++
 drivers/of/fdt.c             | 64 +++++++++++++++++++++++++++---------
 drivers/of/of_test.c         | 48 +++++++++++++++++++++++++++
 drivers/of/platform.c        |  3 --
 drivers/of/unittest.c        | 16 +++------
 include/linux/of.h           | 25 ++++++++------
 12 files changed, 158 insertions(+), 63 deletions(-)
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


