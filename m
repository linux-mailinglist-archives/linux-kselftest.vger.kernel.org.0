Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC49B46DB40
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 19:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhLHSlY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 13:41:24 -0500
Received: from mx1.riseup.net ([198.252.153.129]:52990 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239090AbhLHSlS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 13:41:18 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4J8Qrn5CdnzF4qj;
        Wed,  8 Dec 2021 10:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1638988665; bh=qmTT0TZF4FgttIOcb7U46qcHZlpqSHUf1fFotvwyKfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U985PzHayzOFCbj0sZasqOowNmfuGpwGg7+toftSRpYn6glGQA+ThEzXr+nCo9kQS
         AwRmMIomFwkObPYkuru8XlmDCMrthOZ8UlOFH79EaYKpV1LdgBOJ01cSvrBBwjZdCX
         ugV7Nfza8y8oFad1ZRnk85gTZiLvrVJzu1xIRCBg=
X-Riseup-User-ID: E5DF5197E8D18B2FD28BB17B238BF708AE7E2C32FDF5FE6A6C82748B53D8671B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4J8Qrk2TZsz5vcG;
        Wed,  8 Dec 2021 10:37:42 -0800 (PST)
From:   Isabella Basso <isabbasso@riseup.net>
To:     geert@linux-m68k.org, brendanhiggins@google.com,
        dlatypov@google.com, davidgow@google.com,
        akpm@linux-foundation.org, skhan@linuxfoundation.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, ~lkcamp/patches@lists.sr.ht,
        rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabbasso@riseup.net>
Subject: [PATCH RESEND v3 4/5] lib/Kconfig.debug: properly split hash test kernel entries
Date:   Wed,  8 Dec 2021 15:37:10 -0300
Message-Id: <20211208183711.390454-5-isabbasso@riseup.net>
In-Reply-To: <20211208183711.390454-1-isabbasso@riseup.net>
References: <20211208183711.390454-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
index 5c12bde10996..e5f43d423bc9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2209,9 +2209,17 @@ config TEST_RHASHTABLE
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
index 364c23f15578..f3a2a251471d 100644
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
2.34.1

