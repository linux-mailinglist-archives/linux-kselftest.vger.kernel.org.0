Return-Path: <linux-kselftest+bounces-501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B747F6CDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 08:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A36281A83
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 07:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA904420;
	Fri, 24 Nov 2023 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="pLeWM1Wj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FFA1731
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 23:22:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507cd62472dso2754986e87.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 23:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700810555; x=1701415355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTCTYVT+alIj/hXglZXCEukMBb5xc4LjFRdKzIJrwQI=;
        b=pLeWM1Wjrk4Dz9WkKNV01mgNP1ma6s/hKogEJidXf+J9gOAkpwXh//dHrq/gZ1tbsg
         TsIAElOopAnVwT2e2/6HUpdRm3CBh7pNKhAib4zB1tGi8/eqy2db5u8vQ6VGKLtPEdVJ
         wq8F5cQpm+Rxp/MP46M1rXGnZRtKa77xuAo2/wtCMdw+rhzaPweYwe6PJjAhf/U3j4Ij
         F2GR6EwPFrAPyjC3mrg9OaPmeaEpTJMeQlN4VZtaLAW1TlMI9ocafd3OTgts04dP3DMO
         IzHqZA1dEgtuRW+CnkcBE+ohEwosxA5p4ax9TXT/Hc8wbQ9s1YNZmwTJcvpHSvgIh/Nb
         Dzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700810555; x=1701415355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTCTYVT+alIj/hXglZXCEukMBb5xc4LjFRdKzIJrwQI=;
        b=HNdYsDD/AJj7CoL2xzQcXoW0BuiJbEnJBYWNP73AxguWpFKoYOmE+oheb0vfsv5rTv
         RXO11RZmY6M3ndUUF3JrksJ0IoUZwbHEbP9TTkSDiQ37BcF/WTI9Lb3rlIQE5f1AAF5i
         kCkN2k7O/8XvOeLCemJn9stNB76YWZMKeYFmZOmac3OS1/cKf9aOXf2uhKVd5KTf7bsD
         8bqQTKDBNPKkBLnzGveRrK4irDcMmQEyxdHnivQzk4cEvBZWHYbAoNM0uvNTSnQ7jXz/
         FBk3QW0PCe9q4s3Hbm79p5XyNfFC8mCY790giL+comxF5tkgHPp39tI/EGStsSLVPlIT
         rPVg==
X-Gm-Message-State: AOJu0YxjIRHJljDBVW2j/eNFG5LEoKk6l2WFIbUTE3eGt79KJVW+x5UA
	wZGBWdlnEtIjH2ppwcBuFWOXMJAojDfSYwZOJ91i0rtD
X-Google-Smtp-Source: AGHT+IFRswhz1gVkvMsF4D/eVNQFjsDNT0mxrUgf8ssfidkb6p0pdysEYXgPfpWNEDJ755CSdEkwNA==
X-Received: by 2002:a17:906:100e:b0:9f2:8220:3f57 with SMTP id 14-20020a170906100e00b009f282203f57mr4003586ejm.8.1700810534715;
        Thu, 23 Nov 2023 23:22:14 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060e5200b00992f2befcbcsm1709930eji.180.2023.11.23.23.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:22:14 -0800 (PST)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
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
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [RFC PATCH 5/5] RISC-V: selftests: Add DTSO tests
Date: Fri, 24 Nov 2023 08:21:42 +0100
Message-ID: <20231124072142.2786653-6-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Müllner <christoph.muellner@vrull.eu>

This patch tests the dynamic memory consistency model prctl() behaviour
on RISC-V. It does not depend on CONFIG_RISCV_ISA_SSDTSO or the availability
of Ssdtso, but will test other aspects if these are not given.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/dtso/.gitignore |  1 +
 tools/testing/selftests/riscv/dtso/Makefile   | 11 +++
 tools/testing/selftests/riscv/dtso/dtso.c     | 77 +++++++++++++++++++
 4 files changed, 90 insertions(+), 1 deletion(-)
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
index 000000000000..b9ca33ca6551
--- /dev/null
+++ b/tools/testing/selftests/riscv/dtso/dtso.c
@@ -0,0 +1,77 @@
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
+		ret = prctl(PR_GET_MEMORY_CONSISTENCY_MODEL);
+		ASSERT_TRUE(ret == PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO ||
+			    ret == PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO);
+
+		if (ssdtso_available) {
+			ret = prctl(PR_SET_MEMORY_CONSISTENCY_MODEL,
+				    PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO);
+			ASSERT_EQ(ret, 0);
+			ret = prctl(PR_GET_MEMORY_CONSISTENCY_MODEL);
+			ASSERT_TRUE(ret == PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO);
+		} else {
+			ksft_test_result_skip("Ssdtso not available\n");
+		}
+
+		ret = prctl(PR_SET_MEMORY_CONSISTENCY_MODEL,
+			    PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO);
+		ASSERT_EQ(ret, 0);
+		ret = prctl(PR_GET_MEMORY_CONSISTENCY_MODEL);
+		ASSERT_TRUE(ret == PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO);
+	} else {
+		ASSERT_EQ(ssdtso_available, false);
+		ksft_test_result_skip("Ssdtso not configured\n");
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.41.0


