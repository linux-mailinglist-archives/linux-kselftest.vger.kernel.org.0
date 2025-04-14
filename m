Return-Path: <linux-kselftest+bounces-30660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EDBA87AF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 10:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A305E169694
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 08:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4994C2580FE;
	Mon, 14 Apr 2025 08:50:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F711A83E8
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620615; cv=none; b=H93x3yRfk7kpUhF33Cb9LlQRzORp3Qqp80/N4WUMXPvj4y3NEF5+MpmXkHGT9S16VTlq1BH3dDisRAnfJcRRAZdcOzTTwPfblO8R77fu1vQUtKZyVvWGyzfpkF4g5W0m28uiR7pSRad3L0Oeh6Ljt/mjhYFCxQBdDNhj6QnZggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620615; c=relaxed/simple;
	bh=sC19hA9otRz1IOQFvwSujyUAGh64OV8POPH/BRYjNfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhlEHqIhfva0dj+tLmyMYJG6XduvCZOHpSeZCG+d7V9I4HK1AO+BCnQZwvPPuGTiHXwT6iifv66193rlYusIas7y5dtfhp/CXwazyHXIlv4WreUQQva3PS2wCv42NxVfH3XBvnFxzamXmw4boZdLWfjCO/74qZnfaFOQptODooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1dc6:8b60:8242:85de])
	by andre.telenet-ops.be with cmsmtp
	id cwq42E0094wS71s01wq4XE; Mon, 14 Apr 2025 10:50:04 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u4FVx-00000000YC1-1AwD;
	Mon, 14 Apr 2025 10:50:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1u4E9W-0000000AoOz-0JR7;
	Mon, 14 Apr 2025 09:22:46 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tamir Duberstein <tamird@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lib: PRIME_NUMBERS_KUNIT_TEST should not select PRIME_NUMBERS
Date: Mon, 14 Apr 2025 09:22:44 +0200
Message-ID: <6c3889e81d7396886b91120ba7871b2bffd6d934.1744615218.git.geert@linux-m68k.org>
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

Fix this by making PRIME_NUMBERS_KUNIT_TEST depend on PRIME_NUMBERS
instead of selecting it.

After this, one can safely enable CONFIG_KUNIT_ALL_TESTS=m to build
modules for all appropriate tests for ones system, without pulling in
extra unwanted functionality, while still allowing a tester to manually
enable PRIME_NUMBERS and this test suite on a system where PRIME_NUMBERS
is not enabled by default.

Fixes: 313b38a6ecb46db4 ("lib/prime_numbers: convert self-test to KUnit")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4060a89866626c0a..51722f5d041970aa 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3326,7 +3326,7 @@ config GCD_KUNIT_TEST
 config PRIME_NUMBERS_KUNIT_TEST
 	tristate "Prime number generator test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
-	select PRIME_NUMBERS
+	depends on PRIME_NUMBERS
 	default KUNIT_ALL_TESTS
 	help
 	  This option enables the KUnit test suite for the {is,next}_prime_number
-- 
2.43.0


