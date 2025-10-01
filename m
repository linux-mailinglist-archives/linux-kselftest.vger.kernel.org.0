Return-Path: <linux-kselftest+bounces-42653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21292BB01C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 01 Oct 2025 13:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FEC3C1540
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Oct 2025 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8312C326F;
	Wed,  1 Oct 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UDns/vnf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E42581
	for <linux-kselftest@vger.kernel.org>; Wed,  1 Oct 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317325; cv=none; b=XL6A5xvg8O5pHDlv1meSuzoy8xMtIT9ws1iuFzqbrmCCNO1/r5AV8ZaTLcqSZ63gcxzUBdBW8kPNyQ/VxYMzWVjQ5pZ9MYdIaCU752tpHu6Fw1Wqpcj9Cr0Q1yfw9Nd7LrUPAktGV0u8MrWGrcqK11VqmMueDX8GoYG6wiIfVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317325; c=relaxed/simple;
	bh=EYuImIcyyR0XWCOBoHNfAisa1ZiJGd9hAkfAM7fve9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIkqDFYFHvmGi8Euj5ky9JUxDOwjjp3MjFi9aXZIjksvCL26guPcBkh6AdwQDVFmTWUMULBN7MzXazoyf4IBQ15gPsPoSajfR6JzUVk+MrBYWSnLeDJEbSDe2t89tsQnfyUr+tL0ESZgoFmredBK7kh3M7+/poKhYFFJ0R3Dbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UDns/vnf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so15982285ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Oct 2025 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759317323; x=1759922123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE/uK3RiLFxkAahbU4hR2pbuKpR75t2ugKvqzT3OzwM=;
        b=UDns/vnfcLflMppU5m5vOiO2L3NKhv0rmyvFhKwcwL77K/VPjEKM0mnKNkPNe0rYZ9
         2ENch9p01cMABoMn8shQAWEe0GSUKyRpMlQ4BLm2KQfEQQtTLp3cA4feDOYrGrwU0Qo1
         IjpLzojjUFA0e62zx9PB5fPD7FLDOMhiy4arEhmzIqvaDrDIdWJrMfhGlyq1Ztn2L4Qc
         XnKFyC2IYE5U5A0QExvqC/5FUTcq2TuQTToLlBve4byo6S3LpAo54RuL4Fk55wI++RX/
         yW8OyEI1t/lt2KRh3T0yAJZWvtJMd40utNPc/5dRZOwq1dxE+z7nMiDQb/iwyV0S1IZx
         mqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317323; x=1759922123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nE/uK3RiLFxkAahbU4hR2pbuKpR75t2ugKvqzT3OzwM=;
        b=HITImuq/FIPbWF20s9N2WTAwLTbsbjk1ht3Q2ie003rV++5cozVyMQfVkTLyqSncvF
         tOLLXESFdYcqCooC9B40HrP1L6aWFVZdBEuQL8uRCGMbFXW7aWxpVJxDjBPxXX0QJ60n
         WOHatJRvPX6tHXj9x3vapVydLWqu+jz6jjvF4CoNvviW/V52gTTaylVzgHYtZPwMHXnO
         6zu+rGDyuorjlwHLbxMjFUItEI6FzN+yypgJVUJLdeEvSJ4eh0YDIdRp8kjR1E3uVyVA
         +ufIsXTfjy0jYaZnzoqZScXh9JMjyV5MTAblDfngA/1XlIOftWBy76LpMDgorqpGT/RR
         2E2w==
X-Forwarded-Encrypted: i=1; AJvYcCUGwL4TzQllqbPXNliUT+5xx9X/ZP7ojNUFzLgUSAundh0WJpZAIUve0eJDZGxrPbXPv6uZmMbBS7IJFB0v0gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBn9KBXGZxKEm0nrgdJsn00rvZnSReZH6z9Qexra4Z6C18zMU
	69wdkBET+8SRGGc5purHwXZksCAd/vKSl+YhsLQID1B32lYzHYdVoUxzMnuozobcIz8=
X-Gm-Gg: ASbGncvnsgnSJm0Abj9yth1KH2pfEkz5Stbzd+Wpnx7Vn0ekayasVPSarKxX2qa9oKF
	pwbgkiPjtGy4Ryk6EGbZBPg0qVlMWugwIf5km/onscmvypTKbaxSqbsFTQyjqPEFGZX2uAZTuXx
	phhRbXmW2CMWx+z4HMHkqOIJEcgCYOguOYEtoIiSAgZZSTFGvUVOZ+XZ2vgX7oWpenUHi3NVToT
	PjE2jNjOc3+G2DoXZxQjE7vVsEF3YeZBoudakOy/EBJ5Hbota3mpCAIPBfPVSctUA3k7uwIpE0s
	920/szD6e5Z7MP8xLDx/DDs0WwkaHdFyVSs3h20N4ILYL7MsLxSBYnIGCGX96EQwFrIAKt3Ruy3
	mi+rJCe4J89zDbP/eGCyo0hQuJfI2O/Tri/JB7SlvAmIDJ+oEsK4UUxMAy+rAz6eXgVLoUiWh73
	M2
X-Google-Smtp-Source: AGHT+IHaQVYCBGhi6YuZz9AVv9ozF42lBeCotDfbCK65/uvxRiVeZgynF5pIWS0sP/qUcqQD0l0vdQ==
X-Received: by 2002:a17:903:2352:b0:25b:a5fc:8664 with SMTP id d9443c01a7336-28e7f442c10mr34026095ad.51.1759317323243;
        Wed, 01 Oct 2025 04:15:23 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27eeb9a8ebfsm155163455ad.67.2025.10.01.04.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:15:22 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v 2/2] selftests: riscv: Add test for the Vector ptrace interface
Date: Wed,  1 Oct 2025 19:14:27 +0800
Message-ID: <20251001111451.299163-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001111451.299163-1-yongxuan.wang@sifive.com>
References: <20251001111451.299163-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case that does some basic verification of the Vector ptrace
interface. This forks a child process then using ptrace to inspect and
manipulate the v31 register of the child.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 tools/testing/selftests/riscv/vector/Makefile |   5 +-
 .../selftests/riscv/vector/vstate_ptrace.c    | 132 ++++++++++++++++++
 2 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/vector/vstate_ptrace.c

diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testing/selftests/riscv/vector/Makefile
index 6f7497f4e7b3..45f25e9dd264 100644
--- a/tools/testing/selftests/riscv/vector/Makefile
+++ b/tools/testing/selftests/riscv/vector/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2021 ARM Limited
 # Originally tools/testing/arm64/abi/Makefile
 
-TEST_GEN_PROGS := v_initval vstate_prctl
+TEST_GEN_PROGS := v_initval vstate_prctl vsate_ptrace
 TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc v_exec_initval_nolibc
 
 include ../../lib.mk
@@ -26,3 +26,6 @@ $(OUTPUT)/v_initval: v_initval.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
 $(OUTPUT)/v_exec_initval_nolibc: v_exec_initval_nolibc.c
 	$(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
 		-Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
+
+$(OUTPUT)/vstate_ptrace: vstate_ptrace.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/vector/vstate_ptrace.c b/tools/testing/selftests/riscv/vector/vstate_ptrace.c
new file mode 100644
index 000000000000..8a7bcf318e59
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/vstate_ptrace.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+#include <stdlib.h>
+#include <asm/ptrace.h>
+#include <linux/elf.h>
+#include <sys/ptrace.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include "../../kselftest.h"
+#include "v_helpers.h"
+
+int parent_set_val, child_set_val;
+
+static long do_ptrace(enum __ptrace_request op, pid_t pid, long type, size_t size, void *data)
+{
+	struct iovec v_iovec = {
+		.iov_len = size,
+		.iov_base = data
+	};
+
+	return ptrace(op, pid, type, &v_iovec);
+}
+
+static int do_child(void)
+{
+	int out;
+
+	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL)) {
+		ksft_perror("PTRACE_TRACEME failed\n");
+		return EXIT_FAILURE;
+	}
+
+	asm volatile (".option push\n\t"
+		".option	arch, +v\n\t"
+		"vsetivli	x0, 1, e32, m1, ta, ma\n\t"
+		"vmv.s.x	v31, %[in]\n\t"
+		"ebreak\n\t"
+		"vmv.x.s	%[out], v31\n\t"
+		".option pop\n\t"
+		: [out] "=r" (out)
+		: [in] "r" (child_set_val));
+
+	if (out != parent_set_val)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static void do_parent(pid_t child)
+{
+	int status;
+	void *data = NULL;
+
+	/* Attach to the child */
+	while (waitpid(child, &status, 0)) {
+		if (WIFEXITED(status)) {
+			ksft_test_result(WEXITSTATUS(status) == 0, "SETREGSET vector\n");
+			goto out;
+		} else if (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP)) {
+			size_t size, t;
+			void *data, *v31;
+			struct __riscv_v_regset_state *v_regset_hdr;
+			struct user_regs_struct *gpreg;
+
+			size = sizeof(*v_regset_hdr);
+			data = malloc(size);
+			if (!data)
+				goto out;
+			v_regset_hdr = (struct __riscv_v_regset_state *)data;
+
+			if (do_ptrace(PTRACE_GETREGSET, child, NT_RISCV_VECTOR, size, data))
+				goto out;
+
+			ksft_print_msg("vlenb %ld\n", v_regset_hdr->vlenb);
+			data = realloc(data, size + v_regset_hdr->vlenb * 32);
+			if (!data)
+				goto out;
+			v31 = (void *)(data + size + v_regset_hdr->vlenb * 31);
+			size += v_regset_hdr->vlenb * 32;
+
+			if (do_ptrace(PTRACE_GETREGSET, child, NT_RISCV_VECTOR, size, data))
+				goto out;
+
+			ksft_test_result(*(int *)v31 == child_set_val, "GETREGSET vector\n");
+
+			*(int *)v31 = parent_set_val;
+			if (do_ptrace(PTRACE_SETREGSET, child, NT_RISCV_VECTOR, size, data))
+				goto out;
+
+			/* move the pc forward */
+			size = sizeof(*gpreg);
+			data = realloc(data, size);
+			gpreg = (struct user_regs_struct *)data;
+
+			if (do_ptrace(PTRACE_GETREGSET, child, NT_PRSTATUS, size, data))
+				goto out;
+
+			gpreg->pc += 2;
+			if (do_ptrace(PTRACE_SETREGSET, child, NT_PRSTATUS, size, data))
+				goto out;
+		}
+
+		ptrace(PTRACE_CONT, child, NULL, NULL);
+	}
+
+out:
+	free(data);
+}
+
+int main(void)
+{
+	pid_t child;
+
+	ksft_set_plan(2);
+	if (!is_vector_supported() && !is_xtheadvector_supported())
+		ksft_exit_skip("Vector not supported\n");
+
+	srandom(getpid());
+	parent_set_val = rand();
+	child_set_val = rand();
+
+	child = fork();
+	if (child < 0)
+		ksft_exit_fail_msg("Fork failed %d\n", child);
+
+	if (!child)
+		return do_child();
+
+	do_parent(child);
+
+	ksft_finished();
+}
-- 
2.43.0


