Return-Path: <linux-kselftest+bounces-28273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F7BA4F496
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FCE188C82C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29498197A8B;
	Wed,  5 Mar 2025 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C1i+UPTV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D691946AA
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141057; cv=none; b=KGWQxUPk7vFAZ3hVcD8gOTiMImfTLg9nJvn5/JwotL6JXPQaWVm1EXjtOLMXgsqTGwz3frrhleRXzot3xePFNvu6tfeBWedg52trgYEcCLsI86NygA9zaZEFD6WMSSoRg7hyh59dUTXPJohWLujjEWTO1W4/gIZ/VTt/eovct4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141057; c=relaxed/simple;
	bh=UmY/ayF8HBN/ulyyItJ7lAYgnpBsHJWqhLt8h/dNxHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0fiFduYyi98gpFTfKzxiIYSRhpKynAsoooyzxOPT2Mr1AS81LDRIcr/EYbyO0hgnVw2y9RBFPYNYJDlXWCCBAeifsEJp24Gm705BEV+iafb2CDBvdJqufq0aQMfIdmEdVLZKuai9CL4VQYRxfsDRhwzjZk9KYT2lVZ9wwpZvSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C1i+UPTV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7f9f57192so96675866b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 18:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141053; x=1741745853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcCXP5+9u/FLOTwAJWuE/Eiiwb6Tr4w/nKcMIQwNMtE=;
        b=C1i+UPTV6AA+ewFKbZqsLZmuLRob1bl+nC1SJXQK7vRnqeejuIhwDoai008RgyRYDy
         cyVHJ+PSmulhyXzM1CuE4YKfXf/9FDzTJObKeo3vISeb2B7VyD75HkHC0rmSzB3sOxh6
         ddFvlOydoxRRvD/aztyv/e/JEmRHMJkz/PCmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141053; x=1741745853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcCXP5+9u/FLOTwAJWuE/Eiiwb6Tr4w/nKcMIQwNMtE=;
        b=jxVgqGwHFn8HrPCZsUeNtD5hUqHDdzsYpI0bSQwohTrIwvqUWYiJasLFqUMDm5vzUD
         y+emrVV6WrN8oGGhdDmkJRjTmIWxG9RqsxMxos2vbzMpXxzqqUaPPKAZLLaO5t6A8CeA
         6RekJLx34zHW+5tewWp3743F5GKC/OzY0t887iVC3s38wo8ITLpJOxOqIYoF4R1qcBz1
         uuUzGPp9HzPg3VMu9/0aPhaqJodVaQF1BsSkr60pUljuBOnpqcJpqkE7+A1QfZsfT93r
         t8NW9WDP4N6AVQyXTCUzmJx+mQcINt5oGSq3PaQtzSk4cZmf9I3/cODBNeA0qSpdEek5
         5vsA==
X-Forwarded-Encrypted: i=1; AJvYcCWJUyFgeYS3MScoMYgK5ZH86Q9/pmCc7ZRJ3hQGBdwUYD1Itvpc/TqavV16I8GFMseJLn4Uikf0C10sqJnc5Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5W7yIJEmtO8fLZH/XZO6iIkkskmL7agw8bNbFyB1mBp14eSwh
	ehhJxgCGWOqbpDhvfKnTO8WTwBPwlIrmaljTEow6/DWjQnCMAnQCHZY5qEmWig==
X-Gm-Gg: ASbGnctUZopUGyrR96ErzbQdWae3Bz4EzT220X/Yt9hFlD+tsIL8pabyGgu/jUuysxU
	hypG1Cl/zbGFJw4NIqrIWe7i681GTDEgmkvFa1IS1LwU5HZ+Ts2jG3HYdSKthXjge5lDBn95SnX
	DfOID4iSbg3a0unIlzaBXMGN2zlWoK44Ew3roV0EDLO//XlxhAYbMXdWeA8LVH9UQ5PHyE5KtSb
	asJBhAGx8a9SUzsXmts9m+7PgNaNSpCIKc0iHVA3Sz3EBJtigkXi/frbNUHo3DEgKNLppwuszvj
	VtYTt83/qHTeJEM9v19cC06oiXeRl/Znx6fRb6F4eMNFZQd9t5Cgp98waqdwtD205d83uhbuljJ
	M
X-Google-Smtp-Source: AGHT+IF66plIcsj14Sd9utRPSZXYkhyhx8Xszzbcm4MTAIg/x5pKqpJrtPh/c/C2SNaU4l/Ayi6xCg==
X-Received: by 2002:a05:6402:2693:b0:5e4:d499:5e1 with SMTP id 4fb4d7f45d1cf-5e59f3747a9mr478745a12.1.1741141053293;
        Tue, 04 Mar 2025 18:17:33 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:32 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v9 7/7] selftest: test system mappings are sealed.
Date: Wed,  5 Mar 2025 02:17:11 +0000
Message-ID: <20250305021711.3867874-8-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add sysmap_is_sealed.c to test system mappings are sealed.

Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
config file.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../mseal_system_mappings/.gitignore          |   2 +
 .../selftests/mseal_system_mappings/Makefile  |   6 +
 .../selftests/mseal_system_mappings/config    |   1 +
 .../mseal_system_mappings/sysmap_is_sealed.c  | 119 ++++++++++++++++++
 5 files changed, 129 insertions(+)
 create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 create mode 100644 tools/testing/selftests/mseal_system_mappings/config
 create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8daac70c2f9d..be836be8f03f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -61,6 +61,7 @@ TARGETS += mount
 TARGETS += mount_setattr
 TARGETS += move_mount_set_group
 TARGETS += mqueue
+TARGETS += mseal_system_mappings
 TARGETS += nci
 TARGETS += net
 TARGETS += net/af_unix
diff --git a/tools/testing/selftests/mseal_system_mappings/.gitignore b/tools/testing/selftests/mseal_system_mappings/.gitignore
new file mode 100644
index 000000000000..319c497a595e
--- /dev/null
+++ b/tools/testing/selftests/mseal_system_mappings/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+sysmap_is_sealed
diff --git a/tools/testing/selftests/mseal_system_mappings/Makefile b/tools/testing/selftests/mseal_system_mappings/Makefile
new file mode 100644
index 000000000000..2b4504e2f52f
--- /dev/null
+++ b/tools/testing/selftests/mseal_system_mappings/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS := sysmap_is_sealed
+
+include ../lib.mk
diff --git a/tools/testing/selftests/mseal_system_mappings/config b/tools/testing/selftests/mseal_system_mappings/config
new file mode 100644
index 000000000000..675cb9f37b86
--- /dev/null
+++ b/tools/testing/selftests/mseal_system_mappings/config
@@ -0,0 +1 @@
+CONFIG_MSEAL_SYSTEM_MAPPINGS=y
diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
new file mode 100644
index 000000000000..0d2af30c3bf5
--- /dev/null
+++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * test system mappings are sealed when
+ * KCONFIG_MSEAL_SYSTEM_MAPPINGS=y
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdbool.h>
+
+#include "../kselftest.h"
+#include "../kselftest_harness.h"
+
+#define VMFLAGS "VmFlags:"
+#define MSEAL_FLAGS "sl"
+#define MAX_LINE_LEN 512
+
+bool has_mapping(char *name, FILE *maps)
+{
+	char line[MAX_LINE_LEN];
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (strstr(line, name))
+			return true;
+	}
+
+	return false;
+}
+
+bool mapping_is_sealed(char *name, FILE *maps)
+{
+	char line[MAX_LINE_LEN];
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (!strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
+			if (strstr(line, MSEAL_FLAGS))
+				return true;
+
+			return false;
+		}
+	}
+
+	return false;
+}
+
+FIXTURE(basic) {
+	FILE *maps;
+};
+
+FIXTURE_SETUP(basic)
+{
+	self->maps = fopen("/proc/self/smaps", "r");
+	if (!self->maps)
+		SKIP(return, "Could not open /proc/self/smap, errno=%d",
+			errno);
+};
+
+FIXTURE_TEARDOWN(basic)
+{
+	if (self->maps)
+		fclose(self->maps);
+};
+
+FIXTURE_VARIANT(basic)
+{
+	char *name;
+	bool sealed;
+};
+
+FIXTURE_VARIANT_ADD(basic, vdso) {
+	.name = "[vdso]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, vvar) {
+	.name = "[vvar]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
+	.name = "[vvar_vclock]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, sigpage) {
+	.name = "[sigpage]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, vectors) {
+	.name = "[vectors]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, uprobes) {
+	.name = "[uprobes]",
+	.sealed = true,
+};
+
+FIXTURE_VARIANT_ADD(basic, stack) {
+	.name = "[stack]",
+	.sealed = false,
+};
+
+TEST_F(basic, check_sealed)
+{
+	if (!has_mapping(variant->name, self->maps)) {
+		SKIP(return, "could not find the mapping, %s",
+			variant->name);
+	}
+
+	EXPECT_EQ(variant->sealed,
+		mapping_is_sealed(variant->name, self->maps));
+};
+
+TEST_HARNESS_MAIN
-- 
2.48.1.711.g2feabab25a-goog


