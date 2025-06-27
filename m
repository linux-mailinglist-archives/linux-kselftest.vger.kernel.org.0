Return-Path: <linux-kselftest+bounces-35979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3804AEBB90
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90ED7171C03
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6572D97A8;
	Fri, 27 Jun 2025 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JT3cpXl9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NnpV9FW+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC12980BF;
	Fri, 27 Jun 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037721; cv=none; b=oPXyzuWvAEcD/SiEpF48j82w4K0xSq47q0yjGRTVk/DXtyHLqworVY4oVyvEw9myxl17GI3QzuMU6LOpRtEVe0WlZS+YHvBTB+WroOYzbZZBatH9MrhyItHyJynIOO301daFktoOd2mEjjZHZRD4b5n5iKLO5Qs5aK0a5leUBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037721; c=relaxed/simple;
	bh=CAGA/LC8gIjY84M23uMjgwqj01wT2Jq0hkpX/eaSid8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JzpTIRugdTfh3Elpm42YnSCvnBAavnM7Wzf++0p5WFF1bITMyvXEcPhsfEjNV/REQER85M8+aSOhOEgzX0NMk3b19iGIGyrIGr+Ox+/ZoVAX2ItuzMYRdwGEHkLTx+NJNHdsGR4dqczQoAy5l839QNZCjssOCFQCj0tF/dOldMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JT3cpXl9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NnpV9FW+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751037717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MUttCkDzXycQcM+ZeLMMRCpzl+xVLbejcM6RPqzvGE4=;
	b=JT3cpXl9ZArMeSYMOke6l07StbVHeRVQhA3tuV4Bg8Km1Ss+9agaha2LHgTaHmJjZVcvq7
	zynPyvMlDmw05ilZOHCf9dtf3xr4HkJFzcI3RP2G6TvW5b33SvcGZaD0XFEaLAJ7j9QwSi
	2N3YMNO+gWVPMvtA3+fNEQE4ef9KkQzRypHmv3Xn7znpcpGRsJx3ZdH+2bH7ae0TnqPXIx
	nAVZSvaG21nSwzg3g1co3xgx9KE+P6pyfW4TK2ElfoQ7u1QvXN9ikTw9xipl5TcmmOs50c
	S50r8NzZ5AsS+gw1Z5JoKzuB5Txn1TtDL1zvBi4pmPZBR6hVMcN5VqhTIfrwfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751037717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MUttCkDzXycQcM+ZeLMMRCpzl+xVLbejcM6RPqzvGE4=;
	b=NnpV9FW+8h+UsSWIHT3D8wYe/35aNjAaYlU8izb9l8Z9vawRjWekkV+9RESqAKOqchAuwo
	FNUosS2NQlN+NhCw==
Date: Fri, 27 Jun 2025 17:21:51 +0200
Subject: [PATCH] kunit: Enable PCI on UML without triggering WARN()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250627-kunit-uml-pci-v1-1-a622fa445e58@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAA63XmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyMz3ezSvMwS3dLcHN2C5EzdRKMkMwtzU1NjcxMzJaCegqLUtMwKsHn
 RsbW1AO3c72lfAAAA
X-Change-ID: 20250626-kunit-uml-pci-a2b687553746
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751037715; l=2743;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CAGA/LC8gIjY84M23uMjgwqj01wT2Jq0hkpX/eaSid8=;
 b=Eh34OpL8RnMKtiUJyh8hWfe8gsxH8Ew5FtrA9CHeYf9PtRmtzRqr6baH8A/VTN1VurhCKzWY2
 pw8lIbXWbaFDQBo9s2+vND8RtSWFm8ymLkMXrP5yYcB5uWzM6EZRe00
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Various KUnit tests require PCI infrastructure to work.
All normal platforms enable PCI by default, but UML does not.
Enabling PCI from .kunitconfig files is problematic as it would not be
portable. So in commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=y.
However CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
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

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/Kconfig                           | 7 +++++++
 tools/testing/kunit/configs/arch_uml.config | 5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index a97897edd9642f3e5df7fdd9dee26ee5cf00d6a4..c8ca155521b2455a221ddbec3f6fc55662c83475 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -93,4 +93,11 @@ config KUNIT_AUTORUN_ENABLED
 	  In most cases this should be left as Y. Only if additional opt-in
 	  behavior is needed should this be set to N.
 
+config KUNIT_UML_PCI
+	bool "KUnit UML PCI Support"
+	depends on UML
+	select UML_PCI
+	help
+	  Enables the PCI subsystem on UML for use by KUnit tests.
+
 endif # KUNIT
diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
index 54ad8972681a2cc724e6122b19407188910b9025..28edf816aa70e6f408d9486efff8898df79ee090 100644
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

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250626-kunit-uml-pci-a2b687553746

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


