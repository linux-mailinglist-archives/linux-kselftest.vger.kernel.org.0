Return-Path: <linux-kselftest+bounces-8006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F638A57DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D7BB23F16
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F01839E4;
	Mon, 15 Apr 2024 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KWWw0XX+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9538288A
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198944; cv=none; b=Rxd2hgzk8+n1PQ1J3lYAp5E90BuVVAqSDJbb96wGe+aSWZD7lqR2JAzJql7CEqyr7H0AiT5HBq/WU+19CQJ/n4r9ZHqPeb0YnA+v4HiF3QoTziuOvCfMF0XM4otjJUgys3ziQc8t/jUGgi9OVlePRrEC3+pAHFsFJ2ldeTTJcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198944; c=relaxed/simple;
	bh=tEqZvV3FTwNDGdXGDfu5US6D8OLXShAXUJ74HD0l3yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJ72iiZcQRpHj+lBPa09qzWJtmOpgOmh3m45N5vKnB22EhpCj7y4vBRwoKZtimYUQ01GqixCDVdQ0wwwSH4aHYtzNl4sZecAqmFpYrrszpnUxhaglVHSskLTmZNiVjTT7zNEYaADzIyOFZjTN3QTbjV8Mrvql/VTRz1QFzYi87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KWWw0XX+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so1151226b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713198941; x=1713803741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJHOXE7W4iXMxi8stv8aQLFD0obJISw2P5aysbaDa0s=;
        b=KWWw0XX+uRhxngnEB1gxEnR00m+vN8V9cxoyzeZ0ePPrVk+Yh9u3YLJrlE+Y+jPisW
         uDJ1fvHE9KwRd9r1qgESRWqbyIBgfzfUoPeYN0xhDV5NMuYxHjFiN94VfVbQIRoduUN2
         vseEgNBAC9pRk0e4510/tOMcTcPpmCGAcOjsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198941; x=1713803741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJHOXE7W4iXMxi8stv8aQLFD0obJISw2P5aysbaDa0s=;
        b=YWgvDakzncJEslRM/7V/17qc01TmyGreVIndxsT8CJckOAYgVUZo2wGc0BkfwbEyMh
         iYdorBVe8RZaP/6d2vyaEpO7RA6ulFsU9WhBUfGTRQRJ/MJVo00R6JcNzcq74ad00En3
         qmB4CQP+PrFqcSPdMH2JP5Nx7B7eL34EbcBsBFomu916Wxf++63Gde/ybRd9/F6bjchf
         xpJnWPgTxp9KEf0Igf+Mty+xgqKKLKDFTVz/WIhJFACdIAVHSdCdt3YgW2wYaCtZJrDY
         l1DL5ZYe5aGmfjFJxrdihD31PYfo2meDZolBeimaIL+duwtBpLav9cEL2LW2wt6sijoa
         HPyA==
X-Forwarded-Encrypted: i=1; AJvYcCXh03CaD22FeI47IBVdb31Xxwj0jq2Ee9neJEDkYYxTMaNFev6/pNZfN3Qg+b61sJIqjAlxCtywFsmdX66NYp3Xe4PT6AlZtAhtrQ1CfthO
X-Gm-Message-State: AOJu0Yx6cPjEXa55ow7GXK99+Azds23B+IjnkxPeXRyoYLX12oi5wCxk
	7vUYBVOZpP8exP+l7iIUUykeTE20jgeMwZGU7KvNFFblFMDpsCngffyjGej/NQ==
X-Google-Smtp-Source: AGHT+IGpxBiXitUV65X12uO9kCt9yTS7pqi2G5lLyGKRXo70DVpYj0l9hUD2hNlk3bYPsgQK0YTsXQ==
X-Received: by 2002:a05:6a21:151a:b0:1a9:b3e9:a62c with SMTP id nq26-20020a056a21151a00b001a9b3e9a62cmr8978922pzb.48.1713198941478;
        Mon, 15 Apr 2024 09:35:41 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id b13-20020a630c0d000000b005dc4da2121fsm7213902pgl.6.2024.04.15.09.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 09:35:40 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v10 5/5] selftest mm/mseal read-only elf memory segment
Date: Mon, 15 Apr 2024 16:35:24 +0000
Message-ID: <20240415163527.626541-6-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240415163527.626541-1-jeffxu@chromium.org>
References: <20240415163527.626541-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Sealing read-only of elf mapping so it can't be changed by mprotect.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/.gitignore |   1 +
 tools/testing/selftests/mm/Makefile   |   1 +
 tools/testing/selftests/mm/seal_elf.c | 183 ++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/mm/seal_elf.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 98eaa4590f11..0b9ab987601c 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -48,3 +48,4 @@ va_high_addr_switch
 hugetlb_fault_after_madv
 hugetlb_madv_vs_map
 mseal_test
+seal_elf
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 95d10fe1b3c1..02392c426759 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -60,6 +60,7 @@ TEST_GEN_FILES += mrelease_test
 TEST_GEN_FILES += mremap_dontunmap
 TEST_GEN_FILES += mremap_test
 TEST_GEN_FILES += mseal_test
+TEST_GEN_FILES += seal_elf
 TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += pagemap_ioctl
 TEST_GEN_FILES += thuge-gen
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
new file mode 100644
index 000000000000..61a2f1c94e02
--- /dev/null
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/mman.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <stdbool.h>
+#include "../kselftest.h"
+#include <syscall.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <fcntl.h>
+#include <assert.h>
+#include <sys/ioctl.h>
+#include <sys/vfs.h>
+#include <sys/stat.h>
+
+/*
+ * need those definition for manually build using gcc.
+ * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 seal_elf.c -o seal_elf
+ */
+#define FAIL_TEST_IF_FALSE(c) do {\
+		if (!(c)) {\
+			ksft_test_result_fail("%s, line:%d\n", __func__, __LINE__);\
+			goto test_end;\
+		} \
+	} \
+	while (0)
+
+#define SKIP_TEST_IF_FALSE(c) do {\
+		if (!(c)) {\
+			ksft_test_result_skip("%s, line:%d\n", __func__, __LINE__);\
+			goto test_end;\
+		} \
+	} \
+	while (0)
+
+
+#define TEST_END_CHECK() {\
+		ksft_test_result_pass("%s\n", __func__);\
+		return;\
+test_end:\
+		return;\
+}
+
+#ifndef u64
+#define u64 unsigned long long
+#endif
+
+/*
+ * define sys_xyx to call syscall directly.
+ */
+static int sys_mseal(void *start, size_t len)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_mseal, start, len, 0);
+	return sret;
+}
+
+static void *sys_mmap(void *addr, unsigned long len, unsigned long prot,
+	unsigned long flags, unsigned long fd, unsigned long offset)
+{
+	void *sret;
+
+	errno = 0;
+	sret = (void *) syscall(__NR_mmap, addr, len, prot,
+		flags, fd, offset);
+	return sret;
+}
+
+inline int sys_mprotect(void *ptr, size_t size, unsigned long prot)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_mprotect, ptr, size, prot);
+	return sret;
+}
+
+static bool seal_support(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+
+	ptr = sys_mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (ptr == (void *) -1)
+		return false;
+
+	ret = sys_mseal(ptr, page_size);
+	if (ret < 0)
+		return false;
+
+	return true;
+}
+
+const char somestr[4096] = {"READONLY"};
+
+static void test_seal_elf(void)
+{
+	int ret;
+	FILE *maps;
+	char line[512];
+	int size = 0;
+	uintptr_t  addr_start, addr_end;
+	char prot[5];
+	char filename[256];
+	unsigned long page_size = getpagesize();
+	unsigned long long ptr = (unsigned long long) somestr;
+	char *somestr2 = (char *)somestr;
+
+	/*
+	 * Modify the protection of readonly somestr
+	 */
+	if (((unsigned long long)ptr % page_size) != 0)
+		ptr = (unsigned long long)ptr & ~(page_size - 1);
+
+	ksft_print_msg("somestr = %s\n", somestr);
+	ksft_print_msg("change protection to rw\n");
+	ret = sys_mprotect((void *)ptr, page_size, PROT_READ|PROT_WRITE);
+	FAIL_TEST_IF_FALSE(!ret);
+	*somestr2 = 'A';
+	ksft_print_msg("somestr is modified to: %s\n", somestr);
+	ret = sys_mprotect((void *)ptr, page_size, PROT_READ);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	maps = fopen("/proc/self/maps", "r");
+	FAIL_TEST_IF_FALSE(maps);
+
+	/*
+	 * apply sealing to elf binary
+	 */
+	while (fgets(line, sizeof(line), maps)) {
+		if (sscanf(line, "%lx-%lx %4s %*x %*x:%*x %*u %255[^\n]",
+			&addr_start, &addr_end, &prot, &filename) == 4) {
+			if (strlen(filename)) {
+				/*
+				 * seal the mapping if read only.
+				 */
+				if (strstr(prot, "r-")) {
+					ret = sys_mseal((void *)addr_start, addr_end - addr_start);
+					FAIL_TEST_IF_FALSE(!ret);
+					ksft_print_msg("sealed: %lx-%lx %s %s\n",
+						addr_start, addr_end, prot, filename);
+					if ((uintptr_t) somestr >= addr_start &&
+						(uintptr_t) somestr <= addr_end)
+						ksft_print_msg("mapping for somestr found\n");
+				}
+			}
+		}
+	}
+	fclose(maps);
+
+	ret = sys_mprotect((void *)ptr, page_size, PROT_READ | PROT_WRITE);
+	FAIL_TEST_IF_FALSE(ret < 0);
+	ksft_print_msg("somestr is sealed, mprotect is rejected\n");
+
+	TEST_END_CHECK();
+}
+
+int main(int argc, char **argv)
+{
+	bool test_seal = seal_support();
+
+	ksft_print_header();
+	ksft_print_msg("pid=%d\n", getpid());
+
+	if (!test_seal)
+		ksft_exit_skip("sealing not supported, check CONFIG_64BIT\n");
+
+	ksft_set_plan(1);
+
+	test_seal_elf();
+
+	ksft_finished();
+	return 0;
+}
-- 
2.44.0.683.g7961c838ac-goog


