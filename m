Return-Path: <linux-kselftest+bounces-41187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D8B51E76
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 19:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFB91C8598A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 17:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA1629A326;
	Wed, 10 Sep 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6r+g7rz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2D299937
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523644; cv=none; b=eAcoV9XWolCq+C9uoguyhH/isWXqXaAkDT92wKrsS+W5e571c08DJeLAzpK8yKmYZsdAq83y6cbD/BJvYdJh3jHdLRZNn3SF9nPYCDR6RgsNCffHQFNog1yVN0WQtrhxa5IHAnS6RXdqP5Ax+Lt/jam6/Pln+V2L+R+vrfbEv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523644; c=relaxed/simple;
	bh=0sIXJQSp7LZzik7Xp3UXK+5svlcx1Nb8fZIumzgVzM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7HZA08oAn+Dydw5d/Q6HixalUHWYy/j3EMtkVodp4UndMnyq1CKlzjI7US51LotteqWH/SOArupti+/tTQ/UuE8yneZ9FWbE1Z30bBRbUVgxl16TydtEBnw+AzoOZ88He/PWSo+uqAcT7ZfqT4ulkuUMRBqxDNgVK9g6n0SKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6r+g7rz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757523640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgXJ8j/p1zT2LHdjlIBg+mBx0F8XKwBvEhpf4celif0=;
	b=h6r+g7rz6Ub7YvvZf/qxrE4Xp99yuNliV5rCRAMsbgshYyo3norlmM069Ke3XJH3h9zGGM
	M9DNZ/YbHhjPTRhYNfULg/5kjNUyreQgaCEP+raHXu/PPZTgYVzK+i8Ef0EUojsd1Yxxgn
	0dw1Yl2ifcM48rtpokQ36ss/UwWUXM8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-8QG3kGF3OyquddQp6p04rA-1; Wed,
 10 Sep 2025 13:00:36 -0400
X-MC-Unique: 8QG3kGF3OyquddQp6p04rA-1
X-Mimecast-MFC-AGG-ID: 8QG3kGF3OyquddQp6p04rA_1757523634
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E2B719560B0;
	Wed, 10 Sep 2025 17:00:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 380C81956095;
	Wed, 10 Sep 2025 17:00:27 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-mm@kvack.org,
	safety-architecture@lists.elisa.tech,
	acarmina@redhat.com,
	kstewart@linuxfoundation.org,
	chuckwolber@gmail.com
Subject: [RFC v2 PATCH 3/3] selftests/devmem: initial testset
Date: Wed, 10 Sep 2025 19:00:00 +0200
Message-ID: <20250910170000.6475-4-gpaoloni@redhat.com>
In-Reply-To: <20250910170000.6475-1-gpaoloni@redhat.com>
References: <20250910170000.6475-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Alessandro Carminati <acarmina@redhat.com>

This patch introduces a new series of tests for devmem.
Test cases are mapped against the tested Function's expectations
defined in /drivers/char/mem.c.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 tools/testing/selftests/Makefile         |   1 +
 tools/testing/selftests/devmem/Makefile  |  13 +
 tools/testing/selftests/devmem/debug.c   |  25 +
 tools/testing/selftests/devmem/debug.h   |  14 +
 tools/testing/selftests/devmem/devmem.c  | 200 ++++++++
 tools/testing/selftests/devmem/ram_map.c | 250 ++++++++++
 tools/testing/selftests/devmem/ram_map.h |  38 ++
 tools/testing/selftests/devmem/secret.c  |  46 ++
 tools/testing/selftests/devmem/secret.h  |  13 +
 tools/testing/selftests/devmem/tests.c   | 569 +++++++++++++++++++++++
 tools/testing/selftests/devmem/tests.h   |  45 ++
 tools/testing/selftests/devmem/utils.c   | 379 +++++++++++++++
 tools/testing/selftests/devmem/utils.h   | 119 +++++
 13 files changed, 1712 insertions(+)
 create mode 100644 tools/testing/selftests/devmem/Makefile
 create mode 100644 tools/testing/selftests/devmem/debug.c
 create mode 100644 tools/testing/selftests/devmem/debug.h
 create mode 100644 tools/testing/selftests/devmem/devmem.c
 create mode 100644 tools/testing/selftests/devmem/ram_map.c
 create mode 100644 tools/testing/selftests/devmem/ram_map.h
 create mode 100644 tools/testing/selftests/devmem/secret.c
 create mode 100644 tools/testing/selftests/devmem/secret.h
 create mode 100644 tools/testing/selftests/devmem/tests.c
 create mode 100644 tools/testing/selftests/devmem/tests.h
 create mode 100644 tools/testing/selftests/devmem/utils.c
 create mode 100644 tools/testing/selftests/devmem/utils.h

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 030da61dbff3..55d228572e37 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -16,6 +16,7 @@ TARGETS += cpu-hotplug
 TARGETS += damon
 TARGETS += devices/error_logs
 TARGETS += devices/probe
+TARGETS += devmem/devmem
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
 TARGETS += drivers/ntsync
diff --git a/tools/testing/selftests/devmem/Makefile b/tools/testing/selftests/devmem/Makefile
new file mode 100644
index 000000000000..8aca8cbe2957
--- /dev/null
+++ b/tools/testing/selftests/devmem/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# Kselftest Makefile for devmem test
+
+CFLAGS += -Wall -O2
+
+TEST_GEN_PROGS_EXTENDED := devmem
+
+$(OUTPUT)/devmem: devmem.c $(OUTPUT)/ram_map.o $(OUTPUT)/secret.o  $(OUTPUT)/tests.o $(OUTPUT)/utils.o $(OUTPUT)/debug.o
+	$(CC) $^ -o $@ $(CFLAGS)
+
+EXTRA_CLEAN += $(OUTPUT)/ram_map.o $(OUTPUT)/secret.o  $(OUTPUT)/tests.o $(OUTPUT)/utils.o $(OUTPUT)/debug.o
+
+include ../lib.mk
diff --git a/tools/testing/selftests/devmem/debug.c b/tools/testing/selftests/devmem/debug.c
new file mode 100644
index 000000000000..db88a760414d
--- /dev/null
+++ b/tools/testing/selftests/devmem/debug.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * devmem test debug.c
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#include <stdio.h>
+#include <stdarg.h>
+
+#define DEBUG_FLAG 0
+int pdebug = DEBUG_FLAG;
+
+void deb_printf(const char *fmt, ...)
+{
+	va_list args;
+
+	if (pdebug) {
+		va_start(args, fmt);
+		vprintf(fmt, args);
+		va_end(args);
+	}
+}
+
diff --git a/tools/testing/selftests/devmem/debug.h b/tools/testing/selftests/devmem/debug.h
new file mode 100644
index 000000000000..323f44b94aaa
--- /dev/null
+++ b/tools/testing/selftests/devmem/debug.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * devmem test debug.h
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#ifndef DEBUG_H
+#define DEBUG_H
+extern int pdebug;
+void deb_printf(const char *fmt, ...);
+#endif
+
diff --git a/tools/testing/selftests/devmem/devmem.c b/tools/testing/selftests/devmem/devmem.c
new file mode 100644
index 000000000000..1b3fa5a46f67
--- /dev/null
+++ b/tools/testing/selftests/devmem/devmem.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* devmem test devmem.c
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#define _GNU_SOURCE
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "utils.h"
+#include "secret.h"
+#include "debug.h"
+#include "ram_map.h"
+#include "tests.h"
+#include "debug.h"
+#include "../kselftest.h"
+
+struct char_mem_test test_set[] = {
+{
+	"test_devmem_access",
+	&test_devmem_access,
+	"Test whether /dev/mem is accessible - memory_open FE_1, FE_2, FE_4",
+	F_ARCH_ALL|F_BITS_ALL|F_MISC_FATAL|F_MISC_INIT_PRV
+},
+{	"test_open_devnum",
+	&test_open_devnum,
+	"Test open /dev/mem provides the correct min, maj - memory_open - FE_3",
+	F_ARCH_ALL|F_BITS_ALL|F_MISC_INIT_REQ},
+{
+	"test_strict_devmem",
+	&test_strict_devmem,
+	"Test Strict Devmem enabled - Dependency",
+	F_ARCH_ALL|F_BITS_ALL|F_MISC_STRICT_DEVMEM_PRV|F_MISC_DONT_CARE
+},
+{
+	"test_read_at_addr_32bit_ge",
+	&test_read_at_addr_32bit_ge,
+	"Test read 64bit ppos vs 32 bit addr - read_mem - FE_1",
+	F_ARCH_ALL|F_BITS_B32|F_MISC_INIT_REQ
+},
+{
+	"test_read_outside_linear_map",
+	&test_read_outside_linear_map,
+	"Test read outside linear map - read_mem - FE_2",
+	F_ARCH_ALL|F_BITS_B32|F_MISC_INIT_REQ
+},
+{
+	"test_read_secret_area",
+	&test_read_secret_area,
+	"Test read memfd_secret area can not being accessed - read_mem - FE_4",
+	F_ARCH_ALL|F_BITS_ALL|F_MISC_INIT_REQ
+},
+{
+	"test_read_allowed_area",
+	&test_read_allowed_area,
+	"test read allowed area - read_mem - FE_5",
+	F_ARCH_ALL|F_BITS_ALL|F_MISC_INIT_REQ
+},
+{
+	"test_read_allowed_area_ppos_advance",
+	&test_read_allowed_area_ppos_advance,
+	"test read allowed area increments ppos - read_mem - FE_3",
+	F_ARCH_ALL|F_BITS_ALL|F_MISC_INIT_REQ
+},
+{
+	"test_read_restricted_area",
+	&test_read_restricted_area,
+	"test read restricted returns zeros - read_mem - FE_6",
+	F_ARCH_X86|F_BITS_ALL|F_MISC_INIT_REQ|F_MISC_STRICT_DEVMEM_REQ
+},
+{
+	"test_write_outside_area",
+	&test_write_outside_area,
+	"test write outside - write_mem - FE_2",
+	F_ARCH_ALL|F_BITS_ALL|F_MISC_INIT_REQ|F_MISC_WARN_ON_FAILURE
+},
+{
+	"test_seek_seek_set",
+	&test_seek_seek_set,
+	"test seek funcction SEEK_SET - memory_lseek - FE_4",
+	F_ARCH_ALL|F_BITS_ALL|F_MISC_INIT_REQ
+},
+{
+	"test_seek_seek_cur",
+	&test_seek_seek_cur,
+	"test seek function SEEK_CUR - memory_lseek - FE_3",
+	F_ARCH_ALL|F_BITS_ALL|F_MISC_INIT_REQ
+},
+{
+	"test_seek_seek_other",
+	&test_seek_seek_other,
+	"test seek function SEEK_END other - memory_lseek - FE_5",
+	F_ARCH_ALL|F_BITS_ALL|F_MISC_INIT_REQ
+},
+};
+
+int main(int argc, char *argv[])
+{
+	int tests_skipped = 0;
+	int tests_failed = 0;
+	int tests_passed = 0;
+	int i, tmp_res;
+	struct test_context t;
+	char *str_res, *str_warn;
+	struct char_mem_test *current;
+
+	t.srcbuf = malloc_pb(BOUNCE_BUF_SIZE);
+	t.dstbuf = malloc_pb(BOUNCE_BUF_SIZE);
+	if (!t.srcbuf || !t.dstbuf) {
+		printf("can't allocate buffers!\n");
+		exit(-1);
+	}
+	// seet verbose flag from cmdline
+	t.verbose = false;
+	if ((argc >= 2) && (!strcmp(argv[1], "-v"))) {
+		t.verbose = true;
+		pdebug = 1;
+	}
+
+	t.map = parse_iomem();
+	if (!t.map)
+		goto exit;
+
+	if (t.verbose) {
+		report_physical_memory(t.map);
+		dump_ram_map(t.map);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(test_set); i++) {
+		str_warn = NO_WARN_STR;
+		current = test_set + i;
+		tmp_res = test_needed(&t, current);
+		switch (tmp_res) {
+		case TEST_INCOHERENT:
+			deb_printf("Incoherent sequence Detected\n");
+			exit(-1);
+			break;
+		case TEST_ALLOWED:
+			deb_printf("allowed sequence Detected\n");
+			str_res = "";
+			printf("%s - (%s) ", current->name, current->descr);
+			tmp_res = current->fn(&t);
+			switch (tmp_res) {
+			case FAIL:
+				str_res = DC_STR;
+				if (!(current->flags & F_MISC_DONT_CARE)) {
+					str_res = KO_STR;
+					tests_failed++;
+				}
+				break;
+			case SKIPPED:
+				tests_skipped++;
+				str_res = SKP_STR;
+				if (current->flags & F_MISC_WARN_ON_FAILURE)
+					str_warn = WARN_STR;
+				break;
+			case PASS:
+				str_res = DC_STR;
+				if (!(current->flags & F_MISC_DONT_CARE)) {
+					tests_passed++;
+					str_res = OK_STR;
+				}
+				if (current->flags & F_MISC_WARN_ON_SUCCESS)
+					str_warn = WARN_STR;
+				break;
+			default:
+				tests_failed++;
+				printf("corrupted data\n");
+				exit(-1);
+			}
+			ksft_print_msg("%s %s\n", str_res, str_warn);
+			if ((tmp_res == FAIL) &&
+			   (current->flags & F_MISC_FATAL)) {
+				printf("fatal test failed end the chain\n");
+				goto cleanup;
+			}
+		case TEST_DENIED:
+			deb_printf("denied sequence Detected\n");
+		}
+	}
+
+cleanup:
+	close(t.fd);
+	free_ram_map(t.map);
+	free_pb(t.srcbuf);
+	free_pb(t.dstbuf);
+exit:
+	printf("Run tests = %d (passed=%d, skipped=%d failed=%d)\n",
+	    tests_skipped+tests_failed+tests_passed, tests_passed,
+	    tests_skipped, tests_failed);
+	return tests_skipped+tests_failed;
+}
diff --git a/tools/testing/selftests/devmem/ram_map.c b/tools/testing/selftests/devmem/ram_map.c
new file mode 100644
index 000000000000..cc8855052b75
--- /dev/null
+++ b/tools/testing/selftests/devmem/ram_map.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* devmem test ram_map.c
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <inttypes.h>
+#include "ram_map.h"
+#include "utils.h"
+#include "debug.h"
+
+static int calculate_bits(uint64_t max_addr)
+{
+	uint64_t value = max_addr + 1;
+	int bits = 0;
+
+	while (value > 0) {
+		value >>= 1;
+		bits++;
+	}
+	return bits;
+}
+
+uint64_t get_highest_ram_addr(const struct ram_map *map)
+{
+	if (!map || map->count == 0)
+		return 0;
+	return map->regions[map->count - 1].end;
+}
+
+static int fill_iomem_regions(FILE *fp, struct ram_map *map)
+{
+	char line[512];
+	uint64_t start, end;
+	char name[256];
+	size_t idx = 0;
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (sscanf(line, "%" SCNx64 "-%" SCNx64 " : %255[^\n]",
+		    &start, &end, name) == 3) {
+			map->regions[idx].start = start;
+			map->regions[idx].end = end;
+			map->regions[idx].name = strdup(name);
+			if (!map->regions[idx].name) {
+				perror("strdup");
+				return -1;
+			}
+			idx++;
+		}
+	}
+	return 0;
+}
+
+static size_t count_iomem_regions(FILE *fp)
+{
+	char line[512];
+	size_t count = 0;
+	uint64_t start, end;
+	char name[256];
+
+	rewind(fp);
+	while (fgets(line, sizeof(line), fp)) {
+		if (sscanf(line, "%" SCNx64 "-%" SCNx64 " : %255[^\n]",
+		    &start, &end, name) == 3) {
+			count++;
+		}
+	}
+	rewind(fp);
+	return count;
+}
+
+struct ram_map *parse_iomem(void)
+{
+	FILE *fp = fopen("/proc/iomem", "r");
+
+	if (!fp) {
+		perror("fopen /proc/iomem");
+		return NULL;
+	}
+
+	size_t count = count_iomem_regions(fp);
+
+	if (count == 0) {
+		fprintf(stderr, "No parsable regions found in /proc/iomem.\n");
+		fclose(fp);
+		return NULL;
+	}
+
+	struct ram_map *map = calloc(1, sizeof(*map));
+
+	if (!map) {
+		perror("calloc map");
+		fclose(fp);
+		return NULL;
+	}
+
+	map->regions = calloc(count, sizeof(*map->regions));
+	if (!map->regions) {
+		perror("calloc regions");
+		free(map);
+		fclose(fp);
+		return NULL;
+	}
+	map->count = count;
+
+	if (fill_iomem_regions(fp, map) < 0) {
+		fclose(fp);
+		return NULL;
+	}
+
+	fclose(fp);
+	return map;
+}
+
+void free_ram_map(struct ram_map *map)
+{
+	if (!map)
+		return;
+
+	for (size_t i = 0; i < map->count; i++)
+		free(map->regions[i].name);
+
+	free(map->regions);
+	free(map);
+}
+
+uint64_t find_last_linear_byte(int fd, uint64_t low_start, uint64_t max_addr)
+{
+	uint64_t low = low_start + SAFE_OFFSET;
+	uint64_t high = max_addr;
+	uint64_t last_good = 0;
+
+	while (low <= high) {
+		uint64_t mid = low + (high - low) / 2;
+		int ret = try_read_dev_mem(fd, mid, 0, NULL);
+
+		if (ret > 0) {
+			last_good = mid;
+			low = mid + 1;
+		} else if (ret == -EFAULT) {
+			if (mid == 0)
+				break;
+			high = mid - 1;
+		} else {
+			deb_printf("Unexpected error at 0x%llx: %d\n",
+					(unsigned long long)mid, -ret);
+			break;
+		}
+	}
+	return last_good;
+}
+
+void dump_ram_map(const struct ram_map *map)
+{
+	printf("Parsed RAM map (%zu regions):\n", map->count);
+
+	for (size_t i = 0; i < map->count; i++) {
+		printf("  %016" SCNx64 "-%016" SCNx64 " : %s\n",
+			   map->regions[i].start,
+			   map->regions[i].end,
+			   map->regions[i].name);
+	}
+}
+
+void report_physical_memory(const struct ram_map *map)
+{
+	uint64_t highest_addr = get_highest_ram_addr(map);
+
+	if (highest_addr == 0) {
+		printf("No System RAM regions detected!\n");
+		return;
+	}
+
+	int bits = calculate_bits(highest_addr);
+
+	printf("Highest physical RAM address: 0x%llx\n",
+		   (unsigned long long)highest_addr);
+	printf("Physical address width (installed RAM): %d bits\n", bits);
+}
+
+uint64_t find_high_system_ram_addr(const struct ram_map *map)
+{
+	for (size_t i = 0; i < map->count; i++) {
+		if (strstr(map->regions[i].name, "System RAM") &&
+			map->regions[i].start >= LOW_MEM_LIMIT) {
+			return map->regions[i].start;
+		}
+	}
+	return 0;
+}
+
+uint64_t pick_restricted_address(const struct ram_map *map)
+{
+	if (!map || !map->regions || map->count == 0)
+		return 0;
+
+	for (size_t i = 0; i < map->count; i++) {
+		if ((!strcmp("System RAM", map->regions[i].name)) &&
+		    (map->regions[i].start < LEGACY_MEM_START)) {
+			uint64_t start = map->regions[i].start;
+			uint64_t end   = map->regions[i].end;
+
+			if (end > start)
+				return start + (end - start) / 2;
+		}
+	}
+
+	return 0;
+}
+
+uint64_t pick_outside_address(const struct ram_map *map)
+{
+	uint64_t max_addr = 0;
+
+	if (!map || !map->regions || map->count == 0)
+		return 0;
+
+	for (size_t i = 0; i < map->count; i++) {
+		if (max_addr < map->regions[i].end)
+			max_addr = map->regions[i].end;
+	}
+
+	return max_addr + 0x1000;
+}
+
+uint64_t pick_valid_ram_address(const struct ram_map *map)
+{
+	uint64_t best_low = 0, best_size = 0;
+
+	if (!map || !map->regions || map->count == 0)
+		return 0;
+
+	for (size_t i = 0; i < map->count; i++) {
+		if (!strcmp("System RAM", map->regions[i].name)) {
+			if (best_size < map->regions[i].end -
+					      map->regions[i].start) {
+				best_low = map->regions[i].end;
+				best_size = map->regions[i].end -
+				   map->regions[i].start;
+			}
+		}
+	}
+	return best_low + (best_size / 2);
+}
diff --git a/tools/testing/selftests/devmem/ram_map.h b/tools/testing/selftests/devmem/ram_map.h
new file mode 100644
index 000000000000..8b1bd976b0b9
--- /dev/null
+++ b/tools/testing/selftests/devmem/ram_map.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* devmem test ram_map.h
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#ifndef RAM_MAP_H
+#define RAM_MAP_H
+
+#define _GNU_SOURCE
+#define SAFE_OFFSET (512ULL * 1024ULL)
+#define LOW_MEM_LIMIT 0x100000ULL
+#define LEGACY_MEM_START 0x10000
+
+struct ram_region {
+	uint64_t start;
+	uint64_t end;
+	char *name;
+};
+
+struct ram_map {
+	struct ram_region *regions;
+	size_t count;
+};
+
+uint64_t get_highest_ram_addr(const struct ram_map *map);
+struct ram_map *parse_iomem(void);
+void free_ram_map(struct ram_map *map);
+uint64_t find_last_linear_byte(int fd, uint64_t low_start, uint64_t max_addr);
+void dump_ram_map(const struct ram_map *map);
+void report_physical_memory(const struct ram_map *map);
+uint64_t find_high_system_ram_addr(const struct ram_map *map);
+uint64_t pick_restricted_address(const struct ram_map *map);
+uint64_t pick_outside_address(const struct ram_map *map);
+uint64_t pick_valid_ram_address(const struct ram_map *map);
+
+#endif
diff --git a/tools/testing/selftests/devmem/secret.c b/tools/testing/selftests/devmem/secret.c
new file mode 100644
index 000000000000..164f58947af5
--- /dev/null
+++ b/tools/testing/selftests/devmem/secret.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* devmem test secret.c
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+
+static int memfd_secret(unsigned int flags)
+{
+	return syscall(SYS_memfd_secret, flags);
+}
+
+void *secret_alloc(size_t size)
+{
+	int fd = -1;
+	void *m;
+	void *result = NULL;
+
+	fd = memfd_secret(0);
+	if (fd < 0)
+		goto out;
+
+	if (ftruncate(fd, size) < 0)
+		goto out;
+
+	m = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (m == MAP_FAILED)
+		goto out;
+
+	result = m;
+
+out:
+	if (fd >= 0)
+		close(fd);
+	return result;
+}
+
+void secret_free(void *p, size_t size)
+{
+	munmap(p, size);
+}
diff --git a/tools/testing/selftests/devmem/secret.h b/tools/testing/selftests/devmem/secret.h
new file mode 100644
index 000000000000..07d263fc05e3
--- /dev/null
+++ b/tools/testing/selftests/devmem/secret.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* devmem test secret.h
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#ifndef SECRET_H
+#define SECRET_H
+
+void *secret_alloc(size_t size);
+void secret_free(void *p, size_t size);
+#endif
diff --git a/tools/testing/selftests/devmem/tests.c b/tools/testing/selftests/devmem/tests.c
new file mode 100644
index 000000000000..58ad673c438f
--- /dev/null
+++ b/tools/testing/selftests/devmem/tests.c
@@ -0,0 +1,569 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* devmem test tests.c
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#define _FILE_OFFSET_BITS 64
+#include <errno.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <time.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "tests.h"
+#include "debug.h"
+#include "utils.h"
+#include "ram_map.h"
+#include "secret.h"
+
+#define KPROBE_EVENTS_PATH "%s/kprobe_events"
+#define KPROBE_EVENTS_ENABLE "%s/events/kprobes/enable"
+#define TRACE_PIPE_PATH "%s/trace_pipe"
+#define MAX_LINE_LENGTH 256
+#define RETPROBE_NAME "open_retprobe"
+
+struct open_res {
+	int open_resv;
+	bool test_res;
+};
+char *tracing_dir;
+char *tracingdirs[3] = {
+	NULL,
+	"/sys/kernel/tracing",
+	"/sys/kernel/debug/tracing"
+};
+
+int check_and_set_tracefs_mount(void)
+{
+	FILE *mounts_file;
+	char line[256];
+	char device[64], mount_point[128], fs_type[32];
+	int retval = 0;
+
+	mounts_file = fopen("/proc/mounts", "r");
+	if (mounts_file == NULL) {
+		perror("Failed to open /proc/mounts");
+		return 0; // Cannot verify, assume not mounted
+	}
+
+	while (fgets(line, sizeof(line), mounts_file)) {
+		if (sscanf(line, "%s %s %s", device, mount_point, fs_type) >= 3) {
+			if (strcmp(mount_point, "/sys/kernel/tracing") == 0 &&
+			    strcmp(fs_type, "tracefs") == 0) {
+				retval = 1;
+				break;
+			}
+			if (strcmp(mount_point, "/sys/kernel/debug/tracing") == 0 &&
+			    strcmp(fs_type, "tracefs") == 0) {
+				retval = 2;
+				break;
+			}
+		}
+	}
+	tracing_dir = tracingdirs[retval];
+	return retval;
+}
+
+int get_device_numbers(int fd, unsigned int *major_num,
+			unsigned int *minor_num)
+{
+	struct stat file_stat;
+
+	if (fstat(fd, &file_stat) == -1) {
+		perror("fstat failed");
+		return -1;
+	}
+
+	if (S_ISCHR(file_stat.st_mode) || S_ISBLK(file_stat.st_mode)) {
+		*major_num = major(file_stat.st_rdev);
+		*minor_num = minor(file_stat.st_rdev);
+		return 0;
+	}
+	fprintf(stderr, "File descriptor does not refer to a device file.\n");
+	return -1;
+}
+
+static int write_file(const char *path, const char *data)
+{
+	int fd = open(path, O_WRONLY | O_TRUNC);
+	ssize_t ret;
+
+	if (fd < 0) {
+		deb_printf("Error opening file %s: %s\n",
+		    path, strerror(errno));
+		return -1;
+	}
+	deb_printf("echo \"%s\" >%s\n", data, path);
+	ret = write(fd, data, strlen(data));
+	close(fd);
+	if (ret < 0) {
+		deb_printf("Error writing to file %s: %s\n",
+		   path, strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+static void cleanup_probes(void)
+{
+	deb_printf("Cleaning up kprobes and tracing...\n");
+	char buf[100];
+
+	sprintf(buf, KPROBE_EVENTS_PATH, tracing_dir);
+	if (write_file(buf, "\n") != 0)
+		deb_printf("Failed to clear retprobes. Manual cleanup may be required.\n");
+
+	sprintf(buf, KPROBE_EVENTS_ENABLE, tracing_dir);
+	if (write_file(buf, "0") != 0)
+		deb_printf("Failed to clear retprobes. Manual cleanup may be required.\n");
+
+}
+
+static void traced_open(const char *filename, const char *expected_func_name,
+			struct open_res *r)
+{
+	pid_t child_pid, parent_pid, traced_pid, result;
+	char retprobe_setup_cmd[MAX_LINE_LENGTH];
+	char tmp_path[MAX_LINE_LENGTH];
+	char line[MAX_LINE_LENGTH];
+	int open_resv, retval = -1;
+	struct open_res res;
+	int status, timeout;
+	FILE *trace_file;
+	time_t start;
+	int pfd[2];
+	int sn;
+
+	r->open_resv = -1;
+	r->test_res = false;
+
+	parent_pid = getpid();
+
+	if (pipe(pfd) == -1) {
+		perror("pipe failed");
+		return;
+	}
+
+	deb_printf("Configuring kprobes on '%s'...\n", expected_func_name);
+	snprintf(tmp_path, sizeof(tmp_path), KPROBE_EVENTS_PATH, tracing_dir);
+	snprintf(retprobe_setup_cmd, sizeof(retprobe_setup_cmd),
+		 "r2:kprobes/%s_ret %s retval=$retval ", RETPROBE_NAME,
+		 expected_func_name);
+	if (write_file(tmp_path, retprobe_setup_cmd) != 0) {
+		cleanup_probes();
+		return;
+	}
+	snprintf(tmp_path, sizeof(tmp_path), KPROBE_EVENTS_ENABLE,
+		 tracing_dir);
+	if (write_file(tmp_path, "1") != 0) {
+		cleanup_probes();
+		return;
+	}
+
+	child_pid = fork();
+	if (child_pid == -1) {
+		deb_printf("fork failed\n");
+		cleanup_probes();
+		return;
+	}
+
+	if (child_pid == 0) {
+		close(pfd[0]);
+		snprintf(line, sizeof(line), TRACE_PIPE_PATH, tracing_dir);
+		trace_file = fopen(line, "r");
+		if (!trace_file) {
+			deb_printf("fopen trace_pipe failed in child\n");
+			exit(EXIT_FAILURE);
+		}
+
+		open_resv = -1;
+
+		sleep(2);
+		while (fgets(line, sizeof(line), trace_file) != NULL) {
+			traced_pid = -1;
+			deb_printf("Received =>%s\n", line);
+			deb_printf("matching against: RETPROBE_NAME=\"%s\" and expected_func_name=\"%s\"\n",
+				   RETPROBE_NAME, expected_func_name);
+			deb_printf("matching against: RETPROBE_NAME=\"%s\" => %p\n",
+				   RETPROBE_NAME, strstr(line, RETPROBE_NAME));
+			deb_printf("matching against: expected_func_name=\"%s\" =>%p\n",
+			   expected_func_name, strstr(line, expected_func_name));
+
+			if (strstr(line, RETPROBE_NAME) &&
+			    strstr(line, expected_func_name)) {
+				sn = sscanf(line, " %*[^-]-%d%*[^=]=%x", &traced_pid, &open_resv);
+				deb_printf("scanned (%d)traced_pid=%d, open_resv=%d parent_pid=%d\n",
+				    sn, traced_pid, open_resv, parent_pid);
+				if (traced_pid == parent_pid && open_resv == 0) {
+					deb_printf("found!\n");
+					res.open_resv = open_resv;
+					res.test_res = true;
+					write(pfd[1], &res, sizeof(res));
+					fclose(trace_file);
+					exit(EXIT_SUCCESS);
+				}
+			}
+		}
+		fclose(trace_file);
+		res.open_resv = -1;
+		res.test_res = false;
+		write(pfd[1], &res, sizeof(res));
+		exit(EXIT_FAILURE);
+	} else {
+		close(pfd[1]);
+		sleep(1);
+		deb_printf("Parent process (PID %d) is calling open()...\n",
+		    parent_pid);
+		retval = open(filename, O_RDONLY);
+		if (retval == -1) {
+			deb_printf("open failed\n");
+			kill(child_pid, SIGTERM);
+			waitpid(child_pid, NULL, 0);
+			cleanup_probes();
+			return;
+		}
+
+		start = time(NULL);
+		timeout = 15;
+
+		while (1) {
+			result = waitpid(-1, &status, WNOHANG);
+			if (result == -1) {
+				perror("waitpid");
+				break;
+			} else if (result > 0) {
+				deb_printf("Child exited normally\n");
+				break;
+			}
+
+			if (time(NULL) - start >= timeout) {
+				printf("Timeout reached! Killing child...\n");
+				kill(child_pid, SIGKILL);
+				waitpid(child_pid, NULL, 0);
+				break;
+			}
+			usleep(100000);
+		}
+
+		if (read(pfd[0], r, sizeof(struct open_res)) !=
+		   sizeof(struct open_res)) {
+			deb_printf("Failed to read data from child process.\n");
+			r->test_res = false;
+		}
+
+		close(pfd[0]);
+
+		cleanup_probes();
+
+		r->open_resv = retval;
+		if (r->open_resv >= 0 && r->test_res)
+			r->test_res = true;
+		else
+			r->test_res = false;
+	}
+}
+
+int test_read_at_addr_32bit_ge(struct test_context *t)
+{
+	if (is_64bit_arch()) {
+		deb_printf("Skipped (64-bit architecture)\n");
+		return SKIPPED;
+	}
+
+	uint64_t target_addr = 0x100000000ULL;
+	int ret = try_read_dev_mem(t->fd, target_addr, 0, NULL);
+
+	if (ret == 0) {
+		deb_printf("PASS: Read beyond 4 GiB at 0x%llx returned 0 bytes\n",
+		    target_addr);
+		return PASS;
+	}
+	deb_printf("FAIL: Expected 0 bytes at 0x%llx, got %d (errno=%d)\n",
+		    target_addr, ret, -ret);
+	return FAIL;
+}
+
+int test_read_outside_linear_map(struct test_context *t)
+{
+	uint64_t tolerance, start_addr, max_addr, last_linear;
+
+	if (sizeof(void *) == 8) {
+		deb_printf("Skipped: 64-bit architecture\n");
+		return SKIPPED;
+	}
+
+	if (!t->map || t->map->count == 0) {
+		deb_printf("No memory map provided!\n");
+		return SKIPPED;
+	}
+
+	start_addr = t->map->regions[0].start;
+	max_addr = t->map->regions[t->map->count - 1].end;
+
+	deb_printf("Scanning between 0x%llx and 0x%llx\n",
+		   (unsigned long long)start_addr, (unsigned long long)max_addr);
+
+	last_linear = find_last_linear_byte(t->fd, start_addr, max_addr);
+
+	deb_printf("Last readable linear address: 0x%llx\n",
+		   (unsigned long long)last_linear);
+
+	tolerance = 16 * 1024 * 1024;
+	if (last_linear + 1 >= EXPECTED_LINEAR_LIMIT - tolerance &&
+		last_linear + 1 <= EXPECTED_LINEAR_LIMIT + tolerance) {
+		deb_printf("PASS: Linear map ends near 1 GiB boundary.\n");
+		return PASS;
+	}
+	deb_printf("FAIL: Linear map ends unexpectedly (expected ~890MB).\n");
+	return FAIL;
+}
+
+int test_write_outside_linear_map(struct test_context *t)
+{
+	uint64_t tolerance, start_addr, max_addr, last_linear;
+
+	if (sizeof(void *) == 8) {
+		deb_printf("Skipped: 64-bit architecture\n");
+		return SKIPPED;
+	}
+
+	if (!t->map || t->map->count == 0) {
+		deb_printf("No memory map provided!\n");
+		return SKIPPED;
+	}
+
+	start_addr = t->map->regions[0].start;
+	max_addr = t->map->regions[t->map->count - 1].end;
+
+	deb_printf("Scanning between 0x%llx and 0x%llx\n", (unsigned long long)start_addr,
+		   (unsigned long long)max_addr);
+
+	last_linear = find_last_linear_byte(t->fd, start_addr, max_addr);
+
+	deb_printf("Last readable linear address: 0x%llx\n",
+		   (unsigned long long)last_linear);
+
+	tolerance = 16 * 1024 * 1024;
+	if (last_linear + 1 >= EXPECTED_LINEAR_LIMIT - tolerance &&
+	    last_linear + 1 <= EXPECTED_LINEAR_LIMIT + tolerance) {
+		deb_printf("PASS: Linear map ends near 1 GiB boundary.\n");
+		fill_random_chars(t->srcbuf, BOUNCE_BUF_SIZE);
+		if (try_write_dev_mem(t->fd, last_linear + 0x1000,
+		    BOUNCE_BUF_SIZE, t->srcbuf) < 0) {
+			return FAIL;
+		}
+		return PASS;
+	}
+	deb_printf("FAIL: Linear map ends unexpectedly (expected ~890MB).\n");
+	return FAIL;
+}
+
+int test_strict_devmem(struct test_context *t)
+{
+	int res = FAIL;
+	uint64_t addr;
+	ssize_t ret;
+	uint8_t buf;
+
+	addr = find_high_system_ram_addr(t->map);
+	if (addr == 0) {
+		deb_printf("No high System RAM region found.\n");
+		res = SKIPPED;
+		return res;
+	}
+
+	deb_printf("Testing physical address: 0x%llx\n", addr);
+
+	ret = pread(t->fd, &buf, 1, addr);
+	if (ret < 0) {
+		if (errno == EPERM) {
+			deb_printf("CONFIG_STRICT_DEVMEM is ENABLED\n");
+		} else if (errno == EFAULT || errno == ENXIO) {
+			deb_printf("Invalid address (errno=%d). Try another region.\n", errno);
+			res = SKIPPED;
+		} else if (errno == EACCES) {
+			deb_printf("Access blocked by LSM or lockdown (errno=EACCES).\n");
+			res = SKIPPED;
+		} else {
+			perror("pread");
+		}
+	} else {
+		deb_printf("CONFIG_STRICT_DEVMEM is DISABLED\n");
+		res = PASS;
+	}
+
+	if (res != PASS)
+		t->strict_devmem_state = true;
+
+	return res;
+}
+
+int test_devmem_access(struct test_context *t)
+{
+	struct open_res res;
+
+	if (!check_and_set_tracefs_mount()) {
+		deb_printf("Tracing directory not found. This test requires debugfs mounted.\n");
+		return FAIL;
+	}
+
+	traced_open("/dev/mem", "memory_open", &res);
+	if ((res.test_res) && (res.open_resv >= 0)) {
+		deb_printf("test_res=%d, open_resv=%d\n",
+		    res.test_res, res.open_resv);
+		t->fd = res.open_resv;
+		t->devmem_init_state = true;
+		return PASS;
+	}
+	return FAIL;
+}
+
+int test_read_secret_area(struct test_context *t)
+{
+	void *tmp_ptr;
+
+	deb_printf("\ntest_read_secret_area - start\n");
+	tmp_ptr = secret_alloc(BOUNCE_BUF_SIZE);
+
+	if (tmp_ptr) {
+		deb_printf("secret_alloc [ok] tmp_ptr va addr = 0x%lx\n",
+		    tmp_ptr);
+		fill_random_chars(tmp_ptr, BOUNCE_BUF_SIZE); // lazy alloc
+		if (t->verbose)
+			print_hex(tmp_ptr, 32);
+		t->tst_addr = virt_to_phys(tmp_ptr);
+		if (t->tst_addr) {
+			deb_printf("filled with things -> tst_addr phy addr = 0x%lx\n",
+				   t->tst_addr);
+			if (try_read_dev_mem(t->fd, t->tst_addr,
+			    BOUNCE_BUF_SIZE, t->dstbuf) < 0)
+				return PASS;
+		}
+	}
+	return FAIL;
+}
+
+int test_read_restricted_area(struct test_context *t)
+{
+	fill_random_chars(t->dstbuf, BOUNCE_BUF_SIZE);
+	if (t->verbose)
+		print_hex(t->dstbuf, 32);
+	t->tst_addr = pick_restricted_address(t->map);
+	if (t->tst_addr) {
+		if (try_read_dev_mem(t->fd, t->tst_addr, BOUNCE_BUF_SIZE,
+		    t->dstbuf) >= 0) {
+			if (t->verbose)
+				print_hex(t->dstbuf, 32);
+
+			if (is_zero(t->dstbuf, BOUNCE_BUF_SIZE))
+				return PASS;
+
+		}
+	}
+	return FAIL;
+}
+
+int test_read_allowed_area(struct test_context *t)
+{
+	fill_random_chars(t->srcbuf, BOUNCE_BUF_SIZE);
+	t->tst_addr = virt_to_phys(t->srcbuf);
+	if (t->tst_addr) {
+		if (try_read_dev_mem(t->fd, t->tst_addr, BOUNCE_BUF_SIZE,
+		    t->dstbuf) >= 0) {
+			deb_printf("Read OK  compare twos\n", t->tst_addr);
+			if (t->verbose) {
+				print_hex(t->srcbuf, BOUNCE_BUF_SIZE);
+				print_hex(t->dstbuf, BOUNCE_BUF_SIZE);
+			}
+			if (!memcmp(t->srcbuf, t->dstbuf, BOUNCE_BUF_SIZE))
+				return PASS;
+		}
+	}
+	return FAIL;
+}
+
+int test_read_allowed_area_ppos_advance(struct test_context *t)
+{
+	fill_random_chars(t->srcbuf, BOUNCE_BUF_SIZE);
+	memset(t->dstbuf, 0, BOUNCE_BUF_SIZE);
+	if (t->verbose)
+		print_hex(t->srcbuf, 32);
+	t->tst_addr = virt_to_phys(t->srcbuf);
+	if (t->tst_addr) {
+		if ((try_read_dev_mem(t->fd, t->tst_addr,
+		    BOUNCE_BUF_SIZE / 2, t->dstbuf) >= 0) &&
+			(try_read_inplace(t->fd, BOUNCE_BUF_SIZE / 2,
+			    t->dstbuf) >= 0)){
+			if (t->verbose)
+				print_hex(t->dstbuf, 32);
+
+			if (!memcmp(t->srcbuf + BOUNCE_BUF_SIZE / 2,
+			    t->dstbuf, BOUNCE_BUF_SIZE / 2)) {
+				return PASS;
+			}
+		}
+	}
+	return FAIL;
+}
+
+int test_write_outside_area(struct test_context *t)
+{
+	fill_random_chars(t->srcbuf, BOUNCE_BUF_SIZE);
+	t->tst_addr = pick_outside_address(t->map);
+	if (try_write_dev_mem(t->fd, t->tst_addr, BOUNCE_BUF_SIZE,
+	    t->srcbuf) < 0)
+		return PASS;
+
+	return FAIL;
+}
+
+/*
+ * this test needs to follow test_seek_seek_set
+ */
+int test_seek_seek_cur(struct test_context *t)
+{
+	t->tst_addr = pick_valid_ram_address(t->map);
+	if (lseek(t->fd, 0, SEEK_SET) == (off_t)-1)
+		return FAIL;
+
+	if (lseek(t->fd, t->tst_addr, SEEK_CUR) == (off_t)-1)
+		return FAIL;
+
+	return PASS;
+}
+
+int test_seek_seek_set(struct test_context *t)
+{
+	t->tst_addr = pick_valid_ram_address(t->map);
+	if (lseek(t->fd, t->tst_addr, SEEK_SET) == (off_t)-1)
+		return FAIL;
+
+	return PASS;
+}
+
+int test_seek_seek_other(struct test_context *t)
+{
+	if (lseek(t->fd, 0, SEEK_END) == (off_t)-1)
+		return PASS;
+
+	return FAIL;
+}
+
+int test_open_devnum(struct test_context *t)
+{
+	unsigned int major_num, minor_num;
+
+	if (get_device_numbers(t->fd, &major_num, &minor_num) == 0) {
+		if ((major_num == 1) && (minor_num == 1))
+			return PASS;
+	}
+	return FAIL;
+}
diff --git a/tools/testing/selftests/devmem/tests.h b/tools/testing/selftests/devmem/tests.h
new file mode 100644
index 000000000000..376412034cde
--- /dev/null
+++ b/tools/testing/selftests/devmem/tests.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* devmem test tests.h
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#ifndef TESTS_H
+#define TESTS_H
+
+#include "utils.h"
+
+#define EXPECTED_LINEAR_LIMIT 0x377fe000
+#define PASS 0
+#define FAIL -1
+#define SKIPPED 1
+#define OK_STR "[\e[1;32mPASS\e[0m]"
+#define KO_STR "[\e[1;31mFAIL\e[0m]"
+#define SKP_STR "[\e[1;33mSKIP\e[0m]"
+#define DC_STR "[\e[1;33mDON'T CARE\e[0m]"
+#define WARN_STR "\e[1;31mThis shouldn't have happen. Memory is probably corrupted!\e[0m"
+#define NO_WARN_STR ""
+
+int test_read_at_addr_32bit_ge(struct test_context *t);
+int test_read_outside_linear_map(struct test_context *t);
+int test_strict_devmem(struct test_context *t);
+int test_devmem_access(struct test_context *t);
+int test_read_secret_area(struct test_context *t);
+int test_read_allowed_area(struct test_context *t);
+int test_read_reserved_area(struct test_context *t);
+int test_read_allowed_area(struct test_context *t);
+int test_read_allowed_area_ppos_advance(struct test_context *t);
+int test_read_restricted_area(struct test_context *t);
+int test_write_outside_area(struct test_context *t);
+int test_seek_seek_cur(struct test_context *t);
+int test_seek_seek_set(struct test_context *t);
+int test_seek_seek_other(struct test_context *t);
+int test_open_devnum(struct test_context *t);
+
+static inline bool is_64bit_arch(void)
+{
+	return sizeof(void *) == 8;
+}
+
+#endif
diff --git a/tools/testing/selftests/devmem/utils.c b/tools/testing/selftests/devmem/utils.c
new file mode 100644
index 000000000000..d14e86dbd81a
--- /dev/null
+++ b/tools/testing/selftests/devmem/utils.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* devmem test utils.c
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#define _FILE_OFFSET_BITS 64
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "utils.h"
+#include "debug.h"
+
+
+static inline uint64_t get_page_size(void)
+{
+	return (uint64_t)sysconf(_SC_PAGE_SIZE);
+}
+
+uint64_t virt_to_phys(void *virt_addr)
+{
+	uint64_t virt_pfn, page_size, phys_addr, pfn;
+	uintptr_t virt = (uintptr_t)virt_addr;
+	ssize_t bytes_read;
+	uint64_t entry = 0;
+	off_t offset;
+	int fd;
+
+	page_size = get_page_size();
+	virt_pfn = virt / page_size;
+	deb_printf("page_size=%d, virt_pfn=%lu\n", page_size, virt_pfn);
+
+	fd = open("/proc/self/pagemap", O_RDONLY);
+	if (fd < 0) {
+		deb_printf("Error opening /proc/self/pagemap: %s\n",
+		  strerror(errno));
+		return 0;
+	}
+
+	offset = (off_t)(virt_pfn * sizeof(uint64_t));
+	deb_printf("lseek(%d, 0x%llx, SEEK_SET)\n", fd, offset);
+	if (lseek(fd, offset, SEEK_SET) == (off_t)-1) {
+		deb_printf("Error seeking pagemap: %s\n", strerror(errno));
+		close(fd);
+		return 0;
+	}
+
+	bytes_read = read(fd, &entry, sizeof(entry));
+	close(fd);
+	if (bytes_read != sizeof(entry)) {
+		deb_printf("Error reading pagemap: %s\n", strerror(errno));
+		return 0;
+	}
+
+	if (!(entry & (1ULL << 63))) {
+		deb_printf("Page not present in RAM (maybe swapped out).\n");
+		return 0;
+	}
+
+	pfn = entry & ((1ULL << 55) - 1);
+	deb_printf("entry=%llx, pfn=%llx\n", entry, pfn);
+	if (pfn == 0) {
+		deb_printf("PFN is 0 - invalid mapping.\n");
+		return 0;
+	}
+
+	phys_addr = (pfn * page_size) + (virt % page_size);
+	deb_printf("phys_addr=%llx\n", phys_addr);
+	return phys_addr;
+}
+
+int try_read_inplace(int fd, int scnt, void *sbuf)
+{
+	ssize_t r;
+
+	r = read(fd, sbuf, scnt);
+	deb_printf("read(%d, %p, %d)=%d(%d)\n", fd, sbuf, scnt, r, -errno);
+	if (r < 0)
+		return -errno;
+
+	return (int)r;
+}
+
+int try_read_dev_mem(int fd, uint64_t addr, int scnt, void *sbuf)
+{
+	int space;
+	ssize_t r;
+	void *buf;
+	int cnt;
+
+	buf = sbuf ? sbuf : &space;
+	cnt = sbuf ? scnt : sizeof(space);
+	deb_printf("buf = %p, cnt = %d\n", buf, cnt);
+	if (lseek(fd, (off_t)addr, SEEK_SET) == (off_t)-1)
+		return -errno;
+
+	deb_printf("lseek(%d, %llx, SEEK_SET)=%d\n", fd, addr, -errno);
+
+	r = read(fd, buf, cnt);
+	deb_printf("read(%d, %p, %d)=%d(%d)\n", fd, buf, cnt, r, -errno);
+	if (r < 0)
+		return -errno;
+
+	return (int)r;
+}
+
+int try_write_dev_mem(int fd, uint64_t addr, int scnt, void *sbuf)
+{
+	int space;
+	ssize_t r;
+	void *buf;
+	int cnt;
+
+	buf = sbuf ? sbuf : &space;
+	cnt = sbuf ? scnt : sizeof(space);
+	deb_printf("buf = %p, cnt = %d\n", buf, cnt);
+	if (lseek(fd, (off_t)addr, SEEK_SET) == (off_t)-1)
+		return -errno;
+
+	deb_printf("lseek(%d, %llx, SEEK_SET)=%d\n", fd, addr, -errno);
+
+	r = write(fd, buf, cnt);
+	deb_printf("write(%d, %p, %d)=%d(%d)\n", fd, buf, cnt, r, -errno);
+	if (r < 0)
+		return -errno;
+
+	return (int)r;
+}
+
+int fill_random_chars(char *buf, int cnt)
+{
+	int bytes_read, fd;
+	ssize_t res;
+
+	if (!buf || cnt <= 0) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0) {
+		perror("open /dev/urandom");
+		return -1;
+	}
+
+	bytes_read = 0;
+	while (bytes_read < cnt) {
+		res = read(fd, buf + bytes_read, cnt - bytes_read);
+		if (res < 0) {
+			if (errno == EINTR)
+				continue;
+			perror("read /dev/urandom");
+			close(fd);
+			return -1;
+		}
+		bytes_read += res;
+	}
+	close(fd);
+
+	return 0;
+}
+
+bool is_zero(const void *p, size_t cnt)
+{
+	const char *byte_ptr = (const char *)p;
+
+	for (size_t i = 0; i < cnt; ++i) {
+		if (byte_ptr[i] != 0)
+			return false;
+	}
+	return true;
+}
+
+void print_hex(const void *p, size_t cnt)
+{
+	const unsigned char *bytes = (const unsigned char *)p;
+	int remainder;
+	size_t i;
+
+	for (i = 0; i < cnt; i++) {
+		if (i % 16 == 0) {
+			if (i > 0)
+				printf("\n");
+
+			printf("%08lX: ", (unsigned long)(bytes + i));
+		}
+		printf("%02X ", bytes[i]);
+	}
+
+	remainder = cnt % 16;
+	if (remainder != 0) {
+		for (int j = 0; j < 16 - remainder; j++)
+			printf("   ");
+	}
+
+	printf("\n");
+}
+
+static bool machine_is_compatible(unsigned int flags)
+{
+	unsigned int current_arch_flag = 0;
+	unsigned int current_bits_flag = 0;
+
+#if defined(__x86_64__) || defined(__i386__)
+	current_arch_flag = F_ARCH_X86;
+#elif defined(__arm__) || defined(__aarch64__)
+	current_arch_flag = F_ARCH_ARM;
+#elif defined(__PPC__) || defined(__powerpc__)
+	current_arch_flag = F_ARCH_PPC;
+#elif defined(__mips__)
+	current_arch_flag = F_ARCH_MIPS;
+#elif defined(__s390__)
+	current_arch_flag = F_ARCH_S390;
+#elif defined(__riscv)
+	current_arch_flag = F_ARCH_RISCV;
+#else
+	current_arch_flag = 0;
+#endif
+
+	if (sizeof(void *) == 8)
+		current_bits_flag = F_BITS_B64;
+	else
+		current_bits_flag = F_BITS_B32;
+
+	bool arch_matches = (flags & F_ARCH_ALL) || (flags & current_arch_flag);
+
+	bool bits_matches = (flags & F_BITS_ALL) || (flags & current_bits_flag);
+
+	return arch_matches && bits_matches;
+}
+
+static void print_flags(uint32_t flags)
+{
+	printf("Flags: 0x%08X ->", flags);
+
+	// Architecture flags
+	printf(" Architecture: ");
+	if (flags & F_ARCH_ALL)
+		printf("ALL ");
+
+	if (flags & F_ARCH_X86)
+		printf("X86 ");
+
+	if (flags & F_ARCH_ARM)
+		printf("ARM ");
+
+	if (flags & F_ARCH_PPC)
+		printf("PPC ");
+
+	if (flags & F_ARCH_MIPS)
+		printf("MIPS ");
+
+	if (flags & F_ARCH_S390)
+		printf("S390 ");
+
+	if (flags & F_ARCH_RISCV)
+		printf("RISC-V ");
+
+	// Bitness flags
+	printf(" Bitness: ");
+	if (flags & F_BITS_ALL)
+		printf("ALL ");
+
+	if (flags & F_BITS_B64)
+		printf("64-bit ");
+
+	if (flags & F_BITS_B32)
+		printf("32-bit ");
+
+	// Miscellaneous flags
+	printf(" Miscellaneous:");
+	if (flags & F_MISC_FATAL)
+		printf("	- F_MISC_FATAL: true");
+
+	if (flags & F_MISC_STRICT_DEVMEM_REQ)
+		printf("	- F_MISC_STRICT_DEVMEM_REQ: true");
+
+	if (flags & F_MISC_STRICT_DEVMEM_PRV)
+		printf("	- F_MISC_STRICT_DEVMEM_PRV: true");
+
+	if (flags & F_MISC_INIT_PRV)
+		printf("	- F_MISC_INIT_PRV: true");
+
+	if (flags & F_MISC_INIT_REQ)
+		printf("	- F_MISC_INIT_REQ: true");
+
+	printf("\n");
+}
+
+static void print_context(struct test_context *t)
+{
+	char *c;
+
+	c = "NO";
+	if (t->devmem_init_state)
+		c = "yes";
+	printf("system state: init=%s, ", c);
+	c = "NO";
+	if (t->strict_devmem_state)
+		c = "yes";
+	printf("strict_devmem=%s\n", c);
+}
+
+int test_needed(struct test_context *t,
+			     struct char_mem_test *current)
+{
+	if (t->verbose) {
+		print_context(t);
+		print_flags(current->flags);
+	}
+
+	if (!(t->devmem_init_state) && !(current->flags & F_MISC_INIT_PRV)) {
+		deb_printf("Not initialized and test does not provide initialization\n");
+		return TEST_DENIED;// Not initialized and not provide init
+	}
+	if ((t->devmem_init_state) && (current->flags & F_MISC_INIT_PRV)) {
+		deb_printf("can not initialize again\n");
+		return TEST_INCOHERENT;	// can not initialize again
+	}
+	if (!(t->devmem_init_state) && (current->flags & F_MISC_INIT_PRV)) {
+		deb_printf("initializing: test allowed!\n");
+		return TEST_ALLOWED;	// initializing: test allowed!
+	}
+	if (!(t->devmem_init_state)) {
+		deb_printf("not initialized, can not proceed\n");
+		return TEST_DENIED;	// not initialized, can not proceed
+	}
+	if (!(machine_is_compatible(current->flags))) {
+		deb_printf("not for this architecture\n");
+		return TEST_DENIED;	// not for this architecture
+	}
+	if (((t->strict_devmem_state) || (current->flags &
+	    F_MISC_STRICT_DEVMEM_REQ)) && !((t->strict_devmem_state) &&
+	    (current->flags & F_MISC_STRICT_DEVMEM_REQ))) {
+		deb_printf("strict_devmem requirement and offering do not meet\n");
+		return TEST_DENIED;// strict_devmem requirement
+	}
+	deb_printf("test allowed!\n");
+	return TEST_ALLOWED;
+}
+
+void *malloc_pb(size_t size)
+{
+	if (size == 0 || size > getpagesize()) {
+		fprintf(stderr, "size must be greater than 0 and less than or equal to one page.\n");
+		return NULL;
+	}
+
+	void *ptr = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE,
+	    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (ptr == MAP_FAILED) {
+		perror("mmap failed");
+		return NULL;
+	}
+
+	return ptr;
+}
+
+void free_pb(void *ptr)
+{
+	if (ptr == NULL)
+		return;
+
+	if (munmap(ptr, getpagesize()) == -1)
+		perror("munmap failed");
+
+}
diff --git a/tools/testing/selftests/devmem/utils.h b/tools/testing/selftests/devmem/utils.h
new file mode 100644
index 000000000000..3a8d052f14ba
--- /dev/null
+++ b/tools/testing/selftests/devmem/utils.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* devmem test utils.h
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by Alessandro Carminati (acarmina@redhat.com)
+ */
+
+#ifndef UTIL_H
+#define UTIL_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stddef.h>
+
+#define BOUNCE_BUF_SIZE			64
+/*
+ * Test Case Flags:
+ * F_ARCH_ALL: Test valid on all HW Architectures.
+ * F_ARCH_X86: Test valid on x86 only.
+ * F_ARCH_ARM: Test valid on ARM only.
+ * F_ARCH_PPC: Test valid on PowerPC only.
+ * F_ARCH_MIPS: Test valid on MIPS only.
+ * F_ARCH_S390: Test valid on S390 only.
+ * F_ARCH_RISCV: Test valid on RISC-V only.
+ *
+ * F_BITS_ALL: Test valid on both 32b and 64b systems.
+ * F_BITS_B64: Test valid on 64b systems only.
+ * F_BITS_B32: Test valid on 32b systems only.
+ *
+ * F_MISC_FATAL: a test failure stops the execution of any other test.
+ * F_MISC_STRICT_DEVMEM_REQ: the test requires STRICT_DEVMEM to be defined
+ *                           in the Kernel.
+ * F_MISC_STRICT_DEVMEM_PRV: the test retrieves the status of STRICT_DEVMEM
+ *                           (whether it is defined or not in the Kernel).
+ * F_MISC_INIT_PRV: the test verify the system to be in a proper init state
+ *                  for subsequent tests to run.
+ * F_MISC_INIT_REQ: the test requires a proper init state as retrieved by
+ *                  F_MISC_INIT_PRV.
+ * F_MISC_DONT_CARE: the test is not part of the test plan, it is just
+ *                   auxiliary code that determine how to run other tests.
+ * F_MISC_WARN_ON_SUCCESS: This flags is applicable to negative tests. I.e.
+ *                         it raises a Warning if an operation succeeds when
+ *                         it is expected to fail.
+ * F_MISC_WARN_ON_FAILURE: This flags is applicable to positive tests. I.e.
+ *                         it raises a Warning if an operation fails when it
+ *                         is expected to succeed.
+ */
+#define F_ARCH_ALL			1
+#define F_ARCH_X86			(1 << 1)
+#define F_ARCH_ARM			(1 << 2)
+#define F_ARCH_PPC			(1 << 3)
+#define F_ARCH_MIPS			(1 << 4)
+#define F_ARCH_S390			(1 << 5)
+#define F_ARCH_RISCV			(1 << 6)
+
+#define F_BITS_ALL			(1 << 7)
+#define F_BITS_B64			(1 << 8)
+#define F_BITS_B32			(1 << 9)
+
+#define F_MISC_FATAL			(1 << 10)
+#define F_MISC_STRICT_DEVMEM_REQ	(1 << 11)
+#define F_MISC_STRICT_DEVMEM_PRV	(1 << 12)
+#define F_MISC_INIT_PRV			(1 << 13)
+#define F_MISC_INIT_REQ			(1 << 14)
+#define F_MISC_DONT_CARE		(1 << 15)
+#define F_MISC_WARN_ON_SUCCESS		(1 << 16)
+#define F_MISC_WARN_ON_FAILURE		(1 << 17)
+
+enum {
+	TEST_DENIED,
+	TEST_INCOHERENT,
+	TEST_ALLOWED
+};
+
+struct test_context {
+	struct ram_map	*map;
+	char		*srcbuf;
+	char		*dstbuf;
+	uintptr_t	tst_addr;
+	int		fd;
+	bool		verbose;
+	bool		strict_devmem_state;
+	bool		devmem_init_state;
+};
+
+/*
+ * struct char_mem_test - test case structure for testing /drivers/char/mem.c
+ * @name: name of the test case.
+ * @fn: test callback implementing the test case.
+ * @descr: test case descriptor; it must be formatted as
+ *         "short description"-"function-name"-"FE<i>"
+ *         where
+ *         "short description" describe what the test case does,
+ *         "function-name" is the name of the tested function in
+ *         /drivers/char/mem.c,
+ *         "FE<i>" is the list of tested Function's Expectations from the
+ *         kernel-doc header associated with "function-name".
+ * @flags: test case applicable flags (see list above).
+ */
+struct char_mem_test {
+	char		*name;
+	int		(*fn)(struct test_context *t);
+	char		*descr;
+	uint64_t	flags;
+};
+
+uint64_t virt_to_phys(void *virt_addr);
+int try_read_inplace(int fd, int scnt, void *sbuf);
+int try_read_dev_mem(int fd, uint64_t addr, int scnt, void *sbuf);
+int try_write_dev_mem(int fd, uint64_t addr, int scnt, void *sbuf);
+int fill_random_chars(char *buf, int cnt);
+bool is_zero(const void *p, size_t cnt);
+void print_hex(const void *p, size_t cnt);
+int test_needed(struct test_context *t, struct char_mem_test *current);
+void *malloc_pb(size_t size);
+void free_pb(void *ptr);
+
+#endif
+
-- 
2.48.1


