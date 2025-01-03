Return-Path: <linux-kselftest+bounces-23844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F08A0035F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 05:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7550A1883BB9
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 04:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E14514D444;
	Fri,  3 Jan 2025 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ4JyHvt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6433DF;
	Fri,  3 Jan 2025 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735877038; cv=none; b=fAEuXH0n+le/Rxtqvg9mzOnFoj/1nHLUDIcHfFUTnh525tYaB6CP6dD8Mfqr6iaWw7BXrz8unDF4fP4IW2E7e0EbudLT+ejisleO6O3/jNAJGFCClBEi/FtlAUEsJ+ZiiflTtG2JacFnAkL3Z4D86C+1oiWvkjd1fKVfKe1AzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735877038; c=relaxed/simple;
	bh=7x/PwdmTzGkIDVYD3WqJDRsi7f1m4FX68oZe1VEab30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YsisGPC6BdeBGHNdC/tt2VldnH4wIKF+Wq5K0T08rng9rbjDg4G4bHCRRUxaXWga3OloWeiOuJ+ZC4F1vn+IN+v1ijxdwG52pOiIy594zVFlNnctsMorvPlVnJK4np1OCmr0Rca7+8XQVnbuuJUvKVmwZBeDhKve0Mvqk9pWkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ4JyHvt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43618283dedso118409755e9.3;
        Thu, 02 Jan 2025 20:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735877033; x=1736481833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJuGqMO/jQ4z+TowIOoPl2aMlmVXNRNIGfU0gnbDMo4=;
        b=WQ4JyHvt/0oeI5DN2IoKJwinsdHf4OjbVAjuwLS0lNVupnuDGtH9JTcbrhlAB+9ooa
         lwh+9JbSHYWgVBbOTqDQlT2COWslLrndjkcIfaIL8aSxPFHzLmdG7ezofqw8A3T0yaYX
         JNfec4q+d+lo0DrCIue63ZslWfO4rA/MivQgHRrTLc1GVPbU2TYMEfKLllHZvf/hZAIE
         HsfTZcsmOo4rSODJDlayuov40PhubDWmHSwH9yy8p49htjUYRD+D0QY3D4xnwBq2z5zu
         2dzEice8iMBWYBCQ1l6vMcDq1NkpknRVaZ4G1NBjVSLaCK59YsLQqN4gdMOxswonZ7+/
         oWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735877033; x=1736481833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJuGqMO/jQ4z+TowIOoPl2aMlmVXNRNIGfU0gnbDMo4=;
        b=aEH+D+CR08jX1HpGxsYDYPhdjPqpF3NgUDWdNU5r56s3e9HAh1nCPOIo/wJCTOrdC/
         KZmLIeGyLG4+PIXxmKzXzcRGGOrps1IrnzSORcrEXQ1mSYzhTfYh0GvwP08m3dc0weF+
         BBVsgoDWy0LhRg5su8guswcYiadbNvzp3P1JoRT2jVACxqYN8janehDaeauhR/5cN75x
         L6dZMJ5ZyYAlKjt+YoQ+QZqeme+UOFSK2a/MgBDKSt1oavBrw8WE0ujWzdqpPvsQ4l/c
         bExwT3qWSEsq+djM8ED4OetTXPCYKeoXzPb9FJRJHlMe+xGtd08bQI8MAZ2v2JL40bUX
         D/Og==
X-Forwarded-Encrypted: i=1; AJvYcCVqSBqkZFaKYA8OBbt1pSS1nbNkJtqKnpGYstqohq2r5zvliNeyHH6TXmf/99oC4t8/+Ya8jnnVqHkEohje1K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjswjdTeSzC8tdAAlzqrKG5LZen5oU6w0La5wcMlMlhVkkdSk8
	3f5uUPpm7m/Nww/hUGqRaNI8Sy2cTgdzZ29op37JJQMj8CfMkNU2kYv5XLWk
X-Gm-Gg: ASbGncskFjuY5Gg8633vs5huqn3WfIpmJl8TVjQNL+q0y056QzfM7WB0LiObY1LJ4yH
	b7yInRX++1HfAa5ppR/q6fJJhqPc700PrE1Pd9jLiAlvnZVgvFShfY2RxIdUE8P3mpIWtwO3pxQ
	Cl3ftsQfSi0dA6kcbDDMNU1vh+8/6/NlIcL1lGTC4BHMQ28LCBX61Ai3TfeFu9lYBkhQVdCAt+w
	XLSb8RHE1QXO7a/sOx65RSPQGT401PRGCDFglweJNBfwXawmubWQcZl9w/gX++DtXef8vPJ2w9h
	jZn4UKNqB6ZdOxP+pXeg
X-Google-Smtp-Source: AGHT+IFz1LXuucqG5XV4LRRH13gBdh5dZWFfNIE1AWBUxiyuEmTm3SbKU5ReRbu84ZTQzvFYvORA9w==
X-Received: by 2002:a05:600c:470b:b0:434:a75b:5f59 with SMTP id 5b1f17b1804b1-43668547127mr431260385e9.3.1735877032812;
        Thu, 02 Jan 2025 20:03:52 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661289995sm468388165e9.36.2025.01.02.20.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 20:03:51 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] rseq/selftests: Fix riscv rseq_offset_deref_addv inline asm
Date: Fri,  3 Jan 2025 04:03:26 +0000
Message-ID: <20250103040326.2603734-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working on OpenRISC support for restartable sequences I noticed
and fixed these two issues with the riscv support bits.

 1 The 'inc' argument to RSEQ_ASM_OP_R_DEREF_ADDV was being implicitly
   passed to the macro.  Fix this by adding 'inc' to the list of macro
   arguments.
 2 The inline asm input constraints for 'inc' and 'off' use "er",  The
   riscv gcc port does not have an "e" constraint, this looks to be
   copied from the x86 port.  Fix this by just using an "r" constraint.

I have compile tested this only for riscv.  However, the same fixes I
use in the OpenRISC rseq selftests and everything passes with no issues.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 tools/testing/selftests/rseq/rseq-riscv-bits.h | 6 +++---
 tools/testing/selftests/rseq/rseq-riscv.h      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-riscv-bits.h b/tools/testing/selftests/rseq/rseq-riscv-bits.h
index de31a0143139..f02f411d550d 100644
--- a/tools/testing/selftests/rseq/rseq-riscv-bits.h
+++ b/tools/testing/selftests/rseq/rseq-riscv-bits.h
@@ -243,7 +243,7 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
 #ifdef RSEQ_COMPARE_TWICE
 				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
 #endif
-				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, 3)
+				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, 3)
 				  RSEQ_INJECT_ASM(4)
 				  RSEQ_ASM_DEFINE_ABORT(4, abort)
 				  : /* gcc asm goto does not allow outputs */
@@ -251,8 +251,8 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
 				    [current_cpu_id]		"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
 				    [rseq_cs]			"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 				    [ptr]			"r" (ptr),
-				    [off]			"er" (off),
-				    [inc]			"er" (inc)
+				    [off]			"r" (off),
+				    [inc]			"r" (inc)
 				    RSEQ_INJECT_INPUT
 				  : "memory", RSEQ_ASM_TMP_REG_1
 				    RSEQ_INJECT_CLOBBER
diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index 37e598d0a365..67d544aaa9a3 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -158,7 +158,7 @@ do {									\
 	"bnez	" RSEQ_ASM_TMP_REG_1 ", 222b\n"				\
 	"333:\n"
 
-#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, post_commit_label)		\
+#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, post_commit_label)	\
 	"mv	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(ptr) "]\n"	\
 	RSEQ_ASM_OP_R_ADD(off)						\
 	REG_L	  RSEQ_ASM_TMP_REG_1 ", 0(" RSEQ_ASM_TMP_REG_1 ")\n"	\
-- 
2.47.0


