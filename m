Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D0143F2C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 00:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhJ1Wee (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 18:34:34 -0400
Received: from mx1.riseup.net ([198.252.153.129]:55060 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231360AbhJ1Wec (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 18:34:32 -0400
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4HgKs22VSBzDyY5;
        Thu, 28 Oct 2021 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1635459958; bh=tkbCFKWrxjGir7rH9teJRsNvOx10l1152R9VWniiWbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqD3XpEIJgdniRWd7lBJWRVYuQpLYIIYON3UkqGxxI7u38+ijUVtvPdj47ZSVwseY
         wegLCWgdBHm8DDzKrFBBwQUHpAoptW7EaEYkQJRLuNWosXlGWypGCfgn03yt0Tm9DC
         FLaW4030nrdRJ2J4KNcvHWrCN0w2GrjVM1fwOJiY=
X-Riseup-User-ID: FA42E503019DA0D6417FD084CED29259A0B9C9A14E5B4DF9D236072844DDB55E
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4HgKry2xMHz5wT9;
        Thu, 28 Oct 2021 15:25:54 -0700 (PDT)
From:   Isabella Basso <isabbasso@riseup.net>
To:     geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        akpm@linux-foundation.org, skhan@linuxfoundation.org,
        Isabella Basso <isabellabdoamaral@usp.br>,
        Isabella Basso <isabbasso@riseup.net>
Subject: [PATCH v3 4/5] lib/Kconfig.debug: properly split hash test kernel entries
Date:   Thu, 28 Oct 2021 19:25:32 -0300
Message-Id: <20211028222533.432641-5-isabbasso@riseup.net>
In-Reply-To: <20211028222533.432641-1-isabbasso@riseup.net>
References: <20211028222533.432641-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Isabella Basso <isabellabdoamaral@usp.br>

Split TEST_HASH so that each entry only has one file.

Note that there's no stringhash test file, but actually
<linux/stringhash.h> tests are performed in lib/test_hash.c.

Reviewed-by: David Gow <davidgow@google.com>
Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
 lib/Kconfig.debug | 14 +++++++++++---
 lib/Makefile      |  3 ++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2a9b6dcdac4f..eb6c4daf5fcb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2207,9 +2207,17 @@ config TEST_RHASHTABLE
 config TEST_HASH
 	tristate "Perform selftest on hash functions"
 	help
-	  Enable this option to test the kernel's integer (<linux/hash.h>),
-	  string (<linux/stringhash.h>), and siphash (<linux/siphash.h>)
-	  hash functions on boot (or module load).
+	  Enable this option to test the kernel's integer (<linux/hash.h>), and
+	  string (<linux/stringhash.h>) hash functions on boot (or module load).
+
+	  This is intended to help people writing architecture-specific
+	  optimized versions.  If unsure, say N.
+
+config TEST_SIPHASH
+	tristate "Perform selftest on siphash functions"
+	help
+	  Enable this option to test the kernel's siphash (<linux/siphash.h>) hash
+	  functions on boot (or module load).
 
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
diff --git a/lib/Makefile b/lib/Makefile
index a841be5244ac..02eff11956d4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -61,7 +61,8 @@ obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
 obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
 CFLAGS_test_bitops.o += -Werror
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
-obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
+obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
+obj-$(CONFIG_TEST_HASH) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
 CFLAGS_test_kasan.o += -fno-builtin
-- 
2.33.1

