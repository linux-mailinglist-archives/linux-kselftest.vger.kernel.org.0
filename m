Return-Path: <linux-kselftest+bounces-25770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA7A28137
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 02:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5342818806AC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 01:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA6A230981;
	Wed,  5 Feb 2025 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YL7anOYn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4EF22FE18
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Feb 2025 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718562; cv=none; b=UXxSur/SmPtHZxi/MQEzzdM7hDBm2C550t2mOuXobvOV4MNW9Vkl/SSyDjnKWUZ6NfxCsInQTXbcbtB8ZcHjRh6k5Ldgd0BXnbgWgWqVcjK0ig9NOIQZ/G3rDVooH7BjbAqx/e/+P9Tj76Lem9xYzSyTu8RK3gOEQM3TOV/f4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718562; c=relaxed/simple;
	bh=1sSn7aDfUjcOB92/7A7Venz1EjXj471Fv9kmdXzLrbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmMH1eTR7Gs0KQX44DE5fU/GJsMVIh0kEa7WMRHWnLDO+jFnwdVZSN7FyuAjr0OK09SzaIJO3+LYOdNJr5IDEoMVycy85JLVuWMRwNYkkD17GGL7P9ODuwV4HDVa+Pe7MCpIjczo0TAD7YQUIbaslgrrapYyIg3x3Z7qZIv10RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YL7anOYn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f1b2480a2so397495ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 17:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718560; x=1739323360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vh4CUvpz/fzJO7m3g4Lrx30VWLQNLgBESiJnDVTGIvg=;
        b=YL7anOYngEF4vS4YiMrXoN5j+eKti9Q2VGYxrpklLb9ugveX06CyHu6L19JRM3fafu
         mHMPTe8tPib9KYcMiH5hOMcqH9OgyXglK8sAWRyovjjfwuPyMl1ZMX50CuMl8LtD+qc7
         5BT+iKlNLzObYoLsGgbA0Fy0jHx4P5YSbe0kzSWItIGA0RRPiNgZ+qOEm4PAJZFw0qeG
         usN8ZhE1372RwdLv+8tQqbqJiNaANb1AbkPMRxO5O25XVKqieiDniAbmXWZ3lECAMgTe
         SeBw6pR66M0cv4Jh0pjzGPeMtxBatXlboiX1UCulTLdGuDlRRiJ3EL7mbg16iQsFJftt
         ttsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718560; x=1739323360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vh4CUvpz/fzJO7m3g4Lrx30VWLQNLgBESiJnDVTGIvg=;
        b=QEhx8ZcXzax3EwACNREGeTN8g1y/9lPB1vJQWCCpsdD2AcAjmq6bQDI480O4B0GedT
         WDk/AmZqgiL7YBXABw2//qmnQuGN1gv3JO8ADMKr0oYkGKmgIOTYlJCraS98SZX73owX
         20IKZNo/ao2LZjl1UAVzh6BdH2hmnD4C5y+kp61spcUTepCFrch4zGQUROtA0Ug0DEBI
         2xX3/QgNaS3gIk/evhtLxBlktRKo8SsLKXvGJYUFHO5Fto5oC0ZWC7sMCTjrck3r7/P6
         6kDIqRsE7TLD3VzeE5tav7K65+O/WA9lHkQAVjyyjl9bWBJPATooUMZOPhwboAwYkG9R
         kuBA==
X-Forwarded-Encrypted: i=1; AJvYcCVzIXrv3GTeFRlUESkUQT3s95vtpjdFBjqR6tTLMgFSL5eExmiZfi0c3P2+qP5lu5/e3sP2qPJvaRRU05JPujA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0NS5jU4vh57exJ4yzh4rpjp4A/Urif8C0KZaUp5zse1o8BDW
	xHdMcDBntTXcMUOa+mB/kIWXvsHSrcIKMmBTQqkKH08GqW04bhP0N8NmUTLdjVo=
X-Gm-Gg: ASbGncs+SOWD7Mh84RbzUR7rLSGBag+CQa3cL9NeNlu+XNvRTt9f8xVYx1Js+o3B4Xa
	deq4vthLIgmIDeAl96IAA46AJxAIdWfcEqvSsRkuq+rMJzel0O42tDAjdSDO3asDkpaQeYmihIY
	M1y/N2sQvfRDWWUX6F6wVxhEBaJz7msNZKJwqnF9Gsz0T8OFaDyfQy/WLo7D//RtPKM7dqRx0DN
	pohdU5QLNrB9aCCdt19C5grAChWqOnyQbCGOb9NYYcSWrRhi2HR3iQMdee8F0Dxj6pUXr1dnM6M
	iNzFRb5K3r5YtavWAEDNNwribw==
X-Google-Smtp-Source: AGHT+IGeoQKYcs4hg862DdjQrrtWBKGNz8eQ6PlumY8b2Mk053BpOYNGRkKeyLaC94q3jdNjysT+gg==
X-Received: by 2002:a05:6a20:2d0b:b0:1e1:9f77:da92 with SMTP id adf61e73a8af0-1ede88ab501mr1525342637.33.1738718559719;
        Tue, 04 Feb 2025 17:22:39 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:39 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:22:11 -0800
Subject: [PATCH v9 24/26] riscv: Documentation for landing pad / indirect
 branch tracking
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-24-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Adding documentation on landing pad aka indirect branch tracking on riscv
and kernel interfaces exposed so that user tasks can enable it.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/arch/riscv/index.rst   |   1 +
 Documentation/arch/riscv/zicfilp.rst | 115 +++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
index eecf347ce849..be7237b69682 100644
--- a/Documentation/arch/riscv/index.rst
+++ b/Documentation/arch/riscv/index.rst
@@ -14,6 +14,7 @@ RISC-V architecture
     uabi
     vector
     cmodx
+    zicfilp
 
     features
 
diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/riscv/zicfilp.rst
new file mode 100644
index 000000000000..a188d78fcde6
--- /dev/null
+++ b/Documentation/arch/riscv/zicfilp.rst
@@ -0,0 +1,115 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Deepak Gupta <debug@rivosinc.com>
+:Date:   12 January 2024
+
+====================================================
+Tracking indirect control transfers on RISC-V Linux
+====================================================
+
+This document briefly describes the interface provided to userspace by Linux
+to enable indirect branch tracking for user mode applications on RISV-V
+
+1. Feature Overview
+--------------------
+
+Memory corruption issues usually result in to crashes, however when in hands of
+an adversary and if used creatively can result into variety security issues.
+
+One of those security issues can be code re-use attacks on program where adversary
+can use corrupt function pointers and chain them together to perform jump oriented
+programming (JOP) or call oriented programming (COP) and thus compromising control
+flow integrity (CFI) of the program.
+
+Function pointers live in read-write memory and thus are susceptible to corruption
+and allows an adversary to reach any program counter (PC) in address space. On
+RISC-V zicfilp extension enforces a restriction on such indirect control
+transfers:
+
+- indirect control transfers must land on a landing pad instruction ``lpad``.
+  There are two exception to this rule:
+
+  - rs1 = x1 or rs1 = x5, i.e. a return from a function and returns are
+    protected using shadow stack (see zicfiss.rst)
+
+  - rs1 = x7. On RISC-V compiler usually does below to reach function
+    which is beyond the offset possible J-type instruction::
+
+      auipc x7, <imm>
+      jalr (x7)
+
+	Such form of indirect control transfer are still immutable and don't rely
+    on memory and thus rs1=x7 is exempted from tracking and considered software
+    guarded jumps.
+
+``lpad`` instruction is pseudo of ``auipc rd, <imm_20bit>`` with ``rd=x0`` and
+is a HINT nop. ``lpad`` instruction must be aligned on 4 byte boundary and
+compares 20 bit immediate withx7. If ``imm_20bit`` == 0, CPU don't perform any
+comparision with ``x7``. If ``imm_20bit`` != 0, then ``imm_20bit`` must match
+``x7`` else CPU will raise ``software check exception`` (``cause=18``) with
+``*tval = 2``.
+
+Compiler can generate a hash over function signatures and setup them (truncated
+to 20bit) in x7 at callsites and function prologues can have ``lpad`` with same
+function hash. This further reduces number of program counters a call site can
+reach.
+
+2. ELF and psABI
+-----------------
+
+Toolchain sets up :c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for property
+:c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
+
+3. Linux enabling
+------------------
+
+User space programs can have multiple shared objects loaded in its address space
+and it's a difficult task to make sure all the dependencies have been compiled
+with support of indirect branch. Thus it's left to dynamic loader to enable
+indirect branch tracking for the program.
+
+4. prctl() enabling
+--------------------
+
+:c:macro:`PR_SET_INDIR_BR_LP_STATUS` / :c:macro:`PR_GET_INDIR_BR_LP_STATUS` /
+:c:macro:`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage indirect
+branch tracking. prctls are arch agnostic and returns -EINVAL on other arches.
+
+* prctl(PR_SET_INDIR_BR_LP_STATUS, unsigned long arg)
+
+If arg1 is :c:macro:`PR_INDIR_BR_LP_ENABLE` and if CPU supports ``zicfilp``
+then kernel will enabled indirect branch tracking for the task. Dynamic loader
+can issue this :c:macro:`prctl` once it has determined that all the objects
+loaded in address space support indirect branch tracking. Additionally if there
+is a `dlopen` to an object which wasn't compiled with ``zicfilp``, dynamic
+loader can issue this prctl with arg1 set to 0 (i.e.
+:c:macro:`PR_INDIR_BR_LP_ENABLE` being clear)
+
+* prctl(PR_GET_INDIR_BR_LP_STATUS, unsigned long arg)
+
+Returns current status of indirect branch tracking. If enabled it'll return
+:c:macro:`PR_INDIR_BR_LP_ENABLE`
+
+* prctl(PR_LOCK_INDIR_BR_LP_STATUS, unsigned long arg)
+
+Locks current status of indirect branch tracking on the task. User space may
+want to run with strict security posture and wouldn't want loading of objects
+without ``zicfilp`` support in it and thus would want to disallow disabling of
+indirect branch tracking. In that case user space can use this prctl to lock
+current settings.
+
+5. violations related to indirect branch tracking
+--------------------------------------------------
+
+Pertaining to indirect branch tracking, CPU raises software check exception in
+following conditions:
+
+- missing ``lpad`` after indirect call / jmp
+- ``lpad`` not on 4 byte boundary
+- ``imm_20bit`` embedded in ``lpad`` instruction doesn't match with ``x7``
+
+In all 3 cases, ``*tval = 2`` is captured and software check exception is
+raised (``cause=18``)
+
+Linux kernel will treat this as :c:macro:`SIGSEV`` with code =
+:c:macro:`SEGV_CPERR` and follow normal course of signal delivery.

-- 
2.34.1


