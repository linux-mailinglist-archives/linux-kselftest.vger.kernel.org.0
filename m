Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA3423C4A2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 06:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHEEaR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 00:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgHEE34 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 00:29:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE9C061756
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Aug 2020 21:29:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d26so22706850yba.20
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 21:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mFQWzCkGaiFIpXpMkbbRXHow6YpRUyxsgQjGovY4KbU=;
        b=Pafk7wW34NRlap/R+QTTHb10TijoNPHnI1j9R1KFOtQizsqW9Z+cU+XJnYz/nZZ0/B
         zT087oCYjbIxd7tWgSd3zReI0bn+eTB4GeaZsr6DsZnFvOlc1gpZDGDGvg7iNoEavP4i
         7eSVcN/hInYxYtl1JtOv025ncEAt8kyDQZW8Ubgy+so2hXVZ2g6VsQCADxdLKo2kkpBA
         TmakdaHtqRt+ZFm4ZmGMLhqb89w34Pmm+JKkaTHSiuwuL2ELcPlW4Pq50LhXMNHxhA8K
         oSBLF7qEpXVY7jSHAw0MRty7U/0XBtDpVCr3JYyP6XEpoweKTTLEYySZPGQz/uiMkL3B
         vJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mFQWzCkGaiFIpXpMkbbRXHow6YpRUyxsgQjGovY4KbU=;
        b=CJ2vIS7DuEkiObrcvOnBRER7845CAKRLSAv7y+mN+05SuaTJdOE6PwMuvVCw8WBlRx
         7xALsucwYjYHvjk6b866NBTKuwFyfI5QAs/Oj9T56DAnygZFj8vGNh6oL+D+1qsseHbd
         WB5INTlzv7O3CjgPy6YYnBO9KW4Yu5viiABT8Y/RriDYCPsc/MGWlaXBF8Tc70fShole
         UEtXiJ5sD4YvAsCOHeLBgNX6Zpp/FACiFSeFJol/6srtitVSraaDB5U70NnpaiDzbZtI
         QaX8JRwrbnALllqb7C1DB2gTmAn14AWhN9STMqr3pkZ7u0VI5OhgIUKB1JcB/Z+5zkHe
         1HhQ==
X-Gm-Message-State: AOAM533o928QkPOuQtMpa+pvrfnn5jucmgQKhsZyRQK9wLOUTtl9lxnv
        PJchbvyzzQuWZ9miqkhIBTxT8CtRNF4YAA==
X-Google-Smtp-Source: ABdhPJzF05VQn25N8IX0+W6dIaLPsJOO/gmDBs2lgBSOzWTR+bXWFf6QNGczIuMYMR1Nm8tW4KtRxupn/70klA==
X-Received: by 2002:a25:3803:: with SMTP id f3mr1978981yba.470.1596601795228;
 Tue, 04 Aug 2020 21:29:55 -0700 (PDT)
Date:   Tue,  4 Aug 2020 21:29:36 -0700
In-Reply-To: <20200805042938.2961494-1-davidgow@google.com>
Message-Id: <20200805042938.2961494-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200805042938.2961494-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v11 4/6] kasan: test: Make KASAN KUnit test comply with naming guidelines
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The proposed KUnit test naming guidelines[1] suggest naming KUnit test
modules [suite]_kunit (and hence test source files [suite]_kunit.c).

Rename test_kunit.c to kasan_kunit.c to comply with this, and be
consistent with other KUnit tests.

[1]: https://lore.kernel.org/linux-kselftest/20200702071416.1780522-1-davidgow@google.com/

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/Makefile                        | 6 +++---
 lib/{test_kasan.c => kasan_kunit.c} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename lib/{test_kasan.c => kasan_kunit.c} (100%)

diff --git a/lib/Makefile b/lib/Makefile
index adaebfac81c9..8a530bf7078c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -60,9 +60,9 @@ CFLAGS_test_bitops.o += -Werror
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
-obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
-CFLAGS_test_kasan.o += -fno-builtin
-CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
+obj-$(CONFIG_KASAN_KUNIT_TEST) += kasan_kunit.o
+CFLAGS_kasan_kunit.o += -fno-builtin
+CFLAGS_kasan_kunit.o += $(call cc-disable-warning, vla)
 obj-$(CONFIG_TEST_KASAN_MODULE) += test_kasan_module.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
diff --git a/lib/test_kasan.c b/lib/kasan_kunit.c
similarity index 100%
rename from lib/test_kasan.c
rename to lib/kasan_kunit.c
-- 
2.28.0.163.g6104cc2f0b6-goog

