Return-Path: <linux-kselftest+bounces-42824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931FBC149C
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 13:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3901A189FE07
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AAE2DECB0;
	Tue,  7 Oct 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZdfPHTh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE972DCF78
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838334; cv=none; b=esMa9iMu5Fa1GDdNQCPBncNmfwek6X85LKwj91tlalbl1VCyQASy3C7mTkl/4R1LRYpmB1tZnSCy9sl5/qCD0EIIHvG0pxWynmpCk1ld5m8nd/nTx9M+9oo+5F5yp4SyZLc3VAFgSAm2qmJvZaeDW/ARPlgMgQsECf4r1B18znY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838334; c=relaxed/simple;
	bh=aycT2YW8ngTHcamjRTws20c/psHw5lFicsYQqCpiH3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWPS1z4yeywt0yg9VOFMxPm3+6ZikmWzL0vf4bs7G7degkrcn2HJz9pIgZOUQCtAOBNnbVvGtw4sBl58vaxLU/xpv9TsqiOJQRuYB1+ahKQ2BcPoBOaskDpyiVu9Rhw2Ln0IZxugYpcKOEJZLGA+/NC6IARxGkR0ZgCfNyig8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZdfPHTh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-58afb2f42e3so7343938e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Oct 2025 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838331; x=1760443131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLmsg/56sZrz4BdDAhOz8lvZvUVWtSQgVDQGJvDc9c8=;
        b=TZdfPHThxVOMCc4fUJEPoMK97zP6CedDJFjpUZvgPyISZh8XMM78i8gxdVa9O1Bm8a
         Csl2KoCIl+kBuGTnvlhdS1x++d5Rk71qKg1Sxzcm5ptgqtvP1a/x/IV9hLfOTKwY6HkI
         shB2aNyprHUmvENH7RGSrNrMtBNuNyDwNm0YhP2jOPzhL/k7I94Ybpqz/mwNyCw63XFz
         CAkWFIhMajq2mk4ugUq7FO5QfNK88WPkTYkJNeTAOA1tlEi12/G+mjFn6fAAS6IAxqtN
         +DM7DuH+KzlCE8Xccg2Y8nxpLIJ5Fz+/0+6plbhZmeiNAeUYvo8Gj+xWFAyWYewib/J/
         TqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838331; x=1760443131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLmsg/56sZrz4BdDAhOz8lvZvUVWtSQgVDQGJvDc9c8=;
        b=u0ZTbZnOjxckN2CVttFdDfsylV1rZTXdlDaI+NbOZhIq3I5v2H9ujRswxqyOOM30l1
         pdTCrHINSerCyRG0BRav7xkLgKR51EHd3N6pZuY2nELmb6V8wQDM+isX4lf5VN7EdQrX
         sbjdZRWIighlE9fd76K4qlv4Bpu1jVW48zqTVhLkaefKDyylWw/T56on7V+MvCrNtw59
         EwrIlo7dHGrdxwGyO2xvh68giWZ7Yw247nC783VKUVr64Pzmbl3H5WzpU3mRs3xGlcsC
         u8FF+v0Sal1f4rkubevwUXsfpmOi5Pt1T+f9xnbSWmoGvA08nLaepdUVjNALQCOPljuu
         W7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWL1vRoyCWeHQCtwKRrwFecGKELpre1m8AQwYZe4zQMMhoRtyoLudlR4vJxCsWQ9+HFrNfDM9Zwjes6CrCUMr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Cm0vubeeRMPAExYxM1oWy02kEPu3hzf2a0E0mZU9QrZ0LYMk
	aNAFJ0met193XvFju9x4xtd9fh1fAKrmw4YrTNMCMkKK9cwYESQBiqOs
X-Gm-Gg: ASbGnctL8/lpEZ6vj6YqYlVJeubEBpZ6B45qSjTcN4PJiBEAI0ZV7D0iN2ranioAanE
	9vU1knBBWLXLaGQFoKv7GiEwdGn2JnVRHoPcY19vNbLhYgoCjzfTh6NSMPMELu3f/n8NzJ5OyYS
	xKCN9BQ4A6YH+IvN45MvSjLLaY94FM/0Ue1fs/SQSg2rTV3hwElIBtZre4ACpXWQufXzM5dXRQw
	f0BJ/V8ID0Yg0Lx5EMzlLQyqKgqTttRQ9Mxs87VhPntJvx6lMnCFYxDjUmjR1H6RmxFb3skF0o5
	Fkvi6m0hgS4Ma/hf3u/YWjCE5P7OFOa2iWBPv+gFCUCgZioB5dsA95UsXC6YecoERWn+uOiAgzR
	NToEhhXaUMSJkyoLltXvT5Ib9UIXf9Sgaae2SZQ==
X-Google-Smtp-Source: AGHT+IGfT8s7layBTVcGXA6YfBl09MAMt5tdhMpUSEGyHeuPqtgVVg9HtsIeoOOkz2owLe0BeMm1lQ==
X-Received: by 2002:a05:6512:3e27:b0:55f:6db5:748d with SMTP id 2adb3069b0e04-58cb956b71amr5116109e87.4.1759838330577;
        Tue, 07 Oct 2025 04:58:50 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b011a8941sm6043339e87.114.2025.10.07.04.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:58:49 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nam Cao <namcao@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 4/6] riscv: vector: allow to force vector context save
Date: Tue,  7 Oct 2025 14:58:20 +0300
Message-ID: <20251007115840.2320557-5-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007115840.2320557-1-geomatsi@gmail.com>
References: <20251007115840.2320557-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ptrace updates vector CSR registers for a traced process, the
changes may not be immediately visible to the next ptrace operations
due to vector context switch optimizations.

The function 'riscv_v_vstate_save' saves context only if mstatus.VS is
'dirty'. However mstatus.VS of the traced process context may remain
'clean' between two breakpoints, if no vector instructions were executed
between those two breakpoints. In this case the vector context will not
be saved at the second breakpoint. As a result, the second ptrace may
read stale vector CSR values.

Fix this by introducing a TIF flag that forces vector context save on
the next context switch, regardless of mstatus.VS state. Set this
flag on ptrace oprations that modify vector CSR registers.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/include/asm/thread_info.h | 2 ++
 arch/riscv/include/asm/vector.h      | 3 +++
 arch/riscv/kernel/process.c          | 2 ++
 arch/riscv/kernel/ptrace.c           | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 836d80dd2921..e05e9aa89c43 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -118,7 +118,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
 #define TIF_32BIT			16	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	17	/* restore Vector before returing to user */
+#define TIF_RISCV_V_FORCE_SAVE		13	/* force Vector context save */
 
 #define _TIF_RISCV_V_DEFER_RESTORE	BIT(TIF_RISCV_V_DEFER_RESTORE)
+#define _TIF_RISCV_V_FORCE_SAVE		BIT(TIF_RISCV_V_FORCE_SAVE)
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index b61786d43c20..d3770e13da93 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -370,6 +370,9 @@ static inline void __switch_to_vector(struct task_struct *prev,
 {
 	struct pt_regs *regs;
 
+	if (test_and_clear_tsk_thread_flag(prev, TIF_RISCV_V_FORCE_SAVE))
+		__riscv_v_vstate_dirty(task_pt_regs(prev));
+
 	if (riscv_preempt_v_started(prev)) {
 		if (riscv_v_is_on()) {
 			WARN_ON(prev->thread.riscv_v_flags & RISCV_V_CTX_DEPTH_MASK);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 31a392993cb4..47959c55cefb 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -183,6 +183,7 @@ void flush_thread(void)
 	kfree(current->thread.vstate.datap);
 	memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
 	clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
+	clear_tsk_thread_flag(current, TIF_RISCV_V_FORCE_SAVE);
 #endif
 #ifdef CONFIG_RISCV_ISA_SUPM
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
@@ -205,6 +206,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	memset(&dst->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
 	memset(&dst->thread.kernel_vstate, 0, sizeof(struct __riscv_v_ext_state));
 	clear_tsk_thread_flag(dst, TIF_RISCV_V_DEFER_RESTORE);
+	clear_tsk_thread_flag(dst, TIF_RISCV_V_FORCE_SAVE);
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 906cf1197edc..569f756bef23 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -148,6 +148,11 @@ static int riscv_vr_set(struct task_struct *target,
 	if (vstate->vlenb != ptrace_vstate.vlenb)
 		return -EINVAL;
 
+	if (vstate->vtype != ptrace_vstate.vtype ||
+	    vstate->vcsr != ptrace_vstate.vcsr ||
+	    vstate->vl != ptrace_vstate.vl)
+		set_tsk_thread_flag(target, TIF_RISCV_V_FORCE_SAVE);
+
 	vstate->vstart = ptrace_vstate.vstart;
 	vstate->vl = ptrace_vstate.vl;
 	vstate->vtype = ptrace_vstate.vtype;
-- 
2.51.0


