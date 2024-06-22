Return-Path: <linux-kselftest+bounces-12501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BE591355A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 19:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B41B1C211E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E02A17C69;
	Sat, 22 Jun 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D711IuDF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C00179AF;
	Sat, 22 Jun 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719077117; cv=none; b=kyD93XfGFrxDEVzuPSm9BM/wtOws2xyP/Q2PJ75jYEl6p3V6ZX4jN+rIAHjSjEhUu7kalMteGwDWE6GjBjORxvtXvsifN5Rn35oyN1uBa8TWnYL3adh47x+orX1s8nkO/LuatC8TmeYtKCaisa7cEl3izPAyNXlF54RCoAEn7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719077117; c=relaxed/simple;
	bh=CVM0tqtLkKGFEddWjwzak7cjeyGToDqqOc7peWH2OY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AeVtVKc9ZtSRkd2jS/oMYQcpzCVXlfTdO9IMW13mTsHlDfAyPTgWyT8i4olp7u1x1N18x+tv6vttJqH+9n+PScnR+p+AWISWrgIn42NCAB8XL8BNtQxi5tXFFlWxNbrNLhCM4kPHVF2nH8vd2+TBsG8x7x37FE1BptvAQhVqDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D711IuDF; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-444ca0a84c5so7922251cf.1;
        Sat, 22 Jun 2024 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719077113; x=1719681913; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/NpETEbrYl9agCvQkn9rBKbBmPmmvLpJctZ2r2lHD4=;
        b=D711IuDFRfEeM10K94gGpWzFTTI0EJTFQS0KW1970gpOIgUsXucMmnPJxPvjUvCIvD
         v2ODjn4nVKWqjRdlE3mI6X+MemvbP4TRpYdg/tSAGs5XMlv3N9FngrTssI4NhjsHZnAB
         fXizL4uWNE0l2ASxG1GxhbJtGZRKWC/74L+/Ht7yGH2S5O6BmBf8ica28Aw/jVX++D3I
         hGd3Ftp7NgHEsEg/z/hS4MSirSTrgvD/ItTR1Gp/u47iIUfADYwlEgthMAZNqhJb8FmT
         6jkYA2DnS5FFpMqZUCKjxAqitWe9h7/XTznYMQH7xOeSS29uYTkbjoEOfd4j9m9NSGFm
         wMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719077113; x=1719681913;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/NpETEbrYl9agCvQkn9rBKbBmPmmvLpJctZ2r2lHD4=;
        b=NeBzCur6Ba8Kq2d8VVTer1D1VrxYN447prmz02TSr7MMtI+Jp7B8peTOs8qQDP1zKo
         dH7M4woP9zsDxy9hJvprEdJseMa7b4AcDL0KdoD10aIzXzA5xewfD0HXx1GR2+mUA+r0
         56/jCUllD0b89xEo2DBUrtpzP2EIeFC96F1ycAyGl2pvXsUmajV/ohPuP+YhUtcdWBem
         FDOur5DrOD1F7MGpHhXR8m9AeqYliTKl/X+yJVszc+OianaVPN/dkSxSqgYCRz+Fh2tJ
         V1ZhdtQDa3HUUJSJ8bXs8hB/qXDYpnvQpS+M6anGmxqMOnRr8EMQIHLB6PAzrCdh+i1E
         KaYA==
X-Forwarded-Encrypted: i=1; AJvYcCUe+XQp93TXXVmWLiBivI96m7Kh7dSM5i7NGffxq/Qtjxe+JqnQrKZZfgxeL/faua4jtpaHlQfz/5u2wbX1blpIcsZgvzZkgR12vNX24w9QLDBDWFfNSU20lFkZ+IJn4jTHXSKHUlRs19M6cjqj
X-Gm-Message-State: AOJu0YwyCavairAjBdKX/DRjo5eQZBWY2qk9yjvSPULJjEaeVyYVMX3s
	hBX8u+J4o65WtAm+isBzX/oKO819jwV4YtzwKpsUBCHKjYA6PRc9AHqwnRxy
X-Google-Smtp-Source: AGHT+IFN0A5FAsje5VB6jpRekAfK15MP4jUrNZYgNwmsNaJyRrGMN+wuvRsjTIybljHnzz+75xPxBw==
X-Received: by 2002:ac8:5f87:0:b0:441:52ba:2a5a with SMTP id d75a77b69052e-444d3c0e2a3mr17116401cf.53.1719077113373;
        Sat, 22 Jun 2024 10:25:13 -0700 (PDT)
Received: from [127.0.1.1] ([2607:fea8:bad7:5400:f7e7:150f:53d3:3001])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444d8767fd1sm2444581cf.2.2024.06.22.10.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 10:25:12 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
Date: Sat, 22 Jun 2024 13:24:38 -0400
Subject: [PATCH] selftest: acct: Add selftest for the acct() syscall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240622-kselftest-acct-syscall-v1-1-d270b5be8d37@gmail.com>
X-B4-Tracking: v=1; b=H4sIANUId2YC/x3MQQqDMBBA0avIrDsQB4nYq5QuYpzoYEhLJpRK8
 O4Gl2/xfwXlLKzw7Cpk/onKJzX0jw785tLKKEszkKHBWCLclWMorAWd9wX1UO9iRFomE0Zr7dw
 ztPibOcj/Hr/e53kBujieq2gAAAA=
To: Shuah Khan <shuah@kernel.org>
Cc: javiercarrascocruz@gmail.com, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
X-Mailer: b4 0.14-dev-0bd45
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719077112; l=3225;
 i=abdulrasaqolawani@gmail.com; s=20240613; h=from:subject:message-id;
 bh=CVM0tqtLkKGFEddWjwzak7cjeyGToDqqOc7peWH2OY4=;
 b=vd9kohUia+aY6E1U/5QpBWQZjWU0aRW/t0+jrJUr7gJL3PZUGVgsVAPgjCm5L9Jx/p+KycMLe
 jfBCqnTdmQRDZZzbvfJ+s+49fiaYTLLKzkc4BKq7AJCKk4eSWdqHOjp
X-Developer-Key: i=abdulrasaqolawani@gmail.com; a=ed25519;
 pk=cUqfinPW5pkopFB8ShBc0ZTNgYvSW5ZTa8aLIFPGp/w=

Noticed that there was no selftest for the acct() syscall
which enables the kernel to record terminated processes
into a specified file.

This patch provides a test for the acct() syscall.

Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
---
 tools/testing/selftests/Makefile            |  1 +
 tools/testing/selftests/acct/.gitignore     |  2 +
 tools/testing/selftests/acct/Makefile       |  4 ++
 tools/testing/selftests/acct/acct_syscall.c | 60 +++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9039f3709aff..45a58ef5ad92 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+TARGETS += acct
 TARGETS += alsa
 TARGETS += amd-pstate
 TARGETS += arm64
diff --git a/tools/testing/selftests/acct/.gitignore b/tools/testing/selftests/acct/.gitignore
new file mode 100644
index 000000000000..8ab358d81bd2
--- /dev/null
+++ b/tools/testing/selftests/acct/.gitignore
@@ -0,0 +1,2 @@
+acct_syscall
+config
\ No newline at end of file
diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
new file mode 100644
index 000000000000..ff3e238c5634
--- /dev/null
+++ b/tools/testing/selftests/acct/Makefile
@@ -0,0 +1,4 @@
+TEST_GEN_PROGS := acct_syscall
+CFLAGS += -Wall
+
+include ../lib.mk
\ No newline at end of file
diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
new file mode 100644
index 000000000000..457b83937cac
--- /dev/null
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// kselftest for acct() syscall
+
+// This tests the acct() syscall, which logs closed processes
+// until deactivated or when criteria in /proc/sys/kernel/acct is met
+
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/wait.h>
+
+int main(void)
+{
+// Create file to log closed processes
+char filename[] = "process_log";
+FILE *fp;
+fp = fopen(filename, "w");
+
+int i = acct(filename);
+
+if (i) {
+    printf("Test Result: %s\n", strerror(errno));
+    remove(filename);
+    fclose(fp);
+    return 1;
+}
+
+    // Create child process and wait to close
+pid_t child_pid;
+
+child_pid = fork();
+
+if (child_pid < 0) {
+    printf("Process failed\n");
+    return 1;
+} else if (child_pid == 0) {
+    printf("Child process successfully created!\n");
+} else {
+    wait(NULL);
+    fseek(fp, 0L, SEEK_END);
+    int sz = ftell(fp);
+    printf("Parent process successfully created!\n");
+
+    i = acct(NULL);
+
+    if (sz <= 0) {
+        printf("Child process not logged");
+        return 1;
+    }
+
+    printf("Test Result: Successfully logged closed process.\n");
+    remove(filename);
+    fclose(fp);
+    return 0;
+}
+
+return 1;
+}

---
base-commit: 50736169ecc8387247fe6a00932852ce7b057083
change-id: 20240622-kselftest-acct-syscall-2d90f7666b1e

Best regards,
-- 
Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>


