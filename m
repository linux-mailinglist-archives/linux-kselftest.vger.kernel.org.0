Return-Path: <linux-kselftest+bounces-38320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B452BB1BB0A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D937F624B4C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076FC293C45;
	Tue,  5 Aug 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="WcrIQikb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4AB270551
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422807; cv=none; b=q5vZYWYNaZhQO5sdKzfOYZmOMkGp6I7UnoDpRQycF9BI5X+W6/0kLbDCI/WOBX18oS2pyAz/uhXvybkGWxOa3UHbbX1R2ziYXqaIawQCYJaaYMUlDcv6cj6Ftzw8RuFzsm7rvta8rd+iVMg9ZgBdkpTzKfnIMnuA7ocNCsAmWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422807; c=relaxed/simple;
	bh=Mw1HF+WYqrZH50B60QETN97Z6Qf9c2O3cgvwGI4nSFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPKcqja5eZhNypHJbNM/K//f6o/mQbnJgZ0/3t+OyIlOCx/A9IETrUFSbvzmCsyrO0bxa7PwT72cZO/g+v+1xgrzaCUh+Pd/J5/ceTZTmxiuqo96uiSQPPU5wqSjVLc4QTMDYtpCC24twnYE3GQ3ffBdsZ1sCMtU6iyutPzhxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=WcrIQikb; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e2c1dc6567so299417185a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754422805; x=1755027605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMI5Xwq0SqGXnmGRw5QTZMv+U2y6SNaFWej8c2zdngA=;
        b=WcrIQikb0VFMCoabuN1q9WZT2QVr9aFu9ytV5kdo8aLXFxoGSoJjFuEyYWaR9xt3NB
         ATrDEOAqwAaPCdLac/salE7Fmq73mMHJbpjHOaOL07Es7c9cVWGiWm+WZRvmbf7elDzF
         BA8E7SOpTN58Qnpph6STZtRFPR64WNZxS/GsU8nuGdUuWDEm4HD1pbYlI+TjbwRY265F
         CHO1yCnCbD2Eb/baWc/w2RTX5bElFPucouOGBDlyyFilTH14BdYJHZagOFWpmeX3QhOU
         nEBkxH+SdVdvPEMxBXfiodL5gB8fR4voQmEzr92H6FjisvLdpvZ44cDSvfjztiP15wR9
         /fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422805; x=1755027605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMI5Xwq0SqGXnmGRw5QTZMv+U2y6SNaFWej8c2zdngA=;
        b=v9azYf5JfPDqpG6zqD3C/gQk1ucmGW7klLnYqLilMcO84b5skUYQpLE9js7jMpwyeV
         nn4JrdsRqEn85rkAUQTEK2k/U7LAFoycwVyypubpSjNSYdO+Hov4LeBZ5ccQGm3Moq2a
         441nBepB6oat6NCmQ1NH1Egr5qnw4oiIXDFXvtKoPV9AkXJ1vMq1Pvtp1l+VEgl8L08m
         ndz+hFdJH/hFp4bt8eBGlaCTpIw6/f4xhAxTl5FRnLnp1lb8NK+loC99MH/6hLLZvoX6
         1GYwiH+5NTOmFsTFJcFpzeyeGXIfRHjF8EDQ/aE3wzfswRaeJJsm95WY2KoQ1YmXUxSu
         7Grg==
X-Forwarded-Encrypted: i=1; AJvYcCXLm/H4skSjwiaJJ1rsotM+V4e1F0st1rLRGfxdE+L9MRi+8AVQU8C9giCL8Nv/9o/PY2Hn+cbu+YBSOifazeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJSWKvTJ5et4qIod52G1pK3SGAz5DSVFx1ClAe3koGxkNE/0Ss
	xQoi1pNk1oR+/897jqvoq3IL1pOrz2ZII+KAigzn8+e2qu4XEYWAPDrlTUDQ3OaXvgw=
X-Gm-Gg: ASbGnctjY2i7NEqtfOsxNp4gcXrUunfcR4a9XBX1AjBMpPcrafEsCpC037MPeKr0zM5
	WwnwIMo1g3DqMewn3GCL+J+u6P7Ws1GCpY22igFukGSMrpPQx/FBwpN2PNKDSeUMredmMxVoAZj
	bZwLeyaLt3d2wWl2aRz/+865q+JKnNVLNwW3zYgxiPQNGi0UBqcyh83LDcRVCA5v1yrF0dDqAW8
	ptBBSq9r35eJu56Jq3L1OaOKaiIDGusII1ZA3zbz27vUkvRE2lRyQ0uAyvaKuRPwTWpnzTdLej+
	pXjUHs0AdS3nlWGRjzBFRoINExF+J7e7lLhd/eSc0nrwcvSN+7cgQ6yUARt/43qx+vbP0yYkrAI
	2cPIdtmCkbFx6ElGNTFu4lRcE2rYkUMCazJsXRMCB95qf7FJAAQ3aSV4bbDdZxTghi2011qRLfC
	V//+vJxw==
X-Google-Smtp-Source: AGHT+IGslZriZ3OsEZBWmVfkk5oCBsMISvqP0jsnyJuJf09cg7efSarv3MBZUu5//ACqxd//7g3UxQ==
X-Received: by 2002:a05:620a:430a:b0:7e8:2e5:feb3 with SMTP id af79cd13be357-7e814cf9504mr90508985a.1.1754422804849;
        Tue, 05 Aug 2025 12:40:04 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm717855685a.54.2025.08.05.12.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:40:04 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley  <conor.dooley@microchip.com>,
	Deepak Gupta  <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/8] riscv: insn: Add get_insn_nofault
Date: Tue,  5 Aug 2025 12:39:50 -0700
Message-ID: <20250805193955.798277-4-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805193955.798277-1-jesse@rivosinc.com>
References: <20250805193955.798277-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_insn_nofault uses get_insn with pagefaults dissabled, allowing it to
be called in an atomic context.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
Unsure if copy_from_kernel_nofault is an acceptable replacement for
direct dereference in __read_insn.

RFC -> V1:
 - Add new function instead of using copy_from_user_nofault
---
 arch/riscv/include/asm/insn.h |  1 +
 arch/riscv/kernel/insn.c      | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index ba74e5b8262c..f87e0a48f786 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -553,6 +553,7 @@ static inline void riscv_insn_insert_utype_itype_imm(u32 *utype_insn, u32 *itype
 #include <asm/ptrace.h>
 
 int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn);
+int get_insn_nofault(struct pt_regs *regs, ulong epc, ulong *r_insn);
 unsigned long get_step_address(struct pt_regs *regs, u32 code);
 
 #endif /* _ASM_RISCV_INSN_H */
diff --git a/arch/riscv/kernel/insn.c b/arch/riscv/kernel/insn.c
index dd2a6ef9fd25..c8f77c0093c9 100644
--- a/arch/riscv/kernel/insn.c
+++ b/arch/riscv/kernel/insn.c
@@ -2,6 +2,9 @@
 /*
  * Copyright 2025 Rivos, Inc
  */
+
+#include <linux/uaccess.h>
+
 #include <asm/insn.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -74,6 +77,17 @@ int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
 	}
 }
 
+int get_insn_nofault(struct pt_regs *regs, ulong epc, ulong *r_insn)
+{
+	int ret;
+
+	pagefault_disable();
+	ret = get_insn(regs, epc, r_insn);
+	pagefault_enable();
+
+	return ret;
+}
+
 /* Calculate the new address for after a step */
 unsigned long get_step_address(struct pt_regs *regs, u32 code)
 {
-- 
2.43.0


