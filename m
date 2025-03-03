Return-Path: <linux-kselftest+bounces-28001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67169A4B775
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 06:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7248C7A4597
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 05:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFACA1EB9E2;
	Mon,  3 Mar 2025 05:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BAEYc5OC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71DA1E501C
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978586; cv=none; b=gUnGaRSiO3T96eNgXl4eli0dn9PfWMf3xykrOW9NkbYiZZR/IQ57ttVi8yUrBqmrjEObufJnrhfptSruHYMERodM5/5GgYgM3T/DnVYAObQ4ULgtX6rmzXjl4bmnnhwi6idK6PIZmsTp8k5lavyhbczQrc6WgeWtqh5i14Eo8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978586; c=relaxed/simple;
	bh=INS9DlGcwtOWdHzzaCwgHMRJeqld1ZamApqFE5VhtYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BX0dxo1DOafL2KHgIFSTNBNz9DOCnLFL5olSjpxJ1yyI9eXQCWwSFMEJ9ok7AQZYH1hUxIHi9WlsVM8hytolncVS3YTNF8mkq9+xOz5eeeNPaDG1A8Rf/gsIVoxlaM6nFhMT5kgUferfBW6ubZWFSphvwZFoTJMnaaC9MQ72iuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BAEYc5OC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e4d18a2c51so387032a12.0
        for <linux-kselftest@vger.kernel.org>; Sun, 02 Mar 2025 21:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740978583; x=1741583383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5fgysdw0hYp2QViiRgS1DaKy3XnISgvx98xYEVPXVE=;
        b=BAEYc5OCYLDtJLwGdNBFLuD0adXaXVGRgNodKEV/3Mf3YRnu3RgVWELUIcrwygBKb+
         LIyLTgiP5h2hNh3FEw6LTKGyC/hvmrYNtumoxLpma2Lbna4ygle3HGkZZxYKBkT0odkt
         /+xwC4LyiHmpvzysJ+/40RjfDR2Gv5BUDa+Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740978583; x=1741583383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5fgysdw0hYp2QViiRgS1DaKy3XnISgvx98xYEVPXVE=;
        b=kHiM3YAH694LNuLJZ9Hf08I1AsMHZVB2lJjQa/QByjXtv9I7MX6pj3SXmREBcr2Nt+
         AskBO3niXCbDt548dAQ/ftPRCW7ufDvXjYu0G/1TPS33KkVWgOm1lOelmj+QRbtIkhF/
         GIGeXAAVBy5JMaWPSAfW9iC99/9fHwJJw/p5dOYfuHWKmToQ4kucS/AKaOmqafMEZQ3y
         +6jKdVFZp1bCQk2ZyCpEib4O71kfL+6T5hdq0XUpWEYR3YbhMDJqCFRWqXADnI2XJbeZ
         JUtn3Voo3zZjY2UtQOOm8u0E9vXtAnyfoNiNVdDmq7Q8L00RIuZVyxtLKodvggR0ecP2
         vXvg==
X-Forwarded-Encrypted: i=1; AJvYcCXkGfm+6FkgDXRehYv5zrv5eZNr2RxKChUy5vAK/fLpRyD0ErEuJRX7jy1H45VK3sOwn9GnFlWcuZGrRmBSgSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA9nr5uiuXcGDC4vnTzIn8lE1jx+T1Q9kHoUM4Sskz4ZikovQR
	9sVUsdyFkQsbIAN4+gMf4Y4Zirc6bfmTVEwJBBVBeZImmzmpRFEevVddhqbfBw==
X-Gm-Gg: ASbGncviXV0pGyvnPdrCPccznx1snt3wYjJ7PlCYjMoNsS1+JcodXOWTSa8nTlttyt8
	ePfR9vlPdJToA3e6zeL+NMIDecfnafQ4kUcO4Y4ZUo5CGVjgTHoP+m06rRPGWDVfcUBuniks+oO
	6f7ni5x8KeKhw2K6LwceeT819Np7CUBcEbP7WbOpEdY2sbWXTGBc1+sNyTFE2awZom0WifGy9iX
	3HIJcokMiNjqaZ3aWtVWsVU1c/JTLE/nzzCbE3iUYlH4wStz/RXlUVjadW6SK7FLBSeJxmUGjbI
	uoM7bRXkgjWIn7HtQ+EbG8lzIc1qGCDF/4DpShNwcQH85c8NxNc95QnNC4jjVexAG6xgFJfUI/f
	6
X-Google-Smtp-Source: AGHT+IHTdlg4uwUS2DR1NxqiIsQtmp7SzqfKi1TOhCGqRUS9eLAof+QK26Tfrj2rVc6wBqo4vEC8Zg==
X-Received: by 2002:a05:6402:35cb:b0:5de:d6c3:1119 with SMTP id 4fb4d7f45d1cf-5e4d6ac3cccmr4772163a12.1.1740978583010;
        Sun, 02 Mar 2025 21:09:43 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm6248635a12.50.2025.03.02.21.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 21:09:41 -0800 (PST)
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
Subject: [PATCH v8 7/7] selftest: test system mappings are sealed.
Date: Mon,  3 Mar 2025 05:09:21 +0000
Message-ID: <20250303050921.3033083-8-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303050921.3033083-1-jeffxu@google.com>
References: <20250303050921.3033083-1-jeffxu@google.com>
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
---
 .../mseal_system_mappings/.gitignore          |   2 +
 .../selftests/mseal_system_mappings/Makefile  |   6 +
 .../selftests/mseal_system_mappings/config    |   1 +
 .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 create mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 create mode 100644 tools/testing/selftests/mseal_system_mappings/config
 create mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c

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
index 000000000000..c1e93794a58b
--- /dev/null
+++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
@@ -0,0 +1,113 @@
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
+#define VDSO_NAME "[vdso]"
+#define VVAR_NAME "[vvar]"
+#define VVAR_VCLOCK_NAME "[vvar_vclock]"
+#define UPROBES_NAME "[uprobes]"
+#define SIGPAGE_NAME "[sigpage]"
+#define VECTORS_NAME "[vectors]"
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
+};
+
+FIXTURE_VARIANT_ADD(basic, vdso) {
+	.name = VDSO_NAME,
+};
+
+FIXTURE_VARIANT_ADD(basic, vvar) {
+	.name = VVAR_NAME,
+};
+
+FIXTURE_VARIANT_ADD(basic, vvar_vclock) {
+	.name = VVAR_VCLOCK_NAME,
+};
+
+FIXTURE_VARIANT_ADD(basic, sigpage) {
+	.name = SIGPAGE_NAME,
+};
+
+FIXTURE_VARIANT_ADD(basic, vectors) {
+	.name = VECTORS_NAME,
+};
+
+FIXTURE_VARIANT_ADD(basic, uprobes) {
+	.name = UPROBES_NAME,
+};
+
+TEST_F(basic, is_sealed)
+{
+	if (!has_mapping(variant->name, self->maps)) {
+		SKIP(return, "could not found the mapping, %s",
+			variant->name);
+	}
+
+	EXPECT_TRUE(mapping_is_sealed(variant->name, self->maps));
+};
+
+TEST_HARNESS_MAIN
-- 
2.48.1.711.g2feabab25a-goog


