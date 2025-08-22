Return-Path: <linux-kselftest+bounces-39707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 876EAB321B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1001D63801
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECA1298CBE;
	Fri, 22 Aug 2025 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="OfCFDmNN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57742980A8
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884848; cv=none; b=FqPDUpIudTKXjGEiFUA6LOj4vh7577vE5TLF4QS+Kkf4ETtbHzxjQ+8qcpJHh04yWMfOBVpAecnut2mEr9aX4u1sT4P4HHqAO6lBLJoD2ylLRrxQDYcTXI3xtKI/+hatV10BRGOf/SaYXTOH5qEyEQWkQdUQmBP+8JyOFLJ0knk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884848; c=relaxed/simple;
	bh=0b+k1Da34Ie81q2wS6yZp0j3E9D5ClJNu8JRMBnHi+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+9wqLb7y6iKouw7+uaoinNAgCliaxrC3KPy+bu1Fkfpa2DJoL9jTuHimtIPZV5bwe9M63WiHiccG94ZX9ot9i+lAvyOxKYm+Dt9qIlG5ZthA2pmd2Gju1mo2IPe8C/BtqW9Z4QUH5e+6rtFTaoAbo+M8Lcyd1uqzjqgjq0lz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=OfCFDmNN; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b10993301fso24045301cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755884845; x=1756489645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7icmFEtMbjG8nHUlUz3H6xEpzLvZfrYx0hP4AUrTZT0=;
        b=OfCFDmNNY64q0WQPlHvyCU01UrN1O7uFPdUYZGLx0gq160X8cjbGA6BXYsice8kGT9
         wuEOwiNl1w4Q+dE9CWSycC0eoFwKKguwPhKYsaJC2RKC8cm8sZqUGYtzUfuUYOvHVHxJ
         /Dd3snX4ScJbxhSb04vqSOj3UqLNR3fv0qLyynTX5fHvRf3qNAImmbMam6aQDtS0RrOc
         JI1bMoTYU8PPxCOIs+6Mwkmmvmq0Ezdc83d/grP5F59lZXe1lKB3Fv0vaA41zvrdUx30
         HboVj4nKplV2V9fWIMWA5HuGJ9pF+zZQJMFzijMWMKehgpxhX870AQ5eC7sgg6FSmq7P
         40eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884845; x=1756489645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7icmFEtMbjG8nHUlUz3H6xEpzLvZfrYx0hP4AUrTZT0=;
        b=pLO1iW8rKh41qKKcHvl5GOMuKXnP9kMY9BEKN129gMUQAD6OI4HLZom9nuMjjGFcrY
         RU39Js9fo6db0h8zSenMe3eBnGH+ardjC7eE0tF/2qXDiKdnYoDgmR0AHol642++YtL6
         +nLmjJve+s2L+AGY0KJWSgr/dsHxdEISHj5SF2fjBfiLsstF/YNG3lPHXw7a4zUdGQTD
         urwRNg6QD3fJXNacU8MJ7DVDfsQdGygR3QVmRtz+zxW8EfkNcjQYby41kW5glKbd6ev/
         Eh+pqoEVWObYfeLa3eihKPpaM82z77ErZqF1MKqgv5GXtdMNXEMV0TcYkQ/fVZb8Jvnm
         BXIg==
X-Forwarded-Encrypted: i=1; AJvYcCXoWOr50C//db8osjdqhnDCUAxL8zPOudFrb58KYWU3i5wD+935jBgRLs/Q2WfbIkL/jD7ODrROhWY0gNWYTTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiL0N1n+7HyGfQ67SS1Shwe/v2jeUKUD3zGw7lhaTe1zmbcuii
	iC9BCmR6y9Hg87fPswKr5c1T/auc+Eco/Emy+ue8TnUgoH+2SOirBUamUxShd+V29+Y=
X-Gm-Gg: ASbGncv6xuYvbBKl2fFc0QzLHK6yJgiOxb4uaSvCEGKFM6baTy2eFVVzTHj+I6zgvvW
	CQdPE8ZD8OeW+r1oAv4iZ7ON70sJi7oT5BoFo7BM3w0GOlG6sMwcI56JVr7yBV+5APzRP4wyqjg
	6TVgYLDp1iOx0+yFliIWxvEPe2LzT5OC6lDLkTkXBzjLytwYtvBdZTWxaGVetXra+7Z6mHB6VGd
	KtmvJCUyV75txJd80yn02E017ZqTJMjnuJ4v17WeTRJjhyKPud+8Bo8fYidlMIMN2vNQ5nXsWSs
	i/L9JvIHSCRyZ6lyPj6U+APm6+zFi5JEnKTg7yQsv1A8BOkax9/68B+Ll1wkQ59kK6LaLfq+rw0
	XNt9psxf3AqIbYiDMhaedOuyRWYrhdUvJOzk/mcAvejvPfiWnZnuYReADUz+DE6gAff/FPr/vYU
	xmE72u6w==
X-Google-Smtp-Source: AGHT+IGt5FtRUkeNaYf2QqcOOYK1voNcUZefaLnp0B87objwjhy4KKvTzMxzHCr1EhOf/GN0KqwnNQ==
X-Received: by 2002:ac8:5dd1:0:b0:4b1:103b:bb6f with SMTP id d75a77b69052e-4b2aab276d4mr43535751cf.61.1755884845347;
        Fri, 22 Aug 2025 10:47:25 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e6023asm3121361cf.53.2025.08.22.10.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:47:25 -0700 (PDT)
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
Subject: [PATCH 3/8] riscv: insn: Add get_insn_nofault
Date: Fri, 22 Aug 2025 10:47:10 -0700
Message-ID: <20250822174715.1269138-4-jesse@rivosinc.com>
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

get_insn_nofault uses get_insn with pagefaults dissabled, allowing it to
be called in an atomic context.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
Unsure if copy_from_kernel_nofault is an acceptable replacement for
direct dereference in __read_insn.

RFC -> V1:
 - Add new function instead of using copy_from_user_nofault
V1 -> V2:
 - No change
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


