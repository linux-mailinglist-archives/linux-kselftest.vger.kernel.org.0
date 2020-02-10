Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1537615839F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2020 20:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBJTbG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 14:31:06 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33971 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgBJTbF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:05 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so7598577otf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2020 11:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dy7V9n1SJWAfsimqdnx79gIWJx+OE4CfcWEJjNElzkw=;
        b=kD5EGiWmI843sCuCafTUWkInv63C7SrnPb5eYa/PNLKeGUkbgs8l0tKEsrbARmFeO3
         WnDV5WSszUbzwfAhGPPrFN3uYkvvUZgZNfPv/RmgJGj1O3LaHMDNKg2LDgAb2xaw9T6a
         jtQyquGSSoFjFpvv8I0f9WMF2jMQbyTYs6jqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dy7V9n1SJWAfsimqdnx79gIWJx+OE4CfcWEJjNElzkw=;
        b=j0XDVbd3hOsMH8hCbNK3Ab2v+4gh4PA49vBy8ozdBwf6eMaUK+qzUICYFvEEshr/lc
         IJWrVp4R1igFqHI0zj/VtBU/vayAiZukWFF+U1pca+O/W9IGwn65XGLhCw6xtGM+InLe
         aQGR3wlPzK698+wHMtdOQRH5nNyV/ln4RQEtuj4kNeQ6KDBfXuV8pDcqWkMBI7EBUIFG
         YjZPx6DV7KKs1dX6Rgqmw7jKgGXC4wGcnrS0dqtbI1lFXLceaAVo921qLEjJ8jStP/ii
         RA1if3LD+1bcYFQF4FhgUNhrAlioNISTO9otOv7FkNcad9IWL/CGHd2GVe2nx9i6JGEG
         X0RQ==
X-Gm-Message-State: APjAAAWZDo1cOcNhE586q6wUlUNZgbz3XQQ/zFV6i+1m8Mr810fHBb5h
        okz2ATgtCkZGlo9t6NcIinIkiQ==
X-Google-Smtp-Source: APXvYqytQ6Tq8ED/M4IZzD6H8znkZODeLSYS85Lxv1Mg2ykDKGTymMbliK1RJrYqSv3Cgm5yBLjtiw==
X-Received: by 2002:a9d:5a09:: with SMTP id v9mr2153543oth.214.1581363064328;
        Mon, 10 Feb 2020 11:31:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p24sm358258otq.64.2020.02.10.11.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:31:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 7/7] selftests/exec: Add READ_IMPLIES_EXEC tests
Date:   Mon, 10 Feb 2020 11:30:49 -0800
Message-Id: <20200210193049.64362-8-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210193049.64362-1-keescook@chromium.org>
References: <20200210193049.64362-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to check the matrix of possible states for handling
READ_IMPLIES_EXEC across native, compat, and the state of PT_GNU_STACK,
add tests for these execution conditions.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/exec/Makefile         |  42 +++++-
 .../selftests/exec/read_implies_exec.c        | 121 ++++++++++++++++++
 .../selftests/exec/strip-gnu-stack-bits.c     |  34 +++++
 .../testing/selftests/exec/strip-gnu-stack.c  |  69 ++++++++++
 4 files changed, 265 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/exec/read_implies_exec.c
 create mode 100644 tools/testing/selftests/exec/strip-gnu-stack-bits.c
 create mode 100644 tools/testing/selftests/exec/strip-gnu-stack.c

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 33339e31e365..085d0e4422ea 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -10,7 +10,19 @@ TEST_FILES := Makefile
 
 TEST_GEN_PROGS += recursion-depth
 
-EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*
+TEST_GEN_FILES += strip-gnu-stack
+TEST_GEN_PROGS += rie-nx-gnu-stack rie-x-gnu-stack rie-missing-gnu-stack
+
+# While it would be nice to not build "compat" binaries on 32-bit builders,
+# there's no harm: they're just redundant to the native binaries, so skip
+# performing any detection for now, as it gets complex quickly.
+TEST_GEN_PROGS += rie-compat-nx-gnu-stack \
+		  rie-compat-x-gnu-stack \
+		  rie-compat-missing-gnu-stack
+
+EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved \
+		$(OUTPUT)/rie-*.new \
+		$(OUTPUT)/xxxxx*
 
 include ../lib.mk
 
@@ -26,3 +38,31 @@ $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
 	cp $< $@
 	chmod -x $@
 
+$(OUTPUT)/strip-gnu-stack: strip-gnu-stack.c strip-gnu-stack-bits.c
+	$(CC) $(CFLAGS) -o $@ $<
+
+$(OUTPUT)/rie-nx-gnu-stack: read_implies_exec.c
+	$(CC) $(CFLAGS) -Wl,-z,noexecstack -o $@.new $<
+	readelf -Wl $@.new | grep GNU_STACK | grep -q 'RW ' && \
+	mv $@.new $@
+$(OUTPUT)/rie-x-gnu-stack: read_implies_exec.c
+	$(CC) $(CFLAGS) -Wl,-z,execstack -o $@.new $<
+	readelf -Wl $@.new | grep GNU_STACK | grep -q 'RWE' && \
+	mv $@.new $@
+$(OUTPUT)/rie-missing-gnu-stack: read_implies_exec.c $(OUTPUT)/strip-gnu-stack
+	$(CC) $(CFLAGS) -o $@.new $<
+	$(OUTPUT)/strip-gnu-stack $@.new && \
+	mv $@.new $@
+
+$(OUTPUT)/rie-compat-nx-gnu-stack: read_implies_exec.c
+	$(CC) -m32 $(CFLAGS) -Wl,-z,noexecstack -o $@.new $<
+	readelf -Wl $@.new | grep GNU_STACK | grep -q 'RW ' && \
+	mv $@.new $@
+$(OUTPUT)/rie-compat-x-gnu-stack: read_implies_exec.c
+	$(CC) -m32 $(CFLAGS) -Wl,-z,execstack -o $@.new $<
+	readelf -Wl $@.new | grep GNU_STACK | grep -q 'RWE' && \
+	mv $@.new $@
+$(OUTPUT)/rie-compat-missing-gnu-stack: read_implies_exec.c $(OUTPUT)/strip-gnu-stack
+	$(CC) -m32 $(CFLAGS) -o $@.new $<
+	$(OUTPUT)/strip-gnu-stack $@.new && \
+	mv $@.new $@
diff --git a/tools/testing/selftests/exec/read_implies_exec.c b/tools/testing/selftests/exec/read_implies_exec.c
new file mode 100644
index 000000000000..4b253a84dd27
--- /dev/null
+++ b/tools/testing/selftests/exec/read_implies_exec.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This just examines a PROT_READ mapping to report if it see it gain
+ * PROT_EXEC too (which means that READ_IMPLIES_EXEC has been enabled).
+ */
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+
+const char maps_path[] = "/proc/self/maps";
+
+int main(int argc, char *argv[])
+{
+	char maps_line[1024];
+	FILE *maps;
+	void *region;
+	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
+	int ret = -1;
+	int perms = -1;
+	int vma_64bit;
+
+	region = mmap(NULL, getpagesize(), PROT_READ, flags, -1, 0);
+	if (region == MAP_FAILED) {
+		perror("mmap");
+		return 128;
+	}
+	maps = fopen(maps_path, "r");
+	if (!maps) {
+		perror(maps_path);
+		ret = 127;
+		goto out_munmap;
+	}
+
+	memset(maps_line, 0, sizeof(maps_line));
+	while (fgets(maps_line, sizeof(maps_line), maps)) {
+		unsigned long long low, high;
+		char *end;
+
+		low = strtoull(maps_line, &end, 16);
+		if (*end != '-') {
+			fprintf(stderr, "Missing '-' separator, line: %s",
+				maps_line);
+			ret = 126;
+			goto out_close;
+		}
+		end++;
+
+		high = strtoull(end, &end, 16);
+		if (*end != ' ') {
+			fprintf(stderr, "Missing ' ' separator, line: %s",
+				maps_line);
+			ret = 125;
+			goto out_close;
+		}
+		end++;
+
+		if ((uintptr_t)region >= low && (uintptr_t)region < high) {
+			perms = 0;
+			perms |= end[0] == 'r' ? PROT_READ : 0;
+			perms |= end[1] == 'w' ? PROT_WRITE : 0;
+			perms |= end[2] == 'x' ? PROT_EXEC : 0;
+
+			break;
+		}
+	}
+	if (perms == -1) {
+		fprintf(stderr, "Could not find mmap region\n");
+		ret = 124;
+		goto out_close;
+	}
+
+	vma_64bit = sizeof(void *) == 8;
+	fprintf(stderr, "%s-bit, ", vma_64bit ? "64" : "32");
+
+	ret = 1;
+	if (strstr(argv[0], "missing-gnu-stack")) {
+		fprintf(stderr, "missing-gnu-stack, ");
+
+		/* Missing PT_GNU_STACK on 64-bit: not READ_IMPLIES_EXEC */
+		if (vma_64bit && (perms & PROT_EXEC) == 0)
+			ret = 0;
+		/* Missing PT_GNU_STACK on 32-bit enables READ_IMPLIES_EXEC */
+		if (!vma_64bit && (perms & PROT_EXEC) == PROT_EXEC)
+			ret = 0;
+	} else if (strstr(argv[0], "x-gnu-stack")) {
+		fprintf(stderr, "executable gnu-stack, ");
+
+		/* X PT_GNU_STACK should always leave READ_IMPLIES_EXEC off */
+		if ((perms & PROT_EXEC) == 0)
+			ret = 0;
+	} else if (strstr(argv[0], "nx-gnu-stack")) {
+		fprintf(stderr, "non-executable PT_GNU_STACK, ");
+
+		/* NX PT_GNU_STACK should always leave READ_IMPLIES_EXEC off */
+		if ((perms & PROT_EXEC) == 0)
+			ret = 0;
+	} else {
+		fprintf(stderr, "Unknown invocation\n");
+		ret = 123;
+		goto out_close;
+	}
+
+	fprintf(stderr, "READ_IMPLIES_EXEC is %s: ",
+		(perms & PROT_EXEC) ? "on" : "off");
+
+	if (ret)
+		fprintf(stderr, "FAIL: %s", maps_line);
+	else
+		fprintf(stderr, "ok\n");
+
+out_close:
+	fclose(maps);
+out_munmap:
+	munmap(region, getpagesize());
+
+	return ret;
+}
diff --git a/tools/testing/selftests/exec/strip-gnu-stack-bits.c b/tools/testing/selftests/exec/strip-gnu-stack-bits.c
new file mode 100644
index 000000000000..907e959c3477
--- /dev/null
+++ b/tools/testing/selftests/exec/strip-gnu-stack-bits.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * word-size agnostic routines to scan ELF program headers for PT_GNU_STACK
+ * and rewrite it as PT_NULL to emulate old toolchains that did not include
+ * the PT_GNU_STACK program header.
+ */
+
+int strip_bits(char *elf, size_t size)
+{
+	unsigned int i;
+	Elf_Ehdr *eh;
+
+	eh = (Elf_Ehdr *)elf;
+	if (sizeof(*eh) > size) {
+		fprintf(stderr, "Elf Header too small\n");
+		return 124;
+	}
+
+	for (i = 0; i < eh->e_phnum; i++) {
+		Elf_Phdr *ph = (Elf_Phdr *)(elf + (eh->e_phoff + eh->e_phentsize * i));
+
+		if (ph->p_type == PT_GNU_STACK) {
+			ph->p_type = PT_NULL;
+			return 0;
+		}
+	}
+
+	fprintf(stderr, "PT_GNU_STACK missing\n");
+	return 123;
+}
+
+#undef strip_bits
+#undef Elf_Ehdr
+#undef Elf_Phdr
diff --git a/tools/testing/selftests/exec/strip-gnu-stack.c b/tools/testing/selftests/exec/strip-gnu-stack.c
new file mode 100644
index 000000000000..529e60cf0e6e
--- /dev/null
+++ b/tools/testing/selftests/exec/strip-gnu-stack.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Converts an ELF's PT_GNU_STACK program header to PT_NULL. */
+#include <elf.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#define strip_bits	strip64
+#define Elf_Ehdr	Elf64_Ehdr
+#define Elf_Phdr	Elf64_Phdr
+#include "strip-gnu-stack-bits.c"
+
+#define strip_bits	strip32
+#define Elf_Ehdr	Elf32_Ehdr
+#define Elf_Phdr	Elf32_Phdr
+#include "strip-gnu-stack-bits.c"
+
+int strip(char *elf, size_t size)
+{
+	if (size < 4 || elf[0] != '\x7f' || strncmp(elf + 1, "ELF", 3) != 0) {
+		fprintf(stderr, "Not an ELF file\n");
+		return 128;
+	}
+	switch (elf[EI_CLASS]) {
+	case ELFCLASS64:
+		return strip64(elf, size);
+	case ELFCLASS32:
+		return strip32(elf, size);
+	default:
+		fprintf(stderr, "Unknown EI_CLASS: 0x%02x\n", elf[EI_CLASS]);
+		return 127;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int fd, ret;
+	struct stat info;
+	char *elf;
+
+	fd = open(argv[1], O_RDWR);
+	if (fd < 0) {
+		perror(argv[1]);
+		return 1;
+	}
+
+	if (fstat(fd, &info)) {
+		perror(argv[1]);
+		return 2;
+	}
+
+	elf = mmap(NULL, info.st_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		   fd, 0);
+	if (elf == MAP_FAILED) {
+		perror(argv[1]);
+		return 3;
+	}
+
+	ret = strip(elf, info.st_size);
+
+	munmap(elf, info.st_size);
+	close(fd);
+	return ret;
+}
-- 
2.20.1

