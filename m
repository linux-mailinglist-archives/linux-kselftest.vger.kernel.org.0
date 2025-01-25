Return-Path: <linux-kselftest+bounces-25178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDBA1C50D
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 20:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718023A6C5E
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54458634D;
	Sat, 25 Jan 2025 19:32:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17297D07D
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Jan 2025 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737833553; cv=none; b=m2RXHVeovIR7qFWxzXC+dUAkwIflpza0kpSwgeUMjFRgEXMjpbG0vC5dq9KOgQ+B8VQnSMhC/eW+SbzSh6JDAc2/8enW+8YJ0cDELrV3yvxJ4hCRA8W2hc8vYWRFy60+1VBVHxjoyBbxU0WwZV/O/hesMLrAly3K9+WKhlHtDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737833553; c=relaxed/simple;
	bh=sCYo4RCYbH5VVoOM1MM1Mkdv1l2sHpeD/WDJF8b+y+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgWu0AUH6vTKVkxqLJL98iPFyl1fKETUE8aBLv70VGTTbMLRiZuijOXGZTzYMYzpc0M5bxBciKWhRH7AyXwsPCfQTGm92SXk9csdjUd3F2eDi6MlCNKtNdOT3fXVaZDgm4txh8xgcxmyQQ3X/N8553Cau8TLHDwnm3/3lq2aUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:15d:cd54:ab9b:befd])
	by albert.telenet-ops.be with cmsmtp
	id 5XYL2E00N5N1FwX06XYLtr; Sat, 25 Jan 2025 20:32:22 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tblt5-0000000Eay0-3ZMQ;
	Sat, 25 Jan 2025 20:32:20 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tbltE-0000000DYdq-1tgu;
	Sat, 25 Jan 2025 20:32:20 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Cc: patches@opensource.cirrus.com,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] firmware: cs_dsp: FW_CS_DSP_KUNIT_TEST should not select REGMAP
Date: Sat, 25 Jan 2025 20:32:15 +0100
Message-ID: <73c81ac85e21f1c5a75b7628d90cbb0e1b4ed0fa.1737833376.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling a (modular) test should not silently enable additional kernel
functionality, as that may increase the attack vector of a product.

Fix this by making FW_CS_DSP_KUNIT_TEST (and FW_CS_DSP_KUNIT_TEST_UTILS)
depend on REGMAP instead of selecting it.

After this, one can safely enable CONFIG_KUNIT_ALL_TESTS=m to build
modules for all appropriate tests for ones system, without pulling in
extra unwanted functionality, while still allowing a tester to manually
enable REGMAP_BUILD and this test suite on a system where REGMAP is not
enabled by default.

Fixes: dd0b6b1f29b92202 ("firmware: cs_dsp: Add KUnit testing of bin file download")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
See also commits 70a640c0efa76674 ("regmap: REGMAP_KUNIT should not
select REGMAP") and 47ee108a113c72e ("regmap: Provide user selectable
option to enable regmap").

BTW, what's the point in having separate FW_CS_DSP_KUNIT_TEST and
FW_CS_DSP_KUNIT_TEST_UTILS symbols?  They are always enabled or disabled
together.
---
 drivers/firmware/cirrus/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirrus/Kconfig
index ee09269c63b51173..0a883091259a2c11 100644
--- a/drivers/firmware/cirrus/Kconfig
+++ b/drivers/firmware/cirrus/Kconfig
@@ -6,15 +6,13 @@ config FW_CS_DSP
 
 config FW_CS_DSP_KUNIT_TEST_UTILS
 	tristate
-	depends on KUNIT
-	select REGMAP
+	depends on KUNIT && REGMAP
 	select FW_CS_DSP
 
 config FW_CS_DSP_KUNIT_TEST
 	tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TESTS
-	depends on KUNIT
+	depends on KUNIT && REGMAP
 	default KUNIT_ALL_TESTS
-	select REGMAP
 	select FW_CS_DSP
 	select FW_CS_DSP_KUNIT_TEST_UTILS
 	help
-- 
2.43.0


