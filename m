Return-Path: <linux-kselftest+bounces-19082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB611991372
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 02:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30067B21745
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 00:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E064231C97;
	Sat,  5 Oct 2024 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR43zOOC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46741196;
	Sat,  5 Oct 2024 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728087456; cv=none; b=MxvwA2uL82Qvsf0l4fr02lSYGNfiKxv82CQvQkgs5R+6aBtbAp1IauIjIWMPONMOS3vbU00NnhoQFRIuwzZ0xXjczE0t32HBNC/gOO4xsX+qEAliEQa5n9/IaQnoqcDxi3mU6AlxUygaoQKzo+5VsBknImAnKLtDRe5ZwdlXEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728087456; c=relaxed/simple;
	bh=HBOHRdZdSmmXwU8CFIly7OLLMk7spi/PNBI76VLErPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R14vRh3DJeEQZr/xewv18TYYEyERfnJQV87/uTNhkRnG54e4GFdSwMewSKI4ciKx9d0x+KC7AmJF4vhfCupmKC3rWkuH1W54qAMxUiMzwzJmwcpThvb8JdQXHAiHGHapGsyAP+/dOgbzWqR4WofczVjC2ONbbjnYLpW2J8uCjHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR43zOOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75409C4CEC6;
	Sat,  5 Oct 2024 00:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728087455;
	bh=HBOHRdZdSmmXwU8CFIly7OLLMk7spi/PNBI76VLErPk=;
	h=From:Date:Subject:To:Cc:From;
	b=OR43zOOC99Cc+jG0Se3387Ts/fo1iphUw9Wrq0ZMFwVPHgRCYqpwj1EtVA9WPXIBU
	 jCk/6jx4yl3abGJA1/la4VONVolLZs+TfdasMRClgjAnKKTffjUHf2CLqph62t5GnZ
	 vyAzlEVwO1QnxkpHb/W8jfLpqQXjXstWcamKt0yLW4oxiTxP+4DBcMCEOYxCR3wTFT
	 7auZMCsjatplj/91J3fU6zJ4qD9GA1U3iarsXJcjwMyahoOCON5/PAU8arCjVG4Tqm
	 cl3fmbTIAY0DGJNbj8V3YEFWMl2s//vr3lbIQiIpF+85genEViHmQQFiS3Y0TEp9aW
	 v2o3pVp8I7QIA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 01:17:18 +0100
Subject: [PATCH] kselftest/arm64: Validate that GCS push and write
 permissions work
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-arm64-gcs-test-flags-v1-1-03cb9786c5cd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI2FAGcC/x3MQQqAIBBA0avErBswkaiuEi1ERxsoCycikO6et
 HyL/wsIZSaBqSmQ6WbhI1V0bQNutSkSsq8GrbTplDJo894bjE7wIrkwbDYKjoOy2vvgqQ9Q0zN
 T4Offzsv7fnaxSp5mAAAA
X-Change-ID: 20241004-arm64-gcs-test-flags-980a2ddfde6f
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=6690; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HBOHRdZdSmmXwU8CFIly7OLLMk7spi/PNBI76VLErPk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnAIWdv/CChHxHn5QIGOK1S134Lbs7Lxqjzll1OqhJ
 OGEUjVKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwCFnQAKCRAk1otyXVSH0I6jB/
 9wood//L/c65zbWvndPrfNjcy9wTgyN0CLm6KCupkxgjp/OkT5EayqmA39mycaaZcpdEh2iC4WuE8J
 YO0uleI8TV36qPJ6CzAokQzeVolVRGzRXKKnpAjPUnFRTQ+9J8WnYSMpIM3owTm9zwUE4ozsMmDeMv
 H0AQo3qsKh4ftKxxVvf3RDHjCogOpMa5/hThGCAocF+wWMNu+oSOGuDS3ZiMj3yLrx9LLQ1zhrAiLX
 3sDZpr9SXnmYYYVB4ym/4Guss+qust9SnENPVJeZVYPWoqOFDzkl9lUKzDm9MR7yaJEIFu2Fdy0Zzl
 YJgWs5hpEAYAdZSsKMezKUylvtdlPj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add trivial assembly programs which give themselves the appropriate
permissions and then execute GCSPUSHM and GCSSTR, they will report errors
by generating signals on the non-permitted instructions. Not using libc
minimises the interaction with any policy set for the system but we skip on
failure to get the permissions in case the system is locked down to make
them inaccessible.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/gcs/.gitignore |  2 +
 tools/testing/selftests/arm64/gcs/Makefile   |  8 ++-
 tools/testing/selftests/arm64/gcs/gcspushm.S | 96 +++++++++++++++++++++++++++
 tools/testing/selftests/arm64/gcs/gcsstr.S   | 99 ++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/gcs/.gitignore b/tools/testing/selftests/arm64/gcs/.gitignore
index 1e8d1f6b27f2b4c6f8ea26fc55094469c39616d5..bbb8e40a7e524630fadc4cffe0defff128033829 100644
--- a/tools/testing/selftests/arm64/gcs/.gitignore
+++ b/tools/testing/selftests/arm64/gcs/.gitignore
@@ -3,3 +3,5 @@ libc-gcs
 gcs-locking
 gcs-stress
 gcs-stress-thread
+gcspushm
+gcsstr
diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/selftests/arm64/gcs/Makefile
index d8b06ca51e22a99566f982f3aad3dceb30ffe05e..d2f3497a9103fc12ebc90c7f4e33ab9b846c6c8a 100644
--- a/tools/testing/selftests/arm64/gcs/Makefile
+++ b/tools/testing/selftests/arm64/gcs/Makefile
@@ -6,7 +6,7 @@
 # nolibc.
 #
 
-TEST_GEN_PROGS := basic-gcs libc-gcs gcs-locking gcs-stress
+TEST_GEN_PROGS := basic-gcs libc-gcs gcs-locking gcs-stress gcspushm gcsstr
 TEST_GEN_PROGS_EXTENDED := gcs-stress-thread
 
 LDLIBS+=-lpthread
@@ -22,3 +22,9 @@ $(OUTPUT)/basic-gcs: basic-gcs.c
 
 $(OUTPUT)/gcs-stress-thread: gcs-stress-thread.S
 	$(CC) -nostdlib $^ -o $@
+
+$(OUTPUT)/gcspushm: gcspushm.S
+	$(CC) -nostdlib $^ -o $@
+
+$(OUTPUT)/gcsstr: gcsstr.S
+	$(CC) -nostdlib $^ -o $@
diff --git a/tools/testing/selftests/arm64/gcs/gcspushm.S b/tools/testing/selftests/arm64/gcs/gcspushm.S
new file mode 100644
index 0000000000000000000000000000000000000000..bbe17c1325acc85d74dd3fe7cb586900226cde4c
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/gcspushm.S
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright 2024 Arm Limited
+//
+// Give ourselves GCS push permissions then use them
+
+#include <asm/unistd.h>
+
+/* Shadow Stack/Guarded Control Stack interface */
+#define PR_GET_SHADOW_STACK_STATUS	74
+#define PR_SET_SHADOW_STACK_STATUS      75
+#define PR_LOCK_SHADOW_STACK_STATUS     76
+
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE		(1UL << 1)
+# define PR_SHADOW_STACK_PUSH		(1UL << 2)
+
+#define KSFT_SKIP 4
+
+.macro function name
+	.macro endfunction
+		.type \name, @function
+		.purgem endfunction
+	.endm
+\name:
+.endm
+
+// Print a single character x0 to stdout
+// Clobbers x0-x2,x8
+function putc
+	str	x0, [sp, #-16]!
+
+	mov	x0, #1			// STDOUT_FILENO
+	mov	x1, sp
+	mov	x2, #1
+	mov	x8, #__NR_write
+	svc	#0
+
+	add	sp, sp, #16
+	ret
+endfunction
+.globl	putc
+
+// Print a NUL-terminated string starting at address x0 to stdout
+// Clobbers x0-x3,x8
+function puts
+	mov	x1, x0
+
+	mov	x2, #0
+0:	ldrb	w3, [x0], #1
+	cbz	w3, 1f
+	add	x2, x2, #1
+	b	0b
+
+1:	mov	w0, #1			// STDOUT_FILENO
+	mov	x8, #__NR_write
+	svc	#0
+
+	ret
+endfunction
+.globl	puts
+
+// Utility macro to print a literal string
+// Clobbers x0-x4,x8
+.macro puts string
+	.pushsection .rodata.str1.1, "aMS", @progbits, 1
+.L__puts_literal\@: .string "\string"
+	.popsection
+
+	ldr	x0, =.L__puts_literal\@
+	bl	puts
+.endm
+
+.globl _start
+function _start
+	// Run with GCS
+	mov	x0, PR_SET_SHADOW_STACK_STATUS
+	mov	x1, PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_PUSH
+	mov	x2, xzr
+	mov	x3, xzr
+	mov	x4, xzr
+	mov	x5, xzr
+	mov	x8, #__NR_prctl
+	svc	#0
+	cbz	x0, 1f
+	puts	"Failed to enable GCS with push permission\n"
+	mov	x0, #KSFT_SKIP
+	b	2f
+1:
+	sys	#3, c7, c7, #0, x0	// GCSPUSHM
+	sysl	x0, #3, c7, c7, #1	// GCSPOPM
+
+	mov	x0, #0
+2:
+	mov	x8, #__NR_exit
+	svc	#0
diff --git a/tools/testing/selftests/arm64/gcs/gcsstr.S b/tools/testing/selftests/arm64/gcs/gcsstr.S
new file mode 100644
index 0000000000000000000000000000000000000000..a42bba6e30b18147887bb13046c96bd48850de2e
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/gcsstr.S
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright 2024 Arm Limited
+//
+// Give ourselves GCS write permissions then use them
+
+#include <asm/unistd.h>
+
+/* Shadow Stack/Guarded Control Stack interface */
+#define PR_GET_SHADOW_STACK_STATUS	74
+#define PR_SET_SHADOW_STACK_STATUS      75
+#define PR_LOCK_SHADOW_STACK_STATUS     76
+
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE		(1UL << 1)
+# define PR_SHADOW_STACK_PUSH		(1UL << 2)
+
+#define	GCSPR_EL0 S3_3_C2_C5_1
+
+#define KSFT_SKIP 4
+
+.macro function name
+	.macro endfunction
+		.type \name, @function
+		.purgem endfunction
+	.endm
+\name:
+.endm
+
+// Print a single character x0 to stdout
+// Clobbers x0-x2,x8
+function putc
+	str	x0, [sp, #-16]!
+
+	mov	x0, #1			// STDOUT_FILENO
+	mov	x1, sp
+	mov	x2, #1
+	mov	x8, #__NR_write
+	svc	#0
+
+	add	sp, sp, #16
+	ret
+endfunction
+.globl	putc
+
+// Print a NUL-terminated string starting at address x0 to stdout
+// Clobbers x0-x3,x8
+function puts
+	mov	x1, x0
+
+	mov	x2, #0
+0:	ldrb	w3, [x0], #1
+	cbz	w3, 1f
+	add	x2, x2, #1
+	b	0b
+
+1:	mov	w0, #1			// STDOUT_FILENO
+	mov	x8, #__NR_write
+	svc	#0
+
+	ret
+endfunction
+.globl	puts
+
+// Utility macro to print a literal string
+// Clobbers x0-x4,x8
+.macro puts string
+	.pushsection .rodata.str1.1, "aMS", @progbits, 1
+.L__puts_literal\@: .string "\string"
+	.popsection
+
+	ldr	x0, =.L__puts_literal\@
+	bl	puts
+.endm
+
+.globl _start
+function _start
+	// Run with GCS
+	mov	x0, PR_SET_SHADOW_STACK_STATUS
+	mov	x1, PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE
+	mov	x2, xzr
+	mov	x3, xzr
+	mov	x4, xzr
+	mov	x5, xzr
+	mov	x8, #__NR_prctl
+	svc	#0
+	cbz	x0, 1f
+	puts	"Failed to enable GCS with write permission\n"
+	mov	x0, #KSFT_SKIP
+	b	2f
+1:
+	mrs	x0, GCSPR_EL0
+	sub	x0, x0, #8
+	.inst	0xd91f1c01	// GCSSTR x1, x0
+
+	mov	x0, #0
+2:
+	mov	x8, #__NR_exit
+	svc	#0

---
base-commit: bb9ae1a66c85eeb626864efd812c62026e126ec0
change-id: 20241004-arm64-gcs-test-flags-980a2ddfde6f

Best regards,
-- 
Mark Brown <broonie@kernel.org>


