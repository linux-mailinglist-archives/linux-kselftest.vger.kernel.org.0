Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF56B418B7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Sep 2021 00:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhIZWfX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Sep 2021 18:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhIZWfT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Sep 2021 18:35:19 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89003C061604
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:42 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id r18so10021399qvy.8
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzBIb9Rrkx8NbszjPdEpu16O5Mah570+vhSFzL6iVU4=;
        b=Y/0/o41Pe70qQK42UBfSUxuIpnjC4YEfaSZ/UYMWHES/flFLEToveab17WLhcNVcKB
         GR2F9mdNeqemVHENgXeRLl98XUkl4rtguI3a5jtFz3zCCuYuY9pJ9Gvy0wt1GAhUP+q0
         rdaiVhkJFcw01gjL4qcsMlb61PTmjKusbosQlMh5lxIuiyOa64qAt0XspObUdCBxeeqX
         gLR1jOiUqRw5ZQzl22QVvN0CsihS65sr8SXn0PzPs3OkPuX0/oknbIyASrG3LH2Mujj7
         paWWhUeJl8It37sOsLi16y03iYg1NANggXlqw17e9G/rcHcGaN/eL9CkV7Br7hkU9ar8
         AJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzBIb9Rrkx8NbszjPdEpu16O5Mah570+vhSFzL6iVU4=;
        b=llk2qwM9IqsPG1X9xXESwsK8bnIerrYhrQi5RIpIxqgwNiCCrJ4C7+6NHhqQZq5DWJ
         Now3q95zNiLAoCmmATHlaQuQvNTxHhbF0u50OfnkG5hHer4HrVDPalvh/i+3Ax+EQFh8
         L4aNctYlalC3n7sVlskqQrSCR38NZyFw+ztzgztf9p1uW7hpA3CMzywyiJfR5ns/bkj8
         Pk5lFILBk7IVhybhhzWMW8CohOyK7YgtZzLF5pud39pW2M8juv5o/4y3X3Xs7oxV2wJT
         yB53C6TeQ30x0eewlcco+BE7RnqwF3SKOprB1gOU3+33mrcCU3fgTQtViNivJHDJKO/g
         0o3g==
X-Gm-Message-State: AOAM531X4RKikcc8ZpC4KfeNqh3DcgDR52N33ZhyKrcui8Mhe0V4db7y
        DaeQxF9lg3EgzG6fvOCwFn6R5Q==
X-Google-Smtp-Source: ABdhPJx5HD00AzRcLzny2/Y+fepBxWgk/Zkm/8XqmoemEyc0fYvS0c3N0NbzjA/cfFbwcDISkLWSvA==
X-Received: by 2002:ad4:4531:: with SMTP id l17mr2839310qvu.18.1632695621723;
        Sun, 26 Sep 2021 15:33:41 -0700 (PDT)
Received: from aehse.localdomain ([2804:d41:bd1c:9100:f2e1:f671:7a83:1eb8])
        by smtp.gmail.com with ESMTPSA id x6sm7244151qts.79.2021.09.26.15.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:33:41 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH v2 4/5] lib/Kconfig.debug: properly split hash test kernel entries
Date:   Sun, 26 Sep 2021 19:33:21 -0300
Message-Id: <20210926223322.848641-5-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210926223322.848641-1-isabellabdoamaral@usp.br>
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Split TEST_HASH so that each entry only has one file.

Note that there's no stringhash test file, but actually
<linux/stringhash.h> tests are performed in lib/test_hash.c.

Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
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

