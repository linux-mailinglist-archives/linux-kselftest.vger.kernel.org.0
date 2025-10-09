Return-Path: <linux-kselftest+bounces-42936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0CBBC9F3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 18:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1888D354AF5
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D289A2F9C32;
	Thu,  9 Oct 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ryo0mCRD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D62F1FF3;
	Thu,  9 Oct 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025538; cv=none; b=lan+bgu4A96PIHTZXHiAUZfCEUXl+mnQjj8bEOJPnpS4P1CjPcrvLMC4QS7PTT3NFVVvWdTHF6wBdIr+goQg79gFTNo7d2Gg7ObUCbG4VH2N/XF/75GT90kBs6NT7x54vS3EbWj4RutiGf0eU69xFsZbuE3+m9EcHS7MRLh+vP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025538; c=relaxed/simple;
	bh=nj7D94aELgF7Aatcb8SxpkP2JOZDUoKNzB5eu6yV6Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3M5c45O4d2pKIUKFIK5jLFs8eWh1hvDAWpOH58KMATQBit8DTNx57w1oC5nJ9SNXV3N6tNCEbpC0Nd5YhETiIzvcNN5ibdaFMTOCyDr53lK2/u3/g+lPDozPO7lnCTN0k2VeaUkbdJk7jmr5Jtu5B/mwZ0aVmF1RwlUYf/lwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ryo0mCRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75003C4CEE7;
	Thu,  9 Oct 2025 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025538;
	bh=nj7D94aELgF7Aatcb8SxpkP2JOZDUoKNzB5eu6yV6Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ryo0mCRDo9VQ8aAcIQS8f8ldTC+kUn9kEC7p+YycS4pia41hlh/ibmbrxO3rhapQa
	 v67xAJQu8VYP6xoOTtHSBlBAsFWKHTt8ha75RQ4KRrFOtDCAESm5citXsMvlMMM9aE
	 XcZVJUM3wrhGl95oxoCXWUaUymuqUeXrzNx2/C5WNiK3DWXFu2jAzWJYzEDGKZaY5r
	 EXJCwTPBgDVWVUZ8rxdb8in2f6n7pkj63nT/7MwCRam5I5YSFw3MBXKXJ4VBuTrtZe
	 3iBN3zAl/J90OQ2bzujr+v0g7qqEK2499j4FUlfMVmIpHbfC3ZadVpbp1yAzDWsPyJ
	 nVqP+nodSd+GQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH AUTOSEL 6.17] kunit: Enable PCI on UML without triggering WARN()
Date: Thu,  9 Oct 2025 11:55:02 -0400
Message-ID: <20251009155752.773732-36-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit 031cdd3bc3f369553933c1b0f4cb18000162c8ff ]

Various KUnit tests require PCI infrastructure to work. All normal
platforms enable PCI by default, but UML does not. Enabling PCI from
.kunitconfig files is problematic as it would not be portable. So in
commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=y. However
CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() in
virtio_pcidev_init(). However there is no one correct value for
UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.

This warning is confusing when debugging test failures.

On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
used at all, given that it is completely non-functional as indicated by
the WARN() in question. Instead it is only used as a way to enable
CONFIG_UML_PCI which itself is not directly configurable.

Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
configuration option which enables CONFIG_UML_PCI without triggering
warnings or building dead code.

Link: https://lore.kernel.org/r/20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – this change removes a longstanding WARN() that currently fires on
every UML KUnit run while keeping the needed PCI plumbing available for
the tests.

- Default UML KUnit builds enable `CONFIG_UML_PCI_OVER_VIRTIO`, whose
  probe path calls `WARN(CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID < 0, ...)`
  and immediately bails out because the default device ID stays at -1
  (arch/um/drivers/virtio_pcidev.c:616); many CI setups treat that WARN
  as fatal, so KUnit runs are polluted or aborted.
- The patch introduces `CONFIG_KUNIT_UML_PCI` (lib/kunit/Kconfig:89) to
  `select UML_PCI` directly when building UML with KUnit, letting us
  obtain the PCI core helpers without instantiating the virtio shim that
  never worked in this configuration anyway.
- With `tools/testing/kunit/configs/arch_uml.config:4` switching from
  `CONFIG_VIRTIO_UML`/`CONFIG_UML_PCI_OVER_VIRTIO` to
  `CONFIG_KUNIT_UML_PCI=y`, UML KUnit boots stop compiling the dead
  `virtio_pcidev` code and therefore stop triggering the WARN while
  still enabling the same PCI infrastructure the tests expect.
- The change is tightly scoped to KUnit-on-UML, introduces no behaviour
  change for production kernels, and effectively fixes the regression
  introduced by 6fc3a8636a7b (“kunit: tool: Enable virtio/PCI by default
  on UML”).

 lib/kunit/Kconfig                           | 7 +++++++
 tools/testing/kunit/configs/arch_uml.config | 5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index c10ede4b1d220..1823539e96da3 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -106,4 +106,11 @@ config KUNIT_DEFAULT_TIMEOUT
 	  If unsure, the default timeout of 300 seconds is suitable for most
 	  cases.
 
+config KUNIT_UML_PCI
+	bool "KUnit UML PCI Support"
+	depends on UML
+	select UML_PCI
+	help
+	  Enables the PCI subsystem on UML for use by KUnit tests.
+
 endif # KUNIT
diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
index 54ad8972681a2..28edf816aa70e 100644
--- a/tools/testing/kunit/configs/arch_uml.config
+++ b/tools/testing/kunit/configs/arch_uml.config
@@ -1,8 +1,7 @@
 # Config options which are added to UML builds by default
 
-# Enable virtio/pci, as a lot of tests require it.
-CONFIG_VIRTIO_UML=y
-CONFIG_UML_PCI_OVER_VIRTIO=y
+# Enable pci, as a lot of tests require it.
+CONFIG_KUNIT_UML_PCI=y
 
 # Enable FORTIFY_SOURCE for wider checking.
 CONFIG_FORTIFY_SOURCE=y
-- 
2.51.0


