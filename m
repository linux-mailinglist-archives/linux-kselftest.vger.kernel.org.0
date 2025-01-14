Return-Path: <linux-kselftest+bounces-24466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95FA10D05
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F32257A4886
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6B1C2335;
	Tue, 14 Jan 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjTMEjGR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64961CC177;
	Tue, 14 Jan 2025 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874466; cv=none; b=ZOCjwpHmD0QNLaFl6VywvIK1OgD8EzuMcISHBAUXVL4guAZRnj5ZJDXump2usqM55B4BtY9eA+xiDctpf/fQE7EVc8bP+cs0QPtyAlEcdgnUPTFhjlC18X5FDIEtCL2CtNvIxEaFUYoR1XbgmNNYshdvpFpMiZB1pp0TVJxW/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874466; c=relaxed/simple;
	bh=/GM9DLsnaB6RlzHYbQdpBnzy/tTF2IrANIU8xY9/OEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5tBDaJgjp1cEjPvhhOyqq+rAmQKrZqaKN/Och8ny9h+dxcl1yGnwpuvlxhhEhNBp9bdRA9ZVaD8fucBHk+Aj57vn1+imi2wWhoxJv7Hp1wNXHTkHy+sdQToiDR12dl84hUvIN2UC7qD76HYAo13Cgik99BkcqtPzGCSO4hmPYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjTMEjGR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so41460225e9.1;
        Tue, 14 Jan 2025 09:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736874463; x=1737479263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gk8fgvjSMDx78y5lzfUT57Xiup2COiIkL+Pp/tlBbk0=;
        b=YjTMEjGRUrH4xnoCkr2gxHq0Um3OEcWZBJ49t8SAeiNWn6OLrK2dq52oqsk+m2b1mY
         IuNNhYLA6nplVvuFuKS5CUcWvjTMA86ItXNJjeWmrSrScnsdLN+IiYa8udMCUYI9r3xx
         a2JbZhWdgYVpOc7Qn7cT5VxL4Hyl4jOKVPgoA3XYQZMJaYcx1KkpC8j46JI5B/NUx74R
         0B1Y8CYG2c2FzZzBKywTJPpgaZuKL1F9X0Klkw7tbEcrfjuQL6Q9qixoYsgS7b5hzUYJ
         GFujdhtMN8CvKmwNbjEOFpdZoH27XFBvLq5e6or1TGtssanDplQ3TKGtE2sf8mAAHwTy
         b8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736874463; x=1737479263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gk8fgvjSMDx78y5lzfUT57Xiup2COiIkL+Pp/tlBbk0=;
        b=Znos8NR9wB6+IObFvAFl6AV3wVoxfw0vkpJ2dI4I+HZ800VzT7aVbSRTk2VhuT1usk
         m62bUpV5Fs4jYz+KVcKgwuj6uwFhmIMesK7cEDpagHahIvI2Vv6V9Z3UW8qgAxlMN7+Y
         n9Xmd4lNUiECTWFkYPriI3/MQ8x66CDk8g67qx7dHICO4k+wS+jMPAGxSRZeF8LaC0Sb
         jdFGChbrucJdpKXVyGb38TB97ijN8xaSy+oOXyiq0WffFxy/K1+tgy25G2FMgkkqJ4O4
         GQn9OBQnHPt0OBEUj/lOIS2y/QyxvABS65D51RVA0njs7cGiWHEqGL8By5KvtE1w8Og4
         dsKg==
X-Forwarded-Encrypted: i=1; AJvYcCWcbqENIuOKCRGmMWovxluI7GD5IcS8QE8UhTG3oIBcNF3d4VvXJZ/bKNHgQOrXkMvMG1r1pGcYHl04dpsbmpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0bPSVLuW/1SJGrtLutmKihbPp5KlRoYr8vW4m3ppBVWSyLKY
	ALbPnlulPTMiSfkVW/+ZgMu1EgBjsx7oxN18Wcldbmj6tLcJ0sXtFUO9dPCy1A4=
X-Gm-Gg: ASbGncv90j5aYQkPcR5b7hToH6pEFf9IJQ18N5l8wy86HLw2hFPluF56FD0vkMyMfKr
	7DST7bg6mKfZtADj7R0TQxLT+L/yvtGWbmMDOdv0Cdmjzj2E2DMnth55RDz3o75nTriW3kO5rpz
	eW84yl7mekl425OPv+ntQZOopef9eEnKaz2YVP8mFpDkjm1jASA6dOUkmnzBq94QjJc4Sa5N78b
	TPVt1bnH0384Ta7jRHSCMuUWwddKVydSF957sKV33mSduDSAYoxU7WIzSY4fiuy64017Q68cpnO
	SDgxyKncANfu/FUiixHO
X-Google-Smtp-Source: AGHT+IEUVNz4y01NUhG2yQ5lT5waJ8ea0XrlPzAEPVA6OkzCMOyeaUi83xVYUjfcZkDmF2IwproYcQ==
X-Received: by 2002:a05:6000:2cf:b0:385:e961:6589 with SMTP id ffacd0b85a97d-38a87303d73mr20840214f8f.20.1736874462459;
        Tue, 14 Jan 2025 09:07:42 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c6a2sm15450507f8f.54.2025.01.14.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:07:41 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2] rseq/selftests: Fix riscv rseq_offset_deref_addv inline asm
Date: Tue, 14 Jan 2025 17:07:21 +0000
Message-ID: <20250114170721.3613280-1-shorne@gmail.com>
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

Fixes: 171586a6ab66 ("selftests/rseq: riscv: Template memory ordering and percpu access mode")
Signed-off-by: Stafford Horne <shorne@gmail.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
Since v1:
 - Added Fixes, Tested-by, Reviewed-by etc.

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


