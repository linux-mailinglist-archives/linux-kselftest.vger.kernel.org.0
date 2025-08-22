Return-Path: <linux-kselftest+bounces-39711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8CEB321C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4D0A25E01
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61D729BD94;
	Fri, 22 Aug 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="FKwmNFPW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DF29B78F
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884856; cv=none; b=FAFbfEJ5FFdAG2QA6cSeZ/Yz3pZz7ULBMVoDWDKEOwgUYBGVrGF92wS83Q1pXs48nr+DbQ4egryxX0kJVglseyMtqEoIb5X/IO4QoWXCDNMdWRcB7VEJG5Tp9nhKfWFHG0ZhN+siRozB8PmIMtUj+Eem9GuKThfBE0tYQ1z2+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884856; c=relaxed/simple;
	bh=OYjInNuDIbxgUr95L691pkXfEg25gucGlrQ1kVE7uI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka1H856r6cxlK3b0f8CAvcz57H9TOBv2YtGRW6x25CUp/taUtWRk10inklNvtfee6U1sSVPxfzBHmd+CSb3+tlE4OvKcfEDpcJF8DoLRJv4f8x6EduS1yoPD9k/xFiIIpDrffxwUTmYQbx+Ja0xoTB0q4SWFJCCDoA5qPpTnG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=FKwmNFPW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b10993301fso24046941cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755884854; x=1756489654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/NZ3invqjYii7VgIefIBIrdQlA4A/NoIleSlxqcTKI=;
        b=FKwmNFPWHkVyr6Rcfqh0/BrPDjqVgnkZLZ9zud1CQHmIgjmvsGDP7tr7gzM9qM7EDe
         N1NiWwc1pRReDCQNZCUWYiYvVONU2FChaPjTyYgmFLbF5HvWEpVEgeVESpz8BjMB8QDW
         6uehox7PaQn1oLYWxrcThNp24bKU1shtRbLExtWMr83BMHY7YA3Qy59ZdsJcAlU+I+T7
         x3T85Nf97UMzcgBrBl6Z63PRar0rHEbBk9UGH5dIjqlCs8YuEpopAk2i/cBC9PjC+U4z
         /tJYngVx10Vb6JRPHPhdWWUVXd6674/6L9M+YZHWOO2DSWa4DLGG6SNUCFc9ymIw2ZkZ
         xDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884854; x=1756489654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/NZ3invqjYii7VgIefIBIrdQlA4A/NoIleSlxqcTKI=;
        b=wZcsoGHZRX5243n1XIP4kdm4by6PRFcXxsVcYQd6JTQwqJxUkXrKOLjatIq2OdRtsN
         ykX78RCkvYg2D7A0/vM0jC7KMXG0utumIVgACziJe+bk+Nz8xKvTQ48VvZtCJ4Hc1ve/
         SUzto7tBINoY5e1cLZL+2CzzonOzxmpWSJ0ZIMWUH1aXviBzhvnlqsl92oV/kygblmDb
         bzUfAEQiSOFOXEctnVDESU+CFTKw2ME0Gqyd6PR/9wahV5Vzu+vH4xZh35s1VKkxrHbD
         Urlc5PLECBiXO06OWXG43E7PLLhJPwAcw/ZqUfDrtzOXa4Z1SCfJkRrLrQtDIw1v76E/
         fAqg==
X-Forwarded-Encrypted: i=1; AJvYcCXg0mCiRIvXR5IeODVRqDyFbxx4A1ZrtGjRwpWpo7ALG6OFNuNqJW6ZjYWYhbo5jL+c9si6pvqBIw4+E+lhaYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqzA0bf6OQS9ZegaUmZWVd+8PVGV9C6iOY95+r0R9RvazHokA9
	fiRS+NcrOg5fbcfjGkmXExtcdJN4BvKHPWBkAKlopVf37xV+7Brxfo+s4idjqLV2ltE=
X-Gm-Gg: ASbGnct8fgahjaDzXqfp3wnfMzNoE254mAyTq4/GJMh7ZJ0dr1wKndrcOGlAiLetyeu
	8IMq/9RXVLYRg+R0feGyM8MtQrYsqGS4yQ020B1DwMLuoEhe4+xLUd4R/rQ2F83iaNPlieKyMyY
	XAGWskbPoDbSEdXJ0RTym8WPIMbsMDJIbajQAfJP7co7QbquWB2LudvjjHCudxFoZqyXhXWnkpn
	MP9XTqPst8PjNZBEjvVSguErHxBeozdZvKiHQMsc6hBV/PipaA+rKZFJ7ZwPPtlCfbNMyg2iTcQ
	a1rvPiQf7m9rIXY0YbsYt/x6bsCOiwmqmCcF0lAELRPkj688LwJK0c3WO09/jnyhZjlNsXfesTh
	9ghoqe89nUvXlaGc1fd7q5ZukHWusy3XSgOuuu5Ohd3tAZDW/uBbbh5NDLj0C040VtpNkro8P/H
	fQmksEAg==
X-Google-Smtp-Source: AGHT+IFZbeEwjqDea0hlGgRVd9Xscw2cIAz+36MfAAXzcnD0U+Bx3mxtHkRwJItm6g9vdsmkz7a3oQ==
X-Received: by 2002:a05:622a:50c:b0:4b2:8ac4:ef7c with SMTP id d75a77b69052e-4b2aab4abe8mr43670911cf.75.1755884853830;
        Fri, 22 Aug 2025 10:47:33 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e6023asm3121361cf.53.2025.08.22.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:47:33 -0700 (PDT)
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
	"Liang Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>,
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 7/8] riscv: ptrace: Add hw breakpoint regset
Date: Fri, 22 Aug 2025 10:47:14 -0700
Message-ID: <20250822174715.1269138-8-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822174715.1269138-1-jesse@rivosinc.com>
References: <20250822174715.1269138-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to setup hw breakpoints using REGSET use the
__riscv_hwdebug_state structure to configure breakpoints.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
RFC -> V1:
 - New commit
V1 -> V2:
 - No change
---
 arch/riscv/kernel/ptrace.c     | 59 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h       |  2 ++
 tools/include/uapi/linux/elf.h |  1 +
 3 files changed, 62 insertions(+)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index e097e6a61910..fbd0097ec168 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -33,6 +33,9 @@ enum riscv_regset {
 #ifdef CONFIG_RISCV_ISA_SUPM
 	REGSET_TAGGED_ADDR_CTRL,
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	REGSET_HW_BREAK
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -280,7 +283,53 @@ static long ptrace_sethbpregs(struct task_struct *child, unsigned long idx,
 		return -EFAULT;
 
 	return ptrace_hbp_set(child, idx, &state);
+}
 
+static int hw_break_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	struct __riscv_hwdebug_state state;
+	int ret, idx, offset, limit;
+
+	idx = offset = 0;
+	limit = regset->n * regset->size;
+	while (count && offset < limit) {
+		if (count < sizeof(state))
+			return -EINVAL;
+
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &state,
+					 offset, offset + sizeof(state));
+		if (ret)
+			return ret;
+		ret = ptrace_hbp_set(target, idx, &state);
+		if (ret)
+			return ret;
+		offset += sizeof(state);
+		idx++;
+	}
+
+	return 0;
+}
+
+static int hw_break_get(struct task_struct *target,
+			const struct user_regset *regset,
+			struct membuf to)
+{
+	int ret, idx = 0;
+	struct __riscv_hwdebug_state state;
+
+	while (to.left) {
+		ret = ptrace_hbp_get(target, idx, &state);
+		if (ret)
+			return ret;
+
+		membuf_write(&to, &state, sizeof(state));
+		idx++;
+	}
+
+	return 0;
 }
 #endif
 
@@ -324,6 +373,16 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = tagged_addr_ctrl_set,
 	},
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	[REGSET_HW_BREAK] = {
+		.core_note_type = NT_RISCV_HW_BREAK,
+		.n = sizeof(struct __riscv_hwdebug_state) / sizeof(unsigned long),
+		.size = sizeof(unsigned long),
+		.align = sizeof(unsigned long),
+		.regset_get = hw_break_get,
+		.set = hw_break_set,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 819ded2d39de..7a32073e0d68 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -545,6 +545,8 @@ typedef struct elf64_shdr {
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
 #define NN_RISCV_TAGGED_ADDR_CTRL "LINUX"
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NN_RISCV_HW_BREAK	"LINUX"
+#define NT_RISCV_HW_BREAK	0x903	/* RISC-V hardware breakpoint registers */
 #define NN_LOONGARCH_CPUCFG	"LINUX"
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NN_LOONGARCH_CSR	"LINUX"
diff --git a/tools/include/uapi/linux/elf.h b/tools/include/uapi/linux/elf.h
index 5834b83d7f9a..b5f35df1de7a 100644
--- a/tools/include/uapi/linux/elf.h
+++ b/tools/include/uapi/linux/elf.h
@@ -460,6 +460,7 @@ typedef struct elf64_shdr {
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NT_RISCV_HW_BREAK	0x903	/* RISC-V hardware breakpoint registers */
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
-- 
2.43.0


