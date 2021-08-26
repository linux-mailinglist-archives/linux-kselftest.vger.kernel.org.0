Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0573F7FDF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 03:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhHZB1l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 21:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbhHZB1j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 21:27:39 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E66C0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:53 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t190so1618713qke.7
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BggQHky/pXzcE7QiPL5k7sg98dxSxMdww6ldwaEmBp0=;
        b=QYwdlB6TuvVHIuEIo3d5yH6CEF8VK3DovhMjsqFmowpcsebJsFZrYUE9Qjo+ro84+e
         3STTCnrcyVs5gAXLLArT6woMh7WmW6fAk93Kfvv/ztAkqse76GWaF8T7XonkHjmxTzwc
         b17pvPQgIivZGYT6E6/3h0iar2sv1gf+hEDSpwt8YL8C9w3q56DXpUdPgf5qce5YdTVs
         ekfZ1CtCmcJnw31dB3NOkaKtTagdyfcUlAO+d8GXuUJucUPEk+UkPLcixqLQOIA1QrA5
         Ky8yntLCI3npiZiC/fT8Hphn5OF96ScGzSiFpgi6PGJSZrGoxDPdskt6s80DuRknd6qX
         FdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BggQHky/pXzcE7QiPL5k7sg98dxSxMdww6ldwaEmBp0=;
        b=peZIUqN+UfJwVtcdloLf3MzpsSZ0Rt0J+My84kob6+CcxZ1FIu0n3cokf3VqrNBb74
         DXhAG1xC3C8nl0+MYLzCbI1Xi1An8OMPYy6m5XTEe48B/fdafis5btaBYYGl4oDFwo75
         Fbre1Iweis644A56RJiRm/PppHIgYCXLYMaEjqskhmQOnu44jez2BNO6E0kpKFTrjIMd
         FLLFtwKTbiixQYfAfpAmfR0bUj5kvdnhO3AimLviQaKdEKj4bhfUPW1V+gxByuG2ZQz2
         uDJWd+4LXmQuw7kbIXPrsPajFO5Swnhppt4VKndF2ENV/8nfCs5/0bAOkFbtl4xA/ZYj
         LyyA==
X-Gm-Message-State: AOAM533ezfPy0buQXW6CeOAyyUTczKz6W07Nyzk04UjYD2qOcjXprqCc
        hRO74rKmWiNz0rLi6vDFohvtDQ==
X-Google-Smtp-Source: ABdhPJxvxpmP8WmwImn9XK+xFbumd3Wt4ZiDhUg321z4BDq7FLla6lPBXnL8Uvp6FFbA14cpd8Fntg==
X-Received: by 2002:a05:620a:21dc:: with SMTP id h28mr1494397qka.198.1629941212717;
        Wed, 25 Aug 2021 18:26:52 -0700 (PDT)
Received: from aehse.localdomain (177-209-76-11.user3p.veloxzone.com.br. [177.209.76.11])
        by smtp.gmail.com with ESMTPSA id p123sm1375053qke.94.2021.08.25.18.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 18:26:52 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     linux@sciencehorizons.net, geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH 5/6] lib/Kconfig.debug: properly split hash test kernel entries
Date:   Wed, 25 Aug 2021 22:26:25 -0300
Message-Id: <20210826012626.1163705-6-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Split TEST_HASH so that each entry only has one file.

Note that there's no stringhash test file, but actually
<linux/stringhash.h> tests are performed in lib/test_hash.c.

Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
---
 lib/Kconfig.debug | 14 +++++++++++---
 lib/Makefile      |  3 ++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ddd575159fb..5e5894d98c50 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2224,9 +2224,17 @@ config TEST_RHASHTABLE
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
index 5efd1b435a37..c2e81d0eb31c 100644
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
2.33.0

