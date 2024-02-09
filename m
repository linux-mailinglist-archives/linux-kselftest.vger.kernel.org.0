Return-Path: <linux-kselftest+bounces-4387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0C884F05C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 07:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A461EB286D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 06:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC73664CF;
	Fri,  9 Feb 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="lWmyg9Wo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8200664B0
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707460869; cv=none; b=QfG4TkwZUj4h4vbOR0V2OxtE45JkxVQ4IQ6ZJ1TVLtA/Is/DvsuQkAGNLcZ700xbDe07gcfFMWe3kCYPQMJUFD7Q9SfMyNle6ADg6wt4tCThiXYSU28yacWeQbZAoTrtlHaF9EJwdeTVpCIQcJnuns4sv4VFGezyATq/3RV+jOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707460869; c=relaxed/simple;
	bh=0z8i23JotdZYCWzu9gU2r1/A2xmE1LIuItfOUsSYf1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkuwlMXE0VKayehf0K2IHKk4TZwtuupMbhoTazaczsDSaIGFF3G4a+FkjEgBdBQrSSQ2rs/ZBiPep4i1WkreIKHpHFZU0LEz3+ykWIyy9824ECZaxkJAB5SnZoR89teu2QtfA4QXHp4m/BI/GRybCnPQ9eb2vm1H6T2YA5PgFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=lWmyg9Wo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3be9edf370so30328866b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Feb 2024 22:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1707460866; x=1708065666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/ygjtZTVjHU12+LM3KMSNgL31cpnfsr1+pYQSNIAAg=;
        b=lWmyg9WoWXcsAgqfvPWUUnRpzf5J9jo9E6tcCxhSiOuwpUvR0Or8wDC2EFjck5xAcB
         Kd4T1hSsEcGkmbppJ4r7wx2vumYwliOhoZA9uX7GpKZWuFoXcFEKP70KpISAnA2zI5O9
         k5kiNEj1pSDafxuwQ5WWlmKiK5eqFLPtwC20btGhQ8RmWE+sBFxhnRJUUUrsjgiIz8EA
         25A4DxVh7kDhZtKTq3ZrgCTVEcnIoqpJwnmh7G89VH6AmCuZ10AiH6hRwGqnbnROjG6k
         3t6WkWZP2/WCtSxiiU8v40bfX/hXPxAmIcalX7NJA2ZoE0QjHWBOH1Mk5nCpRn+0bom9
         YONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707460866; x=1708065666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/ygjtZTVjHU12+LM3KMSNgL31cpnfsr1+pYQSNIAAg=;
        b=nuD9EEEgslYjxCcIMm2cy8Z5OuunCJmDqPTatyVtjutvT6jcy1Bhipf1pGE6QnAa+X
         bFnnZzep1jo//PlDyYVGVcVpoQlm3eRy6GILbWyraqL/BPYbPe22I/mlFaLBUipvkR2T
         1FYZXcoQKzgj3TlG15QqPy786TAdo1t+PgarbNtJn7IHzUZH/TjH7GDnNlGoEPIa8vT6
         mhAvQ0rHzJ1LEVM6I7xZUpAykvpD8JvBGNXq6stck0Hef006ehVqcY6Kt/3WRcLsRmOd
         nsPtAy872q5FHzXro4zpBUB0JKKB23FhCv32RAE8biPzHr04+VKZCwwo9IMf9wOuqeTw
         iN7w==
X-Gm-Message-State: AOJu0YwCtM/b13JBmERflcE8ZEKF5V3j6f55M62DJ/eu2Pc6Te9hhpda
	qoYiNpn8Nr2rMiSqZFMjxmynwokaGbIiX6bGqpWb3Z+RsjDoVV/YvJq1iBz6xMc=
X-Google-Smtp-Source: AGHT+IEIwRiGBGnLEqNZprft3iYD6FyLivJVlJ5DvcYSMjlUi+u/u4Zmw+cdsozGJ8bDIbGbqO9viw==
X-Received: by 2002:a17:907:363:b0:a3b:e115:7b69 with SMTP id rs3-20020a170907036300b00a3be1157b69mr404470ejb.69.1707460866164;
        Thu, 08 Feb 2024 22:41:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVssZFqFbfzrmw5N+m8jAa5zM7KTVmwqDhtj5haZxxQzg6uOIC2be48nkwLf0iu0niHguJ551L7u5EteLMF9srBcTAPbhPmlhN9lnjkUU2tTUIeTzif6I3w0++uwCEmChFy3wD+RbH1zBIgET/4eJv8GvYZpGHrClhravWVN/9G12TzOT6pSxV2Hf5e3nv7flcEKay3n/VtUfCFZG3bPN9ruH01WA4pLxi6TRTHdY1GWH33+HGoG4MpOKRjax3mVebVc09T8VWGX+znRRJccUOB6llHqPneJV3KtYH+dT4o/DHN4NIJfia2h3/sHl4L3kSb/tSovFkIYLWSDk7SfUqW4Chj3MUJXUmE0sf9MQYAdtfAN6/1fja+8Igov9hgoncDu7N6JrTf1HelAqwly0GYbt9mqEuV8OdU8VwuMxP9M/G6jFA4wa/KHnI64loSqYdktUMjvLgZ7rx2qlfJXN6Zd3aOJyvy7H5eCPyX4h6MwZ4bSZg8NP1kggYVgQlsNU1N6PAwAccqf+KBuVmusiVRDgI+H0kqOURQEVwFR6RGGBHW+HSr7CQwAxFTrLx054movAmNnanQ2a79ApvJwsN3r/dgbUoFqDGx06ftfb/L8PW2DBt5m8p9uCyAVppafDCV6fPkCjNoRaVSmiVJ3sH76fTIAlBb876kIN/CSV8gNL/Ffh4rtqvRfEz6leUCCjBpy0vXgkAx4sCA7iptzDDd8TasbVhCvk8WJkPDXMHVafgfSo/lKt24X5klr1yI0qYMQawiJ5TkcuJOiLbzBMsWBu8vz6ANKnF7FSpPfnOyRduMkg26SjeQOmb1c/q857B+B6Y2Rw1lUEIifHLy+pGHEaQaYYnqCNjq+3DZmZd6g==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a370a76d3a0sm441180ejc.123.2024.02.08.22.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 22:41:05 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Anup Patel <apatel@ventanamicro.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Guo Ren <guoren@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Will Deacon <will@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Brendan Sweeney <turtwig@utexas.edu>,
	Andrew Waterman <andrew@sifive.com>,
	Brendan Sweeney <brs@berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Hans Boehm <hboehm@google.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [RFC PATCH v2 6/6] RISC-V: selftests: Add DTSO tests
Date: Fri,  9 Feb 2024 07:40:50 +0100
Message-ID: <20240209064050.2746540-7-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209064050.2746540-1-christoph.muellner@vrull.eu>
References: <20240209064050.2746540-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch tests the dynamic memory consistency model prctl() behaviour
on RISC-V. It does not depend on CONFIG_RISCV_ISA_SSDTSO or the availability
of Ssdtso, but will test other aspects if these are not given.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/dtso/.gitignore |  1 +
 tools/testing/selftests/riscv/dtso/Makefile   | 11 +++
 tools/testing/selftests/riscv/dtso/dtso.c     | 82 +++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/dtso/.gitignore
 create mode 100644 tools/testing/selftests/riscv/dtso/Makefile
 create mode 100644 tools/testing/selftests/riscv/dtso/dtso.c

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 4a9ff515a3a0..1421c21841f9 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= hwprobe vector mm
+RISCV_SUBTARGETS ?= dtso hwprobe vector mm
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/dtso/.gitignore b/tools/testing/selftests/riscv/dtso/.gitignore
new file mode 100644
index 000000000000..217d01679115
--- /dev/null
+++ b/tools/testing/selftests/riscv/dtso/.gitignore
@@ -0,0 +1 @@
+dtso
diff --git a/tools/testing/selftests/riscv/dtso/Makefile b/tools/testing/selftests/riscv/dtso/Makefile
new file mode 100644
index 000000000000..a1ffbdd3da85
--- /dev/null
+++ b/tools/testing/selftests/riscv/dtso/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 VRULL
+
+CFLAGS += -I$(top_srcdir)/tools/include
+
+TEST_GEN_PROGS := dtso
+
+include ../../lib.mk
+
+$(OUTPUT)/dtso: dtso.c ../hwprobe/sys_hwprobe.S
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/dtso/dtso.c b/tools/testing/selftests/riscv/dtso/dtso.c
new file mode 100644
index 000000000000..c8a7b25adefd
--- /dev/null
+++ b/tools/testing/selftests/riscv/dtso/dtso.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* dtso - used for functional tests of memory consistency model switching
+ * at run-time.
+ *
+ * Copyright (c) 2023 Christoph Muellner <christoph.muellner@vrull.eu>
+ */
+
+#include <sys/prctl.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "../hwprobe/hwprobe.h"
+#include "../../kselftest_harness.h"
+
+/*
+ * We have the following cases:
+ * 1) DTSO support disabed in the kernel config:
+ *    - Ssdtso is not detected
+ *    - {G,S}ET_MEMORY_CONSISTENCY_MODEL fails with EINVAL
+ * 2) DTSO support enabled and Ssdtso not available:
+ *    - Ssdtso is not detected
+ *    - {G,S}ET_MEMORY_CONSISTENCY_MODEL works for WMO and fails for TSO with EINVAL:
+ * 3) DTSO support enabled and Ssdtso available
+ *    - Ssdtso is detected
+ *    - {G,S}ET_MEMORY_CONSISTENCY_MODEL works for WMO and TSO
+ */
+
+TEST(dtso)
+{
+	struct riscv_hwprobe pair;
+	int ret;
+	bool ssdtso_configured;
+	bool ssdtso_available;
+
+	ret = prctl(PR_GET_MEMORY_CONSISTENCY_MODEL);
+	if (ret < 0) {
+		ASSERT_EQ(errno, EINVAL);
+		ssdtso_configured = false;
+	} else {
+		ASSERT_TRUE(ret == PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO ||
+			    ret == PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO);
+		ssdtso_configured = true;
+	}
+
+	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
+	ret = riscv_hwprobe(&pair, 1, 0, NULL, 0);
+	ASSERT_GE(ret, 0);
+	ASSERT_EQ(pair.key, RISCV_HWPROBE_KEY_IMA_EXT_0);
+	ssdtso_available = !!(pair.value & RISCV_HWPROBE_EXT_SSDTSO);
+
+	if (ssdtso_configured) {
+		/* Read out current model. */
+		ret = prctl(PR_GET_MEMORY_CONSISTENCY_MODEL);
+		ASSERT_TRUE(ret == PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO ||
+			    ret == PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO);
+
+		if (ssdtso_available) {
+			/* Switch to TSO. */
+			ret = prctl(PR_SET_MEMORY_CONSISTENCY_MODEL,
+				    PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO);
+			ASSERT_EQ(ret, 0);
+			ret = prctl(PR_GET_MEMORY_CONSISTENCY_MODEL);
+			ASSERT_TRUE(ret == PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO);
+
+			/* Try switching back to WMO (must fail). */
+			ret = prctl(PR_SET_MEMORY_CONSISTENCY_MODEL,
+				    PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO);
+			ASSERT_LT(ret, 0);
+			ret = prctl(PR_GET_MEMORY_CONSISTENCY_MODEL);
+			ASSERT_TRUE(ret == PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO);
+		} else {
+			/* Set the same model, that's currently active. */
+			ret = prctl(PR_SET_MEMORY_CONSISTENCY_MODEL, ret);
+			ASSERT_EQ(ret, 0);
+		}
+	} else {
+		ASSERT_EQ(ssdtso_available, false);
+		ksft_test_result_skip("Ssdtso not configured\n");
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0


